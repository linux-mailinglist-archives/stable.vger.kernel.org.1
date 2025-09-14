Return-Path: <stable+bounces-179543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95967B56472
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 04:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5959A16E847
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 02:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834025486D;
	Sun, 14 Sep 2025 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftIwtQUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4B24466D;
	Sun, 14 Sep 2025 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757818284; cv=none; b=APY+HCNRo7/hPYeUCZoKPxAr5xTKLkfENeCOfhjrJBUcwrCNI+hsPmAghDsH9FuQxLmlGcUXljK6gXaULJX+Ktr4WjlQuZLdQrcBnp/1L9pvCw6uGY/qPeQ2pv40HZVz+aPXqujEcmRhDF8pvnMSGFqTc93ZSFJDELXR9TIgMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757818284; c=relaxed/simple;
	bh=EEttELQ0YqnMfVMS6rsgMzRidkodEpmUZswFU0OhZIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3SRaCrwEXqZqFbkH+f0mkImOJGAf5kbiJipD2qbq9LaTaZ4VcC2d0+Wgej7zSS/ggHGbaV34QWsR4gabeAYtVqIEi8q6oirebGsU2aW0fVizueSaLb69jqUHsYEJAj1TVhzRb+RgY3g3yKfDshRw6wTkb96DGA8DMxqjFP/gXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftIwtQUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D36BC4CEEB;
	Sun, 14 Sep 2025 02:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757818284;
	bh=EEttELQ0YqnMfVMS6rsgMzRidkodEpmUZswFU0OhZIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftIwtQUmQePnUQ84pTdM71MBHOvPs0B9rOMTYmCsk1kogvt891vc4957LB2idotK3
	 qRSfD53jnqWeApkO3fTuT93STDzFH5VzjdJD0W9XJ/DrEcizPE7nzgE72uS0+/a4Hc
	 d2BUK0wXYrPY9dE829znKzNJMXTlc1G2t6HnveDRKBTSBa0wILs5/1dDDLSDY0Seq9
	 l1mFB+y7YZpMlJ4OEsetYoIDZ6NnBLxIyoQNiD2PLQ9DxbRobqTtQWbdiGykhzXncC
	 a0o1nWt8UZt+YlEF+SEFgaMcCMbsZIHMXPQCRv35lCeCAzTMWgvO36orQ9yiqV1gjN
	 IY9On+ArPn+Yw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Stanislav Fort <stanislav.fort@aisle.com>,
	Stanislav Fort <disclosure@aisle.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/sysfs: fix use-after-free in state_show()
Date: Sat, 13 Sep 2025 19:51:21 -0700
Message-Id: <20250914025121.2284-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091318-trombone-graduate-3828@gregkh>
References: <2025091318-trombone-graduate-3828@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Fort <stanislav.fort@aisle.com>

state_show() reads kdamond->damon_ctx without holding damon_sysfs_lock.
This allows a use-after-free race:

CPU 0                         CPU 1
-----                         -----
state_show()                  damon_sysfs_turn_damon_on()
ctx = kdamond->damon_ctx;     mutex_lock(&damon_sysfs_lock);
                              damon_destroy_ctx(kdamond->damon_ctx);
                              kdamond->damon_ctx = NULL;
                              mutex_unlock(&damon_sysfs_lock);
damon_is_running(ctx);        /* ctx is freed */
mutex_lock(&ctx->kdamond_lock); /* UAF */

(The race can also occur with damon_sysfs_kdamonds_rm_dirs() and
damon_sysfs_kdamond_release(), which free or replace the context under
damon_sysfs_lock.)

Fix by taking damon_sysfs_lock before dereferencing the context, mirroring
the locking used in pid_show().

The bug has existed since state_show() first accessed kdamond->damon_ctx.

Link: https://lkml.kernel.org/r/20250905101046.2288-1-disclosure@aisle.com
Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
Reported-by: Stanislav Fort <disclosure@aisle.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3260a3f0828e06f5f13fac69fb1999a6d60d9cff)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b317f51dcc98..91893543d47c 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1055,14 +1055,18 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-	bool running;
+	struct damon_ctx *ctx;
+	bool running = false;
 
-	if (!ctx)
-		running = false;
-	else
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+
+	ctx = kdamond->damon_ctx;
+	if (ctx)
 		running = damon_sysfs_ctx_running(ctx);
 
+	mutex_unlock(&damon_sysfs_lock);
+
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
-- 
2.39.5


