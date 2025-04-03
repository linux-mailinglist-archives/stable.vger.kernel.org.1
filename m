Return-Path: <stable+bounces-127531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE19A7A4B1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC89617837A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562424EA99;
	Thu,  3 Apr 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AS6P/b4u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A512E3386
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689271; cv=none; b=a0pvxrElaAlpjPTP8JFrSb49p4J8qr8dD8spcinxKGCdWvgzFmdWl7amDku0vXWryj3NZzdI/Sc3MFpulyG86GOhIfpZfILqspz+UpMkoQI/pJXD08vtC4j2HgVjFoHJQEpE8P+Fp0jIIGY790x3XqX9uvKvNG6jChIly9h82yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689271; c=relaxed/simple;
	bh=mHpkx3VtcTowtdqBrjKSKug9utEqGFlQ/yBFJFaUpRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yaz2CFJjWkSA7bDTslE2IMQsFcpuiV8TjwIDon/zszea0/6UduvRMcxqBK3XP58aVld1Sw7cUN4FulAKJe44lAIivIM9Fn8AyQuh8OThsV47cDQr911cpuQi8pvtaubnO4FmeXw4+31dEJ0QSyVQP1h0llpDCCZhQGrgXr4NcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AS6P/b4u; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743689269; x=1775225269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mHpkx3VtcTowtdqBrjKSKug9utEqGFlQ/yBFJFaUpRc=;
  b=AS6P/b4uXXKR/rS86D/8Xts5HvQ7gaUOmcEORMRdfKXjPt5DSPpA7Nn9
   VhOqWUBGooTBh7E3RZiQUqkzaQyJUAUQC4pLRcfOyU5k5EDSRbfUaRPkl
   NP2uZaz9HdKwvfgpnEXHIU1emU38HIHp9rvnGSEbic+/cc/cGtXDdmV84
   d+DO5ztmwGs9ojjRGmMsDOFiRXthT6ka9s0Kp8tyXXGyq+4GDR+5WkgY4
   9DXn8Kxe6rOOnH6/+Wubq0ZaPXg8OESR1qUfWPQB88l5aRNr+fB4xq0we
   3YCZLhjZeuWYchqABegRnTc5GG6+pCQNXpxKwA6mSKDlXEajyZMOInFlT
   g==;
X-CSE-ConnectionGUID: M8VQVOyTTlqaPxPCf4m3JA==
X-CSE-MsgGUID: FyF2hgSPRr6LjKTmzwHEjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45276191"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="45276191"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 07:07:48 -0700
X-CSE-ConnectionGUID: XWJWAb5kSiOhNaiooKNgUA==
X-CSE-MsgGUID: 9xVDJdHBSGKMagLJ+tpoUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127951328"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 07:07:47 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/dma_buf: stop relying on placement in unmap
Date: Thu,  3 Apr 2025 15:07:36 +0100
Message-ID: <20250403140735.304928-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The is_vram() is checking the current placement, however if we consider
exported VRAM with dynamic dma-buf, it looks possible for the xe driver
to async evict the memory, notifying the importer, however importer does
not have to call unmap_attachment() immediately, but rather just as
"soon as possible", like when the dma-resv idles. Following from this we
would then pipeline the move, attaching the fence to the manager, and
then update the current placement. But when the unmap_attachment() runs
at some later point we might see that is_vram() is now false, and take
the complete wrong path when dma-unmapping the sg, leading to
explosions.

To fix this rather make a note in the attachment if the sg was
originally mapping vram or tt pages.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4563
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index f67803e15a0e..b71058e26820 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -22,6 +22,22 @@
 
 MODULE_IMPORT_NS("DMA_BUF");
 
+/**
+ * struct xe_sg_info - Track the exported sg info
+ */
+struct xe_sg_info {
+	/** @is_vram: True if this sg is mapping VRAM. */
+	bool is_vram;
+};
+
+static struct xe_sg_info tt_sg_info = {
+	.is_vram = false,
+};
+
+static struct xe_sg_info vram_sg_info = {
+	.is_vram = true,
+};
+
 static int xe_dma_buf_attach(struct dma_buf *dmabuf,
 			     struct dma_buf_attachment *attach)
 {
@@ -118,6 +134,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
 		if (dma_map_sgtable(attach->dev, sgt, dir,
 				    DMA_ATTR_SKIP_CPU_SYNC))
 			goto error_free;
+		attach->priv = &tt_sg_info;
 		break;
 
 	case XE_PL_VRAM0:
@@ -128,6 +145,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
 					      dir, &sgt);
 		if (r)
 			return ERR_PTR(r);
+		attach->priv = &vram_sg_info;
 		break;
 	default:
 		return ERR_PTR(-EINVAL);
@@ -145,10 +163,9 @@ static void xe_dma_buf_unmap(struct dma_buf_attachment *attach,
 			     struct sg_table *sgt,
 			     enum dma_data_direction dir)
 {
-	struct dma_buf *dma_buf = attach->dmabuf;
-	struct xe_bo *bo = gem_to_xe_bo(dma_buf->priv);
+	struct xe_sg_info *sg_info = attach->priv;
 
-	if (!xe_bo_is_vram(bo)) {
+	if (!sg_info->is_vram) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
-- 
2.49.0


