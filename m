Return-Path: <stable+bounces-78342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE598B778
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29126B27736
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F919CCFC;
	Tue,  1 Oct 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKvFx6JH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6FA19CC0F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772253; cv=none; b=MRtwwRsYp1P2RFHlz89sbmOPhnG7WHfnEP2jACQL0Aeir04KsoC0t+SEFp2mdJgn0oQONI2lq+w4o2kMbMrKlKaApaY4NsAMk48auPMt14qnNn2yB7g9ffR1amGIS+ajuyA64Pw1UH7KjbJqU+kQe6yIWmHNhK2v++tbVTMWay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772253; c=relaxed/simple;
	bh=CafA1T72hhrtjf+FB9H3E5YzBIsAueWcPsypsj9ySUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bmp4Qu081prh9sxYrt5Q5bPlJaqPnJGt+B1Q8dEZJC9mYbG443mq2MTRvFFnV1xzNRTqqdujUm/MkTkck4E8gezxOqj3YbeGHWxnbz4Kj6bSDqff+WgOFlK4f4JhvywNHLns+HCFa7QRyAB1INfffWsirzwbFs4+SOnEwVIxO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKvFx6JH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727772251; x=1759308251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CafA1T72hhrtjf+FB9H3E5YzBIsAueWcPsypsj9ySUQ=;
  b=iKvFx6JHfV1ATrcSbKbscKbgLOPDp2m+QiMw9+JQgK3h8OJUBDDPPvaC
   f/LYohJ5bOApss7XXyjGIdv5vM+ZQonRPCT6TwT34KSD5ygpiZ2fCIdcV
   +G7pb79w7OmWkY9osFTcKTEZiUIEBfZsdb+aaL9mSVbKvehTrOl4C3MuG
   MaKuZWt0VzRtSQ2SSz40NDSTCF2sCuJzj2PynoAO6m0QAZe+cQjjOfCqv
   cvaGgTcPV54eJTre2izL2XK4cOUYOGR5zVNytL3l6kMPt7xTpF2yoHTNg
   3dCmxK+VmFbO4iU698vJSSEJH/QKi5tCBZNYWBvWesmJsTpGXktlTeJFE
   w==;
X-CSE-ConnectionGUID: iTsREcHiQNu+sj/liLPUuQ==
X-CSE-MsgGUID: 1UQbhrNORv+5CNW1MZf35Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="27020704"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="27020704"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:44:11 -0700
X-CSE-ConnectionGUID: zh8CnoGlS6uYzSo4Qh0sBQ==
X-CSE-MsgGUID: 9M++W5BIT7OWPt/1bAOWZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104413723"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO mwauld-desk.intel.com) ([10.245.245.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:44:09 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] drm/xe/ct: prevent UAF in send_recv()
Date: Tue,  1 Oct 2024 09:43:47 +0100
Message-ID: <20241001084346.98516-5-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure we serialize with completion side to prevent UAF with fence going
out of scope on the stack, since we have no clue if it will fire after
the timeout before we can erase from the xa. Also we have some dependent
loads and stores for which we need the correct ordering, and we lack the
needed barriers. Fix this by grabbing the ct->lock after the wait, which
is also held by the completion side.

v2 (Badal):
 - Also print done after acquiring the lock and seeing timeout.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 4b95f75b1546..44263b3cd8c7 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -903,16 +903,26 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
 	}
 
 	ret = wait_event_timeout(ct->g2h_fence_wq, g2h_fence.done, HZ);
+
+	/*
+	 * Ensure we serialize with completion side to prevent UAF with fence going out of scope on
+	 * the stack, since we have no clue if it will fire after the timeout before we can erase
+	 * from the xa. Also we have some dependent loads and stores below for which we need the
+	 * correct ordering, and we lack the needed barriers.
+	 */
+	mutex_lock(&ct->lock);
 	if (!ret) {
-		xe_gt_err(gt, "Timed out wait for G2H, fence %u, action %04x",
-			  g2h_fence.seqno, action[0]);
+		xe_gt_err(gt, "Timed out wait for G2H, fence %u, action %04x, done %s",
+			  g2h_fence.seqno, action[0], str_yes_no(g2h_fence.done));
 		xa_erase_irq(&ct->fence_lookup, g2h_fence.seqno);
+		mutex_unlock(&ct->lock);
 		return -ETIME;
 	}
 
 	if (g2h_fence.retry) {
 		xe_gt_dbg(gt, "H2G action %#x retrying: reason %#x\n",
 			  action[0], g2h_fence.reason);
+		mutex_unlock(&ct->lock);
 		goto retry;
 	}
 	if (g2h_fence.fail) {
@@ -921,7 +931,12 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
 		ret = -EIO;
 	}
 
-	return ret > 0 ? response_buffer ? g2h_fence.response_len : g2h_fence.response_data : ret;
+	if (ret > 0)
+		ret = response_buffer ? g2h_fence.response_len : g2h_fence.response_data;
+
+	mutex_unlock(&ct->lock);
+
+	return ret;
 }
 
 /**
-- 
2.46.2


