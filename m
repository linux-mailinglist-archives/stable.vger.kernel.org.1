Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8641D750F6B
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGLROQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGLROP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:14:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146941BF7
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObGPASpzAjPHO0zq+15O4WDOFxMafIgHdLIth40GztJR6Sp1714otGP+y7nLe7OzXsgB8Nhr3lyi6Nza+xUcel6r5QEQ3E2kW67h/85shVTGCCTo+NSd/0SYpwrPwSralI0yr3kDkNnZ6+2KRh/fzYdpxwpwCjBYtZ5u0x+aZIZy86J9k2BMkplpN5xDZzPgXXvBuhiuvj9n6ET9d7Itqhz8ohTT18eHY6rJZqNN9t0LwUR3L2bc9xOHhHNjeN3IYkbA9uLRkgOy/kOxrEAz80p2gT42r2kY0LQWPXE2d5jpcWwBGwlqW0X1s7vRrglW9aIw36gBMuhrmPm28y4XEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfmN/Jq7imLQ3QQOvEa1cvTpgJE4FCNY/wUfTKgokzs=;
 b=VLVIWMzBuJjrNu6r2TLcdHCuB6Imr9nPDf/RWUdNNf4SBwVnKpw4POdMQWCqMClYTVQrm0yTDOgFBczm5ak6I9TcjyUqTSGxlVMwH4QjT2om5YTzYTQROzArQxLT7FfnfIXfYudb+MbF9+SLLxYywr2vHMsEdjT5SeN+/eXTpJOSJjZrbCr7MDbnkbeby7mLUnRtBg9bu+oUIVkIfIAjMLnkxjpeVjv2tzSUsNtVQllDflypYWkjaRGwaIc1BCKDBoYpi5bOSo92XpLcQDBNxZitfwZz6Oz8BF7eRX3n65mVkVfWANG77nbvrMnzV2XxbphsyyMdRy7FQc7dFtXXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfmN/Jq7imLQ3QQOvEa1cvTpgJE4FCNY/wUfTKgokzs=;
 b=UH8Vn7YTbbLLtBmqjGVo5v14ui9IayWaRGHqMvhZLNLceiIe86+Hd9vE6Q56IEWOgakzyJcZNBvhs029pGsIF9FZKXZrOKcEaen4/OMQhLywRMlcWuJLyhavXy2LYwT240KuWGjRB7P625+2rVGSVfQ+MNjyT9E+FUbRYq122sI=
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 17:14:11 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::3c) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:04 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:00 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, "Josip Pavic" <josip.pavic@amd.com>,
        Alan Liu <haoping.liu@amd.com>
Subject: [PATCH 22/33] drm/amd/display: Keep PHY active for DP displays on DCN31
Date:   Thu, 13 Jul 2023 01:11:26 +0800
Message-ID: <20230712171137.3398344-23-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9930d6-339c-4fe8-ad0f-08db82fb68aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9Tn8OJLDEsfJB2o5U3GgpC712fvGo/sVn/tOmwj15FxCdkA6CtVgzbtGy+5Dewbyg4Jd1IBOmLuQ32qJWe6ANmobtC6WAE2B6eXDxGXqJqv1uAm3zdrJ8CyPH1Nnidpx8rEGtI75swkI7MbSacVMQSOnCtD9TR1aQz9e6NBjEQ1xd6Jf+7QSILfZA1a61Vf335KmLfK+5LcV/CQ11V8XluHu2NMIsK/OIFUqTisgoUsVczIe/O6m8apuNcVVgAk68OxwEteYQCbpnC/ZDjm+YKDKwuTyuvkhc6K7mlshmJUzRK4WdQyAjYUCCrGtHjvKXINrevNEjX69Hh8mmCytO8NOWaEuGGr8xtUjoksn8pvuwDM8pgDwc66lwQDkSndhkfD7Dbd7jajgsYp5IsQqmVUlXrW+3k6oFobqeZxPcSE+UDTJl+hnhuwXY76tz/eUlUni0cyU3f+lAeuZXJj6NU7J2CRAfoYY9uqtOZg2GZ2O49E38IV6Hjv+YdJQ0ON/hwOvzXdc7hdGx82Ep1p6AJh0xwIIQkqA4E1JPsWd1zxXu0zQAi7OtBh/JM1ZO8vxpsXDNamXoXh2OjNLhtIivJHn2Ai8eyvuQAOq2KlXnoKlWdY2XhiYqvdybFxfryfadfg2wonw18TCphZx8QJYUIDvK361M0/n1KdUeyfywVOFGx3a1dE3V584ZqA6nRKYyeUmEFFi2wZhO5wCHY3pMf4PRTUqNJPFzLtTCQ+Pb/klI35+b/Lw/uYTKrV1jPwXg3MCU3ajkhrHOCRQlPGGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(6666004)(478600001)(54906003)(7696005)(26005)(47076005)(2616005)(83380400001)(426003)(86362001)(36756003)(40460700003)(40480700001)(70206006)(2906002)(82310400005)(336012)(70586007)(82740400003)(1076003)(186003)(81166007)(8936002)(356005)(5660300002)(316002)(41300700001)(6916009)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:10.7006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9930d6-339c-4fe8-ad0f-08db82fb68aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Port of a change that went into DCN314 to keep the PHY enabled
when we have a connected and active DP display.

The PHY can hang if PHY refclk is disabled inadvertently.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 7ccd96959256..3db4ef564b99 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -87,6 +87,11 @@ static int dcn31_get_active_display_cnt_wa(
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
 				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
 			tmds_present = true;
+
+		/* Checking stream / link detection ensuring that PHY is active*/
+		if (dc_is_dp_signal(stream->signal) && !stream->dpms_off)
+			display_count++;
+
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
-- 
2.34.1

