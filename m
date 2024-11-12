Return-Path: <stable+bounces-92835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC19C61F6
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 20:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D1B1F2474F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF2A218D7B;
	Tue, 12 Nov 2024 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2puJGvV3"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C71209F2C
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441503; cv=fail; b=gk2xkzJTMOWk00xTGqBb0p5UlcYIcbVBkBwhifi2AhKEOjAiQffA8NrsEnEYSmS5t5SesTA/v+KkZoVg1CMerWk12r0pIxHp+3ioux43ty66zciwRnO8xwbp5fp0//2yzgjatuNTI67vkiGXcFTf61p4t+NaJSwWBIChV1Ow4MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441503; c=relaxed/simple;
	bh=Btru2K/yCVN975Hozg5jcRl9jsyy8o1Wwh3TcVpNB3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4eomrpOpc6WWVW4AgvEZiN+/sFn5k/U1PvJQuhD5iMf7umMNMaDJfSaHUzSgdERIHX2WTPdsxcK8attbl/1nIZXx3FPT1hYmYO95UdAe2k80YfNEFYSDHE+SNKGvek8rn42cSIHEDNEZxBL4ZShRq9zD1eCQGUi8JKNYFhKKFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2puJGvV3; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dd+kCxgWllYonquQdgqULsHOcvPAyCfLQ76qSr/0iQjnDCdnGMI84dc7rPfPp2gXChcvjwIGJDkdLO3L8qvuTYE+JKdtRpUvNJ8Z/OZAo+JElbvzFJHk8RoPrDYN3pr8O1+gRvMp8U8kvtb/fG9FUrZE949mIkGMoHeCVcnFAq+rxp4juScBHvZmZSkILEdXHLEDjTUFqbzZPwG/8+YIuXOcLRJrudZuqVcgBM7WCcW+N3aPIKFQnAJq8ui+Qg/aG4uMkORNOWqSGgiHHVSV7pdNOzu1/YLUHLxk4TXCsB5EwaWMHCz3b6REpB4xg9ItH6QYd99olgKshPxUMvl9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiaQDFHZZ2B5eKFuAGUBpD1FRzjkWT5xBR7DYDfu5JQ=;
 b=ZjRy7H24OS73qPF4X+4pQIJXlVPM2+n0ETdGrutx9NTH3KSdHSKGBJSGI69+INi/ytye8H+WNRQjVmO2zWHNvV5pJt9iQiswyU3O0lG5vSeCrHinMnjuYcH9tXwMqTQEiRAiRWrxpc+U4IFnmCqSoU2l7aWrszREPr8Mw4gH0cEqtm1TtiQ07cqhb3IZTkJXKfmCwoIqb62wwkz1ufE7kKWADpaxCnagqfEg4TVu8VCvYYGq6ZLwTmrPjoA8v8KZNj32toaXbEwfAww+guQctDaY0J55WaR/4SJ3ZnxS1t3awdA9FoAnH0OuB19JSmGvkT5XpbcyM7zwpGrLq69m2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiaQDFHZZ2B5eKFuAGUBpD1FRzjkWT5xBR7DYDfu5JQ=;
 b=2puJGvV348NuFwjhkQJkWFhryq//7ezR1/bcYvN0ovKAlEv/En9Ouq6RlXc0VDXsjT7nKJZu6lY4F8PJ2EvPlbvzwZtThogg7whItYwIp+CWqKXw8/2nBgSszO91Yon8FLsT3HAbACLQuAVqNSDLnv2TvIP8MhEJ5DTHeQruLA0=
Received: from BY5PR20CA0009.namprd20.prod.outlook.com (2603:10b6:a03:1f4::22)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 19:58:18 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::a9) by BY5PR20CA0009.outlook.office365.com
 (2603:10b6:a03:1f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:17 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:16 -0600
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
Subject: [PATCH 1/9] drm/amd/display: update pipe selection policy to check head pipe
Date: Tue, 12 Nov 2024 14:55:56 -0500
Message-ID: <20241112195752.127546-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab6c7f8-a614-4720-c870-08dd035459e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XnK1sDNxx0gYgTZpn2hJoX8KO4007hyIDkJvyYP/dlrxyUf7ymChjiWeFmop?=
 =?us-ascii?Q?jP4ADvSwPGmFaPBH+4HcO6JbV2yshlaQOPZlgyprMGtUMPbM7FIDtCOsuCZk?=
 =?us-ascii?Q?gWGyNz4bArKQ73mNV1HhwsBFOQtDVxCZ/iBfnE4Yso1W6J9xFN9m/CZZf+/m?=
 =?us-ascii?Q?m3OsSF4XbikIyAlvsQZ5ntbvjuSgVTZrSF0LixH8tjtgVTYh4h7sgbwa5i4C?=
 =?us-ascii?Q?Zjg/Qam/JPRgHA3MwmTlVUuLnp68M2ngionTa3iAGS21iy2e5mmKFKYM8Rrx?=
 =?us-ascii?Q?pKgJf+MyFWiuNz/h6B7cSELd662sLaEmLWWGgiD+j9OG3d50XyKvKtlAar5C?=
 =?us-ascii?Q?8kp/N7lC0p2ENeZHO2HidXACqgSuxVru1lT7GqRWsI/umYFNgUhfBGQ/e88d?=
 =?us-ascii?Q?TcB9aQ4+oFH2nS8I4hirbTG5U/hUK8OU+vIA4ZpMhnlsdmUSWqY8riwQnp8p?=
 =?us-ascii?Q?CNoMxHdRiQkzBiLPj+yp+psQo7XSJjQh9313YpsdKNpDewBa6UmRKFM0Y9ex?=
 =?us-ascii?Q?Eo5NgphxTMtKI4w4A44uDcranPHaYUpWgPKpyZFV/R1aAAsAuVjNrRdIEBaf?=
 =?us-ascii?Q?vQw4kfU67l1iqzpK3rhzglVaGej4KJP/Rbwx6YigpRERG3B6ptgEfHDDcEKX?=
 =?us-ascii?Q?bkEAmgqa5V3KHsW3srnyx36h9dv9IjX6Q2Vvd6GGE0b04QEHyCsVbEG9LRa9?=
 =?us-ascii?Q?EXCukPA4nbUJ6JWtRy+07l6jRAREJnXLdB1Pq9n7ANgSTmzQ//MQs9puUqsH?=
 =?us-ascii?Q?ostigPngtFtEbP9gAcRaGegIY4WaNGeGoqAq5LjFaZkaHz1YdlNG7LQEXdLB?=
 =?us-ascii?Q?H1Pr/c7Ip2X3yeb7LvdhfuUHkkJf6K/yvP/9z2U70PtqUtghI6zdThiGtUWY?=
 =?us-ascii?Q?YWXIsaYIQICy3Ac6xNi+h9DM7tw83le2PedgR6i62BE21CglhHewLa0NPSQS?=
 =?us-ascii?Q?0JP6m11AVXHmw1h+Gr+OZIGkQml4RliEmnr1txx6ilZASNec3GZFFUYU6NgX?=
 =?us-ascii?Q?KFUKzpHDnayxi4mrWpR/PGAlmggnVesiRO+D1tmNo+2591R2GZK5jzM+9w3q?=
 =?us-ascii?Q?eCam1MNgG8oy1Stni9OlnxYHcB31ycjcwrovT5bnUmMENll4QtW0K3nFp4Oc?=
 =?us-ascii?Q?iWoifwm/AEN5mLIcuFc39Xdv3SE+PaDuFileMLeBjjp+oISZFu8FB/SxB7Mz?=
 =?us-ascii?Q?Buf220VnPdQ0uI7DJ29cgspBTrxFZ0VTHkRhQodqUW9JL3TkHhl0r82NBqkP?=
 =?us-ascii?Q?ZOlBLfYMyvdylNk1yC+NQmR9fQnKo5zeWJsG6/yN7XH4GyDxmbPl5vSYKvM4?=
 =?us-ascii?Q?K2ntX0zuGBbca3eIbIU2OpmSLnQSzMjpGC3r0TVKcXLAZ9Zagmpd47Hwd9u6?=
 =?us-ascii?Q?b+M+pdEcAL29T7tyPfzYYAtSXpv94GTxuX3NAz2mfFEt34OKZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:17.5414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab6c7f8-a614-4720-c870-08dd035459e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107

From: Yihan Zhu <Yihan.Zhu@amd.com>

[Why]
No check on head pipe during the dml to dc hw mapping will allow illegal
pipe usage. This will result in a wrong pipe topology to cause mpcc tree
totally mess up then cause a display hang.

[How]
Avoid to use the pipe is head in all check and avoid ODM slice during
preferred pipe check.

v2: Added pipe type check for DPP pipe type before executing head pipe
    check in the pipe selection logic in DML2 to avoid NULL pointer
    de-reference.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 6eccf0241d85..1ed21c1b86a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -258,12 +258,25 @@ static unsigned int find_preferred_pipe_candidates(const struct dc_state *existi
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
+					resource_is_pipe_type(&existing_state->res_ctx.pipe_ctx[i], DPP_PIPE) ?
+						resource_get_primary_dpp_pipe(&existing_state->res_ctx.pipe_ctx[i]) :
+							NULL;
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
@@ -292,6 +305,14 @@ static unsigned int find_last_resort_pipe_candidates(const struct dc_state *exis
 	 */
 	if (existing_state) {
 		for (i  = 0; i < pipe_count; i++) {
+			struct pipe_ctx *head_pipe =
+				resource_is_pipe_type(&existing_state->res_ctx.pipe_ctx[i], DPP_PIPE) ?
+					resource_get_primary_dpp_pipe(&existing_state->res_ctx.pipe_ctx[i]) :
+						NULL;
+
+			// we should always respect the head pipe from selection
+			if (head_pipe && head_pipe->pipe_idx == i)
+				continue;
 			if ((existing_state->res_ctx.pipe_ctx[i].plane_res.hubp &&
 				existing_state->res_ctx.pipe_ctx[i].plane_res.hubp->opp_id != i) ||
 				existing_state->res_ctx.pipe_ctx[i].stream_res.tg)
-- 
2.46.1


