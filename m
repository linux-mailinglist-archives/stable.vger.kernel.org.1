Return-Path: <stable+bounces-195386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFBDC75E7F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28BEC34D73C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7F33D6E6;
	Thu, 20 Nov 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UUyTRMFJ"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B302FE57B
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662909; cv=fail; b=K6OVnA+30hdt9GpG67qTnimK4L+ucEgunB2VZEZpZ92vGCDMV/S5hAilqZeuip5PAexaYGHagVsc00CAy1oW2d51FNBwK6dA2lbUDimg86zl5HCmAo7dqIQaAQ249uocq96skppwfmSIFNBBfmgXlAduV04hB5muQTKxwTJucvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662909; c=relaxed/simple;
	bh=TcSgySA91xFV2ywUyMpAARe+emyp67naCqNnrMzWIUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNBhMZX9J5Xlo2pivR0DxhH6AxXrlK0Qy0x0BnNmiAhfylG783TIS/rFqvK6S2Ov03YgVNNux1X8p07Fzeq6FeQvKBhqoT66r2Y6D/Gi2ZJgkvwH6teHKsXVhFDjuh9PtEiKorWaTBEU1e3WzmC99Cf0ji/MKrpU122tNPnVzmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UUyTRMFJ; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMOeewzgjjKbAhUfLo6wME55wulM8BkOS+hoITea3h8i006OZVwGF4/L2e2mn2EXb9ogAwNEb6jRDnPYZRn7DViXGcjBR6cDaQzUKJh6/NfclRpIekJftrOHHy/IPyjs7hpGwlHIXIDtaePtmmxTy7jZ6em+6GXdENmYwE04/UJANEi170+Y0J1ZTLQguc0A2xcOapXWlAYZFzF/MouFCnBalFZTzN5qjNvpZVC6ryqWzb+LKa/JJqlPhC/opSxbtVCHqAW2p8sQ1DwrpfCiwqkHBBvyRicHaHiaOyFpXhv6kivxxM6TOju0U1OlXOm6hR+4sFe/hc1sDvcnQLGW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf/c3ruDIq6tA2byeueXX6UNx6mFcfRwaKeyGleSCOw=;
 b=hbp3+nzo4TWH9vXoDQ8cU8AOE6iZbJMBeL6wi63mR7JaOVQui/e+dPs6lI9etn+0UVZHxYkIFTSj9KcoRJ0C8PmV5CmYx3Y/NBrwosgBL8x+aXQKHKygorPPsU47tCsAbNxqFPiJPhBihzxMm2Ah3qb0tWfyv4kOZYUiqIWaGYH5O+Ldu+Hw8qDyQK6etZ9MApcVj9LaIorkPdMIxAyvd7Jh/7glvaP9grjb/jRWnm7iVFZgIDN4cT6ghvrmPzZ4ggmT7A2M45DI3gkX8OPWgksDJt2E95jQ9s9x0NpWVMsVIMeSp6Pp7XWNkW8TZoYPzXhY9pI0Q5e97O/We/lZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf/c3ruDIq6tA2byeueXX6UNx6mFcfRwaKeyGleSCOw=;
 b=UUyTRMFJ/Ta3OtYa26CwLs6NvOOizKEpFEm520tAUHyoXDlMhrr0sQ6ad4AEsBLzp3dobam/OlDHofGd3PLM2YZdS8lRhvUf6dKSQMibY8n1ZTDaGj7HKiL2MQmg417wOg+sVVl7gpnXOu1goTZgWkRcGNoYIft4LIq3fSIJhAA=
Received: from CH2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:610:57::35)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:21:43 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::c) by CH2PR12CA0025.outlook.office365.com
 (2603:10b6:610:57::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:21:43 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:21:40 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	"Mario Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Dillon Varone
	<dillon.varone@amd.com>
Subject: [PATCH 19/26] drm/amd/display: Add cursor offload abort to the new HWSS path
Date: Thu, 20 Nov 2025 11:03:15 -0700
Message-ID: <20251120181527.317107-20-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b2e6c6-ad33-41c9-c3db-08de2861a82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ljNbvf/hice4LoEchu2T2WaOo3TBFXhQcf2idxVvzai0Qvg+D/7NeNlV4g6G?=
 =?us-ascii?Q?ObzFZvb389P4XDM381brELOsiHFA9SoMSbl2S5BQaksrwItNXEFFIEIXD6YC?=
 =?us-ascii?Q?C0OeUvlYdqPUNN80E05twlXl2dQZs+pHez8+dbkuUdTn1XwIlnwcZA2vLouo?=
 =?us-ascii?Q?QUorQDPDHnmuSVa3Xdk7XqxlAMUkY3Qxl4QUeGI5wjTSETKez7UL+tvLBBe/?=
 =?us-ascii?Q?vwwoIHuAtgQKAmrA9V5xnOlGMisQiZjN4+xPQEkJartBwBqc3gX5P2vMjYrZ?=
 =?us-ascii?Q?yffTfUr7RgLSpKcIurHwdUMaPGLRuZGyzrs5qMYwaOiu43hEyKXKy+FLj/HQ?=
 =?us-ascii?Q?M5OXB2kNzkg/1ZksyFMTSFn8dwPm6wkm127obxJ5KBdt7lM4YY1LdFh30qAw?=
 =?us-ascii?Q?/vmMzK7ZDY2BpbQA2zxiJEM3somZ5SAUKEyxKOQgAhmLEPGMnHremEnL9BoN?=
 =?us-ascii?Q?Hq7vw+QctzOk9qS+TLacVSsnQt6QCuvn8S41bta2wj7/khDJo0D+x566Bqdc?=
 =?us-ascii?Q?aOPECHNGvA4RANuwn7NCvL94Xv+/JyZmuo3mNUQLLM84glN984IyloyivFFO?=
 =?us-ascii?Q?iw7XbMFLREP3FNYXpbF4b4YLhyk3iT3v/9slptLJM3De95GrVDl1IBug4JeM?=
 =?us-ascii?Q?q0naR2h0U++tw2FCH6T3ao1FqRT3ZaEXZIHdhZeTpniAAjd6SZnrbKg2V0L3?=
 =?us-ascii?Q?73I9o3rqiGK8jk2f0oygJyHejaCxpSv8YUaSGDQUG4XSAr3nggJPc5VVTVEC?=
 =?us-ascii?Q?drNfw+8YqAroQUwuF1JctCkAMuN99HwjFA9l6PiTbPYudbT8asEsMEqEEk+e?=
 =?us-ascii?Q?QPIZrGtieYOJ6gR7x8wlwZiNzBuJgAqeB7RWtSbXvVKufHhweTbh5v/YFKNw?=
 =?us-ascii?Q?Abtv7UXzj3Xl5o5ybf2HvHwMSd7aOThh//omIZ1cKu9lNFbkWqlDr71t+I9v?=
 =?us-ascii?Q?AAA31oD8cPfCmSQkLctEeivJlug3tEnj3Y3+wmFnFzSSUl5/fUjA2tvPkldr?=
 =?us-ascii?Q?KUAZ3JfpbGFyExSwFXUUJBLy1rqyS16NBINNLcBS77GR1PgS9Cjfbs7WeQHr?=
 =?us-ascii?Q?Aj1gT2PycLdHJnmzHBB+pXXGAn6iv98LaaZM/ohFDuU4Bg9BNUh0KKHQvCNJ?=
 =?us-ascii?Q?5GSIPv8mUuQ3fN7taig4LGdao+kPPMigbZo7KgTR/de6Grn7nNjzk3Uym+Sa?=
 =?us-ascii?Q?pqyLY66NBadkjQ+Wy9ag15s5hicPsEnXegMCsQUnFCEMwVXxMg2X58kbpQ7r?=
 =?us-ascii?Q?2YRkwv4wYB6o01WA3kUjQ/wskVtxSBo5z4aDfcuNKfqFfKPHueJ76suW+qL3?=
 =?us-ascii?Q?QZ1L5Q3EAsYbpiglNe5bGdZxvUgUDLektgtT98Z4WrCuSsZlEJV6L3OJtXj6?=
 =?us-ascii?Q?YvT67XKxdp+NMdh6LjgQIQ8VF2F1rO7kukneUEnT4Umb62TG9p2o2ai/OkQj?=
 =?us-ascii?Q?1yvfcGjMfLhUcfJ1WRIHBcFtRlIjHEXJaLliTr1xHC/knhO9NdI+21ZLeedX?=
 =?us-ascii?Q?y8ELhxTtUVcHGEKrFilQhwC3hPwK58ryWV6lJ39MPBoJJBrkizYb9IJwEwdu?=
 =?us-ascii?Q?CMBR2Crfcxnm101r1DA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:21:43.0700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b2e6c6-ad33-41c9-c3db-08de2861a82a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[HOW]
If cursor attributes or position are passed into DC via a stream update
and we take the newer HWSS paths then it's possible that the update
races with cursor offloading if it's enabled.

This can cause the cursor to remain on the screen if no further updates
come in if it results in HW cursor support being disabled.

[HOW]
Add the abort into the HWSS path so that cursor offloading doesn't
attempt to reprogram the cursor with outdated params.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 24 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  2 ++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 13 ++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index a01cb2897aab..e2763b60482a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1293,6 +1293,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case HUBP_MEM_PROGRAM_VIEWPORT:
 			hwss_hubp_mem_program_viewport(params);
 			break;
+		case ABORT_CURSOR_OFFLOAD_UPDATE:
+			hwss_abort_cursor_offload_update(params);
+			break;
 		case SET_CURSOR_ATTRIBUTE:
 			hwss_set_cursor_attribute(params);
 			break;
@@ -3076,6 +3079,15 @@ void hwss_hubp_mem_program_viewport(union block_sequence_params *params)
 		hubp->funcs->mem_program_viewport(hubp, viewport, viewport_c);
 }
 
+void hwss_abort_cursor_offload_update(union block_sequence_params *params)
+{
+	struct dc *dc = params->abort_cursor_offload_update_params.dc;
+	struct pipe_ctx *pipe_ctx = params->abort_cursor_offload_update_params.pipe_ctx;
+
+	if (dc && dc->hwss.abort_cursor_offload_update)
+		dc->hwss.abort_cursor_offload_update(dc, pipe_ctx);
+}
+
 void hwss_set_cursor_attribute(union block_sequence_params *params)
 {
 	struct dc *dc = params->set_cursor_attribute_params.dc;
@@ -3934,6 +3946,18 @@ void hwss_add_hubp_mem_program_viewport(struct block_sequence_state *seq_state,
 	}
 }
 
+void hwss_add_abort_cursor_offload_update(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = ABORT_CURSOR_OFFLOAD_UPDATE;
+		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_set_cursor_attribute(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f02edc9371b0..01b0f72b6623 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -3675,6 +3675,8 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 	     pipe_ctx->update_flags.bits.scaler || viewport_changed == true) &&
 	    pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
 
+		hwss_add_abort_cursor_offload_update(seq_state, dc, pipe_ctx);
+
 		hwss_add_set_cursor_attribute(seq_state, dc, pipe_ctx);
 
 		/* Step 15: Cursor position setup */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 3772b4aa11cc..8ed9eea40c56 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -696,6 +696,11 @@ struct hubp_program_mcache_id_and_split_coordinate_params {
 	struct mcache_regs_struct *mcache_regs;
 };
 
+struct abort_cursor_offload_update_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
 struct set_cursor_attribute_params {
 	struct dc *dc;
 	struct pipe_ctx *pipe_ctx;
@@ -842,6 +847,7 @@ union block_sequence_params {
 	struct mpc_insert_plane_params mpc_insert_plane_params;
 	struct dpp_set_scaler_params dpp_set_scaler_params;
 	struct hubp_mem_program_viewport_params hubp_mem_program_viewport_params;
+	struct abort_cursor_offload_update_params abort_cursor_offload_update_params;
 	struct set_cursor_attribute_params set_cursor_attribute_params;
 	struct set_cursor_position_params set_cursor_position_params;
 	struct set_cursor_sdr_white_level_params set_cursor_sdr_white_level_params;
@@ -960,6 +966,7 @@ enum block_sequence_func {
 	MPC_INSERT_PLANE,
 	DPP_SET_SCALER,
 	HUBP_MEM_PROGRAM_VIEWPORT,
+	ABORT_CURSOR_OFFLOAD_UPDATE,
 	SET_CURSOR_ATTRIBUTE,
 	SET_CURSOR_POSITION,
 	SET_CURSOR_SDR_WHITE_LEVEL,
@@ -1565,6 +1572,8 @@ void hwss_dpp_set_scaler(union block_sequence_params *params);
 
 void hwss_hubp_mem_program_viewport(union block_sequence_params *params);
 
+void hwss_abort_cursor_offload_update(union block_sequence_params *params);
+
 void hwss_set_cursor_attribute(union block_sequence_params *params);
 
 void hwss_set_cursor_position(union block_sequence_params *params);
@@ -1961,6 +1970,10 @@ void hwss_add_hubp_mem_program_viewport(struct block_sequence_state *seq_state,
 		const struct rect *viewport,
 		const struct rect *viewport_c);
 
+void hwss_add_abort_cursor_offload_update(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+
 void hwss_add_set_cursor_attribute(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx);
-- 
2.43.0


