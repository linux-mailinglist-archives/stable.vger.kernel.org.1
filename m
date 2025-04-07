Return-Path: <stable+bounces-128561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E989A7E168
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB4F171B7A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD041CCEF0;
	Mon,  7 Apr 2025 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViwXnfdg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0F86355
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035576; cv=none; b=W4FSVIGb61LdZWPnQu3ddlYrcTmrWDRIaStoWR1nZeG7vBjBwpHy4pUGHb6v+4B2z5g2TC+vjWtS1FWbi5w/jGELG7GiGuL1uu7lZK9sVT57Y5xEE3uvygyB9WIyjbAKdTqNj89Rij/8TMDoFvvE8CYoPUrUAyn8TU0+sV1KRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035576; c=relaxed/simple;
	bh=+aLeG1QeHrKOcd8T6h1ZSIIRcGBHS90+cU4u5XEoCKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qOHvG9+qeuMJ3rA7I0xhRxJZUq887BPsZKziknyHpEB7+gCTwT3CUM+010XC8k5ZtiPa8eLNC4ljCXyMabagixz2kW/EguuF/vAhG5URGSYifWVgSDYrBXh6F3c3IaFz9FZDEbLEf2MemDXtpn/H5CljVGr1/ohlQgPKPxphup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViwXnfdg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744035574; x=1775571574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+aLeG1QeHrKOcd8T6h1ZSIIRcGBHS90+cU4u5XEoCKQ=;
  b=ViwXnfdgsZBZvVE95VAFJamennHfqOuc9GpBeP/J7R556HOjYakS393K
   bo0mJHD0EcawyM2itfeBN5tG9gzRWEWAqZbYkzz22nZrH3vVwk7t115kX
   EMsGzTRG7Sc1dKYMEdU7gndSrZGWVDmXdLQvMkxv59Zs6aO8CPyvy0/Ui
   r7/c4LbkcWlFww8rH83+CnzULJf25twQNuVrjVrwcGr1uaozpg9tl+Aj6
   lKSZD5WJJQavL/wcDpueUf2jhAOrI7JHPp3+8GANOy1JE3jMHy+MopFwm
   h0Gs1HQWSuPinthxib4KjQeUm4J3QsCLvmdATVafEqTviLsP2n4EEiU8e
   w==;
X-CSE-ConnectionGUID: HWELZ5csReuypg6cjTi/ag==
X-CSE-MsgGUID: mY3PLpfORR6HUM4MS0XnHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45516550"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45516550"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:19:34 -0700
X-CSE-ConnectionGUID: K+NOaD77R2uSAXHASXkLnA==
X-CSE-MsgGUID: y9f+4U2xTLeGdnOeW2JFeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128302341"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:19:32 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe/dma_buf: stop relying on placement in unmap
Date: Mon,  7 Apr 2025 15:18:24 +0100
Message-ID: <20250407141823.44504-3-matthew.auld@intel.com>
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


