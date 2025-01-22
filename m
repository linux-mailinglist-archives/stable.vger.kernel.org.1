Return-Path: <stable+bounces-110205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B923A196D1
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522811617E3
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 16:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409B21516F;
	Wed, 22 Jan 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="G9HYZzDk"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072A214A74;
	Wed, 22 Jan 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564529; cv=none; b=ftYga/xx9bKTdQLgjtirMKJyp8zUTcmuAkRNQ6i9CvdhfzTzgMoMWiJ+QFzjmgLblFiFLGv6v3yrYFHRoDWL5SBQ/7OsfNpNu1ak4yFD7hPvx/UVGfnJb5O/JXsJZXTvUOd8nH6CINvePaPkWVR1zNSQ+ykAuEeEumqzj1V9VgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564529; c=relaxed/simple;
	bh=lbmULrqJwsIpfkaAt4Gr1iGAT1Y7QqpeKwhsO1+hb6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0TA5sUClDe5mVIRmt4DbXcHFjTC5U2e1wZyHXJ8xezoGIl2hpodm9HKqVsGNSvnRrvXtdbCoWRcaNe0yh9JRqZl/M/xB27dO6WiXn1DjPQdAKA1mp4X7qtexMVnZg7ndEHD6JZJmHiqzRdySrHIPoT2AqyALxzmwlcHC024ars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=G9HYZzDk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737564521;
	bh=lbmULrqJwsIpfkaAt4Gr1iGAT1Y7QqpeKwhsO1+hb6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9HYZzDkQbF2ruv3fd6q7WdJWeHkG0d9ISIfHgpsRCWb2eUQ3D8c/8GYNWRT7qy0q
	 owidWyPT4W7a5//5je6QuEzHwy/T7PDgzVXNr/KAZwEl7e1w0OsumabmlymTVcyja4
	 slwrR42u37SyNA+HMtd+N+CIJomvP6hOZilzOvVc=
Date: Wed, 22 Jan 2025 17:48:40 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Anna-Maria Gleixner <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>, 
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Cyrill Gorcunov <gorcunov@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] posix-clock: Explicitly handle compat ioctls
Message-ID: <c7abaaf0-3bf4-4c49-b4b2-c0d9914c2dcc@t-8ch.de>
References: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
 <603100b4-3895-4b7c-a70e-f207dd961550@app.fastmail.com>
 <Z5Ebh4pbOUGh64BS@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5Ebh4pbOUGh64BS@hoboy.vegasvil.org>

On 2025-01-22 08:23:35-0800, Richard Cochran wrote:
> On Wed, Jan 22, 2025 at 08:30:51AM +0100, Arnd Bergmann wrote:
> > On Tue, Jan 21, 2025, at 23:41, Thomas Weißschuh wrote:
> > > Pointer arguments passed to ioctls need to pass through compat_ptr() to
> > > work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.
> > > Plumb the compat_ioctl callback through 'struct posix_clock_operations'
> > > and handle the different ioctls cmds in the new ptp_compat_ioctl().
> > >
> > > Using compat_ptr_ioctl is not possible.
> > > For the commands PTP_ENABLE_PPS/PTP_ENABLE_PPS2 on s390
> > > it would corrupt the argument 0x80000000, aka BIT(31) to zero.
> > >
> > > Fixes: 0606f422b453 ("posix clocks: Introduce dynamic clocks")
> > > Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > This looks correct to me,
> 
> I'm not familiar with s390, but I can remember that the compat ioctl
> was nixed during review.

From Documentation/driver-api/ioctl.rst:

	compat_ptr()
	------------

	On the s390 architecture, 31-bit user space has ambiguous representations
	for data pointers, with the upper bit being ignored. When running such
	a process in compat mode, the compat_ptr() helper must be used to
	clear the upper bit of a compat_uptr_t and turn it into a valid 64-bit
	pointer.  On other architectures, this macro only performs a cast to a
	``void __user *`` pointer.

	In an compat_ioctl() callback, the last argument is an unsigned long,
	which can be interpreted as either a pointer or a scalar depending on
	the command. If it is a scalar, then compat_ptr() must not be used, to
	ensure that the 64-bit kernel behaves the same way as a 32-bit kernel
	for arguments with the upper bit set.

	The compat_ptr_ioctl() helper can be used in place of a custom
	compat_ioctl file operation for drivers that only take arguments that
	are pointers to compatible data structures.

TLDR:

If the argument is a pointer, pass it through compat_ptr().
If the argument is a scalar, *do not* pass it through compat_ptr().

If all ioctls handled by a struct file_operations::unlocked_ioctl are
pointers, use .compat_ioctl = compat_ptr_ioctl.
If all ioctls handled by a struct file_operations::unlocked_ioctl are
scalars, use .compat_ioctl = .unlocked_ioctl.
If it's mixed, add a custom handler that knows the details, like this
patch does.

This all assumes the actual data structures are compatible between
compat and non-compat, which is the case here.
If they are not compatible those also need to be converted around.

>    https://lore.kernel.org/lkml/201012161716.42520.arnd@arndb.de/
> 
>    https://lore.kernel.org/lkml/alpine.LFD.2.00.1012161939340.12146@localhost6.localdomain6/
> 
> Can you explain what changed or what was missed?

From your link:

	* I would recommend starting without a compat_ioctl operation if you can.
	Just mandate that all ioctls for posix clocks are compatible and call
	fops->ioctl from the posix_clock_compat_ioctl() function.
	If you ever need compat_ioctl handling, it can still be added later.

The fact that compat_ptr() is necessary for pointer arguments was missed.
And because there are two commands with scalar arguments,
compat_ptr_ioctl() can't be used.


Thomas

