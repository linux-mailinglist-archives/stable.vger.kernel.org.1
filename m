Return-Path: <stable+bounces-182994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D5EBB1D23
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 23:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BCB4C05C4
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8842F312804;
	Wed,  1 Oct 2025 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CCLOR7Wl"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B23126DD
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354104; cv=fail; b=saKopzOl2H8VociDCYZxXa0KLfUInBet/V8Rd3WbAhjTaOHdbdWVUpoiTJSE1yXbdAxp6p6HWqFlMjjirglZX+E8V14k/NB1kFhj8cOiWd4WzA4nlG0x6a71FWBpg+1wgOgMOXmC/laS1Dbxv2C6VrQk7g1dLgIKOgUc54hxu/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354104; c=relaxed/simple;
	bh=FwexuRpTfFggrYz7Onh04XgEuzeDL7/hqYJ92NclZgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwWYE/Vi+ZwgHPNAHJFmZYoboSZj9shbvMcU7Q0RbJpf6DN558hNW1hiv1DLdA/dKD89Bx0HQY5DvBk8O85OOnm206yiSAmNY6mUzXjKU2hm3t/lXSxvLKX6Ac+i/q1UUdGckTsJ+Ig7f+poIbJJ8wkmS1hSxcn6T1hqFz4hgz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CCLOR7Wl; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYSbrbyQsmaazRGAP4R6LPnfKtkh9Mp/pdpJhWJOzDUrngxLCwIlC1f9vkIkbeMfy6Qwgd8bnyEhitbzvuyNYg/vxB8r51JX/W+kWnvYYwC8k0Ze0IJ/kIEEeG5I1evnMOSHIxIsKqT3NXTqWzT89gTD/p41pJPt6HjQPqBfsVDaxd3SL+0kGe5AvTuSrzGaS4l0/jqigG/MdSO5KogZsGx4csjbE3WblazeDNlWgOhBJli2KSWEuH+xHDOLVTz4+iPCWDz5/IKiF7GcX1AiZN+wr9VqvzY2lhUwkseop+WnJFrpNDuVAA8oHme0qImOQC0vnKaWefiLHMP6zUmM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOepD+3P2RpqcioZlvWT7ecVab6xQq6wbbDM/JdBWxI=;
 b=hPdXqFF7IR8nSbRtsjQSg4BrUiYkNvgc06sToO68hVHY7GJ6yr5SpcIuoU0eGMDRuwGyQmh25tIUyjDAGGPfHMVcslh7wZ2p/f1rncCxu5rJKA/HkRx/2UNKbs5jtlU2D8+MIpF+MG7K36DIgL0fvuQYSqZp3qdS4S0+GDXvrfFh0sFcJUwL9mqZHNppgTkGsHYufY1g7yUTFdowBRji51jM9fJw/j40AKffIapK4HINwm9jagTow0uW0HA8BgwwSX4eYVEA5/j0LSflmfu/iri6/hZPlctlO8vjaWz6h61OHdWXYnkGZtxPNjCuy9dY62CpWLmg9owsT6vTvs5q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOepD+3P2RpqcioZlvWT7ecVab6xQq6wbbDM/JdBWxI=;
 b=CCLOR7WlseSQhgHXlxcJN6zqwBFlGZG17kpBe/BdT2qjE2KSicWFOQxP9P3xiFRaKrL786DTxA8kgmd/ijY9MzKnbFZFlh1IHJVlQ+dfAZfXmBCE2ED+Ui7sG5+myCZ3MZwXA2sUwZdc2oCIlx1tE9VQ+Fr4qivLMe1Rurj5Rsw=
Received: from SA9PR11CA0015.namprd11.prod.outlook.com (2603:10b6:806:6e::20)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 21:28:17 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::ed) by SA9PR11CA0015.outlook.office365.com
 (2603:10b6:806:6e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 21:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 21:28:16 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:28:14 -0700
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, Jesse Agate <jesse.agate@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Samson Tam <samson.tam@amd.com>, Brendan Leder
	<breleder@amd.com>
Subject: [PATCH 4/7] drm/amd/display: Incorrect Mirror Cositing
Date: Wed, 1 Oct 2025 15:24:09 -0600
Message-ID: <20251001212700.1458245-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212700.1458245-1-alex.hung@amd.com>
References: <20251001212700.1458245-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: e572bbf8-6036-4c6b-de99-08de01316f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UlWmUrYC4XfstaPjDSMOfEIubhTGMLH5dPTbryIbm1uXqb5lGGjbrGI7No+b?=
 =?us-ascii?Q?u+XZYOum+ZR8OFdnP9Q5Fks2tAdKIv5pB6k0WF/TG82h9H9G+OvV0rNUIaHA?=
 =?us-ascii?Q?WvQhA5OYKxSjUGb89QeyVsWTD5uLnoj/Q+S+rB3Q+6yNgTspKtJdjwhi8Koe?=
 =?us-ascii?Q?5fiLO7UUT/6F0L+hLeVTgxnTUUVM+I3r1XpEvAOPydMf8qpCvfVK7uYwG6kr?=
 =?us-ascii?Q?uv9QUig3l+OGvM6Pllz1bdVx0BChEOcjWEmsEmz1LgRgr0FP0M6+eTbtHGlE?=
 =?us-ascii?Q?wQ1PxF+9MnxOI7dwjJqhOGXAw3MD3k+qjj6lplqQi620qupyIxX3+hJ76FgG?=
 =?us-ascii?Q?rItyxkgjSYRGya7jhH2Tkf3wsbk3ofrRClBlrc6pFYz8cRhOe6vKZYJciVm6?=
 =?us-ascii?Q?yWkwfKrLTN3IEVLBeXUcsVUQtb+sM6uFG/easrwY8YcvwRf1pe+vuM55Wvuo?=
 =?us-ascii?Q?/bWZhdA6udwLjMAkDUiQsetQHw7PEzj69OnC+EkDi9kQV9wGtsURVJdLoCUZ?=
 =?us-ascii?Q?cwwMXcgCT2Q8+ZIePLWbJoPCdheRu4CRZpN+m/psD5M93/9nT85GkV3TtjMd?=
 =?us-ascii?Q?5hRNDG8vUk1nLdzlDHV2ZhzujQu5zjiZAzciRahvDRyzr5UAPvEbqGtKkcco?=
 =?us-ascii?Q?ZcajMv3rpmSGq7F4pJgSL5iBydcDLTBPgKXoPqknod29VbAYdjvPkKoywOvi?=
 =?us-ascii?Q?iudfG4uq4PPOq9xAG9i01gYQfnb7aUAnGEM3me+mP/McAc4qrpzYEabLUVqk?=
 =?us-ascii?Q?HvdjefaRHjg14SNNDYO5ilUGb5Wk/J9aG3PhCD7OWmr6LYK0LJGl9+7WMIwi?=
 =?us-ascii?Q?lqPa4X+GW4YHIwI3W+lXxTvcSzmKLgdFy/PVvLnZEECwpiwDwVf3Suei8Gxm?=
 =?us-ascii?Q?vXK66vc2NO/8Kg4FrTW479BXGxc0DPtJXJGDIzINDgpQ5FuuRZVqGDOCm4wO?=
 =?us-ascii?Q?joLDnPpGxopKHAc+4B7CMFM5tgTZxmX6h82YvJJ7CehCSm16cLg9K/231LaF?=
 =?us-ascii?Q?gGQS+2uyb6+aXlybU9genxaa3SgmHYjiv2LtImGkrI+S9cndf7Hy22tF39xG?=
 =?us-ascii?Q?mfuLf5ACQmOc57x2l0WvhBUqfJf67XhCWX82MCxWLFaUM90X+/b0W7nl1avL?=
 =?us-ascii?Q?GsStv5GTfukivamU6ta1lhbNmvWF5N402uDS+7WoYXA54Ig61PhdNE2a9lVI?=
 =?us-ascii?Q?mYjTEu8VoV/kiWLuSUldRP2INsMNMdNJFvbbOA9Hag7LMV2yF6+f5dXRZnmO?=
 =?us-ascii?Q?f2qEUMt4sPPmdawMsVKLY3YKF3bcAvro3Nbgx5CKaNabnWoXvO6Xky1qb7Of?=
 =?us-ascii?Q?pXTm0CRQ3ZUEcRF1nU/AUKdiQorHjN1Z1E4GudhZIb50l6YG05SA5Ud2FsEG?=
 =?us-ascii?Q?arhUe3Mus6OAm0R8D2a4evjucg9bReW4BKsdLk8gTAK0WlA+O5NcoAWCI73N?=
 =?us-ascii?Q?GwQ/TmNEJ2qBoFqrOtcow2mt5QOTdqr1O6yV+ikeXSzLPIqvFlTRdVcXVff3?=
 =?us-ascii?Q?dDZLZUw2EVGzoiYbeBlzvPoiBY1CenwxSQLxf8p24FU95JKJcxTE9eZtFKLS?=
 =?us-ascii?Q?hzV7/U9+BUBzbBe1Yuc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 21:28:16.9818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e572bbf8-6036-4c6b-de99-08de01316f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254

From: Jesse Agate <jesse.agate@amd.com>

[WHY]
hinit/vinit are incorrect in the case of mirroring.

[HOW]
Cositing sign must be flipped when image is mirrored in the vertical
or horizontal direction.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Jesse Agate <jesse.agate@amd.com>
Signed-off-by: Brendan Leder <breleder@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 55b929ca7982..b1fb0f8a253a 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -641,16 +641,16 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 		/* this gives the direction of the cositing (negative will move
 		 * left, right otherwise)
 		 */
-		int sign = 1;
+		int h_sign = flip_horz_scan_dir ? -1 : 1;
+		int v_sign = flip_vert_scan_dir ? -1 : 1;
 
 		switch (spl_in->basic_in.cositing) {
-
 		case CHROMA_COSITING_TOPLEFT:
-			init_adj_h = spl_fixpt_from_fraction(sign, 4);
-			init_adj_v = spl_fixpt_from_fraction(sign, 4);
+			init_adj_h = spl_fixpt_from_fraction(h_sign, 4);
+			init_adj_v = spl_fixpt_from_fraction(v_sign, 4);
 			break;
 		case CHROMA_COSITING_LEFT:
-			init_adj_h = spl_fixpt_from_fraction(sign, 4);
+			init_adj_h = spl_fixpt_from_fraction(h_sign, 4);
 			init_adj_v = spl_fixpt_zero;
 			break;
 		case CHROMA_COSITING_NONE:
-- 
2.43.0


