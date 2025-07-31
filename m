Return-Path: <stable+bounces-165617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61515B16B31
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 06:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D31546062
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 04:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546723D2B0;
	Thu, 31 Jul 2025 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dy38XzYO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3611EB3D;
	Thu, 31 Jul 2025 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753936360; cv=none; b=Pnzn6enXZ91edQ+buqewdcd/u0E8v+gJpmb71aHms5504ezeI3wZ2quMkhmfJh1r1lT30PECf116x5sZXX2fcxVWLmmCDJ0QcxIIs+OSsRZs8Pdqza+IVoTH+4HAp0oEF9Mo+G9wigSdPis0CseXkfiERt4+EP6nKXXUWALEuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753936360; c=relaxed/simple;
	bh=NNClWWcmR2BWH2a2iNSt2rpiOcnkU6NNKfFasK5sQuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH2Tc4P37iqSnRKYAtkvuDlVrLIZV+jMk+HQHeTs/JqRMNTRPCf74HLsYwAyZrhYNHZxg6ruzHqVNRNLo0c+YEUPF8/U95PS9ch/AxneakZHNDV9FnHkCIxSUweiz2YZ89AxiTq+A1CWXmPdK33+qHOOrlisCb/9HXKU7JYQ2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dy38XzYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5752DC4CEEF;
	Thu, 31 Jul 2025 04:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753936358;
	bh=NNClWWcmR2BWH2a2iNSt2rpiOcnkU6NNKfFasK5sQuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dy38XzYO9fpk7Uv715Z6tY9sIMqZDtpXMTy7oTCih13ozJlRvo8VvVXb4U6Z7wBJV
	 uIx3hoJOOmexTBMW3t2uK5nxEX0YB7ZjMjTD8w+nHj3NXIjTvlm/F2k/03RDgz0h2R
	 dLT4ioek5nMWN8CKJjgGG0E0pwkiNta6YAtBY1DY=
Date: Thu, 31 Jul 2025 06:32:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH V3] Bluetooth: bfusb: Fix use-after-free and memory leak
 in device lifecycle
Message-ID: <2025073101-upon-lilac-9d22@gregkh>
References: <aIrSp18mz3GS67a1@pc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIrSp18mz3GS67a1@pc>

On Thu, Jul 31, 2025 at 03:19:19AM +0100, Salah Triki wrote:
> The driver stores a reference to the `usb_device` structure (`udev`)
> in its private data (`data->udev`), which can persist beyond the
> immediate context of the `bfusb_probe()` function.
> 
> Without proper reference count management, this can lead to two issues:
> 
> 1. A `use-after-free` scenario if `udev` is accessed after its main
>    reference count drops to zero (e.g., if the device is disconnected
>    and the `data` structure is still active).

How can that happen as during the probe/remove cycle, the reference
count is always properly incremetned.

> 2. A `memory leak` if `udev`'s reference count is not properly
>    decremented during driver disconnect, preventing the `usb_device`
>    object from being freed.

There is no leak here at all, sorry.

> To correctly manage the `udev` lifetime, explicitly increment its
> reference count with `usb_get_dev(udev)` when storing it in the
> driver's private data. Correspondingly, decrement the reference count
> with `usb_put_dev(data->udev)` in the `bfusb_disconnect()` callback.
> 
> This ensures `udev` remains valid while referenced by the driver's
> private data and is properly released when no longer needed.

How was this tested?

I'm not saying the change is wrong, just that I don't think it's
actually a leak, or fix of anything real.

Or do you have a workload that shows this is needed?  If so, what is the
crash reported?

thanks,

greg k-h

