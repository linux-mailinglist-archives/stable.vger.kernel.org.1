Return-Path: <stable+bounces-132195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92007A8514F
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 03:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B371B629FC
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 01:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7021279335;
	Fri, 11 Apr 2025 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnLjFMXz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9B2572;
	Fri, 11 Apr 2025 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744335708; cv=none; b=jTdb6JzFVP/CufQZ4UAFKjCWDGYdpvGnpq4xT2hn5ExSNUgwZAVIBCb/yNjjQYZoRLYz6xdWs2xaearNr2RHHu+hm3Txy2QdCmDHe9MlTHVY0k1X9rLeByQxpQPRiFSoWTtPXNh5eokt6kssf1WyaB422QfZTiRKTeVvFcRKqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744335708; c=relaxed/simple;
	bh=Rx07dYtKJcqHHucr8sVVvpyEeymU1OxvXC5C3eiT18k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpEvXaQqCacCYKOFf3koR4kiAwKBhTDCf7zsZ/p08Jc+HcN00ySRP4RuW1bve4NytRGOAccN6cZk66vbfo3Tz7oPHdAOej9GyG3gXlBio8Nwvvk0F92DGEYwj1/9tz6MpLLIEZt1bkO/Pd6ashFnEP3Zfxdv8VRn+jC62btLFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnLjFMXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0A1C4CEDD;
	Fri, 11 Apr 2025 01:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744335708;
	bh=Rx07dYtKJcqHHucr8sVVvpyEeymU1OxvXC5C3eiT18k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnLjFMXz/IGTo3jWf2ncww1aKm/vOa2bPpO3LlPWz41mBqPL75KMrJs61oG3HYUsF
	 76uPBNdaMdgAMbMIdktXvYcI4aCh+zpNJ9JPkEn7hlvDKW2pgVZJB8tgg8wmPqwO9L
	 Segkpq4bdgelNMjWVBNPPiXFegFV76pdnCM4Bap7c+R3vIi7MOKipN+4gh4OsRM6VR
	 v2MbXUvQZNzX0WYVHSDIybC4rvjVyaJVTMlrraqB8evK6GY19witn4tLBjhW+/em/Y
	 6bRs8vjjIeI28vYx59palq2un8Z6MhpG6bzWBarpPpE7aCI37uiOMSlzV8UUmTauYB
	 wQW/7ZFq3dg0A==
Date: Fri, 11 Apr 2025 09:41:41 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Message-ID: <20250411014141.GA2640668@nchen-desktop>
References: <20250410072333.2100511-1-pawell@cadence.com>
 <PH7PR07MB9538959C61B32EBCA33D1909DDB72@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538959C61B32EBCA33D1909DDB72@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-04-10 07:34:16, Pawel Laszczak wrote:
> Subject: [PATCH] usb: cdnsp: Fix issue with resuming from L1
> 
> In very rare cases after resuming controller from L1 to L0 it reads
> registers before the clock has been enabled and as the result driver
> reads incorrect value.
> To fix this issue driver increases APB timeout value.

L1 is the link state during the runtime, usually, we do not disable
APB clock at runtime since SW may access registers. Would you please
explain more about this scenario?

Besides, why only device mode needs it?

Peter
> 
> Probably this issue occurs only on Cadence platform but fix
> should have no impact for other existing platforms.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 22 ++++++++++++++++++++++
>  drivers/usb/cdns3/cdnsp-gadget.h |  4 ++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 87f310841735..b12581b94567 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -139,6 +139,21 @@ static void cdnsp_clear_port_change_bit(struct cdnsp_device *pdev,
>  	       (portsc & PORT_CHANGE_BITS), port_regs);
>  }
>  
> +static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev)
> +{
> +	__le32 __iomem *reg;
> +	void __iomem *base;
> +	u32 offset = 0;
> +	u32 val;
> +
> +	base = &pdev->cap_regs->hc_capbase;
> +	offset = cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
> +	reg = base + offset + REG_CHICKEN_BITS_3_OFFSET;
> +
> +	val  = le32_to_cpu(readl(reg));
> +	writel(cpu_to_le32(CHICKEN_APB_TIMEOUT_SET(val)), reg);
> +}
> +
>  static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)
>  {
>  	__le32 __iomem *reg;
> @@ -1798,6 +1813,13 @@ static int cdnsp_gen_setup(struct cdnsp_device *pdev)
>  	pdev->hci_version = HC_VERSION(pdev->hcc_params);
>  	pdev->hcc_params = readl(&pdev->cap_regs->hcc_params);
>  
> +	/* In very rare cases after resuming controller from L1 to L0 it reads
> +	 * registers before the clock has been enabled and as the result driver
> +	 * reads incorrect value.
> +	 * To fix this issue driver increases APB timeout value.
> +	 */
> +	cdnsp_set_apb_timeout_value(pdev);
> +
>  	cdnsp_get_rev_cap(pdev);
>  
>  	/* Make sure the Device Controller is halted. */
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index 84887dfea763..a4d678fba005 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -520,6 +520,10 @@ struct cdnsp_rev_cap {
>  #define REG_CHICKEN_BITS_2_OFFSET	0x48
>  #define CHICKEN_XDMA_2_TP_CACHE_DIS	BIT(28)
>  
> +#define REG_CHICKEN_BITS_3_OFFSET	0x4C
> +#define CHICKEN_APB_TIMEOUT_VALUE	0x1C20
> +#define CHICKEN_APB_TIMEOUT_SET(p) (((p) & ~GENMASK(21, 0)) | CHICKEN_APB_TIMEOUT_VALUE)
> +
>  /* XBUF Extended Capability ID. */
>  #define XBUF_CAP_ID			0xCB
>  #define XBUF_RX_TAG_MASK_0_OFFSET	0x1C
> -- 
> 2.43.0
> 

-- 

Best regards,
Peter

