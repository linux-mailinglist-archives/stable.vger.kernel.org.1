Return-Path: <stable+bounces-27441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047148790EC
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 10:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860F51F25AC8
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF33677F3E;
	Tue, 12 Mar 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WFVQNL6x"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616877658
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235514; cv=fail; b=lRl3MsOKNQdalTyigEk4ZiLqGii8jxxABHxakGDA3ZsnvbiTBDddRpdCE9u2QeDiQm0YUQOJIGyZtHxrDdE8gxfrJcGirbNscPteffToOUIgBo6eQH5evwzgGPiEEGI1KASM7yMj1VJGF40y3ZtekS7g/RNVIz5zIsMu5Wli5fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235514; c=relaxed/simple;
	bh=yxCOgT787IC7xRArBpyUcqy4kPXIIKqfnAippWzQ80Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5AROYjESU2vnJaoqHWFnTejxsXdsr29oWnSDisEIfDhc0I+XxyE3lY7fHFPvqamZi7eL/n+uySHh1QmUczqgVYNwh1025kzj3QBkvwNBV7h5fltrxsgkQ2HDl5QamhWjCBP8cfvaAQEpoOolD73lJ5NsGbvI6/Rkri9UCBcq24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WFVQNL6x; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7UMFtCrsU2L0kTHrxRIRMdY8YiLKERELxfC6mDjhLZr1ZyYPhUyrDM6BBjVwskm2clAZrtYSlkNYp+EjBSGo34+yGXg+nAWoUKVPHQyGz4SWHL9otUUQiOfixmBafIQ5XFNV5TkZmsyX7JDhwp/Xj6lHxY7fKG2Oo4Hhwm2rjk7hDsg6eDAVRTHKPVsN8iegTpkxlUElT5BjWESaiP+T9nZDiqf20N57NN6c/PveVGJPuY/ENU/sdQQlu1o7IoToyvvQSf4KbQgDFfWRJT+Ej4LnxPoTf0bb+ZL6mn39s+8D3JTFFFDaIAL0vLjAF33aI4rdWryj5BiT7GRCo3P+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/IzfeX3pRcwPD7nL764wtPTgAljoQ2bISq+Sdox/iA=;
 b=L1xpUAEW0DCp3CCIdf4YiO/R7lz2CeNF1x3vpxP50d09dQl4csrwTVdVang6l2Xw4q7TZfbJ0UZHuoBdVsW6afBt9jBxhaNf1kKdqUNRdI6Fo8YTK6mGkvJxfjsJKFeIAbw8TMmNrpy7E2C4vzQHrixveHwvZpuBVJcyYJphy/hcU1B4U2jnGUIF8GNYZj/VbKCbrBpxL8g1K+ifCPU6Fl4bsDsQ4tuVmSeB6JG+279nFIcjGKLruknkbGzL/GO1S8I/KZjP8THueoreAm5V1Q6rRJo9xmEUSqtTqSp7jlOmOMUOnzXTugCKH7YTIGh9JYzUbcPHKXPVSJz/Iy5vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/IzfeX3pRcwPD7nL764wtPTgAljoQ2bISq+Sdox/iA=;
 b=WFVQNL6xHgt5CQTGyhOu9AlXYpxXlMTkvT0SbMw4LZdNFBS3rKP7ChycoYj69iyEnCVFBrjqYD9YKEmiO1WAFir03yuqMbTWeSiG2lfVSytp1e+Rcg69kc/JxIYValnPfzF2w6I112nNERcy9Lw1n2bVY3LB8g7iNyIy1X+b6jg=
Received: from CH0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:610:b3::13)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:25:10 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::e1) by CH0PR03CA0038.outlook.office365.com
 (2603:10b6:610:b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Tue, 12 Mar 2024 09:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:25:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:25:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:25:09 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:25:04 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Josip Pavic
	<josip.pavic@amd.com>
Subject: [PATCH 41/43] drm/amd/display: fix a bug to dereference already freed old current state memory
Date: Tue, 12 Mar 2024 17:20:34 +0800
Message-ID: <20240312092036.3283319-42-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 727a30b5-6281-4387-7d3f-08dc4276507d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H1/UR1H8yOClnIpnJNhZ8g7BRLX9Trkp6whVmFihfjsfFVsy8njMqJqGeWZe+FzeE1QQRK8gR0p4sksxwqob3Uglt1eDYdrPoq7SrCRC6z8T7kEd8OY250GxnRXSlppL4PG4Uv4whNJhamnKT+I1TQ0Ye7oaTRoB3NVxAF9qsRPuSo8AdNKHY6NRGN39WM/pdb3Y3lAITZH1YWMAKVlBaNEer7s9ruRmznSf9rPSvxo82IpxsGKpMYJVfJTrB4ckzkrVSh1GpYWLz3MZ6DgiQYJSmMPNjaN1eezvcaI3vE4OBZyckjCiU2Jbky2RqIBix9rPtcu7E+yeDaAgTJJFOdQSWJMh+h27kJDztIecaPqUQN22eUTYQt6VcuoZfaPHURxo4niozcBegLGC97ijXhHxDzr0NfdScElZ8pjQ/15QIF2ZVIE8/HntvO4ngNgfzKEamtUU4gwbP33aoHHeQB2abgFcJ+JUPh4FOM2u5Mn7c54O3g360B6QaTuXy6D8Ac1vK3c5NRd7c9HbodMxGctbfLRuDpU9L8f4AGcvpEtdTjHcBg0MmOi8o6X0e/LUEfNLIXHStLFA+bECiWunfh6GXRi3i5yvwhTsw1MQe4g8G3Tt36aWB7QxuzNsvio2hdqs5cM+HQnvuEuYjA0HuU1++QRzwXRQ3oF/TxfXX8JGWJPV+YbfyxEz9hhz0BnxAM/AkKfojkSk4TbcceXqe+GfSo8AXfGrwRWxpcw9KdPIXxhXyCi985SwgSIAjkmw
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:25:10.2805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727a30b5-6281-4387-7d3f-08dc4276507d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
During minimal transition commit, the base state could be freed if it is current state.
This is because after committing minimal transition state, the current state will be
swapped to the minimal transition state and the old current state will be released.
the release could cause the old current state's memory to be freed. However dc
will derefernce this memory when release minimal transition state. Therefore, we
need to retain the old current state until we release minimal transition state.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a372c4965adf..ab0c920333be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4203,7 +4203,6 @@ static void release_minimal_transition_state(struct dc *dc,
 {
 	restore_minimal_pipe_split_policy(dc, base_context, policy);
 	dc_state_release(minimal_transition_context);
-	/* restore previous pipe split and odm policy */
 }
 
 static void force_vsync_flip_in_minimal_transition_context(struct dc_state *context)
@@ -4258,7 +4257,7 @@ static bool is_pipe_topology_transition_seamless_with_intermediate_step(
 					intermediate_state, final_state);
 }
 
-static void swap_and_free_current_context(struct dc *dc,
+static void swap_and_release_current_context(struct dc *dc,
 		struct dc_state *new_context, struct dc_stream_state *stream)
 {
 
@@ -4321,7 +4320,7 @@ static bool commit_minimal_transition_based_on_new_context(struct dc *dc,
 			commit_planes_for_stream(dc, srf_updates,
 					surface_count, stream, NULL,
 					UPDATE_TYPE_FULL, intermediate_context);
-			swap_and_free_current_context(
+			swap_and_release_current_context(
 					dc, intermediate_context, stream);
 			dc_state_retain(dc->current_state);
 			success = true;
@@ -4338,6 +4337,7 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
 	bool success = false;
 	struct pipe_split_policy_backup policy;
 	struct dc_state *intermediate_context;
+	struct dc_state *old_current_state = dc->current_state;
 	struct dc_surface_update srf_updates[MAX_SURFACE_NUM];
 	int surface_count;
 
@@ -4353,8 +4353,10 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
 	 * with the current state.
 	 */
 	restore_planes_and_stream_state(&dc->scratch.current_state, stream);
+	dc_state_retain(old_current_state);
 	intermediate_context = create_minimal_transition_state(dc,
-			dc->current_state, &policy);
+			old_current_state, &policy);
+
 	if (intermediate_context) {
 		if (is_pipe_topology_transition_seamless_with_intermediate_step(
 				dc,
@@ -4367,14 +4369,15 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
 			commit_planes_for_stream(dc, srf_updates,
 					surface_count, stream, NULL,
 					UPDATE_TYPE_FULL, intermediate_context);
-			swap_and_free_current_context(
+			swap_and_release_current_context(
 					dc, intermediate_context, stream);
 			dc_state_retain(dc->current_state);
 			success = true;
 		}
 		release_minimal_transition_state(dc, intermediate_context,
-				dc->current_state, &policy);
+				old_current_state, &policy);
 	}
+	dc_state_release(old_current_state);
 	/*
 	 * Restore stream and plane states back to the values associated with
 	 * new context.
@@ -4496,12 +4499,14 @@ static bool commit_minimal_transition_state(struct dc *dc,
 			dc->debug.pipe_split_policy != MPC_SPLIT_AVOID ? "MPC in Use" :
 			"Unknown");
 
+	dc_state_retain(transition_base_context);
 	transition_context = create_minimal_transition_state(dc,
 			transition_base_context, &policy);
 	if (transition_context) {
 		ret = dc_commit_state_no_check(dc, transition_context);
 		release_minimal_transition_state(dc, transition_context, transition_base_context, &policy);
 	}
+	dc_state_release(transition_base_context);
 
 	if (ret != DC_OK) {
 		/* this should never happen */
@@ -4839,7 +4844,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 				context);
 	}
 	if (dc->current_state != context)
-		swap_and_free_current_context(dc, context, stream);
+		swap_and_release_current_context(dc, context, stream);
 	return true;
 }
 
@@ -4941,7 +4946,7 @@ static bool update_planes_and_stream_v3(struct dc *dc,
 		commit_planes_and_stream_update_with_new_context(dc,
 				srf_updates, surface_count, stream,
 				stream_update, update_type, new_context);
-		swap_and_free_current_context(dc, new_context, stream);
+		swap_and_release_current_context(dc, new_context, stream);
 	}
 
 	return true;
-- 
2.37.3


