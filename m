Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337207E5E46
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjKHTKX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKHTKX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:10:23 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7842210A
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS+gHYuP89m7wD5yC0zWkmgDo0QGiZ0maAwqwJbsF9dVqTOmPU4fC3i2t7tc8XB3pNpxcRA/xHitSAwfkce0g+GBxmjD1wo5xCpYzcb++0ef+SfW5E87CEHBBo6jrZtc5IJMifIgDllBDMhbMRk3kXm9M2YaAB2wG2sDqNRWJ9qpswXsGEWbUKfQ7wNfo8e8cniej4UF4kKTORY0n6SwxFEhKpHLXGrz/GfN0y2wOSD7fbFhdeaRS7JPxtlbp/mZrfWNE0FUlcAzX8fkw71xwIdLJj47BkUkb/3dIz22aUWJqiVaX4UkeIATEGclxwhxjc/lFK3hQyfg5OQ9G5VdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gISrwmUr8eT0M6ZgbKX0os0mt7wTSvm1rTTTW+e+wuc=;
 b=SPsCsjGIv5hE0lnxvAKqZknBTvaJRYYr/nCTPCwqvDlamoVNu4LLSfYeWl0Emu4rH4UPv2PB8ELYFiHCc/oh62NNe9zNxW6OhABz4CO/jLDJTQW85sh4Qo14nPit8EdwYlfjVqAtMq3O+MS+DqF6P9uW8VeEq/Sh2SKqeqQ8xuuU0kvDTqgRyJ6nJPRpZLuCR9YMIiamzRzm7HJLGhdIYNe1hSp4uxyzuo1kJF9NTSPCx+QYi1OoYkbeiEkXH9XY6iebQOb8hU8av6zRfOrJrUP1i8KzmX+5w65kfgax9uNVJCtADNiQzQWnyNMdG2kMi+xoDRtvYq4t/QnWFephug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gISrwmUr8eT0M6ZgbKX0os0mt7wTSvm1rTTTW+e+wuc=;
 b=tBYlsEBmnJHM0HQPc9itlxDXQjtPhaXaw5nUB4lJoZOo4zf5stPTgQfNqHr5t91aAijtt7qDzNk3bIUTekFqMiJI7sdxyBmFDKk02XX4MxgdWs2ZVOTUhAqalfNe7Llk+Oq3S/yWcsbwX3gmdshnnmztxwXEv0dtA0KemG+o8pQ=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:10:17 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::2e) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:10:17 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:10:13 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        Nicholas Susanto <nicholas.susanto@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Hung <alex.hung@amd.com>
Subject: [PATCH 16/20] drm/amd/display: Fix encoder disable logic
Date:   Wed, 8 Nov 2023 11:44:31 -0700
Message-ID: <20231108185501.45359-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f6e293-7973-46d8-08f7-08dbe08e5836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1c1nCZvlSq1XwvK30LIHwYBfvVHFZHgPv+Ock7iyHlsweZwQA80NKvl3lCFFZMkVdUToCmmm/FMwOGM398KkmHwEnEqd1RG9g3TkoaEFRBqKHXFN2lPveVKswGIcZkO1jIH3TOTd7DS++OsitDGfbLKSG+2DQBH+fdNr54jYF8uaUPW9hVnWEsJo6MUuW0QkJgb06aDs4k0kO/+B4iczFyOCaWHss1sGbpWuvEG+M0KafUaVAO3pGV1zMDVbjHtRQN2Vd0lxKP0o+NvIBHU3APaB0NdxMM64pB9kIL4NeOQATUtWK2zjByMvACqyiIUiIKJ2C1IGI4wqAyhy03O9YTghENwyoe1J9gyO1+rncKGaWmVhv7qpTnUgKAR9iekCve5n7GDkY/knBWpAQcKOXn6y5pPWg24EQwrLCSKEej+uYH8nxQb/7RhUF0ZMhrfoD5GnQPcsQ2+So/iY3NGg6fqpmQBr6IisJ8RsG4Xf1+lAlC/UmZS/Ve9C/KIbQWMX+k/H/M3lneDxLbLjm51yj+1G0fB68w4WIdYMakKM/7HNHBS1zdKl90sL2yyi2R+EZcyEOyJiGX+CN0eSgNQfBZ+NQLEDJBJkdT017kR/eztcFbU6lsGJnV7RvX4JxEDOQql3DHqxz5632hjDMY96GWYnpXSx17vO3dqjmCA97njWmmBn/U0m47jNMf1wXg1uc9Ucy7B3Kdjcwya2UHVf5jJQCHXIBhrNw1J1EDNcoSBCA8cvDazj9f1FDCbRUVaPVxOHTmk5Mps2776hpmkcLkMZoIl6LxFLeM09Dm1CY+HpL0ydTXVeVrTwZLT2iDU
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(40480700001)(16526019)(6666004)(7696005)(426003)(336012)(26005)(41300700001)(47076005)(2616005)(1076003)(36860700001)(81166007)(356005)(36756003)(82740400003)(86362001)(44832011)(70586007)(5660300002)(8676002)(4326008)(8936002)(478600001)(6916009)(83380400001)(70206006)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:10:17.2190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f6e293-7973-46d8-08f7-08dbe08e5836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicholas Susanto <nicholas.susanto@amd.com>

[WHY]
DENTIST hangs when OTG is off and encoder is on. We were not
disabling the encoder properly when switching from extended mode to
external monitor only.

[HOW]
Disable the encoder using an existing enable/disable fifo helper instead
of enc35_stream_encoder_enable.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 .../amd/display/dc/dcn35/dcn35_dio_stream_encoder.c    | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
index 001f9eb66920..62a8f0b56006 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
@@ -261,12 +261,6 @@ static void enc35_stream_encoder_enable(
 			/* invalid mode ! */
 			ASSERT_CRITICAL(false);
 		}
-
-		REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 1);
-		REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 1);
-	} else {
-		REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 0);
-		REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 0);
 	}
 }
 
@@ -436,6 +430,8 @@ static void enc35_disable_fifo(struct stream_encoder *enc)
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 0);
+	REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 0);
+	REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 0);
 }
 
 static void enc35_enable_fifo(struct stream_encoder *enc)
@@ -443,6 +439,8 @@ static void enc35_enable_fifo(struct stream_encoder *enc)
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
+	REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 1);
+	REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 1);
 
 	enc35_reset_fifo(enc, true);
 	enc35_reset_fifo(enc, false);
-- 
2.42.0

