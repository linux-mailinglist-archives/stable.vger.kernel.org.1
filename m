Return-Path: <stable+bounces-28459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7C880B4F
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 07:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1541F22505
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15ABA34;
	Wed, 20 Mar 2024 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MruLDP4p"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DC1EA8A
	for <stable@vger.kernel.org>; Wed, 20 Mar 2024 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916614; cv=fail; b=p0tdry5OwJFLoQRPIxWbHODX543a/ICb7n89utA2Wyf9I1de9PtEIukQETCHzSi8Z09A/2oOF3I3DZ7muz1NHDeOUB31AshPyd9Y2KI6YV1u98I6TtB0kv49u/XBbnd2iOQvWXfmF0WaW5hZDLoGn7FQHCRUMI/KBAkvaqYReGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916614; c=relaxed/simple;
	bh=EVd0kCHMMsEAws6SdBn5uoJBhN5dKdk987RJXVwwv+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcBmWJ/2XLSE7lOKAdvjV8A1nNr4aRz0fHA5SDsx7MWB5rF/QO64QvzFLR8sf0vJZjmbNbDLf5kOgYiTrmLJHf1GMA25OLUJN6+Po48ZbkThNAlM2JQ8FpgvfU7jNhIC3A2pUGzwkMdTvRlthwuMgzSpWF0qFvdj+e//1/4YT/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MruLDP4p; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldQJeV+xUOCWRQ1DPB2mjuCD/7oKpWLkWIvnFUFrBDlEJ/ETrjcPqgWo71Itk5D4pNg8Xi0kxhFqwKpRKuIt61hjaYWFTsw+Mzgaa5Ctcsm46aBHiMJ0o1cbytoQztT+KGxa9Dry+CUQwFeExzgc4iNBRHP6Le2i9yhMEcn74r8YWltNOM8qHbIpKmIGyydpm3XKKT2rAEVMgE9VY3NARYlcCx9w4Yk7v93VM9oLcS0wSxaN86Xku+jv8/YzmdgOXMhbrxsRnggMrcS1Lb9pNP2SQEU9Ii4Ud9tmt04iV1S4x168TLXfyMh1RwGYDOGNwqb9VSxMfovAXxds1g7WmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L67WSdxg8MgDN7zj8c11/bffN2wQyfSuPXp9ma2aJSQ=;
 b=Ir+kfFnD8QNr9ZtdurTyRZ/BYw8DatHKNaONXlZO/nzWCSK7gPKGjeb3xWpFhAmznCn0M2J0O+BONiQF1EC/Eq2G/cmcWuqNPzr9s6AMfGSTQSxzFUw6f/mF+FpCy3swD9n8H+eklZxv6O/t4KlzpklyHQ5poIZR4nw36ALxCl0ekegsOM6nUovkUwYAbq/qgsEGsQ4xvvK/g2jsC/1SIE8apOrSGX8cDv4NDqQRO7hzJd1BtIYOwy7KByrDK3gf+VWNooQi9y8cSE9ZX0qcexzEzqh0rg57sGkLqUbcgzTU5m8KF5qqlYLyka4KdBosCbSYcMbQ481z2RMrahoPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L67WSdxg8MgDN7zj8c11/bffN2wQyfSuPXp9ma2aJSQ=;
 b=MruLDP4pQTpoYA3ZUn2ISZo6jInycj5pZevMr/0JJ7KmQP4+DCANIDq7n491Ds2nVI84UlvqJ6QnWDHAIcnl6ex2CwSxQthXfaAX5Ud+N5hIX1hZqKuFyqlAkRgF2eG10DFILbQw1VlTcYQ0a5seqw3BOMpWhoQ3WykEVySFC2M=
Received: from MN2PR15CA0034.namprd15.prod.outlook.com (2603:10b6:208:1b4::47)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.33; Wed, 20 Mar
 2024 06:36:47 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::6b) by MN2PR15CA0034.outlook.office365.com
 (2603:10b6:208:1b4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:46 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:43 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, George Shen
	<george.shen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wenjing Liu
	<wenjing.liu@amd.com>
Subject: [PATCH 11/22] drm/amd/display: Remove MPC rate control logic from DCN30 and above
Date: Wed, 20 Mar 2024 14:35:45 +0800
Message-ID: <20240320063556.1326615-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 743cf90f-fd4d-489f-73dc-08dc48a81e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t9F6uXNxOq2OwovWHEBOtW1AwGYVb/yaWC+NdjQjFBtUNNdNcm3aQkv/cl1xoY8Kc/VtVd+PmFEoFES6/zsJX5Bv/W0hyHv5Q1uDPGH5WJYYMgdQ66477vonVgoMFyN2a/uGZD7zLD6DkmsnQR4pPpAasBYQhoXHbFZqz/qU4uy3K81qezx6IziWw9SaZ9YRLueoqinqGE9NyFPyDNAWfFRz6uZOc5/3nvXZ/o6RciZVfWN53W3SCPwqwm+qrJWPXynCxEPz5bJqVgvjdT4kvfufRDwXOGwO0WswC71f6TtjNkWrtiVhir4vRyYiymlMImrevlSuvIr8cFlB/IkYEFkGzZP4nNHiLQSGiyTMlRSbDlHngVlzHZWZG43DpaQ98dBHOdRRfu+1vgiUg1DUtfNIJWiqDiBP8dTTyyA5pNEd5e9ap/T3Oi6W0VdKk62I0TA4pGshcFm0oPBSMSHBUGRwEinLT7r3mo+SD/P0Wh2+QBWLlwHMlhuAWxjULC3N+ZI0OZ5LF1cOGrrzTfr/7gJSQ4LrqwFSrERl0VZCdyPL7yo9Jm9xyPv5633vorCmlzRnVrPrgn/r/vpJLdykMoZNt+/+W1rwmmrwK0cPXyhV6BppIRM6P0Xy4QEUz/GpurROtPaQst0GJxC0Y6ZPbHW8HFuVh3U/x18wmQ8E1Axtm1wSTZLko31QoVf9xIyFlPVq2JcZSLlDMHbjB8FuzHUtSedx2HmYoxgMwHUcp54opgEOOXeaVHtmMGOnAnMX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:47.5399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743cf90f-fd4d-489f-73dc-08dc48a81e10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166

From: George Shen <george.shen@amd.com>

[Why]
MPC flow rate control is not needed for DCN30 and above. Current logic
that uses it can result in underflow for certain edge cases (such as
DSC N422 + ODM combine + 422 left edge pixel).

[How]
Remove MPC flow rate control logic and programming for DCN30 and above.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  | 54 +++++++++++--------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  | 14 ++---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |  5 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 41 --------------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 41 --------------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 41 --------------
 6 files changed, 41 insertions(+), 155 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index bf3386cd444d..5ebb57303130 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -44,6 +44,36 @@
 #define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
 
 
+void mpc3_mpc_init(struct mpc *mpc)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+	int opp_id;
+
+	mpc1_mpc_init(mpc);
+
+	for (opp_id = 0; opp_id < MAX_OPP; opp_id++) {
+		if (REG(MUX[opp_id]))
+			/* disable mpc out rate and flow control */
+			REG_UPDATE_2(MUX[opp_id], MPC_OUT_RATE_CONTROL_DISABLE,
+					1, MPC_OUT_FLOW_CONTROL_COUNT, 0);
+	}
+}
+
+void mpc3_mpc_init_single_inst(struct mpc *mpc, unsigned int mpcc_id)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+
+	mpc1_mpc_init_single_inst(mpc, mpcc_id);
+
+	/* assuming mpc out mux is connected to opp with the same index at this
+	 * point in time (e.g. transitioning from vbios to driver)
+	 */
+	if (mpcc_id < MAX_OPP && REG(MUX[mpcc_id]))
+		/* disable mpc out rate and flow control */
+		REG_UPDATE_2(MUX[mpcc_id], MPC_OUT_RATE_CONTROL_DISABLE,
+				1, MPC_OUT_FLOW_CONTROL_COUNT, 0);
+}
+
 bool mpc3_is_dwb_idle(
 	struct mpc *mpc,
 	int dwb_id)
@@ -80,25 +110,6 @@ void mpc3_disable_dwb_mux(
 		MPC_DWB0_MUX, 0xf);
 }
 
-void mpc3_set_out_rate_control(
-	struct mpc *mpc,
-	int opp_id,
-	bool enable,
-	bool rate_2x_mode,
-	struct mpc_dwb_flow_control *flow_control)
-{
-	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
-
-	REG_UPDATE_2(MUX[opp_id],
-			MPC_OUT_RATE_CONTROL_DISABLE, !enable,
-			MPC_OUT_RATE_CONTROL, rate_2x_mode);
-
-	if (flow_control)
-		REG_UPDATE_2(MUX[opp_id],
-			MPC_OUT_FLOW_CONTROL_MODE, flow_control->flow_ctrl_mode,
-			MPC_OUT_FLOW_CONTROL_COUNT, flow_control->flow_ctrl_cnt1);
-}
-
 enum dc_lut_mode mpc3_get_ogam_current(struct mpc *mpc, int mpcc_id)
 {
 	/*Contrary to DCN2 and DCN1 wherein a single status register field holds this info;
@@ -1490,8 +1501,8 @@ static const struct mpc_funcs dcn30_mpc_funcs = {
 	.read_mpcc_state = mpc3_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
-	.mpc_init = mpc1_mpc_init,
-	.mpc_init_single_inst = mpc1_mpc_init_single_inst,
+	.mpc_init = mpc3_mpc_init,
+	.mpc_init_single_inst = mpc3_mpc_init_single_inst,
 	.update_blending = mpc2_update_blending,
 	.cursor_lock = mpc1_cursor_lock,
 	.get_mpcc_for_dpp = mpc1_get_mpcc_for_dpp,
@@ -1508,7 +1519,6 @@ static const struct mpc_funcs dcn30_mpc_funcs = {
 	.set_dwb_mux = mpc3_set_dwb_mux,
 	.disable_dwb_mux = mpc3_disable_dwb_mux,
 	.is_dwb_idle = mpc3_is_dwb_idle,
-	.set_out_rate_control = mpc3_set_out_rate_control,
 	.set_gamut_remap = mpc3_set_gamut_remap,
 	.program_shaper = mpc3_program_shaper,
 	.acquire_rmu = mpcc3_acquire_rmu,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
index 9cb96ae95a2f..ce93003dae01 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
@@ -1007,6 +1007,13 @@ void dcn30_mpc_construct(struct dcn30_mpc *mpc30,
 	int num_mpcc,
 	int num_rmu);
 
+void mpc3_mpc_init(
+	struct mpc *mpc);
+
+void mpc3_mpc_init_single_inst(
+	struct mpc *mpc,
+	unsigned int mpcc_id);
+
 bool mpc3_program_shaper(
 		struct mpc *mpc,
 		const struct pwl_params *params,
@@ -1078,13 +1085,6 @@ bool mpc3_is_dwb_idle(
 	struct mpc *mpc,
 	int dwb_id);
 
-void mpc3_set_out_rate_control(
-	struct mpc *mpc,
-	int opp_id,
-	bool enable,
-	bool rate_2x_mode,
-	struct mpc_dwb_flow_control *flow_control);
-
 void mpc3_power_on_ogam_lut(
 	struct mpc *mpc, int mpcc_id,
 	bool power_on);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index e789e654c387..e408e859b355 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -47,7 +47,7 @@ void mpc32_mpc_init(struct mpc *mpc)
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 	int mpcc_id;
 
-	mpc1_mpc_init(mpc);
+	mpc3_mpc_init(mpc);
 
 	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
 		if (mpc30->mpc_mask->MPCC_MCM_SHAPER_MEM_LOW_PWR_MODE && mpc30->mpc_mask->MPCC_MCM_3DLUT_MEM_LOW_PWR_MODE) {
@@ -991,7 +991,7 @@ static const struct mpc_funcs dcn32_mpc_funcs = {
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
 	.mpc_init = mpc32_mpc_init,
-	.mpc_init_single_inst = mpc1_mpc_init_single_inst,
+	.mpc_init_single_inst = mpc3_mpc_init_single_inst,
 	.update_blending = mpc2_update_blending,
 	.cursor_lock = mpc1_cursor_lock,
 	.get_mpcc_for_dpp = mpc1_get_mpcc_for_dpp,
@@ -1008,7 +1008,6 @@ static const struct mpc_funcs dcn32_mpc_funcs = {
 	.set_dwb_mux = mpc3_set_dwb_mux,
 	.disable_dwb_mux = mpc3_disable_dwb_mux,
 	.is_dwb_idle = mpc3_is_dwb_idle,
-	.set_out_rate_control = mpc3_set_out_rate_control,
 	.set_gamut_remap = mpc3_set_gamut_remap,
 	.program_shaper = mpc32_program_shaper,
 	.program_3dlut = mpc32_program_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 3a9cc8ac0c07..093f4387553c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -69,29 +69,6 @@
 #define FN(reg_name, field_name) \
 	hws->shifts->field_name, hws->masks->field_name
 
-static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
-		int opp_cnt)
-{
-	bool hblank_halved = optc2_is_two_pixels_per_containter(&stream->timing);
-	int flow_ctrl_cnt;
-
-	if (opp_cnt >= 2)
-		hblank_halved = true;
-
-	flow_ctrl_cnt = stream->timing.h_total - stream->timing.h_addressable -
-			stream->timing.h_border_left -
-			stream->timing.h_border_right;
-
-	if (hblank_halved)
-		flow_ctrl_cnt /= 2;
-
-	/* ODM combine 4:1 case */
-	if (opp_cnt == 4)
-		flow_ctrl_cnt /= 2;
-
-	return flow_ctrl_cnt;
-}
-
 static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
@@ -183,10 +160,6 @@ void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
-	bool rate_control_2x_pclk = (pipe_ctx->stream->timing.flags.INTERLACE || optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing));
-	struct mpc_dwb_flow_control flow_control;
-	struct mpc *mpc = dc->res_pool->mpc;
-	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -199,20 +172,6 @@ void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
-	rate_control_2x_pclk = rate_control_2x_pclk || opp_cnt > 1;
-	flow_control.flow_ctrl_mode = 0;
-	flow_control.flow_ctrl_cnt0 = 0x80;
-	flow_control.flow_ctrl_cnt1 = calc_mpc_flow_ctrl_cnt(pipe_ctx->stream, opp_cnt);
-	if (mpc->funcs->set_out_rate_control) {
-		for (i = 0; i < opp_cnt; ++i) {
-			mpc->funcs->set_out_rate_control(
-					mpc, opp_inst[i],
-					true,
-					rate_control_2x_pclk,
-					&flow_control);
-		}
-	}
-
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
 				odm_pipe->stream_res.opp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 367dcaeaf186..62ff99463834 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -970,29 +970,6 @@ void dcn32_init_hw(struct dc *dc)
 	}
 }
 
-static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
-		int opp_cnt)
-{
-	bool hblank_halved = optc2_is_two_pixels_per_containter(&stream->timing);
-	int flow_ctrl_cnt;
-
-	if (opp_cnt >= 2)
-		hblank_halved = true;
-
-	flow_ctrl_cnt = stream->timing.h_total - stream->timing.h_addressable -
-			stream->timing.h_border_left -
-			stream->timing.h_border_right;
-
-	if (hblank_halved)
-		flow_ctrl_cnt /= 2;
-
-	/* ODM combine 4:1 case */
-	if (opp_cnt == 4)
-		flow_ctrl_cnt /= 2;
-
-	return flow_ctrl_cnt;
-}
-
 static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
@@ -1107,10 +1084,6 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
-	bool rate_control_2x_pclk = (pipe_ctx->stream->timing.flags.INTERLACE || optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing));
-	struct mpc_dwb_flow_control flow_control;
-	struct mpc *mpc = dc->res_pool->mpc;
-	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -1123,20 +1096,6 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
-	rate_control_2x_pclk = rate_control_2x_pclk || opp_cnt > 1;
-	flow_control.flow_ctrl_mode = 0;
-	flow_control.flow_ctrl_cnt0 = 0x80;
-	flow_control.flow_ctrl_cnt1 = calc_mpc_flow_ctrl_cnt(pipe_ctx->stream, opp_cnt);
-	if (mpc->funcs->set_out_rate_control) {
-		for (i = 0; i < opp_cnt; ++i) {
-			mpc->funcs->set_out_rate_control(
-					mpc, opp_inst[i],
-					true,
-					rate_control_2x_pclk,
-					&flow_control);
-		}
-	}
-
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
 				odm_pipe->stream_res.opp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index ad88edebcdfe..cdc53384cb51 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -358,29 +358,6 @@ void dcn35_init_hw(struct dc *dc)
 	}
 }
 
-static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
-		int opp_cnt)
-{
-	bool hblank_halved = optc2_is_two_pixels_per_containter(&stream->timing);
-	int flow_ctrl_cnt;
-
-	if (opp_cnt >= 2)
-		hblank_halved = true;
-
-	flow_ctrl_cnt = stream->timing.h_total - stream->timing.h_addressable -
-			stream->timing.h_border_left -
-			stream->timing.h_border_right;
-
-	if (hblank_halved)
-		flow_ctrl_cnt /= 2;
-
-	/* ODM combine 4:1 case */
-	if (opp_cnt == 4)
-		flow_ctrl_cnt /= 2;
-
-	return flow_ctrl_cnt;
-}
-
 static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
@@ -474,10 +451,6 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
-	bool rate_control_2x_pclk = (pipe_ctx->stream->timing.flags.INTERLACE || optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing));
-	struct mpc_dwb_flow_control flow_control;
-	struct mpc *mpc = dc->res_pool->mpc;
-	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -490,20 +463,6 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
-	rate_control_2x_pclk = rate_control_2x_pclk || opp_cnt > 1;
-	flow_control.flow_ctrl_mode = 0;
-	flow_control.flow_ctrl_cnt0 = 0x80;
-	flow_control.flow_ctrl_cnt1 = calc_mpc_flow_ctrl_cnt(pipe_ctx->stream, opp_cnt);
-	if (mpc->funcs->set_out_rate_control) {
-		for (i = 0; i < opp_cnt; ++i) {
-			mpc->funcs->set_out_rate_control(
-					mpc, opp_inst[i],
-					true,
-					rate_control_2x_pclk,
-					&flow_control);
-		}
-	}
-
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
 				odm_pipe->stream_res.opp,
-- 
2.34.1


