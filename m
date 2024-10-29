Return-Path: <stable+bounces-89183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC2D9B46FE
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0431C219F5
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C40204934;
	Tue, 29 Oct 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvfR1dc5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583892038D9
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198187; cv=none; b=fpEcqaJp1chD2DeMbmF7+M/EonTS4OcocLC712yKX8uTUrdBMyxNsAwXq8RyutcBKvg5Wllw9SKFea+qaDCXABmQfsdNbFI7t/CpEx29IxrxLrKAQjn9rmrWA/fr57AIf/U6F5Y98KlcOoNmPD/ld0fy5X/suLaIcE54WKPzO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198187; c=relaxed/simple;
	bh=TfYlddEc+mTaAbptWrPgXIGlpXBF4yyNfdMmgVGflyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx0GAgSgLHgnZ3Nnb27QdD9vM6vYuJBWH4I5+GpCP21GJWQ4WlNQTB3mEwV/0G8Fg9+f77EGtxRL+a01+8Fzu1EyRw0AUEhxtAUELA9lENyJ3vNrI73csH55X8cilsjWYnx570ij8WHo3Kel3PZJ/VUb1L5pilw40cIBEdHmrS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvfR1dc5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730198185; x=1761734185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfYlddEc+mTaAbptWrPgXIGlpXBF4yyNfdMmgVGflyo=;
  b=YvfR1dc5I0aePsa9dLa8K9yjCVXHuGo2zSt/S2l+fIkzscNiDsHeEHrW
   JAE/vWk0CzFR6XqRxdDObXvBuJxFMwwOToSUdo5o3kQxrI6IMalw1l8HL
   UbyJAsB8BZkgwIEFBGHiL69rg0bqbAUogT0uS0Msiukq/+/29XL+BbqzJ
   Ws/gmVTQnWHcPAooYSePoAbjoS0ElDSVOnUrNOBOP0r3Uues25t8Ci3sp
   SSi/Nz6htr+SQc5jvDQGIJH5qsp70ziGjwdp7oRmT3oBD2ZizL+IsM3W6
   3fmzmWUxk7DnXWxGMNOQ8gw8c2xyehrDzMYHo8BuwfiCBomqkEuvDGiTe
   Q==;
X-CSE-ConnectionGUID: c9rq2RZwTUe4EBHJDuPqNg==
X-CSE-MsgGUID: dN1LobaMQaGt5nl7Q6tEwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29937683"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29937683"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:36:25 -0700
X-CSE-ConnectionGUID: 6B/UW57CSwe2cUGYz+s1fA==
X-CSE-MsgGUID: ZKZ1k5I3Q9W4nCdFgzdEIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="105262797"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:36:23 -0700
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
Subject: [PATCH v4 3/3] drm/xe/guc/tlb: Flush g2h worker in case of tlb timeout
Date: Tue, 29 Oct 2024 10:54:16 +0100
Message-ID: <20241029095416.3919218-3-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029095416.3919218-1-nirmoy.das@intel.com>
References: <20241029095416.3919218-1-nirmoy.das@intel.com>
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
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index 773de1f08db9..0bdb3ba5220a 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -81,6 +81,15 @@ static void xe_gt_tlb_fence_timeout(struct work_struct *work)
 		if (msecs_to_jiffies(since_inval_ms) < tlb_timeout_jiffies(gt))
 			break;
 
+		LNL_FLUSH_WORK(&gt->uc.guc.ct.g2h_worker);
+		since_inval_ms = ktime_ms_delta(ktime_get(),
+						fence->invalidation_time);
+		if (msecs_to_jiffies(since_inval_ms) < tlb_timeout_jiffies(gt)) {
+			xe_gt_dbg(gt, "LNL_FLUSH_WORK resolved TLB invalidation fence timeout, seqno=%d recv=%d",
+				  fence->seqno, gt->tlb_invalidation.seqno_recv);
+			break;
+		}
+
 		trace_xe_gt_tlb_invalidation_fence_timeout(xe, fence);
 		xe_gt_err(gt, "TLB invalidation fence timeout, seqno=%d recv=%d",
 			  fence->seqno, gt->tlb_invalidation.seqno_recv);
-- 
2.46.0


