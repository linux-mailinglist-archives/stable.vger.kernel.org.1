Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0E771838
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjHGCS3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHGCS2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:18:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1DA1703
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgDKPG7D6UPw36qZt5FIi4TgWfMwjJIG/UaQg12YhybKFDVe5j6wlBfAB3wKfQVE6wHR9ghsIAU8eu643rSVLAlQdYRVt++K3b82DLl0qiOCxcCl0LYriXtUHC/Hjaol4Lvc1C/DvxdTgkqoaWarlTgbUWwWDroIXY0G+GBpt873rBiH5ezOb5sYt4TvzlBq6kuKrrwaLLkbwnV4eoARS08+6ceKFOjj62YcrnZjOeD7yOpwMiD3+8X/fbkbp/xcmyrnClNFxJ+YChTrI/yb6bgJ6anaFW6FwtQXc8giBN3sDtOZfkJnJZaBiGgIFFCC9EAs2+04XuwBsJEbKAf9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET4iwjxOKtl8PZ/DYLTyRAkRX1DOF6+k31wjGKEMuKU=;
 b=AglfX25rgbg2eYRsr1S8iuUG40XVoNbMraCdcl9/s55ga3IfDw+W5VolgK08K1Vrrn2jC7C8Ca6WvVHa/SyWQk5tHGCjlBrJq896myfL60FYdc6HYDwRMiax+ZfLx4AScEvH814ujQZQbBMygiWVyUnF7n24156am3ZfMOH1KsWlXGLoveTr6wcVQZXl2OQN9wWwsXyV+jzS29ZLxO4TiuXQheaHej/UmnD/yn+n5FfuSlkq0L9kmWM1JRT/vLnY86kDZvtHfENA8wyFe0dWZNFrlbXHvgiDbtixExRK9VUVlNwFS1N7HTuheYz2581tB5psFV6sTHLfPNLbIGkK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET4iwjxOKtl8PZ/DYLTyRAkRX1DOF6+k31wjGKEMuKU=;
 b=0Z3RZqc8vMmt7nYtQEOrgqk7SgsUlCGRRNBBpz/tfdkHe8t6nbV9YULSUVjMfRS1q5Efcj/AXzQSVM9M+FoPc/m9FBGISH5Vw2zPUoe6mvG2cQJDAN4bc6dagGJJ4jq9SZD1X9qxsJNbCS3qxFmaUh/0v93wvLY7vSbO3cn3/LY=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 02:18:23 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::2b) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 02:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Mon, 7 Aug 2023 02:18:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:18:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:18:16 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:18:15 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>
Subject: [PATCH 6.1.y] Revert "drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2"
Date:   Mon, 7 Aug 2023 10:18:12 +0800
Message-ID: <20230807021812.2797828-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 512d7192-9fc2-4215-6767-08db96ec9389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yx3ATKlnFyzKrNsWO/Ymawxb1gFkXZk9wefB2ahghuwosEXfcOF+2FpdrJamFlIrUywMe5HQ2fIcJWTzFmWViUG5BPtQktmrBNUZ5VhmA/od2EUhuYr3ERpQAV7VCzXkMCCj8k6TCfU8PUHYqbm4snH3ymG1lqBWSgr6j6HPCv9Pqcx8vyksoKCmBTWOaPxjpU84zix5Q37YjE1vM3w6cFruGPsEX7iJ0Fayne8DIssWQ4HhKKfb9bzNoI3s3p+HYup/Z7kIiKPN2dbT8t/EyuqDzas1tG7w+TOH7KgwPHEKunHjoO3mZxoXqiMQi5xIppF3XtIGB4NP/cC2IcU68hqH8qmRaIJju36Led7zZzyR72DRx2f3PLHXllyuu4rTXBJBIZ7ZRw2ktMnjdPc345/3hcNLET/QC1fAVyAS8cjv6W6tNy4VzJwbkQDS6GO8d3LrJfpwYB+bI/Qnyg0hF1gWxRnt8j2t53rUWCxasjakbTzsDIxA0Q20SOCcWfcJpmCbJWFizkCGqpu5Bpb3Achx5ynl1cxlD1VfZMzDxbCynpyFIZeirsM4fW75Cq2kr+YIR2BfbD4tEPE9zZmS43wxYWftjcEDvl4AO6wtgNOt8Hf5UjH/QWAK7rBslc9g3g0I3OezQhvfeZuMwrsX3l2IUgU4UyaXEtJ0zDCujPZ8Ud8dENfFwhqR1VMEDGoPZwTNFx9BngYYrXzR2QvVa0jxUBX1kt7we9yGUHQ6pNgujOU2JIhfEykF19czE2pIyG632kEVIEYcd+siMEFJNiCL4V85BNHa6B3PzzNWnro=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(186006)(1800799003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(426003)(47076005)(36860700001)(2616005)(40460700003)(40480700001)(2906002)(6916009)(4326008)(5660300002)(8936002)(316002)(4744005)(8676002)(336012)(70586007)(70206006)(86362001)(478600001)(81166007)(82740400003)(6666004)(7696005)(356005)(41300700001)(1076003)(36756003)(26005)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:18:23.3042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 512d7192-9fc2-4215-6767-08db96ec9389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This reverts commit a2ef3163c3604788abdc060cab74c95ed44fec1a.
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index f5fa7abd97fc..2f4afe40f3e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1165,6 +1165,10 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
+	// For phantom pipes, use the same programming as the main pipes
+	if (pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
+	}
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
-- 
2.34.1

