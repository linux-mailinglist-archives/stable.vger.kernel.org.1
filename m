Return-Path: <stable+bounces-136969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5B7A9FC61
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40093A8C4B
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C420D4F9;
	Mon, 28 Apr 2025 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TKKccxUd"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2CFA94A;
	Mon, 28 Apr 2025 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876533; cv=fail; b=EfQ2s/CKuiHSmwq0k7KmK7ob9y2P7SI28bz2kuXxfBaJU7CrZq9W5sDWjbYciMkle9J30lfamxtoZCTcCy+GU/rwRBv/gb8l+wlBxIk2vE4xq7WqFkmUrjcMLI3bhrCycmdAus06oRIkqqcKXkhqy5ynLVT3zOPtIaoM17t93ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876533; c=relaxed/simple;
	bh=NBlmFerCCl2hF4YON7Xn0RLQw7+PAYMA6OLsjbUcQMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dXTKOR+im+EDHCINicq2XQQ2YN6Q91GKaKUsuFb9sUFBccTS8GZITmq+pHUST/+fUIL27cGU5Lcj78sVOXg4r1qbr14mP+4KKvV/11PYswyHWl73mov9/bnV7MrAGwXLZ/AebHr7FRxF57RqCq1Z2bZL672CJcY+GqX86qSLhnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TKKccxUd; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uF6fVgcd+AcxQvmgXnY9XrCT1Gfm3ae3ex55mPMS34UIx7uU6kVs/ffSSMmWxJH0YxCTYEmHXxrx+zejvLsha/Dp4zg7lSgzav0nNjy3RX/IFyeWqchMq3JGm1QMiT8PpWx/rPNyCOu+JYrAxZsHptNfdT0LQBRf42d/g3E6LkbY1gBFSmBO9tbEQtWBldcfvW2VJ19JYKyPB3A53qZBvUWyXlYXblSH8/T79L5BrLdywAwy/FrBCrkYEYgJC6ajEP8Ni5Cxfi4etJcLyfuxLAhefjxsmQWjUmBQuOiq098hwPYvCV80Bfl/95rTmpT4m3mo/U1dTOhZy/w1qoz4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGaDKsU76PUZQdKN9pEr4car2ehPDnzIQ5pZ5crExJk=;
 b=xJA5g5GD/pfKPgATRCadwMkCoP4BHasgfy/LhFFQJqf6a0l/9eJ0KiVOZVX0QGd29UtNYzR/6aKYRbWjogIFpOJI3ZhbWbA+P1u6tnlO7BFd1qD89dLuFUEzamYYpIzrvlIOH60jEZBEk7Aebs1Q8JEinGzSlJS5v9iCeZWIpNAz4TI2HfRGqrlv9f4PBkOk+zZ983ZoVIxHSKtSk7ogCdDAms9zlC+ig4Zg1gBXOyty/ZBs+2D3M16U04YSxfYGGXoqv8FZX5TZztCi2JgyVGr5LJA56DBR/ge92XmWXS7+NPJWXTo/0O5SueivbQ1WkhJe4DPzZWGz57bwKXBHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGaDKsU76PUZQdKN9pEr4car2ehPDnzIQ5pZ5crExJk=;
 b=TKKccxUdWEpWAkHXX7mQdFqg5ghMk1expmKWJ4nzEgRo7rv4E8Id8xeKX9JrdngMInHSQChzZLYW7eHtD9thOBFTvQHnuEjPAbt2yLJ2cuv8b9gcXyprNnoG1l+d7e+WuJWZUC7lSZGBciwC1IXbeSInzybdVK39xlVDVNSzqyA=
Received: from BN9PR03CA0895.namprd03.prod.outlook.com (2603:10b6:408:13c::30)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:42:06 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::3d) by BN9PR03CA0895.outlook.office365.com
 (2603:10b6:408:13c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 21:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.2 via Frontend Transport; Mon, 28 Apr 2025 21:42:05 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:42:04 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <kees@kernel.org>, <michael.roth@amd.com>, <nikunj@amd.com>,
	<seanjc@google.com>, <ardb@kernel.org>, <gustavoars@kernel.org>,
	<sgarzare@redhat.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH v3] x86/sev: Do not touch VMSA pages during kdump of SNP guest memory
Date: Mon, 28 Apr 2025 21:41:51 +0000
Message-ID: <20250428214151.155464-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac92e29-721b-4a4c-7fdc-08dd869d8512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zKza91aqYfloM5yY6pPuevkCd2MD/nwAovfeQ7gbuOll0mqTdSb2YFRS8ugL?=
 =?us-ascii?Q?GrzYVkux4eaJQRqHhPT0BoNEgLINZMXYvnmjtsR3M+Cu9s7gwSkyheI+yFU5?=
 =?us-ascii?Q?vcUIfIabBddD1ebx+58oSuLqe4PTOa355ktckBD89UxkadWutSjnvMTS6O7R?=
 =?us-ascii?Q?wZkiMQquzC/8wnSFtXnHzc3C2P160QZOELASVZG8VM8HLKXXzCizT00SjD+q?=
 =?us-ascii?Q?X8yL5frMVFWNnQlix7GPOb7z/8Tq5VUJmPoJFtoyy5gvm6JqA8oqknesKxw7?=
 =?us-ascii?Q?GA2c51d/Ps+m/hV7YuEUUZ3FAFdGHx92QhngGM1B/2pe0fQ533zRnc638FFn?=
 =?us-ascii?Q?VxC+v+hA+KmF6k9+oyYR+OlDlZ90ENWQ2JpDuSyI5k5z2Ofm1sD20lA/5kfW?=
 =?us-ascii?Q?yY40JiQjZHyJVdaTp3RecLhsQI1+5CN2qYLsOQYQvzGHNkKHqdVIZo4AtStA?=
 =?us-ascii?Q?bJ21kn1IGFGw0GYKdY3cNV8PZAOIcac94+ABJ7ktO589/ARcJZYkH/PFQk4w?=
 =?us-ascii?Q?5vByGRp4TNbVLlpeBAfZ915pQsC9QNykg2Ytemu9cVisfWtjJUGHCJVZaycw?=
 =?us-ascii?Q?rRtA+v6hzs3r+vVJzW1OMLayMoN/E+fYMtS7WI29jMt48MkEsrAf6yUVAsAp?=
 =?us-ascii?Q?9F/jCug2KG8Dk1qa7lOnyVicpIO0X588HHSHizxiB89zJMK8Q9njxDk1Ae4v?=
 =?us-ascii?Q?EG88hhScItOcyE+Yt9Dysf6AEpAEmE1LJn0Nw6OTs12cuvbeOK8wTR+ERIcn?=
 =?us-ascii?Q?UUsauZJRau1GrLlXVnZetLPnzrQT6sgfRAuDh1EHRDUl2Wq15x5puvsjgDX7?=
 =?us-ascii?Q?uWJ56k6C2oKj1j3zhzb0QASyDhkp6eQTgVmtjMNzwjAm+NEzXhpWL0czyQcP?=
 =?us-ascii?Q?k3dh4AfShWgRnnyRJGr9HMf1+FU3zAsi/d//Mu/XvkUhsMGEHMahfmehePOR?=
 =?us-ascii?Q?q2HqHV3Y1aP7/WVyL+Gfl74gwT+ZhueOMtlMrUZaiZU+25IpkPrD5qOdnP6V?=
 =?us-ascii?Q?xLQj0OBSO3PfJI3Fw++vlbv9iAFecD+JzJBnxWdyjt13F5Ejj4Ouu76woU/n?=
 =?us-ascii?Q?75t0I/iLfWOd2dzfEe1AKVjzrtBuUbMXVKNtK5wB76UEpWF8qUqvHz8Yph+c?=
 =?us-ascii?Q?/wyycufkpiTX76+8u8Li1IGoz76Z41eJGGOtnNlaVUU+EJfuI79rPEtCTsI+?=
 =?us-ascii?Q?ollAcg/vxWvhzleqzsEwcOlbzfWzO5jpmlYn6Ir5NEfrWsVZMuRZVSa88NN2?=
 =?us-ascii?Q?exfpunRDCq8CvXos59YBG0my3bLEG9rDE2lVf1TocP6QJb9lTTJFfgN5JAsh?=
 =?us-ascii?Q?RQzych55cGtzXOVP1Ap+ugBuTWc03TrfeFBCANXDmSRESe0b22DRrsu94zr0?=
 =?us-ascii?Q?a5jPbe11RGApnWb5gjZ0QwaH9O1iqh67biyZvNkwU8hSxGLEv5Qu/9cFz2EU?=
 =?us-ascii?Q?1sDcrw7NLH3NrGgCFDv82miSCMNPiAZTaH9741ZhH9EWmZ3vnbepI5pHghxU?=
 =?us-ascii?Q?QrmFuHNIXet9XC4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:42:05.6625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac92e29-721b-4a4c-7fdc-08dd869d8512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

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

Cc: stable@vger.kernel.org
Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c | 241 +++++++++++++++++++++++++--------------
 1 file changed, 155 insertions(+), 86 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index dcfaa698d6cf..f4eb5b645239 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -877,6 +877,99 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
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
+	if (event == SVM_VMGEXIT_AP_CREATE)
+		ghcb_set_rax(ghcb, vmsa->sev_features);
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
@@ -973,6 +1066,65 @@ void snp_kexec_begin(void)
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
+		 * BSP does not have guest allocated VMSA and there is no need
+		 * to clear the VMSA tag for this page.
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
@@ -987,6 +1139,8 @@ void snp_kexec_finish(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	shutdown_all_aps();
+
 	unshare_all_memory();
 
 	/*
@@ -1008,51 +1162,6 @@ void snp_kexec_finish(void)
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
@@ -1084,24 +1193,10 @@ static void *snp_alloc_vmsa_page(int cpu)
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
@@ -1215,33 +1310,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
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


