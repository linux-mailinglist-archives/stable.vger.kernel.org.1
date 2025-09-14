Return-Path: <stable+bounces-179554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E70B56619
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 06:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D7016A2B4
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 04:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92372750FA;
	Sun, 14 Sep 2025 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tM5Lm5pq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E725DB0D
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822485; cv=none; b=n0eCzA/x0KPdvPMQD6QI5NEQtszXyEpzu8NXwd374EwGypY94ytNMQvwcP9l6GyQhgIQ27oMg/39voZw1Wo/od2/7PyMHM1uNxwhtPgmGJ9Lg+klOrft2dndVG1Bomzu9S+1bomYsOL4QK9u9vEe/JAVxo9siJQkYeVkyey/asI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822485; c=relaxed/simple;
	bh=LFOn0BsNBsYMxFF8u6XGZFC3k5juTSM48joggqMHPK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoHxUlZnxdm2VrP/e2bMw1QdnZUOt7KB9B6rzTtbIE3TCnF/IJf15WBG5mFDp7/Mf1XGaLpCjo1UQTP7hNg0fJ1VUTh0r8UOAKWIpKspSNbkdwvf4h/a6oZ4NmS0m8WSn4basdnDU1Q6KUcTovyTlyGe2I91Vm0R7DDVgGWkEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tM5Lm5pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C668C4CEF0;
	Sun, 14 Sep 2025 04:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757822485;
	bh=LFOn0BsNBsYMxFF8u6XGZFC3k5juTSM48joggqMHPK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tM5Lm5pqUS/OoQKfkAJEThZg+guyiMFCVrnvGk+TU2ytlGzYV4BcaoKNgHCGLpZ8A
	 do6Oqq/gbzxvGc172Vav7Ifess+thmoog3xgSaaCQwTgAI2FMQqQT4mVlZ9rQQKH7q
	 jN5l3ppptUPCorKpoVBi0/irC9MGHyn3tASh6ZlMTZPCIqK/GzS9GVc5HeFYu0QHLt
	 kOIsTRmq0nARrf6wS7jvaNUetYRU9w2Vxz0zFdQIoOyXZo2QqxB/A4kJx9OP3vonwo
	 wTB3NViPOVRQUDQQI+ULh2mXjAwdJnD5V3g4atvFTPjlaasrWxW2IE0SR2QViZEvx1
	 1a5mbJR5TUrRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanislav Fort <stanislav.fort@aisle.com>,
	Stanislav Fort <disclosure@aisle.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] mm/damon/sysfs: fix use-after-free in state_show()
Date: Sun, 14 Sep 2025 00:01:21 -0400
Message-ID: <20250914040121.1957914-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250914040121.1957914-1-sashal@kernel.org>
References: <2025091318-salsa-tarantula-9209@gregkh>
 <20250914040121.1957914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Fort <stanislav.fort@aisle.com>

[ Upstream commit 3260a3f0828e06f5f13fac69fb1999a6d60d9cff ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/sysfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0d86ea6938f90..59fc5d19b374a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1233,14 +1233,18 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
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
 		running = damon_is_running(ctx);
 
+	mutex_unlock(&damon_sysfs_lock);
+
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
-- 
2.51.0


