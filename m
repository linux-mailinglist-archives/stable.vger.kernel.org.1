Return-Path: <stable+bounces-136596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB73A9B0C8
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684191B81B50
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7315533F;
	Thu, 24 Apr 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qjH6mYGJ"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0617BD6;
	Thu, 24 Apr 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504168; cv=fail; b=CqJLVXfAv8RWrd5St8XiHlq/bm5ewhkLzkXDQgJBYXmNdV7E/auEAk8GaufZkdSU2mGVHT+aDdAMByH20Oj6wIxmVN8hTctH61MQPibife4ovpb4ElXqbUS8XMaoOIusgoA1MYDw/2PolGll5rMm1CrCOmKD+f7cDJLmAtx0dmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504168; c=relaxed/simple;
	bh=eHsIbgF3QXlZlBWSabhDCo8kEOZaI61wXU2qqJr1ojw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QxLNq8VGMKfFXIPlgGOmOYaUugo+CQZNhdKdlrBvxUCxceLlpPPC4pdZ7mBFL2C5+TJW9nvvFmYJriWJgJl6YH172jgWkZwbdRuRODjn75lynyJyZVY8L8i7IKLG3vbNt/Ht5CcImHl2U6BfR1mpw0l9kaKCTKI6FTBC/Al+k7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qjH6mYGJ; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcIxCQ7QUtP9wMnKhJeDCsuSBDw5V3N9nF1iGHc6+I0nabK+wyp4ZaJhjGUCzoVw2ONgaPEa3ZIMsU3NxulovCsLuewV6CwTVRHwSs5EVGZN1K+4JLkn5Cl5QCShiTJiJC1+SiHvzruPAlIdYl23LitBSiVs47r+n320qQvp33tdTy4QTM/r6hEzm/lxzgY3hcWlMNrgATQY9gTIRJVq57siFEy0tFY1M9dpw2NyVcM2jgRig2evOKnQZBODwas6/H+PCoAWzjAOU3ebtPFr14kIlsObu6YDGjnTiDGnI47pnQ01FVIlH3UFMx/Sa8JKEFylOK4UJjVWbBDIvq50yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLZncnx5mhdvKivqs9AduXfdVmLPOLICbuUcYD0Tq8c=;
 b=PiRPQAplQNZZK7JCUYqFt65/FUoQKnLywraFQ/PiGT7+NqFvPPQWIpfi/axOqxdlispCnuJgPMtL4m8ZEBA30ABOSnw2O186NpONy5qgLa5rFB5TWVWRefBoyoEPeMGz4yVesdYm1hby9KTrD41c9tevzIzfKlAMBxcYffK/BhCW9DMP9QjliypoxqsEo9UKvaisl1qqsudUw7OUSTw6+jriDzKftJRXKcRZN+T8RWrTP71+lmYqfsjEbraJY8dwPk4+mxzofEpDJXDEpuTCIYjF363SpkynPrw3XOoMuZ56K+V5m060uQYxC1ityWqnPmMmNUWZNQJt/gnDsmGOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLZncnx5mhdvKivqs9AduXfdVmLPOLICbuUcYD0Tq8c=;
 b=qjH6mYGJVwyicwBBHnhdf828gQSio0tT0xv90HeEuYGYvDO2cupMZjxavJQ7B1UiJH639XPj42bXrrgHANsdmeF87lIeqwv358k30iyIcMl7CUDTd6mC7qld2sYJGlxk8JML0UmHGDn+km8sKUB4IjT2HUI8qNQBpA6RC48TONk=
Received: from SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 14:16:00 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::db) by SJ0PR05CA0023.outlook.office365.com
 (2603:10b6:a03:33b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Thu,
 24 Apr 2025 14:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 14:15:59 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 09:15:57 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <kees@kernel.org>, <michael.roth@amd.com>, <nikunj@amd.com>,
	<seanjc@google.com>, <ardb@kernel.org>, <gustavoars@kernel.org>,
	<sgarzare@redhat.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH v2] x86/sev: Fix SNP guest kdump hang/softlockup/panic
Date: Thu, 24 Apr 2025 14:15:36 +0000
Message-ID: <20250424141536.673522-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: ef153c0f-c1ff-4328-4b14-08dd833a89c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SCSSg0cNF4wFaG8yJQyHBQW1OC/Qm4QAQFVY6wWjQWyiLUs88CmOlAYgiW23?=
 =?us-ascii?Q?0+erB4fVHdqt2S3buy6umUMb94ckJjbdebasnjeIsKHcns9S3mbHNcU5ut9H?=
 =?us-ascii?Q?tBIhIdC+Ac+n9z26qsjZnY9YcEDb++vN2fzEL1iRRzADFycCOEX2W1EzUpAH?=
 =?us-ascii?Q?HKoS1jLUj6tdH5tU7Jk8iB4pJN1dcK9eVGddGZhnNnbTo/NuFlRFPSCMi1/d?=
 =?us-ascii?Q?013h9TnX1rFQdrs2sZS42AlIMWp2yJj5+2hRdQWfdaw/OjoCNqUVAjm2vGNw?=
 =?us-ascii?Q?gHTEwTJF932v+u0fD9Z1gF2z4tfY4K/T9mhh/4QFbImMdjL5myVfo+2syjy2?=
 =?us-ascii?Q?dNbmQGo69P0MlCGzxrDRMSXdhkq9rOfZvMi+vUaAlgwIGOdvlrz6E114Ca7D?=
 =?us-ascii?Q?fNZbXz/xY3t8LMj1ukcgcAvIryrjH8JHBgwIWuDqABkM+/CS4KoSKClxx/4g?=
 =?us-ascii?Q?ZZXa7a4v7MXNZm3b9FrlPvU+110jT7+7MsylF1ZM7RJDxsKFcGcGniXnKDdx?=
 =?us-ascii?Q?3Botanf805snmWEd6YqdUE4+dy6+MDdmyJ8gqPX4fcKCo4yRT/r5JmYZpqog?=
 =?us-ascii?Q?QPyLPFu9jKZ6fCrvtU78mWo7DYy5V1dPU6JAEiDhyzL4LpV8DrV1KzXozn1Z?=
 =?us-ascii?Q?YSDHvWIiUXPo8CvbT74KP4Bw76+CRgOlaX2apsUNNr9ID+YwU9w98Q9RgpKz?=
 =?us-ascii?Q?HyDk3I/PNDB9uqoUuE85TJoQax0/7uLfd5eRK7nRxpE1cWVeIQvBCpRvcED3?=
 =?us-ascii?Q?FNQ3cykNX+OkxFAe6ZEp708rT+O5E9eSFm+5bAuf0SZ3s5Spe0gOhiot7Hb2?=
 =?us-ascii?Q?u7nEAG18oelyGDGMtgi9z8JHPfoJDcLY6a2aL7aWXrwZQVH2NEdf6kNcT904?=
 =?us-ascii?Q?VNDgynd69jypSk+zDU2GcI96dOA3Cxl5onNXJRdYPOgO0O49ZK8+rbSc0Sys?=
 =?us-ascii?Q?7Vrs2W+HpbmTO6ydO2OTQ4TBB2+MspUrjkIhXfyewuOblfcaxCOpMrzdNsNi?=
 =?us-ascii?Q?Tl+KFvIz6TUbO17GwshF52iuBsvJlqgEq3JLNOrnCOpGlGY98gT2EiKuya0m?=
 =?us-ascii?Q?4yypCfX9/QRTI9s6+ZjqsCBKue8YUDySwClr9ZKgFoZPQVcPz9lNXtceSjOj?=
 =?us-ascii?Q?Y7nqgX/78wftSIKn47g1o9poKzuK7Z768fyGU3rA4Uxx4AR1y2INsLzG1te8?=
 =?us-ascii?Q?wIOgjYi0ngp5w5Nr8zNX+B6M9ppcZMaBlpQ7b+9oM1GV2y6fRUMr+5LdKKrm?=
 =?us-ascii?Q?aNgj49+O1oQOir0ilcICzWKvIhD7jAl5P34ZhqJnIYMK1lo+Dz9NJQe0LeBS?=
 =?us-ascii?Q?DQ0PkY5yi/5TxTrS/NjCiII8SYu+0MtugK2mwUF35yjDNeQMY7jywfb1DQsv?=
 =?us-ascii?Q?DmjYsV3zU69VjgWtkcCyFNVD+xR58DAiruPVDBhoD2GQcds36ILKw8QQsJSq?=
 =?us-ascii?Q?+vtaNi++uhWQZdLJBpiwdHQrGgh2J2WLO0xKrVAkXV13satm6ll3MBXKDwWH?=
 =?us-ascii?Q?3YVuG1A8mzTQ38MJlrhZt9qiEspCN8PX4PRB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:15:59.7560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef153c0f-c1ff-4328-4b14-08dd833a89c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

From: Ashish Kalra <ashish.kalra@amd.com>

When kdump is running makedumpfile to generate vmcore and dumping SNP
guest memory it touches the VMSA page of the vCPU executing kdump which
then results in unrecoverable #NPF/RMP faults as the VMSA page is
marked busy/in-use when the vCPU is running.

This leads to guest softlockup/hang:

[  117.111097] watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [cp:318]
[  117.111165] CPU: 0 UID: 0 PID: 318 Comm: cp Not tainted 6.14.0-next-20250328-snp-host-f2a41ff576cc-dirty #414 VOLUNTARY
[  117.111171] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[  117.111176] RIP: 0010:rep_movs_alternative+0x5b/0x70
[  117.111200] Call Trace:
[  117.111204]  <TASK>
[  117.111206]  ? _copy_to_iter+0xc1/0x720
[  117.111216]  ? srso_return_thunk+0x5/0x5f
[  117.111220]  ? _raw_spin_unlock+0x27/0x40
[  117.111234]  ? srso_return_thunk+0x5/0x5f
[  117.111236]  ? find_vmap_area+0xd6/0xf0
[  117.111251]  ? srso_return_thunk+0x5/0x5f
[  117.111253]  ? __check_object_size+0x18d/0x2e0
[  117.111268]  __copy_oldmem_page.part.0+0x64/0xa0
[  117.111281]  copy_oldmem_page_encrypted+0x1d/0x30
[  117.111285]  read_from_oldmem.part.0+0xf4/0x200
[  117.111306]  read_vmcore+0x206/0x3c0
[  117.111309]  ? srso_return_thunk+0x5/0x5f
[  117.111325]  proc_reg_read_iter+0x59/0x90
[  117.111334]  vfs_read+0x26e/0x350

Additionally other APs may be halted in guest mode and their VMSA pages
are marked busy and touching these VMSA pages during guest memory dump
will also cause #NPF.

Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
of guest mode and then clear the VMSA bit on their VMSA pages.

If the vCPU running kdump is an AP, mark it's VMSA page as offline to
ensure that makedumpfile excludes that page while dumping guest memory.

Cc: stable@vger.kernel.org
Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c | 129 ++++++++++++++++++++++++++++++---------
 1 file changed, 101 insertions(+), 28 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index dcfaa698d6cf..870f4994a13d 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -113,6 +113,8 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
 DEFINE_PER_CPU(u64, svsm_caa_pa);
 
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id);
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -877,6 +879,42 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static int issue_vmgexit_ap_create_destroy(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
+{
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
+	ghcb_set_rax(ghcb, vmsa->sev_features);
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
+		pr_err("SNP AP %s error\n", (event == SVM_VMGEXIT_AP_CREATE ? "CREATE" : "DESTROY"));
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
 static void set_pte_enc(pte_t *kpte, int level, void *va)
 {
 	struct pte_enc_desc d = {
@@ -973,6 +1011,66 @@ void snp_kexec_begin(void)
 		pr_warn("Failed to stop shared<->private conversions\n");
 }
 
+/*
+ * Shutdown all APs except the one handling kexec/kdump and clearing
+ * the VMSA tag on AP's VMSA pages as they are not being used as
+ * VMSA page anymore.
+ */
+static void snp_shutdown_all_aps(void)
+{
+	struct sev_es_save_area *vmsa;
+	int apic_id, cpu;
+
+	/*
+	 * APs are already in HLT loop when kexec_finish() is invoked.
+	 */
+	for_each_present_cpu(cpu) {
+		vmsa = per_cpu(sev_vmsa, cpu);
+
+		/*
+		 * BSP does not have guest allocated VMSA, so it's in-use/busy
+		 * VMSA cannot touch a guest page and there is no need to clear
+		 * the VMSA tag for this page.
+		 */
+		if (!vmsa)
+			continue;
+
+		/*
+		 * Cannot clear the VMSA tag for the currently running vCPU.
+		 */
+		if (get_cpu() == cpu) {
+			unsigned long pa;
+			struct page *p;
+
+			pa = __pa(vmsa);
+			p = pfn_to_online_page(pa >> PAGE_SHIFT);
+			/*
+			 * Mark the VMSA page of the running vCPU as Offline
+			 * so that is excluded and not touched by makedumpfile
+			 * while generating vmcore during kdump boot.
+			 */
+			if (p)
+				__SetPageOffline(p);
+			put_cpu();
+			continue;
+		}
+		put_cpu();
+
+		apic_id = cpuid_to_apicid[cpu];
+
+		/*
+		 * Issue AP destroy on all APs (to ensure they are kicked out
+		 * of guest mode) to allow using RMPADJUST to remove the VMSA
+		 * tag on VMSA pages especially for guests that allow HLT to
+		 * not be intercepted.
+		 */
+
+		issue_vmgexit_ap_create_destroy(SVM_VMGEXIT_AP_DESTROY, vmsa, apic_id);
+
+		snp_cleanup_vmsa(vmsa, apic_id);
+	}
+}
+
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;
@@ -987,6 +1085,8 @@ void snp_kexec_finish(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	snp_shutdown_all_aps();
+
 	unshare_all_memory();
 
 	/*
@@ -1098,10 +1198,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
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
@@ -1215,31 +1312,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
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
+	ret = issue_vmgexit_ap_create_destroy(SVM_VMGEXIT_AP_CREATE, vmsa, apic_id);
 
 	/* Perform cleanup if there was an error */
 	if (ret) {
-- 
2.34.1


