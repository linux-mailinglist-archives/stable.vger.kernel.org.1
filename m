Return-Path: <stable+bounces-105418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B89F9222
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 13:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71BD57A3036
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF0204567;
	Fri, 20 Dec 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xjuuh4Ev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5013C914;
	Fri, 20 Dec 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697457; cv=none; b=Zl1U7QLKQ203uqJCmN92g3SGfPB7R9D2wOJv3N8Moo0aN1okxflyC9V1rFRteOOeo9llAcx9hBnQ/ad1V+4+2qd18ckoJQf9zztBoQKGkJAatNweZMMRVgNzUl8+wP4yTkqh/BxUl/6535AMGbANcVQcE+fZsBgOT1YEc0/3pjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697457; c=relaxed/simple;
	bh=J8GTeuksbYDtKPfiOanv+yBIDvmxFpdIQ6kc3B9nfN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S62M8h1I4NtuVaY5+exFYr7TRBykx1LEYMSHSVjtACZ4DsiwHt0RbP7FMgTtbMqeU1eUPwSHV2stTWtytQZ9R4hFago/zJlMluUPulRAF7ALIhIcT7HYZpw9yy+dZpzLf+ORDxjqEdv9EaydU3zoq+ioQVH7pzvWzxy+jz7l1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xjuuh4Ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E185CC4CECD;
	Fri, 20 Dec 2024 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734697456;
	bh=J8GTeuksbYDtKPfiOanv+yBIDvmxFpdIQ6kc3B9nfN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xjuuh4EvkkVvjgr+QjOxzUEg/JC72OF9GMebkwk5B5jdlg3jbKwhQcEEcmY4u6Tz4
	 OvokcLd6aOId+LJUJ6OYaghzJpFOHOhPILlclMkBbVCN4XsxiTWFF+yekQm/QiZf0V
	 mP7zSIdyX0pT55du5SA2Dyh80K9MAlmyswZE8C9I=
Date: Fri, 20 Dec 2024 13:24:12 +0100
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
Message-ID: <2024122013-scary-paver-fcff@gregkh>
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
 <20241208152322.1653-1-selvarasu.g@samsung.com>
 <2024121845-cactus-geology-8df3@gregkh>
 <9f16a8ac-1623-425e-a46e-41e4133218e5@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f16a8ac-1623-425e-a46e-41e4133218e5@samsung.com>

On Wed, Dec 18, 2024 at 03:51:50PM +0530, Selvarasu Ganesan wrote:
> 
> On 12/18/2024 11:01 AM, Greg KH wrote:
> > On Sun, Dec 08, 2024 at 08:53:20PM +0530, Selvarasu Ganesan wrote:
> >> The current implementation sets the wMaxPacketSize of bulk in/out
> >> endpoints to 1024 bytes at the end of the f_midi_bind function. However,
> >> in cases where there is a failure in the first midi bind attempt,
> >> consider rebinding.
> > What considers rebinding?  Your change does not modify that.
> 
> Hi Greg,
> Thanks for your review comments.
> 
> 
> Here the term "rebind" in this context refers to attempting to bind the 
> MIDI function a second time in certain scenarios.
> The situations where rebinding is considered include:
> 
>   * When there is a failure in the first UDC write attempt, which may be
>     caused by other functions bind along with MIDI
>   * Runtime composition change : Example : MIDI,ADB to MIDI. Or MIDI to
>     MIDI,ADB
> 
> The issue arises during the second time the "f_midi_bind" function is 
> called. The problem lies in the fact that the size of 
> "bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call, 
> which exceeds the hardware capability of the dwc3 TX/RX FIFO 
> (ep->maxpacket_limit = 512).

Ok, but then why not properly reset ALL of the options/values when a
failure happens, not just this one when the initialization happens
again?  Odds are you might be missing the change of something else here
as well, right?

Also, cleaning up from an error is a better thing to do than forcing
something to be set all the time when you don't have anything gone
wrong.

thanks,

greg k-h

