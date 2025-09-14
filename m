Return-Path: <stable+bounces-179553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B3B56611
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 06:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBED57B3C8F
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 04:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA9267B90;
	Sun, 14 Sep 2025 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMQJb68Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18977248176
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822485; cv=none; b=BT6W2EJWOlhUC5IOFYcceZ5y62cMt96ZC9jpR0Zxb/yxUQ3V0dNjNtUyzzDgZr4ceuZUpDoY6IXbJ3SyvYonZzkWbbmJa78mKUfTihLvxlvsrYk9zokcwRlhRgdT15ynaZ8GK+5eEAVEbZQjvT5jb6yPqx7Zsbxi+B4hgJrx3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822485; c=relaxed/simple;
	bh=EgOt7Vg1RqvQ+T89g758gpktodyomUtAtv3G1m46NQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbw8u0PAv1nDB0ojCtBAQnhn7E88IO3fUKufNisGb9SAiJTeKL23CQSsS2eOAsDktXSi3wFCAMyAwwyojssQcMeJ+fHY/BWVWKKU4j+RpKV/8h0fPd/i39XUSB1NQXTLz3VTYGBa0BdinIzxbO3DJgFfy77VjR7iOQMZjCvIA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMQJb68Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B8DC4CEFB;
	Sun, 14 Sep 2025 04:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757822484;
	bh=EgOt7Vg1RqvQ+T89g758gpktodyomUtAtv3G1m46NQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMQJb68ZKLn7lsCWv9RIv3uc9cCCXg4KD/VJdTFH3i4gpuKagk6zBrb2s05PRB4Qh
	 QD+9UmliHhrTdwzWkspMuYRm9um64DDPr8pmpUA/ZNWWk6UFyn8Eg9npUBHn9Gmr6/
	 89Kd3gx0pfEkSXXc80R60Z/pFmwnBxkrwHZu7PguM1GLmFkdlDvyPazbs4FlGDTgQF
	 O6yzK4k7vhGHjV8vd44+vGNJZa5Bz1kV0pNl4U+2R8AWxwxd/wpX3XgLmwl4ndJlWM
	 GOyBWWGBz+ien+jlabmn0CB7YVTHDkJYAwFGQNvaSlIE7NyyKm5mYqi5xg7c7bMX5F
	 E5jCm4Voj12tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] mm/damon/sysfs: use DAMON core API damon_is_running()
Date: Sun, 14 Sep 2025 00:01:20 -0400
Message-ID: <20250914040121.1957914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091318-salsa-tarantula-9209@gregkh>
References: <2025091318-salsa-tarantula-9209@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit d2b5be741a5045272b9d711908eab017632ac022 ]

DAMON core implements a static function to see if a given DAMON context is
running.  DAMON sysfs interface is implementing the same one on its own.
Make the core function non-static and reuse it from the DAMON sysfs
interface.

Link: https://lkml.kernel.org/r/20250705175000.56259-5-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3260a3f0828e ("mm/damon/sysfs: fix use-after-free in state_show()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       |  8 +++++++-
 mm/damon/sysfs.c      | 14 ++------------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4011726cb3ba..be02ca4329657 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -934,6 +934,7 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+bool damon_is_running(struct damon_ctx *ctx);
 
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8ead13792f049..0317f749b9296 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1340,7 +1340,13 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	return err;
 }
 
-static bool damon_is_running(struct damon_ctx *ctx)
+/**
+ * damon_is_running() - Returns if a given DAMON context is running.
+ * @ctx:	The DAMON context to see if running.
+ *
+ * Return: true if @ctx is running, false otherwise.
+ */
+bool damon_is_running(struct damon_ctx *ctx)
 {
 	bool running;
 
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1af6aff35d84a..0d86ea6938f90 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1163,16 +1163,6 @@ static void damon_sysfs_kdamond_rm_dirs(struct damon_sysfs_kdamond *kdamond)
 	kobject_put(&kdamond->contexts->kobj);
 }
 
-static bool damon_sysfs_ctx_running(struct damon_ctx *ctx)
-{
-	bool running;
-
-	mutex_lock(&ctx->kdamond_lock);
-	running = ctx->kdamond != NULL;
-	mutex_unlock(&ctx->kdamond_lock);
-	return running;
-}
-
 /*
  * enum damon_sysfs_cmd - Commands for a specific kdamond.
  */
@@ -1249,7 +1239,7 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 	if (!ctx)
 		running = false;
 	else
-		running = damon_sysfs_ctx_running(ctx);
+		running = damon_is_running(ctx);
 
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
@@ -1403,7 +1393,7 @@ static inline bool damon_sysfs_kdamond_running(
 		struct damon_sysfs_kdamond *kdamond)
 {
 	return kdamond->damon_ctx &&
-		damon_sysfs_ctx_running(kdamond->damon_ctx);
+		damon_is_running(kdamond->damon_ctx);
 }
 
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
-- 
2.51.0


