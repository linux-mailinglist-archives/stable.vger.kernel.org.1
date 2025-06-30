Return-Path: <stable+bounces-158876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3CAED6F5
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 10:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655CD1725D4
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 08:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE50223716;
	Mon, 30 Jun 2025 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DyctieVi"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907611EB5B;
	Mon, 30 Jun 2025 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271568; cv=fail; b=kQaUDLJWK7w6T+tqy6rTpVsQRM5h4fx9Jb4qFq69TuMN3MvqW8IcoFa8NY9w/lCREMt3EAxrxvT7oqKhT9yntUZ2xtbujm1Rxgx7w9JvOTghPCEt0LpxPqOtf78pdRIi3xBde0PsiDoOWty45s0KhLunTFoJkyQFNys2nrJ9YEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271568; c=relaxed/simple;
	bh=j9bRbi9uGFGDfnIoQQMzYtL0o2evGBmyiMihw1Tm2W8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PwGEvOjEDVT1fNWds76re4cjU2X/EXQkN4WcTuTdAQBtJu3fTnZRTezjOckwwFzAYAYubRLYtQDbN4RSvhTwoJPnPx/rOxE53Y1tfi8WKVVxYyxXjsDbI2fKJdaO+Qq7EVDnnxZDr1CRvw9aTWJk+L1JQ3BhyB8Za3H+CXmCdW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DyctieVi; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZCq1n1P/MSTSOMMgSv6nBMHJNMD7tns8quFvbFyNNTZhA/y6eX9CujZOKUNta2vojljyiE0xCev2QfGEqT85QNxBPV4Z+GScUeZuV38KNejBfNIUy/lMUOHfXyRtxTl2OkaGovmLGj80z3L4pKtpDtoiVTBtpq4IzG6WjOmZkcSqv0oC+qxOJhKOktcP0PG2ksNFjivLAv/UgCzXRugI3nIx7oxoc0NaUWC1mpnvPXu8bbQNVghI2VBzUaMBqe4JU1mW6Kpcg6yV6YDX4lR0rPPKSIqXTN/54pDT5YAyXAWJFxJYuiK3C9E4J5XP8qK4NKAHHHjQ5hHC+mZO5nYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJlq190yapPsITuj87PGdpMVU9i3bMUeLrl4fX7wR3E=;
 b=HkElFOIrCMNR10eDwl76qSoSo4JE1CjYM3vYgPExgjRfm0h0fUqlYP/pJXQlvjFpN7Q2jkSKaaAasSKimacKXf4Kx/vlxghppsqguyn1nfsgY193BxgUVokM5hkPKkTXVuXosZH1L/npaHnB+NIRQJrEIUtcFws7IhYommJJWkKlQcIZbBxH48g/6Slu9JOiNp7uDB0ZEJHR8F/YZxmdp049W75Oklj+pszb+9+vPxmZ+R7F0TnvvPaOa7sAH6zRdBJu/IIjdLLNFLYr21WNkehPntYWIWa0jGbasdc9+tJZOjDv++UZFeTMyEweX2pBTtr2T9MhS6gTdrEaGN7QLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJlq190yapPsITuj87PGdpMVU9i3bMUeLrl4fX7wR3E=;
 b=DyctieViqpobetG2PtaVcnXTA9g73JSLTuKgidzO70/xL/V7BbPs1DZACGgKRCu+LGjncfWNWuN7NMK8ZekquScLTHcQ2THl8BWk8/gwZ2VJn3XEqsl2mYqmB3a8ml+kNx8PNRSjv61JslA24WnRo8pP9Q48G4AldTG1YJBHPBM=
Received: from BYAPR21CA0029.namprd21.prod.outlook.com (2603:10b6:a03:114::39)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 08:19:23 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::1a) by BYAPR21CA0029.outlook.office365.com
 (2603:10b6:a03:114::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.7 via Frontend Transport; Mon,
 30 Jun 2025 08:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 08:19:22 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 03:19:18 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<thomas.lendacky@amd.com>, <aik@amd.com>, <dionnaglaze@google.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation
Date: Mon, 30 Jun 2025 13:48:58 +0530
Message-ID: <20250630081858.485187-1-nikunj@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cf728d-8a81-4d5a-f789-08ddb7aed1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YhE25ofsDar61+Tc5A18Nq1n/9NtTO0uFuMl0XbjSUTJ100BLVoyPWKIsI4z?=
 =?us-ascii?Q?RcEgydKFe35rTrhf5GceV+jmmL5eshOq3kYZczjyn0bpVMBGWXMpTqOB25pi?=
 =?us-ascii?Q?iKB+pqGxxbXIXSgKLRYMXgktq7IBR5pZVAxEudMn9LzJTYgBbQ1rOV3n5mwL?=
 =?us-ascii?Q?qOa0HKgbFjixtdnrc8fglYP96YUbU8ejShX8gEIdt2E11SAMz30+bes3Um0A?=
 =?us-ascii?Q?IE8C7b7mC6qj5RyGSHTfwxfZnznJmsLEJhQw7K4VvlO/i9yDNCnWj/dYTdEz?=
 =?us-ascii?Q?+AbZrdh0DxbJpCUDhMF/z30jwxdF6c0vCMOM8v1UP6plFfeoGifNUGwaB2bk?=
 =?us-ascii?Q?b1AiKzP679c080fXqAV2j1y6CCl8aBDaT/A+GG9bcZRsQOun1RuTdbZ4Q9qR?=
 =?us-ascii?Q?Urb+lmPnGKT8CYbMBPFA+iP3Ck0TCPpBtNOvLpulMO6TNuabFFvroIOYN3SK?=
 =?us-ascii?Q?xI/ThqJ8XiqcOMNL6UX0ocG6SG2Tu8bet2OFAwJCIP8Qc81vYpgbQVcTdohg?=
 =?us-ascii?Q?IIDhuFeVMrxn80rZcduoosSVskSK5Bq93huXfbUakUjRjukUYIjN9R4jFvcf?=
 =?us-ascii?Q?hWYyxURBs7Ym2rCiaZz5uarBY/ZJ3GX6g2Sebe7nCbCLVpKvqIxf/ttPk00X?=
 =?us-ascii?Q?Olu7CNZOF/TJTXG364FNHks+pWpalQNGjvAw8g56B/a8TyVIecn0/TdPMqFA?=
 =?us-ascii?Q?r/pxVgB778Jx0k1G0NROKOuaVCZScY+n3aw2A88/BHkpEZ1lGNsGuihaMioh?=
 =?us-ascii?Q?R36YXbGfmi13Al+4zwg9zX1Qg+1v1TTDxuDVdok8aNcVmlqQYr2Rl4AzVFz/?=
 =?us-ascii?Q?AfqcaYCQytxBnR3oIpqUwCW9TcxiAzyfFwH5rWLJCalJF4oTYhzG+kPTC8fB?=
 =?us-ascii?Q?C0ShUSyu3SmlXTFfXv25/qUKGXVaevQRS4T438ba2vxrPu94U1438Bl1Ot8X?=
 =?us-ascii?Q?zoNt9a3DzENknz4t5g/lTFb3eYOfHtMrfV3oZiYS7n/QcidXTT0rz7lw7xrx?=
 =?us-ascii?Q?9qEAtnY4cgitb/mwoFsMw69SACKgWkX0iL4XaQoTwRPoOnL1BgrTk+sODNjh?=
 =?us-ascii?Q?CZm8Phkn1E/6V5+h2sn7giEPL4GKH051s0lAuwIbXF42pmxqOae2jPYx1+hk?=
 =?us-ascii?Q?h4OGfhi81FKAz78HBNAeqmQU1QiFSjBrUHudHLFiN0I2odCHPdH1w9GSSDss?=
 =?us-ascii?Q?o16p8zsBTpNvUkx9ASj7+OIehawKMzXSJf/DP0lV79xb0mHgMsKlAj43jtEG?=
 =?us-ascii?Q?8rO04tncZ1fsXXuUJTFlYv7mlfyb1JJPzBuYf0PW9KZZnMxEC1ftDUcDPsqM?=
 =?us-ascii?Q?ZWjmR7pACfCcm5waNZSAcHYjdKaLZseGxEFKaRkQYi1DrgoAVIEKROVd4OuF?=
 =?us-ascii?Q?7cCvYRu6uCTg5xnzlFIUh2tycTLf8K6RbHd/xLtd+4wwBxdIFvk6jZSBFeex?=
 =?us-ascii?Q?DFUuMSwkkvAM7kCDaUx+9sTocPlOxo5sCASEO9+AdRqtWVO9N+MwEcjyxs0x?=
 =?us-ascii?Q?tUAcx/W4CR2VEeFR+crZ8NUNV89PhnVRffkp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:19:22.8695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cf728d-8a81-4d5a-f789-08ddb7aed1e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512

When using Secure TSC, the GUEST_TSC_FREQ MSR reports a frequency based on
the nominal P0 frequency, which deviates slightly (typically ~0.2%) from
the actual mean TSC frequency due to clocking parameters. Over extended VM
uptime, this discrepancy accumulates, causing clock skew between the
hypervisor and SEV-SNP VM, leading to early timer interrupts as perceived
by the guest.

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

Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
Cc: stable@vger.kernel.org
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

---
v3:
* Remove unnecessary parenthesis (Ingo)
* To avoid type cast, harmonize the types of snp_tsc_freq_khz and
  securetsc_get_tsc_khz() (Ingo)
* Use rdmsr for GUEST_TSC_FREQ and extract BIT[17:0] from lower 32-bit

v2:
* Move the SNP TSC scaling constant to the header (Dionna)
* Drop the unsigned long cast and add in securetsc_get_tsc_khz (Tom)
* Drop the RB from Tom as the code has changed
---
 arch/x86/include/asm/sev.h | 18 +++++++++++++++++-
 arch/x86/coco/sev/core.c   | 22 ++++++++++++++++++----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index a81769a32eaa..cfa3ace227e6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -223,6 +223,19 @@ struct snp_tsc_info_resp {
 	u8 rsvd2[100];
 } __packed;
 
+
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
@@ -283,8 +296,11 @@ struct snp_secrets_page {
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
index 46bd89578ec7..115a5750c40d 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -88,7 +88,7 @@ static const char * const sev_status_feat_names[] = {
  */
 static u64 snp_tsc_scale __ro_after_init;
 static u64 snp_tsc_offset __ro_after_init;
-static u64 snp_tsc_freq_khz __ro_after_init;
+static unsigned long snp_tsc_freq_khz __ro_after_init;
 
 DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
@@ -2174,15 +2174,29 @@ static unsigned long securetsc_get_tsc_khz(void)
 
 void __init snp_secure_tsc_init(void)
 {
-	unsigned long long tsc_freq_mhz;
+	unsigned long tsc_freq_mhz, dummy;
+	struct snp_secrets_page *secrets;
+	void *mem;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		return;
 
+	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
+	if (!mem) {
+		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECURE_TSC);
+	}
+
+	secrets = (__force struct snp_secrets_page *)mem;
+
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
-	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
+	rdmsr(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz, dummy);
+	/* Extract the GUEST TSC MHZ from BIT[17:0], rest is reserved space */
+	tsc_freq_mhz = tsc_freq_mhz & GENMASK_ULL(17, 0);
+	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
 	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
+
+	early_memunmap(mem, PAGE_SIZE);
 }

base-commit: 4da71e9f8939987cd2063e0b2ab5bb5eafc80a87
-- 
2.43.0


