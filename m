Return-Path: <stable+bounces-158655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A921AE9596
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 08:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E2717A15C
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 06:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE1217F40;
	Thu, 26 Jun 2025 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rgbs9cdg"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142401A0BF1;
	Thu, 26 Jun 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917839; cv=fail; b=U+RROeGQ3W8rfoe+R6ej8vSDEY5gG+YxOIMRen9gxDCtqQui4EeC9gn74/lWydVSGV61RFRqEystafHOG0xNSsxwuGdU/O4kJfpTZbfLA7X0UknD4OFYiQFU/5DH0SbetMjnnuFzmAs804mUYH5rxmOFlhxjhQVW2mJ2UU+SSM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917839; c=relaxed/simple;
	bh=saUBsKXa88QIuKJN0/aW/U7ABDwinK2l2zs3uZ99lw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZPdZMIrVPAvKO6qEzXytFzks2mLK8rDG8h3wdDN3qjRXww4fAh3uMhP2/duNsNSHixlKmMITvObSAvtq5tObinzbbGquBglKXjt8IiGJ272vTH6HfG7blWqC8P2U1mmxKQNhsXDCgWhVXUngStFIGr5Oln7jf6OpByhwYoNfh0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rgbs9cdg; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpNNcZMiOFxh+HMRnwqDerXATlb9tzMghWq4+CyF8PN8hMnEZGz8TSHG2yEX5UTV+YLSQKEEQ2XFPxvl2/AVpLElxNXsqLNCb9yT4jnCs/rWKl2QLMO4QqCNhgOlTdwFDEpbeSDniWHS+5kXsaqELaAnaaHCc7/DPpJ3uiRKMjNDvNyeOD7jD9uMvLRf0hQVntZiuLo3dwy28RqUdGr1W+CMZhfaZMdv8p86+mTmO9dW9rV2GyJpvgt5PHksQ5Mfxfwk6q4vLekm+4/Q7K6TOyorTWKjqfLA4WqBsJINc1WthxgU06S2aFIW7skYsCB0U/ulYOxPzVSomCTKjjjfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxWkQx4J3TGSqTOUaO/knsQCJrl5g4OCmgHNKhJTbXI=;
 b=jFBOwjikxe/3jf9+kjr4tBLYhE9AP7Aim93v+LhJ3xzTmDrv30f6KnkACx8UGK4WqxfhfO88LYCYebgKDd8BvSWSV0BxgRpCjRDczpJ+YMTmYUr0mxqnA8cdJ8NBt1tKP68k5t3V7MT8fa98bn2ROcAcVGMBTKUKtC1abrQ/oBOz1TSMayy3yl8DfIFRhc+UYqzFxKrt8aVA1u+G6av8e2Jokkf1gjzOabac0Bu+DPdPOCVFzskDcNHnxPCPY4R4xLA2KLn9YPj2NKYE7iHThe+1t5efg839JweZ/jhuTXc+baQOPFay7F4IxSN+HmawoEPDRVDgs4QW5ifEbSA5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxWkQx4J3TGSqTOUaO/knsQCJrl5g4OCmgHNKhJTbXI=;
 b=rgbs9cdgr9aXnlKfITvcEJtC63sdVrXPvv/Xp5KZgsd+8V29ZDC0fJAOsCIsk7wrl3DWsX13l8owPxmpLVm4WSCH48XVBNqFI6MDRipvaz4fpurDKq46Eohyj2DW0aWPvmrG7VBAdKlmGhL6klaZUpJUbrWg1ylxUeJWWPRrVuk=
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 06:03:52 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::5e) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Thu,
 26 Jun 2025 06:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 06:03:52 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 01:02:20 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<thomas.lendacky@amd.com>, <aik@amd.com>, <dionnaglaze@google.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation
Date: Thu, 26 Jun 2025 11:31:41 +0530
Message-ID: <20250626060142.2443408-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e97113-2b62-4947-aabb-08ddb47739ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Ki3bc1Qs92rbv9xDXk6wNkwTIZFNzNxJDGb7dM6B8Y3pUyIYLP6qAt13h3V?=
 =?us-ascii?Q?4urD9MTkFyAt3TQfxfJz3UnK6jTNtvQDGpd53SvrScHUQ5VXi8QQOKqNkxf9?=
 =?us-ascii?Q?Kbil7WEmxEC+itUiuWpCu0Z1hgpPEvQ3PRGmkOPpPIwkEc17IlUx2eOO8567?=
 =?us-ascii?Q?tsWBt5dteaEwkvqIXQG79ljW5jwb3ENJ8hhUXHUFSPSfZQRFRUcMrmCOSzrJ?=
 =?us-ascii?Q?BSim3CPQyh+fS05EeJOsLZhH4trgg5W8UQVHMtQ354UPfmFMhPdqI/5BoJzL?=
 =?us-ascii?Q?et6wUiftz4chKCVs1PirOVdn2GY+Jm0IW/iZ/CzTxFC0YwWhHtyHX2km4A95?=
 =?us-ascii?Q?o1qOx3KcR91Jk1JvK7xfdNHgAK5OL3PPJkpEiNHjgcE/tcYOaiXHy2KP3j1Z?=
 =?us-ascii?Q?N9CPrkJ9S88onlGNp2Tr1I2M4uBDpqjNZL3Uq7IJ5+MeLa9z6aY5IU7Zx9LT?=
 =?us-ascii?Q?hkbkityo9+LcRWRJ1FUsUY7AveScvTBXjxx6RVMz/jZRtowCKp3GTdCV486C?=
 =?us-ascii?Q?TjBRTG3xSYijYFhswd0TWEDWp4vbfQkeEmO9k+zBerh+s1cGWFWTCvUJEyTB?=
 =?us-ascii?Q?GHYxTgtG+NDyn8RdBeJeBCuXJ6UUWehjlgdupQi+Dr61zjZ2tr5/wSBFWiQh?=
 =?us-ascii?Q?0fPy1BUq2aQvqcpwXb8vboFJ9cj75eGmWArLCJ3iaQ3kf9Ad1A67F9vSd7op?=
 =?us-ascii?Q?sLXscGbURNtIlXadj6jPkEY7RlFcQjzdOTVgokOo3lcPINCbdtv5bW/5J+Z2?=
 =?us-ascii?Q?jl0lDj4v4y4OLnLp0lEJyBxbNeyJ5B+xtiutZF5+NaljrvsM8JZOytbe0tYE?=
 =?us-ascii?Q?vSiiEWrmUKtagAbaPFWotfBfhUGxFPKtrAKf+7iGzXPZAtkknVByG+sMwFUw?=
 =?us-ascii?Q?NjKFJtkjj6MXu6I4U76jObqykx2zk24zMMqDxbhwCIPmL23Qp2upCtND16IE?=
 =?us-ascii?Q?jBhmszVQ6kVZKbKa2RSl7HBN1unpiPTeVR9ENsJzGKopU2AgRkkxO3J82Ek1?=
 =?us-ascii?Q?BHKTVkOtZZiMlnisF16B6i06/vAT0b41nwHOxPHaBfirrlse2H9NLkKJ8y6w?=
 =?us-ascii?Q?k+r/miRQQcjd1pGW7AwJJRvMFiUrL+u4idbiH8tia/mWROJv4LKRQ3i0vcqu?=
 =?us-ascii?Q?XL5bAaIt/aotw8+qcptYvJrB4nI0jrT4dns3x3esqYiM43eGvaRR1foQA5PT?=
 =?us-ascii?Q?zr7WDTJKAHAqa2xsRzjYRY7RKPlJCFu5SH5rZRjHvw6guvc0zASddwlPfxqf?=
 =?us-ascii?Q?Fqhm5yaUVw6PcCI+82ALuMMH9J9v7PcISVECNu8bivANcvZFAaMyMJm60kxZ?=
 =?us-ascii?Q?cMjbhkZSvRP3RJG8+CgzjMH1LKPzUxZuJT/XHjciJaC6hYZ0aypKZ51zGJEC?=
 =?us-ascii?Q?5gn4NjG33vSzBj7QO6h4C989GsCMNrEPcpkZ0yn8709nvmT5PFgyKXMt3ziV?=
 =?us-ascii?Q?vYrQX/bztgaIhK66EkKAfdv0gvLrfjKtF3GZYDVYzvLApXc9TO8MtQ+gzgHF?=
 =?us-ascii?Q?bdP8KoB34R+K9fazQ9zQs0ABCvkMBMBmkSmV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 06:03:52.0832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e97113-2b62-4947-aabb-08ddb47739ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514

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
v2:
* Move the SNP TSC scaling constant to the header (Dionna)
* Drop the unsigned long cast and add in securetsc_get_tsc_khz (Tom)
* Drop the RB from Tom as the code has changed
---
 arch/x86/include/asm/sev.h | 18 +++++++++++++++++-
 arch/x86/coco/sev/core.c   | 16 ++++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fbb616fcbfb8..869355367210 100644
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
+#define SNP_SCALE_TSC_FREQ(freq, factor) ((freq) - ((freq) * (factor)) / 100000)
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
index 8375ca7fbd8a..36f419ff25d4 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2156,20 +2156,32 @@ void __init snp_secure_tsc_prepare(void)
 
 static unsigned long securetsc_get_tsc_khz(void)
 {
-	return snp_tsc_freq_khz;
+	return (unsigned long)snp_tsc_freq_khz;
 }
 
 void __init snp_secure_tsc_init(void)
 {
+	struct snp_secrets_page *secrets;
 	unsigned long long tsc_freq_mhz;
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
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
-	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
+	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
 	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
+
+	early_memunmap(mem, PAGE_SIZE);
 }

base-commit: 49151ac6671fe0372261054daf5e4da3567b8271
-- 
2.43.0


