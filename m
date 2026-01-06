Return-Path: <stable+bounces-204985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF6CF63ED
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF9B13007660
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DFF4AEE2;
	Tue,  6 Jan 2026 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcDvwU7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5D2AD16
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767662729; cv=none; b=nB28T5lj8EUG8r9v/w7Fwo3Nbg5BXlQ4FLV2FAt+m1a0//b5qXs0cNlWBZVqUNo52SVlIesFmws9mrzdHHKE0pj4NOk5EQyaQHfCWRH0k7+ddC0UKT0vCWB7yKfoAHgN6qu7AnzODESnjRxvZZ150QZBx23gcs/kD49usYaYHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767662729; c=relaxed/simple;
	bh=c8Ld0TNPX2MXWRBakdnMdX4KAWmxlJY4ds2bjsJwJxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIdD275t+oe9i7uD9pqvYR8VGtkcx5qVH7ONJiWjHN+M5P9yfQOUMUA8tPA8bMkE7m94mnzESSSpjKzjtGjrqyjiSrvWkQKuOaDPdHSr4MFvcK35mMZon6jlwEfOoyULiWQwMXVGKE/t275H/sLNpKF0pjh/D6rDAoS37ibr/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcDvwU7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDB2C116D0;
	Tue,  6 Jan 2026 01:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767662728;
	bh=c8Ld0TNPX2MXWRBakdnMdX4KAWmxlJY4ds2bjsJwJxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pcDvwU7KvnWVtE4Z78XHLcOuN5bEHmDWAi+96C7imrPj/hhn2uRe0HbdwPS1DPl7F
	 LqSgTv+/ny41ujIJBQlNwPCKdopHpwRjj1G/UDEI+1awFZBcqpeLLbhQSaem+Xl2J9
	 af3giYqv9VNhdsBCauJKVdjRSTJW6u6RO+MYca9Uznr6o5Vjk3oDN1oMdfmjURKek/
	 iBDCZ9wjGcDDU9ZGrHRCSyZrxuEr7v2mDTolY/gBpOC86zO6SZppOWJRUENkDMwo/0
	 e5v5j/UHxhopZGhSeZq1dPzb2Mtr+GSXUgJQ1vYst2BJ8/l2KpRX9KfEMZtG9T2EfG
	 CHtIWi7qUyTDw==
From: SeongJae Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@google.com,
	stable@vger.kernel.org,
	wangkefeng.wang@huawei.com
Subject: Re: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures on" failed to apply to 6.6-stable tree
Date: Mon,  5 Jan 2026 17:25:20 -0800
Message-ID: <20260106012521.269030-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010533-uncounted-stuffing-5fb6@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Jan 2026 12:05:33 +0100 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 6.6-stable tree.
[...]
> ------------------ original commit in Linus's tree ------------------
> 
> >From eded254cb69044bd4abde87394ea44909708d7c0 Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Sat, 1 Nov 2025 11:20:02 -0700
> Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures on
>  damon_test_split_regions_of()
> 
> damon_test_split_regions_of() is assuming all dynamic memory allocation in
> it will succeed.  Those are indeed likely in the real use cases since
> those allocations are too small to fail, but theoretically those could
> fail.  In the case, inappropriate memory access can happen.  Fix it by
> appropriately cleanup pre-allocated memory and skip the execution of the
> remaining tests in the failure cases.
> 
> Link: https://lkml.kernel.org/r/20251101182021.74868-9-sj@kernel.org
> Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: <stable@vger.kernel.org>	[5.15+]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 98f2a3de7cea..10618cdd188e 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -278,15 +278,35 @@ static void damon_test_split_regions_of(struct kunit *test)
>  	struct damon_target *t;
>  	struct damon_region *r;
>  
> +	if (!c)
> +		kunit_skip("ctx alloc fail");

FYI, the above diff breaks build because kunit_skip() receives two arguments.
Yes, the upstreamed patch is broken.  But, it was not noticed because a patch
[1] silently fixing the issue has merged into the mainline together, as a part
of the same patch series.

My ported patch that just sent as a reply to this mail fixes this together.

[1] 80d725f96c44 ("mm/damon/tests/core-kunit: remove unused ctx in damon_test_split_regions_of()")


Thanks,
SJ

[...]

