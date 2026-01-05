Return-Path: <stable+bounces-204712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D922DCF34AB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 574383065E35
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5A338F38;
	Mon,  5 Jan 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="phlBem9n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C3338F26
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611211; cv=none; b=oVz4vBUVwQVVzx3iuvTGqvDdDOzsGn00LtuFLXZnOtM2wAJUu8sVbftwVB6gC4XdIajHEaLEsH7r8+iQNgk9dsMLEr037qm0/1cv/7HlP/62x6VHbtj3Ze5Yy7Qs5f2KEMOi/bJbF5jeRYF04hQc+ZV2qhw+PmihORlfTrNXA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611211; c=relaxed/simple;
	bh=jvptL47/0m/2Z0UopGdfWqzY9+/1+lLpxJDu2+gXilw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TwjLlTibBODA9pXIW0+nQ6jn3c1Dg6n4/g4vHxNd4TOPCRO5SF/3978joYPLu3DBu8NN8IiF/dMsQI2J9rKA+ra1GQ6l7jKwGU5KQnKrliLucnB+KFQ4t0Bv8v0RG/gYtlvqizeldOS8L+m9P+EKD6HHhDPufiR3vcxA5z4Sack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=phlBem9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7047AC19421;
	Mon,  5 Jan 2026 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611210;
	bh=jvptL47/0m/2Z0UopGdfWqzY9+/1+lLpxJDu2+gXilw=;
	h=Subject:To:Cc:From:Date:From;
	b=phlBem9nZpyJhr7IkB5WDMdP6N+xVsaqzcS3E4RAsCAZafrsxNiIx2gFeuVJ3XIdC
	 BuZaku+mgGxM9WWu2cqts7RuMhG409xBfbQ+ZWKiajWo42zve0eoB+WrlWIttj18cx
	 epveczFqx9hfUmrPVm6+7dJSymTTzMoa2UTvklIw=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures in" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:06:39 +0100
Message-ID: <2026010539-octane-stony-f737@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4f835f4e8c863985f15abd69db033c2f66546094
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010539-octane-stony-f737@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f835f4e8c863985f15abd69db033c2f66546094 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:03 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures in
 damon_test_ops_registration()

damon_test_ops_registration() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-10-sj@kernel.org
Fixes: 4f540f5ab4f2 ("mm/damon/core-test: add a kunit test case for ops registration")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.19+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 10618cdd188e..96c8f1269f44 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -320,6 +320,9 @@ static void damon_test_ops_registration(struct kunit *test)
 	struct damon_operations ops = {.id = DAMON_OPS_VADDR}, bak;
 	bool need_cleanup = false;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	/* DAMON_OPS_VADDR is registered only if CONFIG_DAMON_VADDR is set */
 	if (!damon_is_registered_ops(DAMON_OPS_VADDR)) {
 		bak.id = DAMON_OPS_VADDR;


