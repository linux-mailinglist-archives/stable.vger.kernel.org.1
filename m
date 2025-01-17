Return-Path: <stable+bounces-109351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A74A14E27
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 12:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6830A1887D2C
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258F1FCFCA;
	Fri, 17 Jan 2025 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRYgREvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FEB1F5611;
	Fri, 17 Jan 2025 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111922; cv=none; b=L86yrH8F1VAHpc2KbYkOiBzRJVH51zt5kYQbMYtmgi9Ftw9vkWnFDDl8biwxdnONdZmnnKVhH9ad3XvFbA7MMk+EpKoHfw3j2Ca6+b0VjFW7YjGYF+HJugNhGlqCw2ovDh5NSy0pVPOFI0NCvrJVGue4hJ6sS7DqIa622R37CGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111922; c=relaxed/simple;
	bh=OhE8kwd0EtOOkH33HthBxwmzG/frOrK5izGyB/354Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9AOFV0t91EQLErK1h3xuyPSgTrKkjzBJoYDVcFVuPk7d5DGbcvlzaVtn8mRJwWBoq9EYRK/i+NtRziEip71aDlBFW/m7iE6IoY9XYdKMdSScrhHoyNv+IbMOMuCMLj54aHxahv6jBFU7oD9e1KBdBjqbdDgthC5Cgtwfemlu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRYgREvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D3CC4CEDD;
	Fri, 17 Jan 2025 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737111922;
	bh=OhE8kwd0EtOOkH33HthBxwmzG/frOrK5izGyB/354Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRYgREvpcJ5kDylPRNTu5jD+I00zDRsyCQnw8nMPCEZeJLhjPc5HkoWbf5ycitoKT
	 KrC4Iuyq/FeihX4ZKt726d7BqUf/RuBsiD6ii2UfBLSe4FkBCWhJI/2FPbUNdPwdvM
	 d2kAQARPV6rjKGq1/d3lom3kl0eMyRTVczbhPzrg=
Date: Fri, 17 Jan 2025 12:05:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: quic_jjohnson@quicinc.com, kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org, thiagu.r@samsung.com
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
Message-ID: <2025011726-hydration-nephew-0d65@gregkh>
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
 <20241208152322.1653-1-selvarasu.g@samsung.com>
 <2024121845-cactus-geology-8df3@gregkh>
 <9f16a8ac-1623-425e-a46e-41e4133218e5@samsung.com>
 <2024122013-scary-paver-fcff@gregkh>
 <a1dedf06-e804-4580-a690-25e55312eab8@samsung.com>
 <2024122007-flail-traverse-b7b8@gregkh>
 <6629115f-5208-42fe-8bf4-25d808129741@samsung.com>
 <7d7a0d7a-76bb-49a8-82f8-07ee53893145@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d7a0d7a-76bb-49a8-82f8-07ee53893145@samsung.com>

On Thu, Jan 16, 2025 at 10:49:24AM +0530, Selvarasu Ganesan wrote:
> 
> On 12/21/2024 11:37 PM, Selvarasu Ganesan wrote:
> >
> > On 12/20/2024 8:45 PM, Greg KH wrote:
> >> On Fri, Dec 20, 2024 at 07:02:06PM +0530, Selvarasu Ganesan wrote:
> >>> On 12/20/2024 5:54 PM, Greg KH wrote:
> >>>> On Wed, Dec 18, 2024 at 03:51:50PM +0530, Selvarasu Ganesan wrote:
> >>>>> On 12/18/2024 11:01 AM, Greg KH wrote:
> >>>>>> On Sun, Dec 08, 2024 at 08:53:20PM +0530, Selvarasu Ganesan wrote:
> >>>>>>> The current implementation sets the wMaxPacketSize of bulk in/out
> >>>>>>> endpoints to 1024 bytes at the end of the f_midi_bind function. 
> >>>>>>> However,
> >>>>>>> in cases where there is a failure in the first midi bind attempt,
> >>>>>>> consider rebinding.
> >>>>>> What considers rebinding?  Your change does not modify that.
> >>>>> Hi Greg,
> >>>>> Thanks for your review comments.
> >>>>>
> >>>>>
> >>>>> Here the term "rebind" in this context refers to attempting to 
> >>>>> bind the
> >>>>> MIDI function a second time in certain scenarios.
> >>>>> The situations where rebinding is considered include:
> >>>>>
> >>>>>     * When there is a failure in the first UDC write attempt, 
> >>>>> which may be
> >>>>>       caused by other functions bind along with MIDI
> >>>>>     * Runtime composition change : Example : MIDI,ADB to MIDI. Or 
> >>>>> MIDI to
> >>>>>       MIDI,ADB
> >>>>>
> >>>>> The issue arises during the second time the "f_midi_bind" function is
> >>>>> called. The problem lies in the fact that the size of
> >>>>> "bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call,
> >>>>> which exceeds the hardware capability of the dwc3 TX/RX FIFO
> >>>>> (ep->maxpacket_limit = 512).
> >>>> Ok, but then why not properly reset ALL of the options/values when a
> >>>> failure happens, not just this one when the initialization happens
> >>>> again?  Odds are you might be missing the change of something else 
> >>>> here
> >>>> as well, right?
> >>> Are you suggesting that we reset the entire value of
> >>> usb_endpoint_descriptor before call usb_ep_autoconfig? If so, Sorry 
> >>> I am
> >>> not clear on your reasoning for wanting to reset all options/values.
> >>> After all, all values will be overwritten
> >>> afterusb_ep_autoconfig.Additionally, the wMaxPacketSize is the only
> >>> value being checked during the EP claim process (usb_ep_autoconfig), 
> >>> and
> >>> it has caused issues where claiming wMaxPacketSize is grater than
> >>> ep->maxpacket_limit.
> >> Then fix up that value on failure, if things fail you should reset it
> >> back to a "known good state", right?  And what's wrong with resetting
> >> all of the values anyway, wouldn't that be the correct thing to do?
> >
> > Yes, It's back to known good state if we reset wMaxPacketSize. There 
> > is no point to reset all values in the usb endpoint descriptor 
> > structure as all the member of this structure are predefined value 
> > except wMaxPacketSize and bEndpointAddress. The bEndpointAddress is 
> > obtain as part of usb_ep_autoconfig.
> >
> > static struct usb_endpoint_descriptor bulk_out_desc = {
> >         .bLength =              USB_DT_ENDPOINT_AUDIO_SIZE,
> >         .bDescriptorType =      USB_DT_ENDPOINT,
> >         .bEndpointAddress =     USB_DIR_OUT,
> >         .bmAttributes =         USB_ENDPOINT_XFER_BULK,
> > };
> >
> HI Greg,
> 
> Gentle remainder for your further comments or suggestions on this.

Sorry, I don't remember, it was thousands of patches reviewed ago.  If
you feel your submission was correct, and no changes are needed, resend
with an expanded changelog text to help explain things so I don't have
the same questions again.

thanks,

greg k-h

