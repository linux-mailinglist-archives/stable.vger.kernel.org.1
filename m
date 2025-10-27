Return-Path: <stable+bounces-189955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC948C0D2BA
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F7344605
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F972FB965;
	Mon, 27 Oct 2025 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YcZbm7D/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="imeA4lqN"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3B4438B
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565106; cv=none; b=Dk2SiP1IIZ7kk8HuSe35g8ghdnKF9lJWCfNJ6wJjMclWTLDiZh0FkC8N30CkyQ63fytjjKT4XMpSKsyZzue8NbI8fm26ekO7t6DXSGjNnRKU2KV/9TtlOAVPYrku4TT7UgwNf+OiDpIHj9jkJmCU5kOiS0hvZipKyVq2+l90Oj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565106; c=relaxed/simple;
	bh=6aCF8x16CSrId6Qfu0HaAtB80U8c4JwXDaArSP4tfIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD7toZvMppKxWnld9LV5O2YVQ9f+oXm4AejRauPGSJLGlSxr/RYbfb5SBkYVpF1+jnl/3+toQVSosV0V5R1dJbTCqpRzZcJfojtHJSKsbOCZrtxQ2Q6lZzcm4A4bn28aHFE0pz48EgjrINGcPhCodfeDiZiApRislBMdSKzs5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=YcZbm7D/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=imeA4lqN; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E6C461D00173;
	Mon, 27 Oct 2025 07:38:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 27 Oct 2025 07:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761565103; x=1761651503; bh=39d0JVXLMC
	IFe2t3ZktH8KWGrHD8yw3zS0Nsc1cBSLU=; b=YcZbm7D/bNtfs0twYy0XZohelO
	Yn7qixfCp6SmU4mqgE5DlWULguMx2rVhOPhBSq8FV/Lm8DqN5N5IHrgxcYibNIN5
	x0iBZV/HxdIxZ1BN+Cp/pjevQn5auuqBncNJPU6pYytdai798biedF2Ivnem7XUL
	IQD0/vr5dIpXLkzaf1omj+x0t8paoqeWjzHVNgKQiJVnTWmWf3rxC2ymuerWH3nu
	xBUpNF1yIJIgFDgqELi9TFHDomTp/y3eYoLPmICnLf2TUT6eOkHk90CkeBcs6EU1
	SHWaFQrDZhk63DnKPlLVSh+2qab5X3NvEeQ60JarEh93WokFW4v31lcMZqkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761565103; x=1761651503; bh=39d0JVXLMCIFe2t3ZktH8KWGrHD8yw3zS0N
	sc1cBSLU=; b=imeA4lqNPH7+gOw84gXexj80uiXbpLfukADCQQM7l0Il7YBLmBh
	hYEZFzgrjGRU2wTMzz6pHrF4fJld1ul0wMnyuJwN6CE+47k2ytfJlzzP9zOg56im
	HiH4/2dBhmZGuNRTTQbQna7qXED+u4fwXolCIpfS/jFpn0g1O3PuyvXZRMV9lBWM
	J4ywnPK5+LIRso+Tn0nL/qwKOndhdzuO/8yQMx4kOJbwQcxTN21Vw0bgbM3k7ctm
	AgQMjwA8khHM7yfzXZUAPhPd8arZ7Z3GZ1NDeqmuGvUmbIY/st2AVaTDz71C7e0d
	jUvfM31WWMGrXQ7sh9gzOSXmIejdqPj14Kw==
X-ME-Sender: <xms:r1n_aK7Mcf05dJJCsytGdGzqVqhVYFpTqEjjH1elGxUKAJqZ46JUBA>
    <xme:r1n_aG97NexT_8jx5p8WIouw0Q5iu3oBCeM8AE-llSz_UE8HtlzV9yDrVr5JKlyQC
    3zSTv_MbPSVu9h3UwMqFiOt8D6UbUk3wxVWy3aQl8E4WomdGg>
X-ME-Received: <xmr:r1n_aEEgHQhOehAnRumklEwUp93hKCLlCXSXEVpObDA_7BSGgaDq1aqzVomL9eLXyMVuensyoyEDze9mTxaSD_dgPeKinNs0PedhXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepkedvudelhe
    ekfeffgfduhfdvjeegtedvfedtgffhffetteeiudelhfetvdehgffhnecuffhomhgrihhn
    pehgihhthhhusgdrtghomhdpmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhifuh
    estghovghlrggtrghnthhhuhhsrdhnrghmvgdprhgtphhtthhopehsthgrsghlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhntghhvghnghdrlhhusehhph
    hmihgtrhhordgtohhmpdhrtghpthhtohepmhgrihhlhhholheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhklhesphgvnhhguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:r1n_aDWZT5KOJwWuw1EJzbxPWF8ojrbuBa1mWN8wvCSvccWoNZnA9g>
    <xmx:r1n_aI9CJpZtS_0AfXBvF4SeuVzkGxrB8HJ2a6gicmduTUc1xLm7tg>
    <xmx:r1n_aI7hXG460j1F5xAgOqB7myvQkx3RaQM8wdBwNvOpCPX4_yeH7w>
    <xmx:r1n_aJlflAxlDejBU92N5fUks2PuPIrlgWyAKGbD50zYAs_IMTfb-w>
    <xmx:r1n_aH2_x3Zp26mIEOgepB5xS5JIam5ZMYvpcLDzIJ3IJRuhjgbu-0fR>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:38:22 -0400 (EDT)
Date: Mon, 27 Oct 2025 12:37:37 +0100
From: Greg KH <greg@kroah.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: stable@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.10.y] can: gs_usb: increase max interface to U8_MAX
Message-ID: <2025102730-overcoat-carol-dbf9@gregkh>
References: <2025102040-unusual-concur-90e9@gregkh>
 <20251020122342.1517889-2-uwu@coelacanthus.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020122342.1517889-2-uwu@coelacanthus.name>

On Mon, Oct 20, 2025 at 08:23:43PM +0800, Celeste Liu wrote:
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
> index 864db200f45e..f39bd429f77d 100644
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

I'm not even going to try to build this one :)

