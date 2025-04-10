Return-Path: <stable+bounces-132077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6679A83EE0
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DF79E0C58
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442D256C90;
	Thu, 10 Apr 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zMFLvh3p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267D204F65;
	Thu, 10 Apr 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744277293; cv=none; b=IoLVRk9odHtxV+j0xR58je1Er57/ei+I4aNfHge7EVqoyPu0IIoHAId+ToJrZr0pjPdFIuUOS654wVjssoiadCd/A053gwGISEKW7tCX1+phA5s/dxDxxAg+8A6Qs87qj3nwz+Hq3NnpO81shqJBY3AhC8XOb8I5in3EkikxMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744277293; c=relaxed/simple;
	bh=xE5QEOZfQokzP2MJO9ilKe4LwdE4G+yOiOX5zwVH6ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjhC7d6VkZ7/ObrxMe0YyXkNh/EvgVI+zQJoXlBi1xDxTpdcjP67BLFFxdHJKKrY2NDWPtGtiDBeYt0T6LR+FbqWtkk2nfIAUdhVNHW5Rppbbq6aNle0eV2G5tfFdDu142IJeDwlZE34Z7OJdaW/wmJIKPF6rmI4KTgLKYQNjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zMFLvh3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36E2C4CEDD;
	Thu, 10 Apr 2025 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744277293;
	bh=xE5QEOZfQokzP2MJO9ilKe4LwdE4G+yOiOX5zwVH6ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zMFLvh3pE8OwQ+F0RkFA6Np9d1guQML54ioB3Q+ClmcCD4Z9WGcff0WDR/bokxfsV
	 vqaJ5kId6axn9AJ82kvl23Wyo/BpYyrt189+Tm1c217oBhwh4Cze9ZTosb89tCr+7g
	 hMYf7lgkzbos4JJu3pBiuKr/9aPaN/xn0VtKsvWo=
Date: Thu, 10 Apr 2025 11:26:38 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "peter.chen@kernel.org" <peter.chen@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Message-ID: <2025041050-condition-stout-8168@gregkh>
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

On Thu, Apr 10, 2025 at 07:34:16AM +0000, Pawel Laszczak wrote:
> Subject: [PATCH] usb: cdnsp: Fix issue with resuming from L1

Why is the subject line duplicated here?  Can you fix up your git
send-email process to not do that?

> In very rare cases after resuming controller from L1 to L0 it reads
> registers before the clock has been enabled and as the result driver
> reads incorrect value.
> To fix this issue driver increases APB timeout value.
> 
> Probably this issue occurs only on Cadence platform but fix
> should have no impact for other existing platforms.

If this is the case, shouldn't you just handle this for Cadence-specific
hardware and add the check for that to this change?

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

Do you need to do a read to ensure that the write is flushed to the
device before continuing?

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

Nit, please use the "normal" kernel comment style.

thanks,

greg k-h

