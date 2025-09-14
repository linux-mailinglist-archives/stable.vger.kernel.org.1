Return-Path: <stable+bounces-179544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A54DB56473
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 04:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BADA1A22932
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 02:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D8246BBA;
	Sun, 14 Sep 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fszKJFi6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3743110FD;
	Sun, 14 Sep 2025 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757818632; cv=none; b=eqxzH07Yt6+eFsI5ecBHWdjzpJTXN7/2LR2ppSrRcAE96okSzkEeA0jGg+bLW7pGIJOyaQNs3Bg7lbZMDPzUly9ZPToPUhccHyz2v1ggepxMUS7192HHL+3bKNrI/UsNzGx9NLa1civ0Yajy/cE3HrxiG2G2xDxoZJ8ln8aZ87A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757818632; c=relaxed/simple;
	bh=qvMPxfYnDc2wBVd4IkxHgTXdjuTXTSOO3yLGuEfCGic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAUVE4EInZ8a0qby1rRvBhzDzPh9HxOeaVHSjWfNH/Eb3zgdaaIm21bUMUuteQCq6NHETdH92lmVe4in/aOK5mupIlDO0Ybts0Da4Bn0sAe6g6DZgLV0pu92DvfWD0ORfLtsvrg32fRuhFodpt6i8g2hrn79dM7WfBmHmBbRuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fszKJFi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C6EC4CEF4;
	Sun, 14 Sep 2025 02:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757818630;
	bh=qvMPxfYnDc2wBVd4IkxHgTXdjuTXTSOO3yLGuEfCGic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fszKJFi68LdVDCs39/Xw+ewOdWNNsKTk+Y1XPlk0ifBbMUZIin7XVGAo+JQoNaRkG
	 uL6w3lwXA1S+CR8hLshwrpwz/a10sVSMAirc/Bw3oYZeh57i7uTudxqi19MhK/fNAZ
	 xu7y92Ng3xBWnzA0UWmeVNuk2bAnKLf5tbd4BfOMFRAyLMX75AjHFG6xCf4MVf9Ulu
	 YYNvZL53JJ4XbCi9cvCasbaDqShUC9r0hVZEaVqQ+zsgXnxsMWQ0o+1svcn1Fa/wux
	 Q7ik7pcXjA82onN6tFXQvvvRnjVE8CJwghh7CesFZswTIKtPQKwEkix283nbp+CKrW
	 zLVS2d8GkUbTQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Stanislav Fort <stanislav.fort@aisle.com>,
	Stanislav Fort <disclosure@aisle.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/sysfs: fix use-after-free in state_show()
Date: Sat, 13 Sep 2025 19:57:06 -0700
Message-Id: <20250914025706.1846-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091319-muscular-shorts-753a@gregkh>
References: <2025091319-muscular-shorts-753a@gregkh>
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
index 9ea21b6d266b..18f459a3c9ff 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2093,14 +2093,18 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
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


