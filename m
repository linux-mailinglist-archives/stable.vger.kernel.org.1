Return-Path: <stable+bounces-132175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76971A849A3
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 18:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF2B9C4E14
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B091E9B07;
	Thu, 10 Apr 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1sLzRZH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB31D5CE8
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302451; cv=none; b=MJZofwY+gb0o73t5gajEjirz2UBkOC1BTOSOZF7+aidLE9Ct6x1Xl2dhSv6AP1qnDqIN4r8+l/H0EkSobUE02y2G//NWi0ZVSFLPj/yJH+clBdheDRCxQBN9ThhGxGS2OKogpV3zQ690SkP9afOQBMyFz2dN0QuXm0CE3IEu+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302451; c=relaxed/simple;
	bh=chKz2qbGpXeMzyi0x8vRH1CFhl6txUlwu3vv0gJbwUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8h37r4tNtFyQiIqWZg+DIoElQLIghviH/esWTIJRkU7sXni/OeYJi+EXFvsEuvM5rWRUXfCm1PmJqDYy22WSXihy10Ho8hzPCUjm59nhQKKpuA9pw+uakVTgSu57nJPMMG4Mo+bCBHjkftxU4LbOu8w5ebU7qfId0UEkPG5LLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1sLzRZH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744302450; x=1775838450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=chKz2qbGpXeMzyi0x8vRH1CFhl6txUlwu3vv0gJbwUw=;
  b=E1sLzRZHzOGUbNC3Ajp86d3ICu4NV2wJo2XPZDlcugkqrRY/t28Y0t6J
   XUDGJoWssz2UVfcdXUU/Dpb1dWOLD1QTAg+0C1p4VaGPk84KpA7mCUhjV
   zgM5QTsioAqbekRBfXmv5zFXkqP0QrDvdOLW6glYBw/pBXwuJ0N4TqPOL
   0sNcKXmMQ+ScGLpAit41olDO/D1yGdPRKdV5mUDdMT4LYXD4xLK6rOVbZ
   M1bQ4IYVGLnkty0wYB18N77tfu+y4CEecv7pU+m54y2apHFIzb0DQu0It
   eUAegCZQ2gFDyTfe2JCuk0fyMc1qt99b63GQPgNHUOKv03rxQr8pspM8V
   w==;
X-CSE-ConnectionGUID: WbulPEpYTfuV74OkfxbF9A==
X-CSE-MsgGUID: Eemdmrm9Sy6PUce/yeoKlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63377526"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="63377526"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:27:29 -0700
X-CSE-ConnectionGUID: VynYyzp3Sw6zOYf33MFRRA==
X-CSE-MsgGUID: lS/peeEeTPuuQ9QBhaSONA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="152135201"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.125])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:27:28 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/xe/dma_buf: stop relying on placement in unmap
Date: Thu, 10 Apr 2025 17:27:17 +0100
Message-ID: <20250410162716.159403-2-matthew.auld@intel.com>
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

To fix this check if the sgl was mapping a struct page.

v2:
  - The attachment can be mapped multiple times it seems, so we can't
    really rely on encoding something in the attachment->priv. Instead
    see if the page_link has an encoded struct page. For vram we expect
    this to be NULL.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4563
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index f67803e15a0e..f7a20264ea33 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -145,10 +145,7 @@ static void xe_dma_buf_unmap(struct dma_buf_attachment *attach,
 			     struct sg_table *sgt,
 			     enum dma_data_direction dir)
 {
-	struct dma_buf *dma_buf = attach->dmabuf;
-	struct xe_bo *bo = gem_to_xe_bo(dma_buf->priv);
-
-	if (!xe_bo_is_vram(bo)) {
+	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
-- 
2.49.0


