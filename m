Return-Path: <stable+bounces-89192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17809B49EF
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB3F1C20E52
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 12:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63EB1EB9E6;
	Tue, 29 Oct 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeLNbxGP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AAE1E480
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205807; cv=none; b=D2xfRdrV4565K63sImGtANeNmeDpqa0krMKNE7x6YN+HqoEb3iwgqyoCxu3pF6mZbLiQwMDudWAjfVxDfMff8G8lVOWTjvnsF6jvm+XLjWLBeAD8fVlYUxddRwLO09SOeNKc+eCUazWsLIZ6+ijfx40tXXwGueV3Fvi55xeBpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205807; c=relaxed/simple;
	bh=gV9o3ws1GAPBIVjNBH7xu5paAV+0ZjKwc3K4H1broVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOeFmctzJWiHSGXpfPSrlWV0OW84v81ux3Y/T2Y5WwNZ21+Rs9KMadi7kGs6A98vuGf+hlXAbIrOMxE4Q1GX/NGBRnhwddecccOwoEjrF8/I9u6KCwaC5Q2GyEOtcOqXmmS6aCjwA/sUq7rNwuxGw/GZ7iiBSuY2WzIuHIWEFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeLNbxGP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730205805; x=1761741805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gV9o3ws1GAPBIVjNBH7xu5paAV+0ZjKwc3K4H1broVI=;
  b=IeLNbxGPp1hTtXT5ibxDILHhsk48rz4mS7oXd0HdyvEd2ddQKeKF5Bzq
   fmBCy9Nzj4LB21uWVg6049DUA38QfR4CqX1VXVf2totegBcgDcQNMWGrY
   tCBxkruQ3I/d2+qma67IaR+KWHdWEZRnKVMlStfw1u4HwNZAdPImsjtxH
   OU8x8qyB+NhgWbI7SK7CVohvffrxVdeGwFDxYeChaQOOBmPFQ53nwy/4s
   e3P+TM2DsQYt4QjRL8iQPw3hGe1muSFyTzHyrx9aHJFiqqrFXqXFK+EOi
   TbVHH1FmfevlESbCuZFPdbxMB/KkPLRTuGxwIqUrzdwm5i1llmP9wHEQN
   Q==;
X-CSE-ConnectionGUID: VSSIXg5SQ36S/RvBsKYpcQ==
X-CSE-MsgGUID: tmIb5bMZRfWBRZ04fDmwbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29950452"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29950452"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:43:25 -0700
X-CSE-ConnectionGUID: 4dxTVPNcRyWhXS4fi+zZTA==
X-CSE-MsgGUID: IJkkdzU1SJigOA3VbX96QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82021961"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:43:23 -0700
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 3/3] drm/xe/guc/tlb: Flush g2h worker in case of tlb timeout
Date: Tue, 29 Oct 2024 13:01:17 +0100
Message-ID: <20241029120117.449694-3-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029120117.449694-1-nirmoy.das@intel.com>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

Flush the g2h worker explicitly if TLB timeout happens which is
observed on LNL and that points to the recent scheduling issue with
E-cores on LNL.

This is similar to the recent fix:
commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
response timeout") and should be removed once there is E core
scheduling fix.

v2: Add platform check(Himal)
v3: Remove gfx platform check as the issue related to cpu
    platform(John)
    Use the common WA macro(John) and print when the flush
    resolves timeout(Matt B)
v4: Remove the resolves log and do the flush before taking
    pending_lock(Matt A)

Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2687
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index 773de1f08db9..3cb228c773cd 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -72,6 +72,8 @@ static void xe_gt_tlb_fence_timeout(struct work_struct *work)
 	struct xe_device *xe = gt_to_xe(gt);
 	struct xe_gt_tlb_invalidation_fence *fence, *next;
 
+	LNL_FLUSH_WORK(&gt->uc.guc.ct.g2h_worker);
+
 	spin_lock_irq(&gt->tlb_invalidation.pending_lock);
 	list_for_each_entry_safe(fence, next,
 				 &gt->tlb_invalidation.pending_fences, link) {
-- 
2.46.0


