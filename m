Return-Path: <stable+bounces-141854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17A7AACD5F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8104A32B3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 18:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3516A286438;
	Tue,  6 May 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uU/fU75x"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692028137F;
	Tue,  6 May 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556553; cv=fail; b=TN+0wFY5IU50h6HyvdtpNvxMiOmxwsGFP1ITLOeAdknkEGa4dNkNxOh2tzGKkzZaC+3RMmfBnir7BxVumDLyogA+czI6+P0RO+8Zb5pLnAy663fBn1oTaFh7/2zxLYgsSSFeqhCMHh1GgD4PyGDJ5RpdkMlXZJtAjaeLA9ukR/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556553; c=relaxed/simple;
	bh=wvSqimApZ9EzN31S52EAEvzGiiymg9YNrpwShHe3b8Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PlPo8JWlFZZguHhBaQBbeaH6fFDNucJwPc9H2rjUAhfb3a9qzPlAGwEQvDQ4gDwo8DfNSbmDW70Fwef6SITueG0dkYzGwyRk6Q3VQCLMQMOfWC0Ckbke2aXXtFkNgETqtTw/vHoxLsF+Vdz7SBq0yrQfiiEeOWtqaFLklYKFZFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uU/fU75x; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM7D3fwo8/rimdTeJL5Ir6BoQPu+V7qj9kM7ZAq8T9Ivq3D4ch3aY/vTypKrB7wcqxqWiVMmcZeeGZr9S9tgNd5ynaqhzpfDYhj0+DDg0no8oZMX3a2U1y8E8oNyK1kGPKlBwzH2h/l+wKO5AzPqWMZu+rnWfComRkMraYYwPfCvhCyPbaOTHN7WutoSS3IlqFrg9r+3jsTFxCPTcugn5lhINsZFinvDsP6M0r9gCT8gI2OH5j/WdR4gmgz2dzWMh1/gq1Bw6JSDDC/dgMfJ8UG5+lbrepXMt8OcnS5ieWJs3dL3d5A7VoLgP7sOfTPssxGS5HZcIghIOYCdNtkImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXddQDdVlGciWdiiwOnbHGOIY8x3+yd9guWVk5D8r/g=;
 b=KZc2rZaP0MVqFneg7YD+wJvyTL78cVRTB0fnlCy8NQa8rYz4J9LDWC4BM/lyltozqoRX89P6MMuv50znp9yVPGxIrMtntyAP9EDiEUibqWjQv++IwoZUfRvoWID+jeCtQ2qLCfdeOG9V95L/i6qduhIXhiJrcyPzOIULd/lVBT8ube+c/nbMJSDiehaOhjXkMTGAHJy860vzvh8zCaK3uTWUB5o4JFWZDrmmbXZF2ko8+RB/yuyp7bmlaUA9QjVCxo9KlVNxmlsScSnBciVpJD0Add1w5QnU56h2kH2vfYhnz7bzB9TnKtb1rY7lhXOT9uXuyXlFLVzEhUjVKvQJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXddQDdVlGciWdiiwOnbHGOIY8x3+yd9guWVk5D8r/g=;
 b=uU/fU75xna5AYGwd8BI3u9jjzZ3HJoRDxFpm0xhHj2+40DOF/JHyVJqszKiDTcFNE2TSnmYLHGbFcKeEaSLIWGbyy8WiO2biE8mVMbc66lOf+bny9sHcPsj6lGSWzDZe7qZd8A+QGc+69o6g+Eb8UzHovHx43Kb27sroAPWTtrM=
Received: from MW3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:303:2b::22)
 by BN7PPF0D2C72F0D.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 6 May
 2025 18:35:41 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::81) by MW3PR05CA0017.outlook.office365.com
 (2603:10b6:303:2b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Tue,
 6 May 2025 18:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 18:35:40 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 13:35:39 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <michael.roth@amd.com>, <nikunj@amd.com>, <seanjc@google.com>,
	<ardb@kernel.org>, <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH v5] x86/sev: Fix making shared pages private during kdump
Date: Tue, 6 May 2025 18:35:29 +0000
Message-ID: <20250506183529.289549-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|BN7PPF0D2C72F0D:EE_
X-MS-Office365-Filtering-Correlation-Id: 881ed428-9ebf-41eb-4341-08dd8ccccd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8m4w/DyIfbR0nVHiLDP4xdeOhPABcxtkXZxORdRmgtr9fqhe4Dn0iHPE4Ug0?=
 =?us-ascii?Q?FJL8NMGSM3ZM/O+lqNP8s7X/87p8OvWVi72ijMNjMFLZIxi1h4dm+4jMhbq2?=
 =?us-ascii?Q?tM7AoFikNJSF6a5AJjR+grfgBQnr0XQ0b9vgEJz1mi3FJ9Pa655pdeW9WASd?=
 =?us-ascii?Q?UyCP8IgUiMuazrGWP0pUT+LuC9gegcdG+O4hYVLWPrhiEDhLS6yjhVlLyWae?=
 =?us-ascii?Q?pSHpAw+upf8X+yzBSNFTa15lbHbANRFORqWRI2gM6anGf0/lVV3CHtKFhHaK?=
 =?us-ascii?Q?xcvBcOYva+dqalxjvNktGoznYV6II9S1zOR6xRtzzoxCJiTvgPlRoNMIAxU/?=
 =?us-ascii?Q?dRlJK6XNutt3uOVVuCJ/GGdKH8V9j15seK99tmXQ1vU5TCryTkPvYLPTiiXn?=
 =?us-ascii?Q?k97wTLgY86wnCLvshpaib5qDSd9zor5kWx2QwoJmpgrwcs0DGLnSlNrXafTs?=
 =?us-ascii?Q?+EFcUB3lNpj5lPPh2wh53Pcw8wqt7q5gDIiOJT1VSyO03ylacQF9As90gnEK?=
 =?us-ascii?Q?xoba+sPafurFkZOipDCJG1imHKAV3d5KdAcr9nPpl+JZhTN8kSKvRnhaGlBn?=
 =?us-ascii?Q?HOuvoPkbnSp3/L0J6CxlYs5y+F4lbsE+d+QaTjrGXISkws9Yg4Uc3DQzZtv2?=
 =?us-ascii?Q?OjHJTwmH/+QIOoanJGcclcC9Eerux6mRWYMw0KnJ3imA8QJLWPs+PQ+bZruf?=
 =?us-ascii?Q?ABgLVI3+cAbLkfaofxLAC4L1OAUjuDe57CzZJcW01lsiXfpw6w9wN88k//zY?=
 =?us-ascii?Q?zZEITJCRrfVDwtAfcFpnnlLVCvduOvOezBYH1Vn6fGT1W5I9gyt+y5qzfoRt?=
 =?us-ascii?Q?mLdiu9jIq/bklIMFLIuvjtqNG6KS969noHPDgGiFiUy0pHWUWHJQEUhmI5UY?=
 =?us-ascii?Q?HJv7ogS61lN3sadVJevzzVxAdSzic8+vQN8xGEHSeljPN6nFQ3DSjWJSKOFG?=
 =?us-ascii?Q?/ekOlWO8Ez7aV5RgFhedJyYy0Elx5GXmSpFgRKZsLJJzcHDSZYiTXAO/tp98?=
 =?us-ascii?Q?E/Y0BQ4gnSNQjT29u3ClHYRGFV5iFQ55w768hJHUKvODWu+60vSl2eVG3q5H?=
 =?us-ascii?Q?9PiFKAtLHdhWFTeGso3SgBLdwuWm7D87ZU1/KcbhHSHDeWm/cXrP+HqDo5n/?=
 =?us-ascii?Q?92PhCvJcD5n1OuNS0QiHpy3xrHC3HpYlpmu9ziIUJzmkQJ7yFkhR75RP3Ltk?=
 =?us-ascii?Q?TWTfLhjjiZtgqcAgD+GZ2/wKSKvitU3z4o9MuqU+IeF2FowwMieAKHnsLhk7?=
 =?us-ascii?Q?Sr968pDDWTR0Ua4mMIW7GFVk7LrhZKnfb2O+xeOH99Z+bfkUGy/edc+8wf4S?=
 =?us-ascii?Q?avZ21aKtflPxv+aCe0WqJtZNvCzAAgkh4PDHmAb8Inrz5FSe85g+F2x6f936?=
 =?us-ascii?Q?i5atmeXGQWkp/5soDP6TBlMkN9AorTPGFfG+248AKVXgdTWigeYlJ0hBHHkg?=
 =?us-ascii?Q?s3SSuDX/zGI1vc+/TIbn1pAuYbzjPHd53OHiOa8Bddybtj0KBwHqoP1+pAMD?=
 =?us-ascii?Q?xzzoO18EIgdSY8QaaHk5DsfYUSlWjy0R9qc9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:35:40.5091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881ed428-9ebf-41eb-4341-08dd8ccccd91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D2C72F0D

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

Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Cc: stable@vger.kernel.org
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index d35fec7b164a..30b74e4e4e88 100644
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
@@ -1131,8 +1132,8 @@ static void shutdown_all_aps(void)
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;
+	unsigned long size, addr;
 	unsigned int level, cpu;
-	unsigned long size;
 	struct ghcb *ghcb;
 	pte_t *pte;
 
@@ -1160,8 +1161,10 @@ void snp_kexec_finish(void)
 		ghcb = &data->ghcb_page;
 		pte = lookup_address((unsigned long)ghcb, &level);
 		size = page_level_size(level);
-		set_pte_enc(pte, level, (void *)ghcb);
-		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
+		/* Handle the case of a huge page containing the GHCB page */
+		addr = (unsigned long)ghcb & page_level_mask(level);
+		set_pte_enc(pte, level, (void *)addr);
+		snp_set_memory_private(addr, (size / PAGE_SIZE));
 	}
 }
 
-- 
2.34.1


