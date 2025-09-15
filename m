Return-Path: <stable+bounces-179603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52289B57055
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 08:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0562B3AFD1E
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 06:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08628000F;
	Mon, 15 Sep 2025 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHTqR0Rp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF18275106;
	Mon, 15 Sep 2025 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917927; cv=none; b=dxheSh5Zgphtg5P7aDyMKLOcmIWeljBpkvhraWcurPy06g8Sk0meftcitS8UbzMWkTbGzcHhxdLarMd33Gy4PYWwL4ciLyVZSdgLhhAwEb/d6zPljYAkkh8uR8bVqnd69DHu1rey8EYs7RxisC/0Vap7gM4BwpmQglRBDIttSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917927; c=relaxed/simple;
	bh=BtxIc01N/Av8yQlrBO3Eetrd1//r2n+8p/EQabYge+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ES6RAtKNtwByAHdaKkUab1kadjMR7X6VdT6NteK5iyl2idt/BMjoV7g3nwLCis7PIVrDE1nVmIbauiOE9c2CwGo01IZSy4tP14kkr6zERrgZhl2z/kR849tDSWgGogQ1gBytWKihPBwZfFkIye5/ppi6cCF5BZXMd6seJHcQcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHTqR0Rp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757917926; x=1789453926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BtxIc01N/Av8yQlrBO3Eetrd1//r2n+8p/EQabYge+Y=;
  b=KHTqR0RpHdnBuc9IDfDIi96LaS3eeb390kU1r/s2F8704bzHb1Gxsj6L
   Uq8tB8zJIPHSWR0g+kcZmDvwVce7qu0YNZkjADZSH0PLRwGZ4KGh3G3SK
   vBX0ZrtPdZc7Cl0FR/ngITU5DptVRhP921R/Lf9E/8mpU60poZWXSau7r
   xCDpryKlGMO3fWCyf/cCjqOvTEDVqJcDbkRx3GxdszvqQQf9/cv9KuqDv
   Ghk1jdXFGBiSfqnlcCXWJZuLb03Si4Xb075NlmEy3XN+zfSPkda1KZ6Sr
   naKh3hWrTC7cEcJ8lWtkvLY+ruJTRLutG7Zqj7F3I/BHaQ79myNBn44Nz
   g==;
X-CSE-ConnectionGUID: cXmaWQJ/SgaH7d78vff5Mg==
X-CSE-MsgGUID: /+EvvU1QS/myNls6/G/L6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="60099056"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="60099056"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:32:05 -0700
X-CSE-ConnectionGUID: LyCIui8rROScJpJUqxqMNQ==
X-CSE-MsgGUID: 79S5PAXlQPaHzn7WH30cbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="179698419"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 14 Sep 2025 23:32:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: PRS isn't usable if PDS isn't supported
Date: Mon, 15 Sep 2025 14:29:46 +0800
Message-ID: <20250915062946.120196-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The specification, Section 7.10, "Software Steps to Drain Page Requests &
Responses," requires software to submit an Invalidation Wait Descriptor
(inv_wait_dsc) with the Page-request Drain (PD=1) flag set, along with
the Invalidation Wait Completion Status Write flag (SW=1). It then waits
for the Invalidation Wait Descriptor's completion.

However, the PD field in the Invalidation Wait Descriptor is optional, as
stated in Section 6.5.2.9, "Invalidation Wait Descriptor":

"Page-request Drain (PD): Remapping hardware implementations reporting
 Page-request draining as not supported (PDS = 0 in ECAP_REG) treat this
 field as reserved."

This implies that if the IOMMU doesn't support the PDS capability, software
can't drain page requests and group responses as expected.

Do not enable PCI/PRI if the IOMMU doesn't support PDS.

Reported-by: Joel Granados <joel.granados@kernel.org>
Closes: https://lore.kernel.org/r/20250909-jag-pds-v1-1-ad8cba0e494e@kernel.org
Fixes: 66ac4db36f4c ("iommu/vt-d: Add page request draining support")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9c3ab9d9f69a..92759a8f8330 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3812,7 +3812,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_pri_supported(pdev))
+			    ecap_pds(iommu->ecap) && pci_pri_supported(pdev))
 				info->pri_supported = 1;
 		}
 	}
-- 
2.43.0


