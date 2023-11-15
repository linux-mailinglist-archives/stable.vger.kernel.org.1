Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6FF7ECECB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjKOTor (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjKOToo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:44 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905951B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWSrC/SJ1DZ0yxTKuRyb9DRMNyHtzRsC59SUi3+3Cbn0NxjOj1CcfaH5DNPDRXpYf+5gvTF2YiZbcC5dVqpHP8y/pDIKVXqDJokY6vT4NDh3w53NScdM7KsT1p9+0NDf7EaBQltnkagyli1AZbZMQIIGn2msYJfR0zCLZ+KWj8XHtskH9VcO88Qt/QX2XrWPN4Ivl59evZurAhfLWNZvGutC3hFicljh/TxIoZhRUkyNF/lgFMlVjLgE8SLWbwhckueJqa01HFsikJH9Tv1YAWfbuU6zjaE5e0G0fQinrccvLquuN3b+XJy8eEts+RN4HxTSEc/uihyJi3KH7AocOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ohmphher/PFdFR0NnbiojqZNzgJavFLU3vu/Tde4KbE=;
 b=R5jc19qAadRMygGZ8NNnmnYiP0996GJdfHSSF8uQtPoC5w9S/KY+LAWaPxFTOw7FJ40WCJU0uQJSl4iSupy9bSLk0QLERvnnKCWTDaZzCNeV7A7OeJROhOKvyc6g2+H94vHITqFwTbygtyd2VUuZSC9Cfcg4/OwdD3do5VbtIn2ShR2PGvOI2PpYtG6j/kE7uCf6QUrmBPAUStBZJK6Nab7C7Zb6nquFHK0gUVm/jZKNvpEEKrciF70aKef4VdJriek5Gx7Xt2nWziM09Am2C1s8Nz5KuXJCyw0HrwXxyZ1wQgckbAoJik9tyWRQyTJS+0zoZeUHNJa0t6rENY9ahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ohmphher/PFdFR0NnbiojqZNzgJavFLU3vu/Tde4KbE=;
 b=faj7H+zMm6PdWkwjQNFibvg9JcOg2I6jKXTrHgcqMB7vtjYRnawcLTJv+QE6/cnvOywzkHrPymwgjmRSw9rFXQFNhgC3fwPgzBIHW9RdwzR4mgW7NAjEf/QKNhNhqr7kcdjM0WH+EPhAU601BSdagZJXhP1ZKrfQ/k3AcPdiEb4=
Received: from BL1PR13CA0259.namprd13.prod.outlook.com (2603:10b6:208:2ba::24)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 19:44:35 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::37) by BL1PR13CA0259.outlook.office365.com
 (2603:10b6:208:2ba::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:35 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:34 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        <stable@vger.kernel.org>, Syed Hassan <syed.hassan@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 23/35] drm/amd/display: Remove min_dst_y_next_start check for Z8
Date:   Wed, 15 Nov 2023 14:40:36 -0500
Message-ID: <20231115194332.39469-24-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 243d83ad-16ba-4266-2c6c-08dbe6134bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4r397hLGhxD+8Qg/QoeymUlqoIyLxS+AqLT+QtcCwnPqnQqxSySj/RELSFofqtJ8DkgH1Acc0XHBtfcBh5VL1F6d0jvXKXC6GHL41DNOFufGNGcNjUyJyO8k/3pSXnAoeIokcvYIlN0CW0/CsSikSJxkm3IJYxw+2T80hw+QHtFSscwzA2MyYj32VxwAn7x2dq/NLSZ8qb8xWP3TJ5aTgmK/iqxfeUXiFDIskDL/8tes4AtI15sfTW0BjtOWtuD8OfTANJRWM973E6XRlcBQbK/MEWE7iL0pWZ60cu/PWEd2Eq+nHf1dZkA33v6LLhQwQhYrDY5hfdCJCwAKB1gnQbUyWq+xEb3QJYqN9UTjOcBssIyCF3ZkCl5Mgrazp6KfxutGMocGkHXCOJiZysZ0+M2fv1/cV8AmEbDuJvvtZBHvKsZbjTIaSOjwGhZa4rF6hWVUigmkd6kdtOvNKxx3DHQRlpydsrpYX4fy7BinLQ4sDiSwr9WcQ7cjE3gn7nEURIh0442H2PLsPAlMzjH6rP9UrglWP26IfGJfYcEyitxVHpxklrSd805k+8ystqCudwZcxwaXuTbDTFE24ZJblnsOyfrzYuKpqgY7HRa7qxRFnlddy7yk4vTS+YHV45UZpJBNBD7Su63GMR32iBv1BUa82TSELvDbpGIaev0CeImS3hxnu5EG6F04/LRm/bucJLrcpHOpw1XbAba8hvfLey4YsRmoNk4TRO1bnZyMlGICv8W8bB/FX+fYGMWbfXZjiG/olYmmppKfGsQV4RKn/UccakFKSPES0KOJJdNhpdXSV8i9iXZv1m17/Hb3Qa7C
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(41300700001)(2616005)(1076003)(44832011)(83380400001)(16526019)(8936002)(4326008)(8676002)(426003)(47076005)(26005)(336012)(2906002)(478600001)(40480700001)(356005)(81166007)(5660300002)(82740400003)(316002)(70586007)(6916009)(54906003)(70206006)(36756003)(86362001)(40460700003)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:35.6304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 243d83ad-16ba-4266-2c6c-08dbe6134bfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Flickering occurs on DRR supported panels when engaged in DRR due to
min_dst_y_next becoming larger than the frame size itself.

[How]
In general, we should be able to enter Z8 when this is engaged but it
might be a net power loss even if the calculation wasn't bugged.

Don't support enabling Z8 during the DRR region.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 7fc8b18096ba..ec77b2b41ba3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -950,10 +950,8 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 {
 	int plane_count;
 	int i;
-	unsigned int min_dst_y_next_start_us;
 
 	plane_count = 0;
-	min_dst_y_next_start_us = 0;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (context->res_ctx.pipe_ctx[i].plane_state)
 			plane_count++;
@@ -975,26 +973,15 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
-		struct dc_stream_state *current_stream = context->streams[0];
 		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 		bool is_pwrseq0 = link->link_index == 0;
-		bool isFreesyncVideo;
-
-		isFreesyncVideo = current_stream->adjust.v_total_min == current_stream->adjust.v_total_max;
-		isFreesyncVideo = isFreesyncVideo && current_stream->timing.v_total < current_stream->adjust.v_total_min;
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			if (context->res_ctx.pipe_ctx[i].stream == current_stream && isFreesyncVideo) {
-				min_dst_y_next_start_us = context->res_ctx.pipe_ctx[i].dlg_regs.min_dst_y_next_start_us;
-				break;
-			}
-		}
 
 		/* Don't support multi-plane configurations */
 		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || min_dst_y_next_start_us > 5000))
+		if (is_pwrseq0 && context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
-- 
2.42.0

