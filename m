Return-Path: <stable+bounces-171614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D92B2ABC4
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC4A7B0988
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4D183CC3;
	Mon, 18 Aug 2025 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pzCfCuO6"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2C233133
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528934; cv=fail; b=OZFwe/YUn1OcRQt3YvFHW7uZjF3KO6FrIxv4pn5ELc3la7d/uOgZo0EDrbHvAZrKvsBh0GYweB889NclSkOqH5/yK6+53InX5lFGNWCRmgY/TXQEGgMtCbFnFnAL7Qrqy2M76TSaKzMmGKzxJf/FOrdic/RQi0Ccbkn53LzKtig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528934; c=relaxed/simple;
	bh=H/Fpwl9LA3bU78FZJQYZkctUEc1jdynqzddkofJxjmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjMSXbZqqEN8Cixn6HyJ0nK+rthCFOi+yUicfvq5ASu4CNnOIKMee4U3L2Zd84KbqRk4VbzM28HexdLQUwKFkeMv/OorNKHjNgzyVIQJoVfEaMPmN8SSYKyh8hXcCpNFovWyz8E55qO9FbvemJbsl/14qXAerS0Om/GTWsvErgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pzCfCuO6; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mI/lr4y0+9+LQA0PUBpaWZrf5G0rnn+utbC+j7TeSw/EfnXRNXPRwSn84aQOq4QdqG3TULTn5WISp3zwAVC0uGC+i6/PD3IBc7H2fH8m71kDWNAHMa8cRTVcssM5ENrtBaZ2sPTG/hbYwrHeamyGqIbW/UsyLGv7/DiLQkvu7XhztAXPtIEWUTMVGnm7G8m3L6H7anj45uTO9vxY8s0fbA3tkCXfaisnbMO1Myvq75TdEC1rBevAU5ljSm396XX49l1rCUga6fJ9t+4fT6W2iOkyek1UwfxW0Hu6oXQlBtX+KQiTj9Ay/2y9GRqKVZ88aHmmPEjWiEll9tfC4/1fmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7/ZG8RuTZQWCEVHx9sEciSvPLxa+HTSVuuVzbR10W4=;
 b=P4GcfdpUAOQH9/LFCdn1o+OBpPpf1J1PWyhYMVxGs2vspJdwTvt5K3koSoHSjK2/BDa+OfizwizhkAMqSLQDUOBYypguf12qE69ZFQHwtLEHf5RPu20TidSG395Ksaz212LgZuXv4bd/IP0yeYSDXDTZnsufjcXuI/V6FQ7Ys7tyM8YCZx5cHn+x/KZccT+nvCtrxbYvVmjnBV75/LSsveLYnZDBuAY/G7KfQCUEz1xYn8oFwnIKuCvMsysuHkfmZAP+GqJQO/tLBZRkmfcPEmXgVATV6wBRhNh66QdwgkP7Vo5pD2hVNlGJyTaSVYDBtjv9XqtK2gwNMbf+ToKhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7/ZG8RuTZQWCEVHx9sEciSvPLxa+HTSVuuVzbR10W4=;
 b=pzCfCuO6oc7ocMRsg07dBJfOgjWeqNCQj7WPbQ7xsPuNavKii57pbpS5QYrQAvBhRG/v5Ngi6uDtrI8qf309D4+GMc9IkFxYVt91wmlXyCDPdmkznxmePlFtRelBW/+2avH3wLN38frFKak86EMXgzpl7FCs+Hen1jQS8DTy8h4=
Received: from BL0PR0102CA0054.prod.exchangelabs.com (2603:10b6:208:25::31) by
 BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 14:55:30 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::d6) by BL0PR0102CA0054.outlook.office365.com
 (2603:10b6:208:25::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Mon,
 18 Aug 2025 14:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 14:55:29 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 09:55:29 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <stable@vger.kernel.org>
CC: "Borislav Petkov (AMD)" <bp@alien8.de>, Joerg Roedel
	<joerg.roedel@amd.com>, <stable@kernel.org>
Subject: [PATCH 6.15.y] x86/sev: Ensure SVSM reserved fields in a page validation entry are initialized to zero
Date: Mon, 18 Aug 2025 09:55:23 -0500
Message-ID: <20250818145523.3775305-1-thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2025081850-culture-uncheck-1048@gregkh>
References: <2025081850-culture-uncheck-1048@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d297e3-91df-4ae0-01d8-08ddde67465c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k+JP4VTVZYrFEgToE6xUURnCl/d8bIWnG49qIjo/Uqlcg7j8qOHn8gk7MKEY?=
 =?us-ascii?Q?ceDzpmAzXubpgAEVFI4jHKm+0ofg4AjEJjZSMiAIWpFq8OqaSKSv0+K/MjMS?=
 =?us-ascii?Q?wOVKdyg1D1Vr3qBWnwx4Pm8FhwAElh2Fvti0j58bEJnZfsmJuEQSsIPlhEOS?=
 =?us-ascii?Q?5oITxipJWJVmxZTMD+SvDnT6rECNO20SbaxPLL5Im5nPgsvhuZ2mcCryOJEr?=
 =?us-ascii?Q?rNNDxuYCAmbwuCJoDG/9uUC0CqKnY7ak6JDOVTfIsaaPvOkOs+PbKIA0EcB8?=
 =?us-ascii?Q?XRJLnYlgMVnA4C9Pno2VL040kANq0Wxf7LmP5zu22y1HQ/C2IE7LibbKe09X?=
 =?us-ascii?Q?ERLvWA/V1I4F7VDikymRVOR/vrvKl+z9TWfTrjw05/ZeRKP8P1oFcCvo377C?=
 =?us-ascii?Q?SIlBFwvRD37igpYGdrmmm1jyK4yXiIzT/5I4f9DllOR2BZHuhVfTsUzkdzTk?=
 =?us-ascii?Q?HC3a8A9KgVaWOW/RCoxDU9BfnhnYWJx6Rp89PZrAd9GEC4DT83QqgeVBgEd6?=
 =?us-ascii?Q?2U52Wa/Hh4fTkgKyucOCSBdQxbWHqHs+A9i3OnxeD0jMMgjgpyzqmFnPrkhd?=
 =?us-ascii?Q?TY7alOaKSqwqE0XdWJq5ISKNjy+uodafKKdfCFfa25J8oyqDosW1gyEl909f?=
 =?us-ascii?Q?u42hMR9hTqAqnQv7vS8hph8a2+8KSXhG0zYrpRIAGFs/0RpUVR0alseW8duc?=
 =?us-ascii?Q?LSFSHFkAL9rjb2EtL7wpsL0D8KUN12VmnnmUA2GzOKRsg0ikacXW9fawCV6y?=
 =?us-ascii?Q?aknkROYiA91Q6rU9Iib9YrnZk5zQI0E6uWJqgi9MPtnYe6xubVrCPrJkESD2?=
 =?us-ascii?Q?RXUkkazjfGZsDSp1Vu/Thbfh0MdO3PPULaJMd8ngAkzM5MYsmmRGjUUzDis9?=
 =?us-ascii?Q?iEkjThG4/P9kv7e2Cj6swfIMYKrWpa5qcLMFUrkloVUMXwsbOxk6aftJacrR?=
 =?us-ascii?Q?t+9k36146kQQDrmfwMINrpL+kSiD4UY7JJq3kHk60POxpGyxPPj5RgXzKHGj?=
 =?us-ascii?Q?i58v6g3yed+P0rgidpfZVEeoVNmv5/EgyoaHaJhpQvCnkd/vKJHW0Ke0kt7u?=
 =?us-ascii?Q?4KVZdT3EaS8wXJ+oZekC1buzQNeX3DfgXvwsPv3yEUIi/s3McNhJNJ1lICAK?=
 =?us-ascii?Q?uPNwfZ8R3jpuBxMBgswexAUt+iSqXaNwr9HY3zMXPQTQAPJieh3n7ySw5ynK?=
 =?us-ascii?Q?+c6Pyzq7/EBHDPKGmWSDlF08mFkhKgJVIGSnB+VT819MGmuARUjSj47eF9al?=
 =?us-ascii?Q?kJ4ttlByQB05x2Gh763xxsbyqJEsgBcNpmV6Hlc73SJY36ONpYoYWsRHRNQz?=
 =?us-ascii?Q?SLqu3+bJX4EZjopQ4pIeRo4YC0ChbzN6IlG4DbIVmtficYYNT8R/1qdjqP5K?=
 =?us-ascii?Q?w1o17mzt8IPRXeJpghJ0W4Z0y7QJjeTVQnUw0DPKD1xONTJlaB92oDV0fJPj?=
 =?us-ascii?Q?GCThEo1Qe3a4GV0Zt/eFQuY4iftSC+pI/CiPgErRZQTO31BIr85dKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:55:29.9477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d297e3-91df-4ae0-01d8-08ddde67465c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379

commit 3ee9cebd0a5e7ea47eb35cec95eaa1a866af982d upstream.

In order to support future versions of the SVSM_CORE_PVALIDATE call, all
reserved fields within a PVALIDATE entry must be set to zero as an SVSM should
be ensuring all reserved fields are zero in order to support future usage of
reserved areas based on the protocol version.

Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Joerg Roedel <joerg.roedel@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/7cde412f8b057ea13a646fb166b1ca023f6a5031.1755098819.git.thomas.lendacky@amd.com
---
 arch/x86/coco/sev/shared.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 383afc41a718..b433bc831764 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -1296,6 +1296,7 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	pc->entry[0].page_size = RMP_PG_SIZE_4K;
 	pc->entry[0].action    = validate;
 	pc->entry[0].ignore_cf = 0;
+	pc->entry[0].rsvd      = 0;
 	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
 
 	/* Protocol 0, Call ID 1 */
@@ -1385,6 +1386,7 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
 		pe->page_size = RMP_PG_SIZE_4K;
 		pe->action    = action;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = pfn;
 
 		pe++;
@@ -1415,6 +1417,7 @@ static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int d
 		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
 		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = e->gfn;
 
 		pe++;
-- 
2.46.2


