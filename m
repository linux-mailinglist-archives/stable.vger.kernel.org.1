Return-Path: <stable+bounces-134760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC89A94AA1
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 04:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E114316EF9A
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 02:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A72561A6;
	Mon, 21 Apr 2025 02:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZO3VmAq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2610A3E;
	Mon, 21 Apr 2025 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745201229; cv=none; b=oxh2G5+OOlzckSVE+Hhsb447CXLR4hq99H65tWAOvBoYUiXQNwEeW5p8hqGLH9nE2BpzjaGULczrjrVxH31MKusbw3h03njPNx1ua+dvYr+BpxSTcR1o1Jzy2sIwElk+btkTGzobuQpwW1DKcmhN7LGImfVaP/h1h2qMa75+UWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745201229; c=relaxed/simple;
	bh=rvDBpYvhrT2oxtdi2qm6xbxHsIoIYsSMX4uVIIxKWpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQCvyjpIGLfg8UJM0kezjSSLGHnPpSQGg8y1XhwueENigyxE5syb5tNsBW+y6+uUqvfvQ+DKtXQr1w+7EGGH+7hLVjuSNSG21sbIraoHavi9eB2eOgC9E05E9NZkJ9MuupEiqPvVXowxnGUrcSYCFGDUFxBrHZpgnUJJaa57g7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZO3VmAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACBEC4CEEA;
	Mon, 21 Apr 2025 02:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745201228;
	bh=rvDBpYvhrT2oxtdi2qm6xbxHsIoIYsSMX4uVIIxKWpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZO3VmAqsXxpz6XGWWv2vdc553ldGbGQBdcF0vW4cUNoXLBvZNROOPxUgzOyweKHN
	 /K6hGl8t4l2bUAa5TRl09Fkh6jG/8plEgSmmOmVuesTImLkLZhBdhN32VpZNFeJrrj
	 yVXGdLz5CZ8HoxPCQyZiMpAkVKeUW6mwdcmbabUG4ut5hx5+sFSVGq1zIkrTkkVk3q
	 2KD9cGm4AQjov9K9uZR6zKB6xhIhmRsq9BOTRY8kp4zlfhozTiRdAF2r+15xeKmo3O
	 8/6wbp1Ruqrr2WYZTAy5NJMgmZnuYquiLvqrgstNGjgxv54pFIZM6QKW4JKseDXxPL
	 qZ8R2J4u3VPwQ==
Date: Mon, 21 Apr 2025 10:07:01 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: cdnsp: Fix issue with resuming from L1
Message-ID: <20250421020701.GB3578913@nchen-desktop>
References: <20250418043628.1480437-1-pawell@cadence.com>
 <PH7PR07MB953846C57973E4DB134CAA71DDBF2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB953846C57973E4DB134CAA71DDBF2@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-04-18 04:55:16, Pawel Laszczak wrote:
> In very rare cases after resuming controller from L1 to L0 it reads
> registers before the clock UTMI have been enabled and as the result
> driver reads incorrect value.
> Most of registers are in APB domain clock but some of them (e.g. PORTSC)
> are in UTMI domain clock.
> After entering to L1 state the UTMI clock can be disabled.
> When controller transition from L1 to L0 the port status change event is
> reported and in interrupt runtime function driver reads PORTSC.
> During this read operation controller synchronize UTMI and APB domain
> but UTMI clock is still disabled and in result it reads 0xFFFFFFFF value.
> To fix this issue driver increases APB timeout value.
> 
> The issue is platform specific and if the default value of APB timeout
> is not sufficient then this time should be set Individually for each
> platform.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
> Changelog:
> v2:
> - changed patch description
> - made patch as platform specific
> 
>  drivers/usb/cdns3/cdnsp-gadget.c | 29 +++++++++++++++++++++++++++++
>  drivers/usb/cdns3/cdnsp-gadget.h |  3 +++
>  drivers/usb/cdns3/cdnsp-pci.c    | 12 ++++++++++--
>  drivers/usb/cdns3/core.h         |  3 +++
>  4 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 87f310841735..7f5534db2086 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -139,6 +139,26 @@ static void cdnsp_clear_port_change_bit(struct cdnsp_device *pdev,
>  	       (portsc & PORT_CHANGE_BITS), port_regs);
>  }
>  
> +static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev)
> +{
> +	struct cdns *cdns = dev_get_drvdata(pdev->dev);
> +	__le32 __iomem *reg;
> +	void __iomem *base;
> +	u32 offset = 0;
> +	u32 val;
> +
> +	if (!cdns->override_apb_timeout)
> +		return;
> +
> +	base = &pdev->cap_regs->hc_capbase;
> +	offset = cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
> +	reg = base + offset + REG_CHICKEN_BITS_3_OFFSET;
> +
> +	val  = le32_to_cpu(readl(reg));
> +	val = CHICKEN_APB_TIMEOUT_SET(val, cdns->override_apb_timeout);
> +	writel(cpu_to_le32(val), reg);
> +}
> +
>  static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)
>  {
>  	__le32 __iomem *reg;
> @@ -1798,6 +1818,15 @@ static int cdnsp_gen_setup(struct cdnsp_device *pdev)
>  	pdev->hci_version = HC_VERSION(pdev->hcc_params);
>  	pdev->hcc_params = readl(&pdev->cap_regs->hcc_params);
>  
> +	/*
> +	 * Override the APB timeout value to give the controller more time for
> +	 * enabling UTMI clock and synchronizing APB and UTMI clock domains.
> +	 * This fix is platform specific and is required to fixes issue with
> +	 * reading incorrect value from PORTSC register after resuming
> +	 * from L1 state.
> +	 */
> +	cdnsp_set_apb_timeout_value(pdev);
> +
>  	cdnsp_get_rev_cap(pdev);
>  
>  	/* Make sure the Device Controller is halted. */
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index 84887dfea763..87ac0cd113e7 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -520,6 +520,9 @@ struct cdnsp_rev_cap {
>  #define REG_CHICKEN_BITS_2_OFFSET	0x48
>  #define CHICKEN_XDMA_2_TP_CACHE_DIS	BIT(28)
>  
> +#define REG_CHICKEN_BITS_3_OFFSET       0x4C
> +#define CHICKEN_APB_TIMEOUT_SET(p, val) (((p) & ~GENMASK(21, 0)) | (val))
> +
>  /* XBUF Extended Capability ID. */
>  #define XBUF_CAP_ID			0xCB
>  #define XBUF_RX_TAG_MASK_0_OFFSET	0x1C
> diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
> index a51144504ff3..8c361b8394e9 100644
> --- a/drivers/usb/cdns3/cdnsp-pci.c
> +++ b/drivers/usb/cdns3/cdnsp-pci.c
> @@ -28,6 +28,8 @@
>  #define PCI_DRIVER_NAME		"cdns-pci-usbssp"
>  #define PLAT_DRIVER_NAME	"cdns-usbssp"
>  
> +#define CHICKEN_APB_TIMEOUT_VALUE       0x1C20
> +
>  static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
>  {
>  	/*
> @@ -139,6 +141,14 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
>  		cdnsp->otg_irq = pdev->irq;
>  	}
>  
> +	/*
> +	 * Cadence PCI based platform require some longer timeout for APB
> +	 * to fixes domain clock synchronization issue after resuming
> +	 * controller from L1 state.
> +	 */
> +	cdnsp->override_apb_timeout = CHICKEN_APB_TIMEOUT_VALUE;
> +	pci_set_drvdata(pdev, cdnsp);
> +
>  	if (pci_is_enabled(func)) {
>  		cdnsp->dev = dev;
>  		cdnsp->gadget_init = cdnsp_gadget_init;
> @@ -148,8 +158,6 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
>  			goto free_cdnsp;
>  	}
>  
> -	pci_set_drvdata(pdev, cdnsp);
> -
>  	device_wakeup_enable(&pdev->dev);
>  	if (pci_dev_run_wake(pdev))
>  		pm_runtime_put_noidle(&pdev->dev);
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 921cccf1ca9d..801be9e61340 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -79,6 +79,8 @@ struct cdns3_platform_data {
>   * @pdata: platform data from glue layer
>   * @lock: spinlock structure
>   * @xhci_plat_data: xhci private data structure pointer
> + * @override_apb_timeout: hold value of APB timeout. For value 0 the default
> + *                        value in CHICKEN_BITS_3 will be preserved.
>   * @gadget_init: pointer to gadget initialization function
>   */
>  struct cdns {
> @@ -117,6 +119,7 @@ struct cdns {
>  	struct cdns3_platform_data	*pdata;
>  	spinlock_t			lock;
>  	struct xhci_plat_priv		*xhci_plat_data;
> +	u32                             override_apb_timeout;
>  
>  	int (*gadget_init)(struct cdns *cdns);
>  };
> -- 
> 2.43.0
> 

-- 

Best regards,
Peter

