Return-Path: <stable+bounces-136598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641EA9B0F1
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA06A1891A19
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C7F2853ED;
	Thu, 24 Apr 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SElkqXRg"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA11C84DF;
	Thu, 24 Apr 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504877; cv=fail; b=oeoUqvtj+22xyE9hgcjqycgecYz3DpXDUpr6uEwNAdHlIFR1JCWHc9j5EISMFxu8OQtlJPxTWMaYtaGI690TpE5XntJ4wEc4Vr8im94tHVGTM0AtOhJ+iFwoQuLxcnGBds0cOwJsZ+xl7D9xmGjrWYZHFr5msucUVD6Q3ixE7HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504877; c=relaxed/simple;
	bh=yzN+nmCjwTyOZHui50fNGbIgXtXeRBarbJCrCKTj3f4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jrh9j9LEJ7arILwA0BCJ0bAcb5lE5DkDoPDwRSlbIiGkVlPsZoNTq0zR/H2xGXmeLvLiY4zlPlygGPbypKqY/YvDy7gE2WpcslnUP5WC96Vs3uZsGSDnIaNMk8fi2ksx4fOzh1gFcK0Hn9lSn8jVp96/wzxBX/RuIGxJCu570Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SElkqXRg; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/WA7sX7Y/RQjcSU+PbxiQIySXaXa248pP3kzqPrW2Xh5SRxZyYDxt2otSETZqE3hBTpBkdvwgywkf65t8SP8b6xadurzW7RswhZsaOVLFw6MbEQs0mLKMmFEznnZM/QO/Ng9wUam47GUyj9XO5BUVqSbgiobqe8LMaBRxuWuZeZ+1a7hDZWYSUgciaOUmNuS3BRltObD2ns1e6vGJ6dGXOog8O6E4sIhHby8cLDY6sT17C1zKqusDtGH9OIogEr/WNgg7t58P3mBuu6P9vvdpA7uwCOlaQbuMPRXw4kzA8kFk3LCnvfeYQwi6EoOGYZ8n/lxmos0FhsUfvo+wpo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI2TP4b7jCGv0pXu/4D0efhfa3mQXG5h/nADUSBWVRw=;
 b=FxbkCLKH6SBxCb1SnUXi/oFJcJXG+xDFDufzAfJwnXevFYjYPTeXzKEf0t4zkv4LnlIJbLnfRh9IemTfObR9GIyn4GPdY0fDgBWdUasXj1kkDWheXtbU52KYcRC0o8GUgV0AJ/EJdn057azHcljEUZNqWFE5da9LlULtaVN0gGGGN5EYyF56qZPBU4/KK/5GfhVMuYL2lVX7e5U2aqFKXFVThONDv/JajHif4kk5JN3Mmb7Ra7Y/SMhlg7j26iU7J6Y6bUSzgqGLV7th3KfakZQmFMGNxMolf5Wb0w5DrY3Voe02lCArtGc5rYboAuWo5Kude7TNdtgcovuYsBHAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI2TP4b7jCGv0pXu/4D0efhfa3mQXG5h/nADUSBWVRw=;
 b=SElkqXRgroud62PZYc5q2DZ7GfmPQdrjc5/bJWk/bH0Vwo5EL0Td0RySapP0LAOSzQ06kbdmM6wRlIkR75VhnhEAIrKiwZCupOflCzHOal0sXiZXfMbtzg4fPiOBYLZOvDAekxISrw+7hbeSLcnspJg3EouemrOYJ1PD5f+7cV8=
Received: from CY5P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::29) by
 CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 24 Apr
 2025 14:27:51 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::68) by CY5P221CA0013.outlook.office365.com
 (2603:10b6:930:b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 14:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 14:27:50 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 09:27:49 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <michael.roth@amd.com>, <nikunj@amd.com>, <seanjc@google.com>,
	<ardb@kernel.org>, <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH] x86/sev: Fix making shared pages private during kdump
Date: Thu, 24 Apr 2025 14:27:39 +0000
Message-ID: <20250424142739.673666-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: b5253a43-d4ed-4a81-afe8-08dd833c317b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQjTJogLvbc7CgAdND+h6RGAyYzoBkS01qm9tCPXF11AjUxCTe3OGv/zEWz/?=
 =?us-ascii?Q?s5CFJxPOPJar3FYy3Mf71M58w/kSxA444KNqQdR3MiT+p46hWnsYTA7V3JCr?=
 =?us-ascii?Q?uku74AoWuymSc7WIOAmHeBG5lNEhvN/Zu5HyBnVaeSZzZux0Gfa5Xk5KV9UM?=
 =?us-ascii?Q?tHN4rFIdQdeOnlUpKPoZfWHzjOkP1StMIMYNflePGndcRuYC3c8VmksEzh2b?=
 =?us-ascii?Q?Tz3QnicZBQJymc/a4bf90MWRn29UYMlId+vPPVLke945S27ji/2Nr8lQznWZ?=
 =?us-ascii?Q?shPyXREXEJCX4tMg3wHBMBO2QxOSEoFbWTFB00wSRGFGTHgVMOJGIAPSgG9K?=
 =?us-ascii?Q?nrMywaw4AdcNRIY7qxq7bU5zV9PHbmLYqXfdwusJ7DQmXhy/6+u5nPiX/Hpe?=
 =?us-ascii?Q?mUMpUUwoOpLywto77DviJctqNQ4dhGaygYwWZnpk0/VJFZsnRvum1mgG4Zr9?=
 =?us-ascii?Q?Ka4xnv5Sr34Mdrjm2UXh2tFM3nUiR7EmuUFHhyKCdXqa+ctjaN1HdB4UJGsG?=
 =?us-ascii?Q?kWzQq5QGtsGVWeCeSX1W4Dwxf4eAGco+szO8PV0BLzRiT7uIjwyvWriUTesj?=
 =?us-ascii?Q?btxBmqB3HMXNuW0OYEUnXxHVERRNfbQMPJvZxP6JVuoQZLF21BqnWdWkCUlo?=
 =?us-ascii?Q?kyMeIWGdhRklG+sa29ucBE3QJ7RuEcMUbmUicUMXMnKPoZ4kCAmBpRibx/0k?=
 =?us-ascii?Q?E2GmVqcXOcTgzf6eTtqFlvvhb2hi6JWWXC9NzX3z51ZfrEpjdcuNZ5DJaJUA?=
 =?us-ascii?Q?d+3tejBzKeDGfITC/NwJ1slII5D0IstAM1ylh/+eBVCG0jzgpVHnyw+3vMMJ?=
 =?us-ascii?Q?MG5nmRyDrowDGtqqFnEY5iE1ymN3Ls4tYxgqfnd0GpLcltSAKU2TUbbsto2G?=
 =?us-ascii?Q?QJIRKLajwwBWUUN3YGEWk1GMF48tBlhGh27msLsLzWQk9PPGvgF12dg75RhK?=
 =?us-ascii?Q?Glebyi/XE5A9Is1sU8LAhQhZ8Mqa/1WrpsTn3FgLPI8rz93W/cop9Qw8eUlc?=
 =?us-ascii?Q?z+Q91UfDXaHmll55jtKEIUW0gTbpQ/bDWkwRpsD9F+4fzkh/SM0WdWomknOh?=
 =?us-ascii?Q?2IrlPtb1PQWpM5ro0YVok4wQhw65KvQ5IcqkbjIswZRASPImoXyXWsh+V0t9?=
 =?us-ascii?Q?xsOYomg8rIIbQZ1rp9rfeRvxtyUWbYf9FboQdkaDaDFyDMch2ctASpPCWpO+?=
 =?us-ascii?Q?Z1/SKus8zjS1MJ8+qZqbHcdYHHAqrr8UUCN30uv6XjFgvLSBsyra5K7Vu9Xw?=
 =?us-ascii?Q?Vc+Ggo1K54rELVpagYyUHHBHkImVG6OPQsgUpBsHq9qrxfTCpoWxzh9B4AvJ?=
 =?us-ascii?Q?UYi1mch/crNV4JnZR/fWMuqe3iRp0fl94myHiz7fAtM/AIdotNAcfn5eXnOd?=
 =?us-ascii?Q?SdFOcUAI/xCE8L18NxNa9sc1V1YXivz88AfQxt3mqH6BGrLWNqnRZuZvNr+7?=
 =?us-ascii?Q?VLPFy4mZKCfZZABsX1NushRzEuJybESHo811qLioZsaDKX8oE50UiUgURtwe?=
 =?us-ascii?Q?xuHgTTVdJT9MU4M9pNom9rm/sCuWN07LbmbJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:27:50.6381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5253a43-d4ed-4a81-afe8-08dd833c317b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

From: Ashish Kalra <ashish.kalra@amd.com>

When the shared pages are being made private during kdump preparation
there are additional checks to handle shared GHCB pages.

These additional checks include handling the case of GHCB page being
contained within a 2MB page.

There is a bug in this additional check for GHCB page contained
within a 2MB page which causes any shared page just below the
per-cpu GHCB getting skipped from being transitioned back to private
before kdump preparation which subsequently causes a 0x404 #VC
exception when this shared page is accessed later while dumping guest
memory during vmcore generation via kdump. 

Correct the detection and handling of GHCB pages contained within
a 2MB page.

Cc: stable@vger.kernel.org
Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 2c27d4b3985c..16d874f4dcd3 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -926,7 +926,13 @@ static void unshare_all_memory(void)
 			data = per_cpu(runtime_data, cpu);
 			ghcb = (unsigned long)&data->ghcb_page;
 
-			if (addr <= ghcb && ghcb <= addr + size) {
+			/* Handle the case of 2MB page containing the GHCB page */
+			if (level == PG_LEVEL_4K && addr == ghcb) {
+				skipped_addr = true;
+				break;
+			}
+			if (level > PG_LEVEL_4K && addr <= ghcb &&
+			    ghcb < addr + size) {
 				skipped_addr = true;
 				break;
 			}
@@ -1106,6 +1112,9 @@ void snp_kexec_finish(void)
 		ghcb = &data->ghcb_page;
 		pte = lookup_address((unsigned long)ghcb, &level);
 		size = page_level_size(level);
+		/* Handle the case of 2MB page containing the GHCB page */
+		if (level > PG_LEVEL_4K)
+			ghcb = (struct ghcb *)((unsigned long)ghcb & PMD_MASK);
 		set_pte_enc(pte, level, (void *)ghcb);
 		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
 	}
-- 
2.34.1


