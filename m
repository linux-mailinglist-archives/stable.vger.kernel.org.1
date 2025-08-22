Return-Path: <stable+bounces-172280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C8AB30D67
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0784C3AD548
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40026CE2A;
	Fri, 22 Aug 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7mS0/9R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A56221F06
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835856; cv=none; b=B4/nF+8NVB7BOz4kxcCi54Q39TEGAksPQC1X8gFtyARbByqm8jkuEHkr9IXSKJkx816jfJcajEHy5LWA+jVHseM8QNNeP+80yqB1ivL07UQ8w8SEkEzVTtoG5mLdq6DeDypNctmFnki2Bgwy/ZbvjUJ0PckJJFoO4ARyFwU0ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835856; c=relaxed/simple;
	bh=VT0fBYlcmQdC9+gRPQFAsjfVP9w+rEuQqyMKfAqu9fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey6zXiyTuto9ij79hG+6hz9Js0pl5WHSQvEWscI364HJQAREzTO8CLZwQq5DHv4vCC8deU06yIp4ok7YnaT73lwEudBXGokURHvVUsxmJ1SSdk2Usgi7WXK1WgVcxDT1ffvTIP6rRqA76cqBJyAlKkOxIIWr0lPd1adjshyWnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7mS0/9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836A1C4CEF1;
	Fri, 22 Aug 2025 04:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755835855;
	bh=VT0fBYlcmQdC9+gRPQFAsjfVP9w+rEuQqyMKfAqu9fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7mS0/9RJtgC3paKsImzOiAzOjLSk8ZWRE7txLzbWig4xS+tfOKkK+cfoLUTNVoxW
	 W2b+Tktu0tA/AYXUPgDw2e+DeyhhbijakmnCjXYoe+ffQKSmLUi0iA2EBxHHDdWQlS
	 bwZf01y3ejB8HchSejZ9GQpkudK+zs60ZFvRV4xVgYf9rPZmuEqy9cUki/MgiPpCiT
	 KmltKs01BcNnQ2wUNgNisunKDwlOqhBGU+fgb6E4XhbPr3BpLSoStMWsRmDAZwjfcd
	 /4nLaxQBwFgPebGCK5sMnwT7PYv8jVBqr45WbFNmnQzJwl7KsU03JiGjqTpTfHON0H
	 RC/GhLYcqwk0g==
Date: Fri, 22 Aug 2025 00:10:53 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 6.12.y 4/4] crypto: x86/aegis - Fix sleeping when
 disallowed on PREEMPT_RT
Message-ID: <20250822041053.GD80178@quark>
References: <2025082102-shrug-unused-8ce2@gregkh>
 <20250822030617.1053172-1-sashal@kernel.org>
 <20250822030617.1053172-4-sashal@kernel.org>
 <20250822032304.GA80178@quark>
 <aKfj-C27OQBWNEMq@laps>
 <20250822033951.GB80178@quark>
 <aKfqY4fHAuFj_Ry8@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKfqY4fHAuFj_Ry8@laps>

On Thu, Aug 21, 2025 at 11:56:19PM -0400, Sasha Levin wrote:
> On Thu, Aug 21, 2025 at 11:39:51PM -0400, Eric Biggers wrote:
> > On Thu, Aug 21, 2025 at 11:28:56PM -0400, Sasha Levin wrote:
> > > On Thu, Aug 21, 2025 at 11:23:04PM -0400, Eric Biggers wrote:
> > > > On Thu, Aug 21, 2025 at 11:06:17PM -0400, Sasha Levin wrote:
> > > > > From: Eric Biggers <ebiggers@kernel.org>
> > > > >
> > > > > [ Upstream commit c7f49dadfcdf27e1f747442e874e9baa52ab7674 ]
> > > > >
> > > > > skcipher_walk_done() can call kfree(), which takes a spinlock, which
> > > > > makes it incorrect to call while preemption is disabled on PREEMPT_RT.
> > > > > Therefore, end the kernel-mode FPU section before calling
> > > > > skcipher_walk_done(), and restart it afterwards.
> > > > >
> > > > > Moreover, pass atomic=false to skcipher_walk_aead_encrypt() instead of
> > > > > atomic=true.  The point of atomic=true was to make skcipher_walk_done()
> > > > > safe to call while in a kernel-mode FPU section, but that does not
> > > > > actually work.  So just use the usual atomic=false.
> > > > >
> > > > > Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > > > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > > ---
> > > > >  arch/x86/crypto/aegis128-aesni-glue.c | 8 ++++++--
> > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > 1. Missing Cc of the relevant mailing lists
> > > > 2. Missing cover letter
> > > 
> > > This was sent following the instructions in the FAILED: email generated by
> > > Greg. If you feel its insufficient, take it up with him.
> > 
> > You're one of the stable maintainers.  You can't just deflect and claim
> > this is not your problem.
> 
> We perform different parts of the process. I don't send FAILED: mails out, I
> don't have control over what Greg sends out. If you feel that the recipient
> list is insufficient then Greg should be in the loop - don't take it out on me.
> 
> These mails looked the same for years (decade+?), if for some reason you think
> that a cover letter or an expanded cc list would be useful to have, then you
> can just suggest it - no need to berate me for not sending one.

I've given this same feedback many times already.

> > > > 3. Missing base-commit, and doesn't apply to stable/linux-6.16.y
> > > 
> > > As the subject line indicates, this applies on 6.12, not 6.16.
> > > 
> > > > 4. Two different series were sent out, both containing this patch
> > > 
> > > You might have missed that they're for different trees?
> > > 
> > 
> > Sorry, I meant to write 6.12.  6.12 was indeed what I tried to apply it
> > to, and it failed.  And there are two series for 6.12, see
> > https://lore.kernel.org/stable/20250822030632.1053504-4-sashal@kernel.org
> > and
> > https://lore.kernel.org/stable/20250822030617.1053172-4-sashal@kernel.org/
> 
> Yup, those are replies to two different FAILED emails for two different
> patches that failed to backport.

But why send a separate series for each one, with duplicate patches
across the different series?  That makes no sense.

> Could you share the conflict you've observed? Both series applied cleanly to
> stable/linux-6.12.y for me.

Try:

    b4 am https://lore.kernel.org/stable/20250822030632.1053504-1-sashal@kernel.org/

It looks like the problem may be that b4 picks up the patch from the
FAILED email as a patch in the series.

Please make sure that the way you're sending out patch series is
compatible with b4, as reviewers often rely on that to download them.

- Eric

