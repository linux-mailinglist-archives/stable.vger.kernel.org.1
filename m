Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB37175DA
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 06:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjEaEs6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 00:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEaEs4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 00:48:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3081A9D
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkBTHWbYUW/7r8LJNhUl21unVrc2DXWDrgFQ+225G4bKssBNAgaZxG3KYpNQgm2mpXaFc2WNVvrNKCPji2fEhjeDY1bBZOgmFjtJ+3+hFvL/2WwvpQgJ7z9HkLGjTqEezQxClxIYvL6mMQWaxSbW2A3ac3XmNYXq2+JIfj0IbHzzMjjbeTBsbYAxXQ9T+ycOJZcx1VnqiePLaH5aiSejAozTmomU8pH3RozURHVnIV5n/aGPUIE3X5rkGavpLNxENAkJoDsMO7zlq0XVNymuAvMb7W4p19J5m9X+8uHu25JWbxNDEdjFP0khVutrEd8idvfGS3GzZhIPWaYYhIAEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZR9Q1bzmQfJUivSJlAc5EbqPkpeF2Ksu29eYCJY5ok=;
 b=HhcL4uqThqBKgkHQWe2o+bHVhhmxW/iY7ZciXpytHjKUZAYjCHu6ldDHUxlKrreclll4ThYs2ps7sY2dYwHdWeDXJRzQ0vEHt6RAp0Oxyp1dkTYkfDWF4yKJG/MSFddVfRfIrPIIQZcfIaKWRC+m+WzjhIdXJailGgV6DtpeeF6SFRq/K1ZyudBvfbCQL3vn27t49Nwfzb178pQjv3mnZRDGXolnjdwa04v5iG68hTtioT1UbvUVw+pIfU4RXksKagbpTd0vbnLbWyiszoflIJA+Or4CHdjWbaxYdcOdgvxoq7ToK2Ik06rHDFd14XcM8Pb6NHaahDFj5CrxdMmkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZR9Q1bzmQfJUivSJlAc5EbqPkpeF2Ksu29eYCJY5ok=;
 b=Ce34VY8hz3EkGP58pPU8LA8+0vUTnguAFpm+1MoQzsGp7NS7t4MQbYjfoIFYP3gDcVoj1IWlFT2lvtwZs2iZk8nTUnjLhLeKpcQqkWCLiHGLblR6gwv4325bKDEz86RoCTG/VVU+L1DNyJMKQySBNMvS5Piz1mnQDgqb7j9mWO0=
Received: from BN9P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::25)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 04:48:51 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::8a) by BN9P220CA0020.outlook.office365.com
 (2603:10b6:408:13e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:48:51 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:48:46 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Samson Tam <samson.tam@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Alvin Lee <Alvin.Lee2@amd.com>
Subject: [PATCH 01/14] drm/amd/display: add ODM case when looking for first split pipe
Date:   Wed, 31 May 2023 12:48:00 +0800
Message-ID: <20230531044813.145361-2-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a90a8c-b14a-4071-f984-08db61925453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVHAo2qfb/8bTUu6JD7+06WO7SCslkJV9YsKPBqX0Fz+T51gMqAS4WEaXrW1lvhX75miqaU4hmLsJjd8VUSGpciB5v/DUalar/+Qf6eYhTJvodDohhCaRAE7HvVr4txx5G05YwRQZbjQ29m4kJdcSfr7rrTFDTZiV055Ce1EqnOQnQFYg72ZbTEEOGwggDpxKurUM9dtYM8svSoXC8hihkSbJRrSWUDdHJBJYbp9FpCX/R8U3L/lGtunhis1IUDgrWnbc6BHB3OWNqGXdGIpLxXeByvvFpYluBbKd2mDU7dkySoXoxGpTvSdUaZ5hGr2hNm8Gp9ODujY0mTh2VDNCbKhCBSFb0eV/SfUYebRb90LVwourKQdCLTZ/fUK6OBuiiagUQ8HnKWM43HYrYgcobNrNSvomQeX4AbaSLRaGoXQlPCN7vcdDll/4tOK2OlLFJLCOkli7Z5Pg6mXF+7XzAyJtUlbaMfu6AxqaUaZguD+pDGjpNFFc1MY+I5WhHOzPQ2z+2qNAz3mIEPxI5GxeclM4NbqDtj0grWfMmX4dGmZIE9iSr6BBR0zw332w7dVrU1HOsvCjeVr/Pw9GPPmKoJu+DpPYI/unNmhyTRtoCxOr+k//giwjdy9OQ7s1sahXj7Q+XrFBOwJRH4ecvumX64+4fhbN8XfzYfvmbd/ajDgfjsTFoLdkouZCYWjc49HDtSZl4/1XNg6PpdPuWt90gin8YCi3788ZXqGF9uwYIVwyUuSrUbOPGvNY98grychgotO+UwscvurpIEwJe/ZGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(36860700001)(83380400001)(47076005)(316002)(5660300002)(6666004)(70206006)(70586007)(36756003)(4326008)(6916009)(82310400005)(8676002)(41300700001)(81166007)(356005)(7696005)(8936002)(86362001)(82740400003)(40480700001)(54906003)(2616005)(2906002)(186003)(16526019)(44832011)(336012)(478600001)(426003)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:48:51.0497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a90a8c-b14a-4071-f984-08db61925453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Samson Tam <samson.tam@amd.com>

[Why]
When going from ODM 2:1 single display case to max displays, second
odm pipe needs to be repurposed for one of the new single displays.
However, acquire_first_split_pipe() only handles MPC case and not
ODM case

[How]
Add ODM conditions in acquire_first_split_pipe()
Add commit_minimal_transition_state() in commit_streams() to handle
odm 2:1 exit first, and then process new streams
Handle ODM condition in commit_minimal_transition_state()

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 36 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 20 +++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f3820c5e63af..2ad4293bb3e5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2008,6 +2008,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
+static bool commit_minimal_transition_state(struct dc *dc,
+		struct dc_state *transition_base_context);
+
 /**
  * dc_commit_streams - Commit current stream state
  *
@@ -2029,6 +2032,8 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	struct dc_state *context;
 	enum dc_status res = DC_OK;
 	struct dc_validation_set set[MAX_STREAMS] = {0};
+	struct pipe_ctx *pipe;
+	bool handle_exit_odm2to1 = false;
 
 	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
 		return res;
@@ -2053,6 +2058,22 @@ enum dc_status dc_commit_streams(struct dc *dc,
 		}
 	}
 
+	/* Check for case where we are going from odm 2:1 to max
+	 *  pipe scenario.  For these cases, we will call
+	 *  commit_minimal_transition_state() to exit out of odm 2:1
+	 *  first before processing new streams
+	 */
+	if (stream_count == dc->res_pool->pipe_count) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe->next_odm_pipe)
+				handle_exit_odm2to1 = true;
+		}
+	}
+
+	if (handle_exit_odm2to1)
+		res = commit_minimal_transition_state(dc, dc->current_state);
+
 	context = dc_create_state(dc);
 	if (!context)
 		goto context_alloc_fail;
@@ -3912,6 +3933,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	unsigned int i, j;
 	unsigned int pipe_in_use = 0;
 	bool subvp_in_use = false;
+	bool odm_in_use = false;
 
 	if (!transition_context)
 		return false;
@@ -3940,6 +3962,18 @@ static bool commit_minimal_transition_state(struct dc *dc,
 		}
 	}
 
+	/* If ODM is enabled and we are adding or removing planes from any ODM
+	 * pipe, we must use the minimal transition.
+	 */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->next_odm_pipe) {
+			odm_in_use = true;
+			break;
+		}
+	}
+
 	/* When the OS add a new surface if we have been used all of pipes with odm combine
 	 * and mpc split feature, it need use commit_minimal_transition_state to transition safely.
 	 * After OS exit MPO, it will back to use odm and mpc split with all of pipes, we need
@@ -3948,7 +3982,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	 * Reduce the scenarios to use dc_commit_state_no_check in the stage of flip. Especially
 	 * enter/exit MPO when DCN still have enough resources.
 	 */
-	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use) {
+	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use && !odm_in_use) {
 		dc_release_state(transition_context);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7e1e5532f88f..c72540d37aef 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1445,6 +1445,26 @@ static int acquire_first_split_pipe(
 			split_pipe->plane_res.mpcc_inst = pool->dpps[i]->inst;
 			split_pipe->pipe_idx = i;
 
+			split_pipe->stream = stream;
+			return i;
+		} else if (split_pipe->prev_odm_pipe &&
+				split_pipe->prev_odm_pipe->plane_state == split_pipe->plane_state) {
+			split_pipe->prev_odm_pipe->next_odm_pipe = split_pipe->next_odm_pipe;
+			if (split_pipe->next_odm_pipe)
+				split_pipe->next_odm_pipe->prev_odm_pipe = split_pipe->prev_odm_pipe;
+
+			if (split_pipe->prev_odm_pipe->plane_state)
+				resource_build_scaling_params(split_pipe->prev_odm_pipe);
+
+			memset(split_pipe, 0, sizeof(*split_pipe));
+			split_pipe->stream_res.tg = pool->timing_generators[i];
+			split_pipe->plane_res.hubp = pool->hubps[i];
+			split_pipe->plane_res.ipp = pool->ipps[i];
+			split_pipe->plane_res.dpp = pool->dpps[i];
+			split_pipe->stream_res.opp = pool->opps[i];
+			split_pipe->plane_res.mpcc_inst = pool->dpps[i]->inst;
+			split_pipe->pipe_idx = i;
+
 			split_pipe->stream = stream;
 			return i;
 		}
-- 
2.40.1

