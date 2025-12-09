Return-Path: <stable+bounces-200444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE18CAF5BA
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 09:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D9F301898B
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5328CF7C;
	Tue,  9 Dec 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ih4Zxqni"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68089273810
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270661; cv=fail; b=nUcosUy+LpBBsVlIxPhOrrYe5H9oDBH/RX0jLAV0KFpTX9btRLiPGAllHZSFukc1Bcj/q2GlzPEmbFb8nZESGY+uEivnLO5GjX/RFKMu6Da7G4/T7Sm9558juw7grVQv1e/MbK6viWLW8lBPgB8LLc+LjwfHrULHHfvEmp0EeiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270661; c=relaxed/simple;
	bh=HmYgwJd7P9mGfki2b4P4qUJs8AtiQM9VLaAi5hvx/sg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGi4FWJtpfaqtj4KHa+vd5uDh2KAagU7Jy0w4pQvxbTbIcdfCGO2mmSvODgBIL9tkREaW6vfft5vktPu+Fdqx9/imFwbd0LnKwmuK7GHV/DuR5KqT5Dwm8HG5aoRhWDBBLq0PO5CEnX0CQTKvpk39b3vHL8g61kmczmYn+gKWak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ih4Zxqni; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxrVpYxzdxPdfWMHFeJwXl797B/NSk+Bxc9FOPe7Ygp1urL9iZlpalccrLCZ6vtCbJ992svfuB2C43j3nxfgtXnlaFT6nuDpgv11T1CegGimr0j9fGQHRMWutudK8GF+rQ/T7Ut0H5DZLQt7OwRnUB8r+XOzsq7icptT/RCtLeqQi4ROn5szTXE979j3NH+7ogfYziNGnPjf4ydxAWHQm8PxnHfCdgqbzgNuOJaEmCUL5XZpUfcMj7bOFuzWd4AznmnKa5fWHKBPxtb62p3nzologc38wXAmUaku7UzAh86NcyTYVAY2bDNSseIsSPLGfcdOosMZ2AuQXpl85QYeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n3CW2zcLmqOCqwg0aUOcAAHCNN4g3clODkb0OqAdzs=;
 b=y9MURc7RvWRUgtHu5ZUoCRNAcEYB8CXCPmVRAFex/lFQDLuCYrpm5Tfel58cIpo1vW99Eo1MZv732RflsUIEe9f/XjHxgrPn3OSUrS+b/Dv0tH/qXZLncQZcgDAyXqss6z3qV1VLvsA7oCdj4jFx9qjBDXDkFEfjvQbbabhF5yibX7ib0KOdBCQuS8JetbXh3XiNPVsEkbaw8oSyVb68t1sLZ4fvZOuR+2i5VNQ3AF67G5uHEGdhtCfCdayIQOY5UFe841wFHgCHcdn3MQ9xHKV0vnUQeQXPc+lNmO8JaRwz4pL7WDI/oIB2BRv21jcolA1yQxTiotaTQ4GwtJ7N5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n3CW2zcLmqOCqwg0aUOcAAHCNN4g3clODkb0OqAdzs=;
 b=ih4ZxqniqUThE3GJvrlwJ8cwgHMzbXCa0SXPIHc+lpWv9oVsQlIT+jB/lkqzZwHGQHdO9kJCnxIPnpNrAKAFSVR8buqGoNwtjMC+xoW/CtcWxm+L7hmVWWLPamJEWwwLMsdImRhXVY5xVQbqg4qMhk8X3I27G0P+6LbokYa+aAw=
Received: from BYAPR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:74::30)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Tue, 9 Dec
 2025 08:57:36 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::60) by BYAPR05CA0053.outlook.office365.com
 (2603:10b6:a03:74::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 08:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:57:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Dec
 2025 02:57:35 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Dec
 2025 02:57:34 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:57:26 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 02/15] drm/amd/display: Fix scratch registers offsets for DCN35
Date: Tue, 9 Dec 2025 16:55:05 +0800
Message-ID: <20251209085702.293682-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b529e8-619a-4b5b-876c-08de3700ff76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?czur4F6PCwbS6k2s00qF2t7Llpj2egy297T10stwLJBXtvgoeboPbIfaVJo6?=
 =?us-ascii?Q?2kanKBARRPdPM/xfJ7oNj0nfbaZ+BjmteHpXF546nR24cxKrwb7UYvIM60lw?=
 =?us-ascii?Q?YRI6jGdDE0q17mLofF1kgvz3R9aMwrydHXI41EmrfFHowrJ4JIqv07NQBEOw?=
 =?us-ascii?Q?WJWhijFhbnLmupduWXFKay323WUnQa8vzWRiLqLJCChsmuVho8ooXN52fHyL?=
 =?us-ascii?Q?Ispc8sbmi8oblvWs88xjZKkWvpxCXj+D8wHm1OeZpUX7hOUmgFSGU4sIqQAE?=
 =?us-ascii?Q?w107HDAS6PTSA+HeuzN1V0G/thVp7CZ6pi67uNRgjbFX/14nTQkrNp1XbYDV?=
 =?us-ascii?Q?3gbUu5a6GMJyYH1CDEpZQD+2o0b/75876mK8VWzgONhEeaZllW43mU/gcjXk?=
 =?us-ascii?Q?4AfOPSifjySntLgoQV52V1kZJrEt6IG6RB8PPLYCaL5bjQFMe4KHydglGVtL?=
 =?us-ascii?Q?+/1fL6f3DNWV6lOBWpG3R75OQcxjmcoSRBoENbFYtmrClHYFAU2hwQusqE1r?=
 =?us-ascii?Q?evWPdLru6Is0LMHs8p0MekleGW9uYpGOf7Fg2h1aTu5hFUTq4eTeFpVzN1IR?=
 =?us-ascii?Q?AE2K+nknEERlUsgyzNR2RSwOANZNhn8SmujCB7LLVJcOVcEdbWvErd7ftXsM?=
 =?us-ascii?Q?Bn0TWy5IVbRJLxSJToyIlN+RStMGQpxXD5AZRdS7ZwReYIDr/3BeZIuIRWmJ?=
 =?us-ascii?Q?SPlmbNzrCHGQyu+a/Lf2f9qrNJ+R93ayr/dK6W2LLLsqglUxULWnTW6/Fwc8?=
 =?us-ascii?Q?NhfiosKOwj1vL06+eIl4pbwx80jfkWRXov5wZpouUAguRcK8SdrzQ174k1+z?=
 =?us-ascii?Q?mQZp0gqbfHcV+VdMem+l6m6OMoFRTMPSp8kt8oiWh5B4x5L635ks7+3RHh4K?=
 =?us-ascii?Q?Jghbrc1VNJDYfm7e5Y8CKPWMgiSFJ3n2jQUgq4ib6tdno3iwHGzRqX08yaVX?=
 =?us-ascii?Q?DO3Rnm2TcPiuoYwVJwH6IbsvzWIKhUWQxXh8XP+z6CuE6WDE29R1kZCSq/14?=
 =?us-ascii?Q?Vc7m066JC0pEAf4u4Andt662F6O8YR74DMHryhO3+IAndEf59nZOsVbjAWTh?=
 =?us-ascii?Q?9VTexaqE2gERMfzkTXX75LvtHpW1JPijisyLl9SJiL+/dfe5mqxwUvR+YAeE?=
 =?us-ascii?Q?O1OZZy4EwsWirDZugxp5wSQixiDa7e1Dk1E6FQG2vp9DEyOxWpG5cu3VyZ9i?=
 =?us-ascii?Q?f8YWTooGfX8z48WMCWbFostemHhY2w/Cq2gZ9pP30pxwbtW4W3UTTZRhJOsR?=
 =?us-ascii?Q?OGjsbYowjhL83+391zsxVR9SJYn0pjSeYOpqhVpqiHM8gFH0OGR1G5ElP0pi?=
 =?us-ascii?Q?QGfUHM87rqZTzm8GyRhWmjudRrTHVFFQHf0KowkoPUfpnW0+GFH3Il9UyM/v?=
 =?us-ascii?Q?Hx0TG6vTYpWCAYx76nJ6pXXAybWsjRY7vg4ixxKQOMUoQ10mwrDStSNFapzS?=
 =?us-ascii?Q?D7Hj3z21SMs+7W3c/oyWOHqChhtXCJDqY/16WM4sFjUID3KQIWCQpuBxETbd?=
 =?us-ascii?Q?jnaVfA0T3t5Jll0endkl/M1+l10f8QAP9dSLJns+tvO5OULMKeI8qprk/hRy?=
 =?us-ascii?Q?16wzcggrepj8c75bnzc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:57:35.7856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b529e8-619a-4b5b-876c-08de3700ff76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790

From: Ray Wu <ray.wu@amd.com>

[Why]
Different platforms use differnet NBIO header files,
causing display code to use differnt offset and read
wrong accelerated status.

[How]
- Unified NBIO offset header file across platform.
- Correct scratch registers offsets to proper locations.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4667
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index ef69898d2cc5..d056e5fd5458 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -203,12 +203,12 @@ enum dcn35_clk_src_array_id {
 	NBIO_BASE_INNER(seg)
 
 #define NBIO_SR(reg_name)\
-	REG_STRUCT.reg_name = NBIO_BASE(regBIF_BX2_ ## reg_name ## _BASE_IDX) + \
-				regBIF_BX2_ ## reg_name
+	REG_STRUCT.reg_name = NBIO_BASE(regBIF_BX1_ ## reg_name ## _BASE_IDX) + \
+				regBIF_BX1_ ## reg_name
 
 #define NBIO_SR_ARR(reg_name, id)\
-	REG_STRUCT[id].reg_name = NBIO_BASE(regBIF_BX2_ ## reg_name ## _BASE_IDX) + \
-		regBIF_BX2_ ## reg_name
+	REG_STRUCT[id].reg_name = NBIO_BASE(regBIF_BX1_ ## reg_name ## _BASE_IDX) + \
+		regBIF_BX1_ ## reg_name
 
 #define bios_regs_init() \
 		( \
-- 
2.43.0


