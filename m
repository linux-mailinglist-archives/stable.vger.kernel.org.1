Return-Path: <stable+bounces-176225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4155B36C51
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9932FA0633C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FEC35A28A;
	Tue, 26 Aug 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lQaLP7yz"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF1356909;
	Tue, 26 Aug 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219104; cv=none; b=bw4SbGh4ZGhloh80JXttDjwEb7F5YtimkCkj6CFL0GUnMhYr988QI3eSdaCUlDgJ4+TTMyNDm+2CAUNLr5fwPtltiGb/UKYWrug2tJ9epJS9TOZQZCp6AVYG9z99RjZw8BxQz4SB+kWNUGFzIl4dqWfLGKLN5Z7tzyb5woLBW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219104; c=relaxed/simple;
	bh=DXMxr1RwMg5MgmT6auTJbgNnK3Ha8uV4voztH6nmFhY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YGexjHJXXwtBZDZjnyv2ggGCY5rTCTtBANvxh4bKEMeP/Ok2ul8IIpuxy6a85obApe26H76mmB/eRBoQ2y0STxwyAuQWrOwGe2MGjQH/rfXTwVWMyw1IB2wB3Pu6DW4wPohksqKSvwi7frjt5rBNqW07LmINOS7bpvOAjoUmqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.nl; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lQaLP7yz; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756219103; x=1787755103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RnOjmImgu9Zqc8q7j4uUzhidXc03x0+ZINGJ5dF0yBE=;
  b=lQaLP7yzfSTf1vzBpmJ0zpfSv6AvFtLsWmAKjpAbNbnllsTqdS+q5Hft
   4W7CneMqEpYnBXabGA+2F10tQg5EceYzI8eu6doYC9HTcO3mkjjmNMrSA
   oDyIYnfOf95BHblkGZuX88G+7AyNumw6EN34Lm9FzFnCRw044I1M8TCmd
   Kd9wWtXouDmohvO13XWs4BzW781RjgqwBk8sYF/l5EER5c2ea9v8Ro5iR
   Pe3FmpIJdYvOTBWlsTPPbdG/HixdStXsf8KeD4iWCpkbYboAjl+1McmFn
   wQaqsNb6Ue2Hyl2SGOERYYTlyQNiwbZTHJAOsZunr58KljQArR+NcInDq
   A==;
X-CSE-ConnectionGUID: rDqMdqHMRBGNZ4CVnSOF0A==
X-CSE-MsgGUID: MkVkqfW4T4eoXhwL6I+iKA==
X-IronPort-AV: E=Sophos;i="6.16,202,1744070400"; 
   d="scan'208";a="1825599"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 14:38:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:25577]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.13:2525] with esmtp (Farcaster)
 id 0ef9058f-704c-4a37-ad9a-12fa6f5bd087; Tue, 26 Aug 2025 14:38:20 +0000 (UTC)
X-Farcaster-Flow-ID: 0ef9058f-704c-4a37-ad9a-12fa6f5bd087
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 26 Aug 2025 14:38:20 +0000
Received: from dev-dsk-eugkoira-1b-58cb2f48.eu-west-1.amazon.com
 (10.253.75.199) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Tue, 26 Aug 2025
 14:38:18 +0000
From: Eugene Koira <eugkoira@amazon.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <longpeng2@huawei.com>,
	<graf@amazon.de>, <nsaenz@amazon.com>, <nh-open-source@amazon.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] iommu/intel: Fix __domain_mapping()'s usage of switch_to_super_page()
Date: Tue, 26 Aug 2025 14:38:16 +0000
Message-ID: <20250826143816.38686-1-eugkoira@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

switch_to_super_page() assumes the memory range it's working on is aligned
to the target large page level. Unfortunately, __domain_mapping() doesn't
take this into account when using it, and will pass unaligned ranges
ultimately freeing a PTE range larger than expected.

Take for example a mapping with the following iov_pfn range [0x3fe400,
0x4c0600], which should be backed by the following mappings:

   iov_pfn [0x3fe400, 0x3fffff] covered by 2MiB pages
   iov_pfn [0x400000, 0x4bffff] covered by 1GiB pages
   iov_pfn [0x4c0000, 0x4c05ff] covered by 2MiB pages

Under this circumstance, __domain_mapping() will pass [0x400000, 0x4c05ff]
to switch_to_super_page() at a 1 GiB granularity, which will in turn
free PTEs all the way to iov_pfn 0x4fffff.

Mitigate this by rounding down the iov_pfn range passed to
switch_to_super_page() in __domain_mapping()
to the target large page level.

Additionally add range alignment checks to switch_to_super_page.

Fixes: 9906b9352a35 ("iommu/vt-d: Avoid duplicate removing in __domain_mapping()")
Signed-off-by: Eugene Koira <eugkoira@amazon.com>
Cc: stable@vger.kernel.org
---
 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9c3ab9d9f69a..dff2d895b8ab 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1575,6 +1575,10 @@ static void switch_to_super_page(struct dmar_domain *domain,
 	unsigned long lvl_pages = lvl_to_nr_pages(level);
 	struct dma_pte *pte = NULL;
 
+	if (WARN_ON(!IS_ALIGNED(start_pfn, lvl_pages) ||
+		    !IS_ALIGNED(end_pfn + 1, lvl_pages)))
+		return;
+
 	while (start_pfn <= end_pfn) {
 		if (!pte)
 			pte = pfn_to_dma_pte(domain, start_pfn, &level,
@@ -1650,7 +1654,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 				unsigned long pages_to_remove;
 
 				pteval |= DMA_PTE_LARGE_PAGE;
-				pages_to_remove = min_t(unsigned long, nr_pages,
+				pages_to_remove = min_t(unsigned long,
+							round_down(nr_pages, lvl_pages),
 							nr_pte_to_next_page(pte) * lvl_pages);
 				end_pfn = iov_pfn + pages_to_remove - 1;
 				switch_to_super_page(domain, iov_pfn, end_pfn, largepage_lvl);
-- 
2.47.3




Amazon Development Center (Netherlands) B.V., Johanna Westerdijkplein 1, NL-2521 EN The Hague, Registration No. Chamber of Commerce 56869649, VAT: NL 852339859B01


