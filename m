Return-Path: <stable+bounces-135116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2033A96A2F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FB617F2F9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015FB280A38;
	Tue, 22 Apr 2025 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PiyXbNrG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242427F738;
	Tue, 22 Apr 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325324; cv=none; b=Ol3VuuDTpYMJPM5FQzrxU71QIDr00qRQZI42mI6AWuLqyp8JpGPAN36e2ptBLvli5MPuGFMxRdgj/UTGaax3iTbWZILQNU2n5IEi8CdNl5ut7AY6zW8m3TEviG/kXjURLas0Bd2PIpFpTmk2SyHs5D9Sfls9Y+lmr2teBrrc7t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325324; c=relaxed/simple;
	bh=gZqKppOHtV7ov8iWqtSFUMe6Ys3fjEn+8Qllfx6sA8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciJUSdaqT0l8aUH+K5hhcrydo7d7Ti1Zq1K/efhIb4qR1z+vjjuxM492gwWPNjI6A4VgBpPyoNhH31dugmpbUgUXI9qJ29BIwi/6GWf02/XYRF4KpNKkCCxWS27nZs9IA9l1JfJu6mgS9HAyUvcHWLBV1SYHW/aDGBssl5gmXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PiyXbNrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38E9C4CEEA;
	Tue, 22 Apr 2025 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745325324;
	bh=gZqKppOHtV7ov8iWqtSFUMe6Ys3fjEn+8Qllfx6sA8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiyXbNrGpOkhaeB4wzJs5YFHh4npZ3x+8rNG7vkhSvso/TED2d+vrWCIvoR31otVg
	 /JigCaRCRQDTtvN014Oj4kOnzSVmNW5AAPjzNEFA51Jz2jdajQET4gU/fREpv1rIgD
	 5caBkihWmtIZNr5lDWe8JrCLU90wNK30ATjjS5r0=
Date: Tue, 22 Apr 2025 14:35:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: tomasz.pakula.oficjalny@gmail.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashal@kernel.org,
	oleg@makarenk.ooo
Subject: Re: Request for backporting hid-pidff driver patches
Message-ID: <2025042201-cinema-overpay-c3a3@gregkh>
References: <a0f1dae5eee091781711d3b4ebe812b9a1f8c944.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f1dae5eee091781711d3b4ebe812b9a1f8c944.camel@gmail.com>

On Wed, Apr 02, 2025 at 09:21:31PM +0200, tomasz.pakula.oficjalny@gmail.com wrote:
> Hello
> 
> Recently AUTOSEL selected some of out patches to hid-pidff and
> hid-universal-pidff. Though I looked over what was selected and
> everything will be working, I'd like to keep the drivers up-to-date at
> least going back to 6.12 as these kernels are widely used and leaving
> said driers in an incomplete state, not up to upstream might lead to
> some false positive bug reports to me and Oleg.
> 
> Here's the full list of the hid-pidff related patches from upstream. It
> might look like a lot but some granular changes were recorded as the
> driver was in need of an overhaul for at least 10 years. This mainly
> touches just two files.
> 
> I tested it personally and all the patches apply cleanly on top of
> current 6.12.y, 6.13.y and 6.14.y branches.
> 
> Thanks in advance!
> 
> e2fa0bdf08a7 HID: pidff: Fix set_device_control()
> f98ecedbeca3 HID: pidff: Fix 90 degrees direction name North -> East
> 1a575044d516 HID: pidff: Compute INFINITE value instead of using hardcoded 0xffff
> 0c6673e3d17b HID: pidff: Clamp effect playback LOOP_COUNT value
> bbeface10511 HID: pidff: Rename two functions to align them with naming convention
> 1bd55e79cbc0 HID: pidff: Remove redundant call to pidff_find_special_keys
> 9d4174dc4a23 HID: pidff: Support device error response from PID_BLOCK_LOAD
> e19675c24774 HID: pidff: Comment and code style update
> c385f61108d4 HID: hid-universal-pidff: Add Asetek wheelbases support
> 1f650dcec32d HID: pidff: Make sure to fetch pool before checking SIMULTANEOUS_MAX
> 2c2afb50b50f MAINTAINERS: Update hid-universal-pidff entry
> 5d98079b2d01 HID: pidff: Factor out pool report fetch and remove excess declaration
> 217551624569 HID: pidff: Use macros instead of hardcoded min/max values for shorts
> 4eb9c2ee538b HID: pidff: Simplify pidff_rescale_signed
> 0d24d4b1da96 HID: pidff: Move all hid-pidff definitions to a dedicated header
> 22a05462c3d0 HID: pidff: Fix null pointer dereference in pidff_find_fields
> f7ebf0b11b9e HID: pidff: Factor out code for setting gain
> 8713107221a8 HID: pidff: Rescale time values to match field units
> 1c12f136891c HID: pidff: Define values used in pidff_find_special_fields
> e4bdc80ef142 HID: pidff: Simplify pidff_upload_effect function
> cb3fd788e3fa HID: pidff: Completely rework and fix pidff_reset function
> abdbf8764f49 HID: pidff: Add PERIODIC_SINE_ONLY quirk
> 7d3adb9695ec MAINTAINERS: Add entry for hid-universal-pidff driver
> f06bf8d94fff HID: Add hid-universal-pidff driver and supported device ids
> ce52c0c939fc HID: pidff: Stop all effects before enabling actuators
> 3051bf5ec773 HID: pidff: Add FIX_WHEEL_DIRECTION quirk
> 36de0164bbaf HID: pidff: Add hid_pidff_init_with_quirks and export as GPL symbol
> a4119108d253 HID: pidff: Add PERMISSIVE_CONTROL quirk
> fc7c154e9bb3 HID: pidff: Add MISSING_PBO quirk and its detection
> 2d5c7ce5bf4c HID: pidff: Add MISSING_DELAY quirk and its detection
> f538183e997a HID: pidff: Clamp PERIODIC effect period to device's logical range
> 8876fc1884f5 HID: pidff: Do not send effect envelope if it's empty
> 37e0591fe44d HID: pidff: Convert infinite length from Linux API to PID standard

I think Sasha already got all of these, right?  If not, what ones do you
want applied specifically?

thanks,

greg k-h

