Return-Path: <stable+bounces-184040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F99FBCEDD4
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 03:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E299F4E4CFF
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 01:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F756B81;
	Sat, 11 Oct 2025 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BI9bp86n"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEEF249EB
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760145990; cv=fail; b=SHrnmKrVZCh/RVgeJHpkTtgG9I4qeZHybnQ6Uf652jVA46rJrnhgxDgjKq+F0vppTxqsj0ZjRO/Pn6fOTVMYbPZq2Yoq8OQh6nq49iR2/u+m1yahZd5VF6TsWb4XRKUyko4gR75jf+L384VZvTfB9mi2PrsZv8E34nvBhB0DcKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760145990; c=relaxed/simple;
	bh=nS9onhdfvAOrnEqyh5YZaECEAAKNT9pPw5YI1skv2ek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XNoyZd1eZzlk3nSJDYTUI45aBxudu4MG8KDMeby0+6JCdAi6PnCRIpyShIMPMgxngZSWYjdID3D1GXSGZcS0pWRLBMuViiWdOeYWpN4wDWG3kU9n+9CRr2kwvcKaNI17ICSlwe/RrojxyRscNTBMJYFMIPbWQNi+lDAPVLwKdMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BI9bp86n; arc=fail smtp.client-ip=52.101.48.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHFIooPt4AnElbLh63jjnjc2c7m825yFZGCErXPK/CNOuoqSGxlfExrIIf9+fdVuQ+Arlyds6XruwrrqXZDoBjih7NRdsNBVhVAzbWVJ6O+Ca/H0OivDCBNHQvRaI0eN4n5tUjRM0+UZwSpbnpZwliC3WQpYWfzwLkSS6q7ycbP9yde24RCtBy65fufpANrgEmBCDLjJ/sMH9Dd1AbxZRqburp2+59MRU7MtGb3ehMMbIfdDp1z3UL/a3lV6wFDYiKgnBsPDp+cJF5HHlvAkphvA7T1GrzmQx7+NSern/QUM/+2cqUAhEK+RUvwkxrhaJ3tIl/iZIMwDyX37facT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UNkzQrUqA71VvRK8vuikHy9/d9hgvzD5R4If6P9xoY=;
 b=zOpIwPYLO6LImrawKbUW/k3ZxvoYjopqcjaXLPEB7D7V1gkXMxuSROLEAUVt9A9Qn2AQE/r4MYsTrKqbYX6ERng5iV0BFCbG2Mue8Yb+R5DV0LGZ4phgduXjX4vcPB0LO9fkC1/YBvQfim0RIiqzqPVD2MvJJDD/FF03lzrYPCjs0QEuCbt/Nz1tGzAfG69zbbktI3GMLNWbWHzJDTf5txANraf4lKcQeYxoIZ8l0S2vOoF5XZhlsRVpEPQAA/obHpYopmu0Ty80itBcYspvHeRLeniyYHQCOVnESTywyZ/14TysKoYdey4BML5JE1IaoKaHP4T35BusDI+6hUPwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UNkzQrUqA71VvRK8vuikHy9/d9hgvzD5R4If6P9xoY=;
 b=BI9bp86nwesmUcvlrQSanpgwXhJHbkN3nZVRiph+HAr4uqZUMlGu+Sc2LB6XqRXOOoTV4vEsyMmeO0z6fMHZZkx24fkQYt5jUrtixZonlfdYYtjYOixVtfWV2CM0Syhad6pfadDxyqD7owb0VwCofWcDeJh4B6HKzWKBBMOmPQE=
Received: from BYAPR06CA0036.namprd06.prod.outlook.com (2603:10b6:a03:d4::49)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 01:26:22 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::d4) by BYAPR06CA0036.outlook.office365.com
 (2603:10b6:a03:d4::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Sat,
 11 Oct 2025 01:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 01:26:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 18:25:49 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 18:25:48 -0700
Received: from xhdlc190345.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 10 Oct 2025 18:25:46 -0700
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <git-dev@amd.com>, <michal.simek@amd.com>
CC: <nagaradhesh.yeleswarapu@amd.com>, <sai.krishna.musham@amd.com>, "Jani
 Nurminen" <jani.nurminen@windriver.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<stable@vger.kernel.org>
Subject: [LINUX PATCH] PCI: xilinx-nwl: Fix ECAM programming
Date: Sat, 11 Oct 2025 06:55:39 +0530
Message-ID: <20251011012539.548340-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd07a12-a6d3-4a41-1523-08de08653011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M+HOIxHSMHt/SF+wpJANhP4kSjeE2QLMLWYJJ/yfT8xtBTrAzQO7K4708hgP?=
 =?us-ascii?Q?RSdGd8sowUFNG9iRW+z5Bwdj2fzqnXzS5puDs3Uh8+LOp0K4EVBtXKHdnCX+?=
 =?us-ascii?Q?MpUYq1ickR4GowpyCbMPFPC9vZ/423SSPjQesnATD49IqyEykTTyvRh84tCx?=
 =?us-ascii?Q?XRHmEmQC1IbVq0gS7H5mAX4Km4balLN/c17XlvkLSO3vuyZEaGxZgikQmXZc?=
 =?us-ascii?Q?9vFMdrXxAWSwzfVYluIKOPsehdaZJMDZsADDvvnOKR+wm8gh6Ynmg7iuelBU?=
 =?us-ascii?Q?QyUs0Vp1F7UP/MlalmiD23pv/MPuDSl2J3s7RxpAnDNupBZWi55Wv+wLxWqF?=
 =?us-ascii?Q?Gr8BKXsowxVBHrBSoTK3drdMwpGQ0839MwjNiWPTqH8/bwAn6FRSej2g4HhS?=
 =?us-ascii?Q?5uRHoFAqgFEyKJFaNEnFDWxgogYOiws6s9/4usFGSpP21oqNcRWdfta7zhee?=
 =?us-ascii?Q?hw/+41A6IVvmIE6KvSQYAHLW/w/zYd8eSZdw7C00DYgKXZWwiF3TFpJuPixR?=
 =?us-ascii?Q?ZAKXT47rqfBNbe/PNK90mDpurcfS+lr31GC9E57IET2WwV/YKZE10u4Yzap3?=
 =?us-ascii?Q?vjIjMj/aV9aw3YZAOGyEUSicdJXANz5Fb3oAMDpgEF+EtqJMkQxALOcIfkOB?=
 =?us-ascii?Q?acVXbkdOOyriY8oD1VH3rcsavU3TeW8tBrZw76oyPyy9aq124jHGD0ehRGDM?=
 =?us-ascii?Q?RKjKUIp3Qa3KiLGceQY7KNmxYBDnsncioDef3Co2agu3rpUU8Aq7rcMk//CF?=
 =?us-ascii?Q?xzz/ABXoA7vbf9Zv61weitoIbAhdMSAxov2EJA/YeMCgQ+52aC6sMY1XoLyf?=
 =?us-ascii?Q?B4K/1WhSAkaNja2HjG0RWqnuvxWUm8HZpCCGrb3MTy8kjxms36IoQe5mnfGv?=
 =?us-ascii?Q?hbamJoFv3UXaw9aDOy/QJLmqdJ6eHZ1oKexFGPxsNwzW5ya32LubwDZAFzYJ?=
 =?us-ascii?Q?AYSddT63/QZAB29l2STrK+G2KKrGsYWI2ayRJVkb2VEmbnvbekvsB4Ie99vD?=
 =?us-ascii?Q?acTHzR+fgif6fTwJpdUEL+qTuXrc60IQhF8J5IynrJ8rJ+9ruyR9IKNhndmn?=
 =?us-ascii?Q?tGyS1+nDTqD9mW1DpZ9lXQmZrFyvsFFo9OH+akvLD24H5MiqIJeV+kKSffL8?=
 =?us-ascii?Q?C3ycro66VHVzxoXU+i2l4u3NFAL9gtOWmzWPzmihnNPTgFbsYibn/9xf11yZ?=
 =?us-ascii?Q?fP9f9Ie+rjbvybHDNTccfmHcfbwBjn6fR65GQWY2j7OxkjppoAkjlrvHFjab?=
 =?us-ascii?Q?cKEzLyS5CPrz0MiBf6+TS8PqajlCwQ5VC94pdeerTikkvJX/0BUCSqJjJsT7?=
 =?us-ascii?Q?COnwa9XB99Po787tg8HL6VzBgQUfYs4p/lslmOlON2n7naOrWoMvSK4vSmgu?=
 =?us-ascii?Q?Kk2VRQsAli9hfmuV2bqugtA001xH+frMqvyhRxqB6ysP/e7TG5UxU/QFj/ZV?=
 =?us-ascii?Q?swzw032f3RVceOWpWgmKoGvSztewYkO1uimvFnU/QeKJK46Z8m6sAxgK1KZz?=
 =?us-ascii?Q?3FCMrl5Mej5zfRsfaFHpor7z9E7YX395lLnd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 01:26:22.2999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd07a12-a6d3-4a41-1523-08de08653011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145

From: Jani Nurminen <jani.nurminen@windriver.com>

When PCIe has been set up by the bootloader, the ecam_size field in the
E_ECAM_CONTROL register already contains a value.

The driver previously programmed it to 0xc (for 16 busses; 16 MB), but
bumped to 0x10 (for 256 busses; 256 MB) by the commit 2fccd11518f1 ("PCI:
xilinx-nwl: Modify ECAM size to enable support for 256 buses").

Regardless of what the bootloader has programmed, the driver ORs in a
new maximal value without doing a proper RMW sequence. This can lead to
problems.

For example, if the bootloader programs in 0xc and the driver uses 0x10,
the ORed result is 0x1c, which is beyond the ecam_max_size limit of 0x10
(from E_ECAM_CAPABILITIES).

Avoid the problems by doing a proper RMW.

Fixes: 2fccd11518f1 ("PCI: xilinx-nwl: Modify ECAM size to enable support for 256 buses")
Signed-off-by: Jani Nurminen <jani.nurminen@windriver.com>
[mani: added stable tag]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/e83a2af2-af0b-4670-bcf5-ad408571c2b0@windriver.com
---
CR: CR-1250694
Branch: master-next-test
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index a91eed8812c8..63494b67e42b 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -665,9 +665,10 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
 			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
 
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
-			  (NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT),
-			  E_ECAM_CONTROL);
+	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
+	ecam_val &= ~E_ECAM_SIZE_LOC;
+	ecam_val |= NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT;
+	nwl_bridge_writel(pcie, ecam_val, E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
 			  E_ECAM_BASE_LO);
-- 
2.44.1


