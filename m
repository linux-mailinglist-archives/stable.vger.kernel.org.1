Return-Path: <stable+bounces-98791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099FE9E5445
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF8A165AF4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDDC20C47B;
	Thu,  5 Dec 2024 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7fozab5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBD20D50C
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399046; cv=none; b=bKNNWy6mSWMFSTs3zegPOS4YQK7Bacpy+pIsHhNYs84Ol7nFmEwM5VnKzQvZoAjwwzVUgYDnLWaIan1ILR/qTRARQhux/czbgtFfOQ2ZD3NU1006MNFJlDmEgcs1b7Liq+svdz93A6Cm9K4gyh17oZcWikJVFblaVGBqOHeWLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399046; c=relaxed/simple;
	bh=AE27GIKgR4YhLEYoDRJtp+/wA4/TSiQv6CxIogL1FQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odCWjDUWMqEkOeBnmelD+odwFQnfreElzjEq58vh2y3e/g4Go0QkPziVeThtOAk/dUNegzTYoA0cAceg8NCcjE1bu/pRMoMz/6gq+NzHMi3//Guo9i6wpR445tn1mdp5rhiABrbXSuu/dcgJEO3rRZWLgMaK9p7zw1ZyucP5kOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7fozab5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733399042; x=1764935042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AE27GIKgR4YhLEYoDRJtp+/wA4/TSiQv6CxIogL1FQI=;
  b=X7fozab5morMkbVUNdxeiKaeDNCJUqcYbTxx/RMIDac/PdzCkJdX1E/2
   SMLcLJgQJB+/mPpNVO9gQwh3CMvQlndyaWmPR4q71d2jBQBzVju+hLVxf
   t39+NvcixMqu28YmWst2cV9vOHJ5PHWexFmUoX0sTrUViKJW+AIV4GXA/
   M9P9Yuu7u0DfVVR+T/blQAuBWg0KvxibNvHbLUEKzG+LR+CvttMvG9heK
   k1h4U0sQkSiYIN6GuT+eD2I8ae4YOjhgZWFAMTCgtCUSEZJZ2PSQ62idD
   STXG9MgjzSO3dZBS6MCtwFybdx/pwJdIQGPjZvLiSHSU5p66VuOnrosD6
   Q==;
X-CSE-ConnectionGUID: w3BsXbc7Q4S5QgIYtGmQHw==
X-CSE-MsgGUID: A/4czX7UTQ+bSiZTRU5q3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44376699"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="44376699"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:44:01 -0800
X-CSE-ConnectionGUID: rv1XKFvQRG6CP7emSh0dvA==
X-CSE-MsgGUID: BuiED4j4TGuCVYuKCXkQnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="131499506"
Received: from nirmoyda-desk.igk.intel.com ([10.211.135.230])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:44:00 -0800
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v2 2/2] drm/xe: Wait for migration job before unmapping pages
Date: Thu,  5 Dec 2024 13:02:53 +0100
Message-ID: <20241205120253.2015537-2-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241205120253.2015537-1-nirmoy.das@intel.com>
References: <20241205120253.2015537-1-nirmoy.das@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

There could be still migration job going on while doing
xe_tt_unmap_sg() which could trigger GPU page faults. Fix this by
waiting for the migration job to finish.

v2: Use intr=false(Matt A)

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3466
Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system buffer objects to TT")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index b2aa368a23f8..c906a5529db0 100644
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


