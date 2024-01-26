Return-Path: <stable+bounces-15927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D183E34B
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 21:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C091C2434F
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 20:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A722F04;
	Fri, 26 Jan 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgG77UWO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1F22EF4
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300575; cv=none; b=iBsgQlx+hXuC1q9ghDKyr+iBAeXl9KniXqXr0mSejPTcEsoambbb2UObScDeBjOmReQ4AZkjndKS1unL5B/aulhHlTN4akPZhVSdUaVP/2udK/1nkNBAjFjHCMDDrQfvAT/bxzIVW8p+Ps2cZBHKlXCuuLGl0fgotmfK24NnOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300575; c=relaxed/simple;
	bh=H5dgHNGQ74ibX+fp4AsheVRsQW1VcXv/Agcjzw2ZFcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qE37UnkrpCB/dJ4hsKlHSqWc6i5TIHM9ej7oodwuFFfohtrO1Tc72mQiwGhno0ecHBXw5a807kt/14jRJXSJNof2+VlGqW8/EFPBh8ZdseUpoNIZlNrDhgB1APxP8Rnyo+D4z9AXymboCCkn1yqMsrg2Ml9JimRLrGRPf0120l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgG77UWO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706300571; x=1737836571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5dgHNGQ74ibX+fp4AsheVRsQW1VcXv/Agcjzw2ZFcE=;
  b=ZgG77UWOy241C4htV+2f0Cj+SeS0QtNNfichWls/8DMXuyRfUeer30Es
   GvvxGGCkto73X0K3A2c5R9fuD4uWGMwNdS2hXVSPQB3wHcMzWKCScP6JO
   lNjGuz9VYfD/ALjw7Mi2aDisShw+SXVlVZzaEodN6e1eddSi4gBRRXCMG
   IoQf1gFyQhINr7/eHh+wYdd0R9udb7f09FdH1YPbh4iM/hV/SJiDRdQww
   5rEil1Cqboe7gC0w2ks0qirAEny4SomH7KpoY9FvBkwQJ5Hed2ShHWQkY
   ngPEDBcfA/Z/P8iGx0fwf1bkc16NafhcKqJMKKBhizfYiuIUCUCeZAZwF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2436762"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2436762"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960310343"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960310343"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.246.113.182])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:22:48 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: stable@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 6.1.x] RDMA/irdma: Fix support for 64k pages
Date: Fri, 26 Jan 2024 14:22:34 -0600
Message-Id: <20240126202234.357-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240126202234.357-1-shiraz.saleem@intel.com>
References: <20240126202234.357-1-shiraz.saleem@intel.com>
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


