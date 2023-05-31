Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B37175DB
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 06:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjEaEtB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 00:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEaEtA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 00:49:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726FF9D
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFWH1x+8FoHi+BMq/cz+wAX0lDEHUCxl7hPgc9XrsGU29t4cQK+jYEPpcfj4ier+qyQ1A3OgjMqqgKt6Q+Br2l8AFFOOFu2glWK3TDD2p6jXwxIs0hZJhEc+lLpbOt5Dx5gzqXuqsk52iJd2VGJ9IYpnrPInbtDXz1a4L3M2e05/aHBIPsKUDKz31/1XPFSBClGGSEaM7Hm76rdyQmUZDzeuUr1asSdnfwCxJTbRBALlGYVN4s/ip3GVqMBhWDxnmewshm8xuti1bHGxK7rocIWivw3bVK8SqWVGZRuunCpdDhP4Y4zpMMr5/XnI3XjrSSufiFH741f09iRElWrCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR0CFOZIFDYa8XAxhlLCYyZz6JvWqyi4CYl5341mCeY=;
 b=beH7jjUQIKahw6b4KNIr9EMQtNkAqOYFOlg+StAHaVsB9MtK69gvzBBrF/7yt+7TmteiDLt1KjPYT9Jxxc8Bi49BD/IcCe74hjceDD+R1RvdU/fF7uqLAHS2uxIjXr7eKUXhlIDHa9S8/yum5PFyCRV2qBJ6+qJq4yP2ulI8EtBAHWPFFJPOwQTpnXioF+BpfzbH73GEmwumQHntZ2KEnKkT5dYl/Q4AmXKZ0OzXukL3YiACMWLussSnpqcUy/EmM11jdo1VVhFy8KMXDHf+glo4BFBTU72nbEQRovebHmnx13L1jdblq4DU+Nj0w36XUZWVZcMkjToo3fMW/Rrc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR0CFOZIFDYa8XAxhlLCYyZz6JvWqyi4CYl5341mCeY=;
 b=UB+El0uER7nkNfVgxiDeZBGuvciYMQU/lXQhuULTybQe58qLpXLiHOoTgn+IRQkXLEho37DCV6+FkcMRZ8jt2U9DofQ0Gds0qk4ARhB+/3MK+QvSkFlXIDJqFisw+Ui7WMCOqMtoms73mBLj5SLjh6WDrVq0xSYw/Lsuoyle784=
Received: from BN9PR03CA0393.namprd03.prod.outlook.com (2603:10b6:408:111::8)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 04:48:56 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::7) by BN9PR03CA0393.outlook.office365.com
 (2603:10b6:408:111::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:48:55 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:48:50 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>,
        Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, "Charlene Liu" <Charlene.Liu@amd.com>
Subject: [PATCH 02/14] drm/amd/display: fix seamless odm transitions
Date:   Wed, 31 May 2023 12:48:01 +0800
Message-ID: <20230531044813.145361-3-stylon.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: ce769414-28ab-4103-7771-08db61925737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aniOVEh+ZHOlCBjmj5sePQ44vbruDaUv3ZYfWN6BXBZ4kuA+CbPDNyyhF7rPRQ2cTJNFscfhlsrZpvCBf8pitZGOMqgnNlX0u/iT+gaGgDL77q3brmKWKGBpULkRr2hltiIZlHHKFgSLCaJAgU9o6EMfGkff/lG3lWn0qFbSvTdViQDu7+A+t7NmJrq2en/HJqIeGKJA57EF3v+sNOhINVC4oZveVMhguZvh63Tl8WOydUs5PzRDif1OwLRIngIWgvfSZAzWqyeHzbOp7GH2CFbTrv3EfK5wTQo1apMCgV7Bgj2fJy780KdvULY+C1pSWvw+FQ2VESjO2i5taecVSxD+n9pITEXKS5edzOtKalW+RmropJrX+KThlFqoGcBWewrmIWp3NhOwS920B6cHdibYFpX583gS8Aqhl2vGCfGWCaVFki0xqut2TMI5C/rQGG6qo1p+TxDp+fziMYczWZjpg3BA8ZENOWGWX+PWffbdRJZDbbotQWIWIBQoJhkpXVo77xMfjk7X0DkorxFBrbWMuKmTmo+VlhhsHItkUtWlEuxA4kw61pCv6USCVOqfYRnSVfG/izRWcW3vDkGDt6Wl5sB0RXbBbS8krb6H1RSVNWEbK7bcfFxIrcwEk0KJ9YJlHWZSHffnd/bAZMQNgvRgKLacl0p0vFRFitVzAUdh15t08jYI6exNzQ566VaaZE6HL/liMP2yiyhcKBdBYi5w2vhcomJbKXmqabofylGInJDi9JqGOfWD6nkcH80l6rPpbkY0LHrjGQ7QSk6TzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(316002)(356005)(6666004)(82740400003)(81166007)(6916009)(4326008)(16526019)(86362001)(8936002)(82310400005)(7696005)(2906002)(8676002)(70206006)(70586007)(2616005)(36756003)(54906003)(44832011)(26005)(1076003)(83380400001)(478600001)(426003)(336012)(47076005)(40480700001)(5660300002)(186003)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:48:55.8960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce769414-28ab-4103-7771-08db61925737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Add missing programming and function pointers

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h  |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index eaf9e9ccad2a..20f668d28364 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1741,6 +1741,17 @@ static void dcn20_program_pipe(
 
 		if (hws->funcs.setup_vupdate_interrupt)
 			hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
+
+		if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
+			unsigned int k1_div, k2_div;
+
+			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
+
+			dc->res_pool->dccg->funcs->set_pixel_rate_div(
+				dc->res_pool->dccg,
+				pipe_ctx->stream_res.tg->inst,
+				k1_div, k2_div);
+		}
 	}
 
 	if (pipe_ctx->update_flags.bits.odm)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 6ef56fb32131..2cffedea2df5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -98,7 +98,7 @@ static void optc32_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 	optc1->opp_count = opp_cnt;
 }
 
-static void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
+void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
index b92ba8c75694..abf0121a1006 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
@@ -179,5 +179,6 @@
 	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
 
 void dcn32_timing_generator_init(struct optc *optc1);
+void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode);
 
 #endif /* __DC_OPTC_DCN32_H__ */
-- 
2.40.1

