Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E8E6F4EAD
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 03:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjECBnE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 21:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECBnD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 21:43:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724FE1BEC
        for <stable@vger.kernel.org>; Tue,  2 May 2023 18:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFwA53dBCubUXH2zZ3c5X8c2wTepFcTjDTkC8IkwMuCh8H30kpEfH165VRMTwmWXeTP0BZQ+BponsNKjwu2EYxchJz1uhJSEtA7SR1kx4kOKZ7NZdsDUPJKV0V9nCTESsPwacTKenXrk2U70UK1BrctrAfyADWbYCd1hHZ7hO0wE0kU4JQKwxoPp1RODjbKZCYd7fI6mSFIXls5+sS0FeQlKHpB9A8ssZdPg5ExgvdsFxpob/59TRRmdXaYYTxPYY+QqGP0KbSvsx4zCvPVbu1wuzq1zUNAJ7o2Woy3b8Dd646ZKh3EsthTZDWq7hU8nCNZ8/qF7qQE6gN0mKHfmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0DdrMEsLV5yvTImcCAvGYSAMP3hrPrfJ83pK3M/CQ8=;
 b=jx815PWCDva9Fl3G6PJOa5548nPB88tI3QwwTBDlis/iMYq4yMmiYfsscoXWIQiEuo4g6QJcqwCPeZ8kE+9+CxORkh4SpKHGeCbCO6hTkf8PHyxo4vrXL1L80Ooy65n5Ze0N+wna15YswlY9g+4bTGIf0VADctrcrCWsrXwa/J1G48lSTyDJ5DxritEtVzS15WuUgOKRoH8YTyVAdXJrwIeqCRNoIJuCnprVoW2wP2hWf1kpvJy97iR8vyXh00QQr+CvFYh2ZG0o51xHwnrfH1hFPB3pr85jAbT+HDX5WnO9IayW5cQDebra8MnpCfX2cWMzKr5fK2W72Gd2yib4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0DdrMEsLV5yvTImcCAvGYSAMP3hrPrfJ83pK3M/CQ8=;
 b=XjnyF9CAapApHYhRVYO68doaAB9oPcgFkdW1HejiuTKd5wmtsic7lOOUI7/IiLMVS2E5xP1ylPh7J6ngoZIqSNIICc4jAKTaHi+mqDkaHhVRxEfkjfZm2WBOClkFclZYwLZu/eph0xW/jRwqFl+ClZooJ0y2v9G9oC7wfQAMfag=
Received: from DM6PR11CA0026.namprd11.prod.outlook.com (2603:10b6:5:190::39)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.30; Wed, 3 May 2023 01:42:59 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::8d) by DM6PR11CA0026.outlook.office365.com
 (2603:10b6:5:190::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Wed, 3 May 2023 01:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 01:42:59 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 20:42:55 -0500
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Nevenko Stupar <Nevenko.Stupar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 7/8] drm/amd/display: Block SubVP on displays that have pixclk > 1800Mhz
Date:   Tue, 2 May 2023 19:38:52 -0600
Message-ID: <20230503013853.2266793-8-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac7bb87-7b55-418f-5428-08db4b77b9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zNh+48b8ySQdjT2ZVgeiacU0o1rUuFeLJnMA3ChP51kJg13HFnHTPYZWm4G+dJNvYKNBTCjrhDmtutdLvhICHgLdYp9rSEfexfPK+hFVdA36G0tcJSQtaqwbXAXse/NhMaCdvWIrb6YqtuSm39mj7oZN/jUdHrgge5LP6OXZ+5ynp7yO5j2NwdhpBggqiAILkh3FXRTG/t6/tcwg7abKdYG+kXxAcvKD99UnSX89Fel2u6cLiDAJz0/LyDiOGbY2d0UC4bX4guGZzOu1c4Mptzzei/nmH9AHsOGm/BTVDYMyPkdFNtM8B8H6s92T1/xQwVtWLfPNYKZ5gV+su6IKz2J24BR3DRSQoIjcdeFdAISegmKepkt8HkyyKvXqlfcyKf5xMb0IcXnAmtMJF/gyAPqAnESez4TFOpB0JA0L6HWeo6Ni+Xshe8XUU7Qc27tKobFbDzH2IkDSd5aqCC8rdEAZ7OfyUSxNsbXw0Kku3GWZ78adRASnXJ1XtfW6bakDPOdcUK3hkNWMDasKIkEZXltkdFnAua54U5/st3MQ/EPCyqGZbEMCChTJam16p1eCX3PC+MhbuyTKq8h7THngMQArFIFcIHplaM8yr7cVGQpPi4pa28SQkxXEou7efb+CdYWFOSkaiKgVhQp1ETklut8Vwv+PseERm22SBcXhifxVxorVsMGqpwyomkuTZJz5tQCAUd9xl74cCF8RgPdEDMW9AijeCHHHv8K+qorcRU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(6666004)(54906003)(478600001)(83380400001)(2616005)(40480700001)(336012)(36860700001)(1076003)(16526019)(26005)(36756003)(426003)(356005)(81166007)(47076005)(186003)(82310400005)(82740400003)(7696005)(40460700003)(4326008)(6916009)(70206006)(44832011)(316002)(70586007)(2906002)(86362001)(8676002)(8936002)(5660300002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:42:59.1529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac7bb87-7b55-418f-5428-08db4b77b9bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Enabling SubVP on high refresh rate displays had a side effect
  of also enabling on high bandwidth displays such as 8K60
- However, these are not validated and should be blocked for
  the time being
- Block SubVP on displays that have pix rate > 1800Mhz (includes
  8K60 displays)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 04be01ae1ecf..42ccfd13a37c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -41,6 +41,7 @@
 #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
 #define DCN3_2_MIN_ACTIVE_SWITCH_MARGIN_FPO_US 100 // Only allow FPO + Vactive if active margin >= 100
 #define SUBVP_HIGH_REFRESH_LIST_LEN 3
+#define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index cd28980b2b56..f7e45d935a29 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -703,6 +703,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
+				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				pipe->stream->mall_stream_config.type == SUBVP_NONE &&
 				(refresh_rate < 120 || dcn32_allow_subvp_high_refresh_rate(dc, context, pipe)) &&
-- 
2.40.0

