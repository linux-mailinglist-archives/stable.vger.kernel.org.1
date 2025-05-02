Return-Path: <stable+bounces-139518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81980AA7B53
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 23:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389E41C00380
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B66720127A;
	Fri,  2 May 2025 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qEhbWpvP"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A311376;
	Fri,  2 May 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746220918; cv=fail; b=fwqtdtH7ImlJOLetbyxUa1/kuQsAI6wZqAfzMoWJEsd8giToQHtT11GfMMSQZLunlCsiIJCHHRpX1dfSreHoowFG74XwxPwVKIIUbc+QaWeOiGwPJnIP7CdianCXwgeu1LGTZwKNNQemOgn2WxHskFyYH0F9jUqNtUqJrQYDOcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746220918; c=relaxed/simple;
	bh=vt+aSB+Qbqu0Jo6PjkJst8uAWiFZ9ONl6HyC6OYJ9wY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fOmYdtvqrCq0Zpm8kQz8D8xI8L4O3Zc8HPzZSVYxV08e7EEYcdpEzdl1cbA87IHyq6uTcKi/lRul/MKuYKi8/cqCvlRAZV70TmXjrge4GKCON2ay5U1BvY5r6Zwj7TLUFrGsL0Ym68TmMBdfrYwLSjg9/bVvYz3vzeqTi2RxAjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qEhbWpvP; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiGTz9El8qF8Ol9d1Ss5KWakjrXyzaEg3kvACLcVIxgrF6BTdOkpGKZ57lCZ1QQYQ8h+ornKFrb6JvRZ4FU2hDurdzXQZ22FotkTR+29C4ohff0HCOXK39I2KcdBgnVG7N+gv/eRPreuielQpp+rkY8k5MyMPypFIJSc0XxDYpYLnU/U03kh5NM3AXeetzSRYh9FVvfzCZC/mfMBx0CgT8OczZ0e1Guo/FiMgx/OH73kmLoR8Jx7AXtA/xrdiaLJJxBsXFNRtawpUH3mkW2FZe8SAC5ThvGSVyzk6Jw4IGKiPbvmhlo/K3GN9bHeFZo2eDaCJ2VNKO1AQiJUiGaIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImTkuPZW2UYXRTQqSgpv28YsSGuOW75mJWfxZgBsLvA=;
 b=eL+Qc/WU97/yF1HNpyJe4sgOUjGxDjAbMQuhN/3H77Msh6xmrhLobYVmtlY1vexsAIj/eLq/2DB62ihfWmytFXmo7nlrzAPpto9VqKlvUAj9GMCzRWI8rpsapyonBhGJDtJWJJblNzxJtFoELNzOG/PQgZPUOKm8xyMoIeBFHD2RKqCAjNgAnLO5hglNgMgi0CE1o7hnyIiDsnWV3WqLPa8LMcu9tI7DqDITqyOFRvmBbrB+0i06o5RwyZS2/NZntThydoxWuF0DxkUxPEBosmOqStKmh3VNKtZSDWJDlNuOuDrIzB3Q4fZJ59rHH5GHZnhX0dY3swkIbqREm2E9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImTkuPZW2UYXRTQqSgpv28YsSGuOW75mJWfxZgBsLvA=;
 b=qEhbWpvPvLFQ8p+3VZyC69DEZ1Xa8sVAkY3dlFeChvfAOa2wtWlrGa8b4tXOTwYiHR1Lqr5z+Og5oMy5nVP1PRbr4E2PdYL8zrZhXN6o6e+NAq60TY0BuYWaerS4NO3o1C/Q1VETj/GuMxDnSI+2V6Bi1qEx+ES9e5NAIm78UkU=
Received: from LV3P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::33)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 21:21:54 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::bf) by LV3P220CA0001.outlook.office365.com
 (2603:10b6:408:234::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 2 May 2025 21:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 21:21:53 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 16:21:53 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <michael.roth@amd.com>, <nikunj@amd.com>, <seanjc@google.com>,
	<ardb@kernel.org>, <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH v4] x86/sev: Fix making shared pages private during kdump
Date: Fri, 2 May 2025 21:21:43 +0000
Message-ID: <20250502212143.578866-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 324e22e8-33cd-43ff-52a5-08dd89bf5c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?560fQl8DQEErdxEVsdbHUO3OW8644n87k3OdbPoxNYHE9Hu3lcOwWYOaUx3q?=
 =?us-ascii?Q?s55QAJqK7Zvz3HUQNMekBwU4vUnta0NiHjjUdXi4EL6fMhm8UTo4pc0K3ON8?=
 =?us-ascii?Q?sw+qnHv7U2k0nKvMqlsZDOe2AiT5rGYw2RRAIgQgPSHC1K29xv1wgUVsCgWm?=
 =?us-ascii?Q?+qLJr4j8Zp+HXeGrWpGcSZeiwnvEuo+ul+QcKak76mWL0RfG+C+AmRb+n/Y0?=
 =?us-ascii?Q?iTOZCR8+qfVlENrfMSSNQP2Efbg+ymOD78uAI4iwgeUD3au1ott+4xk1c8/9?=
 =?us-ascii?Q?NuBDGHXxrhOZmKeiDvULftNR98w9NTDX59MJ0E4hbJNCH40kTKft5u861Ui6?=
 =?us-ascii?Q?jmdbwnex6jzVzdSOT7jKeklvBeuXQFeRDddXr2TSn1kBXWHand9obCgWdVJe?=
 =?us-ascii?Q?Z95NtDnhLmLY3kl5e3xpgUajEaWkKis0oifeifzr0tlUZonWqR+JWOsOIwAm?=
 =?us-ascii?Q?0Gw/kThEjxHzrp6cnqlc4TRSyMYR5Dtp8ce/umHb4s/eqlpNTddI4IfjzIOF?=
 =?us-ascii?Q?EV3P3vB+e9TLfyHFHkCEQeIDkocZESPk/TTZFmx3TKQmSeUW5EOX0ugFrs3d?=
 =?us-ascii?Q?ry4aO9Xew+L6ctwEoveWc/uTZ5oxkwGLUBBpBOjgBtOu3aeSiNNQl3WPqY6O?=
 =?us-ascii?Q?xB5h53PcF8GDnxKGxdPaB6O9/aLtmBxemcng+Ymx1ExFAjIia+x4K+r7iu7e?=
 =?us-ascii?Q?2/IHV8mw5LRPqqqaDmwqKoKJk8Bl0QIcHDlxLP/ZILa2cwtWMdDKsYvneXPU?=
 =?us-ascii?Q?YTXrAg8+hPD2LmG6GFlbFFf7KpkI9iuUFAOOo3Zg3X8u8Crx428v77tiTs2z?=
 =?us-ascii?Q?NCIj0sGxaD4hFMfOVxNrFuWiuxcPW0RsBPYGyN3ekxv/6UJP8cpa+94QZKfq?=
 =?us-ascii?Q?FbuU95rgkiMyRVGobPZI1cHXqqNoWUUAVJfZwNXtriBKqOASimaXJsN7f4XD?=
 =?us-ascii?Q?eHOU3/uNt9CD+d9ijEz6ngOmQOrELnrOhUqkfsKvGXmB16mrvlnYpD2ZTeko?=
 =?us-ascii?Q?rbgVTojy0KQLKjdStbnU2eW7lkBwJAqKmGdzwiWtq3uqfWzcsfT7kptNfFkL?=
 =?us-ascii?Q?UT2b4MBxl8tiuOufJMl25RPqpTZyOLGTzB3DoDOoxPdTKfoYbT/zCgz2Zt0W?=
 =?us-ascii?Q?oxecCWzn4wf4fN9VPqPPhqSe2cKYht4Xh2GdAfQ05fgPzefmJPsSdpklNv5u?=
 =?us-ascii?Q?0nhlpgz4nc+79WNqly3GB/OisZiyiVq4SPA4nleGJC2az9E0r4x2KnhgykBI?=
 =?us-ascii?Q?p3bqDfoF8Tu2nSeEnXUZwFvmdZskzem4z+fD8Rwlu9ZmEaDVc2iYJYWIh016?=
 =?us-ascii?Q?gcpbJvCTmISN5+QLnxdS/QB31lijlVwLaCoWF+NxVIV1M8/QfWrtZkednHUn?=
 =?us-ascii?Q?uUlLJzyog3hOhznrJDYdpPamUNfFfkzBOC6oONRUXx2EaAofPe7An07ugD07?=
 =?us-ascii?Q?X6cp19iPElvk0JJMePrYkRKfJh0i8oBg8aixDqk4HSTTfZ2KjSSRJZW3KcpW?=
 =?us-ascii?Q?MR9eSqphudSXo65npTZbJEccnErgoVqIrSjU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 21:21:53.9365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 324e22e8-33cd-43ff-52a5-08dd89bf5c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

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
 arch/x86/coco/sev/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index d35fec7b164a..97e5d475b9f5 100644
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
+	unsigned long size, mask, ghcb;
 	unsigned int level, cpu;
-	unsigned long size;
-	struct ghcb *ghcb;
 	pte_t *pte;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
@@ -1157,11 +1157,14 @@ void snp_kexec_finish(void)
 
 	for_each_possible_cpu(cpu) {
 		data = per_cpu(runtime_data, cpu);
-		ghcb = &data->ghcb_page;
-		pte = lookup_address((unsigned long)ghcb, &level);
+		ghcb = (unsigned long)&data->ghcb_page;
+		pte = lookup_address(ghcb, &level);
 		size = page_level_size(level);
+		mask = page_level_mask(level);
+		/* Handle the case of a huge page containing the GHCB page */
+		ghcb &= mask;
 		set_pte_enc(pte, level, (void *)ghcb);
-		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
+		snp_set_memory_private(ghcb, (size / PAGE_SIZE));
 	}
 }
 
-- 
2.34.1


