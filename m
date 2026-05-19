Return-Path: <stable+bounces-249459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOnCMOX1C2r0SAUAu9opvQ
	(envelope-from <stable+bounces-249459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:32:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B3457774F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 607FC300FC7D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752432DB788;
	Tue, 19 May 2026 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QepWzXLF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B21C5D59;
	Tue, 19 May 2026 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168718; cv=none; b=ALmAYsB4r499CabndOrCkF+bphcZBo+XDZ+CD6TJDlV7yTUVIsG3+iha8cN1L21lyd3WHYc/RlXz2AuSIoRD0WTSM1hP6H1Mv2t+OM5xxrMPqZUjGGDcxGMbe+pPgywi6ZDunZ9haT1HUS9EkJ5qtxP1HLcUuN8PWis9BP/WeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168718; c=relaxed/simple;
	bh=HjTkr/tPr7oETfZJGHuuDY+CDYpJn32WLeQGOszhU9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSWySRC4bXvT/JcAIYyPpaXZdauw4X88I72JQfVVQgwV0pMoVrP9igGGEIPubZ4e++x5sVI5pYcve+vUgJda5PhqcAtr/jsGzX5r7RteERED4C0yd0NMlazDrhVGbrvopFnZUGqfRWVJgjaj3wvISsAreGin+UB34fYQ1MQDFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QepWzXLF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779168717; x=1810704717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HjTkr/tPr7oETfZJGHuuDY+CDYpJn32WLeQGOszhU9w=;
  b=QepWzXLFtX4Czj+XwZPyKk5Xe6NxH0ZegBhXty21Bc0LQ617BcXyXQIE
   ZWO8Hj3I4dBJhtCo6nvZkdsrYEZZ2G1zFf6qKKo4l1CjbO8VEqEBvdxKr
   b4BrEtO2Pyr+SAEeju78TRN3JTZjZyoe8FSTq5+v6hSxrHOwjPptWkCvE
   9gUZeVh6CSaM9Q6c4gTu8Xa2vc5yti8FzY96FXpVt3vgrkqNu/UdjuBUu
   J5968TJLSKHjthq6NGOXAHCE38U1RNhco/qO7skYbBQIWR028iSo1VzRn
   Kso/ffMY7jxxpoB6R+ugPEm/NzG4NuNf9zNk0dxguRm2JeF1lXiRiByIM
   w==;
X-CSE-ConnectionGUID: F8IjmGUhSSyFuyqnrAK1WQ==
X-CSE-MsgGUID: W4cg//KvQUqOHjX0RPasww==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="90617165"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="90617165"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 22:31:56 -0700
X-CSE-ConnectionGUID: OVVCC+xiSb+pt36LZi/tyA==
X-CSE-MsgGUID: UpaDmT/0QkWL+hnTz60uWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="263177221"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 18 May 2026 22:31:54 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org,
	Nareshkumar Gollakoti <naresh.kumar.g@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Avoid WARNING in sva unbind path
Date: Tue, 19 May 2026 13:29:17 +0800
Message-ID: <20260519052917.3729796-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249459-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolu.lu@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 26B3457774F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Intel IOMMU driver allows SVA on devices even if they do not support
PCI/PRI. Commit 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when
PRI is supported") modified the SVA bind path to allow this configuration
by skipping IOPF enablement when PRI is missing. However, it failed to
update the unbind path.

This creates an imbalance: the unbind path attempts to disable IOPF for
a device that never had it enabled, triggering a WARNING in
intel_iommu_disable_iopf():

 WARNING: drivers/iommu/intel/iommu.c:3475 at intel_iommu_disable_iopf+0x4f/0x90d
 Call Trace:
  <TASK>
  blocking_domain_set_dev_pasid+0x50/0x70
  iommu_detach_device_pasid+0x89/0xc0
  iommu_sva_unbind_device+0x73/0x150
  xe_vm_close_and_put+0x4d2/0x1200 [xe]

Fix this by bypassing IOPF operations for SVA domains on non-PRI hardware
in both the bind and unbind paths.

Fixes: 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when PRI is supported")
Cc: stable@vger.kernel.org
Reported-by: Nareshkumar Gollakoti <naresh.kumar.g@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 11 +++++++++++
 drivers/iommu/intel/svm.c   | 12 ++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ef145560aa98..775f1c4ae346 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1254,18 +1254,29 @@ void intel_iommu_disable_iopf(struct device *dev);
 static inline int iopf_for_domain_set(struct iommu_domain *domain,
 				      struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
 	if (!domain || !domain->iopf_handler)
 		return 0;
 
+	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
+	if (domain->type == IOMMU_DOMAIN_SVA && !info->pri_supported)
+		return 0;
+
 	return intel_iommu_enable_iopf(dev);
 }
 
 static inline void iopf_for_domain_remove(struct iommu_domain *domain,
 					  struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
 	if (!domain || !domain->iopf_handler)
 		return;
 
+	if (domain->type == IOMMU_DOMAIN_SVA && !info->pri_supported)
+		return;
+
 	intel_iommu_disable_iopf(dev);
 }
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 57cd1db7207a..fea10acd4f02 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,12 +164,9 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
-	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
-	if (info->pri_supported) {
-		ret = iopf_for_domain_replace(domain, old, dev);
-		if (ret)
-			goto out_remove_dev_pasid;
-	}
+	ret = iopf_for_domain_replace(domain, old, dev);
+	if (ret)
+		goto out_remove_dev_pasid;
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -184,8 +181,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 out_unwind_iopf:
-	if (info->pri_supported)
-		iopf_for_domain_replace(old, domain, dev);
+	iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
-- 
2.43.0


