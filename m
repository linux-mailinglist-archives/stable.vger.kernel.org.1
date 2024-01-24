Return-Path: <stable+bounces-15614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019083A29C
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 08:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85243B2115F
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 07:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8327F134CA;
	Wed, 24 Jan 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q9Ys+d1F"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF0168A4
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079883; cv=fail; b=iATLXbvhkE1/Pmz53uXEpj6MV+3XjloQfh+/Udq0RN91JS0aa9uQ/iwkCNwZ9UfFpx42YnWclU1dQPpCtH1FJ9jFwWoUuxv7pIAaWptfYO20yw+k48pn/LpV+PFHTXNIZZC5S9+WDy2TIdgKcF/B6yJWXozwiWSf+GLk/pe1EYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079883; c=relaxed/simple;
	bh=DMXEbz8cq4Q4NVCTmr7HFxL+VulnrSthu/Ntmw41B6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbXgpwg58Hcm7yrRp6P0RQBq0QgE6fDOz6o/jZETGhWRX7QiaifST+SNV76J3asMngUhbScitl8jgZzxi3XEnCenAXDx/bih9SLubsfkuoQxmPs+T2rx+NUrqYpUKbsGjOQLrnCthRt2Fo90Ubs5S+Jl1YkTTlFIsXNCJXXPsao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q9Ys+d1F; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrpRZ9kgdt8khkqqEvDYHMfo36jjVHtQ5QSLqFcsTpV6B0HvSM+PsXXyMvw/4jM1iycVID6Dv7HhVgyd8G1CTshmas0uJDHyyVAkAGFycQ+JjYwNYLCTQa0rCPaY1sdkBaXEKvP9BluNq1pr5IL7Cl2NMl6si9xFKua1DYobZEY2L2li8Oxca50Pj5DcTO6R7SsQ9NymLLgAqq3ZCoSYWluHxy4zpZAUuYPQ8ha2cobFjdvBlvLkxJFLCvcRMmW3IOE2zKO9LXf2NnOr+vxlI34S0iO9O7H9T0pAx6UEqP0Wx5KRojhog1bMV0X6l6rXBoVmUp9rIOcXEYISr8tivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b4AuTQ/ST027Y350I/eVLUHk2pFMzj4HK2/5h+C0is=;
 b=ARZch8CilI33lt6vfwRb99L6YoV+dyf1s3qw4Wqyf4m0/HPwqKBWHnNWKFNGz7LvuWUGuKbWJHz0Ed9ejMSMy2M5daz6Y7Z8fZ0cEqpkv+ZTd0ejUWXNQ7Z6/WLuSQWyaDnMGOd/s5Foc2cz4U4dfwr3hbcJsg2i09s869rcW6vSBTmaliyINfzvjRYxFz3L8jdaYvvh9Kx1OjE2ZBqwTb2Wo0DK11D81FXBDnGGyDTMGg1LZfL/l4FoGfllhWXs9fKsXkTYSp/UpWNfq4Q6GUSC5sY6Eiw6z7ovjNqNeqsEa4PaQK1i1n66GkLNvUW82EX+QmoTwzCw03qIlLWe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b4AuTQ/ST027Y350I/eVLUHk2pFMzj4HK2/5h+C0is=;
 b=q9Ys+d1Fm9FKwEGh4P578WkL+c79x+wlugIOyK55XVfZktCydIAWMm91febA2y6l8qhttdV1m1vrEl2ySFttYfsD5BGjPY39EFpTHvD+G0KtuAqb6iZJ5ws5D8tZgyYYUqkA0hBYGqH2CDTC62yPoTYQicTBIuGghLeTWlFxV10=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:04:37 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::3b) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Wed, 24 Jan 2024 07:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:04:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 23 Jan
 2024 23:03:50 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:03:46 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 19/22] drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue
Date: Wed, 24 Jan 2024 15:01:56 +0800
Message-ID: <20240124070159.1900622-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 7699e36f-40b8-46c7-1d68-08dc1caaba3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xVEgGSDWIb9BLQbOSHFu0ne2Uaz8Um52XUatkT6dUe3p9WyvbJ7HMY+VrUVgzbBB8E+R4aRFN9vy9yDRzwgwdKliDhkDK3EmSHAPO+SLHiveupXhiPSjTJqpVMuufGKBppa3W6QoeXgvV/aAvJ268ORc+Fe4G0pwh9z4IzXgDpjViPRdbF/8djJmT2Ciw1ekUd5u4y8l9V0PRH96LIsawiLEjvBtswqfn5YRYy9Wpnr9s4ko1Ha2uchDv3j7oot9ErRH3l9Dkud0Wi4HAuEMGkD1OsCG+iRVoN40MXuIoyHcq4ezDKzqx/oacY/BuFQXjbRjpblTey3oktnpjA1Do1Lc+WexZ/QN+ksObSxhZTit7fQ4JzhXlqrdcdC3VCelCeXW50cHuvQYJ8Jfx97KMH9bFB/iaE7IEr6AHaffTreFjWe7TcSFU0z7fsoNRgxO22WjxqfvT9iRUpd343uR5tlF830T0LHAiRTd6oxSujNIWbYygdourg1ObtHvabjhBUqMjuKYopkC6vT2M90z35iHYj7RbyuSsYqvkPkK+FR54zH1QFZFLTLpvzFmLS9TjMhqaAMzQM0zPlpgO9k4FgqtNjGSCyTuoSMxpS6+vc5ZR7IZQl3ozmwI9ZSrSEP2d7/8GqXzBdcDamZahiyiypZQlFF7bevWErah/3kz8Z361TGpqMJ4AG3RJCuEHqXDBqPrKKqKMc21N1dHRnQysdGmCYPr1YSXvQm8Y2mewjQcGOVbVXBZUwzH3/DxH1NHDeN3oIbL0MKQqWNtUCuNcA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(5660300002)(2906002)(83380400001)(47076005)(426003)(26005)(81166007)(6666004)(336012)(2616005)(1076003)(7696005)(478600001)(41300700001)(40480700001)(40460700003)(356005)(36860700001)(4326008)(36756003)(86362001)(82740400003)(8936002)(8676002)(70586007)(70206006)(6916009)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:04:37.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7699e36f-40b8-46c7-1d68-08dc1caaba3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314

From: Fangzhi Zuo <jerry.zuo@amd.com>

[why]
odm calculation is missing for pipe split policy determination
and cause Underflow/Corruption issue.

[how]
Add the odm calculation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c | 29 +++++++------------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 ++
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 8b0f930be5ae..23a608274096 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -791,35 +791,28 @@ static void populate_dml_surface_cfg_from_plane_state(enum dml_project_id dml2_p
 	}
 }
 
-/*TODO no support for mpc combine, need rework - should calculate scaling params based on plane+stream*/
-static struct scaler_data get_scaler_data_for_plane(const struct dc_plane_state *in, const struct dc_state *context)
+static struct scaler_data get_scaler_data_for_plane(const struct dc_plane_state *in, struct dc_state *context)
 {
 	int i;
-	struct scaler_data data = { 0 };
+	struct pipe_ctx *temp_pipe = &context->res_ctx.temp_pipe;
+
+	memset(temp_pipe, 0, sizeof(struct pipe_ctx));
 
 	for (i = 0; i < MAX_PIPES; i++)	{
 		const struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->plane_state == in && !pipe->prev_odm_pipe) {
-			const struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
-
-			data = context->res_ctx.pipe_ctx[i].plane_res.scl_data;
-			while (next_pipe) {
-				data.h_active += next_pipe->plane_res.scl_data.h_active;
-				data.recout.width += next_pipe->plane_res.scl_data.recout.width;
-				if (in->rotation == ROTATION_ANGLE_0 || in->rotation == ROTATION_ANGLE_180) {
-					data.viewport.width += next_pipe->plane_res.scl_data.viewport.width;
-				} else {
-					data.viewport.height += next_pipe->plane_res.scl_data.viewport.height;
-				}
-				next_pipe = next_pipe->next_odm_pipe;
-			}
+			temp_pipe->stream = pipe->stream;
+			temp_pipe->plane_state = pipe->plane_state;
+			temp_pipe->plane_res.scl_data.taps = pipe->plane_res.scl_data.taps;
+
+			resource_build_scaling_params(temp_pipe);
 			break;
 		}
 	}
 
 	ASSERT(i < MAX_PIPES);
-	return data;
+	return temp_pipe->plane_res.scl_data;
 }
 
 static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_stream_state *in)
@@ -864,7 +857,7 @@ static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned
 	out->ScalerEnabled[location] = false;
 }
 
-static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_plane_state *in, const struct dc_state *context)
+static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_plane_state *in, struct dc_state *context)
 {
 	const struct scaler_data scaler_data = get_scaler_data_for_plane(in, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f74ae0d41d3c..3a6bf77a6873 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -469,6 +469,8 @@ struct resource_context {
 	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
 	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
 	bool is_mpc_3dlut_acquired[MAX_PIPES];
+	/* solely used for build scalar data in dml2 */
+	struct pipe_ctx temp_pipe;
 };
 
 struct dce_bw_output {
-- 
2.34.1


