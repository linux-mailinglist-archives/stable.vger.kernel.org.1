Return-Path: <stable+bounces-121086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EDCA509F5
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5A818865D8
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FCF1FC7D0;
	Wed,  5 Mar 2025 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAHvzRD8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E340F1C5D4E;
	Wed,  5 Mar 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199187; cv=none; b=mcK2IArh2CCemRpBrhdJNKLfOQ1j6srOlRkm0H93qP1X7nKZ9/ze+BB7IeXiOUXs+VuozghfRqEOC/G39yfM0QANIhWfMgLlGZcGA9+oPk7JHPrtFvk0havySu2PMVDbUBqaGmq8zUl6e8+UqtPz9vgX9x1Uh5YUPfoptVN3pVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199187; c=relaxed/simple;
	bh=48DnJO3qW9Xs9zwpNZ50ar/9+kQ5TVK9X1F4TNoalcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qghCfJQGWbF9CyuQwgKgZTNVngA2zdJlADrBGBt6kCKx1Ccb4IUXG63WM3nE5wTF7cTipjll5aSuq+OP0gkSqVl8gr7+xRj6Tpwefrt40AQ9s1p33Z3X0Q7mYnL2LJ9nN5525RyXBe6uig6HFflj+B1H4Cl4TpCJRejIxzACdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAHvzRD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4998C4CED1;
	Wed,  5 Mar 2025 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741199186;
	bh=48DnJO3qW9Xs9zwpNZ50ar/9+kQ5TVK9X1F4TNoalcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAHvzRD8+X7g/AegMw7cyR1jIwlwz5qCxdSl8q5jhYOT4xNzXEaGJZB9Fdj+MeCy0
	 zQCXdrTiF2LVuVJcDNOHIsvh5R7txnOr32WZiGaQgPeQy2LJV7s5axeUkJNO5y1Fcf
	 ZdLkD4jegXk2G1loOK//y6wV7Kq4PNp1UoUjKgwU=
Date: Wed, 5 Mar 2025 19:09:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Se=EFfane?= Idouchach <seifane53@gmail.com>
Cc: dirk.behme@de.bosch.com, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] Long boot times due to USB enumeration
Message-ID: <2025030559-radiated-reviver-eebb@gregkh>
References: <CAMpRfLORiuJOgUmpmjgCC1LZC1Kp0KFzPGXd9KQZELtr35P+eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpRfLORiuJOgUmpmjgCC1LZC1Kp0KFzPGXd9KQZELtr35P+eQ@mail.gmail.com>

On Thu, Mar 06, 2025 at 12:32:59AM +0800, Seïfane Idouchach wrote:
> Dear all,
> 
> I am reporting what I believe to be regression due to
> c0a40097f0bc81deafc15f9195d1fb54595cd6d0.
> 
> After this change I am experiencing long boot times on a setup that
> has what seems like a bad usb.
> The progress of the boot gets halted while retrying (and ultimately
> failing) to enumerate the USB device and is only allowed to continue
> after giving up enumerating the USB device.
> On Arch Linux this manifests itself by a message from SystemD having a
> wait job on journald. Journald starts just after the enumeration fails
> with "unable to enumerate USB device".
> This results in longer boot times on average 1 minute longer than
> usual (usually around 10s).
> No stable kernel before this change exhibits the issue all stable
> kernels after this change exhibit the issue.
> 
> See the related USB messages attached below (these messages are
> continuous and have not been snipped) :
> 
> [...]
> [    9.640854] usb 1-9: device descriptor read/64, error -110
> [   25.147505] usb 1-9: device descriptor read/64, error -110
> [   25.650779] usb 1-9: new high-speed USB device number 5 using xhci_hcd
> [   30.907482] usb 1-9: device descriptor read/64, error -110
> [   46.480900] usb 1-9: device descriptor read/64, error -110
> [   46.589883] usb usb1-port9: attempt power cycle
> [   46.990815] usb 1-9: new high-speed USB device number 6 using xhci_hcd
> [   51.791571] usb 1-9: Device not responding to setup address.
> [   56.801594] usb 1-9: Device not responding to setup address.
> [   57.010803] usb 1-9: device not accepting address 6, error -71
> [   57.137485] usb 1-9: new high-speed USB device number 7 using xhci_hcd
> [   61.937624] usb 1-9: Device not responding to setup address.
> [   66.947485] usb 1-9: Device not responding to setup address.
> [   67.154086] usb 1-9: device not accepting address 7, error -71
> [   67.156426] usb usb1-port9: unable to enumerate USB device

That's a real issue, but should not be due to the commit id you
referenced.

> [...]
> 
> This issue does not manifest in 44a45be57f85.

What does that commit have to do with this?  That's just a build break
fix.

> I am available to test any patches to address this on my system since
> I understand this could be quite hard to replicate on any system.
> I am available to provide more information if I am able or with
> guidance to help troubleshoot the issue further.
> 
> Wishing you all a good day.
> 
> #regzbot introduced: c0a40097f0bc81deafc15f9195d1fb54595cd6d0
> 

We know there are issues here.  That commit was "fixed" by commit
15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach race"),
but then that caused a different problem, so it was reverted by commit
9a71892cbcdb ("Revert "driver core: Fix uevent_show() vs driver detach
race"").

There are many discussions about this on the mailing list, with a
proposal to add Dan's "fix" back.  If you could try that, it would be
great to see.

I think your USB problem is different here, but if you add 15fffc6a5624
("driver core: Fix uevent_show() vs driver detach race") to your kernel,
that would be great to see.

thanks,

greg k-h

