Return-Path: <stable+bounces-194604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA8C51D41
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 12:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF90F3A3D7E
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439562FDC5B;
	Wed, 12 Nov 2025 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwGnzPdo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384B223DD6;
	Wed, 12 Nov 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945084; cv=none; b=SdhNfOmAEdJ2jzGEPDcdNjj5Pw3g6k9aLJtzSksEWhzB7NEje6b15uuzSLCES4EwbejUadOFirueRgvFu0vNoaKImqUowcZBh44gGnDRso8kAsG1VUoTdW3csZssZw9+sxsSillhnqn1ZhVIs/OwYvN0NjkdClYQvDSp1wTjoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945084; c=relaxed/simple;
	bh=c0MJyFQfofT+kLIzHC2PGnpq2h6txKRkt+1J0lXD9+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZo650GWRbSP0ph4jT6Sz8V6dfjc6qm1tW2yrwZjSNIt3RRIqBC6I1/aBNWAieEi87VU7+QvTgjTL5QFVHUrq9TBLiHTc7BbY3ijkATJfHZDPxs01Mp4p+VntqvXtfyIgkbUviscxQerkkIkMC31Xxo08akAD3i2AktiSFnJEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwGnzPdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ED2C4CEF5;
	Wed, 12 Nov 2025 10:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762945083;
	bh=c0MJyFQfofT+kLIzHC2PGnpq2h6txKRkt+1J0lXD9+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwGnzPdoaXDdrScj7SpEr3SZ4JVT6cuk3jD1zH3WrwTA6AInM6Crqo2SniuQiDe0m
	 GBC2Y00cPtuEwGcXrC2c4UTOUZQIVhNUIujSq1mzfs1fKqke5hz8TjdjHsrETMUmQZ
	 55oMoW7S/9G3DpI50RQwz0QY8wos70+Z0l9PyP80FPehhWoz2VnZcleOjB0zOKKhEB
	 J2erslHXUqlsD4BdQ23Zik3oyIlBhKf0OhS4qam4ASU1uxfxej6KPLM3Dky5xRtwBT
	 LLpEgI4E/4aCT37L1S++8pWlklcORXY+Mw3NsiaC2Tzc6/q8ry3DknSXyUlArZNSfe
	 HgWP9IokuRl2g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vJ8Y7-0000000025s-0mJO;
	Wed, 12 Nov 2025 11:58:03 +0100
Date: Wed, 12 Nov 2025 11:58:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
Message-ID: <aRRoO5mXbH9eg0fE@hovoldconsulting.com>
References: <20251017054943.7195-1-johan@kernel.org>
 <7ad2b976-3b0d-4823-a145-ceedf071450d@linaro.org>
 <aRH74auttb6UgnjP@hovoldconsulting.com>
 <3c2dee38-46a8-4359-b981-d4e3d53061fe@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c2dee38-46a8-4359-b981-d4e3d53061fe@linaro.org>

On Wed, Nov 12, 2025 at 10:57:21AM +0100, Daniel Lezcano wrote:
> On 11/10/25 15:51, Johan Hovold wrote:

> > On Wed, Nov 05, 2025 at 02:32:18PM +0100, Daniel Lezcano wrote:
> > 
> >> You should replace __init by __init_or_module
> > 
> > That's not sufficient as the driver can still be rebound through sysfs
> > currently (the driver would probably crash anyway, but that's a separate
> > issue).
> > 
> > Also note that no drivers use __init_or_module these days, likely as
> > everyone uses modules and it's not worth the added complexity in trying
> > to get the section markers right for a build configuration that few
> > people care about.
> > 
> > I can send a follow-on patch to suppress the unbind attribute, or
> > include it in a v2 if you insist on using __init_or_module.
> > 
> > What do you prefer?
> 
> I think it makes sens to use __init_or_module because these drivers have 
> been always compiled in and we are converting them into modules.

That's not really relevant. __init_or_module will only save a tiny bit
of memory in builds where modules are completely disabled
(i.e. !CONFIG_MODULES) which is hardly used any more.

Note that it has nothing to do with whether this particular driver is
built as a module or not.

And since no other drivers cares about this uncommon case, are you sure
you want to do this here?

Note that this would also require suppressing section mismatch warnings
for the common case (CONFIG_MODULES).

Johan

