Return-Path: <stable+bounces-96016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C739E027F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE7B2592F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292901FDE00;
	Mon,  2 Dec 2024 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MP2rQG+G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF421FCFF5
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142955; cv=none; b=W5u5LBSbOw+SAXHt8ZPLWIqsyLQNle9frnmlKOg/GiMm0BoKwDraqR46TvFfP8s+lnMZlYsp0Ijf7hz3sGFzgbThx3rM9tBAvVpO+E+JBiud3v3ufyL+Fc4w7ob47TrmP/twV/+mroaAswiloSXa7lF9gyapUckGtQTtN2cd0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142955; c=relaxed/simple;
	bh=agtyamKmXmWdf0ntNLxB5H/Guq1l90g4Tr2Qrsjb0j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEPrKv1C039NzIa4pnTeXytn7f2nSELiB0ewaR1pmsgwSUEUfPMF25VFqueuUUgpuFB/Dnbjkz43sTdQ36q1HMtb02DU3TV9DVAZZZhH9YSrjc79TguOiqLq13Fz4zuAmIM63G5GjT/JAT3BHN8FrQYk02bj+v0dpUP7umK9rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MP2rQG+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD20BC4CED1;
	Mon,  2 Dec 2024 12:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733142955;
	bh=agtyamKmXmWdf0ntNLxB5H/Guq1l90g4Tr2Qrsjb0j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MP2rQG+GCbMGg6cgxvnlvY5MgpBD9I1AE1ahEug1LR6wX2wn1CPwfYKKm9YERZy+p
	 kAmER8BuXxdv8LU6cFy8D4GaodR1vVUryiLqJIh9iX+mmp6nd2qTSkrLCr0OxmSdzK
	 GGso/MZGgznlfLvYoaNwjLVLGVbf6X6/SrKAAx+0=
Date: Mon, 2 Dec 2024 13:35:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: drm/amd/display: Pass pwrseq inst for backlight and ABM
Message-ID: <2024120231-untimely-undivided-e1d7@gregkh>
References: <CADnq5_PCqgDS=2Gh3QScfhutgY4wf4hoS15fW5Ox-nziXWGnBg@mail.gmail.com>
 <1733138635@msgid.manchmal.in-ulm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1733138635@msgid.manchmal.in-ulm.de>

On Mon, Dec 02, 2024 at 12:33:48PM +0100, Christoph Biedl wrote:
> Alex Deucher wrote... [ back in January ]
> 
> > Please cherry pick upstream commit b17ef04bf3a4 ("drm/amd/display:
> > Pass pwrseq inst for backlight and ABM") to stable kernel 6.6.x and
> > newer.
> >
> > This fixes broken backlight adjustment on some AMD platforms with eDP panels.
> 
> Hello,
> 
> tl;dr: Was it possible to have this in 6.1.y?
> 
> after a lenghty bisect session it seems[1] this commit b17ef04bf3a4
> ("drm/amd/display: Pass pwrseq inst for backlight and ABM") indeed
> fixes an issue with a HP mt645[2]: Without it, the backlight stays at
> full brightness all the time, writing various values to the usual sysfs
> place has no effect.
> 
> That commit was backported to 6.6.y (as 71be0f674070) but not to 6.1.y -
> which is the series where I'd like to see that issue fixed. However, is
> does not apply, lot of failed hunks and missing files. So I was
> wondering whether it had been skipped deliberately because a backport
> was deemed impossible - or whether it might be doable with some
> more-than-usual effort. In the latter case, I might be willing to do the
> task, but quite frankly, lacking any understanding of what the code
> does, I'd only try to resolve the conflicts and check whether things
> work.
> 
> So I'd be glad if you could give me some insight here: Would it be worth
> the efforts trying to bring this to 6.1.y?

Why not just move to 6.6.y instead?  What's preventing that from
happening?

thanks,

greg k-h

