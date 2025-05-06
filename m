Return-Path: <stable+bounces-140366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C56AAA7E3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56A47AE2BB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896E343D65;
	Mon,  5 May 2025 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRl3yQE3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5146342C49;
	Mon,  5 May 2025 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484704; cv=none; b=kyCICLVwocbS7BGdaDVXIO4SOAv5zMtfFyqgRg2dKZp6ApomTGMKbPyWcfC4/U15anShYyxOldT3arGIn55XDOhS3V0yObMIEimZ7w1+QDQMFdQqgLcsJwSARJz/w43aludqRuCoYdVujjqaW4ZxJq/psOKW1yxwCMZM6K973e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484704; c=relaxed/simple;
	bh=lezU5NsjbYIMJJZt0x5J6+DVey+U20nESnU8t++H3uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajI+Qe665I3f2ZQ4iF+RJkwkTGvapvT/FgFggvRpe9hbrI1Ifulc8Q7fXz66LqwL6hWyn45bvobZOqhquWecUr2QJ1MVx4u4YKdUqx/PQEkVMWc4m/1YPwoU5zoFkUWV1Hw6QQjYOEha8WPAructwpyC2zCpPOFlzEUrDKlcFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRl3yQE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D335C4CEE4;
	Mon,  5 May 2025 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484704;
	bh=lezU5NsjbYIMJJZt0x5J6+DVey+U20nESnU8t++H3uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRl3yQE3ARCqO2ISkJqme9cFkGvfn9fnOAwiyrdjmJhzZwpNouwjGEgztYdvDoPph
	 VOlDUTX1GyHem88g6ura720UjycKTXIsst0t+Wfy9HzZtS5nw89lqtf8UzpZ3J9vZp
	 yg+sw+3jFWXLyn2systM2NdsUCAgxfd639Voef2dwX5vwgRrEUHnXGLx5fqe9PzJb+
	 aqsnFspAbvIuIpu+poHi3VKufgfqbeLNs/x2dgEkpf9CNNlTtH3vF2hKNKmr74J8q6
	 5TDSIIUPKxK//aErYzL8bv6xP/ykUW3FKcdRLlZfx70mc1Xwsm4WeZcm/Bp09hinHV
	 1ktbPr2kx7uSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 617/642] drm/xe: Add locks in gtidle code
Date: Mon,  5 May 2025 18:13:53 -0400
Message-Id: <20250505221419.2672473-617-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

[ Upstream commit d160dc6f53914d729be7fcb7afbd0e9e6a3725b2 ]

The update of the residency values needs to be protected by a lock to
avoid multiple entrypoints, for example when multiple userspace clients
read the sysfs file. Other in-kernel clients are going to be added to
sample these values, making the problem worse. Protect those updates
with a raw_spinlock so it can be called by future integration with perf
pmu.

Suggested-by: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250110173308.2412232-2-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_idle.c       | 23 ++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_gt_idle.h       |  1 +
 drivers/gpu/drm/xe/xe_gt_idle_types.h |  3 +++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_idle.c b/drivers/gpu/drm/xe/xe_gt_idle.c
index ffd3ba7f66561..fbbace7b0b12a 100644
--- a/drivers/gpu/drm/xe/xe_gt_idle.c
+++ b/drivers/gpu/drm/xe/xe_gt_idle.c
@@ -69,6 +69,8 @@ static u64 get_residency_ms(struct xe_gt_idle *gtidle, u64 cur_residency)
 {
 	u64 delta, overflow_residency, prev_residency;
 
+	lockdep_assert_held(&gtidle->lock);
+
 	overflow_residency = BIT_ULL(32);
 
 	/*
@@ -275,8 +277,21 @@ static ssize_t idle_status_show(struct device *dev,
 
 	return sysfs_emit(buff, "%s\n", gt_idle_state_to_string(state));
 }
-static DEVICE_ATTR_RO(idle_status);
 
+u64 xe_gt_idle_residency_msec(struct xe_gt_idle *gtidle)
+{
+	struct xe_guc_pc *pc = gtidle_to_pc(gtidle);
+	u64 residency;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&gtidle->lock, flags);
+	residency = get_residency_ms(gtidle, gtidle->idle_residency(pc));
+	raw_spin_unlock_irqrestore(&gtidle->lock, flags);
+
+	return residency;
+}
+
+static DEVICE_ATTR_RO(idle_status);
 static ssize_t idle_residency_ms_show(struct device *dev,
 				      struct device_attribute *attr, char *buff)
 {
@@ -285,10 +300,10 @@ static ssize_t idle_residency_ms_show(struct device *dev,
 	u64 residency;
 
 	xe_pm_runtime_get(pc_to_xe(pc));
-	residency = gtidle->idle_residency(pc);
+	residency = xe_gt_idle_residency_msec(gtidle);
 	xe_pm_runtime_put(pc_to_xe(pc));
 
-	return sysfs_emit(buff, "%llu\n", get_residency_ms(gtidle, residency));
+	return sysfs_emit(buff, "%llu\n", residency);
 }
 static DEVICE_ATTR_RO(idle_residency_ms);
 
@@ -331,6 +346,8 @@ int xe_gt_idle_init(struct xe_gt_idle *gtidle)
 	if (!kobj)
 		return -ENOMEM;
 
+	raw_spin_lock_init(&gtidle->lock);
+
 	if (xe_gt_is_media_type(gt)) {
 		snprintf(gtidle->name, sizeof(gtidle->name), "gt%d-mc", gt->info.id);
 		gtidle->idle_residency = xe_guc_pc_mc6_residency;
diff --git a/drivers/gpu/drm/xe/xe_gt_idle.h b/drivers/gpu/drm/xe/xe_gt_idle.h
index 4455a6501cb07..591a01e181bcc 100644
--- a/drivers/gpu/drm/xe/xe_gt_idle.h
+++ b/drivers/gpu/drm/xe/xe_gt_idle.h
@@ -17,5 +17,6 @@ void xe_gt_idle_disable_c6(struct xe_gt *gt);
 void xe_gt_idle_enable_pg(struct xe_gt *gt);
 void xe_gt_idle_disable_pg(struct xe_gt *gt);
 int xe_gt_idle_pg_print(struct xe_gt *gt, struct drm_printer *p);
+u64 xe_gt_idle_residency_msec(struct xe_gt_idle *gtidle);
 
 #endif /* _XE_GT_IDLE_H_ */
diff --git a/drivers/gpu/drm/xe/xe_gt_idle_types.h b/drivers/gpu/drm/xe/xe_gt_idle_types.h
index b8b297a3f8848..a3667c567f8a7 100644
--- a/drivers/gpu/drm/xe/xe_gt_idle_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_idle_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_GT_IDLE_SYSFS_TYPES_H_
 #define _XE_GT_IDLE_SYSFS_TYPES_H_
 
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 struct xe_guc_pc;
@@ -31,6 +32,8 @@ struct xe_gt_idle {
 	u64 cur_residency;
 	/** @prev_residency: previous residency counter */
 	u64 prev_residency;
+	/** @lock: Lock protecting idle residency counters */
+	raw_spinlock_t lock;
 	/** @idle_status: get the current idle state */
 	enum xe_gt_idle_state (*idle_status)(struct xe_guc_pc *pc);
 	/** @idle_residency: get idle residency counter */
-- 
2.39.5


