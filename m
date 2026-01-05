Return-Path: <stable+bounces-204713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2316CF347B
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C8030B65C5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFBF33984A;
	Mon,  5 Jan 2026 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B6akEFGn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD68339870
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611222; cv=none; b=aCWM6k9nNpFXC8OruPs5skH52Cuzi6GZU7dHHDSIj5IdaEtEMFGVGyiRb1m5PqM2t0vnCMrW+fyUWhbYm16k36gSp5ubgHsbgiZ++6yJEbRSA0aknwrJsq4E1xtNv6opnK6bze9n84RxZwdqfBCEB3dk9RKYViNSyFV3avs+Ke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611222; c=relaxed/simple;
	bh=muNZw63aL+wR6pfVZMen/3Ks5EK5/1kto729fYrL7Sk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PGwDsUNzdGwSZObjtHGVR7fD5Oj1GUnGxiHsHbrTrgshwTOCGGKfFReGL2jjM3gLmvlB65DSzzpQmmlSVno3lZa5+D47LhoNvH2qailaW+VyTIbCZf6cQlS1ULs04DUAhkdPPDju1QBlKVjPaWa1iH+SmDzCTiKc5eT1vCmFlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B6akEFGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3CFC116D0;
	Mon,  5 Jan 2026 11:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611220;
	bh=muNZw63aL+wR6pfVZMen/3Ks5EK5/1kto729fYrL7Sk=;
	h=Subject:To:Cc:From:Date:From;
	b=B6akEFGnS+2GlUwdtLDHOtCsdP+lJhNMFScSPkfUBoAzt/UPeAx4zGVa13uaxq6Dt
	 t/C2H/HqD46qSYzFN+EdG6qcIxbXthn8FhFQm2RS+HSR4lKLsQBIFR5V644Uj94GCB
	 AZwuBRE6DIz7Qd2rnLN7sbgHyAvSjwqC78XOp6qI=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failure on" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:06:52 +0100
Message-ID: <2026010552-thickness-copper-cc49@gregkh>
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
git cherry-pick -x 915a2453d824a9b6bf724e3f970d86ae1d092a61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010552-thickness-copper-cc49@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 915a2453d824a9b6bf724e3f970d86ae1d092a61 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:06 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failure on
 damon_test_set_attrs()

damon_test_set_attrs() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-13-sj@kernel.org
Fixes: aa13779be6b7 ("mm/damon/core-test: add a test for damon_set_attrs()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 10c9953581ee..b9bd69a57e62 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -465,6 +465,9 @@ static void damon_test_set_attrs(struct kunit *test)
 		.sample_interval = 5000, .aggr_interval = 100000,};
 	struct damon_attrs invalid_attrs;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &valid_attrs), 0);
 
 	invalid_attrs = valid_attrs;


