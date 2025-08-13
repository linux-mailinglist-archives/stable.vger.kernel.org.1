Return-Path: <stable+bounces-169405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C5FB24C16
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B99B164BDE
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FAC2ED172;
	Wed, 13 Aug 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s0uTM55A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66952BA42;
	Wed, 13 Aug 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095622; cv=none; b=MJVRWFq3KbQzrnMknNU9xD/tcW9RtRBFi+VeljWjDcqzcFtD63E7/Jd875QcjxYFudqbQyDSlV+t+8TcfaYO98q96plsWmdfcWEBp+ISd0BMir/jEqq0s3yOuj5OrL8SxjZMtk/WGCdeuyAxW/YOPw1boYXsJ1xN/O90J7WtQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095622; c=relaxed/simple;
	bh=VrrpYNgF5SMfZgAQUd48nLdHWmF6ukwzVVXH5H0Hhd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNthxeWAgHyOGATawpt1TSVwEHkhnyQTN/eNDnYY9qQ+VOrIR7Dt/8u6Wwnbi8Aij81IJoCnskok2z/dMuMtzVjWOX2P7VACgvvKTLinmLXshgFumnFm8J/ACZjFAdTHvg0i0dB+tsZqh/Ucg2qTJ7aN47/sXz+QxX9Aetm+L84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s0uTM55A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B34C4CEEB;
	Wed, 13 Aug 2025 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755095622;
	bh=VrrpYNgF5SMfZgAQUd48nLdHWmF6ukwzVVXH5H0Hhd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0uTM55AgaoZpWZh96pqh3V7phwxJ8symvJE35flBE6hCm8y/sY0goPQjRCkaaElT
	 mkqm4K/N8tk5EGHG84RoruKAVvc7JSrMskmixa8c2f9blW+cldoD59nWPUg7O/bfCh
	 VU/8ryFGgzWiYBm1ofPjl9BxX3Tzom1KA01Lv9I0=
Date: Wed, 13 Aug 2025 16:33:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: Thinh.Nguyen@synopsys.com, m.grzeschik@pengutronix.de, balbi@ti.com,
	bigeasy@linutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, akash.m5@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	muhammed.ali@samsung.com, thiagu.r@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Message-ID: <2025081348-depict-lapel-2e9e@gregkh>
References: <CGME20250808125457epcas5p111426353bf9a15dacfa217a9abff6374@epcas5p1.samsung.com>
 <20250808125315.1607-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808125315.1607-1-selvarasu.g@samsung.com>

On Fri, Aug 08, 2025 at 06:23:05PM +0530, Selvarasu Ganesan wrote:
> This commit addresses a rarely observed endpoint command timeout
> which causes kernel panic due to warn when 'panic_on_warn' is enabled
> and unnecessary call trace prints when 'panic_on_warn' is disabled.
> It is seen during fast software-controlled connect/disconnect testcases.
> The following is one such endpoint command timeout that we observed:
> 
> 1. Connect
>    =======
> ->dwc3_thread_interrupt
>  ->dwc3_ep0_interrupt
>   ->configfs_composite_setup
>    ->composite_setup
>     ->usb_ep_queue
>      ->dwc3_gadget_ep0_queue
>       ->__dwc3_gadget_ep0_queue
>        ->__dwc3_ep0_do_control_data
>         ->dwc3_send_gadget_ep_cmd
> 
> 2. Disconnect
>    ==========
> ->dwc3_thread_interrupt
>  ->dwc3_gadget_disconnect_interrupt
>   ->dwc3_ep0_reset_state
>    ->dwc3_ep0_end_control_data
>     ->dwc3_send_gadget_ep_cmd
> 
> In the issue scenario, in Exynos platforms, we observed that control
> transfers for the previous connect have not yet been completed and end
> transfer command sent as a part of the disconnect sequence and
> processing of USB_ENDPOINT_HALT feature request from the host timeout.
> This maybe an expected scenario since the controller is processing EP
> commands sent as a part of the previous connect. It maybe better to
> remove WARN_ON in all places where device endpoint commands are sent to
> avoid unnecessary kernel panic due to warn.
> 
> Cc: stable@vger.kernel.org
> Co-developed-by: Akash M <akash.m5@samsung.com>
> Signed-off-by: Akash M <akash.m5@samsung.com>
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
> 
> Changes in v3:
> - Added Co-developed-by tags to reflect the correct authorship.
> - And Added Acked-by tag as well.
> Link to v2: https://lore.kernel.org/all/20250807014639.1596-1-selvarasu.g@samsung.com/
> 
> Changes in v2:
> - Removed the 'Fixes' tag from the commit message, as this patch does
>   not contain a fix.
> - And Retained the 'stable' tag, as these changes are intended to be
>   applied across all stable kernels.
> - Additionally, replaced 'dev_warn*' with 'dev_err*'."
> Link to v1: https://lore.kernel.org/all/20250807005638.thhsgjn73aaov2af@synopsys.com/
> ---
>  drivers/usb/dwc3/ep0.c    | 20 ++++++++++++++++----
>  drivers/usb/dwc3/gadget.c | 10 ++++++++--
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 666ac432f52d..b4229aa13f37 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -288,7 +288,9 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>  	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
>  			DWC3_TRBCTL_CONTROL_SETUP, false);
>  	ret = dwc3_ep0_start_trans(dep);
> -	WARN_ON(ret < 0);
> +	if (ret < 0)
> +		dev_err(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
> +

If this fails, why aren't you returning the error and handling it
properly?  Just throwing an error message feels like it's not going to
do much overall.

>  	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
>  		struct dwc3_ep *dwc3_ep;
>  
> @@ -1061,7 +1063,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>  		ret = dwc3_ep0_start_trans(dep);
>  	}
>  
> -	WARN_ON(ret < 0);
> +	if (ret < 0)
> +		dev_err(dwc->dev,
> +			"ep0 data phase start transfer failed: %d\n", ret);

Same here, why not return the error and propagate it up the call stack?

>  }
>  
>  static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
> @@ -1078,7 +1082,12 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
>  
>  static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
>  {
> -	WARN_ON(dwc3_ep0_start_control_status(dep));
> +	int	ret;
> +
> +	ret = dwc3_ep0_start_control_status(dep);
> +	if (ret)
> +		dev_err(dwc->dev,
> +			"ep0 status phase start transfer failed: %d\n", ret);

Same here.  Don't "swallow" errors that you find, that's a sure way to
paper over real problems.

Same for all other changes here.

thanks,

greg k-h

