Return-Path: <stable+bounces-8265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB081BCAD
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 18:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8FE287567
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6365990D;
	Thu, 21 Dec 2023 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+K2IkfW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229E62803;
	Thu, 21 Dec 2023 17:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5613FC433C8;
	Thu, 21 Dec 2023 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178712;
	bh=wGxfU3cYAyfRf9pobVG8mBWcniCrAKbyXU8GosW2aNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+K2IkfW54ig2qFYEJPu/Fn+/lf43RAmGp6Or8UlxVjKHDqEZiI5FqdLpBiGXTBmN
	 62PO470CPM7K6KWbwi8GBgT1dtxtiAj319Fz4ZtU8IJcuTkaJghhY53JbnfYrS5kkF
	 ZH3fFb26FEEl9++CH5at5Hmvdmi8o7VeHq4bHMdfEaMAnZgALNvmTKj2KZs+XeD8SG
	 xzkyyP9xrM0KJODfWrBNtG/y+NxZkql+gj5aTBX4VBKRpp6Pj7t2xC+8h0o/EvKTsn
	 FmmNNZyHrfzHM1ihwE5pNU/OQ/OVobsECvqckkTaV5FazZ/zlPONBnEnjtxYXATVhV
	 yqxoKW2poMjlA==
From: SeongJae Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org,
	stable-commits@vger.kernel.org,
	sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: Patch "mm/damon/core: use number of passed access sampling as a timer" has been added to the 6.6-stable tree
Date: Thu, 21 Dec 2023 17:11:50 +0000
Message-Id: <20231221171150.45526-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221145301.1548807-1-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha,


Thank you for picking this patch.

On Thu, 21 Dec 2023 09:53:01 -0500 Sasha Levin <sashal@kernel.org> wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     mm/damon/core: use number of passed access sampling as a timer
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mm-damon-core-use-number-of-passed-access-sampling-a.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit dfda8d41e94ee98ebd2ad78c7cb49625a8c92474
> Author: SeongJae Park <sj@kernel.org>
> Date:   Thu Sep 14 02:15:23 2023 +0000
> 
>     mm/damon/core: use number of passed access sampling as a timer
> 
>     [ Upstream commit 4472edf63d6630e6cf65e205b4fc8c3c94d0afe5 ]
> 
>     DAMON sleeps for sampling interval after each sampling, and check if the
>     aggregation interval and the ops update interval have passed using
>     ktime_get_coarse_ts64() and baseline timestamps for the intervals.  That
>     design is for making the operations occur at deterministic timing
>     regardless of the time that spend for each work.  However, it turned out
>     it is not that useful, and incur not-that-intuitive results.
> 
>     After all, timer functions, and especially sleep functions that DAMON uses
>     to wait for specific timing, are not necessarily strictly accurate.  It is
>     legal design, so no problem.  However, depending on such inaccuracies, the
>     nr_accesses can be larger than aggregation interval divided by sampling
>     interval.  For example, with the default setting (5 ms sampling interval
>     and 100 ms aggregation interval) we frequently show regions having
>     nr_accesses larger than 20.  Also, if the execution of a DAMOS scheme
>     takes a long time, next aggregation could happen before enough number of
>     samples are collected.  This is not what usual users would intuitively
>     expect.
> 
>     Since access check sampling is the smallest unit work of DAMON, using the
>     number of passed sampling intervals as the DAMON-internal timer can easily
>     avoid these problems.  That is, convert aggregation and ops update
>     intervals to numbers of sampling intervals that need to be passed before
>     those operations be executed, count the number of passed sampling
>     intervals, and invoke the operations as soon as the specific amount of
>     sampling intervals passed.  Make the change.
> 
>     Note that this could make a behavioral change to settings that using
>     intervals that not aligned by the sampling interval.  For example, if the
>     sampling interval is 5 ms and the aggregation interval is 12 ms, DAMON
>     effectively uses 15 ms as its aggregation interval, because it checks
>     whether the aggregation interval after sleeping the sampling interval.
>     This change will make DAMON to effectively use 10 ms as aggregation
>     interval, since it uses 'aggregation interval / sampling interval *
>     sampling interval' as the effective aggregation interval, and we don't use
>     floating point types.  Usual users would have used aligned intervals, so
>     this behavioral change is not expected to make any meaningful impact, so
>     just make this change.
> 
>     Link: https://lkml.kernel.org/r/20230914021523.60649-1-sj@kernel.org
>     Signed-off-by: SeongJae Park <sj@kernel.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Stable-dep-of: 6376a8245956 ("mm/damon/core: make damon_start() waits until kdamond_fn() starts")

I think adding this patch on 6.6.y has no problem.  Nonetheless, Greg notified
me the patch that depends on this ("mm/damon/core: make damon_start() waits
until kdamond_fn() starts") cannot cleanly applied on 6.1.y and 6.6.y[1,2], and
hence I sent conflict-resolved patches for those[3,4] before.

Hence this patch might not really required, but I also think adding this now
might help merging future fixes.  I don't have strong opinion on whether this
patch should be added to 6.6.y or not.  I hope you to select a way that better
for minimizing stable kernels maintenance overhead.

[1] https://lore.kernel.org/stable/2023121849-ambulance-violate-e5b2@gregkh/
[2] https://lore.kernel.org/stable/2023121843-pension-tactile-868b@gregkh/
[3] https://lore.kernel.org/r/20231218175939.99263-1-sj@kernel.org
[4] https://lore.kernel.org/r/20231218175959.99278-1-sj@kernel.org


Thanks,
SJ

[...]

