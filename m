Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB14785CE0
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbjHWQE3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjHWQE2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 12:04:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC84184
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 09:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddopDuC3+0G2zoqEYTeQItlsbrtNslTHtk/JZ9yg3ISKyPC/u4bK8LtIECLFZt28GECnEhxkHyYHllZyJqeVhesPNCvTtvOq7r9Tt7Xx7/mYEb9g/b1A56Bu1DUicSlV7QI0sPah/Yw5rnKeEw98Az9IU8oPjDwi2WieidP+zWMTjqDp0/GQOxx5gQsEiM7fuNtxbLyxgTuZHDMFpBnS/bAdhIDCkhA5cURL60W/FYz0TcsTt1HUJSiMkF/mZddATccFI9LDDf93WZFd46H58bFDvy9X9W2oFRUp/PcUSelq7Vpa6xIXbEAGWsXT7BQT8mN+pHoWfRmALqNf/DQvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zpVLTmH+NJaenHNkJgF7+FO4nAwG2vNeTK9PreeWfU=;
 b=hkSa/0ArxAcj/iUIulL5qqARxDRjisr/LUXGnlepm9K4m94XOKbRLGMnEnbtEmDE74fT8KhWwqkUCYAidbPHMqEFaJmNgJYx/iaGftjg2EkYcJmJsOad8LgfbwzEUjN9phpgU7IbHJCkhW8fhdMcGtRqZkL6LHK6dSICi55Ycxo4QWjp4Y5oBxyroHNUEikaZ4KX8q8jQjkxwCyB6AY/AbHBhWOQO5Uq0DqH0M9MT15engCu4gvMqvimgVViebP2xcq9RYbI4plK9OMiIQjhFIAlNoessqNveNl+nLq6FtKpPDXs8gMntxMYYNYhtMaTe3bizTJS/VfmWOIPN/LBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zpVLTmH+NJaenHNkJgF7+FO4nAwG2vNeTK9PreeWfU=;
 b=f8+FwRLQbVWYbAhjGeYyb3sLvVpcz06y3o+n6QdfBiM4cOhpCkfVO3PCQ/awV9xeqNaTIq5iAOIR4HvfqtZXt28800q89vFv0cG6wnX3QS9QszBAObDX6ja2iYRAfyqRVa7kr1OugAkHSOYswD0XTtm1Td73iWgUpDYfN125QkA=
Received: from SA0PR11CA0136.namprd11.prod.outlook.com (2603:10b6:806:131::21)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:04:21 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::6d) by SA0PR11CA0136.outlook.office365.com
 (2603:10b6:806:131::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:21 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:18 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
        <hamza.mahfooz@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>, <stable@vger.kernel.org>,
        Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 04/21] drm/amd/display: update blank state on ODM changes
Date:   Wed, 23 Aug 2023 11:58:06 -0400
Message-ID: <20230823160347.176991-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: bc821b01-c322-4eaf-4388-08dba3f29cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xxQmpdwdDdbYJxOMDABL6kWhv5NVs5eCTionQtVpWlvqp+e2oHeyG5I1PhCtPzszlYSORKN5XxRHgiFkKDGcPKEhPUeOgriVbIQ39W3xBnVFf9H8zpwUiLObupFjDTD2TzdcSe1/1GryaU1X5wBe3rE0cZ35GpJYKGQF8ZNKORiKSwhn8qGx+fsamOoY5h3HOE7sInB37LaEoF7TRX24KivJEz5vJd85cufIt57btGL3MK+WGccm1GOzFaxbUrwd9axSTqnn+7pquYuOLrKjXDPv9wsrkm0QYGVI0WeqxmrHNm8qv/2yYpICo/eVL+cuh+Xgna4mEa+nLNFYzm9pjb/WbkUnjMmlNfPG6HcpL3pRSD0QrTtd2XN/UroZKv0k6y1wHPixVNMGClpadzV0awj2rKhGPZrCv6Jxt6cNz5dmLh6jIVzTMPMB3Zqptbh/koiQb+bbACVLRvuAH423kUoCqodgo/6OxbelAbEtqs0zSAscs39dPsmJazuV5KNBsdkPpQ+Mh6Vd3EDDlJekeDiWExgdVPNrdQcg7+ntI2897Z291U2sbOO4srvsy7tbZHnKcEVHxXXdkq2Qy+ZBV5NMO9s8U3EX/NWO3qAzu3zlxn3cjMwPwq7zirRVsVRjLXCjSjmU1YPRnL53Yn1QMm0xpHUnffTTMqwBC+OAnVscY59nzK1+h4DSsSrBHBgXEDoXZac53wqgcqZ8gg36g3jY3qu3fSJ29CXVRvJnKqTxreykfuOf3ORxJuyNv2xQJLEYirMYcoCYHNfCKYxiosRIT3qG4KKAAYGBq7w67FBcpkVrZ5kWAcptFrQoMev
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(70586007)(70206006)(54906003)(5660300002)(44832011)(2616005)(41300700001)(15650500001)(316002)(6916009)(2906002)(478600001)(86362001)(4326008)(8936002)(8676002)(81166007)(6666004)(40460700003)(356005)(82740400003)(426003)(336012)(1076003)(36756003)(83380400001)(36860700001)(26005)(16526019)(40480700001)(47076005)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:21.3099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc821b01-c322-4eaf-4388-08dba3f29cf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wenjing Liu <wenjing.liu@amd.com>

When we are dynamically adding new ODM slices, we didn't update
blank state, if the pipe used by new ODM slice is previously blanked,
we will continue outputting blank pixel data on that slice causing
right half of the screen showing blank image.

The previous fix was a temporary hack to directly update current state
when committing new state. This could potentially cause hw and sw
state synchronization issues and it is not permitted by dc commit
design.

Cc: stable@vger.kernel.org
Fixes: 7fbf451e7639 ("drm/amd/display: Reinit DPG when exiting dynamic ODM")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 36 +++++--------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index d3caba52d2fc..f3db16cd10db 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1106,29 +1106,6 @@ void dcn20_blank_pixel_data(
 			v_active,
 			offset);
 
-	if (!blank && dc->debug.enable_single_display_2to1_odm_policy) {
-		/* when exiting dynamic ODM need to reinit DPG state for unused pipes */
-		struct pipe_ctx *old_odm_pipe = dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx].next_odm_pipe;
-
-		odm_pipe = pipe_ctx->next_odm_pipe;
-
-		while (old_odm_pipe) {
-			if (!odm_pipe || old_odm_pipe->pipe_idx != odm_pipe->pipe_idx)
-				dc->hwss.set_disp_pattern_generator(dc,
-						old_odm_pipe,
-						CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
-						CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-						COLOR_DEPTH_888,
-						NULL,
-						0,
-						0,
-						0);
-			old_odm_pipe = old_odm_pipe->next_odm_pipe;
-			if (odm_pipe)
-				odm_pipe = odm_pipe->next_odm_pipe;
-		}
-	}
-
 	if (!blank)
 		if (stream_res->abm) {
 			dc->hwss.set_pipe(pipe_ctx);
@@ -1732,11 +1709,16 @@ static void dcn20_program_pipe(
 		struct dc_state *context)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-	/* Only need to unblank on top pipe */
 
-	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->stream->update_flags.bits.abm_level)
-			&& !pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe)
-		hws->funcs.blank_pixel_data(dc, pipe_ctx, !pipe_ctx->plane_state->visible);
+	/* Only need to unblank on top pipe */
+	if (resource_is_pipe_type(pipe_ctx, OTG_MASTER)) {
+		if (pipe_ctx->update_flags.bits.enable ||
+				pipe_ctx->update_flags.bits.odm ||
+				pipe_ctx->stream->update_flags.bits.abm_level)
+			hws->funcs.blank_pixel_data(dc, pipe_ctx,
+					!pipe_ctx->plane_state ||
+					!pipe_ctx->plane_state->visible);
+	}
 
 	/* Only update TG on top pipe */
 	if (pipe_ctx->update_flags.bits.global_sync && !pipe_ctx->top_pipe
-- 
2.41.0

