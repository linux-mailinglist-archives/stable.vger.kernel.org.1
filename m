Return-Path: <stable+bounces-189956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED88BC0D356
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD473BDA1D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 11:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF1D2F99A6;
	Mon, 27 Oct 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBF+E92U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695111C861D
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565249; cv=none; b=jKkVAlBVitO5IM9SXhQU2XynYnk2PaZyrpmEx3MWNkQSD1sllWMQrwefL4O6ycjqGLWNfAsdr3RbuewXEWyrOoizairf33DXyd33BlZoNZa9CSsI/1aUJXZ5hrYm3yHRIWjbRFZlEglLRIKxCLWKyRhk3yRndLSB199onMof7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565249; c=relaxed/simple;
	bh=p199MZUK74DuV9R8BVwcbNSGCptTnBkNE16l/LPPMTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKAVhDpulJVm39j3KkWFpRiiN3S1cC4HqxEQC+NZb2J8hxhmKWG7JCpUP6XlMh1UmrZ/ZvW5Ks5W62cvUXfGY+kUfUeJejq+rGerN4EmZJD7YW9HRhD+k0oqhigLb5PSJGa5AmRMNiwNjsXEzJB9hpf5Cq6WiGOgeoRUZ+2uGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YBF+E92U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B1EC4CEF1;
	Mon, 27 Oct 2025 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761565249;
	bh=p199MZUK74DuV9R8BVwcbNSGCptTnBkNE16l/LPPMTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBF+E92UXpseYMXJWLVcssFOyRzYJqGEOUNFFDQTCj8+u+GQm3wO8HjYJqGz8xHuK
	 LkLHvdcTDUzrGYC7MIotnW8wg7EXYKMlw1nHLK14j/rwCWr28Ks7lrfauccWq9tCLb
	 z2Lax98t58Ea4M8/t/Bt4DdZYBusXTH4Rg/3x89o=
Date: Mon, 27 Oct 2025 12:40:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: stable@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.4.y] can: gs_usb: increase max interface to U8_MAX
Message-ID: <2025102739-gout-copilot-7469@gregkh>
References: <2025102041-mounting-pursuit-e9d3@gregkh>
 <20251020122237.1517578-2-uwu@coelacanthus.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020122237.1517578-2-uwu@coelacanthus.name>

On Mon, Oct 20, 2025 at 08:22:38PM +0800, Celeste Liu wrote:
> commit 2a27f6a8fb5722223d526843040f747e9b0e8060 upstream
> 
> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
> converter[1]. The original developers may have only 3 interfaces
> device to test so they write 3 here and wait for future change.
> 
> During the HSCanT development, we actually used 4 interfaces, so the
> limitation of 3 is not enough now. But just increase one is not
> future-proofed. Since the channel index type in gs_host_frame is u8,
> just make canch[] become a flexible array with a u8 index, so it
> naturally constraint by U8_MAX and avoid statically allocate 256
> pointer for every gs_usb device.
> 
> [1]: https://github.com/cherry-embedded/HSCanT-hardware
> 
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> Link: https://patch.msgid.link/20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/usb/gs_usb.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 1a24c1d9dd8f..509b0c83ebb8 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -156,10 +156,6 @@ struct gs_host_frame {
>  #define GS_MAX_TX_URBS 10
>  /* Only launch a max of GS_MAX_RX_URBS usb requests at a time. */
>  #define GS_MAX_RX_URBS 30
> -/* Maximum number of interfaces the driver supports per device.
> - * Current hardware only supports 2 interfaces. The future may vary.
> - */
> -#define GS_MAX_INTF 2
>  
>  struct gs_tx_context {
>  	struct gs_can *dev;
> @@ -190,10 +186,11 @@ struct gs_can {
>  
>  /* usb interface struct */
>  struct gs_usb {
> -	struct gs_can *canch[GS_MAX_INTF];
>  	struct usb_anchor rx_submitted;
>  	struct usb_device *udev;
>  	u8 active_channels;
> +	u8 channel_cnt;
> +	struct gs_can *canch[] __counted_by(channel_cnt);
>  };
>  
>  /* 'allocate' a tx context.
> @@ -321,7 +318,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	}
>  
>  	/* device reports out of range channel id */
> -	if (hf->channel >= GS_MAX_INTF)
> +	if (hf->channel >= usbcan->channel_cnt)
>  		goto device_detach;
>  
>  	dev = usbcan->canch[hf->channel];
> @@ -409,7 +406,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	/* USB failure take down all interfaces */
>  	if (rc == -ENODEV) {
>   device_detach:
> -		for (rc = 0; rc < GS_MAX_INTF; rc++) {
> +		for (rc = 0; rc < usbcan->channel_cnt; rc++) {
>  			if (usbcan->canch[rc])
>  				netif_device_detach(usbcan->canch[rc]->netdev);
>  		}
> @@ -991,20 +988,22 @@ static int gs_usb_probe(struct usb_interface *intf,
>  	icount = dconf->icount + 1;
>  	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
>  
> -	if (icount > GS_MAX_INTF) {
> +	if (icount > type_max(typeof(dev->channel_cnt))) {
>  		dev_err(&intf->dev,
> -			"Driver cannot handle more that %d CAN interfaces\n",
> -			GS_MAX_INTF);
> +			"Driver cannot handle more that %u CAN interfaces\n",
> +			type_max(typeof(dev->channel_cnt)));
>  		kfree(dconf);
>  		return -EINVAL;
>  	}
>  
> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	dev = kzalloc(struct_size(dev, canch, icount), GFP_KERNEL);
>  	if (!dev) {
>  		kfree(dconf);
>  		return -ENOMEM;
>  	}
>  
> +	dev->channel_cnt = icount;
> +
>  	init_usb_anchor(&dev->rx_submitted);
>  
>  	usb_set_intfdata(intf, dev);
> @@ -1045,7 +1044,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
>  		return;
>  	}
>  
> -	for (i = 0; i < GS_MAX_INTF; i++)
> +	for (i = 0; i < dev->channel_cnt; i++)
>  		if (dev->canch[i])
>  			gs_destroy_candev(dev->canch[i]);
>  
> -- 
> 2.51.1.dirty
> 
> 

Again, not going to try :)

