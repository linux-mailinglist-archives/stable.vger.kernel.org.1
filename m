Return-Path: <stable+bounces-161803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862DBB0364B
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 07:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98143B08A5
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 05:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6945204098;
	Mon, 14 Jul 2025 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w/Xy2DgL"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A4C13B
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752472475; cv=fail; b=YErGo5wBxt2n6LycipaP5WU3HH4BLEPgAobQL3bMfaoAKX8dGd3w3L9uCAmPebIoFE8GTP3WuCvJ+sAtaVmW3q44+QdMrugYDCD9dnVZvf8K5oVJWkTT4uo7k0E5nxzoVKAw7oobV4uIh8oG/K8GactCAhRyjq3XEGuLx10nJpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752472475; c=relaxed/simple;
	bh=/x1T0i2PE9FKyYqxYRqr13vpOAcbKpbAzTpQnAQtSIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i34kZDk85x1CzRZLpWV9w2TdZz9CIRUDUBiGuym7qoAbV4794Q+7swbugNaRO4JlQ45pEuMIrxUYG1LffwKX0k1OiaqSOdNuVVlWfBJ3rX5iA+x3KWC44QRC7gHre0Ojq05Cgx0FQEu568MwjnSf0GWYhxs6iPyVZXEF3HSTmX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w/Xy2DgL; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luiZVn6rsXkoVOB3sxy8E8y6tcHCZLYYw2v9uqTiu8wmL9nr2QeuQQ014wY4RTUO9g09B3LqATy7XwajkM7GsTbWanSaTQXoJiLPyozN7zH44Tg4GkZ2T8WR2yPwOJbUCbnOgSKFtuhy24Ih3ALIILuLSIlvwG470W2Ntm+YLJcWMyRVj6Qo/qO5fBXJXvMjBX04LovxKLj9Gl6Hz3wBPhVlupschZfwnpOjjx/6b8kNmyJsVPsD2TMh+mgYpVeJDXTgePhJSPVenGKjCwPvQbBPz8t4WpCLB1LYVGBghH1HxhQBV1KZP49n5bfMjuuJYguhyvkhJlxd4fwxbfOPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFa6zyF8VipbyesFHj05Df96V30LoZr8RDTVoHPe254=;
 b=Dv9Ak549cmkG4po4jRExeh8w27WY5CC7dUIHworm7AsoCM885ZXug4FIei9e/6MW0aZtRNZAZJppq+ceBCPhynURBRMdSBjKn97faeAgJCC3BtstzUV5j38RLU61JbSm0Dxoej0lK12oZ4hZArHxFnM8MXMhT9zh6GlfsUo1pKMB8zDd9EzPg7CXeTtO7QHN7x8LlisOya2m31VApum5Y29ICOfsSZPfxoNTXEDnlZTQFhTOrvdSXL2xK58pmLYbYO7Vc+x9C8NiGzrQJNRZTjdtE3VcJhjjlKAKFAxTMnqmRlBsbhFiKriIWwGNw5WuMox6TjaKYXmjhc8sFuOJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFa6zyF8VipbyesFHj05Df96V30LoZr8RDTVoHPe254=;
 b=w/Xy2DgL5YgxRbBOpzanVI0PJu+1XFm0oIdNUSMbY1zUutMdPiQ9snaUDi9u3qc2OGh9Gl0vWbXcrVBYMWO1jRcHR82mHMQDoL9TzmKi+9VIWSX872zH+lc439d/LT0wWye9p5elHCBO6khYDUHESV9HDanK0Yi2E4GbG1v+4e8=
Received: from CY5PR15CA0004.namprd15.prod.outlook.com (2603:10b6:930:14::33)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Mon, 14 Jul
 2025 05:54:29 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::95) by CY5PR15CA0004.outlook.office365.com
 (2603:10b6:930:14::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Mon,
 14 Jul 2025 05:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 05:54:29 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Jul
 2025 00:54:27 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <stable@vger.kernel.org>
CC: Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH 6.15.y] x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation
Date: Mon, 14 Jul 2025 11:24:01 +0530
Message-ID: <20250714055402.653464-1-nikunj@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025071203-dime-overcook-61dc@gregkh>
References: <2025071203-dime-overcook-61dc@gregkh>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: d17ba8e0-719f-499d-7157-08ddc29ae5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uR6UwsTIJQIw+tCxpXkGcv5iRB/MizUcfq9Qb7T+KBFF8hWv/m+62SdkdE6Q?=
 =?us-ascii?Q?iYfm/PE2cZKZvUEseyEWJKsUFZQN2xjKQw6oVEDZtex1O4xiTxZ4g3kGURxb?=
 =?us-ascii?Q?Rry4z6lM8CC+G0zrxerGZJnS6IDOPybR7PMwnEWNuQ4l4KzX55xAvTXPrXvX?=
 =?us-ascii?Q?ol2eLB3fcbjY0H6bU8c30EzGfj7DjwbKzZnlodD3uZ3ZSuu2aT1UqUP/NAzJ?=
 =?us-ascii?Q?dNJYyCXByQaF3IPWjZKAcf0xrpAq/dAQJbOuYt59QDlZ/TJcRriqe7IvSyQr?=
 =?us-ascii?Q?JX1aFnfngWLTnqwkXODZKJREvbEgSyL7gezupL9ektINWEneCwiUZGiTLFcH?=
 =?us-ascii?Q?9yPgydKCj45G6ZOYEiwH9FRna3PafmyCJoGTT8FhL2i8VxjweDaUasWHtmhV?=
 =?us-ascii?Q?onqBnkOaedBjCZoFO9+r/LJrpJS9/zpbYUuJbgyYIQiOBRq3Jsq/JrwQakjG?=
 =?us-ascii?Q?ssHj0DSgL8o6GACA9vFn4pLQYUjKaFl3yn8ge3PBeXsv9WFhPweRiFhav5kr?=
 =?us-ascii?Q?Yld3FMzAAbm9jRKGLvH90xoa8uRb8Eu37tItAaqPpoWB+mx/7NUC07AJdMmc?=
 =?us-ascii?Q?7edEpZh8GUiXJXVX+3hU6K0MSxtE+KVes/oTjpiMZRzobfLU+1OpK4z2qTwy?=
 =?us-ascii?Q?VLlZc638qqoZcgALjCsYJdPPqxLxeF9wztnpalZhoVZxN7P4+wJ1Ib29IGVc?=
 =?us-ascii?Q?Ldw0LJZYwWRA6bRXvMG95JH2+2hYGckpCXynfX5pMOXFMYzoG4kNMNJWuGrr?=
 =?us-ascii?Q?JBGMEziDKuGsKCTZ3MS9wx4y1lAoHY4NjFl3hsui6uOatEy53U8WxCOjgfnE?=
 =?us-ascii?Q?Jv+jjd5UjqFJHJdFnrClaJozXjP+N3WdjuZktrfpBWDY9WCvBsJpE+GDSk/X?=
 =?us-ascii?Q?KVElV1GyOele6UnOeDBmQf0y2vPV5kThx7hUrDfj1dKSdM7oBwfftJA6ZpB3?=
 =?us-ascii?Q?eYaLwydnporbCim0xKPeMB+UM2huxp0xiHbKYnWMOp/d5kbv45ICuvLrCmrz?=
 =?us-ascii?Q?gSZJvlIORiCKKtm1n5biSXKMtQcaztYpQ2tVTEcHt8BqwUFGGf3mHJB1ZYCt?=
 =?us-ascii?Q?KpaK5Tx1yjjYjnKGaBcOfL7w4UtWGSPilNxhvV7BzXB3EOTXORxFUrgocfZ/?=
 =?us-ascii?Q?UOQ2Ai2elHsjFOhrAfculZ65tDu/MC7yd9e8poj3oNo/G5HDrwnQbBQkGzZh?=
 =?us-ascii?Q?DA3Unnx79nDTBKQomnRSk/JzcqoSgV55iF61a4RpQ83eRJJ+gUJcPXfyO5J+?=
 =?us-ascii?Q?EZc1UagvWj4ILjv3xVD7hy07rmodWWixmxaUWXGW61Sk8P7JOmo+R0+wG221?=
 =?us-ascii?Q?5+fo0VrW3XRaOPhTyB62HDz2DLH3Bzy+juSl1Af15pygxFuyn+d+BJY6LidM?=
 =?us-ascii?Q?ZeYEnieJOI9nufkz8bqytuuFXF9vCocsUOcI/EOiY1WUgBUToudQWf9CsTZN?=
 =?us-ascii?Q?VWUbTkZnH95IHbaxiQXf9x46AjdVTzfKfCl0yTSSilX21lpi72z1HtAX1bHC?=
 =?us-ascii?Q?s2XXqXSXM0rSGZURQZUKAtaj7Kbhky9WVyL7wln1FOH+a7MFQT7oB5nMRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:54:29.3919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d17ba8e0-719f-499d-7157-08ddc29ae5ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609

Commit 52e1a03e6cf61ae165f59f41c44394a653a0a788 upstream.

When using Secure TSC, the GUEST_TSC_FREQ MSR reports a frequency based on
the nominal P0 frequency, which deviates slightly (typically ~0.2%) from
the actual mean TSC frequency due to clocking parameters.

Over extended VM uptime, this discrepancy accumulates, causing clock skew
between the hypervisor and a SEV-SNP VM, leading to early timer interrupts as
perceived by the guest.

The guest kernel relies on the reported nominal frequency for TSC-based
timekeeping, while the actual frequency set during SNP_LAUNCH_START may
differ. This mismatch results in inaccurate time calculations, causing the
guest to perceive hrtimers as firing earlier than expected.

Utilize the TSC_FACTOR from the SEV firmware's secrets page (see "Secrets
Page Format" in the SNP Firmware ABI Specification) to calculate the mean
TSC frequency, ensuring accurate timekeeping and mitigating clock skew in
SEV-SNP VMs.

Use early_ioremap_encrypted() to map the secrets page as
ioremap_encrypted() uses kmalloc() which is not available during early TSC
initialization and causes a panic.

  [ bp: Drop the silly dummy var:
    https://lore.kernel.org/r/20250630192726.GBaGLlHl84xIopx4Pt@fat_crate.local ]

Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250630081858.485187-1-nikunj@amd.com
(cherry picked from commit 52e1a03e6cf61ae165f59f41c44394a653a0a788)
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

---
Conflicts:
	arch/x86/coco/sev/core.c

s/rdmsrq/rdmsrl
s/sev_secrets_pa/secrets_pa
---
 arch/x86/include/asm/sev.h | 17 ++++++++++++++++-
 arch/x86/coco/sev/core.c   | 22 +++++++++++++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f66abe..488a029c848b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -192,6 +192,18 @@ struct snp_tsc_info_resp {
 	u8 rsvd2[100];
 } __packed;
 
+/*
+ * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
+ * TSC_FACTOR as documented in the SNP Firmware ABI specification:
+ *
+ * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
+ *
+ * which is equivalent to:
+ *
+ * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
+ */
+#define SNP_SCALE_TSC_FREQ(freq, factor) ((freq) - (freq) * (factor) / 100000)
+
 struct snp_guest_req {
 	void *req_buf;
 	size_t req_sz;
@@ -251,8 +263,11 @@ struct snp_secrets_page {
 	u8 svsm_guest_vmpl;
 	u8 rsvd3[3];
 
+	/* The percentage decrease from nominal to mean TSC frequency. */
+	u32 tsc_factor;
+
 	/* Remainder of page */
-	u8 rsvd4[3744];
+	u8 rsvd4[3740];
 } __packed;
 
 struct snp_msg_desc {
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 36beaac713c1..e2ee6bb3008f 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -103,7 +103,7 @@ static u64 secrets_pa __ro_after_init;
  */
 static u64 snp_tsc_scale __ro_after_init;
 static u64 snp_tsc_offset __ro_after_init;
-static u64 snp_tsc_freq_khz __ro_after_init;
+static unsigned long snp_tsc_freq_khz __ro_after_init;
 
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
@@ -3347,15 +3347,31 @@ static unsigned long securetsc_get_tsc_khz(void)
 
 void __init snp_secure_tsc_init(void)
 {
-	unsigned long long tsc_freq_mhz;
+	struct snp_secrets_page *secrets;
+	unsigned long tsc_freq_mhz;
+	void *mem;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		return;
 
+	mem = early_memremap_encrypted(secrets_pa, PAGE_SIZE);
+	if (!mem) {
+		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECURE_TSC);
+	}
+
+	secrets = (__force struct snp_secrets_page *)mem;
+
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	rdmsrl(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
-	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
+
+	/* Extract the GUEST TSC MHZ from BIT[17:0], rest is reserved space */
+	tsc_freq_mhz &= GENMASK_ULL(17, 0);
+
+	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
 	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
+
+	early_memunmap(mem, PAGE_SIZE);
 }
-- 
2.43.0


