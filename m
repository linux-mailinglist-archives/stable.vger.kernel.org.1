Return-Path: <stable+bounces-116696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C4BA3981C
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA021881E0D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E522B8CA;
	Tue, 18 Feb 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEAI+5HQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAF22B8B9
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873042; cv=none; b=I3ea3Y6Fu8f+LYo0c47D6oxDfqi3r/0n+8BEmmHPODt0K+3xAoltwd/WWvGV7VKKI5XZMea0+B+eLznvKmCgeSk+/8jm+CPAxSOpNx4+Y98tgKB0uXF4iyYMBLbaEmXu+XksOycOBvry0wcDKg+mH+QEqCzbdM+Sdwa2IvTo0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873042; c=relaxed/simple;
	bh=pbjfnE9HZCkMOLVmjETIUig4+GqCqmpYo/9Mb0qYsbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVpJvyh3paJ6x1u1Q77ayfwCPhfWkb6vnsoz3MG58GXZafrbrtdLBrDWys85+/PzXLnQzkCsxKkuFJRoTKN05iExtDslzbMez2wREUPdSu3XF7o3A3K1+LzM/5LGsQ2v3+2e8J/unT5ZE3waA3cGrcfjE9SRF6UaroiXcdsCwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEAI+5HQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739873041; x=1771409041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pbjfnE9HZCkMOLVmjETIUig4+GqCqmpYo/9Mb0qYsbA=;
  b=kEAI+5HQpoBbKRwj26jGWiVVthUGo8ZDjq1lziQlywOGijWUT9hKRHPu
   pmFaS+Wq1wQWG9c4GqJxz7zpglU7ste6cg2libxZ8Gw+GUQ4NADGpV7gK
   A7VvGXHzplwjLt4hrrHWp0Gj2NFndy6TVCHzYMOCGvGsUm43FSz9Hq9sK
   yvQjkW0CD75KF2P5QkkkfCbrbnvleKWi8P6rK2Iwfwy5yx9aFvvTYdWvB
   KylCQQScng6lwA/6R5iMssSfFlUeTLc5itFV+76joBJmmmrFpAuTkTbjv
   8e+o2U1HTaCcrlEedqhMF/cTSjR6rzDmpc/Bpd9ie1PrPcW88XKma4nmE
   w==;
X-CSE-ConnectionGUID: KgS6RItMRZyO0jRPTKjfEg==
X-CSE-MsgGUID: Mdpz1LoWQ5WR902Gw02/ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="43392539"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="43392539"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 02:04:00 -0800
X-CSE-ConnectionGUID: lVCtNglrTji1fTt9b5jeTA==
X-CSE-MsgGUID: MYQ9djApRZGgCYSc+/APpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145201549"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 02:03:56 -0800
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH] drm/xe: Fix exporting xe buffers multiple times
Date: Tue, 18 Feb 2025 11:03:53 +0100
Message-ID: <20250218100353.2137964-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>

The `struct ttm_resource->placement` contains TTM_PL_FLAG_* flags, but
it was incorrectly tested for XE_PL_* flags.
This caused xe_dma_buf_pin() to always fail when invoked for
the second time. Fix this by checking the `mem_type` field instead.

Fixes: 7764222d54b7 ("drm/xe: Disallow pinning dma-bufs in VRAM")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_bo.h      | 2 --
 drivers/gpu/drm/xe/xe_dma_buf.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index d9386ab031404..43bf6f140d40d 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -341,7 +341,6 @@ static inline unsigned int xe_sg_segment_size(struct device *dev)
 	return round_down(max / 2, PAGE_SIZE);
 }
 
-#if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
 /**
  * xe_bo_is_mem_type - Whether the bo currently resides in the given
  * TTM memory type
@@ -356,4 +355,3 @@ static inline bool xe_bo_is_mem_type(struct xe_bo *bo, u32 mem_type)
 	return bo->ttm.resource->mem_type == mem_type;
 }
 #endif
-#endif
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index c5b95470fa324..f67803e15a0e6 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -58,7 +58,7 @@ static int xe_dma_buf_pin(struct dma_buf_attachment *attach)
 	 * 1) Avoid pinning in a placement not accessible to some importers.
 	 * 2) Pinning in VRAM requires PIN accounting which is a to-do.
 	 */
-	if (xe_bo_is_pinned(bo) && bo->ttm.resource->placement != XE_PL_TT) {
+	if (xe_bo_is_pinned(bo) && !xe_bo_is_mem_type(bo, XE_PL_TT)) {
 		drm_dbg(&xe->drm, "Can't migrate pinned bo for dma-buf pin.\n");
 		return -EINVAL;
 	}
-- 
2.45.1


