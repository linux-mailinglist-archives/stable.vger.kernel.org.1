Return-Path: <stable+bounces-135053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D61A9600A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417613AEFF8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934F1EF094;
	Tue, 22 Apr 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0V5t/33"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40B16F858;
	Tue, 22 Apr 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308434; cv=none; b=CWbghNFIZQSWagVt2vWJiH2NEVRdKBWbhY9veR5B7FGTQ3/Q7rQwwUZVdpDp1vY3dPr/IM6MpLehwkPgGhMdUdekmSSCSdtRky98VrcDVgZxKjs3/oIJ3qNcbR7EiAQZimto5MrsUO7cQcdUY9wjYVER3SxNYxukXQK4pOPNLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308434; c=relaxed/simple;
	bh=bN11AdKFan4/zi4bzqZxPMPow5eSnJU3qwTnj0tn9Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXhvDO7aLajowa7x0B1YuilUqLtM4vaRaH/Rl4AQUmWFlyGOuB5cCaxeVlJhs5PzG+5u7ZC4NhmfTYAFbsH/CXBqDd/VYen/ZlmE7ScF6tOqj10mUc1QfeJleRlX/FiTCLZWTwoKelKpqYXt/o0M9cNrCyx2f2Ucrd4qwMJdOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0V5t/33; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745308433; x=1776844433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bN11AdKFan4/zi4bzqZxPMPow5eSnJU3qwTnj0tn9Rw=;
  b=h0V5t/339p6ZNfFpap0qOEPuq8e2eXwfEvO7fYRN2DiFub4ypq0H3TaB
   iiVqsJ38nUrTW2Y1JC6WoMtkKMIPSO3N2cKNe3pXOFEKI2yk0srnWnoY4
   LqetEFnSODk04gDu33O3p6HXu/VOfJyk2f8RPbCmcDlh+CQ+Y/oo/W+0l
   ZLUTAFJfFGKd71AtXzOLOYJZmvBJFvri8PXvWrhIqgwqQkR30zLxpCnSG
   eqMMwfBqZqhxkXs6v5jmyM32LKHOD4/bwyTZzJQ5mF3xUoTTnRFuUxV6+
   80mUuT1WKg37ErNVNVOW293pANQPIPx3zPwF9rfZ2Xkp0lGJDD3qdmzUd
   Q==;
X-CSE-ConnectionGUID: OZ9NqcfvS+6a42YLFjD7Jg==
X-CSE-MsgGUID: 6uWSPq5kQL+G17WQIUGeog==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46736241"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="46736241"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 00:53:52 -0700
X-CSE-ConnectionGUID: ELbREccUShGmuQop5UDLng==
X-CSE-MsgGUID: 7a9xTTQJRdGm62RFmFudLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="131687764"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa009.jf.intel.com with ESMTP; 22 Apr 2025 00:53:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	shangsong2@lenovo.com,
	Dave Jiang <dave.jiang@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Assign owner to the static identity domain
Date: Tue, 22 Apr 2025 15:54:22 +0800
Message-ID: <20250422075422.2084548-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The idxd driver attaches the default domain to a PASID of the device to
perform kernel DMA using that PASID. The domain is attached to the
device's PASID through iommu_attach_device_pasid(), which checks if the
domain->owner matches the iommu_ops retrieved from the device. If they
do not match, it returns a failure.

        if (ops != domain->owner || pasid == IOMMU_NO_PASID)
                return -EINVAL;

The static identity domain implemented by the intel iommu driver doesn't
specify the domain owner. Therefore, kernel DMA with PASID doesn't work
for the idxd driver if the device translation mode is set to passthrough.

Fix this by specifying the domain owner for the static identity domain.

Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cb0b993bebb4..63c9c97ccf69 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4385,6 +4385,7 @@ static struct iommu_domain identity_domain = {
 		.attach_dev	= identity_domain_attach_dev,
 		.set_dev_pasid	= identity_domain_set_dev_pasid,
 	},
+	.owner = &intel_iommu_ops,
 };
 
 const struct iommu_ops intel_iommu_ops = {
-- 
2.43.0


