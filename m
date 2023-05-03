Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800676F4EAB
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 03:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjECBmO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 21:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECBmN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 21:42:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A421FD2
        for <stable@vger.kernel.org>; Tue,  2 May 2023 18:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDr+4Tev5kUpekqcIIkuAosc/4fjJjQrmKaYvoQpEqMLeTIi+XXOKBbBbE24zmKrgqaSTQliD9wyg8HbYXZrSO8Ef3BGqXsVjJzc7jWWHLyQHwgNa+eO3cupxQ83MfNcw7etmjCHsjEKl4j53jOBvLnqUGpe29Oomx6+1F99Ogon8E2OeDUUZo0JmizHw4AUksG+XIR5yzPg0KoBfCj1xXIzk5JHxWjNppL0s1UzX5veI4XL3WkmEboVJaGR8UfDM2k00BH7/GNWXbwA993pmYYDKepcAIA1h9uoPX0X4D+N1aFgG1MVtj/OA9seSUoV/7RFWHxnXqPUBHqEnpX5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaFj9NgVjPVT1bS9+UTLBWh61F+DOJy9EW2Ssa32bTM=;
 b=R5hKT3TowG988ZUyfKqk5QYe0rsO8LHE3lur8iVFomEXPx42j+KA74F4sINeUMzYTQkUrsYvu236gO5fB4B+Xqmb53gMn77fOi1UL1qkPYpkE1EQSQ6sKf10kA+rPGBdaLjlspkXxYCF9rcEtQpUx/3iHOZ/PllPwlTyCzb0AJAqjTZ20HpVFnrR2FZRbI9uTPDyz0qTV14+WcdeMEr4AbpKtDRBO5j6Ya0NCYIvZ+fGC7/91KsHBgFLHkY6StEqNjVxkScascH77Zs6OgRZ6rlN9sojsr6yVjadHLADkpnRH0mCOcjBmkfusGEV78B40nQfBR8H7xpwU5UcRoneUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaFj9NgVjPVT1bS9+UTLBWh61F+DOJy9EW2Ssa32bTM=;
 b=jtz9Ed274+PgXBQ2o3HNy4+4bl3MUcuY+nrw3jMNvBZ7xtb7lyAmfqbrSnt5kCjpWlfoAauOGyJytKWTX3d1DsCmDwvTESkBxrYOsWWIEINf+arwQzGobraGxNWACKXRJfv7VMVJpp6jASfIWic+DmZifD2B6yr27h4EvbFF/hY=
Received: from DM6PR11CA0035.namprd11.prod.outlook.com (2603:10b6:5:190::48)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 01:42:09 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::3b) by DM6PR11CA0035.outlook.office365.com
 (2603:10b6:5:190::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Wed, 3 May 2023 01:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Wed, 3 May 2023 01:42:08 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 20:42:05 -0500
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
        Nevenko Stupar <Nevenko.Stupar@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 6/8] drm/amd/display: Block SubVP high refresh when VRR active fixed
Date:   Tue, 2 May 2023 19:38:51 -0600
Message-ID: <20230503013853.2266793-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503013853.2266793-1-alex.hung@amd.com>
References: <20230503013853.2266793-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 725fe866-5438-49a8-50ea-08db4b779bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CC3FQSvmcXnsHTr0SVQZR5LCkXwXZoswBVlqchUJXOamsgdWkYE/qLvgADclMwn32a+4Fry+nLJfHtaL1f6DpupU1Xt7tizlZemisehK9q9jqNxt36NYxPHvmilS+AzmpiVLucykIuQVV0fhbtIsUwxxWDsINZgwYRwQ3SyudEbWwQuOBhraAkxWmoaoLHfCIDxbBvxLuzmgHBL1ny3ANUgGyaHnceCdUDqOufpbQiwGnC+kt7PCmzZIZWNYadeMcRyZ3IcOayAVIwrnMP+EutgPG/WrwpIdPn1QBzaJi1XeMWRXIuf1gDF+oMQAqAvXVhT+H+p3DJ6UOVo6ItT/xTrW2fmeTmpOpnR0a5VMG837Jb/LclWaQk8gMZFtkf7TRsbJSsENZJOwoEXJSQ+zJF+bIhErVbkS8HiI+G40kKRZ3iOCzBTASvLyiaR9NNdEW5Zc2iJFW0ASduCfEtQLSWf7crxeY7mO1QRUmcYjvN0n7LTPgQ3V2i+Hu0Jh704rTfUr4jaed3ZYktUpaQopYECipty/bAi4+GxUE8rwUeOF9dzHDhVOSg1iAVRoKL01MnWpZ0GBCiwerGDLIz6gy36gJU/2H6GMC9nUWbY85UMDJdDNDBUOvCAYM8zZL1GpPmpk8c+zUyQ7MDhwhQorCDZXP7Ku7vNGj+q1UZT1ZoZBLBu+gQjI6cojcFrLIGzJjx1HJgF4obXh/kWNRhUNsbOtBJwEfMyVeaQG6Kle7Mg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(54906003)(2616005)(47076005)(83380400001)(478600001)(36860700001)(40480700001)(7696005)(6666004)(1076003)(26005)(70206006)(316002)(6916009)(356005)(4326008)(82740400003)(70586007)(186003)(336012)(426003)(16526019)(41300700001)(81166007)(8676002)(5660300002)(44832011)(8936002)(40460700003)(2906002)(86362001)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:42:08.8736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725fe866-5438-49a8-50ea-08db4b779bc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- SubVP high refresh is blocked when VRR is active variable, but
  we should also block it for when VRR is active fixed (video use
  case)

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 46fd7b68857c..cd28980b2b56 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2825,7 +2825,7 @@ bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context
 	uint32_t i;
 
 	if (!dc->debug.disable_subvp_high_refresh && pipe->stream &&
-			pipe->plane_state && !pipe->stream->vrr_active_variable) {
+			pipe->plane_state && !(pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed)) {
 		refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
 						pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
 						/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
-- 
2.40.0

