Return-Path: <stable+bounces-231147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DMVNYlNymmb7QUAu9opvQ
	(envelope-from <stable+bounces-231147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:16:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EF5359019
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B626B301D542
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7D3B9DB3;
	Mon, 30 Mar 2026 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+1RntwR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815BF3BA23D;
	Mon, 30 Mar 2026 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865483; cv=none; b=arE7R3vgEMzWyKFZ0CxHJiefhThVfR8+W6NzGnIhLbbchteui+EfJB6Wrj3mwnG4TXSO3Wx5cOPW0skT0dJ4cNJrJB7Px9Xu83l6f09h3RHKitjvSzf4f2K9/q+z+ciTOQbVcuhAVDMLr5Vp5KFFqov9DWUhN4ADVwujDpgf0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865483; c=relaxed/simple;
	bh=EGxIrnSiCc0r/A40It2qhOffrUuycMftQdxuwrCg0o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNF8YikVhMdHFnx1BJFrJrRT09czGURC8rVVzuKcvoBJfWyNL/nU0HkwUjFJf/zapL1T00A4CjYCftzm2mIV7csdt7mKL1EzIBfLjAHP4dpBH586VJjrQYpuTeKdcWC1VZsQA4Ex89ydf8F9OOU+ybM+J/ZM2aVI2MaXTdXvgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+1RntwR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774865482; x=1806401482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EGxIrnSiCc0r/A40It2qhOffrUuycMftQdxuwrCg0o4=;
  b=L+1RntwRF/isVcfZ2yPSm+nRa368o0zI5j6MTo7rjz+xWPGHDYHdCX+H
   zw+HeNBQQDCpNNWnnvuD1Wj+CgIQGyWjnID9FI8l3VeDhsZvaFtPtS6o2
   /LiCsXPCWhP+66g6y+hq9lZHpB+O+0V2Fa9US/wEaNWofAFDrygDcod6R
   lx2Dx9bvUTnNsm1eaGKI5fqvZpjqGo4y+fX5Pt0s2dETWm6KwErV/bdJE
   qN+86fl+JzichgrS6OYJWgcyMOzNXofzgq9X4m1Uu6blY6UnUUpDOzACC
   Rza3TN/TUrwAYzPeXldM0ycc42qTCfRXSuHL9RMaI7dPl7K8VH2PbhNzj
   g==;
X-CSE-ConnectionGUID: 16LX1xQZTlemSclXesUXwA==
X-CSE-MsgGUID: fp4le8k/ThaNDqx9PQDUKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75921156"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75921156"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:11:22 -0700
X-CSE-ConnectionGUID: dFt7b/aVQXGo+Eo0pJRHbQ==
X-CSE-MsgGUID: gE/uhu0iSn2I/UWmpWh10w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="225913432"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:11:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	stable@vger.kernel.org,
	Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 1/4] iommu/vt-d: Block PASID attachment to nested domain with dirty tracking
Date: Mon, 30 Mar 2026 06:11:04 -0400
Message-ID: <20260330101108.12594-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330101108.12594-1-zhenzhong.duan@intel.com>
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231147-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenzhong.duan@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: C4EF5359019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kernel lacks dirty tracking support on nested domain attached to PASID,
fails the attachment early if nesting parent domain is dirty tracking
configured, otherwise dirty pages would be lost.

Cc: stable@vger.kernel.org
Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/nested.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56ce..16c82ba47d30 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -148,6 +148,7 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct iommu_domain *s2_domain = &dmar_domain->s2_domain->domain;
 	struct intel_iommu *iommu = info->iommu;
 	struct dev_pasid_info *dev_pasid;
 	int ret;
@@ -155,10 +156,13 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
+	if (s2_domain->dirty_ops)
+		return -EINVAL;
+
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
-	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
+	ret = paging_domain_compatible(s2_domain, dev);
 	if (ret)
 		return ret;
 
-- 
2.47.3


