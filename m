Return-Path: <stable+bounces-43097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863968BC64B
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 05:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9F21F2104B
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 03:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF043ABC;
	Mon,  6 May 2024 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRn0xDym"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680A43156
	for <stable@vger.kernel.org>; Mon,  6 May 2024 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967246; cv=none; b=EvoEwdBQe8zoNQM+sGAg2cqgzYorabC3nmssu/9RXdDgX1oOqrFaqxp9EoQo3xtX0pmdJp3DBtR69PgejrthUM3liltd1tbMtmdf6atNTKVScBgUu1on26ys+bN1hdJKXi06kmfhUJn+rc8L1oFfJD+a1WEgRM5MEItXocPSmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967246; c=relaxed/simple;
	bh=RK6yj4lD621S+Hs9R7/1VKnPvMeDk8oiL+OZurPhxpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n8L1krUgddR/ofUh1sxwCSudgDongTqyHzKimKo7AcafrkJyE+fLFhoe9orq7H5cjB9PcEyVP7f1WYQJ3QMVXdl3eSr2GHAKG8gOuWbD1RvgGDinnXIFfsGclTAJzyM6ucBRctHyvkze7WXnfIwRNcfD4MlDknsOPFxO+MjwwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRn0xDym; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714967245; x=1746503245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RK6yj4lD621S+Hs9R7/1VKnPvMeDk8oiL+OZurPhxpU=;
  b=RRn0xDymU+4xUjwG8b1d7scY4Mh9VATAmfx6OgWclSAP40IxJnjZRK1T
   O5bH4nLEJEskqq2674wE6vsHEGXX7vp89WOW0Rvu38XUEUC/h55ZY/nq7
   /A5NRBsLjuUuS7qnpvsCAaKLOWqSLHQ9oHdPweK6Z4xV6TKdf1xTc5HaL
   dCPFSG1ZlAm+u/lS0Z4wkxd6LKU7vJ+SEfJ5Qa6kusteZu6gwgez61eax
   rZvGeo+te6AqmcepBMhYPfFGWksv9bKBlllJfXVAXS98Y4G3L9baQbVb7
   1+HD9ixbvgJtUtIEpTPZhNh1XDkVwDg+NA85X4FN8Rx2vqBdQo0yxJ95I
   A==;
X-CSE-ConnectionGUID: AYpl2qMJRfWNSsh1CeFBYA==
X-CSE-MsgGUID: f7tcWQSWR2+447XN7fulBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10851833"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10851833"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 20:47:24 -0700
X-CSE-ConnectionGUID: IlFaKTaCTLGBGtJSQ/CQ0A==
X-CSE-MsgGUID: yHkKxu4TRDGk84s4435b/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28144728"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 20:47:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Use ordered WQ for G2H handler
Date: Sun,  5 May 2024 20:47:58 -0700
Message-Id: <20240506034758.3697397-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

System work queues are shared, use a dedicated work queue for G2H
processing to avoid G2H processing getting block behind system tasks.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ct.c       | 5 +++++
 drivers/gpu/drm/xe/xe_guc_ct.h       | 2 +-
 drivers/gpu/drm/xe/xe_guc_ct_types.h | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 8ac819a7061e..cc60c3333ce3 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -121,6 +121,7 @@ static void guc_ct_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc_ct *ct = arg;
 
+	destroy_workqueue(ct->g2h_wq);
 	xa_destroy(&ct->fence_lookup);
 }
 
@@ -146,6 +147,10 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
 
 	xe_gt_assert(gt, !(guc_ct_size() % PAGE_SIZE));
 
+	ct->g2h_wq = alloc_ordered_workqueue("xe-g2h-wq", 0);
+	if(!ct->g2h_wq)
+		return -ENOMEM;
+
 	spin_lock_init(&ct->fast_lock);
 	xa_init(&ct->fence_lookup);
 	INIT_WORK(&ct->g2h_worker, g2h_worker_func);
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
index 5083e099064f..105bb8e99a8d 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct.h
@@ -34,7 +34,7 @@ static inline void xe_guc_ct_irq_handler(struct xe_guc_ct *ct)
 		return;
 
 	wake_up_all(&ct->wq);
-	queue_work(system_unbound_wq, &ct->g2h_worker);
+	queue_work(ct->g2h_wq, &ct->g2h_worker);
 	xe_guc_ct_fast_path(ct);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ct_types.h b/drivers/gpu/drm/xe/xe_guc_ct_types.h
index d29144c9f20b..fede4c6e93cb 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct_types.h
@@ -120,6 +120,8 @@ struct xe_guc_ct {
 	wait_queue_head_t wq;
 	/** @g2h_fence_wq: wait queue used for G2H fencing */
 	wait_queue_head_t g2h_fence_wq;
+	/** @g2h_wq: used to process G2H */
+	struct workqueue_struct *g2h_wq;
 	/** @msg: Message buffer */
 	u32 msg[GUC_CTB_MSG_MAX_LEN];
 	/** @fast_msg: Message buffer */
-- 
2.34.1


