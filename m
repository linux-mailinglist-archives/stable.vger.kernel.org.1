Return-Path: <stable+bounces-104025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0789F0BDD
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD5516938C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483741DF263;
	Fri, 13 Dec 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjXq9x9q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A251DE2B2
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091521; cv=none; b=E6OKrtiyMiJlyHNr2uot6zzJpn0KP3yyWGWM/K0JJ0K7Py6Sk5be9yjAgFbRMezf/5yxTZVdbqjcLJTT2Zk/J8pWY8OCBY6zkkzHctQu3AzKkVIH7rakOdRwAMd9gOzeEpwpzsHez14uNcWEVOZkCrgXbPrhb719xbf1wdEtNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091521; c=relaxed/simple;
	bh=LCjRVWpcZBGhW0HMGCq+B7gwylhE3p+P9sgcf/dKReE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I4PS8YWK/EmFtf2ARBqVA9YsM79BcQzTmVzLePvRFTEaFnqGj7PZi1RqyOKLLNXyqIHQMsNCDKBWoSG7LEEmehSn2bwb8lufhUYaRRukekOwub9yz0YZbeBW8dLWArBmh3TTHaeOldlYPr9sBLRbTK1cjjC8f0+fxpMjP1kGUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjXq9x9q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734091519; x=1765627519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LCjRVWpcZBGhW0HMGCq+B7gwylhE3p+P9sgcf/dKReE=;
  b=SjXq9x9qzaV7+OWoNyZlyfL+c3IZ9zK3y0NyfLo4HlixWd4HfNnZDapU
   7eyU7Nkz1Q/q6qYTaxUL/siCxtukVQXQRvVw5eW8A6HxNTO+u8H72dTBQ
   306Ymk+CA3JPN5pjjt6GK7H5Kr42frehTkQ+u1LMoHLFDzob9oe76MfGj
   o9/Sx81BHtSongT/AZNxNN41TGeR4OmqVZ+tUGKvzw5HfyEKkymgsMpFk
   1P29QEn7mXVejg9sYOn7R4AMLsSoipkqsMKNgIfe9vSMixbu3/UAOl1ry
   ObUq/lEe1Yy1w7pAc8dGI0sxhYXPMafRx8eimHbyFN+F/BJZtjkW2i4Uh
   Q==;
X-CSE-ConnectionGUID: HTKxajWYT3yZvTt1W/jtCA==
X-CSE-MsgGUID: INIGo+LaQ2iCYIB+L23aRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45951326"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45951326"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 04:05:17 -0800
X-CSE-ConnectionGUID: e9UbHqKpS1qpGcwbRqh8MQ==
X-CSE-MsgGUID: 6PC0MzlKRjyG7jMKuPReNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="127330960"
Received: from nirmoyda-desk.igk.intel.com ([10.211.135.230])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 04:05:15 -0800
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v4 1/2] drm/xe: Use non-interruptible wait when moving BO to system
Date: Fri, 13 Dec 2024 13:24:14 +0100
Message-ID: <20241213122415.3880017-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

Ensure a non-interruptible wait is used when moving a bo to
XE_PL_SYSTEM. This prevents dma_mappings from being removed prematurely
while a GPU job is still in progress, even if the CPU receives a
signal during the operation.

Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system buffer objects to TT")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 283cd0294570..06931df876ab 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -733,7 +733,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 	    new_mem->mem_type == XE_PL_SYSTEM) {
 		long timeout = dma_resv_wait_timeout(ttm_bo->base.resv,
 						     DMA_RESV_USAGE_BOOKKEEP,
-						     true,
+						     false,
 						     MAX_SCHEDULE_TIMEOUT);
 		if (timeout < 0) {
 			ret = timeout;
-- 
2.46.0


