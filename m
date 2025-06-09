Return-Path: <stable+bounces-152001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E906DAD1994
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 10:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6181888097
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D828151B;
	Mon,  9 Jun 2025 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hvgbVoOv"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A793281379;
	Mon,  9 Jun 2025 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456562; cv=fail; b=rWgksGTSnWNZSZoHdZn+YsUgXFMF/zUYPnvbFj57woPniN4r11VlWp5wUUVm7YUBaoRTKv/JhBgFShdaqZTfEYpmit6yYEUNJx5hhavy8IISwFG9lHB8c0HaYRqBdwBV2tuN9i9U5EW3dg/ALKWRfGBs3SrHAX060ccOQEwUNlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456562; c=relaxed/simple;
	bh=pDGao/maUDTSu7j6oeSRB0xSx35F0n4tagBYU7nugpQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ToYw4mVyTS21780nPeL8A1bn1G/YphP+v+26N3lakZxJgPtXdd4su4wpdTz/Plo5uoKNICWkYBBll0HuPfKNZCOw4hPuRm2l/P8pvwpl0NF9d6Z4TCCt5RHQJpSpkEZf/4GmCYhaQx1kuup/0gn2BNdcsewcaGoSHu/VeDiMXrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hvgbVoOv; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu4BnWpNQPSNo9OTuMEcgX4hmsW6yIhA405i5qavIhM3XanbbV7NTMe6GaeACSGdj37I0bqxDKaU3sEMkHI6NpU8bhU/TdYrj7c6oKRnMSXkvJVyeoBxAlbjh4gPffiEysXfzhz+JkXbPNX+7Fg6QQ26cjQrytRqlulnb3f9BZyxplsnyG/I2W4r1Z3C4YcDRbPp9Vy/7h4150rCsak81v61XAg4pE6dd8QOlv6b97+go9Sjakdnt73K7XwXuSRxkBdxRlJYCvwyVsJ0asfOqUIkFdm/UW3idkNOoNQoIW5fkkAVPa8RmMJrcZJqVHYyNWgEqlhB9wbu9JBz3+oYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYXR/Z6GszrWykQchy3BBAlcJyNa6V+/Rhf4kEtHeow=;
 b=bLe53CgfoSRWCrXfz8IrBrOz+vLRYzHbnc4jFT45ZxQyKeCLkeE5bxke3MNH+PY0303ZIewBSwst5RApb7kqNNJGIvhzw9D4MgBzfMbMkeuIY4tY2Um20dAHPMSVGMDvU675fZwDPLFT3o0+ivQZDQz3Y+lhckELDAHwrMIVccl1b9ZWjn3MIPkQlMCndvClsklYYOSqDHjgXAfk87qkG5vFEEy265hce8Ubi1W9SbvHheBY+yhUAy/cVCNrjAjAaIpH0ARzcHDeNncSVc3q2AGX4PCwn/OC4VDV0vUp15asdK+wJRvMvyg6XbBpU1oK6LKdh4weFybWhsATFYlf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYXR/Z6GszrWykQchy3BBAlcJyNa6V+/Rhf4kEtHeow=;
 b=hvgbVoOvrIIuBEklwPbwJHDiZu3VQqUJsaBf5e7iNMsxqQU30cIe4i1nRrASn1psq1V0PHvg6CeAsj0W/Ne/nW45INTeFIzzk9Dzev1RSSrs1jQh5uJUBeeiYaxt0nmThi5Y4j0jO2CU7rbuZUTJ4szBYYoGb/98C3uszD9zw+k=
Received: from PH7P220CA0115.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::32)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 08:09:16 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::6e) by PH7P220CA0115.outlook.office365.com
 (2603:10b6:510:32d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 08:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 08:09:15 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 03:09:12 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<thomas.lendacky@amd.com>, <aik@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation
Date: Mon, 9 Jun 2025 13:38:41 +0530
Message-ID: <20250609080841.1394941-1-nikunj@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ac431f-7371-4a8d-a115-08dda72ced64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xplB1DMLyFBDYlbV40vlnS19WOElG3rmoebbq7s+rLjHQ9MoLT/jGp3m1MQB?=
 =?us-ascii?Q?EngNMXcEb/Frq9XFGZFWoA3O7vacqRf1VPIOpx6wKCs44PzKa9iknNeEZaiU?=
 =?us-ascii?Q?W2Ev8JuPcxdihQWQ1mqY/x5Nu1M7kS6JuHsr2SBUl3AK6BDyjJpnpdU+bYOo?=
 =?us-ascii?Q?KQu/HLVChB3qG0+97o9g9UGSvxbOSCIDLVh8ABeyX/1iFMUMTojPsCNV7lqR?=
 =?us-ascii?Q?60+3KQ4lORM1HYwXravwxYl48uCgCAZuwSJTnCopw2o/yhc+oDXX4OgqMxP2?=
 =?us-ascii?Q?T3IU/8R/LBfG8BjxfNbxRNJsNmhWuSUZunyy56RlWssO/KbCX8DCUkleyZvF?=
 =?us-ascii?Q?H/GLtvdP2l4LVadGHk86hyHmRCnhOnx4YQU+l+03GPXotLWrI+tP+V96Laqz?=
 =?us-ascii?Q?kqQ82xwMyrJCusYpCD8gTj7fNwAfKipQUbitQRiexez0pEHduTQxk6MY4VOu?=
 =?us-ascii?Q?Ic5fKxkA/KKE2hOvT8gqtF+d99AcAR4EPE/YwL9p+PPSpyW27Qugzy3T6iZE?=
 =?us-ascii?Q?Vb0kMAI0hRy+/rHpsQegePk/cpaZ9VTelcZAo1sEDcBoD8rGoOVh0lmjEctF?=
 =?us-ascii?Q?N84mvuJzQl6l2bxvMHowhmiiiWgnyeNBIuTxpQQo4Q743JAeICfhbK25K1sg?=
 =?us-ascii?Q?+9GNZq59sUG7MQPyWKVecwkVxGzJ39j712gq+C2xHC8StTs5FpuG5C/IUfl5?=
 =?us-ascii?Q?cGk/hmMdlovTzX+sRb4ZMxy9U+1b4On43YZjILQlV7u3qUDwZxMuPlibsHPk?=
 =?us-ascii?Q?z8I6YAtgPG9ErA011IeD+Dt00bohjI5su2YG+YIuDqfQ0gtNc95wyWvvoMBn?=
 =?us-ascii?Q?t1p8d9Mi075pxtnikVg1kHXc33H4wu4S1JMARLNBcyZsevks+5Xja4SyZvmK?=
 =?us-ascii?Q?dCAOQB7AwWc/b60b2wqh1+jTpNG0PWo9R24Jw98dfTHh3pN3pgkYBBQm/BcS?=
 =?us-ascii?Q?HVbiwZK5Kw0OHGlbXvCY5wpU+W4D7XRuezIyWniRDCt3UBGd4sYl03K0DHKZ?=
 =?us-ascii?Q?PW6C071Bkp76JzBzpSfiIw2x49aSqYmFraDWPYVQcBWjvgh36aGKTGY6o7xB?=
 =?us-ascii?Q?4RNLT+2hT1ILtGQ1rT8tHLI4Lr79oh6ixer8WnEs2ix19nNcViFhqQFLV+rh?=
 =?us-ascii?Q?HbMR/0xHByQGTwHTYqdu740LSO/Z+j/7O8kv/KILu8IRsoEfw9w0iKc8uQ52?=
 =?us-ascii?Q?5gg92lcyBG6r71AX67bDEsJBrtD6C/DzHethgRZZhWxmxZQx7Am3oZhMxHVz?=
 =?us-ascii?Q?W50kQIo/Ydoh1EOJE2Q6bIntwG0lhcBLkYCS7i+AnzWLQbwgvCVWrEXvvR8p?=
 =?us-ascii?Q?FKUsIXeAfUt2E+V9uTwrv+6KesViISDGuJhv+uvAG6mOTMgfc6uXyrVygfvG?=
 =?us-ascii?Q?25YXzz02m01OvTjUIm/k4DlnazsUwq7beEtNlJzk4XJqx06xCMSStfvXLOkn?=
 =?us-ascii?Q?Hh2cdtTJxAqWI68WutYZOFKHPmgEIvfy+61YjYaxJa6VzCZn2sJg9xIDfAma?=
 =?us-ascii?Q?C94tPsXB/QnMR4Nxw7LBq0sAO6cf7+v6Rgyg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 08:09:15.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ac431f-7371-4a8d-a115-08dda72ced64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733

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
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/sev.h |  5 ++++-
 arch/x86/coco/sev/core.c   | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 58e028d42e41..655d7e37bbcc 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -282,8 +282,11 @@ struct snp_secrets_page {
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
index b6db4e0b936b..ffd44712cec0 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2167,15 +2167,39 @@ static unsigned long securetsc_get_tsc_khz(void)
 
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
 	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
 
+	/*
+	 * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
+	 * TSC_FACTOR as documented in the SNP Firmware ABI specification:
+	 *
+	 * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
+	 *
+	 * which is equivalent to:
+	 *
+	 * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
+	 */
+	snp_tsc_freq_khz -= (snp_tsc_freq_khz * secrets->tsc_factor) / 100000;
+
 	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
+
+	early_memunmap(mem, PAGE_SIZE);
 }

base-commit: 337964c8abfbef645cbbe25245e25c11d9d1fc4c
-- 
2.43.0


