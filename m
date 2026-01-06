Return-Path: <stable+bounces-204976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C47CF635C
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 406CC304A8F3
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B8532D0CD;
	Tue,  6 Jan 2026 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR4u5zCf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C832D0D6;
	Tue,  6 Jan 2026 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661363; cv=none; b=MMWFpoypxXq+TmN5If5F9N3Kcs5/wuVKsCasIwlj2i/JnD4RG/8pkBaM4UZ0ymxdUWX3WTmh96W/jRXdW0q8BFKjjRFxnK8HW36JFQKkxI2Q48rIohF38YE25zwCzPGnZD0BY4mDtExOMcdxTFfgwNgV6lI0osfY2BFhpcTPsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661363; c=relaxed/simple;
	bh=DUoh31EKTly/HGINTYv/WZ7yV3iL+E320mJWpd6rfK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQaFkx4L1zpnOOAsh+7lgg6PchImTefChw38u2EsP4ITBsR8ev7eECp0/n4gdhqVsqUDa4qhanbFXdFnJrL0lVQUJy+//mbEOSHQXhOGTxE+sk/Fw206i5Ugy0OZAhWONeWtzdC83rmHFS5RYE3Am8Tdd7Azc1Z9ot3kRV3yZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR4u5zCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE162C16AAE;
	Tue,  6 Jan 2026 01:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661363;
	bh=DUoh31EKTly/HGINTYv/WZ7yV3iL+E320mJWpd6rfK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YR4u5zCfF0SYhTt9Q76DwKzf7M2/rAzZA8Zbce2KLdiK9YcfbOReVrL00uY7g4Ujm
	 AoPr+GmstlCm0PNfyqjFa/qk7zgfKkz1DzBle48NJZZF7jIHcDZ+FD5QnlhY+H17NY
	 yuY1NqeQmnGW3IWFV6XbuTcUpRYZQ4gU6MWX0qGDmzmaODaZsa4XI/fx+KMtfboTnm
	 dxtVdY/kY7BYmj0z1FTT4t020DLRnBj5N1kMEB9exz4wa9v6allPImTH6yNicCXwVU
	 fFWmHWOkYSZdPAMY6Xz2hlnLRBZOHoeC8nVIvf0kp2VmJ4rf8jHwiCHgVf78k3eQ8y
	 p4qIivAf/cdPA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle memory failure from damon_test_target()
Date: Mon,  5 Jan 2026 17:02:32 -0800
Message-ID: <20260106010232.185372-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010535-tumbling-unread-bbf4@gregkh>
References: <2026010535-tumbling-unread-bbf4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_target() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-4-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fafe953de2c661907c94055a2497c6b8dbfd26f3)
---
 mm/damon/core-test.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..0ef2324e3422 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -52,7 +52,14 @@ static void damon_test_target(struct kunit *test)
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, nr_damon_targets(c));
 
 	damon_add_target(c, t);
-- 
2.47.3


