Return-Path: <stable+bounces-172263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA16B30C90
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CAA1C824E8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67528A1D5;
	Fri, 22 Aug 2025 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfVkuIN6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8D1096F
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833338; cv=none; b=Hxo741DdaMSz88kxgvgmrHlZOM+PvAtZtm6lMHk9xT0o+e3AS1bOuYsF/KOokqQX5OUZvwGoZ1pgLphVOTPlu2DRK3CLsKfwCpSHNAV3loeZwsOQGECwVLiTZ4/LHSDsGhbeoU1DV0g6LxeTYn2Ph+aQqW2BR6ww20pXTC77o9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833338; c=relaxed/simple;
	bh=wB3L8reBN8kEzirp8gASddm0oHjQNYTvt88SST0qP10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxv6dnkN8GWNUzTItc/mNfHgmcIEY4WIrvnjoGMUJvbUIDjdUdlP+6kUueORo0HXYQfM0lej3Yr4exMIO5X8PNdeOigTPkcENzpGXTvXo0GD6M32PvidjSBEdfNw0T9MlgndALphbPcf48/dZnpnJ1Q1tKFgJGL0G4KTqoKKzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfVkuIN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB5AC4CEEB;
	Fri, 22 Aug 2025 03:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755833337;
	bh=wB3L8reBN8kEzirp8gASddm0oHjQNYTvt88SST0qP10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfVkuIN6Orvaew3k8AXTLlJXajG1aKeN0207F3ucJanX3bon0GyrFQPZUY2unpga2
	 gMbJ08BKLkJdtbiQvb+SfDOuiOF+DaDEk6RSNo9fp6qBagR6lo5/zz0N10EbBTzoqT
	 RUgOyL/oLPixGxJXG4nWOUFSeOpHzcr8mxtf/2KeiNmovv95w63STXpaufWnqBDy5z
	 x6R7yNF4iW4QDtBO1gJ+BLHEwIpn9eJ8hbc2+DhuOXh7yyTHbyt3zKrs4RAvKgtzzA
	 D81N2WALWZTRneKkWfyvQlTR8SavsPSneDJlB5Rwl4h5KgpNM7yVn+jV+18HylQK+g
	 kLTWFpCBpNL1g==
Date: Thu, 21 Aug 2025 23:28:56 -0400
From: Sasha Levin <sashal@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 6.12.y 4/4] crypto: x86/aegis - Fix sleeping when
 disallowed on PREEMPT_RT
Message-ID: <aKfj-C27OQBWNEMq@laps>
References: <2025082102-shrug-unused-8ce2@gregkh>
 <20250822030617.1053172-1-sashal@kernel.org>
 <20250822030617.1053172-4-sashal@kernel.org>
 <20250822032304.GA80178@quark>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250822032304.GA80178@quark>

On Thu, Aug 21, 2025 at 11:23:04PM -0400, Eric Biggers wrote:
>On Thu, Aug 21, 2025 at 11:06:17PM -0400, Sasha Levin wrote:
>> From: Eric Biggers <ebiggers@kernel.org>
>>
>> [ Upstream commit c7f49dadfcdf27e1f747442e874e9baa52ab7674 ]
>>
>> skcipher_walk_done() can call kfree(), which takes a spinlock, which
>> makes it incorrect to call while preemption is disabled on PREEMPT_RT.
>> Therefore, end the kernel-mode FPU section before calling
>> skcipher_walk_done(), and restart it afterwards.
>>
>> Moreover, pass atomic=false to skcipher_walk_aead_encrypt() instead of
>> atomic=true.  The point of atomic=true was to make skcipher_walk_done()
>> safe to call while in a kernel-mode FPU section, but that does not
>> actually work.  So just use the usual atomic=false.
>>
>> Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
>> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/x86/crypto/aegis128-aesni-glue.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>
>1. Missing Cc of the relevant mailing lists
>2. Missing cover letter

This was sent following the instructions in the FAILED: email generated by
Greg. If you feel its insufficient, take it up with him.

>3. Missing base-commit, and doesn't apply to stable/linux-6.16.y

As the subject line indicates, this applies on 6.12, not 6.16.

>4. Two different series were sent out, both containing this patch

You might have missed that they're for different trees?

>No reason to even take a look at the patch content until it's in a
>reviewable state.

Sure, appologies, please ignore the series.

-- 
Thanks,
Sasha

