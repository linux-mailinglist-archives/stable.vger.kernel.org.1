Return-Path: <stable+bounces-78256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61B98A273
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637411C21866
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFB817A5A7;
	Mon, 30 Sep 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1R6W4rf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E256E2AE
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699436; cv=none; b=lHU2hSV4ZEf/Q/zYgsWrD5RKr3rkC+DGolmu8K3caIlLKsymJLLffv28HjhhI7Keikbm3nxYCwg150kd2Mxpqd+RLt3UmwnMkq7yWPoRq4O51wuWPxQ+K4yhcNAAPFK7WI7bu2HyHC3Wqo5O/zY7Z1SYQtNFzC5Xrm2Ya8PDPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699436; c=relaxed/simple;
	bh=QHKaBkJ7pSKhYHOy88Y4skjm3ODUSGapTjUF3q87JEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ft3CpL6TPKkw9EGgSdJ47hvhT3BPVu2dnaoz0xBEW787ZzRy1VZJcVtoCDbYtqSu5ayuC6ysuUJ+K8cOerhr3nLkkYaqVn8GIw4qNO1FxgCtxblm4ag9AJtCCuoxidq7BIJdmZdCddsXIraabb7V7klSyJgTQ5lwj0GPEGFdWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1R6W4rf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727699435; x=1759235435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QHKaBkJ7pSKhYHOy88Y4skjm3ODUSGapTjUF3q87JEs=;
  b=V1R6W4rf6M6s5vwx+A/0SbDTrxdCq5YUVwnTXGyTy9dTSwNdm+yrIVma
   qNJ2PD2govd6SqaRA0NV0cco68tE7pbRwVUx2ZgU2sfc5HNQ4/GwJU5wj
   WRvl55jyHdfxYYFeOXYTedeWBdBYE+Z8vZE4FRUOhlggkR9lZAUc3yIuN
   OTOhnc7QXTohYVzjmfELkRDe7mKMNFlIDVn0uicZOhWBKw4x7FqLIkvs5
   M0OnkxJmhFnX64JEg+hlWLIt+ZjqoKlRcw7OLtK3dVxHa1BthHXipe+NU
   FQgb3Zww6DKBlE1Bs6nMPW4bPTawkGuEGgkZJtBMge/t78dwgf5W0e51F
   Q==;
X-CSE-ConnectionGUID: +ibYq+wHRwSAgMcRvTwh4A==
X-CSE-MsgGUID: gJ0uxMJJTWeH25Bv+g/8BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="49305180"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="49305180"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:30:34 -0700
X-CSE-ConnectionGUID: 9aRKxVpVRWCDb/81LSAhVA==
X-CSE-MsgGUID: 6V2R7O/+R8aeIXLfnSpuhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78247126"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO mwauld-desk.intel.com) ([10.245.244.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:30:30 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe/ct: prevent UAF in send_recv()
Date: Mon, 30 Sep 2024 13:29:41 +0100
Message-ID: <20240930122940.65850-3-matthew.auld@intel.com>
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

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 4b95f75b1546..232eb69bd8e4 100644
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
 		xe_gt_err(gt, "Timed out wait for G2H, fence %u, action %04x",
 			  g2h_fence.seqno, action[0]);
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


