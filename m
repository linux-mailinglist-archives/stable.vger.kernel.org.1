Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27585750F41
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjGLRGf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGLRGe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:06:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216819A7
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv4SAEzC0SWll4/xLS6an8AV/IwRCyXTBbq1Akd69oWEwgOfBuvFP5OF3/WByHEnqFcG5DZxLvoilwuwVuK3h7uyv1dryyCOht+WbLRiSwDxPifUYHArFgx7MCLQCpBZUdE+0NgmVwXXKCiP4+UYwjH1Ujwx8kgNPA723PsWbkMjM3VpjOf6jhqe2FsszV7MDCbAH9dhh20YflZ5gAzw1TvWsbGStXZDFCmr75sPza2qeMzi0G3d81REpx5vpIxZRbRuqXz3m/7wwlpsE69fifFNkk4ZkP8HZXk5ax+fS0IrVfyHSwup1uI6j0Auof8WiuC84acde+gyOvD8myDwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfmN/Jq7imLQ3QQOvEa1cvTpgJE4FCNY/wUfTKgokzs=;
 b=SL9cFnB9fkkCA/XDz+yBeAH/IaAoFngzwIRnFA9RCrmfGu5AZasxuDz8coxAdL0RxBiUSz5lfTozddmwZxcx8c6QGt3+G2Ppt3n8aYffuile+D0ia81Sc4WBN9KAFE3WmDBa8SxKxQ4vJMe2NQhqgr3DDjT/eIyQnqQQpcM4izQGytJkwoPQWTSpieBlC5AyIOBZdOBaLSwyTGQZ3OE5mEViAMqtfvk1HM1mTwWvVZeBcllrzYB9G5N5bdJp+s6lIxmDj05Uv4ZlwloJugJj0vQqZxjGwqydXOAGM8rTVlWzXV3ouvXF05B46zVxjZrw4GfCF71vjH7edTCWBJkOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfmN/Jq7imLQ3QQOvEa1cvTpgJE4FCNY/wUfTKgokzs=;
 b=QvBq1bfHmF3P1ybtZ6GFnLVszfmy4FAlqbhfuUtphin+r1CX3exez9Fjm3anRqsv0i7KVjv8UW+gOBVXIVGE/WaXy889FX+61E1IO2FhWQRhTG7hKlc4J2zyljurTG8YiXIqrts20TDc8HSZoJcCpdYHCy6GMo+ecdBG7Ohi4I8=
Received: from MW4PR04CA0153.namprd04.prod.outlook.com (2603:10b6:303:85::8)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 17:06:30 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e7) by MW4PR04CA0153.outlook.office365.com
 (2603:10b6:303:85::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:06:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:06:26 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:06:24 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <haoping.liu@amd.com>
CC:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Josip Pavic <josip.pavic@amd.com>
Subject: [PATCH 22/33] drm/amd/display: Keep PHY active for DP displays on DCN31
Date:   Thu, 13 Jul 2023 01:05:25 +0800
Message-ID: <20230712170536.3398144-23-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
References: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 0530ea19-e4ed-4be0-41d9-08db82fa564e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kzo9ED1ys19nISMv0zO94EtKQkb5EFKT+01FAS8C629zdWfM7dsX/SQVtmVaEzXHXV8BfhJY6ErQ8wCSBvPksAdEki+uf+OWrb4RNjH6fnrguhNeQudPOHQioSFUDAvnaekY9C5npWJ8MO60CK1M2NGOw2aoc/1xqV4KomwDWnMJoVS4OdZtV5ngbh2eyl+uRxxRsmY1i7DC5L6aZYfW8w/zFnNJIw7TRRBpjCrpVhGMWwHwWf+hi/aLPQ2djnoq8DGrLgrIY3/fF2GcqgwclOwv0OzfLXzAhLSjFaesbtWbfVDt47tKQeS13Y6xiwl/IwsGF7HLEzc6++nJcev1LBWhwaT6FqJvr4iW6YBMYxipyYg6e5VQkoEHD8M+onmvWmYDCWmZ57tPH8y/1GkI7dY9yhYLW9XdHIoyVrwZs2SrKzyEig/6u1/BJtszIozI7S4zlhfH0q9hXfCooZWvRZyZhTWT/BUbFfSkHelOXqt4gMSKa8fSjiiQfCzRsDU7ihDo2kL+P3de60VELywWjOt3KYLyVe7fQeOJBGN+zT1vfKNh18f8EcZwXPMxfxqhtB8Z3++rSg5aawAPhWcI5Zvh6eL4mZw6V5DJilT3XZfmNO6iX+4v/cQYopnpAi1WnsD7WNmwtWoe/vAx8VucKkxNDLYzUDKRisUV0Z+80Lay0R7Ajk5zPsY/f1uIh8547KquSSg8iF8E98BDHewuznYOIHIzZWeZTWlxBsbMn2GYbWiPjPVjJVMrNwzWwE9pab1REhgtLVnPUJweoEtcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(54906003)(47076005)(83380400001)(41300700001)(36860700001)(426003)(2616005)(40460700003)(6200100001)(2906002)(36756003)(336012)(186003)(356005)(81166007)(5660300002)(82740400003)(6862004)(26005)(4326008)(8936002)(8676002)(1076003)(40480700001)(316002)(37006003)(70206006)(70586007)(82310400005)(478600001)(86362001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:06:30.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0530ea19-e4ed-4be0-41d9-08db82fa564e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

