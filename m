Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58478750F5B
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGLRNT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGLRNS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:13:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F7010B
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jckCdmtleJ3wlBZ/DAiOKkfGHO5G+V9Quo4VDV9r6wh5spCALuTQl75WB1tRHnsY8zBkVlZk9dmpU509jkecFZ/NtBRuxnE+g584VAciHgRVxUTs1va9cnMuV/GhTNPktMRHkaIugjn0qk3nydp1zxcunVzt8DmNh9A5krg1WJSdCZAPfyrTj8A9GG7g9xL0n0i/AhmDZmHep4DsXHWg3mI2UzruV2xL2rNBgCllx6J4cLwn4g5THSQ/PttQBQbKCR9qXlVk20+MJaoBTON76geX+VK2odB2L7BVog8Kz0HDXBgDr+sOOD6QcX6aVr1xwDW7Ow6YmgS+uuZjeee5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOe1bZT607MyrdSJb1UNg44P05Yd+sQBlLO/IZuH80E=;
 b=HATNwPdukPQ4gt9g7ri2EB3+COMo+Aq+MgbSqQuZb3hZswS1tn7bmTQwiu0icNWlK/m5PytG+10xh5cybn9vVCjejnPk8okbys1NnENrB1DlsdkgrMNYTIOpUBWnit2SV4NJ3763JQXiqzElSJm47c7WgnFAcDwE0+J9TiUjQhpwnZDHz2xjH+owFQJi+h0o0pLEhhzqzvWMS/08SNmFd2/4yaj3usjCaJxq+fd352QZ6IJQDNJYRZRhwtK9nfapgczDSrS10mEyui2RitHavG+sg+rJNIcqwYp59igv1o5KsLRNi2ygMGvdyGed8b+byMQcjQPDrsVj56gcln1/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOe1bZT607MyrdSJb1UNg44P05Yd+sQBlLO/IZuH80E=;
 b=WUomutGEg/yeHR+DhM39iW7h/F4Maii8in7+Tx3fp6JPsuHQOBBGQqOEhKCh/mglX0++JL7NYV6oNBBmjWjL3T8nr1FdXHdeNZTdvX0KGUFzlepcqYthx1qotztx83wCbLq5zNSx285VlbNMZT5W+VjMwwGF81TgKTj+x7iS3ic=
Received: from BN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:ee::30)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:13:14 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::91) by BN0PR04CA0025.outlook.office365.com
 (2603:10b6:408:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:13 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:09 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Taimur Hassan <syed.hassan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        Alan Liu <haoping.liu@amd.com>
Subject: [PATCH 11/33] drm/amd/display: check TG is non-null before checking if enabled
Date:   Thu, 13 Jul 2023 01:11:15 +0800
Message-ID: <20230712171137.3398344-12-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: e19d3ec4-edb7-4e84-aeca-08db82fb46dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQ3k358wZfJ/rsC6dkHkS+jWjNBMQU9wMq2cjd6hGBciKAw473tRYABlfoFXO1dISt6m1nSjDk0dOushJHdmKZYF3jeAf9SNPhOZ6cuAlc7l23kyTf2pl4AxLnqjOd0PP9SCOHBBoi3W0xxXDMf1QJHyTBItNOxfFFViP62o+iZG/LSQ6Q43zaH2F0EAIEI0+4wjnpT6mubML0hy/OBv3gsLWrM9bo2bxoV3Xs/GAPIQbjw0yRdsroPvW1C7uTGI79RGJw+DWc47m8jzHh3gFdAc4+2jVMUkRofVdjO19ySJ5zPuKPP6QZ6jQz6WAjKjdYmdIr58V+yK3apdPYgCOcP5fn7kL65LsNpeuZ32ydn1YF8WPfFB5gW70hcWLFs2HM0M7qL9LSOD4E6VtlsWw6PKN7Th3x2qLY0XL5quEhk5tkgipRXqK+FcvP5IiEU5WtyRZqxEjTW2hYhHnIbz0tJ/gpGoR0ggr/CcGVbil2dfL0+B47Xa444JRAbhR0lHgbD/s/FqjRIRHerwqQTFn8fCJ2pb5D8drMfosVI/DOkawcS5OioH106v2jQmxm+ou2krTra7xHPbB4Ss/wKMYqksEjJCo1yiXWRRtPARVHNnskaZWa8GmtfsCpE1DCwh2kcGvzVGb7vKBudDminYkg5n0l4XL8jNuDmGDM/IKwIt2okcEW3v/BQr7b6UoPc5R5c4sXO3xR7cSIhmT6+vYq98PIYLfC5pvOht0JiFCWvj3kyDOHkqtc67bq79a/0UTiBGUWMDuVwW1lLKfLUO9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(8676002)(8936002)(47076005)(36860700001)(83380400001)(426003)(2906002)(336012)(36756003)(2616005)(82740400003)(356005)(81166007)(82310400005)(86362001)(40480700001)(5660300002)(26005)(1076003)(186003)(6666004)(6916009)(4326008)(70586007)(54906003)(70206006)(7696005)(41300700001)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:13.9923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19d3ec4-edb7-4e84-aeca-08db82fb46dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330
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

From: Taimur Hassan <syed.hassan@amd.com>

[Why & How]
If there is no TG allocation we can dereference a NULL pointer when
checking if the TG is enabled.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index a50309039d08..9834b75f1837 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3278,7 +3278,8 @@ void dcn10_wait_for_mpcc_disconnect(
 		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
 			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
 
-			if (pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg))
+			if (pipe_ctx->stream_res.tg &&
+				pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg))
 				res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
 			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
 			hubp->funcs->set_blank(hubp, true);
-- 
2.34.1

