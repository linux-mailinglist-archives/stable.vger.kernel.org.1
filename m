Return-Path: <stable+bounces-179542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E95BAB5646D
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 04:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18A71A21097
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 02:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F924A074;
	Sun, 14 Sep 2025 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3TVU5nF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63252D531;
	Sun, 14 Sep 2025 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757817854; cv=none; b=R23bUgTLrh9UD2Nhlb/zbU4cds/76i/k7nu05p8zZ8LPpQxzr/tX5/BJVyrVGXG9p8CjOrgi1C+1WZrFIdJdL+6SduF+gkPvhuWMAuEsMLRzFpcF6oRVZPZp+fvjgnO5CmPIXKogVFbi35kbawN5Op87SZYHIOd+SuSr3rauGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757817854; c=relaxed/simple;
	bh=Y730O9sViAf3b3p+i7zR+wVuu86a8CS64X6qn1YEAqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAWYGPR89QlwOotgn6iqSsm94aH2mzY2/ynnNZbN8jNrB/WAUhKZtDnXui30YucWzld6MOCDBSKpyCgULmB83VG8Gw1nZiLNfcPdvIegYkMZcnFoTFHXtaQWiZDX9TH0JMSsixyDH2rzsEI79QH+MD4GPeVuC+uHigqS6NcfuhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3TVU5nF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA18BC4CEEB;
	Sun, 14 Sep 2025 02:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757817854;
	bh=Y730O9sViAf3b3p+i7zR+wVuu86a8CS64X6qn1YEAqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3TVU5nFHtDiT3HotDXquhv2pdZczdV8z+Q+9GBd50/wZRW2KRxyjLWyEsPT6VC5C
	 ohoqC3+dJAKrV1EUDgcA3JhXTcuWxdv6HBX4JIdsMhLQQlKzP79ijzpIDqviDcmOsC
	 1HTcH8R7wQhFau5wDte+PUwKzsbtf5Osa7q+U8zwWWFldzBnLu0CMkdz62H30ukxn9
	 KI0BHf1A2/dXxK+yyHgT1bgdhRf1NJINhMvzTjwHNF2Y10fi4I0RJyy373+IQPATW9
	 LkYKsNrwCs6S/HG2S+tG+eGaR9TpB2eekm3/xBDp+YW3Qk1qORVSYUEnFXFkHa+u4w
	 kEuTPVzpnC/bg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Stanislav Fort <stanislav.fort@aisle.com>,
	Stanislav Fort <disclosure@aisle.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/sysfs: fix use-after-free in state_show()
Date: Sat, 13 Sep 2025 19:44:08 -0700
Message-Id: <20250914024408.9009-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091318-dreamt-kindling-f2c4@gregkh>
References: <2025091318-dreamt-kindling-f2c4@gregkh>
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
index 58145d59881d..9ce2abc64de4 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1067,14 +1067,18 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
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


