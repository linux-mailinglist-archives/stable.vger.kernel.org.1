Return-Path: <stable+bounces-204687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E969BCF3294
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E177E3015946
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4766231986F;
	Mon,  5 Jan 2026 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGHHK8xw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077033191B5
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611067; cv=none; b=eVBZTb+UdNzftdSM6TVNkfTpr6k/4tq34CQwwu1blSlcvUW2A4L1TXpNh07K0zsa/sQVBbloxM+J47fqXPhheu8H1UmeElXri2teQxJmsfZ2KS1ViQMztjUSAYKz5OLJXbqPPWM0YSsfGGgN2P07m/RwQUAWlMQw61xqRlOf6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611067; c=relaxed/simple;
	bh=raye+3qRQF8jJL2zW3ppLkwdNDosA93oeKRodY/wRGo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LC1XcOapnDQFrPY+GMyOj0uy0Pw25j0zDxwT3PPgV1W+PDmJQjIecfedQ4A/BpSTxjA0TSIBFlFwkSMorXd4UwGme1H/TCASoFxVsbKS7BGtFncy3DCIX3Mt24SFCeg6UHEpiG3v3Iri58kz9FzQ/KP6fE1Xo0drHxb8l3a5Ss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGHHK8xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D9EC116D0;
	Mon,  5 Jan 2026 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611066;
	bh=raye+3qRQF8jJL2zW3ppLkwdNDosA93oeKRodY/wRGo=;
	h=Subject:To:Cc:From:Date:From;
	b=PGHHK8xwZ5zNr16jmC2CHMlEVQroKBe7inJmZK46+VcBqjhb/f15OmO4TRIZFgckQ
	 GB2/CgUrMB3//Jewq7Rp6JuSHuDUk7q4ajM2Pnnhso321AnSdZTX2O9UdwI4gOxopu
	 7xdWtR3Qn3vNNHpZ0qVEiTzhQ2ijemJqp2Pz7yEM=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle allocation failures in" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:04:22 +0100
Message-ID: <2026010522-unrelated-secluded-4f8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e16fdd4f754048d6e23c56bd8d920b71e41e3777
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010522-unrelated-secluded-4f8f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e16fdd4f754048d6e23c56bd8d920b71e41e3777 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:19:56 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle allocation failures in
 damon_test_regions()

damon_test_regions() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-3-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 69ca44f9270b..a2c9ee7a5de1 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -20,11 +20,17 @@ static void damon_test_regions(struct kunit *test)
 	struct damon_target *t;
 
 	r = damon_new_region(1, 2);
+	if (!r)
+		kunit_skip(test, "region alloc fail");
 	KUNIT_EXPECT_EQ(test, 1ul, r->ar.start);
 	KUNIT_EXPECT_EQ(test, 2ul, r->ar.end);
 	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_free_region(r);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_add_region(r, t);


