Return-Path: <stable+bounces-172270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D4B30CA9
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69331CE2811
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE4223708;
	Fri, 22 Aug 2025 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1Wkn5/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A16149C51
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833994; cv=none; b=mQliyhkp4WEPZAIJ4xu4q1scp53AVfKRhkVfOGmNYmXf6lAWwtQzWHB1yn3hzmyEGYcXWLhFcCqB+4JyzG+RcRkByFjcrt4qmwCCrTkr409WRpWsgDpVCFKcj62Em+D7dVioPnFx2yS88pPqC7KOBCouXbQAOYcLzolWCKXAgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833994; c=relaxed/simple;
	bh=0ndn9ErCLYbYq32kF5PwwmdLS4zM7/PUlxoWqoh8W98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvDhC/RupvZKf8lOn6f0CxpUsXKMDT3UgFS7BF0aSH0Zc4bGLyAMoSob4zdJmnt1nxRSFfHw5GunmklQSd3C43rcibbimaV0p1TIXYrzkOFxWIOnYGlMuwYYYVgj6BhXPKPy40C1vE78ydD3jOrgymmP5o2kOZmGIVO0YH/JpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1Wkn5/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F41C4CEEB;
	Fri, 22 Aug 2025 03:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755833993;
	bh=0ndn9ErCLYbYq32kF5PwwmdLS4zM7/PUlxoWqoh8W98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1Wkn5/+86mKI51A3qkZ6+ezMG6l/1X/84q1sjNDKeezMg/ArIVlh+aGtQG5GRX/1
	 SUgmow5Ctf407ebY9HuPQHKRBkercmOuYK3WgJ7c7eJqpZRAE7WDx8kWFfGdHinzVF
	 jpEfYmKecE6nOiM5C7dPBt+/J03IbM6RcwhxhvxZ9VkX/70xSgZPTo+vdbif0Ciq1m
	 IcALsa4BykScLAUwKMNcpZTRa3ocnq6+Ho+dnRSYDNg0AIwlX3hJF3FNELFTeZonh2
	 51flSnFzE5GqXuoKHnGgalVuSHu+o6CyOaLQTWhvMRkdlzNU6TcDxMtW1Mm7fSzcuS
	 OnNBbg566ZhjQ==
Date: Thu, 21 Aug 2025 23:39:51 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 6.12.y 4/4] crypto: x86/aegis - Fix sleeping when
 disallowed on PREEMPT_RT
Message-ID: <20250822033951.GB80178@quark>
References: <2025082102-shrug-unused-8ce2@gregkh>
 <20250822030617.1053172-1-sashal@kernel.org>
 <20250822030617.1053172-4-sashal@kernel.org>
 <20250822032304.GA80178@quark>
 <aKfj-C27OQBWNEMq@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKfj-C27OQBWNEMq@laps>

On Thu, Aug 21, 2025 at 11:28:56PM -0400, Sasha Levin wrote:
> On Thu, Aug 21, 2025 at 11:23:04PM -0400, Eric Biggers wrote:
> > On Thu, Aug 21, 2025 at 11:06:17PM -0400, Sasha Levin wrote:
> > > From: Eric Biggers <ebiggers@kernel.org>
> > > 
> > > [ Upstream commit c7f49dadfcdf27e1f747442e874e9baa52ab7674 ]
> > > 
> > > skcipher_walk_done() can call kfree(), which takes a spinlock, which
> > > makes it incorrect to call while preemption is disabled on PREEMPT_RT.
> > > Therefore, end the kernel-mode FPU section before calling
> > > skcipher_walk_done(), and restart it afterwards.
> > > 
> > > Moreover, pass atomic=false to skcipher_walk_aead_encrypt() instead of
> > > atomic=true.  The point of atomic=true was to make skcipher_walk_done()
> > > safe to call while in a kernel-mode FPU section, but that does not
> > > actually work.  So just use the usual atomic=false.
> > > 
> > > Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  arch/x86/crypto/aegis128-aesni-glue.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > 1. Missing Cc of the relevant mailing lists
> > 2. Missing cover letter
> 
> This was sent following the instructions in the FAILED: email generated by
> Greg. If you feel its insufficient, take it up with him.

You're one of the stable maintainers.  You can't just deflect and claim
this is not your problem.

> > 3. Missing base-commit, and doesn't apply to stable/linux-6.16.y
> 
> As the subject line indicates, this applies on 6.12, not 6.16.
> 
> > 4. Two different series were sent out, both containing this patch
> 
> You might have missed that they're for different trees?
> 

Sorry, I meant to write 6.12.  6.12 was indeed what I tried to apply it
to, and it failed.  And there are two series for 6.12, see
https://lore.kernel.org/stable/20250822030632.1053504-4-sashal@kernel.org
and
https://lore.kernel.org/stable/20250822030617.1053172-4-sashal@kernel.org/
They were sent only 14 seconds apart, so these submissions appear to be
automated.

- Eric

