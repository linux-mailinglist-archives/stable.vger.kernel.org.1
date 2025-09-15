Return-Path: <stable+bounces-179601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20394B56F8E
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 06:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645DC1899243
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 04:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B0227056D;
	Mon, 15 Sep 2025 04:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ParPvsxQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657642AD24
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 04:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757912333; cv=fail; b=RvmYptc/r3ymDlCM5p/XvTLMhTjI1mo7/KHSzReFQ57H00vChj6wpnI66CIFne0NS6HpHygtBzA/C1H2Q0zo0t54Mz+zy3vVBMuAcbM/Q4g/JL30UDY0eaMN7HA4c0TTUQLqjE+fZKaNjTraAB5vUC4JbOZQTeZL9O5th60oSQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757912333; c=relaxed/simple;
	bh=jgL69+Dip9FG9pH5K5Z/OMo5uZ6KWkuJhz9adhdS8hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKHiFEDbMeZ7lHo2q2j0sVZ/OUTsUfMqGzW+bck67e0DC0eRcxmMs0sYScblgJ4ftwBhWUDcJD8Un8KXPRdsnqmuPy8kNoMgpLtkh3AmKC1qECSUNMvnLuZsjBTSmsMQZ4wCbjv1Qc+hftcfG1osLvvFgdBQo0ZO9VP7Uay3ih4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ParPvsxQ; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urFJD3CycBu5C+CuCn+ESBAGO/aa01Rw+FDwke4tRX9TWVFj18zKebk7/slLKFgro4m9byVGgamplQI/INl7sk23PCZKpAtrCEffTD63EqSpaMTkhpiSdp3kvCUG+OdVFu3Dmf/VkAEYRabIdupTJz0J+i2VMi6G//h5xmlsT5Kp+8MNWEyoc8X5yH2mZF16n8M7Rby8WQjVBRawv7OjxyhNoknFovRh8ryavxs2ia4oxfAvJpJXpL0EXbgxzjXtljD4dwQz/oc7CI9L4d0cPNoPNN+s2yhmz3rPf6hEk1ko4s5mQ1miOM8PLZ3tW6jAaARA1yBYEy26+cHr6BeFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkLhab8hRCrUaB2kjTPN/ZFf7VY1phE5E//j3ghXvfs=;
 b=bAtw0kJGM3eWdslIf0ov3tm9Lzt6yQdRU4Qlx2sm05aCpN7EiiJjP3ZNIX8hd86TOVkGsJ4nztfnVu0Pll9sBu1MWOr29EjCHgV9s6u2g+PB3Mo7h8aZnT2rVmh47eblzYr/2XL4euMwAeGCwtyVeGEF/ikGR/NJ5kkLWgRnhRyOnux400pm22FjgVclwcFu7nYNNqjyiHrbQCuXNNzY2wK/Zjo5TMLuJ9e29LJ2g6dT7xybi3ca2t47PgdinT8KtNmYUsabcdzvePx/344aTP5UVMtz5+cHawEmdkS2ZlZ8eKYl9NRZzbglTf8A3o2rJ7JuvqygNV80M187BhKtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkLhab8hRCrUaB2kjTPN/ZFf7VY1phE5E//j3ghXvfs=;
 b=ParPvsxQnGwxiGlFbxh0ZYEhrkagZY5XWokffEhS0tDnNBTEzp5Mw+KU92FTEu5JyMbPYM4wt6rpjTM1pF5Y6qnBFRRFHMCjf0rXf62wznEipLUtEkbYFnW9ygS6pP7zCOCW47PlmpICm2O8fNwJr85cbbq7uCOwf0ddA4GZMg8=
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 04:58:47 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::dd) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 04:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 04:58:47 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 14 Sep
 2025 21:58:44 -0700
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: K Prateek Nayak <kprateek.nayak@amd.com>, Naveen N Rao
	<naveen@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH 6.12.y] x86/cpu/topology: Always try cpu_parse_topology_ext() on AMD/Hygon
Date: Mon, 15 Sep 2025 04:58:17 +0000
Message-ID: <20250915045817.1622-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025091430-empirical-late-479b@gregkh>
References: <2025091430-empirical-late-479b@gregkh>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 398287c1-8f13-4563-dd6f-08ddf4148df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WDO1TZ0djNZcdPYj6xbs5sxqlSEUg0+E5vL9pKHBaSUHChvM20IAYnONJF/d?=
 =?us-ascii?Q?XO8YV4WNpsw4ug8R7Xa69HLsrVKuEUjrMw/yQsRysnIWpki/FLA2NFvZPmTl?=
 =?us-ascii?Q?5k+ffICbwxpDiHRwuGEwOCBxGCZm0MeySz0z98P659arykJK+EXFS6xJxxSt?=
 =?us-ascii?Q?3BaSfJiZ5JhmVfiTo/9B+pRZImv76JSf1WJOCUNBkhZ3bnaVT5l6IPKexoOw?=
 =?us-ascii?Q?kmdJNh1gFqIRNC74xbHMBV3u8qinaoupGiv9DXJG+95a9ogMakPlHXBlHvTg?=
 =?us-ascii?Q?Lqt0WXk39kttVc2exkd01x6dWg9OFY0+5MrpkGW6OBfM4sngghZRO7xjarcb?=
 =?us-ascii?Q?9rHM5n4CGUBZy1RYVJP0PkMCDQ72SIPpjN/F+y6NkUUEGmC959oO5YsSwVdq?=
 =?us-ascii?Q?4LtY2Q9nps1DjzN06F495e3c1tXV2DCrfUt8XmyG+fuQ6QXIyEzxEFh+n6MI?=
 =?us-ascii?Q?tSiTXCjENBvBClYlTKl8IK6JkzRMoeKvSAwCQwo2+TUcZxKGQYtgiq9/eh7V?=
 =?us-ascii?Q?/uF0s26KYANv1Akd5jM1mZy9+PlP72lq5EEybQX1EqbMazq4V0jKw21Aj6WQ?=
 =?us-ascii?Q?nTxhZDqd7i9+wLJfrpUYCseAbOn+kcy4KYYEZfc2TEtigr0Mjjv+28PS497E?=
 =?us-ascii?Q?4aOthgDzKiq0Qp3gPvuTN7pWiGCFfJQhPCYdWmyRN+oUBsDGOrCZcbHIPFHG?=
 =?us-ascii?Q?kG2y6C+a8dd09lvkjf/HPfwgHcKdZLTStX0hEYHIPVIG85zSMJqYc4ku2YD8?=
 =?us-ascii?Q?4hltzCvC9vXyB1RHy/r7iQn+LB5hiGoFPNwh4BVGQot0QQOyp4lJhEDSo7+8?=
 =?us-ascii?Q?1clQs2jtqRhz7tW5rG0OuyJUnWWVDMTkBpGlcBF06Z9keU8rCCEBxCmpcvnY?=
 =?us-ascii?Q?cyMtKwx1vQu5L+7b22ZyCUFQsSYO45rPBsVa/WXoTrArQAc/hhGiMW6AbCGi?=
 =?us-ascii?Q?NFwdJYHNVlEfvmONHdIc7QTWuOyvRhSwk+efcThiGIqDQPisam3zbJL1XNTx?=
 =?us-ascii?Q?U5aOnbOMruwYSGvjmCSSNsgQL/wyixeaYRJJyoxSJocNCl7T3YjC8cD0F7IA?=
 =?us-ascii?Q?U1qsV61OCPG9SR9+Z0Fp543c2RUsfs30Q3Acv5+iWU7FVWb49qLBtqzhElRn?=
 =?us-ascii?Q?ZmYOrP7UwXYI82ODoaK9Bs7xNa2xmOJcP3myntxuyCdcrciICFJA8sZzjvqY?=
 =?us-ascii?Q?+bE7cr2Mjp+t+uWrFNjC0bYYxV+0fPDnH0gGFc83Al8fGvavXeFv3i5AsKXn?=
 =?us-ascii?Q?xl7LQcABAzay0c9XIaxoO6ybGKxSg7NaJC2w/x9RSbjNxdtDpVYcSf65M4j+?=
 =?us-ascii?Q?p4B8CZTLMPOumSEgAm28gZicEnIVZxY3wNX/of2S711P30fVSDi4wA2RTqUK?=
 =?us-ascii?Q?XB+mgu2zP/+TZPrljZDANrmEcJnytU7bF9eiWU394tbDpAzFKvPHZUl/jT/v?=
 =?us-ascii?Q?RiOOynwqSWfQOyV+oSTndgWmtfNvZ2EW8ZkfeYpfflDkFsz8lJzxapGtlT4U?=
 =?us-ascii?Q?Hsux++dG+rBg68o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 04:58:47.3569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 398287c1-8f13-4563-dd6f-08ddf4148df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B

Commit cba4262a19afae21665ee242b3404bcede5a94d7 upstream.

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

Similar to 0xb, the support for extended CPU topology leaf 0x80000026 too does
not depend on the TOPOEXT feature.

The support for these leaves is expected to be confirmed by ensuring

  leaf <= {extended_}cpuid_level

and then parsing the level 0 of the respective leaf to confirm EBX[15:0]
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

Unconditionally call cpu_parse_topology_ext() on AMD and Hygon processors to
first parse the topology using the XTOPOLOGY leaves (0x80000026 / 0xb) before
using the TOPOEXT leaf (0x8000001e).

While at it, break down the single large comment in parse_topology_amd() to
better highlight the purpose of each CPUID leaf.

  [ prateek: Resolved conflict with X86_FEATURE_AMD_HTR_CORES enablement
    for stable backport. ]

Fixes: 3986a0a805e6 ("x86/CPU/AMD: Derive CPU topology from CPUID function 0xB when available")
Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org # Only v6.9 and above; depends on x86 topology rewrite
Link: https://lore.kernel.org/lkml/1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com/ [1]
Link: https://lore.kernel.org/lkml/20080818181435.523309000@linux-os.sc.intel.com/ [2]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 [3]
---
Resolved conflict with "X86_FEATURE_AMD_HTR_CORES" enablement upstream
which was introduced in v6.13 with commit 45239ba39a52 ("x86/cpu: Add
CPU type to struct cpuinfo_topology").
---
 arch/x86/kernel/cpu/topology_amd.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 0fab130a8249..78d05a068af4 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -174,24 +174,27 @@ static void topoext_fixup(struct topo_scan *tscan)
 
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	bool has_topoext = false;
-
 	/*
-	 * If the extended topology leaf 0x8000_001e is available
-	 * try to get SMT, CORE, TILE, and DIE shifts from extended
+	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
 	 * CPUID leaf 0x8000_0026 on supported processors first. If
 	 * extended CPUID leaf 0x8000_0026 is not supported, try to
-	 * get SMT and CORE shift from leaf 0xb first, then try to
-	 * get the CORE shift from leaf 0x8000_0008.
+	 * get SMT and CORE shift from leaf 0xb. If either leaf is
+	 * available, cpu_parse_topology_ext() will return true.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
-		has_topoext = cpu_parse_topology_ext(tscan);
+	bool has_xtopology = cpu_parse_topology_ext(tscan);
 
-	if (!has_topoext && !parse_8000_0008(tscan))
+	/*
+	 * If XTOPOLOGY leaves (0x26/0xb) are not available, try to
+	 * get the CORE shift from leaf 0x8000_0008 first.
+	 */
+	if (!has_xtopology && !parse_8000_0008(tscan))
 		return;
 
-	/* Prefer leaf 0x8000001e if available */
-	if (parse_8000_001e(tscan, has_topoext))
+	/*
+	 * Prefer leaf 0x8000001e if available to get the SMT shift and
+	 * the initial APIC ID if XTOPOLOGY leaves are not available.
+	 */
+	if (parse_8000_001e(tscan, has_xtopology))
 		return;
 
 	/* Try the NODEID MSR */

base-commit: f6cf124428f51e3ef07a8e54c743873face9d2b2
-- 
2.34.1


