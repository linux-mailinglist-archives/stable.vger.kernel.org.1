Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12928779931
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjHKVIu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjHKVIt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA1E75
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+WOQb88DvNbGJKx3puiduYQqijo6iJb/VTQ6cc7TfPQojtFY9iLyTCk/15po3Cu8bDG13bHEKcEV9SVItJyo6oZYHn+D6h6olXAm6sVGY4fjpy/ON+VTGx9xNGScj2IOVpqCNUtgCb/VA/ACYeSLFMx39SlnIQxYWlymp8DCm93hnTIWS8h9AXDc8hRlmkWQhoRHc/6bmxgObLAtBgOkyOFQ6z6qv2Ks0nOavyu/4oC82vtTW0wM15tn8gE9D6LawAj4jilHmNjpSI83Yj/84tHu0X0bE1Va0uXnWp0CUc8SUx+hOAzT1pTHbrQ+TYxZdf7yOUmgXnbvrcV8MWfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc+S7w1YqisVhf2Mv7Q6OcGIMkB6o/274QrYO0VtwkM=;
 b=FnE3OQpz/nj/1XSiPpzlAdOdRLB445dK9DGPLzCsCiPJFps1LjfppiC/gZVjquv7Aza0HJX27rr3PJrYAFkwwOB/dO3dWJtAMD2NMdbqfJZqE25zJOTSkOWGyOV0zptvLo4Hku9pCfyKM0BDlR6wopJQti+PkoJkfOlIahVKpDVpGxLR3LaixZMqh32SOvagQ7AyoMFJ5sx0gI/i+N4T1TWGdRU5Xj0y9Aj24y88IRmstNY5qc/8VaSuy8eOZTUBnG5j+QHGM08dRAI8AoIqQZEQKC4QUXbm7asmtHwalt7rLBtCbZaJNSiXD6vUdqN7wELlT3cI85fUyYPxunHn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yc+S7w1YqisVhf2Mv7Q6OcGIMkB6o/274QrYO0VtwkM=;
 b=bvSd2PHJ5AVv4wgWdvtz8F4bFB+zJO+Tg6wFnjob1HIXww7o0CFaOGDENER9QMo4NcZabRIdWM4Bm6bRT8OuRYNhdvjwLG7I3j8b+X4ocdmnlu8Q58TLn2sdcct8QJk73o8bkNPAQzfVJm1OzRwDJNhy4I3pqHmn1AhCLacTh7s=
Received: from MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::20)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:08:47 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::3d) by MW4P222CA0015.outlook.office365.com
 (2603:10b6:303:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 06/10] drm/amd/display: Use update plane and stream routine for DCN32x
Date:   Fri, 11 Aug 2023 16:07:04 -0500
Message-ID: <20230811210708.14512-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811210708.14512-1-mario.limonciello@amd.com>
References: <20230811210708.14512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: a00042c5-9747-417e-e944-08db9aaf275f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /e0+7o0OlzGZWwXCKB9lehkqpCH8R0kek33xokXayBopJSu4VNvga3pTyX8wFMivkGN9yMZf+EcNULFro4zDGYvWhQbpQpcmKPWIklJMPFBMoxrcK7FqOsZUrTYT5yqXwjVZyIcaIVxphshw+rsrfq7GeXViSsjg8v9Ue9aa6dEdK/DXr0MY1vdZK9/YGk0M/mHkwE2whlw22lURpFCWTtVFP0GsHULlCDnZePplPU/kWD+R0nNYcqij1iBYxBZ3psgiyphJK8q/TFCqxFNFi/oIPhgG/IhuZStBCe0qwbOf3jB05EkTq2rlWyYmtCHhfAJ806wcFcExlMj++Q95Rty6fwvEY/NMJBySTyNsPToVyksX9AbqxjRfp3lpO6Z25Xjy35nKRNwwFVuYlj6mWW+4xZHzViqMShXJAcnUX5SYXuaHTCq2Sy322IfOjQtTsBtnTi6m/4750rfKoQKDLASRt7+d/MaXTykCKcBuh2JwNlzUYX3tjscgEHb9lctWAxsd1rs2Dv4yahGY1NnszuOz5j7doHh7W0vPYw3pQdWKMwVJXyVjjNC1IBNyI5UiraOiIBv9QF2we7Eskq4t6VKpvMkcFduhbVuk+/keyxIDu5LMv7rlIOMH2i384BnJLvkAXjw9xj5TkTrvmwjSFFeUS61R9KYHpFUyIaTFOUrlBQ0xFRSticMLwT/G+hQnisDsds/9MHtQ7hUb/Oi2/ufD119Hvjo7q/+uyeTL8e8YLI/H1+n/fP754OU69Mw9cNnpAVsv6llp4Hl2uY7OUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400008)(1800799006)(451199021)(186006)(36840700001)(46966006)(40470700004)(336012)(44832011)(2906002)(82740400003)(5660300002)(40460700003)(356005)(81166007)(2616005)(426003)(83380400001)(7696005)(16526019)(47076005)(36860700001)(1076003)(26005)(41300700001)(86362001)(6666004)(8936002)(70206006)(8676002)(40480700001)(70586007)(36756003)(316002)(4326008)(478600001)(54906003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:47.2202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00042c5-9747-417e-e944-08db9aaf275f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Sub-viewport (Subvp) feature is used for changing MCLK without causing
any display artifact, requiring special treatment from the plane and
stream perspective since DC needs to read data from the cache when using
subvp. However, the function dc_commit_updates_for_stream does not
provide all the support needed by this feature which will make this
function legacy at some point. For this reason, this commit enables
dc_update_planes_and_stream for ASICs that support this feature but
preserves the old behavior for other ASICs. However,
dc_update_planes_and_stream should replace dc_commit_updates_for_stream
for all ASICs since it does most of the tasks executed by
dc_commit_updates_for_stream with other extra operations, but we need to
run tests before making this change.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dddde627807c22d6f15f4417eb395b13a1ca88f9)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8c9843009176..c9ed0346b88c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4002,6 +4002,18 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	struct dc_context *dc_ctx = dc->ctx;
 	int i, j;
 
+	/* TODO: Since change commit sequence can have a huge impact,
+	 * we decided to only enable it for DCN3x. However, as soon as
+	 * we get more confident about this change we'll need to enable
+	 * the new sequence for all ASICs.
+	 */
+	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+		dc_update_planes_and_stream(dc, srf_updates,
+					    surface_count, stream,
+					    stream_update);
+		return;
+	}
+
 	stream_status = dc_stream_get_status(stream);
 	context = dc->current_state;
 
-- 
2.34.1

