Return-Path: <stable+bounces-94667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EAB9D6536
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2898916194D
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0A1DFDAE;
	Fri, 22 Nov 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBcRmik9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96EB1DFDA2
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309677; cv=none; b=WR9PC5eY0IoOKnlydDWtdP0RWf5pU/fFOtenKIfr3sw3zLrqZ8L3KGnxEoXmuwGuyQXpGu58sv9N+ptrvR0hCznTTH0Czq1yh+5KueU6FYgsIa6BgUOVoOCZjG/tg3gEv+m6uf/F4vuPhMEaAtqrlMyo10x/FJVQmWiZBP+diKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309677; c=relaxed/simple;
	bh=LtknylRL/lo8D7FJWpWhpHXYfNsmxJArrHridOai6BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeTa906aTpBiRcWiGRDEKdJy4n37x0RYFt9temNEPplli94z+LyvfXEZYbYkVpuvutoAEQMqYXlOQG8sir4ex2tINU9ybz0uvF5nRGGNkKJXQM5PgbBbjXbtFMH5pxz/KWy4m4MxfeF5YbG4BNWK3zemrPK9K1EdTM/imqK7sVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBcRmik9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309675; x=1763845675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LtknylRL/lo8D7FJWpWhpHXYfNsmxJArrHridOai6BM=;
  b=nBcRmik9LM0f3LzG1U0xCIUyURZzoMeqWkIs3lX/sglvOWjlDOGT6fSU
   iktTQmjt5+ly9wzvatQfkC8z/ZGcNXDaHjZTt8LIfdBub6gXl3MH9s6yk
   At5b09hiijyvAK2/j1iRWqV4xXgedppedjBxzjmptT07n2JtDvUS1hWOq
   vEYNXaxHLHiUkgMcqH3yRoQbpECr38fjGdmQPgXQD7KgGgz3tB1gps96J
   h7GWozDKj+OyDYvaOamFnXlYRDs6LXLPQ9c/evNdkM5liocoO69czQdVB
   wvoXAnB1+8SporrxX5w4WjMyZeNbgUUqsEEM2EIn0pX5dxdqFe/9/ZfTk
   g==;
X-CSE-ConnectionGUID: P/7ZT61ASBOKh5deh/0erA==
X-CSE-MsgGUID: g+sHSIHFQlKiiDUHYwyMeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878286"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878286"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
X-CSE-ConnectionGUID: zPkrd04rS4GvIUECiSJPng==
X-CSE-MsgGUID: EzbaQISMSz2o5udBOXR7Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457297"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Vitasta Wattal <vitasta.wattal@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 29/31] drm/xe/bmg: improve cache flushing behaviour
Date: Fri, 22 Nov 2024 13:07:17 -0800
Message-ID: <20241122210719.213373-30-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Auld <matthew.auld@intel.com>

commit 6df106e93f79fb7dc90546a2d93bb3776b42863e upstream.

The BSpec says that EN_L3_RW_CCS_CACHE_FLUSH must be toggled
on for manual global invalidation to take effect and actually flush
device cache, however this also turns on flushing for things like
pipecontrol, which occurs between submissions for compute/render. This
sounds like massive overkill for our needs, where we already have the
manual flushing on the display side with the global invalidation. Some
observations on BMG:

1. Disabling l2 caching for host writes and stubbing out the driver
   global invalidation but keeping EN_L3_RW_CCS_CACHE_FLUSH enabled, has
   no impact on wb-transient-vs-display IGT, which makes sense since the
   pipecontrol is now flushing the device cache after the render copy.
   Without EN_L3_RW_CCS_CACHE_FLUSH the test then fails, which is also
   expected since device cache is now dirty and display engine can't see
   the writes.

2. Disabling EN_L3_RW_CCS_CACHE_FLUSH, but keeping the driver global
   invalidation also has no impact on wb-transient-vs-display. This
   suggests that the global invalidation still works as expected and is
   flushing the device cache without EN_L3_RW_CCS_CACHE_FLUSH turned on.

With that drop EN_L3_RW_CCS_CACHE_FLUSH. This helps some workloads since
we no longer flush the device cache between submissions as part of
pipecontrol.

Edit: We now also have clarification from HW side that BSpec was indeed
wrong here.

v2:
  - Rebase and update commit message.

BSpec: 71718
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Vitasta Wattal <vitasta.wattal@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241007074541.33937-2-matthew.auld@intel.com
(cherry picked from commit 67ec9f87bd6c57db1251bb2244d242f7ca5a0b6a)
[ Fix conflict due to changed xe_mmio_write32() signature ]
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 3 ---
 drivers/gpu/drm/xe/xe_gt.c           | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 224ab4a425258..bd604b9f08e4f 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -393,9 +393,6 @@
 
 #define XE2_GLOBAL_INVAL			XE_REG(0xb404)
 
-#define SCRATCH1LPFC				XE_REG(0xb474)
-#define   EN_L3_RW_CCS_CACHE_FLUSH		REG_BIT(0)
-
 #define XE2LPM_L3SQCREG2			XE_REG_MCR(0xb604)
 
 #define XE2LPM_L3SQCREG3			XE_REG_MCR(0xb608)
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index ba9f50c1faa67..a4a5c012a1b0b 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -108,7 +108,6 @@ static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 		return;
 
 	if (!xe_gt_is_media_type(gt)) {
-		xe_mmio_write32(gt, SCRATCH1LPFC, EN_L3_RW_CCS_CACHE_FLUSH);
 		reg = xe_gt_mcr_unicast_read_any(gt, XE2_GAMREQSTRM_CTRL);
 		reg |= CG_DIS_CNTLBUS;
 		xe_gt_mcr_multicast_write(gt, XE2_GAMREQSTRM_CTRL, reg);
-- 
2.47.0


