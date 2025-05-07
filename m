Return-Path: <stable+bounces-142072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A6CAAE315
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32657524095
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBAC2557C;
	Wed,  7 May 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v2+qM9D1"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1D639ACC;
	Wed,  7 May 2025 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628166; cv=fail; b=dhu5X0YxPexT2KgYWhx6Ur9/5RMYwaJhGtmSCGKa1xIkrFyzXX6Lit4HpigLhYi1t794Fe1sOGg3FiPaOsBtXtr9fJ6DO9CKotPXzfIOrnjutIzPWR6snz9mY5GaTkmKrbF32kEx48P28noipiJIaDfJacl65r94K1HQzn5ksUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628166; c=relaxed/simple;
	bh=y87L18X46S3yuj3lSL4NnbGmaXu7Mh5shEDqMIPnDvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXQOTKRs4uYTc1K6ntq7/OsxzT9xoGmsxa2e0FJMseo/xoeDVP9iIMITtebvh7JPrfLKt1J32qBQDvjJHZeYD0uHAf+VmuETW/cCWxDAlmaZgsz3XuPU4P8bMjAXFEfN/t/1+XRwVAH+XNKNd8r7X+YwLfqCGECTsDseCQ5MgYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v2+qM9D1; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYEc7bxY7mAkCZoQ6xrI0/eMkhopQNQU0ENTDj4WV6f6aYw6ES6vienWPosTMufuPeGzufJXJEbt7krdtorl/HwglGzrVo97gkJphtQmIdEPyhI8taajEC7aTp8Bj+7cxCRghUUlGViOlrbnId+9X5vPQT7MyotXywBjrJfCE0i5ndowkQdYWkOmjHmAiEro7QJcdK9wek80FESsdF7x4gf0vtkkXCGxO6g9j73ySXtmAHup1F9QuAfV8JWG3Mz8ZdzrUhreUxT78YLRa+8jY4F2EId8EIIjWMDztq8Xs7qMsyXHrywKWfdobBQmevga/314FLHieOD6aqKz725fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n7Cyv0Iglcid8/Edjyd4SEEgkVv17UEREslMblo01k=;
 b=CDB5KdHFXXIXBGtKdIKcf1HybaDbm9940OtwU2TRqorrQ5cIExA/eua4cArBIsZqWBAIF36W8k3NaeG+tUk6InIO/d0HrMsnWVyHmFwZ2Y/scKMRy/Mh4fkRt8ZRn502SyrBeUp2IPHokJ61vUT3AyAtByrG6VILX6eyTONBE38yjUBABXo4BF2bTZN34NRBsUqLejBjQqb7/Jp79bbpCGBOoz1Az4XLry+H9FCucgXQbHq9v/E09/h/rx4g3/St5BiYs+o+jjM8dcgWAl+yB0fczDhVZcnERUlOI8NT6cUUu8Jh3s0XgYq6d1FSshzxgs85FpNkgzLw1TkTedeyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n7Cyv0Iglcid8/Edjyd4SEEgkVv17UEREslMblo01k=;
 b=v2+qM9D1MwxW+G1s8m2Cv1rrv4AO9ek49qshCleBq76xAXHgsqL31VGuqfu0g0Ep2KMFpbw3r5Abwo8/Xd7oeuIe6RKG8rujM6x8X9pmECLoRl/3A7E8zjD70nxP5JXSXVHC76tGPGhu4qUNw4Ca8W/3ztbEFoICFDDAd11dnOo=
Received: from BN0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:408:ee::23)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 14:29:17 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::80) by BN0PR04CA0018.outlook.office365.com
 (2603:10b6:408:ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Wed,
 7 May 2025 14:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 14:29:17 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 09:29:12 -0500
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
Subject: [PATCH 2/3] perf vendor events amd: Remove Zen 5 TLB flush event
Date: Wed, 7 May 2025 19:58:28 +0530
Message-ID: <a37abb53e540f3375706a6d6877323ba950ee6e3.1746627307.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: f4985359-dd86-4df8-67e3-08dd8d738c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BAhFvj3jJt5CksmpnTOrpK8+7ubDmgHRG+qesvC2c++q/J4kfeasmMgh/6uT?=
 =?us-ascii?Q?Nb6W7pKL/GJFWG0Tq/tjdZCsl8AJYbnw0a8irNZHukoF89DcQ0c1mL8J8BW/?=
 =?us-ascii?Q?NaYkjgvPwj7/UEXT+fAiJd4LwASvf7LVnUiOaFWrHT5IVDSgzH8OsY/wM4yr?=
 =?us-ascii?Q?pJnHvLs3KoZARhCpIoHRxN7nYrdkuIQ3Gb0h9WFbWCnv7gH77qtWOUvqgWhF?=
 =?us-ascii?Q?7K8O4vcFVxdOZy90cevrBBUgt7kjc8CC0JjjAJKUjqSRy8k5OQn/yzvy+vxR?=
 =?us-ascii?Q?ulpbumPLESeiSw/3igVbl8ivrJtl4xg/ZOpG88GsTaOFKiQZlQkdbqdr3CCB?=
 =?us-ascii?Q?OBEK2K3itSolW0kfod2TcJWIIWPmSy+ZK87j7sqt8HKV9hGEFtBojT5KyZBx?=
 =?us-ascii?Q?Uh7a1igiYPhkKsVlw8qSMqyWBd8hvkWu0UuJuw9rCV1nnkwqavlmaDcQ4xau?=
 =?us-ascii?Q?TTHLcO0+A/VCrC4M6O9uModcqGLtC3uAREO6/+9leV7WRWcXFYGPXjYEozKu?=
 =?us-ascii?Q?p4SSjMtxnoL8Dgm2FqEBTwTsRVA7CQZfiZWuH70q6jkc+bXJ2k2PdYvkastt?=
 =?us-ascii?Q?cFnrrhjOIMDv9ptd1If0cGIMOwGtGusNAMSuH71cww3pm9Ng9mXUOPPp/bu2?=
 =?us-ascii?Q?eo/HuIwY32V/lomcKVW1OJ5OIMipOIrLvdo6GWsWvaNleYiIm7TVot8SaC6e?=
 =?us-ascii?Q?sWhtFCEOGcoYBTdDCqYwR1tSUKZfLhQg68QDi5SZqTP05R12xfyKrTuxsOkj?=
 =?us-ascii?Q?Yf/In6b28tINwu+v3jzPkmAyHNTfkrt6M7RDUHxpM7aN0qOSveo7KzTxXq1H?=
 =?us-ascii?Q?f5kflRWCX3m3WeREPBVj0OXnILo6dmso23KMimSrgRhK2V4pNdCrMWen0nMp?=
 =?us-ascii?Q?HLs4ZZJLJVrQI/1rCLETgIDVBTeWNPEcA+4cURGAy/+cKYnwgpg88nzf65o2?=
 =?us-ascii?Q?SuJ+WpX3rK+Pb1gS+cu2ubEWYagdPtvTBMYVhXwpD6+3uYdnwhurX/186nqI?=
 =?us-ascii?Q?/TxSeECONI8BQfDuthVOa6NYvuGTiOtoleChj3nGyAIaF+56bJfCD/uyvZdJ?=
 =?us-ascii?Q?Clr2vzaQ9Tn7PI2KFubA2y+E71PmPA9svwtWVbFr2yhJG3sCIC4yXG7fjxeW?=
 =?us-ascii?Q?/j40bSFtN3FFqJMueD+ozD20zWv1JGsAzCqPnsAEPi81OhOOIs1OcpAv2Sdb?=
 =?us-ascii?Q?g08si0ZPtHtIRfdZJkQVnsSejOzIojS614HoGOm95wvgvKA/sjUCl2oyPJxM?=
 =?us-ascii?Q?LQCiTvs42AoZkg/THiZf6CZb1A0YXkm9es4QPmkxfpbVfc+KRgpLiCgapRlV?=
 =?us-ascii?Q?WxUPY3Uer9m4Se4fq00F/iCYI/ncNfaayv2VmL1hKjlwq9WEApy+an7QHpom?=
 =?us-ascii?Q?JHwvKgkrtsiSQihg+sN8Dfail6YbCHr8CO0sDohqyF2zSmLijcC2mLKDpl5D?=
 =?us-ascii?Q?3XhE9cy402wgcQaXkXs5iAPgexfXSOLBK9Kllol+w4dHIgOdyoAaUDNaq5sD?=
 =?us-ascii?Q?93m1gTVLiYpO7yR1dc9zajELHv/afWpjGeP7SwL/Xu0Q4mIfof37Vo7WJA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:29:17.4398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4985359-dd86-4df8-67e3-08dd8d738c86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763

As mentioned in Erratum 1569 from the Revision Guide for AMD Family 1Ah
Models 00h-0Fh Processors available at the link below, PMCx078 reports
incorrect information about TLB flushes on Zen 5 processors. Remove
affected events and metrics.

Link: https://bugzilla.kernel.org/attachment.cgi?id=308095
Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Cc: stable@vger.kernel.org
---
 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json  | 6 ------
 tools/perf/pmu-events/arch/x86/amdzen5/recommended.json | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
index ff6627a77805..f23a92bf55ac 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
@@ -502,12 +502,6 @@
     "EventCode": "0x76",
     "BriefDescription": "Core cycles not in halt."
   },
-  {
-    "EventName": "ls_tlb_flush.all",
-    "EventCode": "0x78",
-    "BriefDescription": "All TLB Flushes.",
-    "UMask": "0xff"
-  },
   {
     "EventName": "ls_not_halted_p0_cyc.p0_freq_cyc",
     "EventCode": "0x120",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
index 863f4b5dfc14..6b32308b1c3a 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
@@ -241,13 +241,6 @@
     "MetricGroup": "tlb",
     "ScaleUnit": "1e3per_1k_instr"
   },
-  {
-    "MetricName": "all_tlbs_flushed_pti",
-    "BriefDescription": "All TLBs flushed per thousand instructions.",
-    "MetricExpr": "ls_tlb_flush.all / instructions",
-    "MetricGroup": "tlb",
-    "ScaleUnit": "1e3per_1k_instr"
-  },
   {
     "MetricName": "macro_ops_dispatched",
     "BriefDescription": "Macro-ops dispatched.",
-- 
2.43.0


