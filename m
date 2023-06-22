Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5F73ABEE
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjFVV6T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 17:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjFVV6S (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 17:58:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618AB1739
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 14:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaa5sKqQ405JJkAGcSVIOAP87lCYV8u/GWqf+bLOGqrkIyPmd+iHHNkoqYJVU63Hm8hX/szh4NGPSafIJaKHzGiYDz/tS6FuPIJUnkZAGHVq1ZjqSw5aE/kVQNkqIaCeYnGTpqbReIboVcDBbJN4KVmC4fdc2eOhekf4zS7APsfTdnKsUtHPtap+JCH782dZo5/RuN8v3yBgAwWbvqUWUXb1gymDYhmE4CN/T4VP4wbONAbazxzGljYPiFmo2gTHf9bDEcq2QzR8v7Fawug93ZdDRCaSa4i5Cag/wVsumcYTwHxBi5TShXo3668vB+6GPD8RPZzImMoN8DQZeLWrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbDrsnF4ADTdh04NGI+QGjNQASSCWIQv4kIMvBXehJ8=;
 b=DSrV12hL5q3yNE626ci8G1AO+ece9xgIAA2LwL3h2yFYw1sg1YZdYe2KssfDDPMNfbzqFrz6Fte/NT3R/sW7dl92awWDfBcIkTFMHYwFgveCYtN5aGMZL3pyV1cekuVi/idT//ARlfd15pOwfC0GHO0CV8BqM0mVNB+9ESEwGF1yUC+v/wF698eyC8WDbiXSyVLK/SoWCDaN3uBONto1iGM9F8kJBhiHcwmsfppYS3LBFNrtoiVETJwDT8JzjeWyA62gtKaNearA2XDRx7FyzRbKBz6f4mYCluXXEMj6a+hc1Pd7EVYusHyzVyaaRa53zP5Rnkqynf7kIeSORN/Yug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbDrsnF4ADTdh04NGI+QGjNQASSCWIQv4kIMvBXehJ8=;
 b=HgnWYt8e+2Of5NBkdZ7tKBAF4x/74BeaTGiLJ3/2ic3ntC6DJ3fZ34i9VLMGxLrVD8lNBBR9ggL3vGewLHoBkYl/Luf0r1LagH1pDcNVCQusYpaOoCvzAyYm8WJZHwwgLW1sy06zkVaQrduDAXkmRv5m7VH2wtvSOhSbcpMvEqE=
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 21:58:14 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::98) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:58:13 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:11 -0500
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Austin Zheng <austin.zheng@amd.com>,
        <stable@vger.kernel.org>, Alvin Lee <alvin.lee2@amd.com>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 06/11] drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2
Date:   Thu, 22 Jun 2023 15:57:30 -0600
Message-ID: <20230622215735.2026220-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: eedace5c-ea6e-4e53-3011-08db736bc6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSOmhpwsIBoNep22WQxTEOj5k/iPQC7IMCzS3el+ic8/MjZNTGYRfhY/svHR10yZz39FkiO4DncxYxDc0Q+SzZweKpVbrzkeSxhZOHuSQyKecsIB4a12nwqKCXx/9CZm0hyKCFK+ib00+61LCOmEH/f41+6RS20TH8dYkS3h0eoxpXeRLha3su4TJE4mD8dpC/69JOMuyWLDelP/ICylRuSV98TUgy/caE+QWn68MFmj/goJW4CjSI5tDoi2mohL5GJ/stSwq0GRDetGpncwSGUxISd951o9ilGEObyZFYLy7pqkMhDscptVEDxP0ipnk+XLPMh3Fz6NE24+8m2KYNw5f0y2cbvqo4kq62i3tXpY8oowwMl5mpzDVJckIdEHnonMvrW4smOtyHp9CAMxnbtIcZZ8utocibkOlmNN3o9dRj8avExGak2z8Uqi9Pc9BP9wl9l6TDLd+VNMEzi7uqu3dYW9F5nCfbD7dX+b90xMXPS0mAAeK0ctZjCdb7GG65+c42TXmmLINQpftptu2YDA6/zpF7tU6uoU2S1ygJGd8YEvPzn7tpZ3aKVgMCOz0BdFGs0Vn7pl+UGdKP2+dzPym3neIF/nKC+CPCMN2pjA4B9mUZu8wGqW5F99Ki6rV+NIrUtYBfmJjZZuR6+axibykgUbWY7gkim/eBHb9t6HzGmH72Q7x404KJoDsp3MrRtJ7apLeBz9ijoqNqj7Xr72jHHKqitLg3EpRMfolYJsZhfCYYpOzZpkFNzTG2N0jg+7gI3ny6FmgGVF0yYJQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(2616005)(86362001)(40480700001)(478600001)(16526019)(186003)(6666004)(70206006)(47076005)(316002)(83380400001)(41300700001)(70586007)(26005)(82310400005)(4326008)(336012)(1076003)(426003)(6916009)(8936002)(5660300002)(36756003)(8676002)(36860700001)(40460700003)(2906002)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:13.8429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eedace5c-ea6e-4e53-3011-08db736bc6eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Austin Zheng <austin.zheng@amd.com>

[Why]
K1 and K2 not being setting properly when subVP is active.

[How]
Have phantom pipes use the same programing as the main pipes without
checking the paired stream

Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 526e89ef9cdc..d52d5feeb311 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1147,10 +1147,6 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
-	// For phantom pipes, use the same programming as the main pipes
-	if (pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
-	}
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
-- 
2.39.2

