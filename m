Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F9750F65
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjGLRN4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGLRNz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:13:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D131986
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rpx5NgPCSogLyUjU1Nknc4Koeo5rZFhZlARvF19/pR9MgDUj7lSB6SRaaVpm8dLasYJyGFzNp75J0wDRGsHdlmJJi5yQmX/K6D8QmdWH8kUcINyGVyqkdHGvxM7WQzCEttnckFOBtXkVb2DvhjhTWYYA3nNgPbk5+Gky8yCwYoluT/bZyuHx4npqUy5WVK+/mkpU68fCEs0HvyDGCHSXz5cZK0YnJ6DS7UV3dPHjdtxijE/KDaESdqWAtfDzfLUvy128sZhJ2JmrH39hsbhsE8S01arXQV8JeyRpAwhUj3xJ3LCqljan4hw67D0nn2Vl/GpxWQNr4Gwjj4XeoWGZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD7lLyhJxJJOgu6PZSbO6zXmpw69IukuO1vP+q+YTMk=;
 b=SbbDtFOX6jWIBR46SzcNTvtwUfVOEP2BzN/e4ECSn06W6ORw7NiMLfrgTzQutpd/wGal1SyRW1EWqiUOPPK9ej8WiruSxRCwlp/pubYDfq+2N0IgJoN895HWSdfTK5oogtCyrSiNhxCvPBjJdSoQFEX6M7wtKVnFbQSO1aC2ki8/gBd39YZ507snwOVCgIhvUbL4M+NkpItP8W6EoJcptvQswiS960cY10ilwNpDUnbyBxIkNcwLwQeiVdeV0QGZaUwjcvbwZIlhOkzGQopTMIExm/SrEH9qoo5wASa52G31h0Jdhba9Jpd3mom0qQ+qIVnjEiytik7neS3nsIocFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD7lLyhJxJJOgu6PZSbO6zXmpw69IukuO1vP+q+YTMk=;
 b=xWToEhNgJ6B1uMF4LXVNWO6FGM6rIbdwlay1FeiUngsuxazQvUVbkC/cnbLi9SauFvXFYu0TZtTJHKYOlTwk2jD4sH0c/aWHFZZcauxZkYHox3/TGUXzn6FHcvE5H8Nh8bQiQQPtWFb+mx8aErLv8QRt4H8y+HZ/1ejwmKX99Ng=
Received: from BN9PR03CA0736.namprd03.prod.outlook.com (2603:10b6:408:110::21)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:13:51 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::c5) by BN9PR03CA0736.outlook.office365.com
 (2603:10b6:408:110::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:51 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:46 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Daniel Miess <daniel.miess@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        Alan Liu <haoping.liu@amd.com>
Subject: [PATCH 20/33] drm/amd/display: Prevent vtotal from being set to 0
Date:   Thu, 13 Jul 2023 01:11:24 +0800
Message-ID: <20230712171137.3398344-21-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 7641eef6-7f2d-4f59-ffaa-08db82fb5d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhpsBsq4/H55u90WAJWS5UlN9R7FVsHcDV2/mxJU3ScLWUB6uJR/e3L16iB3yP7Nd1O30Uaw0A1dzldhq0KeuShKTtRGHMTNYKWqfoBCSJl+5S8x8uVkFZ8QnbGnliRXRxg4SFp4VTvb9uaoG/Oc/cgBPQlp+z5yQx+gs5eyRMi/6S92r+hXaXuM1xnBV9MpbzGSaAOsCmIPfAaQz00JbK1eFn1gD7nR44CdHG6ShuDxKG5j2hqtvsJ9v4X3xgWaxsu4JvpknkTdHJK2uV+Ifa8E1cAA6ZZ37UBauxcnKFxvvmcSN4c0bQPkshYAa3xJ6vJ/gwS26HkZ1CMxVgfFhsdBP9jSCzi1c5fN/xASZKe+SB31FGNr0+r+569S8DJYNjflDxIO4O/rShz8zOnTMUT/287cTm8M347WqUw3BJmgnEQNyLlsua7lPo2UY6cI+yMxI89wOGZJIx1lMBuuONw2qdMaxP9KCrfOWSTmPhKUZb48wn+Ny1mVioICYF/wvpeIId40Y1COFQgkIG4x+Ejjs2ZdfI862Gj8mXwuuHwp29r1kOEayuP8kLPAwp5vFEgXYlFH6fOwQnbuOHWZuNif+SqfFsWPopUI6sSsEmqZse3iind9fYvI8oFz+0T/9Q8/ZUrpd5+VIRj/rxuVpQsvathbr84sMtzRdLEbBI6EAZi6UuFfepWNlgqfyEUZZZU5ytc8MB9JrNJnpnOWB00i8ZWSkRkyLhPX6R20kn+Msylyx+DL0LihcHvAApRtoLnpw8sUdCjKidWTn5aU2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(6916009)(4326008)(70586007)(70206006)(82310400005)(356005)(81166007)(86362001)(186003)(336012)(26005)(1076003)(2616005)(36860700001)(47076005)(82740400003)(83380400001)(426003)(36756003)(478600001)(7696005)(6666004)(54906003)(40480700001)(41300700001)(8936002)(8676002)(316002)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:51.4876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7641eef6-7f2d-4f59-ffaa-08db82fb5d36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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

From: Daniel Miess <daniel.miess@amd.com>

[Why]
In dcn314 DML the destination pipe vtotal was being set
to the crtc adjustment vtotal_min value even in cases
where that value is 0.

[How]
Only set vtotal to the crtc adjustment vtotal_min value
in cases where the value is non-zero.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index d9e049e7ff0a..ed8ddb75b333 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -295,7 +295,11 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+		if (pipe->stream->adjust.v_total_min != 0)
+			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+		else
+			pipes[pipe_cnt].pipe.dest.vtotal = timing->v_total;
+
 		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
 		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
 		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
-- 
2.34.1

