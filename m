Return-Path: <stable+bounces-15925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E51B83E348
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 21:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8668281274
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075F2260B;
	Fri, 26 Jan 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb1uWcWU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEC22EE8
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300520; cv=none; b=JGsNUkkekg0nWQrHDgYAfGSgBjJhtcZjd2GwAOjiY/9ZA57bpXcsaiIxB4r5sjw+q2C2pCDRMpsqtKV4dutccTFbEx3rtB+Unxh6T4dNkwXDNwXOsKOBHljoDx4Iu88i/kD94Jbx+R+2au8pj+MEqsSETF2ZNxgU6cubroosj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300520; c=relaxed/simple;
	bh=H5dgHNGQ74ibX+fp4AsheVRsQW1VcXv/Agcjzw2ZFcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AzegRf0CUQ5nDv9ZslAcJgp8bmUlk0GKG+oZs21NH95FisTN3Yc8Bl506UcOGDAlSLJzNRXVoOcMJglTiqo2anPDhsuWO2gapKY2eTEau3dZl+5xxkJ57sS6DSXCBOeiiLNXBYYAMAtlAkOZ9R96uSTe0lUnFiCcWb+s/CMfATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb1uWcWU; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706300518; x=1737836518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5dgHNGQ74ibX+fp4AsheVRsQW1VcXv/Agcjzw2ZFcE=;
  b=Wb1uWcWUTy1BCHsWNO5EmUsLF4TwwbeU4PWb7HHtAKH1TMxWE857ou7O
   W0FubOlcMbfjP25NLVj4ODBtagkPZS1FsZLfZXKH7B73vevMHK8Tkz7ph
   y3/HQhPsq8qe/jb8LSUm1tDEhQfxcytgA1m2FmBGF00ou5N+jcuZIA5vJ
   ZoKDCeRJM6Q+IFuk6uVkwXQpM5mILyastB/ujBS7CX7/LcxLIEyoBFHGE
   yZJGnYy77KkLIyvXUS7OxK/k976h6tvf+eN88FWQdYvYEGc8AY8llFbMy
   dYRBQQ3K3ETKQoG8nszaOP/IXItkmLc2quMrOiHmT5+c6PNbXOaT/SUCt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466841969"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466841969"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821243878"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="821243878"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.246.113.182])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:21:55 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: stable@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 5.15.x] RDMA/irdma: Fix support for 64k pages
Date: Fri, 26 Jan 2024 14:21:44 -0600
Message-Id: <20240126202144.323-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240126202144.323-1-shiraz.saleem@intel.com>
References: <20240126202144.323-1-shiraz.saleem@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

[ Upstream commit 03769f72d66edab82484449ed594cb6b00ae0223 ]

Virtual QP and CQ require a 4K HW page size but the driver passes
PAGE_SIZE to ib_umem_find_best_pgsz() instead.

Fix this by using the appropriate 4k value in the bitmap passed to
ib_umem_find_best_pgsz().

Patch reworked to handle the different pre-split context.

Fixes: 693a5386eff0 ("RDMA/irdma: Split mr alloc and free into new functions")
Link: https://lore.kernel.org/r/20231129202143.1434-4-shiraz.saleem@intel.com
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index fa1ccd6a9400..745712e1d7de 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2763,7 +2763,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	iwmr->ibmr.pd = pd;
 	iwmr->ibmr.device = pd->device;
 	iwmr->ibmr.iova = virt;
-	iwmr->page_size = PAGE_SIZE;
+	iwmr->page_size = SZ_4K;;
 
 	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM) {
 		iwmr->page_size = ib_umem_find_best_pgsz(region,
-- 
1.8.3.1


