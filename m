Return-Path: <stable+bounces-104026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571029F0BDF
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903D4188B988
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492A11DF277;
	Fri, 13 Dec 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0HH7n2B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFA1DF26A
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091523; cv=none; b=onb3PkvqPcl9RIlYGojbrEmLWEv2dJ9Weu1wtv6uyrfBxU2w2sBgMcbzZbXuTRr3IzurDdVOsGExV38LekGlNYOK9dWUzYHYmNWw923e0Uh6iOC+tDdWRbqww1/WeZe8TWO/G9ehjHU8UWPyH9Y3ww8wadbwQPiIx2nfcIjz3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091523; c=relaxed/simple;
	bh=Wxca4nWqVRYw78odCUx7X9ScpYXZQbZgyncSVPxftBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFndxcEjGbZ+bVqomacWgewcYbH9puowGpvTDG4CzcksD4QaGhMT2GepjKUELmcYP4Aaf/Yponmxyct0RGL7gybeFPjwE0PGnm53dPCeNCm7p22vZRiuG98x6OrUwWfN29UXPLm01Zx80WQcshaj7pQg7//SeGNjCws6iaOgiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0HH7n2B; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734091521; x=1765627521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wxca4nWqVRYw78odCUx7X9ScpYXZQbZgyncSVPxftBs=;
  b=l0HH7n2BdJt+d7lk9zqo4rBxo381FJMSwZF59WgOwk42zDTo3AT7nzIt
   OYE6RUU5YG1Iwm3IHf4eG9adrFh5EQ7RkIWsN6EmjUNd7IMPz/SarK/rP
   eRQilknBzGWL8J5jeQXYiAkT1tOr9pc9ElzzprmQatAGS8uU76kfguSQ3
   7sGm5zHi8W34s0sUUvtD+a4RxEYrEqJzXO3HOcKQJ3dhl7WDiZoPVgMMm
   Lz2sFOg8QPt6tBvS6iVYxf7sUlMGZ0ii048dLnT8rOXvyq6P0SZ1G8X45
   HQfauGEERBzCMy7EKLJ8+k0KPFVYOoYxbt4fxUgtiKSUdEACoV4/ZotVF
   A==;
X-CSE-ConnectionGUID: /qrruDeiQhWHG9UVvI3U7g==
X-CSE-MsgGUID: UUbBvCSNSVyv+Ny1H9iFUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45951337"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45951337"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 04:05:19 -0800
X-CSE-ConnectionGUID: TR8mUurtQImKW0H3n0QyfQ==
X-CSE-MsgGUID: IfIw0MLIR7e2ZqcevIx96w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="127330967"
Received: from nirmoyda-desk.igk.intel.com ([10.211.135.230])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 04:05:18 -0800
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v4 2/2] drm/xe: Wait for migration job before unmapping pages
Date: Fri, 13 Dec 2024 13:24:15 +0100
Message-ID: <20241213122415.3880017-2-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241213122415.3880017-1-nirmoy.das@intel.com>
References: <20241213122415.3880017-1-nirmoy.das@intel.com>
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
v4: s/DMA_RESV_USAGE_BOOKKEEP/DMA_RESV_USAGE_KERNEL(Thomas)

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
index 06931df876ab..e6c896ad5602 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -857,8 +857,16 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 
 out:
 	if ((!ttm_bo->resource || ttm_bo->resource->mem_type == XE_PL_SYSTEM) &&
-	    ttm_bo->ttm)
+	    ttm_bo->ttm) {
+		long timeout = dma_resv_wait_timeout(ttm_bo->base.resv,
+						     DMA_RESV_USAGE_KERNEL,
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


