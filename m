Return-Path: <stable+bounces-169506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CA0B25B67
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 07:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D101891B22
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 05:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF3230270;
	Thu, 14 Aug 2025 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Xngf2XY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ECC2264A1;
	Thu, 14 Aug 2025 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151082; cv=none; b=hcDarhnFeVgMceLjEow4hJmsYpEolnaFI6gqtPNXoDb7fKVC/QhqIcegzytI8uYSBSR4YEAxIKEJsMCeXR1kvlA+3gDFpFK9UT/T6TlWdEsOBqYMNGkXB00X5oPEKRMnNSahsu2MOb7/KA2nO2OeKhYOutfHjEMD8cPRJdraF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151082; c=relaxed/simple;
	bh=i+BULjIrt5Ty3hv65N41KIDjGgGgkaHyuvDeN1TuW7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB799ypg+SvwCNLLK194vETdugaQxlx8l5QGLBMeoLtoRvyzJSWz5kqB6ODCQWjx6W3PXXavEsZDd7v0A10BAxBWCn1VcmhexPwlKIG5iznTM4y+/Gb2tcEz4cp2mMr2tU6Ua1VCjiQ0+iAKLJWfq1PaBUXrLd9F/DFT7ZIWLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Xngf2XY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AFBC4CEEF;
	Thu, 14 Aug 2025 05:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755151082;
	bh=i+BULjIrt5Ty3hv65N41KIDjGgGgkaHyuvDeN1TuW7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Xngf2XYsaKJfjKq5a4SFvaG/HFhLb++ksZ0Xm9oIzgpfhgM/4M3Os4gAyr5ukE1Y
	 aWM8omb7C8TNSaLSy+po4tYydM7GoUYMXTPdck/uY5V9hcG9d421V0WC1FEmdJd3+A
	 lSCTj3C+aPuYKfV2AfC7FsGtInx5i07+jDZAlMJ4=
Date: Thu, 14 Aug 2025 07:57:58 +0200
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
Message-ID: <2025081442-monotype-pony-83ed@gregkh>
References: <CGME20250808125457epcas5p111426353bf9a15dacfa217a9abff6374@epcas5p1.samsung.com>
 <20250808125315.1607-1-selvarasu.g@samsung.com>
 <2025081348-depict-lapel-2e9e@gregkh>
 <f9120ba5-e22b-498f-88b3-817893af22be@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9120ba5-e22b-498f-88b3-817893af22be@samsung.com>

On Thu, Aug 14, 2025 at 10:23:38AM +0530, Selvarasu Ganesan wrote:
> 
> On 8/13/2025 8:03 PM, Greg KH wrote:
> > On Fri, Aug 08, 2025 at 06:23:05PM +0530, Selvarasu Ganesan wrote:
> >> This commit addresses a rarely observed endpoint command timeout
> >> which causes kernel panic due to warn when 'panic_on_warn' is enabled
> >> and unnecessary call trace prints when 'panic_on_warn' is disabled.
> >> It is seen during fast software-controlled connect/disconnect testcases.
> >> The following is one such endpoint command timeout that we observed:
> >>
> >> 1. Connect
> >>     =======
> >> ->dwc3_thread_interrupt
> >>   ->dwc3_ep0_interrupt
> >>    ->configfs_composite_setup
> >>     ->composite_setup
> >>      ->usb_ep_queue
> >>       ->dwc3_gadget_ep0_queue
> >>        ->__dwc3_gadget_ep0_queue
> >>         ->__dwc3_ep0_do_control_data
> >>          ->dwc3_send_gadget_ep_cmd
> >>
> >> 2. Disconnect
> >>     ==========
> >> ->dwc3_thread_interrupt
> >>   ->dwc3_gadget_disconnect_interrupt
> >>    ->dwc3_ep0_reset_state
> >>     ->dwc3_ep0_end_control_data
> >>      ->dwc3_send_gadget_ep_cmd
> >>
> >> In the issue scenario, in Exynos platforms, we observed that control
> >> transfers for the previous connect have not yet been completed and end
> >> transfer command sent as a part of the disconnect sequence and
> >> processing of USB_ENDPOINT_HALT feature request from the host timeout.
> >> This maybe an expected scenario since the controller is processing EP
> >> commands sent as a part of the previous connect. It maybe better to
> >> remove WARN_ON in all places where device endpoint commands are sent to
> >> avoid unnecessary kernel panic due to warn.
> >>
> >> Cc: stable@vger.kernel.org
> >> Co-developed-by: Akash M <akash.m5@samsung.com>
> >> Signed-off-by: Akash M <akash.m5@samsung.com>
> >> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> >> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> >> ---
> >>
> >> Changes in v3:
> >> - Added Co-developed-by tags to reflect the correct authorship.
> >> - And Added Acked-by tag as well.
> >> Link to v2: https://lore.kernel.org/all/20250807014639.1596-1-selvarasu.g@samsung.com/
> >>
> >> Changes in v2:
> >> - Removed the 'Fixes' tag from the commit message, as this patch does
> >>    not contain a fix.
> >> - And Retained the 'stable' tag, as these changes are intended to be
> >>    applied across all stable kernels.
> >> - Additionally, replaced 'dev_warn*' with 'dev_err*'."
> >> Link to v1: https://lore.kernel.org/all/20250807005638.thhsgjn73aaov2af@synopsys.com/
> >> ---
> >>   drivers/usb/dwc3/ep0.c    | 20 ++++++++++++++++----
> >>   drivers/usb/dwc3/gadget.c | 10 ++++++++--
> >>   2 files changed, 24 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> >> index 666ac432f52d..b4229aa13f37 100644
> >> --- a/drivers/usb/dwc3/ep0.c
> >> +++ b/drivers/usb/dwc3/ep0.c
> >> @@ -288,7 +288,9 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
> >>   	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
> >>   			DWC3_TRBCTL_CONTROL_SETUP, false);
> >>   	ret = dwc3_ep0_start_trans(dep);
> >> -	WARN_ON(ret < 0);
> >> +	if (ret < 0)
> >> +		dev_err(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
> >> +
> > If this fails, why aren't you returning the error and handling it
> > properly?  Just throwing an error message feels like it's not going to
> > do much overall.
> 
> Hi Greg,
> 
> Thanks for your review comments.
> 
> The trigger EP command is followed by an error message in case of 
> failure, but no corrective action is required from the driver's 
> perspective. In this context, returning an error code is not necessary, 
> as the driver's operation can continue uninterrupted.
> 
> This approach is consistent with how WARN_ON is handled, as it also does 
> not return a value. Furthermore, This approach aligns with how handled 
> similar situations elsewhere in the code, where added error messages 
> instead of using WARN_ON.

Ok, thanks for letting me know, but be prepared for someone in the
future to come along and attempt to actually add error handling return
logic as it does seem arbitrary to do this for these cases.

greg k-h

