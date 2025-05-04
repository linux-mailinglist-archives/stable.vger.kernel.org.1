Return-Path: <stable+bounces-139549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7E4AA844E
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 08:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364017AA33F
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 06:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8897C136351;
	Sun,  4 May 2025 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qACkAEXu"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CE33E7;
	Sun,  4 May 2025 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746340024; cv=fail; b=hpnCaz+kCNAjXNnEB07me074rWuS2ZZcpeZpUhqa0nBJ2CAeK/TRUFO9xsiQraijg/JGL8Y0xv5JiqI6VoKGVHxCpqgZcnYcgktr0cln7stF3ekc1Sze7egCfePkW3nlRmm1Y2z5SseHEQeQZodVkj9hlDtztqE9yFKM/fnL6PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746340024; c=relaxed/simple;
	bh=tZ3Jv3r7EUn3UhhcI+cyAUaepQ+GyVFCUnIGl47cnRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vqs04pbCa+raiYi6hPerEag8bgzhxJ5F3F/GYcXQW/rqSM9UBINwLaGa8rL1pozHtpbImbkGT6g+OTcKy34kTMiXOAt1kfUw9EIz50Hud3AM/d/GZRdid1O1I+jIMuGCKjPJdVhgTQQz0DQHMcISLCyY8myUrRojGJfyO/sLV34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qACkAEXu; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUR6VbYqj2GYE9QgIGwkKsr06xCNbn7EV0ZMbKyU+ILR7DpbhBXolWG/ISULs7YEEOsNtZLutNdMyLyj7ntOARYNtHhY9W/7djtt5tAX9l8EPMjpFGVbn+sdcxsa7voU0/H1T7e+PzFYzVkUJr04X6s/zUPf9tzvJX+dFsEnCxNk91mEikJ6mvGc+MYzXbRnxHs+LEA8kDwuMbts9uBR8EIl8kF24mC+ZyA/maEFZvppSM79ZdqvNhrs6zgTA9bydOai7ATTod+/AK35VJrgRxPWAf7xbeNuFSV+EhLAAzH8P9mK3TFIO66q+K/Ffh5LJx0+skBtz3f9hPMzFmvrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PaK9p23ZIX0olOGsqmh/jb6gviW7Bf2RqPqBNX6Ago=;
 b=MXL2EHaGIPZTGbbEBhL1B5D7MnC+P2sBNnivS2k+zWzDI0rdsmB2i0SgEgIO+RPkQq7bTYNhP3BynysJ4iPF3djRs1VaDp93eAOwPQoHFaR0KCHLEUdz9jfHHnnE4ue59lpPq6SBETBoccvdt2R2I/VvA3jqxFLpm3wPB7tNpFwmPdrqhnnyINChQ1/P0UahdQg9xU3du4gtRGeCtgz+PYOp6lhOVDiSujyYhe5hYM0SMi9RZViMh8KPFmxDMU26Pw4onQqcHRt1tbqvxIAIyXW87lSf2qGazYipB0MOXbjXKwGjbRXvVS8BbQ8PJ9JuwxXC4/p6O6imZMIIK2pkZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PaK9p23ZIX0olOGsqmh/jb6gviW7Bf2RqPqBNX6Ago=;
 b=qACkAEXu+DC6w4WfjQXAPPdvRB+RgWDYvaiE/TsW9kwL3/1O1LU7pCCq5OxKAKaX3I/8zuDqd6+zVp9ltvuGJ3VXoSWtvSf8dR5n4XH5rd56F0+4yId4C+K/Iz5P7LE3GzdEP4a1qSL38s7cctyZK+ElVQKZRv6pOB+i/4JeYIE=
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 4 May
 2025 06:26:58 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::e8) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.16 via Frontend Transport; Sun,
 4 May 2025 06:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Sun, 4 May 2025 06:26:57 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 4 May
 2025 01:26:56 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <michael.roth@amd.com>, <nikunj@amd.com>, <seanjc@google.com>,
	<ardb@kernel.org>, <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH v4.1] x86/sev: Fix making shared pages private during kdump
Date: Sun, 4 May 2025 06:26:42 +0000
Message-ID: <20250504062642.144584-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 24dff9e7-8522-4dc8-b260-08dd8ad4abbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tjAG7OVZDL6UD9WDvaOouyPjhBTz+pRbIb5N8AFLCLrr3uPVHkeKoC4uQEUy?=
 =?us-ascii?Q?b/Bcnc64d8nZq1Vaf5MwDJqdUwsgqzk/NvRqAUcl1/uqWoW42Zyn0rIESjpk?=
 =?us-ascii?Q?2o14JeX03xeWHwMqrWQafH3OR8UDwavcNzg9plByFVkZT+5TP/vJPkV6n9Gd?=
 =?us-ascii?Q?1VM778ItQF6O784S9YyiyXVYnhaESNn8UfUrONmZLB8s/sj4LURllJgQ9qqZ?=
 =?us-ascii?Q?3q46iWP38KZhHiOHyJwuQLh7XYkf/JEYjzleV98LseqbjeF4mIOoj+uA140G?=
 =?us-ascii?Q?sFl8R3AhcrGt/6dDlEzpLKvnjjHn7vKhBkl+e7ueaHB5JdfR7Xs+V/IqQ4ID?=
 =?us-ascii?Q?30OcKvLvmwAC8YQ637sIKX6v6hiZdmuCFd4L+lJ/97ItkqV5/LkXt/pOBKPU?=
 =?us-ascii?Q?4R7dWukIN4BOAI0nlo5cZ+ABzKb2WVQtFWA29+xVGrTP+kvqBLSHPpwL57cJ?=
 =?us-ascii?Q?MtAmN60ZVgkeM5ipnYBt4k8+qIGLPB+ra7+xg8mfBqg4nusUhe6zkz9Z01HF?=
 =?us-ascii?Q?1GFFGZq5UjKdPZl7zRV+CyF+CVjgR1Shl1BCLYakv2YMrxSKJcLoNG4E2qSV?=
 =?us-ascii?Q?HGF/UbcxvxGLOtKUksuZ5SLnKTd3wXmPKtXdMkdAe2VsecwSMGK2d9rjr3yF?=
 =?us-ascii?Q?zp+XiOI5/XGRIMeJKdh9M2OsaW9meXS23O1Q2ktNsk248OMQYb8w6u+6zXh1?=
 =?us-ascii?Q?STiU+Vpx0baq4UafvQNSjmFMIoiGjSl5ltpRZIK0NnSXmSARDpXjlLNYpw01?=
 =?us-ascii?Q?CrjX8sjqZSewONgNOtDFLJVdgO7zyyIUe5SoQPnWnDXPL4Ta+sVfQTZQSeVG?=
 =?us-ascii?Q?D/00E9nCi/IFjB9m/Ntu2CmQ0DIAVmcWTczKxbMiFvqAr05WIPf1UYd2L4Xd?=
 =?us-ascii?Q?Ud2ZgFnnzLE+jrNcmscUnBqJvYuzpVSLGmy0l4Hz20xfEcydrL55Kz8eB6S7?=
 =?us-ascii?Q?PpgpomgwakR/h7r2Cp/Km3RganT+j3sPG/VABb2svnt6RNjOqMLS6nC6B7f6?=
 =?us-ascii?Q?6Csu+5JFlhrhNMrGiRIweraflTAQcDAm2b+lI9oiwZq7/7VsM4wzvqaO3vRs?=
 =?us-ascii?Q?w6hvrJRytx1lmG0hS/qTsJjIQE/rEE0GPfcGJ3rlkyceGmZARzCQ+01L2yam?=
 =?us-ascii?Q?/4buVGdnC8jWs+mctzjzENxHI+BeSUCTM9hXFpHHAz4xpem+0eA+i7FX36W/?=
 =?us-ascii?Q?LBjH6yxUgWOKX4O2UvADveDytjy1qbo4Y691KLVoGvVbEDUaB0EGIrhXQOlB?=
 =?us-ascii?Q?Z6SQOVhZiNzOCPI2WYNxocIB3Tah1a48k67eFMuXD/T/zDtWDkmETBt+4LaW?=
 =?us-ascii?Q?gTKG2J1gdxBzy2bZWfLSTKHq2VALMFko38a6K0raHklw3hZ6auhIDadw55Y/?=
 =?us-ascii?Q?xf4hHDggQ+14Dx7v8IDHWBZJum6uQdaE4mhgf35voBKCsWvDXUeq5EGdOTEs?=
 =?us-ascii?Q?gVYS/dFj9O73m/b9FinVFPkcv7yIIOEAxrLN/8xyR9u28tuyA7aKEsFdoCkv?=
 =?us-ascii?Q?/7jH/q+Vfp/vWGsuuOmbpEpGEwQeu8hue+hq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 06:26:57.4186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dff9e7-8522-4dc8-b260-08dd8ad4abbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

From: Ashish Kalra <ashish.kalra@amd.com>

When the shared pages are being made private during kdump preparation
there are additional checks to handle shared GHCB pages.

These additional checks include handling the case of GHCB page being
contained within a huge page.

The check for handling the case of GHCB contained within a huge
page incorrectly skips a page just below the GHCB page from being
transitioned back to private during kdump preparation.

This skipped page causes a 0x404 #VC exception when it is accessed
later while dumping guest memory during vmcore generation via kdump.

Correct the range to be checked for GHCB contained in a huge page.
Also ensure that the skipped huge page containing the GHCB page is
transitioned back to private by applying the correct address mask
later when changing GHCBs to private at end of kdump preparation.

Cc: stable@vger.kernel.org
Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index d35fec7b164a..e39db6714f09 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1019,7 +1019,8 @@ static void unshare_all_memory(void)
 			data = per_cpu(runtime_data, cpu);
 			ghcb = (unsigned long)&data->ghcb_page;
 
-			if (addr <= ghcb && ghcb <= addr + size) {
+			/* Handle the case of a huge page containing the GHCB page */
+			if (addr <= ghcb && ghcb < addr + size) {
 				skipped_addr = true;
 				break;
 			}
@@ -1131,9 +1132,8 @@ static void shutdown_all_aps(void)
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;
+	unsigned long size, ghcb;
 	unsigned int level, cpu;
-	unsigned long size;
-	struct ghcb *ghcb;
 	pte_t *pte;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
@@ -1157,11 +1157,13 @@ void snp_kexec_finish(void)
 
 	for_each_possible_cpu(cpu) {
 		data = per_cpu(runtime_data, cpu);
-		ghcb = &data->ghcb_page;
-		pte = lookup_address((unsigned long)ghcb, &level);
+		ghcb = (unsigned long)&data->ghcb_page;
+		pte = lookup_address(ghcb, &level);
 		size = page_level_size(level);
+		/* Handle the case of a huge page containing the GHCB page */
+		ghcb &= page_level_mask(level);
 		set_pte_enc(pte, level, (void *)ghcb);
-		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
+		snp_set_memory_private(ghcb, (size / PAGE_SIZE));
 	}
 }
 
-- 
2.34.1


