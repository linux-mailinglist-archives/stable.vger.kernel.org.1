Return-Path: <stable+bounces-89570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8429BA164
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72373281F8E
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E219E990;
	Sat,  2 Nov 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0+ngxKV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D432155336;
	Sat,  2 Nov 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730564776; cv=none; b=YniJ1PTm97YB14eBQB1Twd7/GT8zcHk4u4tafa81wBYqji/5EYxn37O+miATXsRQTpvl50kMeCLLsv8lczI3bAiTEDShEX13bvCJdRj0lAV/aU/X0fe7VBhRpqTrgv7SfVypEEV8Ld/N04Rd/92g8HZjIup6RfODztg1XeR39Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730564776; c=relaxed/simple;
	bh=yunjkn+PFjU9Wb7inK50HBEHgmR/FimcMDdTBrVFDKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiDkZ7k1EsEv0HufTCrbRnA8Tp7ySanaZ42Lzv17SS6YM6BleY0H645jkt1cnfNeaE/6sgm8sKdZk1ocCahkJKdYzxxeXAqrCGgzrekv2UUQ97gQPMwKF34rWgZR9e/2SqHTjV+lDd0e9pY9SV68hDo41PDoV6aw2HlYjmDvaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0+ngxKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2146CC4CEC3;
	Sat,  2 Nov 2024 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730564775;
	bh=yunjkn+PFjU9Wb7inK50HBEHgmR/FimcMDdTBrVFDKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0+ngxKVAEauxsQ1pjt9EUyCMgJpzSjB/zSd3ES/aCU265VRhDFX1Ob1xtlBoDdR4
	 yvRFHITu2g0/q4Nx6KcaciB3kjDzrntM+BfheZzLv+p4mYLgIo0RKGTXIv1HN2w4kz
	 YkbnP/58doyXAukNY1ofYg1680+1zXuxf8uO30R/PY2vUXgUapcrL5PkJNNL/m28vg
	 wAYjHjPaYRadCzKWgQ8Iwt2leuOmBPFTt/aY9popvKjugPKMgTk6xFxDo9lorXpYl+
	 qKfhe7em3FM4HoLBMGN7wsWqENsHKakQvigfIQeDzW8nTJ2rcXEBEPeOtwE8m1+pZe
	 V4cVM+qe0rWjg==
Date: Sat, 2 Nov 2024 17:26:10 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZyZSotlacLgzWxUl@example.org>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
 <ZyU8UNKLNfAi-U8F@google.com>
 <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
 <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>

On Fri, Nov 01, 2024 at 03:44:48PM -0700, Andrei Vagin wrote:
> On Fri, Nov 1, 2024 at 1:58 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> 
> > > Well, personally I'd not use this limit too, but I don't think
> > > "it's broken, userspace shouldn't use it" argument is valid.
> >
> > I said if you don't want the limit don't use it.
> >
> > A version of "Doctor it hurts when I do this". To which the doctor
> > replies "Don't do that then".
> 
> Unfortunately, it isn't an option here. This is a non-root user that
> creates a new user-namespace. It can't change RLIMIT_SIGPENDING
> beyond the current limit.
> 
> We have to distinguish between two types of signals:
> 
> * Kernel signals: These are essential for proper application behavior.
> If a user process triggers a memory fault, it gets SIGSEGV and it can’t
> ignore it. The number of such signals is limited by one per user thread.
> 
> * User signals: These are sent by users and can be blocked by the
> receiving process, potentially leading to a large queue of pending
> signals. This is where the RLIMIT_SIGPENDING limit plays its role in
> preventing excessive resource consumption.
> 
> New user namespaces inherit the current sigpending rlimit, so it is
> expected that  the behavior of the user-namespace limit is aligned with
> the overall RLIMIT_SIGPENDING mechanism.

Hm. I think I understand the problem now.

+Cc Oleg Nesterov.

-- 
Rgrds, legion


