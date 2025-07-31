Return-Path: <stable+bounces-165653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1DCB170B3
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 13:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C677A82150
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBEE2C324C;
	Thu, 31 Jul 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p96UlHqi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0312C08C1;
	Thu, 31 Jul 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962752; cv=none; b=MPeHrxZDz3+Q6xWUJAWMe1NOsu5jGp2Aakr2uYdx+Je8r6KrNXFAufdMFDWDeRCNsdZqfuS/mgxo6UfHghh8sIU9+JX5jEHLRUDn+fc2mie1/WmxJfNduSrzHtOmHceLLp6Ii6QJGMs6yI+qzlZuHLwmK6MJggMhr46pogk2w3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962752; c=relaxed/simple;
	bh=L+Oj+lgcb5CliM2jzbx09ewH/vd7ovKgOLBsvX7o3ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG8xzk1yzmtwXpq7gxJSGY51dW5p4Q8BMqi2I6zO9VUA/j8y56netJzKuSam/zhbCeVD3zvQCvFhFxvEa6WoInuu203N4SWyfAu6kwM4XTnF+oLmrYUCYkifuZH5g4gzncgan3Drd+RlMUy9CRzzoEvSQu1t7+4sQkeuSELMhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p96UlHqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A852FC4CEEF;
	Thu, 31 Jul 2025 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753962752;
	bh=L+Oj+lgcb5CliM2jzbx09ewH/vd7ovKgOLBsvX7o3ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p96UlHqiFFrkaTDbfQuB/eKt9KJY/OkRMDTR2favyWTiCBGEB5YJ5ybcg1BuwJ680
	 6tBXJ6R25SZ85H+UTR2mix4hbrxIq5T6jMQU+6c8WsL4o/3Yu4nwARid+m2zaNiu+L
	 6ZynRgXd/O6yJCS7wXTHN+rr4VgtZmH7MNI5dAE8=
Date: Thu, 31 Jul 2025 13:52:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH V3] Bluetooth: bfusb: Fix use-after-free and memory leak
 in device lifecycle
Message-ID: <2025073152-molecular-porthole-c949@gregkh>
References: <aIrSp18mz3GS67a1@pc>
 <2025073101-upon-lilac-9d22@gregkh>
 <aItRhGyTWNCJmXFA@pc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aItRhGyTWNCJmXFA@pc>

On Thu, Jul 31, 2025 at 12:20:36PM +0100, Salah Triki wrote:
> Hello Greg,
> 
> Thanks for your feedback.
> 
> On Thu, Jul 31, 2025 at 06:32:35AM +0200, Greg KH wrote:
> > On Thu, Jul 31, 2025 at 03:19:19AM +0100, Salah Triki wrote:
> > > The driver stores a reference to the `usb_device` structure (`udev`)
> > > in its private data (`data->udev`), which can persist beyond the
> > > immediate context of the `bfusb_probe()` function.
> > > 
> > > Without proper reference count management, this can lead to two issues:
> > > 
> > > 1. A `use-after-free` scenario if `udev` is accessed after its main
> > >    reference count drops to zero (e.g., if the device is disconnected
> > >    and the `data` structure is still active).
> > 
> > How can that happen as during the probe/remove cycle, the reference
> > count is always properly incremetned.
> > 
> > > 2. A `memory leak` if `udev`'s reference count is not properly
> > >    decremented during driver disconnect, preventing the `usb_device`
> > >    object from being freed.
> > 
> > There is no leak here at all, sorry.
> > 
> 
> I understand your concern about the existence of a memory leak or 
> use-after-free scenario in the driver's current context.
> 
> My intention with this patch is to ensure the driver adheres to best
> practices for managing `usb_device` structure references, as outlined in
> the kernel's documentation. The `usb_get_dev()` function is explicitly
> designed for use when a driver stores a reference to a `usb_device`
> structure in its private data, which is the case here with `data->udev`.
> 
> As the documentation for `usb_get_dev()` states:
> 
> ``Each live reference to a device should be refcounted. Drivers for USB
> interfaces should normally record such references in their probe()
> methods, when they bind to an interface, and release them by calling
> usb_put_dev(), in their disconnect() methods.``
> 
> By following this recommendation, adding `usb_get_dev(udev)` in
> `bfusb_probe()` and `usb_put_dev(data->udev)` in `bfusb_disconnect()`
> ensures the `udev` structure's lifetime is explicitly managed by the driver
> as long as it's being referenced. This proactively prevents potential
> issues that could arise in future scenarios, even if a specific problem
> hasn't been observed or reported yet.

Yes, I agree with the documentation, I wrote it :)

But, I am saying, you are NOT actually fixing anything here.  It's a
"best practice" but due to the fact that the dev pointer is only being
reference counted by your change across the probe/release function, it
is a pointless change.

It's also a "dangerous" change in that you are trying to say "this fixes
a security issue!" when it does not do anything like that at all.

> > > To correctly manage the `udev` lifetime, explicitly increment its
> > > reference count with `usb_get_dev(udev)` when storing it in the
> > > driver's private data. Correspondingly, decrement the reference count
> > > with `usb_put_dev(data->udev)` in the `bfusb_disconnect()` callback.
> > > 
> > > This ensures `udev` remains valid while referenced by the driver's
> > > private data and is properly released when no longer needed.
> > 
> > How was this tested?
> > 
> > I'm not saying the change is wrong, just that I don't think it's
> > actually a leak, or fix of anything real.
> > 
> > Or do you have a workload that shows this is needed?  If so, what is the
> > crash reported?
> > 
> 
> While I don't have a specific workload that reproduces a current crash or
> memory leak, this patch aims to enhance the driver's robustness by
> aligning its behavior with the established conventions for managing
> `usb_device` object references. It's a preventive measure to ensure the
> driver correctly handles the lifetime of the `usb_device` object it
> references, even in scenarios of unexpected disconnection or re-enumeration
> that might otherwise have unforeseen consequences.
> 
> Please let me know if you have any further questions.

Please test this to see if it actually makes any difference in the code
before making claims that it fixes a real bug.

thanks,

greg k-h

