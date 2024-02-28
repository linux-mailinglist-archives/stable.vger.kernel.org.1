Return-Path: <stable+bounces-25428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD4086B791
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E5728420E
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2076471EB9;
	Wed, 28 Feb 2024 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2bacwFjk"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA87B40849
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145977; cv=fail; b=V4CCOhSdbaiad86xzq5rCArxqR6XFAruSWmOyyYBCYRGh1+N/cUL4YEyHA7vT8KKSwazMIQH/ktyToJOtS0BEWMlewe+Td+2IJefdgyoYE+L+Ia0sXKM4/7YHdA02FwUNMkUfUrYa9aFvvuObbi5KHGSjdZwN35XrDA9fBma3Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145977; c=relaxed/simple;
	bh=3IZtiCfG/mv7WG+MOSx2I9a66TUDDBg3FyBxfTAAVzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0PC8fIgIaYchBYQkOS/Xq+90esmslDQ+vNs+FL32flKihTvJ/LIVlZvBbfWPO5MCNQ+vP9duoW2GYPJboBbIf6ldQtAMQuuanMHHzFODVxYd9S+DBYa4Qzbl2n//qq7lxZzMCnUalk2DgIk5Y9Y4oTcGzGq2iuY7s6GR7UT/Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2bacwFjk; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkLiPBxTEhJAL+tc8/dOGIpfz/sRCWK/zMR6YEW4eYAB8ss7MXaok7K8Syr/d/yn3ETRBS6EUNotozBsTghanvgIQ8+YsG24NPfMJqd6VIJ58WrQv3ip8Bz9ZM7w3WzhsHfHQ54g9nTJuokpYgs/SqmB+Gkl9y/X/6VMk+402ZMzgcW5najnWNfH+KP0XDeMo+VDpsl3uzP6xIGHTJZzl0ydf7wf2Hd2WEyejxGm46AXZC5YwhzklJqJorarJZz6FKfzNpyZGr8OPrD+Xlizkg/w4EiB3Fz1ZDGdm60FCbFKBL3XIR6kQAxvdJ/3s9dXXwzyufZnKfkO5a1XRoAvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUPB6FoieJGyqvsTVhqTHNfftWH2h4F9VmUwwlEEJvE=;
 b=JPUqa+N3biW2wkL7H3adnUffe13IItqWWFkFbaywIMe4ZetCYicbG8HnfrAyoIg4vp+NR78e+pVpwEeBBZ7p/Au+50sv7ZKKKxl7iH1BbW8Apj9ZTHAZJD4qETviirT4EHej/dKRxQk49ObJRbWt3i6N+H2cluT3uTQpgWiksBP9589sweeLxpOr2GF0K4XLYq7O0dARrGbH81VZZ5pPEM1+VT3MJL+xunFrICOeu2GJLTW2PKZU6oKZEs+4oXrHaIc8+maPfFC3Ousm9uTMG7rR39JD8uxpacqy91bGKYEaCTnKlmEnpNwsgM5bHkqp23y56HqmcgY2DuZWx7Rvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUPB6FoieJGyqvsTVhqTHNfftWH2h4F9VmUwwlEEJvE=;
 b=2bacwFjk9inHWeWeiG/81cJcxdudHDSYzmuzGVwVhD3GNQZrfAReF9UK1y8L/XClQ4ehdlBZC22LCr6/qwWSHmkIDHbeM53qSUACBrvoKuf8VkrHYNzZ9HiFOWc6hy03O73fjnAAwXroeuf5ihODn4q7tba6BtTrGUqUqzCLGaA=
Received: from SA9PR10CA0020.namprd10.prod.outlook.com (2603:10b6:806:a7::25)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 18:46:07 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::34) by SA9PR10CA0020.outlook.office365.com
 (2603:10b6:806:a7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:46:06 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:45:55 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, ChunTao Tso
	<chuntao.tso@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alvin Lee
	<alvin.lee2@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 23/34] drm/amd/display: Amend coasting vtotal for replay low hz
Date: Wed, 28 Feb 2024 11:39:29 -0700
Message-ID: <20240228183940.1883742-24-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 505302f1-b424-429b-2dc2-08dc388d85a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6a1yzyUx1W6eQi6ZkVLZ4+WJIWRVb96RiAkEsyAAwUUCz5Z0dA+p7W/Zgj06aDCjkTg6w8/Njs0h5rhSvJv6x72tBemw2mQLVweK+N/a/SQrfAEou3ARmIRFC3k/S8oJJOYQSmGHepJ24syrFY81nszzcblKlAPfnxkT60wQfkQ9JWxGNGjJ8Z7nUP1U+MGRjByYVa9LXazY9tt/u644S/ulsxvmNhMlfnlPEhsaUSMlAOPhthzxg0ggjYqWv76DagCetf0nA4JLGIYQyNh2hejLllpT2TE98YKhcY17bRvxC+XuIsg8q4l1UXCHqrLvCmwbsFk99iFUwPKBe6L27BIagniS2jNePLXeL+JWWabgMqEFYOQxESWRyHglpJaHUvQdD29U+SlcUyJWfH0I4i3tcx4YJ/6aqNhzOJPZadmoe3YbyuebBY7VkMKvK7NTlAASJUmF0QCbC8r8xhlO7YBZJnahZcw0b/Bvula8vvj7yLst6yhyoOZMdJzIF3Mw9xPN+XFl0pEQV2NaydrfDnTzjLZ4rRp08y0vmVEcQAP2VtI9lNO+1V+QeCGQfGNFmRAXIPQ1Mvy3svBu/4o2Ff47B+b96qp3zuhtB0CUENY9JuJXHs8leSQxi0+PIds73VSFsAufmtw1T80oBlRhdXyT91rVqACraMhw8gQIcuKJZc41G5yMsZK9eEcl1AdsCgIm1SpRexJoluZ0PAUMJqtLd6Nc6mKzJGoeEfEZ8RElY/qTCJlWqjd0DKXunWXX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:46:06.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505302f1-b424-429b-2dc2-08dc388d85a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266

From: ChunTao Tso <chuntao.tso@amd.com>

[WHY]
The original coasting vtotal is 2 bytes, and it need to
be amended to 4 bytes because low hz case.

[HOW]
Amend coasting vtotal from 2 bytes to 4 bytes.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 4 ++--
 drivers/gpu/drm/amd/display/dc/inc/link.h                 | 4 ++--
 .../display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
 .../display/dc/link/protocols/link_edp_panel_control.h    | 4 ++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h           | 8 ++++++++
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 +-
 drivers/gpu/drm/amd/display/modules/power/power_helpers.h | 2 +-
 7 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 9900dda2eef5..be2ac5c442a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1085,9 +1085,9 @@ struct replay_settings {
 	/* SMU optimization is enabled */
 	bool replay_smu_opt_enable;
 	/* Current Coasting vtotal */
-	uint16_t coasting_vtotal;
+	uint32_t coasting_vtotal;
 	/* Coasting vtotal table */
-	uint16_t coasting_vtotal_table[PR_COASTING_TYPE_NUM];
+	uint32_t coasting_vtotal_table[PR_COASTING_TYPE_NUM];
 	/* Maximum link off frame count */
 	enum replay_link_off_frame_count_level link_off_frame_count_level;
 	/* Replay pseudo vtotal for abm + ips on full screen video which can improve ips residency */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 26fe81f213da..bf29fc58ea6a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -285,12 +285,12 @@ struct link_service {
 			enum replay_FW_Message_type msg,
 			union dmub_replay_cmd_set *cmd_data);
 	bool (*edp_set_coasting_vtotal)(
-			struct dc_link *link, uint16_t coasting_vtotal);
+			struct dc_link *link, uint32_t coasting_vtotal);
 	bool (*edp_replay_residency)(const struct dc_link *link,
 			unsigned int *residency, const bool is_start,
 			const bool is_alpm);
 	bool (*edp_set_replay_power_opt_and_coasting_vtotal)(struct dc_link *link,
-			const unsigned int *power_opts, uint16_t coasting_vtotal);
+			const unsigned int *power_opts, uint32_t coasting_vtotal);
 
 	bool (*edp_wait_for_t12)(struct dc_link *link);
 	bool (*edp_is_ilr_optimization_required)(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index acfbbc638cc6..3baa2bdd6dd6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1034,7 +1034,7 @@ bool edp_send_replay_cmd(struct dc_link *link,
 	return true;
 }
 
-bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal)
+bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal)
 {
 	struct dc *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
@@ -1073,7 +1073,7 @@ bool edp_replay_residency(const struct dc_link *link,
 }
 
 bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
-	const unsigned int *power_opts, uint16_t coasting_vtotal)
+	const unsigned int *power_opts, uint32_t coasting_vtotal)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 34e521af7bb4..a158c6234d42 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -59,12 +59,12 @@ bool edp_setup_replay(struct dc_link *link,
 bool edp_send_replay_cmd(struct dc_link *link,
 			enum replay_FW_Message_type msg,
 			union dmub_replay_cmd_set *cmd_data);
-bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal);
+bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal);
 bool edp_replay_residency(const struct dc_link *link,
 	unsigned int *residency, const bool is_start, const bool is_alpm);
 bool edp_get_replay_state(const struct dc_link *link, uint64_t *state);
 bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
-	const unsigned int *power_opts, uint16_t coasting_vtotal);
+	const unsigned int *power_opts, uint32_t coasting_vtotal);
 bool edp_wait_for_t12(struct dc_link *link);
 bool edp_is_ilr_optimization_required(struct dc_link *link,
        struct dc_crtc_timing *crtc_timing);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 02ad641bd8df..4a650ac571d7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3244,6 +3244,14 @@ struct dmub_cmd_replay_set_coasting_vtotal_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
+	/**
+	 * 16-bit value dicated by driver that indicates the coasting vtotal high byte part.
+	 */
+	uint16_t coasting_vtotal_high;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index e304e8435fb8..2a3698fd2dc2 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -975,7 +975,7 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 
 void set_replay_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
-	uint16_t vtotal)
+	uint32_t vtotal)
 {
 	link->replay_settings.coasting_vtotal_table[type] = vtotal;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index bef4815e1703..ff7e6f3cd6be 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -56,7 +56,7 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 void init_replay_config(struct dc_link *link, struct replay_config *pr_config);
 void set_replay_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
-	uint16_t vtotal);
+	uint32_t vtotal);
 void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
 void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint16_t vtotal, uint16_t htotal);
-- 
2.34.1


