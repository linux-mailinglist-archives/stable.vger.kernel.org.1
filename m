Return-Path: <stable+bounces-105426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1D9F9527
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 16:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B188616BD70
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3B218EA8;
	Fri, 20 Dec 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O2YHlbSa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812E216392;
	Fri, 20 Dec 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707745; cv=none; b=aeRx1zAzLB+4fnIs62phw0wBLZ+4J1IVBj0OsaIbO4HrIYliL11qtJFzar366v0zHLXFe9ndT5tYzvCGcYhPQDhBL4xKvG4txSeAcwBxYzzj8CBsjVujmgizlyefmwoWyWAX1B8F6ge5kzRFIayUogMH21HdK1XwLWj0rwvK3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707745; c=relaxed/simple;
	bh=NaQxpuMSY7jAHd7w2AoDfw5wsF4s423zwuOxLDwqw68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLXP5F9Vugp4igZsSJY0OCuN4D4PErAtMEh/uBOE2v6f4P4tiz8+FIUMLJjhtwtWyGgrHkBnJS4BsT2dSMrHvw4qCJP0utLYB+iKmw+43I5dcuoSagUTIMxjfZZb+U8U+isIR2GCCVUA03sDp5W4c3mAdSFwRyXjA/8GOLZw7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O2YHlbSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92328C4CECD;
	Fri, 20 Dec 2024 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734707745;
	bh=NaQxpuMSY7jAHd7w2AoDfw5wsF4s423zwuOxLDwqw68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2YHlbSaa6XypeiVm1f7MEH8KI6XdnAqSJ4hjB2GleiAfK255j1Ko1ApzYZM6fWOR
	 etn2JRI132882zCr1GDDujGv1YmqG3E0B9f7q4COUvgnb1YRE9Gs624WdLXUyNLjZq
	 l/ant+RHHoQ4vi2CuzJqCt2sULQZQlYVJmsghLGQ=
Date: Fri, 20 Dec 2024 16:15:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: quic_jjohnson@quicinc.com, kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
Message-ID: <2024122007-flail-traverse-b7b8@gregkh>
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
 <20241208152322.1653-1-selvarasu.g@samsung.com>
 <2024121845-cactus-geology-8df3@gregkh>
 <9f16a8ac-1623-425e-a46e-41e4133218e5@samsung.com>
 <2024122013-scary-paver-fcff@gregkh>
 <a1dedf06-e804-4580-a690-25e55312eab8@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1dedf06-e804-4580-a690-25e55312eab8@samsung.com>

On Fri, Dec 20, 2024 at 07:02:06PM +0530, Selvarasu Ganesan wrote:
> 
> On 12/20/2024 5:54 PM, Greg KH wrote:
> > On Wed, Dec 18, 2024 at 03:51:50PM +0530, Selvarasu Ganesan wrote:
> >> On 12/18/2024 11:01 AM, Greg KH wrote:
> >>> On Sun, Dec 08, 2024 at 08:53:20PM +0530, Selvarasu Ganesan wrote:
> >>>> The current implementation sets the wMaxPacketSize of bulk in/out
> >>>> endpoints to 1024 bytes at the end of the f_midi_bind function. However,
> >>>> in cases where there is a failure in the first midi bind attempt,
> >>>> consider rebinding.
> >>> What considers rebinding?  Your change does not modify that.
> >> Hi Greg,
> >> Thanks for your review comments.
> >>
> >>
> >> Here the term "rebind" in this context refers to attempting to bind the
> >> MIDI function a second time in certain scenarios.
> >> The situations where rebinding is considered include:
> >>
> >>    * When there is a failure in the first UDC write attempt, which may be
> >>      caused by other functions bind along with MIDI
> >>    * Runtime composition change : Example : MIDI,ADB to MIDI. Or MIDI to
> >>      MIDI,ADB
> >>
> >> The issue arises during the second time the "f_midi_bind" function is
> >> called. The problem lies in the fact that the size of
> >> "bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call,
> >> which exceeds the hardware capability of the dwc3 TX/RX FIFO
> >> (ep->maxpacket_limit = 512).
> > Ok, but then why not properly reset ALL of the options/values when a
> > failure happens, not just this one when the initialization happens
> > again?  Odds are you might be missing the change of something else here
> > as well, right?
> Are you suggesting that we reset the entire value of 
> usb_endpoint_descriptor before call usb_ep_autoconfig? If so, Sorry I am 
> not clear on your reasoning for wanting to reset all options/values. 
> After all, all values will be overwritten 
> afterusb_ep_autoconfig.Additionally, the wMaxPacketSize is the only 
> value being checked during the EP claim process (usb_ep_autoconfig), and 
> it has caused issues where claiming wMaxPacketSize is grater than 
> ep->maxpacket_limit.

Then fix up that value on failure, if things fail you should reset it
back to a "known good state", right?  And what's wrong with resetting
all of the values anyway, wouldn't that be the correct thing to do?

> > Also, cleaning up from an error is a better thing to do than forcing
> > something to be set all the time when you don't have anything gone
> > wrong.
> As I previously mentioned, this is a general approach to set 
> wMaxPacketSize before claiming the endpoint. This is because the 
> usb_ep_autoconfig treats endpoint descriptors as if they were full 
> speed. Following the same pattern as other function drivers, that 
> approach allows us to claim the EP with using a full-speed descriptor. 
> We can use the same approach here instead of resetting wMaxPacketSize 
> every time.
> 
> The following provided code is used to claim an EP with a full-speed 
> bulk descriptor in MIDI. Its also working solution.  But, We thinking 
> that it may unnecessarily complicate the code as it only utilizes the 
> full descriptor for obtaining the EP address here. What you think shall 
> we go with below approach instead of rest wMaxPacketSize before call 
> usb_ep_autoconfig?

I don't know, what do you think is best to do?  You are the one having
problems and will need to fix any bugs that your changes will cause :)

thanks,

greg k-h

