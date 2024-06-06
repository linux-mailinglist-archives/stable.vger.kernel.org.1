Return-Path: <stable+bounces-48251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A2E8FDB50
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 02:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6401F212DA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 00:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CF71C2E;
	Thu,  6 Jun 2024 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnNJVOxX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176511361
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633054; cv=none; b=Ry0bduLpTaFOKbmUboh5772CBacnUFNMh7nB7mLKwvUbqTCgif6tfmUxOPfrKFcoOXiwxvmH1KLY2AzEO7V+L6tkQrzDhYR96XfZBRTBJhYAH7a0WRcmz8oxNN6rrGxvi4W/PYDJBPw0JAbNfrtQpDUEiThvAElZV0zbq5PD98s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633054; c=relaxed/simple;
	bh=Xjtfn4sZ7WNbokQyGS4/ipg3CJbH0IuDDvhdnQIPnnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+yz1U0ctahJMuOHWcghaWyLRMYG1GmlkPdRWoA6mW3Yzro+wYi1PZokJj11WSBRNLrsUcau5hDMGmwFKbrcicU0RJDnmn1g2X/L/pbsFwZZlgTwpIZnJ6ww+bs9F9aBmR5x/70mV392Tj/9RIXZZm1apGYn201wSLHiXE1Wwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnNJVOxX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717633052; x=1749169052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xjtfn4sZ7WNbokQyGS4/ipg3CJbH0IuDDvhdnQIPnnU=;
  b=PnNJVOxXVy+N3+3tBl/uOS6pa2m/AuX3haM1z+UGEfi4SVgiUOUawvww
   zdHbDdVFT1+4B6rMXU64B/j59okOky+Z5hdxeOP84emaB2OhA+AFwSx4+
   kV0bNQJehYyZYk0Eulh/Gw0L9eOuVPZngL/ue9e3FUHjxa4T9YyE97NI+
   hHOKuOC1eRFdWq8go7IX03dy+PmEEDTeGCXb/O9TJENi4diwvujFwFrvg
   bmIfAUjV2Gsu1S9FpuQ1M9+TgMWhm6oQ95RCNA8EsXaCpvG+ADrFlBazO
   MBh+FDzyUHAz1Tu0Joln0Y0JydyxSNWE9oDgmeful41hs9PkG0EWVjcsE
   Q==;
X-CSE-ConnectionGUID: sy6UHQVOS/64Yy07HV1EKg==
X-CSE-MsgGUID: Cka+aj+kT76UywZcsN0kgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18123145"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="18123145"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 17:17:31 -0700
X-CSE-ConnectionGUID: JtXPUDZ5QTmqeHNDPPRxsw==
X-CSE-MsgGUID: jVBrJdgaRKmE3baR04REgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42730147"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO intel.com) ([10.245.246.215])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 17:17:29 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: John Harrison <John.C.Harrison@Intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt/uc: Evaluate GuC priority within locks
Date: Thu,  6 Jun 2024 02:17:02 +0200
Message-ID: <20240606001702.59005-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ce->guc_state.lock was made to protect guc_prio, which
indicates the GuC priority level.

But at the begnning of the function we perform some sanity check
of guc_prio outside its protected section. Move them within the
locked region.

Use this occasion to expand the if statement to make it clearer.

Fixes: ee242ca704d3 ("drm/i915/guc: Implement GuC priority management")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v5.15+
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 0eaa1064242c..1181043bc5e9 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -4267,13 +4267,18 @@ static void guc_bump_inflight_request_prio(struct i915_request *rq,
 	u8 new_guc_prio = map_i915_prio_to_guc_prio(prio);
 
 	/* Short circuit function */
-	if (prio < I915_PRIORITY_NORMAL ||
-	    rq->guc_prio == GUC_PRIO_FINI ||
-	    (rq->guc_prio != GUC_PRIO_INIT &&
-	     !new_guc_prio_higher(rq->guc_prio, new_guc_prio)))
+	if (prio < I915_PRIORITY_NORMAL)
 		return;
 
 	spin_lock(&ce->guc_state.lock);
+
+	if (rq->guc_prio == GUC_PRIO_FINI)
+		goto exit;
+
+	if (rq->guc_prio != GUC_PRIO_INIT &&
+	    !new_guc_prio_higher(rq->guc_prio, new_guc_prio))
+		goto exit;
+
 	if (rq->guc_prio != GUC_PRIO_FINI) {
 		if (rq->guc_prio != GUC_PRIO_INIT)
 			sub_context_inflight_prio(ce, rq->guc_prio);
@@ -4281,6 +4286,8 @@ static void guc_bump_inflight_request_prio(struct i915_request *rq,
 		add_context_inflight_prio(ce, rq->guc_prio);
 		update_context_prio(ce);
 	}
+
+exit:
 	spin_unlock(&ce->guc_state.lock);
 }
 
-- 
2.45.1


