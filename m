Return-Path: <stable+bounces-89926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83219BD6FA
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 21:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690E61F22DB9
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E6A21219C;
	Tue,  5 Nov 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rwygj0b7"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018281FF7C5
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838300; cv=fail; b=btUKcacNCxZjHHBXlKEQKwhtpOFfeqLY3NSGwdAlEbFvXklhnSWAKhyO3XeYIBjGcMpjQ+RNaOvKJ74kJ/ygONgxZ2+Pw26ru48k982EpoiksI45XM2KNcyP7JSZRtJ/4z0zpeJfWwQqVPEAUQLPTmHrKeGqbP0J5OA70M/b4kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838300; c=relaxed/simple;
	bh=UQuBafpznT1DLEOy5uCvNA+UN8mUi53Cbrg9GLxSJZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmx/AWHZxKgO/7UG5OOOT9JPFET120sOflDugqnJfALaCKjb+skUWz94MKDA4UmeV7ltOQFpcqS1+SsAr+JTsn6o2tK+8aR2cbuqrueyi7XX6/9rliX9kYY3CsimA34rAf6iiH6l1VfkNtWH/ZUfjPen5MpdrQfSHtrHGQv3vPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rwygj0b7; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3wo94bsc5GHzzpnx3yRpQ+xQFpQbKSmVyvvES1qQHeiMgriz9Qi8V58BeVV+TcThm++YsZd6qdvCgHA6+sFMbsrd3FBajl21DBuMB/KQt+XfpN0P6EPosykqPNZXEf7UBLqXOF+WK4I8f4yTpuPafNM/LXEDPNV0QKer8VnkL6lgKt9QnZI+iTJJiu3ANvBR3r+nuQZbmVBMsM0isQh3q4ETOGXeRh1NrUnFt1LDqML51NaTvNqkzREq6SOdJrwjAIqvV+K0FgeqseD7niNU1kDWuxsj7g7bu6OcRMXwOWPJVvyIhzaiSJuTBTl6cysd27Iu6u1uTpVmM7+Eh46/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S09HEuQPUJLLfBIJDDNrfsF4EidsmB07JYP3znEKoYI=;
 b=XlHXk2kEKhZiAMstziBzpQmdkzdi3zspD6BoP/2UiVcH768UeQEDwsFxRX8LkZ8xR4g5UE9rka14yxzVDuHBYMX2ee5tAwgYR55PN8qda3726MslhLdmuTD4aR1QjTODm2E0tH6vVfF7dd7Zx0WUxeNp40ql8hrK3PRxeaCWB9giVq9khF077Vl9kAz/OJt4Os9D3WZbjTyPR8N2+1AVJ7u49lp96d/X0c4DhWJZYB+3zI1+LQJXy+G8ZqPdW/dPJ2ifX3wpMjl4FLP5jSKttMaxhnJrt52E4nWtRlqtAPT0ebsmZvpznw2fnwlpVk3hASWi5vpR1GKZX8hJ/49Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S09HEuQPUJLLfBIJDDNrfsF4EidsmB07JYP3znEKoYI=;
 b=rwygj0b7WV6P7+fHfxVfuDOMAWt/NBQts9EXvwnrtfrA3mf1cWSzr8o1D546DNQcqO4BurJ7JGuy5RYSH8wlgKk6usyXVCWv4UYAhvMBhGf9QDC47/cHbAce6rxHBeuniIklcWIkJS3zECDCK5hOhJ9kN6LJZYbX4ACUrLh3aQ4=
Received: from BN9PR03CA0469.namprd03.prod.outlook.com (2603:10b6:408:139::24)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:24:52 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::19) by BN9PR03CA0469.outlook.office365.com
 (2603:10b6:408:139::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:51 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:47 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Yihan Zhu <Yihan.Zhu@amd.com>,
	<stable@vger.kernel.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 13/16] drm/amd/display: update pipe selection policy to check head pipe
Date: Tue, 5 Nov 2024 15:22:14 -0500
Message-ID: <20241105202341.154036-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9aee79-c33c-4372-dc58-08dcfdd7e740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l16oP+G/frmM+a0n/B5aowsE4+MibkqhhFZgd8bcU/UJJTUgiQoon6v5AlLL?=
 =?us-ascii?Q?feYfITd4kTMzAgDY543RJzdvHMC0EYY11zwiZ3AR1zFu+PTaZJf2hZVsGx8F?=
 =?us-ascii?Q?WdWCXVtLUSZFWUb6PVylSg9Sg5wAo6vYVOt5UWBz6tPVyBlaab71zRBNRhfD?=
 =?us-ascii?Q?7pIemfSvXzSBvZt3P8yMnmJkXtCtBdvNYqgfStHrjlGdsiHNE2pKfnS+pDmE?=
 =?us-ascii?Q?58ycbniuN+U7ozeEFZkv/v23Smk/DeVWJGwa3rHC44L/LV8LK0UrtlXmRYqr?=
 =?us-ascii?Q?RRSw+whxHJ8AhtllAET8n4MpSWmO+SJYh2Y+NrL5JqAV+J1IH0dFIIlWadry?=
 =?us-ascii?Q?iqAqdjc1yPboFQm3LELiZXaiVrgib3jd/AuswEYsUtgVKDBsjG01o75elmnN?=
 =?us-ascii?Q?pr7vEje2yDFvJJRomx1STlcEI2qyOZQHNi7desCLoocBlap/s6VHj17QTj9U?=
 =?us-ascii?Q?q1gxJEhY/0o3HPkHR3rCjj2dILz7ZeCE3y8/En+3Jvd2i3d4COhJEWQraTak?=
 =?us-ascii?Q?O4fmRei7+WrR7Yeam4qngoeI8Kpvm9BczclnNaeWtPG4FXcSGydNlC6CPGda?=
 =?us-ascii?Q?WzbU2IoyOIJz4YAqrZlAKRfPsrIT3RwfkogDYn1B1in/GEXjkI/m2vdO2f2b?=
 =?us-ascii?Q?WnJ5xERT9zjPmIy8H2ezr1UOSTv68MbEoB69gpZelKc0A3a+bW5qJDb4ZPxn?=
 =?us-ascii?Q?Eo5KeM5XF/q/F4BsXgBSQ+zkzkOmj8bULw3mNTHY/BDTjMonhnUMW8loXNbt?=
 =?us-ascii?Q?fUUlOBNE5AxVgpYd1dp/L9k90J+l2fLo6pQjLJQjpNfZdRlPQkoDcG05Vjq7?=
 =?us-ascii?Q?QB9ZXPeRyPwYNFoemJ43SA2Wm/GOf9VKqlPykPpDWF1HFyNh+L5TgqQfyFMp?=
 =?us-ascii?Q?+Sc3OYFNIEA8DlTzMEcReTqUdhf2hAVoPNQ0wcq6j4XabkE64aZRnU1KHFHS?=
 =?us-ascii?Q?1Ut5vJ59Wd4lF2UKtBUBbrjRClpQk+wu0cLDCFjN1TBBzV4EEn/0v+LKLzpL?=
 =?us-ascii?Q?gh4w/QkYev8tAcXLTIdXtV0FffuwEkwBofCf8PcyDKPFraa6+/oa8wWE4q91?=
 =?us-ascii?Q?zaRaPGvmsoObpXXde2AtE3xOA6xjml68WWrgOLSgRGfR6UKPvz7w601OjpRR?=
 =?us-ascii?Q?mLmFYxzKz5xwfznYzEGZfL2wvc7odmWU7bwS4XmNcwyEcq163DM9+wimzX9I?=
 =?us-ascii?Q?kLMwIBvoBzYMVUM1JkkpLKXdnlNhbIx9fXFr4XzcIGTmI2LBWFRvzWtxE6GZ?=
 =?us-ascii?Q?Uk3IcvWm1iNmP3n9GM2OVg7bSbAkfJ2S3i/zzLb34Cx7gOTqS1wj3hY/3IlR?=
 =?us-ascii?Q?DcMPtzsbSo+gankZt0bkd00HGqSEQcRQVBtvvdGVy7YMjqTllgcCpC1Wt8AG?=
 =?us-ascii?Q?6lpa0a+eHxMVJI3CXJuy2hRy9pR91RY9IV7YEzpCVcO5oacNHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:51.8101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9aee79-c33c-4372-dc58-08dcfdd7e740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598

From: Yihan Zhu <Yihan.Zhu@amd.com>

[Why]
No check on head pipe during the dml to dc hw mapping will allow illegal
pipe usage. This will result in a wrong pipe topology to cause mpcc tree
totally mess up then cause a display hang.

[How]
Avoid to use the pipe is head in all check and avoid ODM slice during
preferred pipe check.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 6eccf0241d85..9be9ed7e01d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -258,12 +258,23 @@ static unsigned int find_preferred_pipe_candidates(const struct dc_state *existi
 	 * However this condition comes with a caveat. We need to ignore pipes that will
 	 * require a change in OPP but still have the same stream id. For example during
 	 * an MPC to ODM transiton.
+	 *
+	 * Adding check to avoid pipe select on the head pipe by utilizing dc resource
+	 * helper function resource_get_primary_dpp_pipe and comparing the pipe index.
 	 */
 	if (existing_state) {
 		for (i = 0; i < pipe_count; i++) {
 			if (existing_state->res_ctx.pipe_ctx[i].stream && existing_state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id) {
+				struct pipe_ctx *head_pipe =
+					resource_get_primary_dpp_pipe(&existing_state->res_ctx.pipe_ctx[i]);
+
+				// we should always respect the head pipe from selection
+				if (head_pipe && head_pipe->pipe_idx == i)
+					continue;
 				if (existing_state->res_ctx.pipe_ctx[i].plane_res.hubp &&
-					existing_state->res_ctx.pipe_ctx[i].plane_res.hubp->opp_id != i)
+					existing_state->res_ctx.pipe_ctx[i].plane_res.hubp->opp_id != i &&
+						(existing_state->res_ctx.pipe_ctx[i].prev_odm_pipe ||
+						existing_state->res_ctx.pipe_ctx[i].next_odm_pipe))
 					continue;
 
 				preferred_pipe_candidates[num_preferred_candidates++] = i;
@@ -292,6 +303,12 @@ static unsigned int find_last_resort_pipe_candidates(const struct dc_state *exis
 	 */
 	if (existing_state) {
 		for (i  = 0; i < pipe_count; i++) {
+			struct pipe_ctx *head_pipe =
+				resource_get_primary_dpp_pipe(&existing_state->res_ctx.pipe_ctx[i]);
+
+			// we should always respect the head pipe from selection
+			if (head_pipe && head_pipe->pipe_idx == i)
+				continue;
 			if ((existing_state->res_ctx.pipe_ctx[i].plane_res.hubp &&
 				existing_state->res_ctx.pipe_ctx[i].plane_res.hubp->opp_id != i) ||
 				existing_state->res_ctx.pipe_ctx[i].stream_res.tg)
-- 
2.46.1


