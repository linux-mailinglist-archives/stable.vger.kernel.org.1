Return-Path: <stable+bounces-6565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0F2810A10
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 07:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CA21F21B2A
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 06:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAAEF9EF;
	Wed, 13 Dec 2023 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TRqkX//S"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67A83
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 22:14:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYtRVpAIjCnuUioHv1xsHt7XcIsQ8Y4HoNvJEjpH//TeiwcIh+OUGkqCvHSmYrRHLtOh+5em7z9LqxEUgDprbQpf6NvaFqSGMsNBWdKECXB0QPxiHPzOT+BVYjoYMMlzyX4DzIYQ7ITcB9utKXpTOG+uU0F8KcTJcuM/2Au53otWhiuPBXR2+snn5r0uM0c5rue9tPqqPKj+ymfXWnk50e2/6IKluEbeDPw5m9N2OJ+Z10+xee7uGMsuU7SxjyiQ4jKQ9PxIaZrcCNzuQZIDG2d4Rz6jaCZ41Wq64kD3OUT8Cpee3Rq29R+AARO8Us3iY+6GIol4uH83RPgITsmflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo/Huhxgwq7EpRwJxQIOBYHCxkHNRYzKZj7Tcf0S1Gg=;
 b=DMzPS2F6m7ZsLJYvztEMZaK9wASrLfrTHhB4H0LnoK8fLnklqqwM7A1TOvdQJkjw/wcZ7Ay08RRbb69GzUpL3W+LrTRtoJdgyTo8o0o2k0O5qNMskILt40NH8sypTXuz+fEubEzw9fUAbz6nwyXMerLZrH+On5+O1wvtcoDh/cREP5s9Q79I9nqJNSRxqoNdGUUdih0pJFl9VKs/KboF+L7CfOKHKkdN4vVNB2bnNYit3U+roXvrOnRhQtsBdFSEi+5izM5Jm82O3kyzfCcoD3CMwPyQ3Cpbo1eVEHNuKo0Oc8ZlhENusM+m0hThQJ6HF11OXFYME2ljf2W4WxMTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo/Huhxgwq7EpRwJxQIOBYHCxkHNRYzKZj7Tcf0S1Gg=;
 b=TRqkX//Sj/+vM8IXM03WumppagP9lCHKZyVT1jmgQm51sa5fao1pFb1VMw061fPvV4qGIfQbJ9PeEH4YjlOGhVQQnoTrhC14jHZEsjCZyxqD7rZicuJy9k4TudkXM3oaa+YykfZbdBCO3vI5YYv9bKDDL+6HSaXpaI9BYLUMs2E=
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:14:38 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::c1) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:14:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.8 via Frontend Transport; Wed, 13 Dec 2023 06:14:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:14:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 12 Dec
 2023 22:14:37 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:14:31 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <stylon.wang@amd.com>, <agustin.gutierrez@amd.com>,
	<chiahsuan.chung@amd.com>, <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Hansen Dsouza <hansen.dsouza@amd.com>
Subject: [PATCH 17/25] drm/amd/display: Wake DMCUB before executing GPINT commands
Date: Wed, 13 Dec 2023 14:12:19 +0800
Message-ID: <20231213061227.1750663-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: b0494a6c-1019-43a4-ba88-08dbfba2c984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ew3+5boW7oLHGek2FwWenAOCvHkdU9rWMTmTTHAP3HJAcG4mtJkTo7I2ecKr454STBvH62ePo9fb/Cg7CO5zY2mxbrIr/jRl0OFsrM/NfHaJYWvZkAC+1d2t1WDRjP8Q0LMIf/jrlYeFqzbJOQN9riUe6gh6gF0Mga6qFLFzv6jxKIIDLArq4/fL/h0NWEq3Plvgd7pvyE0sqEQcfmGptcIpIb9QiQMuiRqKsMPJk5RNOqy6+TUVtCmDLEh3+kBODt7NPSdu/PeeGePHKmL3rt22wqlycMpZwfNEDjnAL8V8yUXDI5PWV+u68mmou9mPSim8WRGUM68JlPXvM9sKdopWwFAvHES/h1KLw1Xecm0SA44lJltgjEbELKTYLrH0zZu5OVF4xZE+pDfyTqfl0w0TK6ZXHFw2tu+ypEtUQJSB6F0gRDY5Jg6780fwfmLbi8IlH7qEt5yyMdA+W2t3h0Ei2j7tOJ97nlxpT0a2ay4cie+eHk6sRrewF9tfoyhiZEKuhpz4ckwmfwuHqhmxB4ea5HLIyB+IkEDKWddEO6f9QaYotOvifctpU5NWoyk77B/kkS+yZ5nAILrIwMbA+Gy7i63gbZCpzdg3BeE7v4Q1lmuh6dumy5bgeRuT99mHm76uWWH0ckzAeNgB5WNL66HMft2Kf2KauB2j5iG6YEiGANljLX+IgKKxBN1Mj7kCyea/swqLjYF9w85veLlxkGnoRY0u0KA/aUHlScoipzC3h/OESOif+WX13k/eBQdnmwwusfI8LvEA5puzv3BULQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40480700001)(1076003)(2616005)(426003)(336012)(26005)(7696005)(6666004)(40460700003)(86362001)(82740400003)(81166007)(356005)(36756003)(5660300002)(8676002)(8936002)(4326008)(36860700001)(83380400001)(47076005)(54906003)(6916009)(70206006)(70586007)(41300700001)(2906002)(316002)(478600001)(461764006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:14:38.5374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0494a6c-1019-43a4-ba88-08dbfba2c984
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DMCUB can be in idle when we attempt to interface with the HW through
the GPINT mailbox resulting in a system hang.

[How]
Add dc_wake_and_execute_gpint() to wrap the wake, execute, sleep
sequence.

If the GPINT executes successfully then DMCUB will be put back into
sleep after the optional response is returned.

It functions similar to the inbox command interface.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 29 ++------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 72 ++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  | 11 +++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 19 ++---
 4 files changed, 77 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 98b41ec7288e..68a846323912 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2976,7 +2976,6 @@ static int dmub_trace_mask_set(void *data, u64 val)
 	struct amdgpu_device *adev = data;
 	struct dmub_srv *srv = adev->dm.dc->ctx->dmub_srv->dmub;
 	enum dmub_gpint_command cmd;
-	enum dmub_status status;
 	u64 mask = 0xffff;
 	u8 shift = 0;
 	u32 res;
@@ -3003,13 +3002,7 @@ static int dmub_trace_mask_set(void *data, u64 val)
 			break;
 		}
 
-		status = dmub_srv_send_gpint_command(srv, cmd, res, 30);
-
-		if (status == DMUB_STATUS_TIMEOUT)
-			return -ETIMEDOUT;
-		else if (status == DMUB_STATUS_INVALID)
-			return -EINVAL;
-		else if (status != DMUB_STATUS_OK)
+		if (!dc_wake_and_execute_gpint(adev->dm.dc->ctx, cmd, res, NULL, DM_DMUB_WAIT_TYPE_WAIT))
 			return -EIO;
 
 		usleep_range(100, 1000);
@@ -3026,7 +3019,6 @@ static int dmub_trace_mask_show(void *data, u64 *val)
 	enum dmub_gpint_command cmd = DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD0;
 	struct amdgpu_device *adev = data;
 	struct dmub_srv *srv = adev->dm.dc->ctx->dmub_srv->dmub;
-	enum dmub_status status;
 	u8 shift = 0;
 	u64 raw = 0;
 	u64 res = 0;
@@ -3036,23 +3028,12 @@ static int dmub_trace_mask_show(void *data, u64 *val)
 		return -EINVAL;
 
 	while (i < 4) {
-		status = dmub_srv_send_gpint_command(srv, cmd, 0, 30);
-
-		if (status == DMUB_STATUS_OK) {
-			status = dmub_srv_get_gpint_response(srv, (u32 *) &raw);
-
-			if (status == DMUB_STATUS_INVALID)
-				return -EINVAL;
-			else if (status != DMUB_STATUS_OK)
-				return -EIO;
-		} else if (status == DMUB_STATUS_TIMEOUT) {
-			return -ETIMEDOUT;
-		} else if (status == DMUB_STATUS_INVALID) {
-			return -EINVAL;
-		} else {
+		uint32_t response;
+
+		if (!dc_wake_and_execute_gpint(adev->dm.dc->ctx, cmd, 0, &response, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
 			return -EIO;
-		}
 
+		raw = response;
 		usleep_range(100, 1000);
 
 		cmd++;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index fea13bcd4dc7..4b93e7a529d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -301,17 +301,11 @@ bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 				    unsigned int stream_mask)
 {
-	struct dmub_srv *dmub;
-	const uint32_t timeout = 30;
-
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
 
-	dmub = dc_dmub_srv->dmub;
-
-	return dmub_srv_send_gpint_command(
-		       dmub, DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK,
-		       stream_mask, timeout) == DMUB_STATUS_OK;
+	return dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK,
+					 stream_mask, NULL, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
 bool dc_dmub_srv_is_restore_required(struct dc_dmub_srv *dc_dmub_srv)
@@ -1126,25 +1120,20 @@ bool dc_dmub_check_min_version(struct dmub_srv *srv)
 void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
 {
 	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
-	struct dmub_srv *dmub;
-	enum dmub_status status;
-	static const uint32_t timeout_us = 30;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
 		DC_LOG_ERROR("%s: invalid parameters.", __func__);
 		return;
 	}
 
-	dmub = dc_dmub_srv->dmub;
-
-	status = dmub_srv_send_gpint_command(dmub, DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD1, 0x0010, timeout_us);
-	if (status != DMUB_STATUS_OK) {
+	if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD1,
+				       0x0010, NULL, DM_DMUB_WAIT_TYPE_WAIT)) {
 		DC_LOG_ERROR("timeout updating trace buffer mask word\n");
 		return;
 	}
 
-	status = dmub_srv_send_gpint_command(dmub, DMUB_GPINT__UPDATE_TRACE_BUFFER_MASK, 0x0000, timeout_us);
-	if (status != DMUB_STATUS_OK) {
+	if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__UPDATE_TRACE_BUFFER_MASK,
+				       0x0000, NULL, DM_DMUB_WAIT_TYPE_WAIT)) {
 		DC_LOG_ERROR("timeout updating trace buffer mask word\n");
 		return;
 	}
@@ -1368,3 +1357,52 @@ bool dc_wake_and_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned in
 
 	return result;
 }
+
+static bool dc_dmub_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_command command_code,
+				  uint16_t param, uint32_t *response, enum dm_dmub_wait_type wait_type)
+{
+	struct dc_dmub_srv *dc_dmub_srv = ctx->dmub_srv;
+	const uint32_t wait_us = wait_type == DM_DMUB_WAIT_TYPE_NO_WAIT ? 0 : 30;
+	enum dmub_status status;
+
+	if (response)
+		*response = 0;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	status = dmub_srv_send_gpint_command(dc_dmub_srv->dmub, command_code, param, wait_us);
+	if (status != DMUB_STATUS_OK) {
+		if (status == DMUB_STATUS_TIMEOUT && wait_type == DM_DMUB_WAIT_TYPE_NO_WAIT)
+			return true;
+
+		return false;
+	}
+
+	if (response && wait_type == DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)
+		dmub_srv_get_gpint_response(dc_dmub_srv->dmub, response);
+
+	return true;
+}
+
+bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_command command_code,
+			       uint16_t param, uint32_t *response, enum dm_dmub_wait_type wait_type)
+{
+	struct dc_dmub_srv *dc_dmub_srv = ctx->dmub_srv;
+	bool result = false, reallow_idle = false;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	if (dc_dmub_srv->idle_allowed) {
+		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, false);
+		reallow_idle = true;
+	}
+
+	result = dc_dmub_execute_gpint(ctx, command_code, param, response, wait_type);
+
+	if (result && reallow_idle)
+		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, true);
+
+	return result;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 784ca3e44414..952bfb368886 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -145,5 +145,16 @@ bool dc_wake_and_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cm
 bool dc_wake_and_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned int count,
 				       union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type);
 
+/**
+ * dc_wake_and_execute_gpint()
+ *
+ * @ctx: DC context
+ * @command_code: The command ID to send to DMCUB
+ * @param: The parameter to message DMCUB
+ * @response: Optional response out value - may be NULL.
+ * @wait_type: The wait behavior for the execution
+ */
+bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_command command_code,
+			       uint16_t param, uint32_t *response, enum dm_dmub_wait_type wait_type);
 
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 3d7cef17f881..3e243e407bb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -105,23 +105,18 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
  */
 static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state, uint8_t panel_inst)
 {
-	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
 	uint32_t raw_state = 0;
 	uint32_t retry_count = 0;
-	enum dmub_status status;
 
 	do {
 		// Send gpint command and wait for ack
-		status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, panel_inst, 30);
-
-		if (status == DMUB_STATUS_OK) {
-			// GPINT was executed, get response
-			dmub_srv_get_gpint_response(srv, &raw_state);
+		if (dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__GET_PSR_STATE, panel_inst, &raw_state,
+					      DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
 			*state = convert_psr_state(raw_state);
-		} else
+		} else {
 			// Return invalid state when GPINT times out
 			*state = PSR_STATE_INVALID;
-
+		}
 	} while (++retry_count <= 1000 && *state == PSR_STATE_INVALID);
 
 	// Assert if max retry hit
@@ -452,13 +447,11 @@ static void dmub_psr_force_static(struct dmub_psr *dmub, uint8_t panel_inst)
  */
 static void dmub_psr_get_residency(struct dmub_psr *dmub, uint32_t *residency, uint8_t panel_inst)
 {
-	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
 	uint16_t param = (uint16_t)(panel_inst << 8);
 
 	/* Send gpint command and wait for ack */
-	dmub_srv_send_gpint_command(srv, DMUB_GPINT__PSR_RESIDENCY, param, 30);
-
-	dmub_srv_get_gpint_response(srv, residency);
+	dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__PSR_RESIDENCY, param, residency,
+				  DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
 }
 
 static const struct dmub_psr_funcs psr_funcs = {
-- 
2.37.3


