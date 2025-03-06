Return-Path: <stable+bounces-121216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E5A548B7
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 12:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852AD172D9B
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0826720371F;
	Thu,  6 Mar 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1gz1SnB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA21D2E339F;
	Thu,  6 Mar 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259190; cv=none; b=Hby57rs9luMlESuSzntcaH8YE1Z2XPSLMmfblRratoH74RMaKz86j7luX5gTn3ZI50wDu3Iit5+lAS8Q8l/j0JMX+0HCnCZcQ4B98Xpfc0wn8cVQjeCnWxw3E+g12TQ09wmnoSpRX+El9PAFApMowrnrMkuYYIfkNKMlxHWamZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259190; c=relaxed/simple;
	bh=Toiav5rJXJ6ER7IWROvJ6xmb8MuBfokeAG7Tqf3wg4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ0mAxH5ra3rU4IAWFUY88q/SewUv4mASbz18EfRFLtaY8aJQc8tRL4rKR8i1OEhPWwfEzVF6ifyPh+PogwYiL1wLG0BQ+6U377a7rX+EyAzo0NsGE+4kGjoXRstYqTY3D6mrTIx6py8bdtFKLI3MUDSTMSbL5pcyTP0zvb6F+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1gz1SnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395E9C4CEE0;
	Thu,  6 Mar 2025 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741259190;
	bh=Toiav5rJXJ6ER7IWROvJ6xmb8MuBfokeAG7Tqf3wg4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1gz1SnBTuJs7H7QIYe6Fl+/cl4wZsBHTjBQCVtMgW/2FvnwveSHeHATq6MB0LCwN
	 iC+2Ojt7C3G1KaILC0kbQ19kJPh/MK1g3qTidffoQDQGhwDW/mmZm7rl4z19GGqzNn
	 ngKAkPROSbb+IsCz5oM4xdgZgRL1lfiZoB4W4cgR5XhdRvMRyiEhkDh4oY+v19b+Ud
	 CCHM67eRHQSf9ZBZWKzb1nglxa+w5/P2Huz4i6GCpR0mY5sObxop2Nn4SBu46NlHxg
	 ga/1mR2hqehr90BoC4nHoYYWBTSAn7VmYjlN7mEBJKEbHD/zMW2ph4FJpgTMSC4zZW
	 RZA20RLkMeHTg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tq93a-000000004kf-2e7f;
	Thu, 06 Mar 2025 12:06:27 +0100
Date: Thu, 6 Mar 2025 12:06:26 +0100
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 1/2] USB: serial: option: add Telit Cinterion FE990B
 compositions
Message-ID: <Z8mBsi-Tsu9ubbWQ@hovoldconsulting.com>
References: <20250304091939.52318-1-fabio.porcedda@gmail.com>
 <20250304091939.52318-2-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304091939.52318-2-fabio.porcedda@gmail.com>

On Tue, Mar 04, 2025 at 10:19:38AM +0100, Fabio Porcedda wrote:
> Add the following Telit Cinterion FE990B40 compositions:

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  drivers/usb/serial/option.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 58bd54e8c483..8660f7a89b01 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1388,6 +1388,22 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
>  	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b0, 0x60) },	/* Telit FE990B (rmnet) */
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b0, 0x40) },
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b0, 0x30),
> +	  .driver_info = NCTRL(5) },
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b1, 0x60) },	/* Telit FE990B (MBIM) */
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b1, 0x40) },
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b1, 0x30),
> +	  .driver_info = NCTRL(6) },
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b2, 0x60) },	/* Telit FE990B (RNDIS) */
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b2, 0x40) },
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b2, 0x30),
> +	  .driver_info = NCTRL(6) },
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b3, 0x60) },	/* Telit FE990B (ECM) */
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b3, 0x40) },
> +	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b3, 0x30),
> +	  .driver_info = NCTRL(6) },

Thanks for the patches. I noticed now that you use
USB_DEVICE_INTERFACE_PROTOCOL() just like you recently did for FN990B.

While this works, the protocol is qualified by the interface class and
subclass which should have been included.

I changed these to use USB_DEVICE_AND_INTERFACE_INFO() and sorted the
entries also by protocol.

I'll send out a corresponding change for FN990B.

Johan

