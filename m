Return-Path: <stable+bounces-183325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5C0BB80E5
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 22:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7CE1B20A1E
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752B2475D0;
	Fri,  3 Oct 2025 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bll7mUUA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8C21CFFA;
	Fri,  3 Oct 2025 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522513; cv=none; b=EYjZ4NYpNN274i6FbzaZW+udVMnlJsXu0yuYPoFJ94w5JjLO7jCoWf/4agi7A41cBIygU4WaLVvVIISyIy6T4Cxkhwzo9GIjP3GowxH0uA/YWRpD0ygqsBMi7NDw0KDlkTwJnxpYd0OySktcnLEAK+ty5xjPvTPj7waCL/Fe7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522513; c=relaxed/simple;
	bh=RUym5ecXxJyHPu+yV0bLUP/4AGHYamHBJdCCq97kIHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jEPTSF0eM48NOARLJBSd0p12joz8q4DHt/QNp6vJRA+IPjqfup3/Gm51V/RabbHv2KRSVCA5YyjvWWliXPWkD/S9JcpgDqCDo8Iovc4lC5PrIjYl1tuRhDiQhqxzvtWYydSK+41txPbtSJs6J+Ai0uHu3wLfoF7hB59X8GUXNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bll7mUUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58E3C4CEFC;
	Fri,  3 Oct 2025 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759522513;
	bh=RUym5ecXxJyHPu+yV0bLUP/4AGHYamHBJdCCq97kIHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bll7mUUA+UwhEStyFuFQwNoFvZilUR/YeNEuPz/sr6fMhzx1574r+bKBZdS0eHDlL
	 3cdi3UyPSuoK19/y0jPQlf92hGKUPPAnnE246oXAPOhaeSYyv27mJOzD1bnYmMhCdd
	 sSVE+7g9o/b3G7IEYV6nEE+nVYGxPUXjkKA9tnIjOB430/1OMD2osnmr3yOws0HiD0
	 k+D0H+Q3WLxaJ3tjz6bXrZWD46E48RjQS82lZUUlZ15ieaeVG1fmAkypr/yDhjqhEA
	 3hqbZYDymnHP8cEJd1VeQcKtVTT6FdWDKy0RXUiyJQreVcG3C+VC9rwt2+4AhBA2Ij
	 +HTuxp3gZu9VQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damon/sysfs: dealloc commit test ctx always
Date: Fri,  3 Oct 2025 13:14:55 -0700
Message-Id: <20251003201455.41448-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251003201455.41448-1-sj@kernel.org>
References: <20251003201455.41448-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The damon_ctx for testing online DAMON parameters commit inputs is
deallocated only when the test fails.  This means memory is leaked for
every successful online DAMON parameters commit.  Fix the leak by always
deallocating it.

Fixes: 4c9ea539ad59 ("mm/damon/sysfs: validate user inputs from damon_sysfs_commit_input()")
Cc: <stable@vger.kernel.org> # 6.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 27ebfe016871..ccfb624a94b8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1476,12 +1476,11 @@ static int damon_sysfs_commit_input(void *data)
 	if (!test_ctx)
 		return -ENOMEM;
 	err = damon_commit_ctx(test_ctx, param_ctx);
-	if (err) {
-		damon_destroy_ctx(test_ctx);
+	if (err)
 		goto out;
-	}
 	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
 out:
+	damon_destroy_ctx(test_ctx);
 	damon_destroy_ctx(param_ctx);
 	return err;
 }
-- 
2.39.5

