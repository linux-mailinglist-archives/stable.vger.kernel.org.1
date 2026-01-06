Return-Path: <stable+bounces-205023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD87CF67D3
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11C6F30242B5
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C67231A41;
	Tue,  6 Jan 2026 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVuEyLa0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248D22FE11;
	Tue,  6 Jan 2026 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667155; cv=none; b=ds7eYk3tXkW5IwGpNOB415TXw8QOo/GgLStOJqcEY1dtTRRaRmgvFq/mYfarhRizkQjpG1bs9P919HPhSCqMVQBK9aMtTMK6M8OvuVKVbXC5y6mPBi8QzgrhmYL9LIR4G819z/cTaYLPIKyetFEBar0LUlpDK7xpWubMZ+qK5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667155; c=relaxed/simple;
	bh=9rgiOmYnH/xcSdeBN/+UtGuOcu5FjtWdfgmcD++0jL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u65oXbxCB2TzYVaxXTggaO15PwYmnbWDFFb/MJ0sSoJvXGMWg8n5l/fSJm1z1FMVM+5sitOsWGwxbBZRLwYJbKXjujyu8q+WC1BsgJvFmRpa4HFl9yXwnq+N5nvfnyGWaRjeY6PZhxki0wWu/Fo10Sy+G8a+PpEeU6b1XFET0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVuEyLa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD17C116D0;
	Tue,  6 Jan 2026 02:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767667154;
	bh=9rgiOmYnH/xcSdeBN/+UtGuOcu5FjtWdfgmcD++0jL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVuEyLa0EhqLUR3bzF+VaVwUIIkvpdf3gHVwpp2UFzT8sjO9cDGVXFA3rsZyu0was
	 ytYQAkRW5v9dkUkEJSXCeWPBlKKuGj7zeC8al9z2mlWf77L5/iB5Xgbdc1QBA18MYT
	 r+6RAh+WILbrDAeZiKF5s628fFrww412Im2K9IjjqxlpfVXhgx+36W8u9AaVnhRav9
	 yGv62SggiEehiD5a1cJZt2mA+2apbcgAly2IhP4m9ZGeOGI0d2GzOt4lU580IyOACc
	 xM/hGNyZeZH+ArJCNMr6Q2B68uTe8n9aeVJ13zr+MomiiIgGBF1PTvxtCMkkO9BnBq
	 h9qrirYFHn+EA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: handle alloc failures on damon_test_merge_two()
Date: Mon,  5 Jan 2026 18:39:06 -0800
Message-ID: <20260106023906.786839-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010518-backhand-stood-34f4@gregkh>
References: <2026010518-backhand-stood-34f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_merge_two() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-7-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3d443dd29a1db7efa587a4bb0c06a497e13ca9e4)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 3db9b7368756..b77ee599b354 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -145,10 +145,20 @@ static void damon_test_merge_two(struct kunit *test)
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	r = damon_new_region(0, 100);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	r->nr_accesses = 10;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
+	if (!r2) {
+		damon_free_target(t);
+		kunit_skip(test, "second region alloc fail");
+	}
 	r2->nr_accesses = 20;
 	damon_add_region(r2, t);
 
-- 
2.47.3


