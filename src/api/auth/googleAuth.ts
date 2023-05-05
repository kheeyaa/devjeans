import {initUser} from 'src/lib/initUser'
import {login} from '../service/auth'

type InitAuthProps = {
  ref: HTMLElement
  text?: google.accounts.id.GsiButtonConfiguration['text']
}

export const initAuth2 = ({ref, text = 'signin_with'}: InitAuthProps) => {
  google.accounts.id.initialize({
    client_id: import.meta.env.VITE_APP_GOOGLE_CLIENT_ID,
    callback: async (res) => {
      await login({idToken: res.credential})
      await initUser()
    },
  })

  google.accounts.id.renderButton(
    ref,
    {theme: 'outline', size: 'large', text, width: '200', type: 'standard'}, // customization attributes
  )
}
