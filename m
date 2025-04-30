Return-Path: <stable+bounces-139245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9053BAA57AB
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5158498600A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2F22171A;
	Wed, 30 Apr 2025 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xthJ72mO"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE661221555;
	Wed, 30 Apr 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050269; cv=fail; b=D83MpaHyVasLyyPoIqHJlRtNmSJmvf6fp2tiLKEPEt3deCC0120XZJYmg+yh8o3xmp5Qw9YL9GF2/f/4tkHL8KHDwX6X46KpyElYUJF6W4qDAeiH7TEcPldRPJ7MhsHBCsMoQ4HLD2DuJAyyOSGNwdOoUr23TPdYImKOrIKJ+5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050269; c=relaxed/simple;
	bh=b1kSzbFJH2o+3vFiTWlDzqSFGAQj8+H4WMsarXupggE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uW0I5D+krS3p7m8/dhYFdkbWjhGkBmgfP18eOR3dimnlEJvrm+4AxSM22BQVQPZrYzRa7wWd15RAngedBSWcMFHN8s6fw+kDcUNOlzNqimJ5WTZxZnsBNR9QtQbO7ZlKZoBU526xeNCjGfhq3J93gDyC6mwmTP7k6brbBMmZm+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xthJ72mO; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Equ232I09xscowv1M4dPN0Z/KVKL6gUnbKDChmR0pqMSWKFLi8VYKY68647t5cBYbLOLr0In+bEU3ZgvqZncwKChWz+yzWPtN980dsUSAzvgckh+f+9abWpryBv7Q3pdCTdq43sQX0qPe/3ZQ/8lkAuGeDg6JuS/ewaaKElJhByqhEEBfebfnDO3GOyQrkj7wG/SQrLoC/ZWXZemLirbPuaX2vcBQoWNOaRHWJQqQP9aP496AnlhMtl63d0Vqc209kQDPXrJn8I9SwEBswe1YmVAgp9iohTyzUjcUG1ajRB2CxkSIB0UErS+OXtwMoqwFt/VgcccQ8ty5Mo4j8j3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3A4U/UKjkwNkzwA7/soheVLpl5WnjquoOuCc/bc4Jc=;
 b=DsNfKxGe7qiHKCWmWRAaCze+n/+n81JN/ynWw4ldYynbpl2Qyz17fb4KfdWYVxUN+oJCtAusED9696l6fVQaiXrigTGBw7FDNnOrNdL3figXw/Zn7eFLTnQzvVpYzUke7zTV5xpq802nR9c+3SRn4EysJINlnG/Qm4njL1V26aeJkefsXuytoNVi5w19G0eB3/MxcFxDzFbcaYdINF+wI54yAA6bTL67zDM+Pk8QMmvdtoD1YTBdlL/uYZryMqe5itBpHqJd3lfgbkMMzLc5Up9wofepGCvtUkULh+gVJDwiC2Wi0jf1IUMSUGN0+r/4vql5gfZoU6ri5lsPROuNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3A4U/UKjkwNkzwA7/soheVLpl5WnjquoOuCc/bc4Jc=;
 b=xthJ72mOEBvLJg4LSqJfvhKYLa9TpigtK7YNh07evd0pViBRtZLfYDQ1MkZZlRcbYk5M3dQuI5UvJdlOVrQ+RhnZDvNjejYiN0VFpOIjnoGZYK5gMNb9IG3htKs8hyLVjSf384lcIKFTZD4vrw+AbqOcrSNZmoAk2XHZ2lGBHME=
Received: from MW4PR03CA0210.namprd03.prod.outlook.com (2603:10b6:303:b8::35)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 21:57:42 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::6e) by MW4PR03CA0210.outlook.office365.com
 (2603:10b6:303:b8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 21:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 21:57:41 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 16:57:40 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <kees@kernel.org>, <michael.roth@amd.com>, <nikunj@amd.com>,
	<seanjc@google.com>, <ardb@kernel.org>, <gustavoars@kernel.org>,
	<sgarzare@redhat.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH v4] x86/sev: Don't touch VMSA pages during kdump of SNP guest memory
Date: Wed, 30 Apr 2025 21:57:30 +0000
Message-ID: <20250430215730.369777-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b6c51d-d30e-471d-b069-08dd883207f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uIrmsnsog8m+9unhHCIjscUWwE/BBUmPdJRyVmK7mD4JVf8X355Vm2b2eRE2?=
 =?us-ascii?Q?yiaOphn1DjfCmJLjolVTrJ3uweZz7LReK1HKPHSWP7gwkq6gPg2mKqvdJZ76?=
 =?us-ascii?Q?PRXJs4bJt3NhdBxNlEuPMDXQhuUkKLysx2ClM4V9k5oIwMOooYgUi0gadFRu?=
 =?us-ascii?Q?MLlVod6+A2Cc4kwv7XTtMY16b0e6ENX27RyxYfEOGdQ3EcQKMYAmPSBJV1LK?=
 =?us-ascii?Q?F/6edpJB/K6XdtFARRQqgRL8mCx6IsjwuSMfMaBryndebLeuYbdFXjP0rmiU?=
 =?us-ascii?Q?tCuQWhx8Ffb5CpqbpTTFAc3+Az9rXg4NzEUmVuBKC5uUt1k0gneTPPBJHe6s?=
 =?us-ascii?Q?ocXbbVspCDhqN0LSjgfGfRUMvpGr4W/pL6hQbGBg7SfqJop3KNsa1i/968lb?=
 =?us-ascii?Q?1TxRld4YBGhCSAGCULxV53dOnvvrl5B5Y+MGPLfX5wCvoSTYb5ds/uKgIQAa?=
 =?us-ascii?Q?Voswc+5V61uJWYrxZKMqOvzddvcw2/MP/s8z6HmHAq7JOo93KQEPtrAmMQmU?=
 =?us-ascii?Q?meraCmUmZKg5dkwl/fL4QD/pzR2dyteOmiFApdYbfrDVJEhLjOOKdKm1AgDE?=
 =?us-ascii?Q?8goIC+x8SfsyT2B8+u1EfhjOtxBlkBbzYxKOOHQcsUpL2GAA4G6wBW5rk956?=
 =?us-ascii?Q?7pJBfmp1HRAX53Z/qHzyyy0mqM6p/v8Tce50HKOJU0S+W6scoqG9biRgp6cn?=
 =?us-ascii?Q?GBTqaYqoEVxG8uVADFMj3+uIiHwgmQA6W/vN1NetzNTvTQSXR9sCXLYil9Ol?=
 =?us-ascii?Q?KJBn1X08DHp79lF9CoN92unAcUevqJCp7izboroUPHd+mJZ75KH+CT+ImAci?=
 =?us-ascii?Q?+KitC0e6mwkAXrljX4Xu1m5RUBuroWkbkp36kIgnMjd+dpwCvSlHzRFkOFHa?=
 =?us-ascii?Q?F/d9cvZUGksGWA2EzNe5I5utUWNzVzS4GxY2/utzxpcvGrEh2Nc7a+o6aK3u?=
 =?us-ascii?Q?sab92vSIJ3aIBcCk3l0vOvPHB7foXrvu1tFelkc99+tK4cxcTlsRn8HYzIqr?=
 =?us-ascii?Q?1ipCeROWfMwx2RTjU8+PGW1ykyRJi6NHMhmAevMNVKcK5PaCOsBOqkYf7cMc?=
 =?us-ascii?Q?H0q9icC8gjF5hGzKPb0DOTPkwPOkxEhAL3zyYRuOpn6Fhlr/8oCnbD6TtrTn?=
 =?us-ascii?Q?W70yF7FDEzBtlJN1JnR6qtT3vsiZUmtO7D+BlL0SVFg9D28PfKP9RMNCSYvT?=
 =?us-ascii?Q?Z4aIqJyEC7GL09fvzsWv6bt/S+Xogx6wE36trmavQtM3stUiSoY20rk38Jip?=
 =?us-ascii?Q?Y5npnGp4dAzCqCUOc/b9N+K/JDlH1q4nGhoWE7YHmKYEkXqMPfzUnCLRfJNq?=
 =?us-ascii?Q?GP5lI8WF6Z6dpst14RqWA/Z3qv2UMGiHgoYgBYgE1cHzFThCwpgtGOabp/7V?=
 =?us-ascii?Q?B5qg5ffo5lYz+o+dhXqPJ+sE00YYgnbSQ+2odk54ps2fdJNJDMcwdo860nh2?=
 =?us-ascii?Q?MY5zy15POGSAgA7BE2+GjHY0FZARf2FNL59lhJP8kcSadktDOjan58Mx3VrI?=
 =?us-ascii?Q?3v+/14GKE2qe4UVUR/U81dP2iGDl69kgdcVE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 21:57:41.8486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b6c51d-d30e-471d-b069-08dd883207f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253

From: Ashish Kalra <ashish.kalra@amd.com>

When kdump is running makedumpfile to generate vmcore and dumping SNP
guest memory it touches the VMSA page of the vCPU executing kdump which
then results in unrecoverable #NPF/RMP faults as the VMSA page is
marked busy/in-use when the vCPU is running and subsequently causes
guest softlockup/hang.

Additionally other APs may be halted in guest mode and their VMSA pages
are marked busy and touching these VMSA pages during guest memory dump
will also cause #NPF.

Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
of guest mode and then clear the VMSA bit on their VMSA pages.

If the vCPU running kdump is an AP, mark it's VMSA page as offline to
ensure that makedumpfile excludes that page while dumping guest memory.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: stable@vger.kernel.org
Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c | 244 +++++++++++++++++++++++++--------------
 1 file changed, 158 insertions(+), 86 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index dcfaa698d6cf..d35fec7b164a 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -877,6 +877,102 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
+{
+	bool create = event == SVM_VMGEXIT_AP_CREATE;
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret = 0;
+
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+
+	if (create)
+		ghcb_set_rax(ghcb, vmsa->sev_features);
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
+	ghcb_set_sw_exit_info_1(ghcb,
+				((u64)apic_id << 32)	|
+				((u64)snp_vmpl << 16)	|
+				event);
+	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
+	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
+		pr_err("SNP AP %s error\n", (create ? "CREATE" : "DESTROY"));
+		ret = -EINVAL;
+	}
+
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
+{
+	int ret;
+
+	if (snp_vmpl) {
+		struct svsm_call call = {};
+		unsigned long flags;
+
+		local_irq_save(flags);
+
+		call.caa = this_cpu_read(svsm_caa);
+		call.rcx = __pa(va);
+
+		if (make_vmsa) {
+			/* Protocol 0, Call ID 2 */
+			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
+			call.rdx = __pa(caa);
+			call.r8  = apic_id;
+		} else {
+			/* Protocol 0, Call ID 3 */
+			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
+		}
+
+		ret = svsm_perform_call_protocol(&call);
+
+		local_irq_restore(flags);
+	} else {
+		/*
+		 * If the kernel runs at VMPL0, it can change the VMSA
+		 * bit for a page using the RMPADJUST instruction.
+		 * However, for the instruction to succeed it must
+		 * target the permissions of a lesser privileged (higher
+		 * numbered) VMPL level, so use VMPL1.
+		 */
+		u64 attrs = 1;
+
+		if (make_vmsa)
+			attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+	}
+
+	return ret;
+}
+
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
+{
+	int err;
+
+	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
+	if (err)
+		pr_err("clear VMSA page failed (%u), leaking page\n", err);
+	else
+		free_page((unsigned long)vmsa);
+}
+
 static void set_pte_enc(pte_t *kpte, int level, void *va)
 {
 	struct pte_enc_desc d = {
@@ -973,6 +1069,65 @@ void snp_kexec_begin(void)
 		pr_warn("Failed to stop shared<->private conversions\n");
 }
 
+/*
+ * Shutdown all APs except the one handling kexec/kdump and clearing
+ * the VMSA tag on AP's VMSA pages as they are not being used as
+ * VMSA page anymore.
+ */
+static void shutdown_all_aps(void)
+{
+	struct sev_es_save_area *vmsa;
+	int apic_id, this_cpu, cpu;
+
+	this_cpu = get_cpu();
+
+	/*
+	 * APs are already in HLT loop when enc_kexec_finish() callback
+	 * is invoked.
+	 */
+	for_each_present_cpu(cpu) {
+		vmsa = per_cpu(sev_vmsa, cpu);
+
+		/*
+		 * The BSP or offlined APs do not have guest allocated VMSA
+		 * and there is no need to clear the VMSA tag for this page.
+		 */
+		if (!vmsa)
+			continue;
+
+		/*
+		 * Cannot clear the VMSA tag for the currently running vCPU.
+		 */
+		if (this_cpu == cpu) {
+			unsigned long pa;
+			struct page *p;
+
+			pa = __pa(vmsa);
+			/*
+			 * Mark the VMSA page of the running vCPU as offline
+			 * so that is excluded and not touched by makedumpfile
+			 * while generating vmcore during kdump.
+			 */
+			p = pfn_to_online_page(pa >> PAGE_SHIFT);
+			if (p)
+				__SetPageOffline(p);
+			continue;
+		}
+
+		apic_id = cpuid_to_apicid[cpu];
+
+		/*
+		 * Issue AP destroy to ensure AP gets kicked out of guest mode
+		 * to allow using RMPADJUST to remove the VMSA tag on it's
+		 * VMSA page.
+		 */
+		vmgexit_ap_control(SVM_VMGEXIT_AP_DESTROY, vmsa, apic_id);
+		snp_cleanup_vmsa(vmsa, apic_id);
+	}
+
+	put_cpu();
+}
+
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;
@@ -987,6 +1142,8 @@ void snp_kexec_finish(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	shutdown_all_aps();
+
 	unshare_all_memory();
 
 	/*
@@ -1008,51 +1165,6 @@ void snp_kexec_finish(void)
 	}
 }
 
-static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
-{
-	int ret;
-
-	if (snp_vmpl) {
-		struct svsm_call call = {};
-		unsigned long flags;
-
-		local_irq_save(flags);
-
-		call.caa = this_cpu_read(svsm_caa);
-		call.rcx = __pa(va);
-
-		if (make_vmsa) {
-			/* Protocol 0, Call ID 2 */
-			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
-			call.rdx = __pa(caa);
-			call.r8  = apic_id;
-		} else {
-			/* Protocol 0, Call ID 3 */
-			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
-		}
-
-		ret = svsm_perform_call_protocol(&call);
-
-		local_irq_restore(flags);
-	} else {
-		/*
-		 * If the kernel runs at VMPL0, it can change the VMSA
-		 * bit for a page using the RMPADJUST instruction.
-		 * However, for the instruction to succeed it must
-		 * target the permissions of a lesser privileged (higher
-		 * numbered) VMPL level, so use VMPL1.
-		 */
-		u64 attrs = 1;
-
-		if (make_vmsa)
-			attrs |= RMPADJUST_VMSA_PAGE_BIT;
-
-		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
-	}
-
-	return ret;
-}
-
 #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
 #define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
 #define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
@@ -1084,24 +1196,10 @@ static void *snp_alloc_vmsa_page(int cpu)
 	return page_address(p + 1);
 }
 
-static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
-{
-	int err;
-
-	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
-	if (err)
-		pr_err("clear VMSA page failed (%u), leaking page\n", err);
-	else
-		free_page((unsigned long)vmsa);
-}
-
 static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
-	struct ghcb_state state;
 	struct svsm_ca *caa;
-	unsigned long flags;
-	struct ghcb *ghcb;
 	u8 sipi_vector;
 	int cpu, ret;
 	u64 cr4;
@@ -1215,33 +1313,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	}
 
 	/* Issue VMGEXIT AP Creation NAE event */
-	local_irq_save(flags);
-
-	ghcb = __sev_get_ghcb(&state);
-
-	vc_ghcb_invalidate(ghcb);
-	ghcb_set_rax(ghcb, vmsa->sev_features);
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
-	ghcb_set_sw_exit_info_1(ghcb,
-				((u64)apic_id << 32)	|
-				((u64)snp_vmpl << 16)	|
-				SVM_VMGEXIT_AP_CREATE);
-	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-	VMGEXIT();
-
-	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
-	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
-		pr_err("SNP AP Creation error\n");
-		ret = -EINVAL;
-	}
-
-	__sev_put_ghcb(&state);
-
-	local_irq_restore(flags);
-
-	/* Perform cleanup if there was an error */
+	ret = vmgexit_ap_control(SVM_VMGEXIT_AP_CREATE, vmsa, apic_id);
 	if (ret) {
 		snp_cleanup_vmsa(vmsa, apic_id);
 		vmsa = NULL;
-- 
2.34.1


