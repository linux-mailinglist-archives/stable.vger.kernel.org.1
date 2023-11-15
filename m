Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38207ECEDC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjKOTo4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjKOToz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308F312C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZmkUk7pN0csRuwKEcI5tgw1+5cVa9Lsw5vXxMRXDD2BjE6bSHjAh8TLfFS/Tb54A7vD/Zbb5EtCL6gNK9q7a8voGLO8vz0AKr+8dNikhGDEsfIBrNAlYb4e0RGnbBV7NiS2RXauei6ol0wb8yICspf5WHs6HrYJIvssGW3NAs4USrNDovpCLMmZQR644EpXvzyuwjVgA1QqaYZD/KyWrrTsUs98uVhNgj84hU26AAJTYDuHPhp4P4HTviBfTnfljw/xw3tQsvAgSe92N7wyru479Ed8MBJ1nWX5TZLncS4qPbBAT0puhvOgSONmPkhA2pGaSc/1ACG3IP6zoOp5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxwgCdC/2vkq5IczQrG8wtZkmlGLzAU8PsDjDi6yidM=;
 b=ZGbTPHUqNbwXoWLF+BED/rsMTMjM6bp4kNnywtn5onbR13E7B5Nnv2+9RmyHZZ8jFwAKRgjcmgVvOPeI1+E7Oq+WllnWmHoPHPJd1rrj7/bO72Tyduhk5LKq7yx/HAWl1yeXGZEnn23waFucFYRPY8Y9cEJp1PQLQvkD4v0SPxRX71ZSNpV90eWlv4FTgrhVCW9jXlFQOw2xpLpantvVaQLx7XHDRidSahp/motYJxhQDy2f7S9TT4Caaj2zGMKGgfwLVqEcnTHGRjdK8V6AVS5vJAe3cX5L6xrd5PEDx3/HrVSdxZMQAD4rDXuF8xaYUDpNfbyz6TPCyho7eDEl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxwgCdC/2vkq5IczQrG8wtZkmlGLzAU8PsDjDi6yidM=;
 b=0auiG9p4XBki6OT9I9Tqdjjudw1rV9ez/piGzMKtJ6dPj48+kzJCiVJlRA5KuBg22EnXbP+YfSczq2S1G/iozuKQ3MFcjDNj9749VgCUDaLpd0+Y8oqn1W2MhqfzbEhPyQd2HI5TtcjH2lX/pHfw6QaQwdhNLWQbCRLl20HnVfM=
Received: from BL1PR13CA0261.namprd13.prod.outlook.com (2603:10b6:208:2ba::26)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 19:44:48 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::3d) by BL1PR13CA0261.outlook.office365.com
 (2603:10b6:208:2ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:47 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:46 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Sung Joon Kim" <sungkim@amd.com>, <stable@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 33/35] drm/amd/display: Fix black screen on video playback with embedded panel
Date:   Wed, 15 Nov 2023 14:40:46 -0500
Message-ID: <20231115194332.39469-34-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: adc87905-92c8-4916-e465-08dbe6135354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgblIbmtj0bR+4Y25yiFLsQT/lliFmvxhB3692K3NZDZP2Beaha2UUVC28oedbl0G6ksDiTxfq1Mc6buL+LI80HmOrYqfOQevWzBLW+ODrrtzuipkUkSG7B9coIyqdXeepBteYMijA+Ae+c2LrfQa79EkoSm8QdeDVMSJc3F4QjklU3z95TY7dC/F8faX7dRtGsVAFGfQYdpYQnfmEX98R8IMevh/xggDJwJniGb0nhIEhsUnImv5WSwJfFp/5ABPwoY7RzVwpHCdbt5kWaroC4ktObe4AiWsKlcffukDt03quag2rdEogeMFA6vdCqm9grh6814OmeVnK/5dFVgdYpxppKXTFnPyzYk5MISGSP7h8deJEk31v4JHJDODCco/rTyg4e9SeDW9TmY/T4a+kPnJsBtlKo6B98to8d1YNevScsNqkTIVw2e5yR+USXiBcl8X7iAA3CdpRjXi5odeF7yzIqaW5iNrzOdR9jldTD/qEzaszkfWYtmtdadENzP09poO4WwwRCB4lrOtnyf6zTB2VPLXUVHC3XdmPo5qBYP4q8NhkiHJvw3GTJKp9NoRZvoTjo9Xnqq5npUL9hlZkuIJhVQ1J9FR/YMmcj03gPPayiY3kDz8qtmOVi8vl5r3G//TPUusfs562EMB2aGoTiDlC+v6cE2KBcxyRQpk1yyVetgi8Ya7tir1sQtIDh7nfZgnX2VQ5w+dhv8C6neHoyFar85wRZDx7owaUE0in519Qb3fIqIZoWaqLItgdPJLoc7rRISNR4lnL6E6kXcj2P+DDiemWqwru5yc3GNUzDV6ciz1OknHfT6yDma/Qai
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(356005)(40480700001)(81166007)(83380400001)(36860700001)(54906003)(8676002)(4326008)(70206006)(8936002)(70586007)(426003)(336012)(36756003)(41300700001)(47076005)(1076003)(16526019)(26005)(2616005)(478600001)(2906002)(40460700003)(44832011)(82740400003)(6916009)(316002)(86362001)(5660300002)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:47.9427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc87905-92c8-4916-e465-08dbe6135354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sung Joon Kim <sungkim@amd.com>

[why]
We have dynamic power control in driver but
should be ignored when power is forced on.

[how]
Bypass any power control when it's forced on.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |  1 -
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c   | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 19f8d83698be..63a0b885b6f0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1132,7 +1132,6 @@ void dcn35_clk_mgr_construct(
 			ctx->dc->debug.disable_dpp_power_gate = false;
 			ctx->dc->debug.disable_hubp_power_gate = false;
 			ctx->dc->debug.disable_dsc_power_gate = false;
-			ctx->dc->debug.disable_hpo_power_gate = false;
 		} else {
 			/*let's reset the config control flag*/
 			ctx->dc->config.disable_ips = DMUB_IPS_DISABLE_ALL; /*pmfw not support it, disable it all*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
index 0f60c40e1fc5..53bd0ae4bab5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -261,6 +261,7 @@ void pg_cntl35_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
+	uint32_t power_forceon;
 	bool block_enabled;
 
 	if (pg_cntl->ctx->dc->debug.ignore_pg ||
@@ -277,6 +278,10 @@ void pg_cntl35_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 			return;
 	}
 
+	REG_GET(DOMAIN25_PG_CONFIG, DOMAIN_POWER_FORCEON, &power_forceon);
+	if (power_forceon)
+		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
@@ -304,6 +309,7 @@ void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
+	uint32_t power_forceon;
 	bool block_enabled;
 
 	if (pg_cntl->ctx->dc->debug.ignore_pg ||
@@ -319,6 +325,10 @@ void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 			return;
 	}
 
+	REG_GET(DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, &power_forceon);
+	if (power_forceon)
+		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
-- 
2.42.0

