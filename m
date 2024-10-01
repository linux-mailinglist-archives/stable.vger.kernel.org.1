Return-Path: <stable+bounces-78343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8607598B776
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAC31F25538
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D819F121;
	Tue,  1 Oct 2024 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QllIxUcf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112319CC07
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772254; cv=none; b=Ce8jNJDrTx09hvEiVvYNnDDccbVfqV1zv+gRvrFtKGarzoCsIhiktL1vpO8YmZm7d2KBsyFAOpTUcMh0tS52Am+cVEjnOwnumj9yNaG/Wuwh1hUfGsRTObs2YyyUoQzy6mV376MHoRnQ+sRBSXopGjat3ilTNzUsbLEUR9ywmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772254; c=relaxed/simple;
	bh=NikIlOR247N8HjbsfLXdEHSOadUyqYQMzDwX0DHwedg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjQavlQYwBe4nSWc8PD4Eof0ksZn6arp45sdhX7EZBjXl5xT0/8oop2shZzIfqiVzcXPCHj5jLYmVEedtDsD4OrsEl78zFVnZ8n/a30HBevDIwOu9/9jBWvxmEgKcUZKPGip+t/FTRGEWtyZLtPbmXbKkxDRfogxd5CBZ8h5K4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QllIxUcf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727772253; x=1759308253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NikIlOR247N8HjbsfLXdEHSOadUyqYQMzDwX0DHwedg=;
  b=QllIxUcfdTwE/35CwMefLUdgoJ4B/wcaFZ3wxz3AmmD3b/qheg8sIH4m
   swjNv2a7hacLtQzmdES4E5MI6f8XwGk1X3Toits/5v38a9AFXwJ9VIe/U
   p9/L1+KFpKdeM9VIqP4V6giu/89BprG2wNJoD/RAksTB/DlQvY/8f1Vwn
   50M8CIAHt0/yl9Y/DLkjDUa+7c96u5/E2ME/qEBPNgiNjHSwghdW2jOsm
   l/1XAg3hBZ8VijA3WmvvVM7zWpKvFP+LjTn8/0bzeK2PmBgnolX9NaJh5
   lRJXAWN0QhVu/F17Ya/r9oDZg99x3UxfB6WlkF7e1BcuSFuBhTBTo48ip
   Q==;
X-CSE-ConnectionGUID: Sl/t0eQwTfS7/xbl4SJ7UQ==
X-CSE-MsgGUID: 7qf3//imQS+ACzWjhlzZYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="27020714"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="27020714"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:44:12 -0700
X-CSE-ConnectionGUID: LmuwFW8aRFK0mw33O7xTWg==
X-CSE-MsgGUID: 2xJh5uyIR0iJaixoiDAISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104413731"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO mwauld-desk.intel.com) ([10.245.245.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:44:11 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] drm/xe/ct: fix xa_store() error checking
Date: Tue,  1 Oct 2024 09:43:48 +0100
Message-ID: <20241001084346.98516-6-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001084346.98516-5-matthew.auld@intel.com>
References: <20241001084346.98516-5-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like we are meant to use xa_err() to extract the error encoded in
the ptr.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 44263b3cd8c7..d3de2e6d690f 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -667,16 +667,12 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 		num_g2h = 1;
 
 		if (g2h_fence_needs_alloc(g2h_fence)) {
-			void *ptr;
-
 			g2h_fence->seqno = next_ct_seqno(ct, true);
-			ptr = xa_store(&ct->fence_lookup,
-				       g2h_fence->seqno,
-				       g2h_fence, GFP_ATOMIC);
-			if (IS_ERR(ptr)) {
-				ret = PTR_ERR(ptr);
+			ret = xa_err(xa_store(&ct->fence_lookup,
+					      g2h_fence->seqno, g2h_fence,
+					      GFP_ATOMIC));
+			if (ret)
 				goto out;
-			}
 		}
 
 		seqno = g2h_fence->seqno;
@@ -879,14 +875,11 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
 retry_same_fence:
 	ret = guc_ct_send(ct, action, len, 0, 0, &g2h_fence);
 	if (unlikely(ret == -ENOMEM)) {
-		void *ptr;
-
 		/* Retry allocation /w GFP_KERNEL */
-		ptr = xa_store(&ct->fence_lookup,
-			       g2h_fence.seqno,
-			       &g2h_fence, GFP_KERNEL);
-		if (IS_ERR(ptr))
-			return PTR_ERR(ptr);
+		ret = xa_err(xa_store(&ct->fence_lookup, g2h_fence.seqno,
+				      &g2h_fence, GFP_KERNEL));
+		if (ret)
+			return ret;
 
 		goto retry_same_fence;
 	} else if (unlikely(ret)) {
-- 
2.46.2


