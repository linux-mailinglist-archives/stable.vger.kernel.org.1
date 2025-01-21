Return-Path: <stable+bounces-109582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60025A175F7
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 03:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EF53A3E12
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 02:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB02AE9A;
	Tue, 21 Jan 2025 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aI21x/a5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91FDDC1;
	Tue, 21 Jan 2025 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737426716; cv=none; b=KgKPwNyY5k3UzjPpljfU4iJXKofT6qZw3wWn9S3EZkcLEmbjZpovDPGN5Q3zD6tiiVnBrbmvD/TJTCEhAM5kqha+wCccIn01Xk13ke4DojtSOBI59riRarCuk83BPgMknzyKWu8B6P+19d2Fofncg22nFGKLn/mqcGE8VP5sNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737426716; c=relaxed/simple;
	bh=UQciwYJtF8gs4Ambi7sdzozbOkoN5xsR0BqOeHo9xj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3nHUabrUMZ1SzI/2mmInBgdU3tHkim5l10IIg61OCaWFZawRtFo8mEztRgSb/xQQsG35a6mX73u3/FciqNBvIp1Rw8k/vWP/hGLU4tLz29CPUJEDRIkLEQ5lkugJ8IDTMz5lVMHK2ancsoQPP2bdQrKIMGPEioA9IRnMkq+D9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aI21x/a5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737426714; x=1768962714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UQciwYJtF8gs4Ambi7sdzozbOkoN5xsR0BqOeHo9xj4=;
  b=aI21x/a58k5Of4AsA2ilLcXmhKwFDyweFL8TGQPDLSrsaDGSFYetVN17
   eyJj8LPokB7tD+nCRXZfGwXlAc2deyqkSZvKPF39ThKaPW36FONruFPJ3
   /MggPDglZawSVooDuAPGwBbu4vCH/WthKkEfxV+QhsS0hpv1yK2xlYXx2
   T423pbnc3mU0RrM8Chm8fbHKD88liAzeOpy2KVV2cMGjdzM4efCNw5O0B
   /a6pFuTCQ6lhMuOsFeAX6hEg+AuRPBbMr4anydCtrT8uXR1//WDlmHL43
   TyePCjGIbCGs/uHdGnzUVzQBTHGciHVl7tkM5xnPde3CoeEVTLO5IHrOY
   w==;
X-CSE-ConnectionGUID: 9iSVdLepQJWKDj8pkFJr7A==
X-CSE-MsgGUID: tJvbAg+0TCi/31Fvnd6SzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37987464"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; 
   d="scan'208";a="37987464"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 18:31:54 -0800
X-CSE-ConnectionGUID: OSGA3/x9Rx+cG8KKEt+4dw==
X-CSE-MsgGUID: p+8KxOm6T9Wcm8VOpGPRgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; 
   d="scan'208";a="137512570"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2025 18:31:51 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover faults for RID
Date: Tue, 21 Jan 2025 10:31:50 +0800
Message-ID: <20250121023150.815972-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver supports page faults on PCI RID since commit <9f831c16c69e>
("iommu/vt-d: Remove the pasid present check in prq_event_thread") by
allowing the reporting of page faults with the pasid_present field cleared
to the upper layer for further handling. The fundamental assumption here
is that the detach or replace operations act as a fence for page faults.
This implies that all pending page faults associated with a specific RID
or PASID are flushed when a domain is detached or replaced from a device
RID or PASID.

However, the intel_iommu_drain_pasid_prq() helper does not correctly
handle faults for RID. This leads to faults potentially remaining pending
in the iommu hardware queue even after the domain is detached, thereby
violating the aforementioned assumption.

Fix this issue by extending intel_iommu_drain_pasid_prq() to cover faults
for RID.

Fixes: 9f831c16c69e ("iommu/vt-d: Remove the pasid present check in prq_event_thread")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/prq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Change log:
v2:
 - Add check on page faults targeting RID.

v1: https://lore.kernel.org/linux-iommu/20250120080144.810455-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index c2d792db52c3..064194399b38 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -87,7 +87,9 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 		struct page_req_dsc *req;
 
 		req = &iommu->prq[head / sizeof(*req)];
-		if (!req->pasid_present || req->pasid != pasid) {
+		if (req->rid != sid ||
+		    (req->pasid_present && pasid != req->pasid) ||
+		    (!req->pasid_present && pasid != IOMMU_NO_PASID)) {
 			head = (head + sizeof(*req)) & PRQ_RING_MASK;
 			continue;
 		}
-- 
2.43.0


