Return-Path: <stable+bounces-172277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15751B30CE2
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48AF1CE3968
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1EC223DED;
	Fri, 22 Aug 2025 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JutM7h9D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80821D3F5
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834512; cv=none; b=R0Z1IqsPZDJf2WnoBopRqflAF6u4mCpx+LkkHTzeGIy9kwmgDiqNk/qjQm/7AFzko+iLBxbH2KluP+vUQYmCKZ6hHiCfDg6mZzp17QBOjtQbqbUyXqTPHfs6b2/uADQmCmTK+xCisaQHIKGsgv8x2ppkb1WL0sti0uMsjwzRQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834512; c=relaxed/simple;
	bh=fAJPS5Or1nkS0CMWlrpDllfTmGP7MYtR6Z7n6JlTRBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxJ4Vkn+YMaPAak4qdt+iOkhAQRalPb5xe4T4RZ7vS1IuAS/5FG+kcN3B4MqpndRlwEA3OjsjzIcyxsirzOY/qAHeq6en91bLC4jcyr8ngV5KpH636PMHFA3U7B+IBogpi80PcWYkVguHXFMSwUMg04FeChnQFBCh2DTrtiWvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JutM7h9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF09C4CEF1;
	Fri, 22 Aug 2025 03:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755834511;
	bh=fAJPS5Or1nkS0CMWlrpDllfTmGP7MYtR6Z7n6JlTRBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JutM7h9D5zE7rAL227xXCfB9sSEHXLNvaMcQC7i7ugrWKENFWghOQIEIL6QQHTKGJ
	 +72S1qn/w2pPpacuaNsRz22vhtbgjo5KmKqBx3fyvSYDSupX+NHrJgofCsBRXPML2d
	 PNwYSyRk6o48EhX+IdLSNVjWOTjmHniH/JUw6cewvWWe46/VSepZowmVtXJj79/FVn
	 2nMYCNFBdgpZwp2hhjbLJZWxAvQ+npzmkrJP+yX5HiKOYmSqUFfyOsSosPTss7u0vG
	 8a06YvGvgPJ544HtKZfcIMiZuT7FrzIVF+mnKACGpAObzXRIlw7wOfMDTCZk1W9U76
	 UAXx6Aj9/WqNA==
Date: Thu, 21 Aug 2025 23:48:29 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 6.12.y 4/4] crypto: x86/aegis - Fix sleeping when
 disallowed on PREEMPT_RT
Message-ID: <20250822034829.GC80178@quark>
References: <2025082102-shrug-unused-8ce2@gregkh>
 <20250822030617.1053172-1-sashal@kernel.org>
 <20250822030617.1053172-4-sashal@kernel.org>
 <20250822032304.GA80178@quark>
 <aKfj-C27OQBWNEMq@laps>
 <20250822033951.GB80178@quark>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822033951.GB80178@quark>

On Thu, Aug 21, 2025 at 11:39:53PM -0400, Eric Biggers wrote:
> On Thu, Aug 21, 2025 at 11:28:56PM -0400, Sasha Levin wrote:
> > On Thu, Aug 21, 2025 at 11:23:04PM -0400, Eric Biggers wrote:
> > > On Thu, Aug 21, 2025 at 11:06:17PM -0400, Sasha Levin wrote:
> > > > From: Eric Biggers <ebiggers@kernel.org>
> > > > 
> > > > [ Upstream commit c7f49dadfcdf27e1f747442e874e9baa52ab7674 ]
> > > > 
> > > > skcipher_walk_done() can call kfree(), which takes a spinlock, which
> > > > makes it incorrect to call while preemption is disabled on PREEMPT_RT.
> > > > Therefore, end the kernel-mode FPU section before calling
> > > > skcipher_walk_done(), and restart it afterwards.
> > > > 
> > > > Moreover, pass atomic=false to skcipher_walk_aead_encrypt() instead of
> > > > atomic=true.  The point of atomic=true was to make skcipher_walk_done()
> > > > safe to call while in a kernel-mode FPU section, but that does not
> > > > actually work.  So just use the usual atomic=false.
> > > > 
> > > > Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  arch/x86/crypto/aegis128-aesni-glue.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > 1. Missing Cc of the relevant mailing lists
> > > 2. Missing cover letter
> > 
> > This was sent following the instructions in the FAILED: email generated by
> > Greg. If you feel its insufficient, take it up with him.
> 
> You're one of the stable maintainers.  You can't just deflect and claim
> this is not your problem.
> 
> > > 3. Missing base-commit, and doesn't apply to stable/linux-6.16.y
> > 
> > As the subject line indicates, this applies on 6.12, not 6.16.
> > 
> > > 4. Two different series were sent out, both containing this patch
> > 
> > You might have missed that they're for different trees?
> > 
> 
> Sorry, I meant to write 6.12.  6.12 was indeed what I tried to apply it
> to, and it failed.  And there are two series for 6.12, see
> https://lore.kernel.org/stable/20250822030632.1053504-4-sashal@kernel.org
> and
> https://lore.kernel.org/stable/20250822030617.1053172-4-sashal@kernel.org/
> They were sent only 14 seconds apart, so these submissions appear to be
> automated.
> 

Anyway, until someone can get this sent out properly, consider it:

Nacked-by: Eric Biggers <ebiggers@kernel.org>

for all trees.

- Eric

