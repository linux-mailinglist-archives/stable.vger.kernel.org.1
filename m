Return-Path: <stable+bounces-142071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6BAAAE2DB
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88E77A2CC8
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF571DE4F1;
	Wed,  7 May 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZgyAPzFG"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EEC20330;
	Wed,  7 May 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628149; cv=fail; b=BFVqAhAkh17/ZYArQPORnr9HNQa6B9k/Eh1/JI0hQ97WYVqvlP1cu3/CCrmE9Yxzp6ErTPdyMwdhqzRScxUD3AKqElfwznKedReyxkZpSg90jQBJs1i3eoT66K7swk+So84mWxGQMrpz/8KZ3+orcaFSc1jINHEVo4Q/mrosSBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628149; c=relaxed/simple;
	bh=B0xA/42Bm7jO9YXoi8JN70rqgUDWe9I8puYBYX6MzIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpCxDSdOu1mRRK8v9xA9p/qGq40y03DGNmX7xSc7T32zZzcvYEETlSWZIkVs9JF7sBhFfPJMNXCpuecUM8ZRQaMV7Tg0rSEuETQrNqAJKg6dmoM6wQ0G/gjnMBUO+pmEAw910A0svmLGiIcSPEuBC8bEwT9rh5+RfIYANfHVCuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZgyAPzFG; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndT0vwq7eGJ5RXttCwxLGTmn/IEKn5DTiUw1uCmB7vjUGEHu71XsBHyjYBP1si+zfecHiKbhYmMvk0B8JdRQqRz/uovF6MYJu8OHbQ/yR6I9izmweAjYbYTvxnME2pcaM9NOlTpjPxLTqFjTVlsicEVPoDzcwxC7cD4HjCua+x602SXZ7/J0uUHNzomFkDelKu5trbKOYlI64+juqAQVAgsKF5MCD4Hb52p4+5rC2Q89Y86BscC84c44W6mJHH3pVLqE30x+fOJvk9coXPNCBNxHWAUSDFOlfvXnGa3jUlOBWsemYsJ2X1UEujB2Rtf0bkbOqLY6ErMKCQyhNybH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFiiniU4wbhX+c9PA8HFfmfY8OGS1QCA5pwxt92/x2E=;
 b=ZbiWYVJPFoVDqtS/segyHHVX1NLFPxJ85QnJLANudz/wLslzmN2SlQFwXH+esKYYxkdjnJiVSaH3F5Rdt7Qne+SsPeER5y0MbV9ZK9dJUbrBoB5bIc9eaAgAi1Gt1ZbCszxlR9oRLG31y3adeLS988+3lweMDkgH4T4FOxdA53eWq7H8zrbvOsMmTFK6Y0QYlWre/aWdqxs2pXxpR9a8yaqIEsOWEKycWP//8qlk5Xo6rUA2QJsyMuFmK6l28PkFMapX0CWqOm4tX/6J7vF7MAtPR2+QCX5xYElPAqJn4/Lo8p5hGTKTMAxjEnd1Oy5aGDuOoQI4XKKDaRQNSRn8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFiiniU4wbhX+c9PA8HFfmfY8OGS1QCA5pwxt92/x2E=;
 b=ZgyAPzFGrixj7odML0AqBe4oi0ORZBLJ51lp6+QiDInlMgSvXAHayXh9uuKMxhu0EAkIA5rkTzKgS6/JSPMFYLj+7ww4whwN9DsdQGqfCr0Rq5SX7/ybuCDs4z3CQO6OwDQ+kJcmiBuorxDk6ej95TbNRdn1atCQhXofjwoWvcI=
Received: from BL1PR13CA0357.namprd13.prod.outlook.com (2603:10b6:208:2c6::32)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 14:29:00 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::4c) by BL1PR13CA0357.outlook.office365.com
 (2603:10b6:208:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 7 May 2025 14:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 14:28:59 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 09:28:55 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, Stephane Eranian
	<eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/3] perf vendor events amd: Remove Zen 5 instruction cache events
Date: Wed, 7 May 2025 19:58:27 +0530
Message-ID: <43325687785a80f6b8860f79d9957e484f36ef48.1746627307.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746627307.git.sandipan.das@amd.com>
References: <cover.1746627307.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 505eef1a-03d2-4469-c434-08dd8d738207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BLn8yqdVTaBvQR514ackK0iFyzzMG2fwOzfLbqnCV50ngdNF/SXxZsi6yV/F?=
 =?us-ascii?Q?SFeJr7LEZ+E/x/iC/IX3C0sAkhJgP+VukwDFHidelt0H/FgYDqPxDmi2+HEi?=
 =?us-ascii?Q?VZO0EyCvFaBFeNaKSsdI6wp7iudI1C2+k6NBho13G7UL5UIzw5EuPL4ZeDwK?=
 =?us-ascii?Q?eA7vD2YMu6Br2tVjbSGxt1HdASnqDM8fuFiYmEC+HenUU5gIRpiwWC9XAu8l?=
 =?us-ascii?Q?Lo1/TuZCZ3M54x97tvElFrJr5t3BvGJI2OtSN6Cl9NAj/GWvR42k28EQvLd0?=
 =?us-ascii?Q?7NrVusQL90kP35NQ6xGDz2HgJpZUPLB4uSoR+RyETvKTKQiIjH1r0CgI1deD?=
 =?us-ascii?Q?CBCmwA898EuhbmIwSOWWjKYO/bS/5gYxsz5Il/d8mttUJIDaRFwov5f5GTGH?=
 =?us-ascii?Q?SwhmK+eQ+D8OYT2qq6ZqXSmqs4DlnbZBlqQ2xTEJ/Iue8/QvrruTFxcLbXCQ?=
 =?us-ascii?Q?gUt+NM/yfNQzTHy49tk1/Bb4cuIjNANBXnhvTh8t+jmJTz+LR0FUrgnYjzLu?=
 =?us-ascii?Q?8Or6Wx6U0CR+mETkh4zsCUAM/bm27OEJiMsPWb07QtR7Yincgk848RkTHD+6?=
 =?us-ascii?Q?ZV1o9AtE74U9l1nFXuOHSM6QuMsCYRgAeqQ0DZLSdZb5nzqdw4va4nTmfe/b?=
 =?us-ascii?Q?jFvUUI3wq9r9d+6n54qhPvfLh8Ir+e56ozJv4MYO32t3nOB/hxsiql+0pMyW?=
 =?us-ascii?Q?2QxvabHK5xtm6PnErkyHjgr2fJ3JZcDvigCxixAfSxxFvpsysPMW9M6L/+DG?=
 =?us-ascii?Q?x664jEKSD7xNhm63BWfjyE6y0Isi04nfR3CUTdi7DBrdQ8FVilpG9865EGgD?=
 =?us-ascii?Q?n58wXS2id/92f0HTz7J1Dr5U4rNaFDCwKNfQ9YGyNfmXjiZvsCigldl6JxkI?=
 =?us-ascii?Q?4/FJhWQTmmmNJpuu3W2h4mC0p6xCD0IubB3elN7epghVEkZSB+GPQOTGEmhv?=
 =?us-ascii?Q?j0Ld8QwqYq9BCHXbLAAZ6dvvxpftSjudq/l6lKtcFn3EwcTiwGkb0cvMkhjM?=
 =?us-ascii?Q?4ROfe/5f+DkmjxRR0s2Ym9qVnDpeUCUbZY7KtLcunERjVg5+30C7fEMASt8c?=
 =?us-ascii?Q?6zfs1NE1i13P/Ub4Ewq5+a6LTS28f8NGAUxIgkqzIkBt44Nyc5L9TNDfdClI?=
 =?us-ascii?Q?HdVK4ar3/lr57+u3K2awMHwaL4EdG7bVd6dyoq+1dMUWrDmjaJd3h/dtm0EC?=
 =?us-ascii?Q?kRx0A+PRHOBxtxUA8LYb9KoLSVexDZr3f/zZi8owsOEbBP4fGU14E4BNniRm?=
 =?us-ascii?Q?zUojgREaQ+Qp99VUtqtUE2N3sNRhd1kdBl+bBv44OXnkANuqqcLu0eJ+PFd6?=
 =?us-ascii?Q?4ezK9i2WE7WK2bXyjtJFAKdgmxGbEVDYNUHuVuu1WLyTyZbJAVUaRxPPq4Az?=
 =?us-ascii?Q?sjgQw8iw5j0x6GkqeyMU3MbUsM4kb8lxIIjzy6YcTUY3mrHe8dA6elP339ae?=
 =?us-ascii?Q?WiVq6iaWRNiwMeTWOwxEGH/USjfvoH+wmaiyQK8Xur1z+LnfY3QV4t4Q9/pn?=
 =?us-ascii?Q?sRQuHHqOSZNB8T1d/z2zpj+sxusyKnphFO6ACub4s9auWFpxym5SACtCog?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:28:59.8340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505eef1a-03d2-4469-c434-08dd8d738207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263

As mentioned in Erratum 1583 from the Revision Guide for AMD Family 1Ah
Models 00h-0Fh Processors available at the link below, PMCx18E reports
incorrect information about instruction cache accesses on Zen 5
processors. Remove affected events and metrics.

Link: https://bugzilla.kernel.org/attachment.cgi?id=308095
Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Cc: stable@vger.kernel.org
---
 .../arch/x86/amdzen5/inst-cache.json           | 18 ------------------
 .../arch/x86/amdzen5/recommended.json          |  6 ------
 2 files changed, 24 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json b/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
index ad75e5bf9513..4fd5e2c5432f 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
@@ -33,24 +33,6 @@
     "BriefDescription": "Fetches tagged by Fetch IBS that result in a valid sample and an IBS interrupt.",
     "UMask": "0x10"
   },
-  {
-    "EventName": "ic_tag_hit_miss.instruction_cache_hit",
-    "EventCode": "0x18e",
-    "BriefDescription": "Instruction cache hits.",
-    "UMask": "0x07"
-  },
-  {
-    "EventName": "ic_tag_hit_miss.instruction_cache_miss",
-    "EventCode": "0x18e",
-    "BriefDescription": "Instruction cache misses.",
-    "UMask": "0x18"
-  },
-  {
-    "EventName": "ic_tag_hit_miss.all_instruction_cache_accesses",
-    "EventCode": "0x18e",
-    "BriefDescription": "Instruction cache accesses of all types.",
-    "UMask": "0x1f"
-  },
   {
     "EventName": "op_cache_hit_miss.op_cache_hit",
     "EventCode": "0x28f",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
index 635d57e3bc15..863f4b5dfc14 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
@@ -136,12 +136,6 @@
     "MetricExpr": "d_ratio(op_cache_hit_miss.op_cache_miss, op_cache_hit_miss.all_op_cache_accesses)",
     "ScaleUnit": "100%"
   },
-  {
-    "MetricName": "ic_fetch_miss_ratio",
-    "BriefDescription": "Instruction cache miss ratio for all fetches. An instruction cache miss will not be counted by this metric if it is an OC hit.",
-    "MetricExpr": "d_ratio(ic_tag_hit_miss.instruction_cache_miss, ic_tag_hit_miss.all_instruction_cache_accesses)",
-    "ScaleUnit": "100%"
-  },
   {
     "MetricName": "l1_data_cache_fills_from_memory_pti",
     "BriefDescription": "L1 data cache fills from DRAM or MMIO in any NUMA node per thousand instructions.",
-- 
2.43.0


