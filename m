Return-Path: <stable+bounces-205007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9587FCF6672
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E420D3017674
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205C821D3C0;
	Tue,  6 Jan 2026 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCbGAU4v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB0155C97;
	Tue,  6 Jan 2026 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664922; cv=none; b=H3o0/ykiuayheJfgWOvUUsuAQWY60HDyBBj8JObfT3H6zi6u8C4s+mow5TXuScgaSnXsFwHv0bS3HntXmPctevSGLH/6UYpqXSjITv01i78xV95xjkEYxfocQVx2d29gDhDXafKtg7aURo+GnPNaIJtw/C6WGzpS+0aNiJgZZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664922; c=relaxed/simple;
	bh=WjuZOo0zxKYjbscwFMF/RaUHUEGl6EaM5jTZlrHycWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5FqHKCwWUpWYaBmsp0mn1HB9aJZjaiH6NRDmSIkW4Gr3Hzq0PGLnD0J0Gvrzm89pe+qpdiR5KQA1QBzd17Vi0u2ylKc2COexX3JPoHZ8/xhcX4wYSbaQljTT4piYBioOsac9Svle63VpTrWnuL7H61Pjusfjz5CIyYiL0XkyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCbGAU4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC92AC116D0;
	Tue,  6 Jan 2026 02:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664920;
	bh=WjuZOo0zxKYjbscwFMF/RaUHUEGl6EaM5jTZlrHycWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCbGAU4vjyPclXPYtQU0/ixRIKPKUSeW2QZOZRY/3pdyEgejMaCgPyFT0dJlhesWw
	 Zt4LcxqN/0cORzS8Et/neEeXREAt6HLu7kwvV9XnX4gx4galwTs3e+Waq8rS9AMnm5
	 C/dog5ZJr7D6Cmud2EuTRE/5b47XWpYff1iCUDFL/+4ZmSW+e6nMN0MCufViXV6/jp
	 4ZLbns0/833rYjn5MjKaeGH4j5wZcPwuEYWYln2yW9iqcO0gDrthNGzMr2+ZLL0MdP
	 Gw4ryViXZTGf3yNVO+dghs9iNCKeFUZ0e2TeuUwZoY7DC0G6DdzmIht3htmiVm0gwz
	 npPpTkJXv+AwA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: handle memory failure from damon_test_target()
Date: Mon,  5 Jan 2026 18:01:55 -0800
Message-ID: <20260106020155.549647-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010535-convent-enigmatic-f417@gregkh>
References: <2026010535-convent-enigmatic-f417@gregkh>
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
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 3db9b7368756..3f0773dc2ead 100644
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


