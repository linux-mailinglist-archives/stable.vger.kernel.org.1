Return-Path: <stable+bounces-142074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D100AAE309
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62DC188A961
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C628935D;
	Wed,  7 May 2025 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4bJUqSS+"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D742036FE;
	Wed,  7 May 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628185; cv=fail; b=ht4okf96uTNJ5gz7RurN7IM9xKwhmFzAbgyUMWoiyx6/G45yJrvnHuxyTzeMju1kD3zQh/lYsHMeTHU33583Z7eMmcK+CLwMY6kfy8M5g/8HRAuwdGxoz35ivmzE/apNWbQTXZsugk8ytYjf+JIKs9DuWcBOKNwuO+5WyK6OK5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628185; c=relaxed/simple;
	bh=5tygQWSxNU2rITRj7BTDK603omGX5sRzgbYekjukFkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLZmQG0qhQ7Lxp2lBU0QyZZYuDHJtfHK0qt6mNaikW++DB8+iZLeqsg8mmCAGF9rRHcSU/AcUUfa5u2A87GpbCrFOm+ti7wuErNFLaRfG4OZyVTOqNiNDJCilndkkBQm1zn/vM0BcD+BkgvIK67M9QXBusjMyZCuaI07OdPaHdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4bJUqSS+; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hr4EMzNbAO99S2vuqtmH4VPb1h+TseaK68RVvlsnlW/jbJuG/oyBYkEGYHapBBYxDDVUE9fxVFijUvGa2bfoJ2Lz2WJ6ilpQOPNxVkcUasFuJbjzbgpgjQnAmQ/6417Doaot415r5BsGcDDupaMwuMU1f/b94XOMQgHONWXlhQfi6f2Yk1uNjEEjjqSmhnMxiJ5rmSiB9YocyupXnVa86bMYDewC7ENOY2e8XT4fzL8s88LwBEnPsnOe5AAzds/n6oLE8W+xNWkFvAZ0pFjKIB6gKnx5zjOuLYlSmhSZt2UTkInmDOCPSCtj2KG9LldhwFj5KqIG+n6T+JPThHKOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duewllPgDHqrvny/U3PnaeLXo1s/k2lqs2DRpPEeESk=;
 b=smEuchMWb6kNFYbOgLNSjSt6fV/S9jSLv1yh3LWpYvnMK0RtL51YS4iiOwi28nxZw7CKhb3kZcTghFtLCeFpShy7X+/XmbNXweF+j3I6tg6j0yUZtps/2+l0i5P3EVVYI4Zh4XD5jsul/mikScO0WsDbmP72taI+UGYh8JsNEt/bzNbCg9KiFXFtjwCSYMrnkflKWHDQh0bQAYVekz2jzf3NrmhU8dZxQ5VuSDB0rxVMsryWQb3OD6ag5I7cKVqzmGBtWiIIEvzVlEjyLwjxLmQeyDdB1bvnZ3IdpoDMsYRd5CRLTNCJrh7ziIE0dkOJrhaihh8VAYkjxZqO8U/e/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duewllPgDHqrvny/U3PnaeLXo1s/k2lqs2DRpPEeESk=;
 b=4bJUqSS++QIEv8ILXaI3y3XrYmPDWW6xi+/6TFs+b/iDzZ7f5+dD8+1A4lLv3ujyoOfDwjq93yHcXlxctw5gAiO+hGjEWRsfr6JGeU090kBEHGLAp3x6oEXRwR/3TOSvsKSvxgyCrD+hLMXoLzDvu1K4AhTiH6eDcxLvz1Yqq8Y=
Received: from BN0PR04CA0121.namprd04.prod.outlook.com (2603:10b6:408:ed::6)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.20; Wed, 7 May 2025 14:29:35 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::f1) by BN0PR04CA0121.outlook.office365.com
 (2603:10b6:408:ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Wed,
 7 May 2025 14:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 14:29:35 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 09:29:30 -0500
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
Subject: [PATCH 3/3] perf vendor events amd: Remove Zen 5 IBS fetch event
Date: Wed, 7 May 2025 19:58:29 +0530
Message-ID: <826b1fc26b97eb040c784bbf43f9ad666b7822b1.1746627307.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb2208a-04c3-45a8-d2c1-08dd8d739713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PeBnxB5p8jLVDyorUAYCztVXttaLRI8P6V/VI4QLAghs9ffy24fE5k+RCJrs?=
 =?us-ascii?Q?a0cLZ6qZ73WZTzBLAAmcYzVMMX4OGgBKlxKBBHpdrkWJOz1PzD9VSaPPPSux?=
 =?us-ascii?Q?qMY3iENjUJ9DO5ezGkbo6+REFQBlnpThcp501fggco7DAQZ9EGG7f1UXhG4f?=
 =?us-ascii?Q?hlXbvRJFtmqpUMG1skT36QBd6eiB/MDiZkWVruWjOzBobEfrMAn9Orlv7/q8?=
 =?us-ascii?Q?FyEgV6muOWjpA1kAATzKSqkEBRzP1OZ+n5xRqwGJLxtBi6vxKgcMpN0EPU78?=
 =?us-ascii?Q?lg0isM9EqpxZJLFaBujVyMdN0QBH0kvtNoVTZ/ZypkJiK1mtP1BcAw7BdDJV?=
 =?us-ascii?Q?N8Aqon3B6f6KDCuGn6PYFHNb6xg0kOgkVgP+Lpzt9MKiFg8k/cP0kAWJUHxP?=
 =?us-ascii?Q?l/8MWCT6a+MjLUR0PS0P6mbHoXfuq4IFRK44WLCUDux6cQx4yTg3TYm74dYk?=
 =?us-ascii?Q?X6vEOSz3ryR9QQKUWAidfx2OkMp9LsHqUme7254AXdNTB19VHa7jkgHNnVW3?=
 =?us-ascii?Q?rXVvHGexBYDStqAoGEZtdFiDf+phVxlYAZyvCWGpq6LETnchYNmluGfWL9oB?=
 =?us-ascii?Q?WYOziMDB1Fx8UtMnTj0niyykGdc8OLp+ED7Wl1DEjh2zGurIofxsDRQBrjRU?=
 =?us-ascii?Q?Smz7MQ/lxjaLDSowPifYoQKPo3dsm/e2HLnMxGcIcBpJYXbSnsNvqKnnx5lR?=
 =?us-ascii?Q?aR5MxLO9F6RycMidFT1aSOQihl5j7oPAWruzLqZfs+H0JxVxgHk9zDTQJ5mJ?=
 =?us-ascii?Q?H4369byMcvv9kzA4hsI/lo5oFmg9/3ZSJyunzUBG/l85ckVlI2jknY83EZWJ?=
 =?us-ascii?Q?aHy5I4+Kbz+ps9V2lH9FuBaPS70ErPe3OQKUusUL4ninMo7aH04LQmrt2aJh?=
 =?us-ascii?Q?bUcU1OIhYmrl6EosKiE4YjchEUwP1ZFEaCLMYRv7AT1Hk+BzUIZPiTDQ64oz?=
 =?us-ascii?Q?ffpi/IPdig324NJKY8AIKtP6y89kvTiZI/3bVbVleCHz8fAYrriT5Q1KQZFH?=
 =?us-ascii?Q?ekTKCVHWFkoo5aV4Pd0ks5AB5rPH9hBQDFiUk1DuiLk7rAPV6+3vF3p0iZSx?=
 =?us-ascii?Q?ZSvACHpyW1yQBARQOv+v5kHku+CTO9LSbiXczIjh8AFBWHEo6J9P5RxwpxUo?=
 =?us-ascii?Q?1EoXwSWLA2aaEO6UXfyP8Rsq1he/pDqETSRqOyxp3rhaGJKKiXgC2KDO0CiG?=
 =?us-ascii?Q?01XTmR35UI5TR8rpjactBqE1zbt2GHdez5BApNYBtuU+gAG/cowRlTQoCRcE?=
 =?us-ascii?Q?xxRD2yt+WwxFTxm6OFlB8fJHBmkQFlPBd9nr6QfEl4BXT0cn4AhfkWpYy9rR?=
 =?us-ascii?Q?Nyn/ae1LfYWIM/E7iy6kBXjTHEJqFsZvZBc1KQVIce06wV2ZGPq/8jn4kXdg?=
 =?us-ascii?Q?vDVuQUSruN8AFKJHzqeu6yE7g6cmK9hl8EKVJNhPJmWNnx4pi2UtNcvYQ1RQ?=
 =?us-ascii?Q?H1gWOQjKxKDzsWpBHxdEswb7w1Xj5Mb2ge1uxO8fYu5bPTqsujiXSWrh6YcZ?=
 =?us-ascii?Q?+O22q7BJdYJl6HMEZoS7vaAxGQe4oHzxSYp3Qblx7PM4Nd2aFwRGRtxwYw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:29:35.1082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb2208a-04c3-45a8-d2c1-08dd8d739713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724

As mentioned in Erratum 1544 from the Revision Guide for AMD Family 1Ah
Models 00h-0Fh Processors available at the link below, PMCx188 reports
incorrect information about valid IBS fetch samples when used with unit
mask 0x10 on Zen 5 processors. Remove affected events and metrics.

Link: https://bugzilla.kernel.org/attachment.cgi?id=308095
Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Cc: stable@vger.kernel.org
---
 tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json b/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
index 4fd5e2c5432f..3b61cf8a04da 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
@@ -27,12 +27,6 @@
     "BriefDescription": "Fetches discarded after being tagged by Fetch IBS due to IBS filtering.",
     "UMask": "0x08"
   },
-  {
-    "EventName": "ic_fetch_ibs_events.sample_valid",
-    "EventCode": "0x188",
-    "BriefDescription": "Fetches tagged by Fetch IBS that result in a valid sample and an IBS interrupt.",
-    "UMask": "0x10"
-  },
   {
     "EventName": "op_cache_hit_miss.op_cache_hit",
     "EventCode": "0x28f",
-- 
2.43.0


