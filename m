Return-Path: <stable+bounces-179602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82BB56FAB
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 07:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B60C171BD7
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 05:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD1433BC;
	Mon, 15 Sep 2025 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ppoKgnRE"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC01BC58
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757913533; cv=fail; b=Nsb/YSsJJK+TOmVBeq2a9sjjKQjhOiUnCLy7xM0VeKENtULOqeJjnUjCm3ZlRUE1sdn5wFVrzN9CY6B4eRNoQRP3HaMY41DGoCUYU+h35V2PX4ft7qYJHXnDmuSseYzfaQjIcjwG76ZWB/uXuX0G0Cy+GheAEbrIHZPhl8noh64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757913533; c=relaxed/simple;
	bh=p5DsdvbW0ocT/3RoZkAI0ck4oFwWGs3eit+TZBvU5vA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIXHE3QkSQzBHb9vAhB0ksPD07s0hf238wxBuLIkoUz0YPQ0Q5BQURt3nE/ekKoITwxKkEYmVXzow0n4XMsjSHcvDryGrF6kcX5KlDvnkqXF/NmjD2xf6oG1juRWs5en5Nz8UVQ5u27RH50lkjbQZTbaNo9wQqK2N1igaF/vQlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ppoKgnRE; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6ejwlT+7C3aA39Dbdr/fndqErqKdYERNNLFvBfsQiyzr1y3PTfXyKC2WdSHfUe7Gi+aRTlswfo/uPwQ9ddl8b5MB0G/BemBxSs3pAjhho4BEMsymRLQlvgZXfKLiX0SN4c6Xu03WwAdnhHFaiRrSuyYRd+4+WWnDdxxTqH7AD35U62iWaHuyGNQ7f9ukd6Dqy43gaYby4d09NBM1DesdEVIc3qKJ8+C3Hdl0X82ZQgti1/ay81ZM6o99UKYR3VHYzhFLh3yyAi8uW99SCOvbgRWkqb3inc1++LMW7pwbZpnkJAiDFRo/xxlU1wn4oGFCujIZ4bIcnvLspfge0dGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coKmKf1uV/UmtgEw3iiiUCmrb6EYE4NzRNH3xbLMWaU=;
 b=YcW0pTesVktQaiAdxdxm/6M5ZhGuvwShpQbaSnb0M9H3xMnmVdjyeCljQ/raCrhIUMXgiUBEcG0O8MlILxNMN5EPhrs8CPSriwHrSpJD2u105TdC3/ThesKlrMSV7m79CjSo0n2MvEfsSp10JZ0g02t5358d9ozliHD9/vSSL+jQgLrHa9ko9bpAcVZuZv+65yIO1VpfdUY0TzRd/AA1e/HMQJ16MNhHxaoBFrWwaPOVcaPhDG1WKydp7cXwuLUW8+qihTmAZRGHZvHcptGbm9ek+e2nZ4lCmue59de9FtcPSdZCo6Hx7yPoA5hIHgqkwfOp0ewDkiy4Ozg6vqKaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coKmKf1uV/UmtgEw3iiiUCmrb6EYE4NzRNH3xbLMWaU=;
 b=ppoKgnREc+t6yKIfdB2dD3hPn05wYACs/XGm/cKJzanHXQGDZt5I0lSYhZnTU78tgentyNguACMJxrT7SKxVHbOpns8aebt/42/PliRjA303RIhpPM2HsTixc4xVJB474wGeO7MwkJuPtSkQvvUAos0vStwL5agqH2geOkDmamg=
Received: from BL1PR13CA0243.namprd13.prod.outlook.com (2603:10b6:208:2ba::8)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 05:18:45 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::ed) by BL1PR13CA0243.outlook.office365.com
 (2603:10b6:208:2ba::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 05:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 05:18:45 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 14 Sep
 2025 22:18:41 -0700
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <stable@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Naveen N Rao <naveen@kernel.org>
Subject: [PATCH 6.6.y] x86/cpu/amd: Always try detect_extended_topology() on AMD processors
Date: Mon, 15 Sep 2025 05:18:25 +0000
Message-ID: <20250915051825.1793-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025091431-craftily-size-46c6@gregkh>
References: <2025091431-craftily-size-46c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: f59b441e-2074-45f1-8957-08ddf41757d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VIoA7FTUwF0nk5A6/kGrNEJicGAYYUFkyuuTtfeOtR7j2s50dh9jvzxw2Oel?=
 =?us-ascii?Q?mwtDO9g32d9CYU6hFHWEh3WcQtFP3+UHqmZxxIvFHnBMS0IE1Utmpl+XmYc8?=
 =?us-ascii?Q?gY6d5CXgvevI80KbCR3htNeY78/jY0GPtoinusaS/uhDzyR+StWa6ZhkrEO8?=
 =?us-ascii?Q?7DMvQpq1VsW600znn318iw70KTrPrUkQzlYLF7b7aXrEaby95LucZwqw4d2W?=
 =?us-ascii?Q?fPr7VEFPxOYN+aEQS9m7ZfazUVmvuXuKwRZFr1DbUsvaoTHUSqJ0304YcWOO?=
 =?us-ascii?Q?TS2yj8jcvEq58DgHSrYNhV7oc2PKezmwMobdALXY2qicr3n2QkEr5dypLBm/?=
 =?us-ascii?Q?H3SopNO7xfWHzvFzaDMqwQo1bHN6rTChF7vAsiL8zZUsTqu43XQe/BzwwWmv?=
 =?us-ascii?Q?Uqn2SOxjSEihujQK4DFm/daclYmTsCIMvAevI9IJT0dSroD9eEqfdbFpVG0h?=
 =?us-ascii?Q?KpZi9NYsTs3YBKEGjx/+/ZeYU8Hy9UFz0f3YjHevrE3aQyWgRnhANsuK/4K1?=
 =?us-ascii?Q?wJuVIAExwAQV7JynBd/ZymjKgaQFHz4ph4t5aaemuN+7X60rABnZOU7S2sYm?=
 =?us-ascii?Q?gZ/ewgZFM8hSE6bdUejtymRwVxS9I6Z/hz706tTsM0Hw4WIjNTh4UjX2qrGI?=
 =?us-ascii?Q?1nuhKhADO414QLeJ0X4v5QW8a7Szp6OTU+k4IYp6pfg0VNzZdUpcvm9nTrBF?=
 =?us-ascii?Q?7nbNdaKH5NmYLlarvqwb/uByY0kxEBqb71fGqdKgW4yLTAhMbP9p0GQAJ+Jm?=
 =?us-ascii?Q?odQE+GMazAuJ72tx3cR0QnTKG4k9POkPQkyUqwDinr7b/tgeTH3q6kprcbE7?=
 =?us-ascii?Q?6aqOqHmSuZJqGs4VBTeA9hh3qBipw7wG26pcAU/4LVCALLS+zSDYQlEKj4bU?=
 =?us-ascii?Q?YqKS4G9Iz4ydzfBUvcTvNOIj5FnJ0YAPQN3YnzwZd4jstDUzE1okSnNzv6SH?=
 =?us-ascii?Q?WxtE+ZUxUAWJU8FUxBchM5kI0VTa3qOnmJ6jd48O0e/JLbL9qAUqt3HyGXRH?=
 =?us-ascii?Q?wJjBqSmyMPARjV5Uctuz1fjZJ6y3OKTe8E2tqoszW1LSOp0wuHuDhTe2lfCt?=
 =?us-ascii?Q?wKZrAZF41Tz5odM8RYaw1/tuKH2rniW2xPzDBCqLeLmvR/a7UFkUINVgnMfK?=
 =?us-ascii?Q?NJe+BLEpvx45eIHNqSQlE+1KAvVgwUptlmlxMAl/2yxHaHADA+iYXJnK44wC?=
 =?us-ascii?Q?VbYGv2vv/CV5MBm0cPrrICRHt8l7pTYDwreQUm5dlaLGaz+779a070yPZH4u?=
 =?us-ascii?Q?Rear5QbD3eujR757C5xpBD+kSIZmGwQUjJs3X5n2WntBd3HZE/uvRSWgZjR7?=
 =?us-ascii?Q?4j2d1VGMkRUkl6w417P7njkAKB7d5HJZaqaTspAqQ6AdsPCQvvW6E6/cwHkQ?=
 =?us-ascii?Q?Ab9VcrHJvxMGsfuUuYO75sD2pNh1h/BVooDy+6p8C4scwYaoTgPeygq2oeWs?=
 =?us-ascii?Q?6PsjSCg1mGRJW8FB36R4sOY+AXtBcbeaxoN8lOtFtxWaaXtl4SVcKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 05:18:45.0846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59b441e-2074-45f1-8957-08ddf41757d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

commit cba4262a19afae21665ee242b3404bcede5a94d7 upstream.

Support for parsing the topology on AMD/Hygon processors using CPUID leaf 0xb
was added in

  3986a0a805e6 ("x86/CPU/AMD: Derive CPU topology from CPUID function 0xB when available").

In an effort to keep all the topology parsing bits in one place, this commit
also introduced a pseudo dependency on the TOPOEXT feature to parse the CPUID
leaf 0xb.

The TOPOEXT feature (CPUID 0x80000001 ECX[22]) advertises the support for
Cache Properties leaf 0x8000001d and the CPUID leaf 0x8000001e EAX for
"Extended APIC ID" however support for 0xb was introduced alongside the x2APIC
support not only on AMD [1], but also historically on x86 [2].

The support for the 0xb leaf is expected to be confirmed by ensuring

  leaf <= max supported cpuid_level

and then parsing the level 0 of the leaf to confirm EBX[15:0]
(LogProcAtThisLevel) is non-zero as stated in the definition of
"CPUID_Fn0000000B_EAX_x00 [Extended Topology Enumeration]
(Core::X86::Cpuid::ExtTopEnumEax0)" in Processor Programming Reference (PPR)
for AMD Family 19h Model 01h Rev B1 Vol1 [3] Sec. 2.1.15.1 "CPUID Instruction
Functions".

This has not been a problem on baremetal platforms since support for TOPOEXT
(Fam 0x15 and later) predates the support for CPUID leaf 0xb (Fam 0x17[Zen2]
and later), however, for AMD guests on QEMU, the "x2apic" feature can be
enabled independent of the "topoext" feature where QEMU expects topology and
the initial APICID to be parsed using the CPUID leaf 0xb (especially when
number of cores > 255) which is populated independent of the "topoext" feature
flag.

Unconditionally call detect_extended_topology() on AMD processors to first
parse the topology using the extended topology leaf 0xb before using the
TOPOEXT leaf (0x8000001e).

Parsing of "DIE_TYPE" in detect_extended_topology() is specific to CPUID
leaf 0x1f which is only supported on Intel platforms. Continue using the
TOPOEXT leaf (0x8000001e) to derive the "cpu_die_id" on AMD platforms.

  [ prateek: Adapted the fix from the original commit to stable kernel
    which doesn't contain the x86 topology rewrite, renamed
    cpu_parse_topology_ext() with the erstwhile
    detect_extended_topology() function in commit message, dropped
    references to extended topology leaf 0x80000026 which the stable
    kernels aren't aware of, make a note of "cpu_die_id" parsing
    nuances in detect_extended_topology() and why AMD processors should
    still rely on TOPOEXT leaf for "cpu_die_id". ]

Fixes: 3986a0a805e6 ("x86/CPU/AMD: Derive CPU topology from CPUID function 0xB when available")
Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/lkml/1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com/ [1]
Link: https://lore.kernel.org/lkml/20080818181435.523309000@linux-os.sc.intel.com/ [2]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 [3]
---
Hello Greg,

This will need a review from the x86 folks. Once they are okay with
the changes, I'll attach the same patch on v5.15.y, v5.10.y, and v5.4.y
stable backport threads.

I wasn't sure what the exact procedure is when the backport patch is
different from the upstream fix due to large changes. I've retained
Boris' S-o-b and added the "commit
cba4262a19afae21665ee242b3404bcede5a94d7 upstream." message nonetheless.

Let me know if any of this should be changed and I'll send out a
follow-up version.

Changes have been tested on Zen1 (contains TOPOEXT but not 0xb leaf),
Zen3 (contains both TOPOEXT and 0xb leaf) and Zen4 (contains TOPOEXT,
0xb leaf, and the extended leaf 0x80000026) based EPYC platforms.

No difference was observed in c->x86_max_cores, c->x86_coreid_bits,
c->phys_proc_id, c->apicid, c->initial_apicid, __max_die_per_package
after applying the patch on the above platforms.
---
 arch/x86/kernel/cpu/amd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 864d62e94614..3c247ea85d8b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -391,11 +391,20 @@ static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
  */
 static void amd_get_topology(struct cpuinfo_x86 *c)
 {
+	/*
+	 * Try to get the topology information from the 0xb leaf first.
+	 * If detect_extended_topology() returns 0, parsing was successful
+	 * and APIC ID, cpu_core_id, phys_proc_id, __max_die_per_package
+	 * are already populated.
+	 */
+	bool has_extended_topology = !detect_extended_topology(c);
 	int cpu = smp_processor_id();
 
+	if (has_extended_topology)
+		c->x86_coreid_bits = get_count_order(c->x86_max_cores);
+
 	/* get information required for multi-node processors */
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		int err;
 		u32 eax, ebx, ecx, edx;
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
@@ -405,21 +414,17 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		if (c->x86 == 0x15)
 			c->cu_id = ebx & 0xff;
 
-		if (c->x86 >= 0x17) {
+		/*
+		 * It the extended topology leaf 0xb leaf doesn't exits,
+		 * derive CORE information from the 0x8000001e leaf.
+		 */
+		if (!has_extended_topology && c->x86 >= 0x17) {
 			c->cpu_core_id = ebx & 0xff;
 
 			if (smp_num_siblings > 1)
 				c->x86_max_cores /= smp_num_siblings;
 		}
 
-		/*
-		 * In case leaf B is available, use it to derive
-		 * topology information.
-		 */
-		err = detect_extended_topology(c);
-		if (!err)
-			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
-
 		cacheinfo_amd_init_llc_id(c, cpu);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
-- 
2.34.1


