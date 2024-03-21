Return-Path: <stable+bounces-28533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A7885871
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 12:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432D11F21F85
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87CD58AD1;
	Thu, 21 Mar 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzK58+0h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0458AA6
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021059; cv=none; b=AdkWVrJZrr+h/94vbp7ZKDE8ZcuAvBzW1nh7GLKMYUVXyHZWukc1yhz7O7f04s+kFDD93S7yUEHCWmovLECE6NatpsumcPq3V6pMuaiIDX3PIxT09GcplYgWPfMmkPMhXswTlPcGrC4M6FZjtkDyCp6cks7bFl5BYHamnUP98PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021059; c=relaxed/simple;
	bh=WtN0UBCWMg2Zq7F9H7sTe8kq/+Y/RtD7ichY8UYUJAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqFXy1emhWIqp9oMOq+w2yoKeSAeVOJtcSkDNn92CR5BEHTLojIWYPkVcFDPab75YLaJBps5AFvnYCoVdqSmN04pG9muZt9XErqUj+rO/83gPtZthJ5nFfo1rTAs+ccO4zAu/OuIFcZReVElvvh0phqMcKJaXq9TZGdXSCGeVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzK58+0h; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711021058; x=1742557058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WtN0UBCWMg2Zq7F9H7sTe8kq/+Y/RtD7ichY8UYUJAo=;
  b=CzK58+0hLHQ2RQXiPbvbl/gs7DpTp6BMOG3V+6ZI+F0MdKczCQgfOjqo
   P8IG/6VR0pmZVgalDB2udmPVjUywZEhHjfIbLDpbbU21nuCNIgLEoz06Z
   NU1UA5/AmtnlKQpjy2oEuDqhj6RXQlj/KFa0ps2ya1VT1aAKOWED0Zzs1
   p0V55MKx/M8vH0goVryc8C3oUExEhSdt8Eqcf4iVSGNGT8SHdXI1nDpg1
   IHM3ESSmIgyfUtAu2t+cuSiMTxQkFUHQ9hNjB/HcsK8J16CU8cugVxyBd
   +erfnKOSzwz41/JSRbpH0F4Wl4svdgfJZwE38UmrZF7bFFSw/ADm+rZDs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127331"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127331"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:37:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="19053230"
Received: from dinieasx-mobl1.gar.corp.intel.com (HELO fedora..) ([10.249.254.100])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:37:36 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] drm/xe: Make TLB invalidation fences unordered
Date: Thu, 21 Mar 2024 12:37:10 +0100
Message-ID: <20240321113720.120865-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

They can actually complete out-of-order, so allocate a unique
fence context for each fence.

Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after rebinds issued from execs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 1 -
 drivers/gpu/drm/xe/xe_gt_types.h            | 7 -------
 drivers/gpu/drm/xe/xe_pt.c                  | 3 +--
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index a3c4ffba679d..787cba5e49a1 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -63,7 +63,6 @@ int xe_gt_tlb_invalidation_init(struct xe_gt *gt)
 	INIT_LIST_HEAD(&gt->tlb_invalidation.pending_fences);
 	spin_lock_init(&gt->tlb_invalidation.pending_lock);
 	spin_lock_init(&gt->tlb_invalidation.lock);
-	gt->tlb_invalidation.fence_context = dma_fence_context_alloc(1);
 	INIT_DELAYED_WORK(&gt->tlb_invalidation.fence_tdr,
 			  xe_gt_tlb_fence_timeout);
 
diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
index f6da2ad9719f..2143dffcaf11 100644
--- a/drivers/gpu/drm/xe/xe_gt_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_types.h
@@ -179,13 +179,6 @@ struct xe_gt {
 		 * xe_gt_tlb_fence_timeout after the timeut interval is over.
 		 */
 		struct delayed_work fence_tdr;
-		/** @tlb_invalidation.fence_context: context for TLB invalidation fences */
-		u64 fence_context;
-		/**
-		 * @tlb_invalidation.fence_seqno: seqno to TLB invalidation fences, protected by
-		 * tlb_invalidation.lock
-		 */
-		u32 fence_seqno;
 		/** @tlb_invalidation.lock: protects TLB invalidation fences */
 		spinlock_t lock;
 	} tlb_invalidation;
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 8d3922d2206e..a5bb8d20f815 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1135,8 +1135,7 @@ static int invalidation_fence_init(struct xe_gt *gt,
 	spin_lock_irq(&gt->tlb_invalidation.lock);
 	dma_fence_init(&ifence->base.base, &invalidation_fence_ops,
 		       &gt->tlb_invalidation.lock,
-		       gt->tlb_invalidation.fence_context,
-		       ++gt->tlb_invalidation.fence_seqno);
+		       dma_fence_context_alloc(1), 1);
 	spin_unlock_irq(&gt->tlb_invalidation.lock);
 
 	INIT_LIST_HEAD(&ifence->base.link);
-- 
2.44.0


