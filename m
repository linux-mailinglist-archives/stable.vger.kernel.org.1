Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A4750F40
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGLRG3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGLRG2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:06:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7694B1BD6
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxcZaf7nRAguAMzuaTBV12AVmEb0+j/xlvhBfb0hFSEeWnQkx9J/AtbuYvrV4yMwl1xjBYlkUv4stK63OI3TIH6hmf6Oy5mGH+UE+EZsE/z/w709FNNe71M/kzqtUSEPKmI8c2aijGSWlyqH8eQd/NADikvfNerTZhGj9bvHr8G5UmLCQk8YfJkJZVYZczbPNHemGaelSHnVOIK6iTZtHgJ/T01aKpvrHXdJFKMRzntbkMOqU6y9ffF1tYx0w9fLU7nwDXZcLSlYzSbJtnlKdeYn8m9MUfKKoNTdoZvs/PGRFkLieMnYzdmuEZ8NJq/CxrjZh6Cyq8HG+Ugl70cHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD7lLyhJxJJOgu6PZSbO6zXmpw69IukuO1vP+q+YTMk=;
 b=KsEh62bF6D/zvh2+JlQ/vQoDttzSo41OFuAsuzatAR8G3iD9Omswk/8USmfdMhtykOUaA7/x/yGEz1S60ryYZuxVqhN9zV5/LUkp0zjg53iGb0gOkF+zvuW/SZNiEDCDL5F9TDsBtM9+V998cfDBFm8DYvbfuHY4WMYxXvUorsHsBVWrZV30R4Q1DLbHf2tcPeEnIXYmu8zIcfXx6TmFiXbU7fnIiv6m3+e+BLBjkcyVTL6lvKppiDDIshQs9mT1GCTFgz+qomW/WOns7ir3EkmjCsTBVzji/NsgQ9NpAJHFXBkohQB30Ij3b9cAr+8bTclA2ow+QQ/kTmHbT7pjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD7lLyhJxJJOgu6PZSbO6zXmpw69IukuO1vP+q+YTMk=;
 b=OLvrqZf1xB4OpyNQkJn/ovdUgrIi+EkdiOZ3JRCWx/4D47nlU1VXauXUX/OJv0pM8U2d1RFgG2Lo/TPZ0iE5wXNDw51rWIXig8tHdG45yYDH6R2+DXa2OUmkU132ZOTQYN3JkFaK251BjuSXvHJ8mT/r1Q2RoTOh/LiGF199GwA=
Received: from MW4PR04CA0266.namprd04.prod.outlook.com (2603:10b6:303:88::31)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Wed, 12 Jul
 2023 17:06:24 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::ae) by MW4PR04CA0266.outlook.office365.com
 (2603:10b6:303:88::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Wed, 12 Jul 2023 17:06:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:06:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:06:22 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:06:20 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <haoping.liu@amd.com>
CC:     Daniel Miess <daniel.miess@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 20/33] drm/amd/display: Prevent vtotal from being set to 0
Date:   Thu, 13 Jul 2023 01:05:23 +0800
Message-ID: <20230712170536.3398144-21-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
References: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: b40b31a2-4315-450d-f9b5-08db82fa525d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Oeln2oepcQfgkTgK4mIhlLj43cxGvvi7tvLS1nbnNY3UkuT2Gq55Rrt2fGZsshNUXuHNpYKtd6uI49Jgi91pU4wm8c/qB4Z3xg/Z6v4GLkLTPAn+SwHhX1P4gT6N/qwJ7AuonqeiuvulA5LOfZg6Wu1waNGbOT5lxAL/47CTg5xxCnMOzsL1eJChIfxYgPm7cTdWPTZqJ2DX/NpB/HqGKuxRRdVF7F0K73ETkqIaRgcr1mpU6hDO9akYwtHlkE5vvN1Gyk8QZFv0tMlVGUPiR6jlERYRmD6YNs7n+Xk+kbK3hHHakoA9k3iX/CNIld5Ik2r4TuFoJcUokw40WIXKk//n3y8MzNGx1QpXCt/Yj6eFf3hHVu3KjwjNgNStHB+aRmcVvi6gBlu1mJwUCVDddRKt1sBO3NoQV92KH+sDKFj2j5r2bwqyqmM2UDaPzoeABLVVPxxwH5dndhoS6RF/dlBBGDOjYZZ9zbMzS7pgjNo/7AZrAsDZdy8U8eBNmGGnqiHOYxQML4e6OcFZx2IY4LffelsReBNBiaQ2gfl2cc6Ag1soY4ORj5CTZ4I47EuICsf0Wrolt4zUT//wtGoUTZ3oRJaauDWPmf17azXd2V4BPBPU/xJuiv9CDqJglDSg+QzFf+0bcZyYWOtN3wGXimDs3ibSAEVR1rFMxG3AQdrB4PNB4l1ErCYA9HrEWn+UIVe7nM3NTS206YtxTcFapymPANxNJkWsVOUR8QWs641Wx+tf8hT+aAyj8yvovdBwbgi0PnSqdxJGSajtk6Gqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(336012)(26005)(1076003)(186003)(47076005)(7696005)(6200100001)(426003)(37006003)(356005)(82740400003)(54906003)(478600001)(81166007)(36860700001)(2616005)(6862004)(316002)(41300700001)(5660300002)(40460700003)(70206006)(70586007)(4326008)(2906002)(8936002)(40480700001)(8676002)(86362001)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:06:23.6820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40b31a2-4315-450d-f9b5-08db82fa525d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
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

