Return-Path: <stable+bounces-179541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEF6B56448
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 04:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0C042103C
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 02:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3347E248F48;
	Sun, 14 Sep 2025 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qka+X46u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8151D90DF;
	Sun, 14 Sep 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757817480; cv=none; b=Q32+gPs+mDUmVcv9eKHAFJGzaxFKGB3thWeLHO2tyn1vNp5EDFiVxklSOuNni7gj5Qyv4aPT2jwks/l4tXdwjrAr8FuSjOTqzktTeK18wEz+BOlQ83/OAxGYHO/MKTh6eLhuvBILF/5EYR/NFqffOq/45rA+lmOTbcJiNySDA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757817480; c=relaxed/simple;
	bh=8/lgSvfugheGu+iobarQep7sBXpA+J6KgIUsGxNPvZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NStf5pjpVwAa5+XmHS6caSO2IjezCMUv71EZL0njOwiq8BXBGAYfMJlAZQ3bCy5rZ3XjZbEgmCglQq7QMazUlfiBs3HHecvbydzZJpgAoxVS8XHtO745soS/vcemWpVynxR7M17wTI4DYU+bS3ynE0UUnU+ukuZgoAAYzCCOJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qka+X46u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD6EC4CEEB;
	Sun, 14 Sep 2025 02:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757817479;
	bh=8/lgSvfugheGu+iobarQep7sBXpA+J6KgIUsGxNPvZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qka+X46u5Lb7eXIg18b2eedkUHrnA35ug1WuuBmsjjCZltPdSr+ASM/NG+t5y44Jc
	 kAoN1ZX7qoan8PrXRcVvKrtrbczHbnXiSNjY5fD+6dt5fhCk5X0f5j1tuo2QatOF38
	 xJx3ml0+0/emwKjAIR+lVHKqiHXAREN+BY74MMta96BcmRUq39nZIKHDhzmUVLGbHc
	 XIrMzQ09iuzFMu5TXbehChH4gFzuq+rC1FpZNvj69mhV7Kf4OFkgqzJTCeUWCJVzc1
	 QA9WfoUGble406z/cZz2Wysbxyi7cIXm4MMwmH6zKIyGd92mu38H+xiFP4ipCuex01
	 SD8P0dD2hiD5g==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Stanislav Fort <stanislav.fort@aisle.com>,
	Stanislav Fort <disclosure@aisle.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.16.y] mm/damon/sysfs: fix use-after-free in state_show()
Date: Sat, 13 Sep 2025 19:37:55 -0700
Message-Id: <20250914023755.2382-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091318-salsa-tarantula-9209@gregkh>
References: <2025091318-salsa-tarantula-9209@gregkh>
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
index 1af6aff35d84..57d4ec256682 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1243,14 +1243,18 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
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


