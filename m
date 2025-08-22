Return-Path: <stable+bounces-172252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA334B30C81
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122707236D8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5084228A1D5;
	Fri, 22 Aug 2025 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7le5sGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8F22578A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832987; cv=none; b=KCByJ7Qg4kFf1rMhm2MsLHIGx1xtOO2tTeemzLuMKHMSnLltuISVeX7Zx+cif/H+vW8WDkqpSXmvwZaV0JppV0WWFZorteN9j5OCmRLDUeuY1l9ZIExoQFMp+5Ee0sFKhdley7q8QA12dWqjPCX51hXzGjisPRSZeb0uetMUzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832987; c=relaxed/simple;
	bh=hVKaMje8elKNZiqkzbvC21cn5/MH8FXNLXc3z2Is3z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYzl/IirpmJqh2bid3QmysAYEv+b+EpsTnbFj6Me6SaAK4XC6hCkmUX4dB8Btagn9NiOq4hjWnEZjWwNRXTmYWjGunwj8sPzY8R5I2m3yHb+V0U4yxS2TgQK/dATBr79FWxbLV8KR42ZAgx0QvluKsuNsXnI2KH/LlC9UrRffrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7le5sGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562BBC4CEEB;
	Fri, 22 Aug 2025 03:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755832986;
	bh=hVKaMje8elKNZiqkzbvC21cn5/MH8FXNLXc3z2Is3z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7le5sGaP2ePnjzGpuWbw8fTvP9HkugC508rRU9yk2CsWsBRDePvray1b8tBKFVze
	 ke6ZcSjDe7Spc+iP8AspbvYfGREoBWzFBHNWrSV0x7+S8Z7XWIqdWxsfxKpzXCn/2X
	 mgSfML+fczBwMihcFVv6SRGD9R+SdE3TqqG0eFN5ippntHmJdVxC938QrBZWSaCf9o
	 pK+x7ofNuAca7WAKS29iyBjWY+eL2hZzZRVvSLnGrXtssq16fAtto28U2Ql2Yy/u52
	 0ueci77NnRJERLebZg2MWia++gfDXG7ZLqqAh+EC/3hk4JmcOqn98DKy7vjGw5oxuR
	 LaMI0Fd2Rr49Q==
Date: Thu, 21 Aug 2025 23:23:04 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 6.12.y 4/4] crypto: x86/aegis - Fix sleeping when
 disallowed on PREEMPT_RT
Message-ID: <20250822032304.GA80178@quark>
References: <2025082102-shrug-unused-8ce2@gregkh>
 <20250822030617.1053172-1-sashal@kernel.org>
 <20250822030617.1053172-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822030617.1053172-4-sashal@kernel.org>

On Thu, Aug 21, 2025 at 11:06:17PM -0400, Sasha Levin wrote:
> From: Eric Biggers <ebiggers@kernel.org>
> 
> [ Upstream commit c7f49dadfcdf27e1f747442e874e9baa52ab7674 ]
> 
> skcipher_walk_done() can call kfree(), which takes a spinlock, which
> makes it incorrect to call while preemption is disabled on PREEMPT_RT.
> Therefore, end the kernel-mode FPU section before calling
> skcipher_walk_done(), and restart it afterwards.
> 
> Moreover, pass atomic=false to skcipher_walk_aead_encrypt() instead of
> atomic=true.  The point of atomic=true was to make skcipher_walk_done()
> safe to call while in a kernel-mode FPU section, but that does not
> actually work.  So just use the usual atomic=false.
> 
> Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/crypto/aegis128-aesni-glue.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

1. Missing Cc of the relevant mailing lists
2. Missing cover letter
3. Missing base-commit, and doesn't apply to stable/linux-6.16.y
4. Two different series were sent out, both containing this patch

No reason to even take a look at the patch content until it's in a
reviewable state.

- Eric

