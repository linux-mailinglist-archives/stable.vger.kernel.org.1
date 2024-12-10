Return-Path: <stable+bounces-100444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3E9EB57B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32D12830DE
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415EA22FE03;
	Tue, 10 Dec 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7nmtRjk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4838DEC
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846220; cv=none; b=ce0Q5Zd7ZdDw0WHdfoHjGPDmQO1IwFetbeDWwzikDl+0PbAA3JZTvqF83+vzQV8sgLc1RX0VJmFg2dTUFO2BcvRXGB+yWnzh8puBGZ4abzcyKnev7yLRCJqetugkG+nAGqY3hzlQr/9t3nBxvJUyvNjk/7HWXZGri5XE3xf+Kj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846220; c=relaxed/simple;
	bh=mjC+e6gNCU3emBb9QuvtpFcjeRTWGAeStvy+POWh8lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNn8H3DylL267Qr4oCThzynKPOzZQthfezgkSfKIScywo+oSr6KT0uKFM8jE61eXUtZm4FNSAvNEHoCEY4MltQUY/nuKyfvx2sXiaE5o9izZbH7Ox0ZFialvURfLyDTOk5iIdoALswZ+mOQKitav9v0pF0ZH+tidBcE+3vPVJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7nmtRjk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733846218; x=1765382218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mjC+e6gNCU3emBb9QuvtpFcjeRTWGAeStvy+POWh8lo=;
  b=K7nmtRjkwSTs7WVE02xG1H/Lj8jXSsOJtsmuko8H86BbGk0L8ocJ+O/e
   XeKKSrFkNBE5QNFbcHJlRrE51fNIiAD4sAk1/0ylEFdoE7zZZr+Y7Z7l6
   iHj+iE58NdcmmkxwJEcr4kl+oHp/QlUNylinZ5zPNV7Yzb5pIEZBdWB+/
   vAl2xWfNdcji4vIfGbf8vUD8v3/c+NIv/F9q5pYjelTv/491jg0Ze3tKl
   4L3gAOJEzBZCI2scwS79EvWV1vnOOFUXyJ1z9JD7xeTSqTeZGssXu9EQp
   qiSxldB9KQ/U147PAzrlxjFDRVm7Si4tO1VaZQV6QSayG3ccJ4a5yOp/u
   A==;
X-CSE-ConnectionGUID: nDxCZzSRSlmFQN8GN7z3ug==
X-CSE-MsgGUID: TaZXdlQgSruCzCh0L2yvUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34117431"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="34117431"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:56:58 -0800
X-CSE-ConnectionGUID: 3ugKgCagTxyib1MZYBnKKw==
X-CSE-MsgGUID: vWkfEt9ZSQ+zHjZYy8T8CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95261352"
Received: from nirmoyda-desk.igk.intel.com ([10.211.135.230])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:56:55 -0800
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v3 2/2] drm/xe: Wait for migration job before unmapping pages
Date: Tue, 10 Dec 2024 17:15:52 +0100
Message-ID: <20241210161552.998242-2-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241210161552.998242-1-nirmoy.das@intel.com>
References: <20241210161552.998242-1-nirmoy.das@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

Fix a potential GPU page fault during tt -> system moves by waiting for
migration jobs to complete before unmapping SG. This ensures that IOMMU
mappings are not prematurely torn down while a migration job is still in
progress.

v2: Use intr=false(Matt A)
v3: Update commit message(Matt A)

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3466
Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system buffer objects to TT")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 06931df876ab..0a41b6c0583a 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -857,8 +857,16 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 
 out:
 	if ((!ttm_bo->resource || ttm_bo->resource->mem_type == XE_PL_SYSTEM) &&
-	    ttm_bo->ttm)
+	    ttm_bo->ttm) {
+		long timeout = dma_resv_wait_timeout(ttm_bo->base.resv,
+						     DMA_RESV_USAGE_BOOKKEEP,
+						     false,
+						     MAX_SCHEDULE_TIMEOUT);
+		if (timeout < 0)
+			ret = timeout;
+
 		xe_tt_unmap_sg(ttm_bo->ttm);
+	}
 
 	return ret;
 }
-- 
2.46.0


