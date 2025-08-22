Return-Path: <stable+bounces-172279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAD9B30D13
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E164B635BA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F090285C9F;
	Fri, 22 Aug 2025 03:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4mWK1cD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35E242D95
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834981; cv=none; b=sncOMSi7g+94VXcGw1/vCbhMDP3aoo5gUt1XvyLchw3ZhODotHmIEioLsxS/35Ovo0V0jtEy4W8jlJSbnQbZLjG9zzKARbI0MTwP/uST8lccPYgbxbu9fu3lbgko8mU20CM03EoShnvaIILPKOmP9z0LtHmrUAvaVbNPAHvwaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834981; c=relaxed/simple;
	bh=9Hp83wmclz//uj0hp2AHnHeBBbwGifqnIQuJWtiOWrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EF7XO/p5qfPBFg8yCYlnBC3tZsThra6jrUoguETnJNJ+pL5EU+D8Dv5KZzQRbzcOuf+fDW8SvqFaxL8w8KiU5Ox4cz+NcZ+4VCuKac4uU7VIFgJywKJ0ev+UOm4/hwPTjYAnnZzRLPekAbvy5Hi8JwFqnStSJTl306l6u3NltIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4mWK1cD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B699C113D0;
	Fri, 22 Aug 2025 03:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755834980;
	bh=9Hp83wmclz//uj0hp2AHnHeBBbwGifqnIQuJWtiOWrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4mWK1cDS3asBhfhW3ZzLKZPk5TyPNZ5lASmxYyrNP8czUceoOlG2TorxIu0m65lj
	 26+Qckh3Nxj7PyePViiyVOlIpFw0GWGmtYEgmr4tsVkbDWJv9tJvInA03IqVGdrcxU
	 tkllLw3AxFsyP7RFYvzhWIZkZGElkWCKqXF3VpZpa/7W/e4QNvnsjaa+QSWDNfQRg5
	 9xmBcWrV2kdixO5jjKtDl4PCJvSXCofGxaz85X8uzzEl1yb9dUpMQAFM80KYtKp9RX
	 8ykXYk/rJdkwIRNxfWVDgx6ab86oZ5t7/78RWGIfOJo2Ha8haBi7rhVMPEg7TGTfoR
	 8sveQukEkNIhA==
Date: Thu, 21 Aug 2025 23:56:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 6.12.y 4/4] crypto: x86/aegis - Fix sleeping when
 disallowed on PREEMPT_RT
Message-ID: <aKfqY4fHAuFj_Ry8@laps>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250822033951.GB80178@quark>

On Thu, Aug 21, 2025 at 11:39:51PM -0400, Eric Biggers wrote:
>On Thu, Aug 21, 2025 at 11:28:56PM -0400, Sasha Levin wrote:
>> On Thu, Aug 21, 2025 at 11:23:04PM -0400, Eric Biggers wrote:
>> > On Thu, Aug 21, 2025 at 11:06:17PM -0400, Sasha Levin wrote:
>> > > From: Eric Biggers <ebiggers@kernel.org>
>> > >
>> > > [ Upstream commit c7f49dadfcdf27e1f747442e874e9baa52ab7674 ]
>> > >
>> > > skcipher_walk_done() can call kfree(), which takes a spinlock, which
>> > > makes it incorrect to call while preemption is disabled on PREEMPT_RT.
>> > > Therefore, end the kernel-mode FPU section before calling
>> > > skcipher_walk_done(), and restart it afterwards.
>> > >
>> > > Moreover, pass atomic=false to skcipher_walk_aead_encrypt() instead of
>> > > atomic=true.  The point of atomic=true was to make skcipher_walk_done()
>> > > safe to call while in a kernel-mode FPU section, but that does not
>> > > actually work.  So just use the usual atomic=false.
>> > >
>> > > Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
>> > > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > > ---
>> > >  arch/x86/crypto/aegis128-aesni-glue.c | 8 ++++++--
>> > >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > 1. Missing Cc of the relevant mailing lists
>> > 2. Missing cover letter
>>
>> This was sent following the instructions in the FAILED: email generated by
>> Greg. If you feel its insufficient, take it up with him.
>
>You're one of the stable maintainers.  You can't just deflect and claim
>this is not your problem.

We perform different parts of the process. I don't send FAILED: mails out, I
don't have control over what Greg sends out. If you feel that the recipient
list is insufficient then Greg should be in the loop - don't take it out on me.

These mails looked the same for years (decade+?), if for some reason you think
that a cover letter or an expanded cc list would be useful to have, then you
can just suggest it - no need to berate me for not sending one.

>> > 3. Missing base-commit, and doesn't apply to stable/linux-6.16.y
>>
>> As the subject line indicates, this applies on 6.12, not 6.16.
>>
>> > 4. Two different series were sent out, both containing this patch
>>
>> You might have missed that they're for different trees?
>>
>
>Sorry, I meant to write 6.12.  6.12 was indeed what I tried to apply it
>to, and it failed.  And there are two series for 6.12, see
>https://lore.kernel.org/stable/20250822030632.1053504-4-sashal@kernel.org
>and
>https://lore.kernel.org/stable/20250822030617.1053172-4-sashal@kernel.org/

Yup, those are replies to two different FAILED emails for two different
patches that failed to backport.

Could you share the conflict you've observed? Both series applied cleanly to
stable/linux-6.12.y for me.

>They were sent only 14 seconds apart, so these submissions appear to be
>automated.

Not too automated :)

I fix up the backports, run builds, and go do something else.

When I get back to the computer, if the builds passed, I just send out the mails.

-- 
Thanks,
Sasha

