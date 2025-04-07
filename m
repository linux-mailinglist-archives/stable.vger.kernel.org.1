Return-Path: <stable+bounces-128562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06644A7E106
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E719E188C22D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83E41D6DAD;
	Mon,  7 Apr 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XheIOC10"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12751C7004
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035577; cv=none; b=LmJj3i8EjPOEvCNUfGCw9CxfJ6NICMf0NllC6vWfPVZmAaTwFmhpCEv28LDFqUrXfm2/FXG7bW+zugl2Y+ckHVQ7pGenjAlXW5Cu9hek4l7eEO67aIyyN1H+7xAX/BL1z6wVWDCdSGXwRorhVrmWby48m3qFOpPQ6I5zP5UUSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035577; c=relaxed/simple;
	bh=hpDb+1m/k1u4yTwGzkvw+8r5MtZcOIxF44F/LagRZTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gmo6C1qOHt2NqYVyoaPIuoGDYpqaN14ZEOAwksB5rQ0XLPLYptCuCo8Z4TWHvX9xHQUcR2qVR6nuCwBcSWEnnHTLRV4A2SPTHSJ6p5NJX3d8x8eCMt4hTIJlCBXxGOGT31FMJBTbJWRRyv3z1Nh6vg2CBgSlSrMTpkVkNJ93yGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XheIOC10; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744035575; x=1775571575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hpDb+1m/k1u4yTwGzkvw+8r5MtZcOIxF44F/LagRZTk=;
  b=XheIOC10CRoHc2EofNS7jm8JbxGl4NU/tKxhiSnhpJ4a58rMXu2GR6Oa
   ItFU7ClvjGo9fY8CF/IbUFkHxikHA3K1FRq/MUTwqedgwtFTw1pTAnrEE
   MmPuynhG3bQGmfs+eBPyAH+oYd1oWxnn4FxQd0ZkM/KYNaY5BMWljpPEI
   rJgndyi6xSqq67KqVJCDdb5yG8ltRRWMzFXj9NCLoXPWGN+XEA1JqEa8q
   Uq7DTgsZS8yCDvpJI0DMzcJy1HGIIXgobKiGiMhlPpeLufdpFL+v874Kp
   tMHobleBN+2ffw0nGF1msWTXX7CoApThccQNu/uA73ACJzSAH6NOVmOIf
   A==;
X-CSE-ConnectionGUID: PvY9hsfsSIG0T9vEJ8nF5A==
X-CSE-MsgGUID: YAYzdD6jQ32CzEFuEw4o2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45516556"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45516556"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:19:35 -0700
X-CSE-ConnectionGUID: dP9wzO5NS+iaG2ArmVz5Iw==
X-CSE-MsgGUID: 9vo+JgdWQGOlOD6KkLIotg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128302344"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:19:34 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu/dma_buf: fix page_link check
Date: Mon,  7 Apr 2025 15:18:25 +0100
Message-ID: <20250407141823.44504-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407141823.44504-3-matthew.auld@intel.com>
References: <20250407141823.44504-3-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The page_link lower bits of the first sg could contain something like
SG_END, if we are mapping a single VRAM page or contiguous blob which
fits into one sg entry. Rather pull out the struct page, and use that in
our check to know if we mapped struct pages vs VRAM.

Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.8+
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 9f627caedc3f..c9842a0e2a1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	if (sgt->sgl->page_link) {
+	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
-- 
2.49.0


