Return-Path: <stable+bounces-205016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDA3CF679A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77F7D304640F
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FFF2E6CC7;
	Tue,  6 Jan 2026 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHIKHkuX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025B2E540C;
	Tue,  6 Jan 2026 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666208; cv=none; b=XsZC6/5PWFnDO1yC+rBdB7v4EQ2uKTKtUz9KUDCNj1uLPm3GalmKPhs0OaarEgbFP6YdZJXDaBkt0YhCiSU/FIQZj/syB6pJ/M0F+3CzOPPo//+dZ6EnHco9a3Z6BIoPg1P3FD/nAphVEjNRwJxmi3gC8pjmEE7tOnzvGJUdWRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666208; c=relaxed/simple;
	bh=WHUC4hR8e9vq9/zZ3W3YPDwZO+OJo+oddTcuh1qURRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcJ63arYKIPY7MGxj/EC/HzKZVWWmHLHG4sWu+tGS5TiZzqmQYoszIcdSCV5IUIM5nRKLzOrgqp1adzvLIdPvw4g4I+M63RCVtcdm77lyQ9NgGCWwvcw7inZKo01sgQL10EHU/vbSBme8j71lyYozuB3akntfDB5TtlblIHhkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHIKHkuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E63FC116D0;
	Tue,  6 Jan 2026 02:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767666207;
	bh=WHUC4hR8e9vq9/zZ3W3YPDwZO+OJo+oddTcuh1qURRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHIKHkuXzRwn/iE/NZYS8WiWQmtDY+bxgiB0JSzSqs2Xh5hR/mGXIvY38dT+8gix/
	 HJ5siw2+MohYc3ZbZe/zOKCaJuC3niQWhHsk/t2W0bbzTNq/duKzfdArkQwCw0qs0a
	 tJY08+olvGNT41xocoIPLYBFIz6sBAakXH1MFu/qrgmT9cfu4Y9tKi8t09u/uBoDYZ
	 pCAiHzOXyLt+e7h8IQ25HZcXrXqvLLNMhxeJJ8rshRk7xy+B4Ak85WueAhLPB6imwh
	 YeH8ggs7Axv6kvIUxACapa1IjfhBSiQvglEs1H6NeTHuPnLE2VOdcfyXw8q7KNJY4w
	 ApPYfBdIxOo+g==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_at()
Date: Mon,  5 Jan 2026 18:23:24 -0800
Message-ID: <20260106022324.674359-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010508-outnumber-condense-f43a@gregkh>
References: <2026010508-outnumber-condense-f43a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_at() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-6-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5e80d73f22043c59c8ad36452a3253937ed77955)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 7008c3735e99..ea8f548a556c 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -122,8 +122,19 @@ static void damon_test_split_at(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
 	t = damon_new_target(42);
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(0, 100);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_region_at(c, t, r, 25);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
-- 
2.47.3


