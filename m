Return-Path: <stable+bounces-195126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 112CAC6B64A
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 20:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D04A5359B69
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212142F7ACB;
	Tue, 18 Nov 2025 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5jzR0TA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634572D7814
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492935; cv=none; b=RBW/dYIkL5OCAb086IYnRzvmR4ZRpuzZ1RzMAKO7zfVfP8Tmnlp0OTK22Y2Pm39eTAizaIdvu10u3Fd64hPg3sbFUtIX+eE32AY6I8T0J0qQXJPG3KmbWt+2fHGG+Y0VODtlTHtJEXfAoeALXrw4hE5blUJbtzYM57m67B/OZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492935; c=relaxed/simple;
	bh=kkuvldVXERFE72Asnf7S8mCnwdNcAL3Pvr/dIhFfr5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mw5MckE56WltDCVSsixsm96nZcITZ5FyLW4W3Us+p+1MOKIaPqjwrwVxsYwY4qTNkE8aekyNa352RuQdv6/rUGGzSbQFck4TuGcoRiwkU3NNdJg3Oei9Ye5Gx8letHSMngqxRWb2c+tmhjX3sDYed6GEBL5W0V6ztK1/fWpK9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5jzR0TA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763492934; x=1795028934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkuvldVXERFE72Asnf7S8mCnwdNcAL3Pvr/dIhFfr5o=;
  b=R5jzR0TAaH9NLHD6MwDA5AhbneBR1KMqtQAAHrYOREcpazFt3EYe5X5A
   kaTG29xaCOdc8REfCXNnzsQIrQ5/8BHtKqF+3brIqUAsjw+us/RQxvFG+
   uvhRdWhlCtbn2wBk4T102rqbG7fq7WNOBgMPzc1oZ9R/Zpf/S6rzELzFE
   RX4es3f4XKaPmfQKORNM3VU+tPabiaQTTG7ILP/77Plg7uu/GgwUPGOeT
   k6fAE0yv3DLzOeG8oIT3NLoVP+/uLRasjES4qltA5L+0WdotOFkvpGlGy
   3CZLOlOVt7Z1srVEGnIjzMlYEaFY0r9BSBY6Mz8Wr6ls2kA+FHW74tUUG
   g==;
X-CSE-ConnectionGUID: tPyOUKlNQFarE6YgKv+9Jw==
X-CSE-MsgGUID: iDVnZCuKQOeIB9enzdEdLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68132372"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="68132372"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:08:52 -0800
X-CSE-ConnectionGUID: 0e2VV+z2TSS0Zr875llZBA==
X-CSE-MsgGUID: wsG1DUp2RKalDs5awkSxRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191627280"
Received: from lucas-s2600cw.jf.intel.com ([10.54.55.69])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:08:51 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Sagar Ghuge <sagar.ghuge@intel.com>,
	Stuart Summers <stuart.summers@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
Date: Tue, 18 Nov 2025 11:08:11 -0800
Message-ID: <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
References: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-50d74
Content-Transfer-Encoding: 8bit

Add missing stack_depot_init() call when CONFIG_DRM_XE_DEBUG_GUC is
enabled to fix the following call stack:

	[] BUG: kernel NULL pointer dereference, address: 0000000000000000
	[] Workqueue:  drm_sched_run_job_work [gpu_sched]
	[] RIP: 0010:stack_depot_save_flags+0x172/0x870
	[] Call Trace:
	[]  <TASK>
	[]  fast_req_track+0x58/0xb0 [xe]

Fixes: 16b7e65d299d ("drm/xe/guc: Track FAST_REQ H2Gs to report where errors came from")
Tested-by: Sagar Ghuge <sagar.ghuge@intel.com>
Cc: <stable@vger.kernel.org> # v6.17+
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 2697d711adb2b..07ae0d601910e 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -236,6 +236,9 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
 	spin_lock_init(&ct->dead.lock);
 	INIT_WORK(&ct->dead.worker, ct_dead_worker_func);
+#if IS_ENABLED(CONFIG_DRM_XE_DEBUG_GUC)
+	stack_depot_init();
+#endif
 #endif
 	init_waitqueue_head(&ct->wq);
 	init_waitqueue_head(&ct->g2h_fence_wq);

-- 
2.51.2


