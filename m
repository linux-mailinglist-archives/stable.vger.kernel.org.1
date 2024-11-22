Return-Path: <stable+bounces-94660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A309D652E
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BAC1B22FED
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177291DEFFD;
	Fri, 22 Nov 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEH1TypB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A389188583
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309673; cv=none; b=Y20e8L1C01W97CwB91zn7wgWcwvdMPohG9icOrzX6f1O5XP2VKNtbvZWHXUqCfcxofbcqVdAIzgvUNABWwsy01ikaav6YX1CasNv7Monn5/vpi8ImEDaJjpuRTZ7rqmK1KtaLsCvPrK2C0DAR2g0ZvsLHpQKX7ipD7StuiL4V+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309673; c=relaxed/simple;
	bh=a4esvcjDBH3TKZa9O5A3amUbrQCh/5+29Uu1fdjaRQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Em0f/6Cd9zOYNh0w3hIPQCTCWB9snyt+jSFt6/SZ0EuSG08Yhth6GUfaUQOzKKDsDoltH7+oeAK8sBTuuD2TkCSEQGWmC2CoWDk0qInasdnwEqJUS+cQTXmVtbWyIHVh6PnXg+83lJxt8oNic7G+Qo5XvPujTzRuukZDarpRibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEH1TypB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309672; x=1763845672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4esvcjDBH3TKZa9O5A3amUbrQCh/5+29Uu1fdjaRQM=;
  b=LEH1TypBryJBNbi55M0b1uUHI+xES5OXJs5Al58gZW21LAFem9Kevdli
   cJhCTgtX9q0RwuCx9sBu91tJllt9jxcmd17Kxiy5C1NUoz25nJqGimZPv
   CdlzRxJTWVg10r3CC4sKGMhM+MOUlDahIh2a9JI4SPTpSqQ2ryD54gxB7
   MB8kJhMtiiZF7nFdzyvMtMzhVTXipNhNUQ95deAoRuZyP6N8JV/Pcge8c
   TLU+W3C789zbVsVeOA2rQBoSg3/unSalsZjOf/NvHhFp48UF1x5zMYN30
   4DNHM8RVKGeilytnMvHwZLjJggpFAWF5S33stHDEHHZIvt00i/8oXlcN/
   Q==;
X-CSE-ConnectionGUID: KzacM7SYQiOmM+ryPBS+Yw==
X-CSE-MsgGUID: BhuTis5KTVOR564oGmMeLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878279"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878279"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
X-CSE-ConnectionGUID: 8AAw7hpvTxybkDqv9BVEVg==
X-CSE-MsgGUID: DddX4ABRSraWw26DlP2iGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457279"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 23/31] drm/xe/client: use mem_type from the current resource
Date: Fri, 22 Nov 2024 13:07:11 -0800
Message-ID: <20241122210719.213373-24-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Auld <matthew.auld@intel.com>

commit fbd73b7d2ae29ef0f604f376bcc22b886a49329e upstream.

Rather extract the mem_type from the current resource. Checking the
first potential placement doesn't really tell us where the bo is
currently allocated, especially if there are multiple potential
placements.

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240911155527.178910-7-matthew.auld@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index c237ced421833..eaf40857c1ac6 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -168,15 +168,10 @@ static void bo_meminfo(struct xe_bo *bo,
 		       struct drm_memory_stats stats[TTM_NUM_MEM_TYPES])
 {
 	u64 sz = bo->size;
-	u32 mem_type;
+	u32 mem_type = bo->ttm.resource->mem_type;
 
 	xe_bo_assert_held(bo);
 
-	if (bo->placement.placement)
-		mem_type = bo->placement.placement->mem_type;
-	else
-		mem_type = XE_PL_TT;
-
 	if (drm_gem_object_is_shared_for_memory_stats(&bo->ttm.base))
 		stats[mem_type].shared += sz;
 	else
-- 
2.47.0


