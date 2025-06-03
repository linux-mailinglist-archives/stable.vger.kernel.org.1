Return-Path: <stable+bounces-150743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B47AEACCC59
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08F8188DD72
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B601D8E07;
	Tue,  3 Jun 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kN/4VM9S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3BD1361
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972654; cv=none; b=PIA70xd+z61w1iUF+p4unI1L6VjwNpscC9GlVj1y2VOH+Iz4+sA3Y9/ZqR1KRYZPEusZRucxNaLNU3hj2rzJ4NY6OPjcDXxvXH/RcPympMiOugSJXSKZAeZRMI0pSHBDnqGrQLpzmJOvX/awiSZzzbzzLjp7QjAa4Ml3zN5pBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972654; c=relaxed/simple;
	bh=gkU+QWlpAX+NBjL3w7KK5c2bREwP/6LUPDPozrAIHrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0QA4hbhQZqQrm7q939DXAH8tvHuioRBJM60pTXZIKGr0VuFsOvjXS753LXB3bdmwYJqToA+ZeoYBh7jubsLP0uatQ1lq+2zhnUsEn1ErnI3wL6aWdWo6D3mcRXN6/BafVP4+tbc43VgypQZVSAAAAMfCr/LGegrpNQ05vBIz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kN/4VM9S; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748972653; x=1780508653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gkU+QWlpAX+NBjL3w7KK5c2bREwP/6LUPDPozrAIHrM=;
  b=kN/4VM9SBUljBglq/9zyvFNz2K5Xt7/EEZbcT3EWFnyP6V1fWjAz3ab9
   sgUKrqIPC1emXfEsNjE9hpSX7WUbFOvfM6paaJ8Wi9kPnIvfYZpOPB4++
   vyCupEHdbfQxs4uEqJJNyxsLSInZ950IYQkqkvSj9y0c0nBzmRiK8pbSr
   RKJdkg9Mwv4xvFikEdYARlgs7brPWdhEgX0UudWvb+qoHqcnVioj08Vme
   RQPc2ZJ7WwZYajr0fgtv+pwWf7XzZG/+TAzBL9LNXze4/D63kQOrNNRca
   /aimO6O7cAQUfw1yZPcwfwRXXUb7wPZlxVuNsISOalnkv7qWkkaBQFLQ5
   g==;
X-CSE-ConnectionGUID: x+F7fnc3TP6gYD9M8OLzkw==
X-CSE-MsgGUID: rIjrmphqSheBpmBZJuZ2DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51127051"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="51127051"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:44:12 -0700
X-CSE-ConnectionGUID: WTAvGLAeQmOkpz/uDGXYVw==
X-CSE-MsgGUID: ePQKOApARAWCxB24b+HwHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144901291"
Received: from opintica-mobl1 (HELO mwauld-desk.intel.com) ([10.245.244.166])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:44:11 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/guc_submit: add back fix
Date: Tue,  3 Jun 2025 18:42:14 +0100
Message-ID: <20250603174213.1543579-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Daniele noticed that the fix in commit 2d2be279f1ca ("drm/xe: fix UAF
around queue destruction") looks to have been unintentionally removed as
part of handling a conflict in some past merge commit. Add it back.

Fixes: ac44ff7cec33 ("Merge tag 'drm-xe-fixes-2024-10-10' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes")
Reported-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 80f748baad3f..2b61d017eeca 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -229,6 +229,17 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
 static void guc_submit_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc *guc = arg;
+	struct xe_device *xe = guc_to_xe(guc);
+	struct xe_gt *gt = guc_to_gt(guc);
+	int ret;
+
+	ret = wait_event_timeout(guc->submission_state.fini_wq,
+				 xa_empty(&guc->submission_state.exec_queue_lookup),
+				 HZ * 5);
+
+	drain_workqueue(xe->destroy_wq);
+
+	xe_gt_assert(gt, ret);
 
 	xa_destroy(&guc->submission_state.exec_queue_lookup);
 }
-- 
2.49.0


