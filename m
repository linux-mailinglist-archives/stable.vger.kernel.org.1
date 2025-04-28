Return-Path: <stable+bounces-136956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293CA9F97D
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6314D460A2E
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE3D296D27;
	Mon, 28 Apr 2025 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VAkt0gYp"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7F28DF09;
	Mon, 28 Apr 2025 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868439; cv=fail; b=LV6/7kJhx1vnxT5ySHuBTVtvxa6KCLh19Ed3mJU78i45vtVWLc4GyxqVShKqqpisb/51TuBpG8y+UbIafctCPTsDPOCTTVxzQ2nLy/YQyLtF+EihQ8ek7xpX21RyXI1xG7Kbt8/ee8JA4ko+qK3119Knw5iQZWjNLvqgguA5y9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868439; c=relaxed/simple;
	bh=1b49YhUYBhn/wK8tIlI1MRRSyLyGJOjAjjQSo39lCn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M5zmXtIW56FMwrSHHfpV4qXojlv6GPJh+J3bDeyuLVlelcDEoyvoTqjRf4R6GOM42sc9WoP4anDvTvox7SCzAaLsHRAD/arFK4xZyi6kyvnmBxjwon/Yv5yr9r7wFIzbzXO5jfMFvuepZ9tOKtCvWniAQpVLgXWtzCIz+uRDcSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VAkt0gYp; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsztuXvczXd+D2wJlbaRy6oI94SxnOXSCGzADiHwTalmtFNG5SOatECtmWmrKQv9p2jTtwId7SaBv70/ghlj5p7E1re5QUlMIuykf1xhMbroemKx5ehbIHGLYeO/ehuNnaTz86bm4W/W1IUYXPxce6zBrWXK56FOBU1eWClUk7zeeLg1pHPtynD9XxH+aKHNNejevlCaWAczYmo+zzk+QcPbs1862MZ4wIudOYRz0ew2/0NsNt/c2Ju9eq1sY6ai4uw6ChfWtCjCJzj0EKnwd8WQkW3iViSvH+pKqJ2P7cEsN3KqkzkI9SeooYlEiFKn6+aZrrCBFlC7HLEAqrqN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qnIS76TyQwaO87xcoApsDeumncaUjYQolGNwuhkiVU=;
 b=fjl7X2+4X2k6/ZAte1z/NA2G4K8+J4bbeYNcNrxn841QatqAUhEtJEQHT29S0v0lc1Wv652S6v5AWhB7boNgZcG0caB/TF1VKjtX6Ga6yUse8RD1uSfWZAXWVA3wJ+lvZ7WDCiEXvjTBmSOO40H1lh6wGBmkLHalhpMq8O+HD082zuCXmegneW+WSJeaap1N8aLRZCA61E0udZ4AY64qbIhHKolDsg36dVqiooLLcSOyquyoZzUd+6jt+IxvD/nvPV+p4GXuTKldFtSXCR68fkkrqo8sel71ZKAqAS7R96jQlfgrMwJayhThl0DzujJgM2sTi04++jKI11f8aj6ZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qnIS76TyQwaO87xcoApsDeumncaUjYQolGNwuhkiVU=;
 b=VAkt0gYp3+SdWP3gpQMQ8SPOMwW8uNAIjZszdDr7xU0f0N3W/cmG4dCC9YUlqn97VPPGtGeTJknPZva/JDaDkzhYRlNZ5ppnkQ1toFUcMWmIgrLODJjVAXuVV/7cUpEZZbFpU4fG9OL+RY6pZw4ifeZ7zyywqwXza71qh8rU/E0=
Received: from MN2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:208:23b::21)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 19:27:10 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::98) by MN2PR11CA0016.outlook.office365.com
 (2603:10b6:208:23b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 19:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 19:27:10 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 14:27:09 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <michael.roth@amd.com>, <nikunj@amd.com>, <seanjc@google.com>,
	<ardb@kernel.org>, <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH v2] x86/sev: Fix making shared pages private during kdump
Date: Mon, 28 Apr 2025 19:26:57 +0000
Message-ID: <20250428192657.76072-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f67d20-ead0-4bd7-d21a-08dd868aabe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AkeWcfyU3UtjnXSnClgoL1a1ilnCh79ECQFQsohXhwFLj6vb9JnguGSKYpyo?=
 =?us-ascii?Q?enaDGxUgIulGDHuazOY54wrJVbWFZ4bsOCLLvVokC7PI92mwIuJVspszptxu?=
 =?us-ascii?Q?TZDWEQc50NsL2oWa0SQYY19idPs9qf3v5vvl8U6TiNDwaPcjLOORmDXAGOqg?=
 =?us-ascii?Q?6mH4RVwyIcpkJn4NeTJUKDFh1927h3lC0LogxP0w7g9wqzodQQ69hraCLVfW?=
 =?us-ascii?Q?57U7xs+9o7irCmDb+dJVfHqbnWnM5JSHJ5KlLWiT/HIwVaO4CWT/fm2mTMpP?=
 =?us-ascii?Q?/fcLxZmcmIAFDJY0Hj+vCXjyJvPSDJhovNon0dcELWCHVIFgagOlDb9fM+jB?=
 =?us-ascii?Q?uRQ1euA+ymnJm+RjwGXut7ZJ9yq4wWjc4LablylLmkLyqvttKWiZG82Hz8aX?=
 =?us-ascii?Q?SakTvsed0H0Oe3tbUKVwFOU7ervLwcZscyqh+9rJkQFO5DMLptz1NOzTYRL2?=
 =?us-ascii?Q?R7W+DWTwhDjHnexuA3RhUuxl29+FQ6bawZF+e8Zsy40iskAdw572VqPhgzDd?=
 =?us-ascii?Q?XHqKLfwibwu20N27LPneXXCTr6AA/9sU1E0CQKi2pFcZrz1zicSo27Rvra6p?=
 =?us-ascii?Q?Nh5FsaHhx1pRCQMnCQdI0OQlVfrE7Pm8EcszJvKBoWgXq6VBLwxJ/B8Siezn?=
 =?us-ascii?Q?Y8YMfPR3tjynxrCJwgDf/UdPnX+qWzm0l/ljjau1mFUf8q5+3cTreqVayl8I?=
 =?us-ascii?Q?PSzic08OBS0Wvb45OWJxR5/QqbleZfjReAA/jD1nmWNP4+y9h0PAdOCNW5K8?=
 =?us-ascii?Q?zktddT6a3+bRIUC/jYId+v1SmbyoAuzK/aT08/TDA2nDN2Ck7Z+wKLClR/bx?=
 =?us-ascii?Q?4FATl/Fm0dkHbEUxv9UNXBhL8DAGCazgrli5tCGklRjJ1byXuZ9e9I2Ycs0r?=
 =?us-ascii?Q?5RZ6ewxnZtSZ102eOuM8pUTbxLa9Pcvcm6aTQnEaSik4Wit0/RzU4EFyZBxW?=
 =?us-ascii?Q?yG5i/nC832H8ZeWZKNfry0g9GVsPsD5ud7FsHDoyJmjO1pKj0AbKM8Tjw8ry?=
 =?us-ascii?Q?kVAyjHZbeEJ5LjJodi+5rvl5wnciPQRK3Gf6GHqiM3ih5FO47a8pUkQe/GMS?=
 =?us-ascii?Q?5c3zculvBdK1E8T1zCdNrC0zobgq8quKfwkX57yWeId6UiMkY5krstcchDhY?=
 =?us-ascii?Q?18t6SYHXKv/1OsO9jwJF/dBz/5KSjJ8ZL4oBfOUWhgWbW4aGFGONijUNScJL?=
 =?us-ascii?Q?JmMBaJrnmjQzxH5+ubKtpcB0FU9cIArDyJh5IAJrbi4xllMc292RO+PCyqQ1?=
 =?us-ascii?Q?yW/fGRqVLD42LNKghnJB9HkvBwix4FLOcNwqHnqqYxRXQUt07IiZUh6mL2PD?=
 =?us-ascii?Q?mQwb3l57x+nx6Ft8/0EvZtSWvQpxDg7nZ4miSU2DQxKa8uXuSwdfQounOYEf?=
 =?us-ascii?Q?AcYTiLSmpCDmfAQnxO3GWKuPkNSnIOTLkc0PXQmCngK/yYg7vHY/adV+nZO5?=
 =?us-ascii?Q?vk9N+BNYQ0Jl5XrwqDV5w6N4rbClrHA2rNwWjS9hmGp1JRJ09OashCUz8KlQ?=
 =?us-ascii?Q?naJVEtfnQXfY9OZz2X4LyynuU+vLXRmuG0oq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 19:27:10.3293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f67d20-ead0-4bd7-d21a-08dd868aabe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

From: Ashish Kalra <ashish.kalra@amd.com>

When the shared pages are being made private during kdump preparation
there are additional checks to handle shared GHCB pages.

These additional checks include handling the case of GHCB page being
contained within a huge page.

There is a bug in this additional check for GHCB page contained
within a huge page which causes any shared page just below the
per-cpu GHCB getting skipped from being transitioned back to private
before kdump preparation which subsequently causes a 0x404 #VC
exception when this shared page is accessed later while dumping guest
memory during vmcore generation via kdump.

Correct the detection and handling of GHCB pages contained within
a huge page.

Cc: stable@vger.kernel.org
Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 870f4994a13d..ba601ef5242d 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -961,7 +961,13 @@ static void unshare_all_memory(void)
 			data = per_cpu(runtime_data, cpu);
 			ghcb = (unsigned long)&data->ghcb_page;
 
-			if (addr <= ghcb && ghcb <= addr + size) {
+			/* Handle the case of a huge page containing the GHCB page */
+			if (level == PG_LEVEL_4K && addr == ghcb) {
+				skipped_addr = true;
+				break;
+			}
+			if (level > PG_LEVEL_4K && addr <= ghcb &&
+			    ghcb < addr + size) {
 				skipped_addr = true;
 				break;
 			}
@@ -1074,8 +1080,8 @@ static void snp_shutdown_all_aps(void)
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;
+	unsigned long size, mask;
 	unsigned int level, cpu;
-	unsigned long size;
 	struct ghcb *ghcb;
 	pte_t *pte;
 
@@ -1103,6 +1109,10 @@ void snp_kexec_finish(void)
 		ghcb = &data->ghcb_page;
 		pte = lookup_address((unsigned long)ghcb, &level);
 		size = page_level_size(level);
+		mask = page_level_mask(level);
+		/* Handle the case of a huge page containing the GHCB page */
+		if (level > PG_LEVEL_4K)
+			ghcb = (struct ghcb *)((unsigned long)ghcb & mask);
 		set_pte_enc(pte, level, (void *)ghcb);
 		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
 	}
-- 
2.34.1


