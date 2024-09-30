Return-Path: <stable+bounces-78290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5461498A9F9
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 18:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C861C22A54
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E797E193086;
	Mon, 30 Sep 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qrUkw/Ee"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C86193426
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714268; cv=none; b=s5TTLigramZBSV4IyLZuube1jdyi2yTYv4wtDvIn9ejPFJmGFmVBBLYi8a2eyhP6JBDGSnc1LiXzyEj+XkrF2HIch+FsTnbOnoSBRMvx9oWvh7vcIE7D4mejZYyV0FCiN/Kz0fDj5WhUDMqpWDd2ALLZxyIuiMn3q7anXVdLMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714268; c=relaxed/simple;
	bh=DGTEqWT59b4xewI8tbF2K62XtAnt9luFRH8leH+xhAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJYdAZCiv6PUYpCl0/vA9fKK1j2cIWBk9v4eFTgp1+bKfY78G/tsUybLu5l8dZa5zhPeXzyVgnFuPi4CwSFgCa7sGWTJ+ZicefBch7BAVw9nSL2avoForh/sgmpk6WmMFtMY7CjZk7gLcOilHjchhOz8lIOxa4BE/tbfZYjlIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qrUkw/Ee; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727714264;
	bh=DGTEqWT59b4xewI8tbF2K62XtAnt9luFRH8leH+xhAY=;
	h=From:To:Cc:Subject:Date:From;
	b=qrUkw/EeNToGGqEunZuQjU/k84z8qn8RM+FfQvwDMpkcfLszalEv4BPJbUGIc7hD7
	 NxV4XptFAcodG3oHlDnR/LXvCOrGuwciBVUE2BgRg49OlXcR2B71trdxPj8anMWzhT
	 TF66BrlQcAMv1FMM8mPzIguDsN2oZUcY+AK3uOQ4LEUw1Jp3X2ZTF02ugP+V5GoQv8
	 MzOlmOfv8Tlt/mQ3pKH4qoz8xLjU12xdxmg9IQr/PaeXo54sEq/Ul/bJ7dMFajaO3X
	 AjSSese99l4ONUbKsZOUVtQzIAlgwSQlJndGnrtptXDvvyAUhSRzpcd5jdvuhsyfkH
	 740QKQrFdg7Jw==
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3CB5C17E360D;
	Mon, 30 Sep 2024 18:37:44 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	Julia Lawall <julia.lawall@inria.fr>,
	kernel@collabora.com,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] drm/panthor: Fix access to uninitialized variable in tick_ctx_cleanup()
Date: Mon, 30 Sep 2024 18:37:42 +0200
Message-ID: <20240930163742.87036-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The group variable can't be used to retrieve ptdev in our second loop,
because it points to the previously iterated list_head, not a valid
group. Get the ptdev object from the scheduler instead.

Cc: <stable@vger.kernel.org>
Fixes: d72f049087d4 ("drm/panthor: Allow driver compilation")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202409302306.UDikqa03-lkp@intel.com/
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 201d5e7a921e..24ff91c084e4 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2052,6 +2052,7 @@ static void
 tick_ctx_cleanup(struct panthor_scheduler *sched,
 		 struct panthor_sched_tick_ctx *ctx)
 {
+	struct panthor_device *ptdev = sched->ptdev;
 	struct panthor_group *group, *tmp;
 	u32 i;
 
@@ -2060,7 +2061,7 @@ tick_ctx_cleanup(struct panthor_scheduler *sched,
 			/* If everything went fine, we should only have groups
 			 * to be terminated in the old_groups lists.
 			 */
-			drm_WARN_ON(&group->ptdev->base, !ctx->csg_upd_failed_mask &&
+			drm_WARN_ON(&ptdev->base, !ctx->csg_upd_failed_mask &&
 				    group_can_run(group));
 
 			if (!group_can_run(group)) {
@@ -2083,7 +2084,7 @@ tick_ctx_cleanup(struct panthor_scheduler *sched,
 		/* If everything went fine, the groups to schedule lists should
 		 * be empty.
 		 */
-		drm_WARN_ON(&group->ptdev->base,
+		drm_WARN_ON(&ptdev->base,
 			    !ctx->csg_upd_failed_mask && !list_empty(&ctx->groups[i]));
 
 		list_for_each_entry_safe(group, tmp, &ctx->groups[i], run_node) {
-- 
2.46.0


