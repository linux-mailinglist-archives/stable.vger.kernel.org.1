Return-Path: <stable+bounces-201016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE8CBD19B
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 836AC3016997
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6E3148B4;
	Mon, 15 Dec 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uisQV9Ij"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB9017C220
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765789552; cv=none; b=m0gMqHBnqsBMgtET42vWdwwcnAxiAz77cwnHEXBcME94UmF37M+Fbk5VsrY+TX3ECCgRXcpdEj3+4GHzvTf4MWGYtP4bpeSgEEFIVEKke75fh2gnvwAKTfoqOfu2KJqtMTDNg5YIZC731xvVJpJ4lrvuwoijbG8m9BNdy1BB4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765789552; c=relaxed/simple;
	bh=0yOPKOALnmrcL2CF4UYHsweuR/AFn0IIZZy/VPrBDoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXNIZsA23o1LOCS/ZCajDV4Nm8JzNV5iP5M9wAintDRF1qnKi/r76452+GXbVtBHBbhUoWWwwlQL0q0tNGQY5j6OH1+hM5jyurHm5GVPVU3ENBGI2Te/ZrQQozcWUbYjtt90G9Yd7+4arMod5RchLGWw/3a4wSt4/Z2fOg3t4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uisQV9Ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7A2C4CEF5;
	Mon, 15 Dec 2025 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765789551;
	bh=0yOPKOALnmrcL2CF4UYHsweuR/AFn0IIZZy/VPrBDoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uisQV9Ij9wnFL7pcyM/1AkfHr0HWalBPd72aHx9wK+h04yC9bNRnuE3AFzsyfrUKJ
	 YqjAFJnAw+q9MpMfSoUBkc/Uqobb+YR21efLuXoGMI7CLnWJ/cNs3j0FIajU7T/4hN
	 C228v6Rp7ecEVSXiYDXfbHi4ctgfvFyaK1x6Qvy0=
Date: Mon, 15 Dec 2025 10:05:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
	Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't attach the tlb fence for SI
Message-ID: <2025121500-portside-coleslaw-915b@gregkh>
References: <20251214095336.224610-1-johannes.goede@oss.qualcomm.com>
 <2025121502-amenity-ragged-720c@gregkh>
 <b78aadb1-d2ca-459c-8078-b1cd9a500398@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b78aadb1-d2ca-459c-8078-b1cd9a500398@oss.qualcomm.com>

On Mon, Dec 15, 2025 at 09:15:17AM +0100, Hans de Goede wrote:
> Hi greg,
> 
> On 15-Dec-25 9:12 AM, Greg KH wrote:
> > On Sun, Dec 14, 2025 at 10:53:36AM +0100, Hans de Goede wrote:
> >> From: Alex Deucher <alexander.deucher@amd.com>
> >>
> >> commit eb296c09805ee37dd4ea520a7fb3ec157c31090f upstream.
> >>
> >> SI hardware doesn't support pasids, user mode queues, or
> >> KIQ/MES so there is no need for this.  Doing so results in
> >> a segfault as these callbacks are non-existent for SI.
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
> >> Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs update")
> >> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > What kernel tree(s) should this go to?
> 
> This fixes a regression introduced in at least 6.17.y (6.17.11)
> and 6.18.y (6.18.1). So it should at least go to those branches.

But that commit is in 6.19-rc1, not anything older.

> If any other branches also have gotten commit f3854e04b708
> backported then those should get this too.

I don't see that commit in any stable tree, what am I missing?

confused,

greg k-h

