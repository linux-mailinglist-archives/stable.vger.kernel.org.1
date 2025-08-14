Return-Path: <stable+bounces-169606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15242B26D42
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 19:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2257A572A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192841E5B7A;
	Thu, 14 Aug 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2sbObHT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC023321446;
	Thu, 14 Aug 2025 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191205; cv=none; b=Sg2xn9u1RgE583gdKwU0ssl5YyO3qP1s23MPIPlRuVT6irZIQ0Y1vWCS1c95cGdA3jYmU8L5AmMGzXhirZ7W/mj3DxBWjKkhQwE+EG76H3wIEvrnOCU6sgIz76hKIU+CTdUNYtftcQ1+jW4vJ0C9CGimrSugmhsC3gweu2veIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191205; c=relaxed/simple;
	bh=7ZxYnpu99t0vZK+i5eu58QROLyB3Osh4912wLP+tnas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9mtrDbnT8wPpSOWEsN1sgq2jgBuTrHOs4qhYvrspDASZjQe02+9zjmYcnpnDG1gTu4SH4S06R5U3YTtnKhNbA6+E3lmuzosS2eaRr5s6T8vn7ZqrNXd6HtzypeztL4Am+DM32IWd06eGS+AVu7tgKAfkrF8sVKLNzo/A0aXsAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2sbObHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07FDC4CEED;
	Thu, 14 Aug 2025 17:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755191205;
	bh=7ZxYnpu99t0vZK+i5eu58QROLyB3Osh4912wLP+tnas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2sbObHTU7j8tt1ACsqdXrxxy0DRrlkD6AzWHftGONh5kYE0OeE0LA3jZCM4cmbcS
	 L20aaWDLkw1DM/nPhSNBFifj4b7k2mzoWsawWos9BqbPp5JU9cNjeac7GdQicyJH0p
	 au6vTe0rnkXX/Dod1xOME9n2hdfVLBENtrqjA8wc=
Date: Thu, 14 Aug 2025 19:06:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Zenm Chen <zenmchen@gmail.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, pkshih@realtek.com,
	rtl8821cerfe2@gmail.com, stable@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, usbwifi2024@gmail.com
Subject: Re: [usb-storage] Re: [PATCH] USB: storage: Ignore driver CD mode
 for Realtek multi-mode Wi-Fi dongles
Message-ID: <2025081428-unfold-shakily-6278@gregkh>
References: <03d4c721-f96d-4ace-b01e-c7adef150209@rowland.harvard.edu>
 <20250814140329.2170-1-zenmchen@gmail.com>
 <b938a764-6ded-4b76-a15c-82c0062abf42@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b938a764-6ded-4b76-a15c-82c0062abf42@rowland.harvard.edu>

On Thu, Aug 14, 2025 at 12:21:16PM -0400, Alan Stern wrote:
> On Thu, Aug 14, 2025 at 10:03:29PM +0800, Zenm Chen wrote:
> > > Also, can you collect a usbmon trace showing what happens when the dongle is plugged in?
> > 
> > Hi Alan,
> > 
> > Today I removed usb_modeswitch from my system and grabbed some data, could you please take
> > a look what was wrong? many thanks!
> 
> Yes, this shows the problem.  I'll skip the unimportant stuff below.
> 
> > D-Link AX9U
> 
> ...
> 
> > ffff8ae1f0bee000 771359614 S Bo:2:053:5 -115 31 = 55534243 0a000000 08000000 80000a25 00000000 00000000 00000000 000000
> > ffff8ae1f0bee000 771359684 C Bo:2:053:5 0 31 >
> > ffff8ae1b52d83c0 771359702 S Bi:2:053:4 -115 8 <
> > ffff8ae1b52d83c0 771359812 C Bi:2:053:4 0 8 = 00007bff 00000200
> > ffff8ae1f0bee000 771359853 S Bi:2:053:4 -115 13 <
> > ffff8ae1f0bee000 771359935 C Bi:2:053:4 0 13 = 55534253 0a000000 00000000 00
> 
> This is a READ CAPACITY(10) command.  It asks the device for the number
> of data blocks it contains and the size of each block.  The reply says
> there are 31744 blocks each containing 512 bytes (which is unheard-of
> for CDs; they virtually always have 2048 bytes per block).
> 
> ...
> 
> > ffff8ae1f0bee000 771366235 S Bo:2:053:5 -115 31 = 55534243 17000000 0c000000 00000615 1000000c 00000000 00000000 000000
> > ffff8ae1f0bee000 771366306 C Bo:2:053:5 0 31 >
> > ffff8ae218ff2900 771366317 S Bo:2:053:5 -115 12 = 00000008 00000000 00000800
> > ffff8ae218ff2900 771366432 C Bo:2:053:5 0 12 >
> > ffff8ae1f0bee000 771366443 S Bi:2:053:4 -115 13 <
> > ffff8ae1f0bee000 771366556 C Bi:2:053:4 0 13 = 55534253 17000000 0c000000 01
> 
> This is a MODE SELECT(6) command.  This one tells the device to change
> the block size to 2048.  The device responds with an error indication.
> 
> > ffff8ae1f0bee000 771366567 S Bo:2:053:5 -115 31 = 55534243 18000000 12000000 80000603 00000012 00000000 00000000 000000
> > ffff8ae1f0bee000 801899370 C Bo:2:053:5 -104 0
> 
> This is a REQUEST SENSE command; it asks the device to report the
> details of the error condition from the previous command.  But the
> device doesn't reply and the command times out.  From this point on,
> the trace shows nothing but repeated resets.  They don't help and the
> device appears to be dead.
> 
> I don't know of any reasonable way to tell the kernel not to send that
> MODE SELECT(6) command.
> 
> The log for the Mercury is generally similar although the details are
> different.  Everything works okay until the computer sends a command
> that the device doesn't like.  At that point the device dies and
> resets don't revive it.
> 
> So it does indeed look like there is no alternative to making
> usb-storage ignore the devices.
> 
> Greg, do you still have the original patch email that started this 
> thread?  You can add:
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks, I have it somewhere, I'll dig it up and apply it.

greg k-h

