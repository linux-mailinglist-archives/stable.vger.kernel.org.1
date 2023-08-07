Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4A7728E1
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 17:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjHGPRS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHGPRR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 11:17:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8204010FC
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 08:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNctrHWLHcUCLgQ/pE5a1MLSVOi4KJtaOOOX+9+HJinmu9Da4Rnda6zlxLy27XdCY+b61sgyJlPYwRt1HYiHhfl+JpoKP51PY0osi/VrTb8R/2b6dojfmU5SktsiIWXp6mvTXaSwQApGxrLVHSRKn4UGDe59xXEjY3OWho+RprBC0I/7bB7sHPl+J8NZbtBEbjWlgqvskJkFUDiJ6RG+2/nk9wXei7cRIUS3usLdk3uRm6UbTe+o7qx4zPtFaPy/jfh2YbXe6meDA2Rqv1T4R2jB0NylUDO/8+BY93JYdWgnCt7nWm2cCD4biDHMe59SErw6i/t4w6dsAKkx5BCL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOs8vmh/kbQNX9r1orp38EoNVOZov2m5+MRPzSz9M8I=;
 b=AhPYSQDH7ETypXM48yEoB30xov3ZzF3apVCqnV5zBk4R4esR0diQJL6TZ5Qf5nyqu8Dg2nxsECwA/3Q+amPGnvRDxUa7xXwPXH+e/GOYZxPqjrrpZiVog7e8HGtH67LyLikrcsRGZiOTHvbrpUIhNpglLuWG9VT+/0zrkDrFyivNcexr1Sc+yd53gKnU5ueknl2uWWHVLngB0+on9WBiS53uH2T1WoWoKvflzQV02Y7Fh64mAXtgFmjWBqLRNAglpRF21c6LBu4wIE95qBD2fn2YrrMPocA4g//PEcVM7uxFo6OEH9LFW1suJyTnM1/lfF/gUkLmi5wJdXRkBBcaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOs8vmh/kbQNX9r1orp38EoNVOZov2m5+MRPzSz9M8I=;
 b=NvoNKnBLyIQa9WnKU5V78nnmNJGGu3A5sAXhViO+o5DGThAL2PwFNWOaVBiiReIbMSkIF5TSJjG3XkkNzSefDxzCpPctdJCHqSfz+af3xZqYggSfr7/tmpaqjckGeIKbQDzXxu5Q5j2hAxDIHBgv9Qf0ErI1nSit6ZI4lBBSU9c=
Received: from CY5PR14CA0017.namprd14.prod.outlook.com (2603:10b6:930:2::16)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 15:17:07 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::9e) by CY5PR14CA0017.outlook.office365.com
 (2603:10b6:930:2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 15:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 15:17:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 10:17:08 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Peichen Huang <PeiChen.Huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y] drm/amd/display: skip CLEAR_PAYLOAD_ID_TABLE if device mst_en is 0
Date:   Mon, 7 Aug 2023 10:16:56 -0500
Message-ID: <20230807151656.27881-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5c359e-c8a5-4f99-914a-08db97595e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agvZjSm7F4xykpezrMOvl1Dk8agncMXNdW0YjRbpEC73IKIxW/lxRZHuIuyjNLT493SBryTKzUZUX7KD3YLenldT++HEK2d6QapXtlVFAGkDeRcyi/UrdxvFq689oqQPJTZf24T0XELVvJtevyTSDqWyPevM8tnFe4AjgTrqG4/4hoM3XD9//wCPUdf6WoSq6PmumFvNdPl23mPpil1aYI1gtC8SRNqUy3EMAmtnYcMEA+qczb+0y99WNNqjN+ed+p8DYDKr80xJLO44BcEhjwbPvaJOs9g8ODlr1Qf5ry4S0PiFfaZdHcC+civagIVx5YhmKtHnBHp9MTRcBvI8KmCygl+2y20L4mmWz63q99ZGv3lOMcq5/OFkmnAh3cLQnRT2KZTQDbpR4xNDZVcA4/doObFcUXypT6XOBt409pj+O7fePciF285aMs+CKXeT7u58nqK2bohA1whCXE9t+TIBHZlYacNiP3kujxGicXAiYpoXzEikIfgKjjJ7WsO4YIjqbQ0oZ+UKVOayW8yv17X/i9PQV2y722C6LCQLoG3juS8C2WgCTeJHd3uH0KSERbR5fTx5YIheKBLUriiBAsDEJ5/YUczQU2c5RVRzKBYnCPPq5VSTkl9siO4MOvsKc1Ts+U7HSMHYIZgsVlKc94uUARff6tNHZ6vOOjny1+SbUnetxY9WzAVr1Nwwk2AQZO+9l1E97QLnLoYfkdZSVZyuDOeHoaF0mGGs5pl+JrGLrkY6VzQetLX7OA/zpGEX8MrW//r4B0uVvPOKHJv7BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1800799003)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(426003)(47076005)(36860700001)(2616005)(40460700003)(40480700001)(54906003)(2906002)(6916009)(4326008)(8936002)(316002)(5660300002)(44832011)(8676002)(336012)(70586007)(70206006)(16526019)(86362001)(478600001)(81166007)(82740400003)(6666004)(7696005)(356005)(41300700001)(36756003)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:17:09.5724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5c359e-c8a5-4f99-914a-08db97595e86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peichen Huang <PeiChen.Huang@amd.com>

[Why]
Some dock and mst monitor don't like to receive CLEAR_PAYLOAD_ID_TABLE
when mst_en is set to 0. It doesn't make sense to do so in source
side, either.

[How]
Don't send CLEAR_PAYLOAD_ID_TABLE if mst_en is 0

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a1c9a1e27022d13c70a14c4faeab6ce293ad043b)
6.1.y doesn't have the file rename from
54618888d1ea7 ("drm/amd/display: break down dc_link.c")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 63daf6ecbda7..bbaeb6c567d0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2097,6 +2097,7 @@ static enum dc_status enable_link_dp_mst(
 		struct pipe_ctx *pipe_ctx)
 {
 	struct dc_link *link = pipe_ctx->stream->link;
+	unsigned char mstm_cntl;
 
 	/* sink signal type after MST branch is MST. Multiple MST sinks
 	 * share one link. Link DP PHY is enable or training only once.
@@ -2105,7 +2106,9 @@ static enum dc_status enable_link_dp_mst(
 		return DC_OK;
 
 	/* clear payload table */
-	dm_helpers_dp_mst_clear_payload_allocation_table(link->ctx, link);
+	core_link_read_dpcd(link, DP_MSTM_CTRL, &mstm_cntl, 1);
+	if (mstm_cntl & DP_MST_EN)
+		dm_helpers_dp_mst_clear_payload_allocation_table(link->ctx, link);
 
 	/* to make sure the pending down rep can be processed
 	 * before enabling the link
-- 
2.34.1

