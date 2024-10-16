
import ReactDOM  from 'react-dom/client'
import App from './app/layout/App'
import 'semantic-ui-css/semantic.min.css'
import './app/layout/styles.css'
import { StoreContext ,store} from './app/stores/store'

ReactDOM.createRoot(document.getElementById('root')!).render(
//<React.StrictMode>

<StoreContext.Provider value={store}>

<App/>
</StoreContext.Provider>

//</React.StrictMode>

)