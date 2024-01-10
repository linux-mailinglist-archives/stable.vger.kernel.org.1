Return-Path: <stable+bounces-10461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3BB82A3A3
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 22:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0561C24020
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 21:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509F74F61D;
	Wed, 10 Jan 2024 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ISyMRHkB"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0054B5BE
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGkrcSKf8fpTxzRCgsu/bnKTGml1Tstqufi7GA+0jSOwqpWIdlJ4wo79+vyxtaDfNUA4KoYUe7spdKBRJkxYI3zIKGi4aPL4Y5R6uW+7i8bTWwmRhtv+JgrGOdVEOjp9TU+2NmzBOP2mh1mb0GNVG4+riCRqe3FJWnMK/ME9LVjfYh8qPNyX2omsyArILmRSaLyNgeoy/6rYBzA8VEjHTsca7dZIK/S2RwiOYm8ZDu2r5RI5R19KXd+9v3UPJtmX5tDrcgRDxVL+IHuov1NJAFRHT4l+NZ72CyLbdSoC4yEpd1+t4hP0pMThywxXhZQNV3/13azi9Zus5xn2SSfBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCw9pJ4C3g1mgbzQa6mYW53YiSy8NJg6yjFP93UMWLo=;
 b=bh0OvSmShXgxpqOUZM3whkveRFMmbrep2Ovb/NNX6zsUG2xT+g4uGwIbd5z5knUqfpSi/p9eLUY1GwZ4jC6ZthaYYAI8GolZcrEd6a6tN6dzciW23G6jWF5MS1GkuP5utb6k/JrRNTEBDINCzjRCAm72v3IYoJVvrI5I+0FLUxaWOc+DkEjk/6ZLz1O3pWGDvS1oXL7Uut9hwFVSdLeYAfMJS5qmjC5aHUlLnvuDI0P1W/JxTKYFJ5Bl7dahEcIT4l6WNYmlg99dhSoPld2d3rO34sQJ8egKIeb2TFKeKKAz0YKutPM8SDkWnnxph7QhmUsMQz4ORCkZjGNt0Pj/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCw9pJ4C3g1mgbzQa6mYW53YiSy8NJg6yjFP93UMWLo=;
 b=ISyMRHkB5ExgIRmyBl5BHr20CEo87T6hOGJCprH51kngblD0scfDHoCZjS7MqHXWOGsD9iZrwLXl98cu8nShrPfsXT59nd0ZSw3SD9MtMCtaJERUsu/Y/uZI7joYUnWYv/xMbGwTI3HA+Sw/JAbF2nFKUxCSzRxZp1XSD/hZFUs=
Received: from SJ0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:a03:39e::16)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:54:38 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::19) by SJ0PR03CA0281.outlook.office365.com
 (2603:10b6:a03:39e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 21:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 21:54:37 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:54:35 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <stylon.wang@amd.com>, <agustin.gutierrez@amd.com>,
	<chiahsuan.chung@amd.com>, <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
	Charlene Liu <charlene.liu@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Sung joon Kim <sungjoon.kim@amd.com>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 04/19] drm/amd/display: Add logging resource checks
Date: Wed, 10 Jan 2024 14:52:47 -0700
Message-ID: <20240110215302.2116049-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad30c0f-adf6-42df-a424-08dc1226bd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9at7hNuV0MtCjwOS81VC4kUeP7Sz9b44kHLnb/1kS3i+nRccgKe4G9jSXMC2RtT59CN1GqgZf0wcpxLflofRcACYHZUhz5Cz7VuX8WEKZ2B3JaSTuyNFodV8vlcaXnE7qOoxMqA6hIPhxW0WVflsQ3i9+pf7ZttvB2r3+fveevUJawGP78Ut6quTZD0UGFE+5EYPI38klGs//fMsnlEIhEXULr01heVk7PxEPLXeKko3ZInwdw3jxuE4iWWMrE8eqYjZmnF5LyXc/eY0KbyQI03jNjUE+9j7pM1DHwso+SYVNRqcIOd4e4QCvQ049s2qD9ge+rtenM+bbBSr9vAial6P1DhVk4BfdVH5rl3MGOLLOUMz+2zEFF5v201HllmGM0nyXqFz/nqBxYgfa48vas165VYDYS25/8QQE5JYFBUQ0VrcDmzHqBwENvhkX5ocish7r4GTQUF6dgLQruV9uKScNT/T/VvCQSPYC7rgdd17iS86wSUbiJahaOBQzsrbrwNmuDCNpHJu9+/73I1JKMRQXDo/UwsdRcPeRKCO5FaYxHlFuEFCgw+Sx+c7CFzUfeISRgYLOi9lLDoPQgJo09dOzNCG3jTiaUQIwDXDrGndBcv9Wli+GFvLUde/R8CYjm1Ap8HPch1Amnfz3zMrzDBXa1SyUwsqXNCsD7lLJHimxGgdot4t3Z0WptgAZDyYPkfe/RIg4HBpwf5IecLfwRMOajxot/CqftdCAnra03K7ibLDzb7MEce8zSDs9C8Px5RjFOQ2RNwVmiAUSpR6jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(41300700001)(478600001)(44832011)(83380400001)(40460700003)(40480700001)(16526019)(2616005)(336012)(26005)(426003)(1076003)(36860700001)(6666004)(7696005)(86362001)(81166007)(356005)(47076005)(8936002)(4326008)(8676002)(36756003)(54906003)(82740400003)(6916009)(70206006)(70586007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:54:37.6544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad30c0f-adf6-42df-a424-08dc1226bd91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280

From: Charlene Liu <charlene.liu@amd.com>

[Why]
When mapping resources, resources could be unavailable.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 4 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_state.c    | 5 +++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 69e726630241..aa7c02ba948e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3522,7 +3522,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	top_pipe_to_program = resource_get_otg_master_for_stream(
 				&context->res_ctx,
 				stream);
-
+	ASSERT(top_pipe_to_program != NULL);
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
@@ -4345,6 +4345,8 @@ static bool should_commit_minimal_transition_for_windowed_mpo_odm(struct dc *dc,
 
 	cur_pipe = resource_get_otg_master_for_stream(&dc->current_state->res_ctx, stream);
 	new_pipe = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+	if (!cur_pipe || !new_pipe)
+		return false;
 	cur_is_odm_in_use = resource_get_odm_slice_count(cur_pipe) > 1;
 	new_is_odm_in_use = resource_get_odm_slice_count(new_pipe) > 1;
 	if (cur_is_odm_in_use == new_is_odm_in_use)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f2abc1096ffb..9fbdb09697fd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2194,6 +2194,10 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 	for (stream_idx = 0; stream_idx < state->stream_count; stream_idx++) {
 		otg_master = resource_get_otg_master_for_stream(
 				&state->res_ctx, state->streams[stream_idx]);
+		if (!otg_master	|| otg_master->stream_res.tg == NULL) {
+			DC_LOG_DC("topology update: otg_master NULL stream_idx %d!\n", stream_idx);
+			return;
+		}
 		slice_count = resource_get_opp_heads_for_otg_master(otg_master,
 				&state->res_ctx, opp_heads);
 		for (slice_idx = 0; slice_idx < slice_count; slice_idx++) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 56feee0ff01b..88c6436b28b6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -434,8 +434,9 @@ bool dc_state_add_plane(
 
 	otg_master_pipe = resource_get_otg_master_for_stream(
 			&state->res_ctx, stream);
-	added = resource_append_dpp_pipes_for_plane_composition(state,
-			dc->current_state, pool, otg_master_pipe, plane_state);
+	if (otg_master_pipe)
+		added = resource_append_dpp_pipes_for_plane_composition(state,
+				dc->current_state, pool, otg_master_pipe, plane_state);
 
 	if (added) {
 		stream_status->plane_states[stream_status->plane_count] =
-- 
2.34.1


