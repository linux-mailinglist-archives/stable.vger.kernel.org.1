Return-Path: <stable+bounces-118637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454BCA40058
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 21:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C0D422E9E
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9201FCD0B;
	Fri, 21 Feb 2025 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfRhUm+7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98A45948
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168346; cv=none; b=C4B9nHHr48uQPHdWTqRyEiUaFLyj4FNPgeLLq0BONsOaD3iCuoIx/TPM8xbAPyXPyss3d91hidH3ab5rl/LvWbRvZ7L2TGoLGU4vEcJOnhFmboSFFlJqldgAyQd5L1CxLL2etLz3SYiNGFgqlSx84zUr9MbR2P49nvQhwvZIcoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168346; c=relaxed/simple;
	bh=mN4cTuznIzq0DSMIO5ggGxbIdKYQcDa/bztA1gNW/C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APadRCS3Alhz8+GR47fwLUxNKBJgbYKndETRNOOLdqVoY9HE8bKMLYepxj/uc6ngvb3nzb7SleDXAxGA15/qxC3N2Ia0rAu/JTkMP8Uj9vQSvbgbePGqwOx9i/+k8clBHjt+3gUj0jL/iQjt1xQimh1ijUfJ8MHLNwvvq57sWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfRhUm+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAC8C4CEE4;
	Fri, 21 Feb 2025 20:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740168346;
	bh=mN4cTuznIzq0DSMIO5ggGxbIdKYQcDa/bztA1gNW/C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfRhUm+7oPMCYRFHDzT/UO/Rld4kFdGfyKKQbUBB/HNaF7o3NW6stseu3Ny1Tc3DF
	 XMtMohq948+pD3Fuvzg6b1ICREAHuupBTs1OEO+mFdeSmOPQoJs0xObTM36v1kMtBS
	 i0Nsw+haegQ8fXA5BFUzHWKXhburT6FUXYcOdR6kHTCOXUkxHXICM2hTty3jQ8CYS+
	 9kYxAekpn8FHa2fO29IB7EQYPUJrbKLV68XmgUmO0hwdlWCnfrUcQpCaU6i1+4nkg+
	 zFxzhXLUlKRDbKG25rk8EXH/vOI5bYwRTQJgWdsbuRDUfZmY9Z36Q0qSyt0zQqTXs8
	 uOxBthkFrQdjQ==
Date: Fri, 21 Feb 2025 15:05:42 -0500
From: Sasha Levin <sashal@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] batman-adv: Drop unmanaged ELP metric worker
Message-ID: <Z7jclt4dEDLWc0te@lappy>
References: <20250219165644-edb7cfac3c0ce091@stable.kernel.org>
 <1939631.tdWV9SEqCh@sven-l14>
 <3614082.iIbC2pHGDl@ripper>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3614082.iIbC2pHGDl@ripper>

On Fri, Feb 21, 2025 at 07:32:30PM +0100, Sven Eckelmann wrote:
>On Wednesday, 19 February 2025 23:38:33 CET Sven Eckelmann wrote:
>> On Wednesday, 19 February 2025 23:09:58 GMT+1 Sasha Levin wrote:
>> > [ Sasha's backport helper bot ]
>> >
>> > Hi,
>> >
>> > Summary of potential issues:
>> > ❌ Build failures detected
>> >
>> > The upstream commit SHA1 provided is correct: 8c8ecc98f5c65947b0070a24bac11e12e47cc65d
>> >
>> >
>> > Status in newer kernel trees:
>> > 6.13.y | Present (different SHA1: 7350aafa40a7)
>> > 6.12.y | Present (different SHA1: c09f874f226b)
>> > 6.6.y | Present (different SHA1: c8db60b2a7fd)
>> > 6.1.y | Present (different SHA1: 831dda93b13c)
>> > 5.15.y | Present (different SHA1: 72203462f255)
>> > 5.4.y | Not found
>> >
>> > Note: The patch differs from the upstream commit:
>> > ---
>> > Failed to apply patch cleanly.
>>
>>
>> Was this patch applied with or without the already queued up patches from
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.10 ?
>> They are required for this patch to apply correctly.
>
>Ok, now it will definitely fail because you've added your own backport..

Ah, sorry, the bot only tests against "vanilla" -stable releases.

I had a backport queued up which brought in a dependency rather than
changing the original commit, does it make sense in this case? I think
it'll make future backports easier.

-- 
Thanks,
Sasha

