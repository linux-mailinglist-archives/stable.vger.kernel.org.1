Return-Path: <stable+bounces-77088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2E985480
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 09:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6605F286E8A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBF6157466;
	Wed, 25 Sep 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbJ7PpjM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87957154BF5;
	Wed, 25 Sep 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250610; cv=none; b=HMfxSl4/twSyPDJxjG2Vwsf1zGrG1W4uLKtB7m/lAbGMO6XjOb4EYOjSK4lhtZtrZ8ONwxOw4qfpgPhVx8dnOrSFxCv3YlF9OUSXJjUeinnokKY9Ff9gfd0Pdk5Iu50YzqvB5ODHuaB+vwbUxEpcBLgbnsdyrUqBrSiTZ9DiKPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250610; c=relaxed/simple;
	bh=RpG2dBj8JzsPbVubKdeAOPINRsigi7wT+7vUn6efoPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvmkjDs08XMUbgpX53RI5PrhA4OhwxFds2hPzJMQFbtV1xBQWBkkEelSUXie/fQvn7GzzkkHCeG40we4sn7WqmDkm9SpDiX9iGr7snQpH24YvtiThzfbWdplp3HSloscYfLRCDsQ+gdignq/WYwEJhe+Hhaq4UD5rO/LPdD36mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbJ7PpjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC96DC4CEC3;
	Wed, 25 Sep 2024 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727250610;
	bh=RpG2dBj8JzsPbVubKdeAOPINRsigi7wT+7vUn6efoPc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EbJ7PpjMZU3x1C8IXfT7LnSzo23xBZ6mcXeuI86g7aJHUtGCEFghI4i+W9RF3nVRU
	 VdNlqS1FDvb/J8P2PWklcpoK9b7CG2+Zxov+Wo/ItG8wI4k9YFXh0CkDFRvD46wVXK
	 gctWIf2+e0/mw0z72mcWyGsEx81AQW8y3H/qqJYaGVHqYZm6bk9T7mPK+eCcpqQ/ms
	 zo4YoBu0cV6jYzjYB5yQSlW6LsPBBaaGt5EMKoCuL+gntGYtyoH727ntJsVCZiVT8N
	 5DkUmHNLTrsQhgYoz77ztNB1mM7As9eMMSeLRWKOT7F9Yi9w45MQdd2u1P+sEES38E
	 YckBdViuXSyBg==
Message-ID: <1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org>
Date: Wed, 25 Sep 2024 10:50:05 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: dwc3: core: Prevent phy suspend during init
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Youn <John.Youn@synopsys.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, msp@baylibre.com,
 "Vardhan, Vibhore" <vibhore@ti.com>,
 "Govindarajan, Sriramakrishnan" <srk@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Vishal Mahaveer <vishalm@ti.com>
References: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
 <e8f04e642889b4c865aaf06762cde9386e0ff830.1713310411.git.Thinh.Nguyen@synopsys.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <e8f04e642889b4c865aaf06762cde9386e0ff830.1713310411.git.Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Thinh,

On 17/04/2024 02:41, Thinh Nguyen wrote:
> GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY should be cleared
> during initialization. Suspend during initialization can result in
> undefined behavior due to clock synchronization failure, which often
> seen as core soft reset timeout.
> 
> The programming guide recommended these bits to be cleared during
> initialization for DWC_usb3.0 version 1.94 and above (along with
> DWC_usb31 and DWC_usb32). The current check in the driver does not
> account if it's set by default setting from coreConsultant.
> 
> This is especially the case for DRD when switching mode to ensure the
> phy clocks are available to change mode. Depending on the
> platforms/design, some may be affected more than others. This is noted
> in the DWC_usb3x programming guide under the above registers.
> 
> Let's just disable them during driver load and mode switching. Restore
> them when the controller initialization completes.
> 
> Note that some platforms workaround this issue by disabling phy suspend
> through "snps,dis_u3_susphy_quirk" and "snps,dis_u2_susphy_quirk" when
> they should not need to.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9ba3aca8fe82 ("usb: dwc3: Disable phy suspend after power-on reset")
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

This patch is causing system suspend failures on TI AM62 platforms [1]

I will try to explain why.
Before this patch, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY
bits (hence forth called 2 SUSPHY bits) were being set during initialization
and even during re-initialization after a system suspend/resume.

These bits are required to be set for system suspend/resume to work correctly
on AM62 platforms.

After this patch, the bits are only set when Host controller starts or
when Gadget driver starts.

On AM62 platform we have 2 USB controllers, one in Host and one in Dual role.
Just after boot, for the Host controller we have the 2 SUSPHY bits set but
for the Dual-Role controller, as no role has started the 2 SUSPHY bits are
not set. Thus system suspend resume will fail.

On the other hand, if we load a gadget driver just after boot then both
controllers have the 2 SUSPHY bits set and system suspend resume works for
the first time.
However, after system resume, the core is re-initialized so the 2 SUSPHY bits
are cleared for both controllers. For host controller it is never set again.
For gadget controller as gadget start is called, the 2 SUSPHY bits are set
again. The second system suspend resume will still fail as one controller
(Host) doesn't have the 2 SUSPHY bits set.

To summarize, the existing solution is not sufficient for us to have a
reliable behavior. We need the 2 SUSPHY bits to be set regardless of what
role we are in or whether the role has started or not.

My suggestion is to move back the SUSPHY enable to end of dwc3_core_init().
Then if SUSPHY needs to be disabled for DRD role switching, it should be
disabled and enabled exactly there.

What do you suggest?

[1] - https://lore.kernel.org/linux-arm-kernel/20240904194229.109886-1-msp@baylibre.com/

-- 
cheers,
-roger

> ---
>  drivers/usb/dwc3/core.c   | 90 +++++++++++++++++----------------------
>  drivers/usb/dwc3/core.h   |  1 +
>  drivers/usb/dwc3/gadget.c |  2 +
>  drivers/usb/dwc3/host.c   | 27 ++++++++++++
>  4 files changed, 68 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 31684cdaaae3..100041320e8d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -104,6 +104,27 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>  	return 0;
>  }
>  
> +void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
> +{
> +	u32 reg;
> +
> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> +	if (enable && !dwc->dis_u3_susphy_quirk)
> +		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
> +	else
> +		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
> +
> +	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> +
> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +	if (enable && !dwc->dis_u2_susphy_quirk)
> +		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
> +	else
> +		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
> +
> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +}
> +
>  void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>  {
>  	u32 reg;
> @@ -585,11 +606,8 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
>   */
>  static int dwc3_phy_setup(struct dwc3 *dwc)
>  {
> -	unsigned int hw_mode;
>  	u32 reg;
>  
> -	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> -
>  	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
>  
>  	/*
> @@ -599,21 +617,16 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>  	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
>  
>  	/*
> -	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
> -	 * to '0' during coreConsultant configuration. So default value
> -	 * will be '0' when the core is reset. Application needs to set it
> -	 * to '1' after the core initialization is completed.
> -	 */
> -	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
> -		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
> -
> -	/*
> -	 * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be cleared after
> -	 * power-on reset, and it can be set after core initialization, which is
> -	 * after device soft-reset during initialization.
> +	 * Above DWC_usb3.0 1.94a, it is recommended to set
> +	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
> +	 * So default value will be '0' when the core is reset. Application
> +	 * needs to set it to '1' after the core initialization is completed.
> +	 *
> +	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
> +	 * cleared after power-on reset, and it can be set after core
> +	 * initialization.
>  	 */
> -	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
> -		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
> +	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
>  
>  	if (dwc->u2ss_inp3_quirk)
>  		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
> @@ -639,9 +652,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>  	if (dwc->tx_de_emphasis_quirk)
>  		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_de_emphasis);
>  
> -	if (dwc->dis_u3_susphy_quirk)
> -		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
> -
>  	if (dwc->dis_del_phy_power_chg_quirk)
>  		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
>  
> @@ -689,24 +699,15 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>  	}
>  
>  	/*
> -	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
> -	 * '0' during coreConsultant configuration. So default value will
> -	 * be '0' when the core is reset. Application needs to set it to
> -	 * '1' after the core initialization is completed.
> -	 */
> -	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
> -		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
> -
> -	/*
> -	 * For DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared after
> -	 * power-on reset, and it can be set after core initialization, which is
> -	 * after device soft-reset during initialization.
> +	 * Above DWC_usb3.0 1.94a, it is recommended to set
> +	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
> +	 * So default value will be '0' when the core is reset. Application
> +	 * needs to set it to '1' after the core initialization is completed.
> +	 *
> +	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
> +	 * after power-on reset, and it can be set after core initialization.
>  	 */
> -	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
> -		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
> -
> -	if (dwc->dis_u2_susphy_quirk)
> -		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
> +	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
>  
>  	if (dwc->dis_enblslpm_quirk)
>  		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
> @@ -1227,21 +1228,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	if (ret)
>  		goto err_exit_phy;
>  
> -	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
> -	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
> -		if (!dwc->dis_u3_susphy_quirk) {
> -			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> -			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
> -			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> -		}
> -
> -		if (!dwc->dis_u2_susphy_quirk) {
> -			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> -			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
> -			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> -		}
> -	}
> -
>  	dwc3_core_setup_global_control(dwc);
>  	dwc3_core_num_eps(dwc);
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 7e80dd3d466b..180dd8d29287 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1580,6 +1580,7 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc);
>  void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
>  
>  int dwc3_core_soft_reset(struct dwc3 *dwc);
> +void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
>  
>  #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>  int dwc3_host_init(struct dwc3 *dwc);
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 4df2661f6675..f94f68f1e7d2 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2924,6 +2924,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
>  	dwc3_ep0_out_start(dwc);
>  
>  	dwc3_gadget_enable_irq(dwc);
> +	dwc3_enable_susphy(dwc, true);
>  
>  	return 0;
>  
> @@ -4690,6 +4691,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
>  	if (!dwc->gadget)
>  		return;
>  
> +	dwc3_enable_susphy(dwc, false);
>  	usb_del_gadget(dwc->gadget);
>  	dwc3_gadget_free_endpoints(dwc);
>  	usb_put_gadget(dwc->gadget);
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 0204787df81d..a171b27a7845 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -10,10 +10,13 @@
>  #include <linux/irq.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
>  
>  #include "../host/xhci-port.h"
>  #include "../host/xhci-ext-caps.h"
>  #include "../host/xhci-caps.h"
> +#include "../host/xhci-plat.h"
>  #include "core.h"
>  
>  #define XHCI_HCSPARAMS1		0x4
> @@ -57,6 +60,24 @@ static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
>  	}
>  }
>  
> +static void dwc3_xhci_plat_start(struct usb_hcd *hcd)
> +{
> +	struct platform_device *pdev;
> +	struct dwc3 *dwc;
> +
> +	if (!usb_hcd_is_primary_hcd(hcd))
> +		return;
> +
> +	pdev = to_platform_device(hcd->self.controller);
> +	dwc = dev_get_drvdata(pdev->dev.parent);
> +
> +	dwc3_enable_susphy(dwc, true);
> +}
> +
> +static const struct xhci_plat_priv dwc3_xhci_plat_quirk = {
> +	.plat_start = dwc3_xhci_plat_start,
> +};
> +
>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>  					int irq, char *name)
>  {
> @@ -167,6 +188,11 @@ int dwc3_host_init(struct dwc3 *dwc)
>  		}
>  	}
>  
> +	ret = platform_device_add_data(xhci, &dwc3_xhci_plat_quirk,
> +				       sizeof(struct xhci_plat_priv));
> +	if (ret)
> +		goto err;
> +
>  	ret = platform_device_add(xhci);
>  	if (ret) {
>  		dev_err(dwc->dev, "failed to register xHCI device\n");
> @@ -192,6 +218,7 @@ void dwc3_host_exit(struct dwc3 *dwc)
>  	if (dwc->sys_wakeup)
>  		device_init_wakeup(&dwc->xhci->dev, false);
>  
> +	dwc3_enable_susphy(dwc, false);
>  	platform_device_unregister(dwc->xhci);
>  	dwc->xhci = NULL;
>  }


