Return-Path: <stable+bounces-211201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNVGMrnHcWknMAAAu9opvQ
	(envelope-from <stable+bounces-211201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 07:46:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C562551
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 07:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 764045263B1
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4334335573;
	Thu, 22 Jan 2026 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZUEDDCfp"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C3136672;
	Thu, 22 Jan 2026 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769064336; cv=fail; b=RO5VntRf4XmXuoFrYL6+7T28uI5e2hEKFgrpiR0djYihZAXT/B20sz154wIu3Y66FWn+mEoMGSKwn3yRhMSLSLTYiFC11kqLq0ZkMGkri4XwO2unF01XR2YdVzn7Q0nrqTusVNFLQtwLIOJynMivTxKvZDF/xfCN+E0fs63/1V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769064336; c=relaxed/simple;
	bh=mdoVbkck62veiolSqgREzH4sUcOvGJLkdnyjfD9iYTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KlQV9UiPLWHw1cgEDQxtc7WE2Vd2uhEK6cmA+IzIb4TMg8mVBYbfBudmBuOyLOMY1FMPacTiQuv58AuZa5NtvhNsYBMaI/mryaMX4+B/duY9jarKk8k1swG1Yi161PZh+fGFevVsM3xZ4ZVtfkCjcgLz0KByUpCm+SzH7IREkf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZUEDDCfp; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2JzotpARjmlkEhG8D62AN5fCwn6RyfnzcLLCdE8LZD+XznkYDq9WGD63NRAXONOSHbD9WC/YwYmyET/ROxEtOXEqOyp9/sZRcYeJww1Nuj7GhR5T270X5MaWPuU0Ih9be/IpLkPyV6x4bGL8WUKdNcs0to7X9Fs3yzC5uHVmAalUseU26AmoB9ygsjiDUl+kNW1NOBfCqUh67q81XixWNrEByf58fnkwCaa/zo35kO4a3HJ/4IRv1OUjmYzH0u19urcvRfY4kQ+56/CYKv5I73Oi7xuM21/RDiOXE13Cy3iITv53gpLHKJfkDmGWY2WGJeSRp7eqVh3VjHH/KYrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOYN2O2F66othUo8OnlsTbw8iRxjjQhRuiiNjAUL/9M=;
 b=hZMuhOhFKxsRC+TeEobtKqpVup8nVyfQh4I09IdbKMPH9X8L9Is2dOvUkHUVzfTMMyTklgBCz9SrT+qL612mtqoADbUFDRrBkZOveczY2m2+1s1gm5xfskI/A3YVJo6xu0lTqtPLyPXMO3NJb3TD49BL2LSZbM7APJWpvVDZA7Y73uiNorcITcSvbwndCRFN1DTEQIpr3vbxiPl+Fn6aZuO2t5jMX9cJ134d61T7qi4ohhqoAjw08F+HclfNbcheygl2HA9woveCBu6ChVC9VbNeQdD+9tkzrcQSisiLLWXd13Q5rLKbjFTcLfCCXcfIFWqaqzGXcFEb35B/29N4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOYN2O2F66othUo8OnlsTbw8iRxjjQhRuiiNjAUL/9M=;
 b=ZUEDDCfpW26ZJAR/dcMcNjSE/FgaWaz4HMguJcR9CMoONENxNx9okMPMFBaeR/ycJP6zCluyOogD+q6ydZVKgtOcO1iQhl7VtLXu0EQ43T+5kFkZpBO9vUPSeVAXgr5b+DPYKXJAs4kmTjsoiIW6OyQVo53UN8VeXL8ZPFGplEs=
Received: from DS7PR03CA0350.namprd03.prod.outlook.com (2603:10b6:8:55::27) by
 MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Thu, 22 Jan 2026 06:45:25 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::19) by DS7PR03CA0350.outlook.office365.com
 (2603:10b6:8:55::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 06:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 06:45:25 +0000
Received: from sindhu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 00:45:17 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	<stable@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, "Ananth
 Narayan" <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/uncore: Use Node ID to identify DF and UMC domains
Date: Thu, 22 Jan 2026 12:15:05 +0530
Message-ID: <f337ed92d3e3d519ce4b5d4f23616053ca8a1726.1769063941.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df230e0-db2f-4b3b-9687-08de5981d295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wqIQr0Gg5LoRmwicJvuHhoZOMBmhcm1s+/9EuxPyrtlRF5KSVEbT5fyUlLDZ?=
 =?us-ascii?Q?Qjwn61FiAa0q0in1M9mvXIY0in3AUKfDk8UazR2wDHqe5TcexZuJOasBcXfN?=
 =?us-ascii?Q?tiatdJv3cYP9hYAW9f/HF94zXy3Xy5gmxo89N9xCpc8wj70btLEplxP2OI4F?=
 =?us-ascii?Q?DmQhU2VxotzzIs3EFF3KEJQbOZaHmRfbTVj2U4vY0D41jCdqbt5Es7c/w8HZ?=
 =?us-ascii?Q?e5/oJmjf0tYaLUNcnNb2pFkxuwbgEejFSBGKCGtrAb4elZeQeG4HDOHR2hW7?=
 =?us-ascii?Q?PGOlZ5xnk4qMfrQ+WBGhyBNaio3hQ8/dfcXLruuqr7iJ5PX4iHR+F2l6OrLP?=
 =?us-ascii?Q?x7dMi8o9FsIELaaLIaYgIfPv+NU/G8Bys08o4vUsPYulsvqjH6BuJ6KLh+GE?=
 =?us-ascii?Q?hnUsqzHErjYhVhnNxB53blU3jteT9az4xijdB4ZmNM+ucq0JbNVyttiCO+2O?=
 =?us-ascii?Q?wLMR4xf7l858TltUutMsSbr8Uzsf2atFj0EPhO/UX9GxsHcjr5aHx/p7a/GF?=
 =?us-ascii?Q?mOBv97xoJ8sYLMToM5g7Vyq2PVm/AWokySkqrq5/OPNyA1TKFJOC6Dh9f6Io?=
 =?us-ascii?Q?t9oBi9Q8tTZ8wbOd4Lvxz+ilrOMTgKlrX2o/dsg5+z0fWXU9oKnJMkTEuLFm?=
 =?us-ascii?Q?lXijHnF+qraAV840x/QpgND+iUw18JtJv0siC9wp44szJF+ukJ2Ycf10FUBt?=
 =?us-ascii?Q?AItclJlY+h9w7/Q8qliMbdsv7g8oOKXve15XZG5iK9XY0Rumwx4GJ3iaCJi1?=
 =?us-ascii?Q?qBchYBGQkAm9F8PqKdsYHQDe9xnUvJzNj/ceNRGfvzoyYXqjKvY0Iqltql9S?=
 =?us-ascii?Q?O4h/69QnjbNTiyZAjQnlHyhyjSe7RQgT0Q2sStHT8ZIgVN19uhDNOROOU36O?=
 =?us-ascii?Q?5CrGlXfZIC2eJKt+ueFjc1jE/Ek2iH3hoWpK3oK8jCYaSCzd6rwlK/83vuH0?=
 =?us-ascii?Q?mjxYanEKm+kpeG6aWh6LTJZrbeAQFuONu5kCsYikx/RBDmtO8N6stn8nfuNg?=
 =?us-ascii?Q?iYmnaYky5ThoXL5JpT8teur3LEkkEo9DMQVFHGfKreSU+1tzAiq+PolLk8hH?=
 =?us-ascii?Q?hUPhN2T2xLQhnSTm9Xd1XOEl57V+ssGisQQ0E90JLSsJdAU61geTK6nZqtVH?=
 =?us-ascii?Q?7wVVNeuUWwhPMxatyUFDelSFps+4obOiLTEl2vfG6+A1uJSg7JmZz/2iYOLf?=
 =?us-ascii?Q?cCZ7r2yIQoD8PKbgratNegCXOdPlCuQb+xEwM+uzw9QuUATSsmQTJvsXvFU5?=
 =?us-ascii?Q?yYyPENd5W5I4BZ6eLYuIVH9YG9WoAglE8t9tKChVQBmvyyiukfiU9dfE3mFy?=
 =?us-ascii?Q?tkjjwA89lRDLgVznmAZcFwu1AJr95E6zuGobV3a5BfWEKdaTrp1YxarCtLPY?=
 =?us-ascii?Q?+kwsJVDA9pjxRSVh94RlV57urHcHFGNriHi7E9DgAZ3FnQTbQ8+vAu9O/6Sg?=
 =?us-ascii?Q?GVdn5HbMO46pbuz8ow39NpvHPagFR/m9J4k4qqiXGxXqdViYSuqplWSF34aT?=
 =?us-ascii?Q?zpIJ7Ri0AX0gtZ+Q/bm6a9XqLP5JU+Gihw+BocxNe6WBQnwyu5LvWYGWFM3j?=
 =?us-ascii?Q?xW+skFUDiZyMKuKRlqmDvWWM0NZZOTZprOlDJAPpKoUvobyYmXgAsptWzcLe?=
 =?us-ascii?Q?8rATaYVRAMPYjdIC2STqWmyllyeCuBuX3nLiHWaIa7FVIdecI0IYTlSHD+uD?=
 =?us-ascii?Q?3glqRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 06:45:25.0961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df230e0-db2f-4b3b-9687-08de5981d295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211201-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sandipan.das@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 736C562551
X-Rspamd-Action: no action

For DF and UMC PMUs, a single context is shared across all CPUs that are
connected to the same Data Fabric (DF) instance. Currently, Socket ID is
used to identify DF instances. This approach works for configurations
having a single IO Die (IOD) but fails in the following cases.
  * Older Zen 1 processors, where each chiplet has its own DF instance
    instead of a single IOD.
  * Any configurations with multiple IODs in a single socket.

Address this by using the Node ID available in ECX[7:0] of CPUID leaf
0x8000001e which is already provided by topology_amd_node_id(). Replace
the use of topology_logical_package_id() with topology_amd_node_id() in
order to correctly identify domains for context sharing.

Fixes: 07888daa056e ("perf/x86/amd/uncore: Move discovery and registration")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 9293ce50574d..9a13a9f21d2f 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -700,7 +700,7 @@ void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 	info.split.aux_data = 0;
 	info.split.num_pmcs = NUM_COUNTERS_NB;
 	info.split.gid = 0;
-	info.split.cid = topology_logical_package_id(cpu);
+	info.split.cid = topology_amd_node_id(cpu);
 
 	if (pmu_version >= 2) {
 		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
@@ -999,8 +999,8 @@ void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 	cpuid(EXT_PERFMON_DEBUG_FEATURES, &eax, &ebx.full, &ecx, &edx);
 	info.split.aux_data = ecx;	/* stash active mask */
 	info.split.num_pmcs = ebx.split.num_umc_pmc;
-	info.split.gid = topology_logical_package_id(cpu);
-	info.split.cid = topology_logical_package_id(cpu);
+	info.split.gid = topology_amd_node_id(cpu);
+	info.split.cid = topology_amd_node_id(cpu);
 	*per_cpu_ptr(uncore->info, cpu) = info;
 }
 
-- 
2.43.0


