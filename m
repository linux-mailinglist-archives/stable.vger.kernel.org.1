Return-Path: <stable+bounces-254059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELkVMJS1E2ptFAcAu9opvQ
	(envelope-from <stable+bounces-254059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:36:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DE35C56DC
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43B9E3007AC4
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 02:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733A2253A1;
	Mon, 25 May 2026 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dtfltjvX"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD6322A
	for <stable@vger.kernel.org>; Mon, 25 May 2026 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779676561; cv=none; b=KDOD0qoEKJy0rcRTGv8wEoQjKvyxqjtmhXvV0XxlTp0APs7DnenkPZTs445JNenQRrNTEOMrSnwtlnGhd4ALH1NBRrCNZqP4LfMOMjbpA84jcQnFL6lc9hgTxWb7vVovkrWCLm+iFVS8EfzEc+C11ap8nh56vR/jxyDRKpuhb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779676561; c=relaxed/simple;
	bh=WlEkZOv5nj0ARZNqtX9/2kxG01H0k9HKinBRL/jDQrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5KRS9A5yWzKMAFntc4qDGbnSXO8iEekdcxlxzeI14lZpR5ijNlyu0KiufZDXrKPPmPX50XuLdyJ0wMbWr1oYY6c1rrO3l4FxiFAcetwBJkhpSPPbk+paI0ALZ32WfYABVhG4CdKtDSkHX0R3ijwY1Dz1Bl+ynMVEL0wxnBwGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dtfltjvX; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kkywFzGdQQywiGFe2xfuQHQyuwWQgBARrNGTnWz1u1w=;
	b=dtfltjvXYtDGgW3Du5vG9ZMz5AXZ5Vcocg7mTvzDJh/7dI0RQfP3H1Os28T8fCiGv5+wTy+cW
	m9TwCy0WXvoy0fta7+smjnLZe+yjyYZoBk9I/Brfmqu5NEQPoXzIWlgh5jgkgg6RgYAf8RTT9jo
	2OWOGr9rsZ+8WOyFm2C4JHI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gP0D26hlFzKmVp;
	Mon, 25 May 2026 10:28:02 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id A4B6940563;
	Mon, 25 May 2026 10:35:49 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 May 2026 10:35:48 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <patchwork@huawei.com>, <kernel@openeuler.org>
CC: <xiaqinxin@huawei.com>, <linhongye@h-partners.com>, Balbir Singh
	<balbirs@nvidia.com>, <stable@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH OLK-6.6 4/4] iommu/arm-smmu-v3: Fix pgsize_bit for sva domains
Date: Mon, 25 May 2026 10:35:39 +0800
Message-ID: <20260525023539.3587618-5-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260525023539.3587618-1-xiaqinxin@huawei.com>
References: <20260525023539.3587618-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254059-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaqinxin@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,8bytes.org:email]
X-Rspamd-Queue-Id: 78DE35C56DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Balbir Singh <balbirs@nvidia.com>

mainline inclusion
from mainline-v6.15-rc5
commit 12f78021973ae422564b234136c702a305932d73
category: bugfix
bugzilla: https://atomgit.com/openeuler/kernel/issues/9215
CVE: NA

Reference: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12f78021973ae422564b234136c702a305932d73

----------------------------------------------------------------------

UBSan caught a bug with IOMMU SVA domains, where the reported exponent
value in __arm_smmu_tlb_inv_range() was >= 64.
__arm_smmu_tlb_inv_range() uses the domain's pgsize_bitmap to compute
the number of pages to invalidate and the invalidation range. Currently
arm_smmu_sva_domain_alloc() does not setup the iommu domain's
pgsize_bitmap. This leads to __ffs() on the value returning 64 and that
leads to undefined behaviour w.r.t. shift operations

Fix this by initializing the iommu_domain's pgsize_bitmap to PAGE_SIZE.
Effectively the code needs to use the smallest page size for
invalidation

Cc: stable@vger.kernel.org
Fixes: eb6c97647be2 ("iommu/arm-smmu-v3: Avoid constructing invalid range commands")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Balbir Singh <balbirs@nvidia.com>

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250412002354.3071449-1-balbirs@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
Signed-off-by: Hongye Lin <linhongye@h-partners.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9342fac71801..4075ef00c4c9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -402,6 +402,12 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 		return ERR_CAST(smmu_domain);
 	smmu_domain->domain.type = IOMMU_DOMAIN_SVA;
 	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
+
+	/*
+	 * Choose page_size as the leaf page size for invalidation when
+	 * ARM_SMMU_FEAT_RANGE_INV is present
+	 */
+	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
 	smmu_domain->smmu = smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
-- 
2.33.0


