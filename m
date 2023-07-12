Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD07750F3F
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjGLRGN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGLRGM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:06:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105919A7
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK2QXCbP2UnQdb4j7bQiTfCtIhpyzVveUfqWL1AMHpoCrLmYBI2pUT09s5GKzX1ut82pos3A6VNCTDEJc2ZY3RIbrhkCC64ntxzFBt53rpcCz9WHwTPY4yR+HPHg0UTuQkYzzosSS2g3I6ZMkWVq23d01CODZHsorOYdiCrJxCG7Z3L2TfecQmiSSR6yPyxXwuKTGhD644uqTx0he++ixogDJIwLalaCo8WsKmX6d2OoRx/MZR77RwiYNuUS1hwVvT71lfl1Eiv1n5A6TdxxOnZvwtDpJZBtVnkuefrXcb4fp3lvGdZ26GShH1gzjC9YohyWHImLYxRE/HazkyfoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOe1bZT607MyrdSJb1UNg44P05Yd+sQBlLO/IZuH80E=;
 b=FqHEgeLBQ8iDwxz8E9roYNOl/fs2Qh0zd/8qtXPPpgJBkltE9hovakmoyGKN7FcVi6ZhVOkXQMixWemIgL6J+R9fjCYLwhE8Hkg7arTUOdQ6s+Fz+m/tb4cz6SHi/iEElDQ7w5ub7b+beC8uXKYDo9JUd2N4DdnO5KGk5sXMm3CcdMJFRMUrWx79jLSqjm1yScmn5NNOJCPj8liJD8zGUYgECSibx1tQfftDuCxr+PdqhX+moauyG4Hq2U1Ui4zH+whY93p+28aYSAG4bM4bsb7sOkU8c7BX8gIg1Xbt2MAoUEpe96jdkdo9K/crNjpcxxtNWax8/Ksi6fnjuMRUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOe1bZT607MyrdSJb1UNg44P05Yd+sQBlLO/IZuH80E=;
 b=CUEJWd2oJGxz/15p1kfrPpE3VhgvagqRk6Cnhf7VFS5Cxz/Xuk43h5nTPlDZokKIJyoX2PxaPEPGJ+Gsc9+RFYJFyoF82gzOkq2fVlohytrHWez8hcbs2J82v9Fb/K0hS1D5CNWkQPpCqDfOFGUOYaCzyf1yc/cakh/iIYEfI2I=
Received: from MW4PR04CA0226.namprd04.prod.outlook.com (2603:10b6:303:87::21)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:06:09 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::cd) by MW4PR04CA0226.outlook.office365.com
 (2603:10b6:303:87::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 17:06:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:06:08 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:06:06 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <haoping.liu@amd.com>
CC:     Taimur Hassan <syed.hassan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 11/33] drm/amd/display: check TG is non-null before checking if enabled
Date:   Thu, 13 Jul 2023 01:05:14 +0800
Message-ID: <20230712170536.3398144-12-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
References: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 106e0f63-bab1-47a8-7489-08db82fa49ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vtgx2EnHSjj/ERPr+jppmc0JuNOp5Bp3hD6wa5zjyvyfg7nZ2Ohhc0JdudMhLSAR5ScY0hKibdYv3yrTXMBpTHjoIn7G9v9mKjpMEa5+S2PExShrSqb3KI7COxtxWyRbW4tJmnsfCoI7zfyaLpn34MqoeEPQHHnbmNBrtHfORNPjWmKHh8cs19fkuh2spFeFQaqkXvC4K2lxybGLfNPxomJZS2TKEKXhqLdKlCDKEfUQkMYxVhc/v0JuFVRckQZVLE9gdXuxlKrkLdChlbGMJzVAq0p0euSmqWjLYT/32C4V5UUOBdr8mhOST8Mm8PMKzwxYbaXtO7gW8438EIhatylkjgWCoae5r8XgB1gCo0S3uELuW1rQqG+6df8dWKzIUCEfKMHokZ6j2Ux31uWVnwLnIbnAiiK0UifunaLZpIGifRvRc+XTBIG6lkKBxHqVf9lFU8umpdUAJDVR7pL5ufAARAop30GqSMSo2OdtKesnJK8LBb+wS+An2leeo9OQsL3xr5wkYnQjrK2UTqSHbo5bQRNo1vSVJsRt9MuVm7eojRLvdzzLd9xNdWHaRd9/3ML2tHhhUil9LhdPTrdeJwJjZ+WZw3zVVRRubzZTr9NIMpQbtz40OoQkfLv9n5LnOxDq5mpDvDPCL00aS247oNRZHsejkOL0d10bVapsBhbRor/uL+m1wZgcxrKUYNChgqqR7Nms245f7kaOtiBtLmpA0bg0jRPZ11mgt1jG6ZcVk6mrTAETOoQx4QqrYJigDq/Hf9r9OaFXr+hvcOl5yA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(4326008)(70586007)(70206006)(82310400005)(356005)(81166007)(86362001)(186003)(336012)(26005)(1076003)(2616005)(36860700001)(47076005)(82740400003)(83380400001)(426003)(36756003)(478600001)(7696005)(6666004)(54906003)(40480700001)(37006003)(41300700001)(6200100001)(5660300002)(8676002)(8936002)(316002)(2906002)(6862004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:06:09.1033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106e0f63-bab1-47a8-7489-08db82fa49ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
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

