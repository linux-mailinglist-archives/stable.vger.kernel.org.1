Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838E27E5E27
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjKHTG3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHTG2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:06:28 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53E119
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:06:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV8scetUumEZk3X/DGPTl+7YbnX2Mq7/snzPH3DYP2ZEh7VQyqhF8JJCmlBbm+RkHnroUAzRZVDN2U9yGA06YzxAJG/ha3jFSUMtK6p/c803k1BsFkeQwMFlMAWpbFajMvRKnDkdMViS/Dn0mvWl8otsLyimsI3VZQDSh5whw1gn8WPx7dODEH4i195zZonGQZ1eROKOSfljW5VCAW9fgQam2AdIEyUAohOeEEWzh1upi7Ck0KuIjAXaKH8WOtgv/r/VHosi7hsFF9I9qtB13WJ6YN8dw44ysYJ8LjoPUXl3FsxzwnamrZTi2SYetGJ4d5Hp3WwRWkIbR8PHVRPzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6JFIAnNcLC/fLzAkIc2H4S0kHQp2KocsL+t129heRI=;
 b=FI3sEqG7bxkUED5eW/NRGbDKvDt4KHrhP97DxRv9QsosOi57g1XiuB6o+gcXjVJJocU0bUiMgxy9fdGkYeh3lujrJQKphpwd7L8sHW9S04CGOaNsy9a1+P793G3pR1si3psZpiwplUaMOe+Ty1CqNRY5/CSLqS21jAWSDQ6XVKgLq4slS3ZTn/prIHAY5siCzUnuz/WPpD5UsoAspCYbqDSULBLAdXFzUePw+LCaiHIzRv8spjAbEXv1oQlvPo9opiwPxjZGFu2RhHkVSqQkj30VavmoP3aXBWB7FErLUigL9obxhwcJddA2u15D3ld4I/FvLkJwtpawzbnPzhXrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6JFIAnNcLC/fLzAkIc2H4S0kHQp2KocsL+t129heRI=;
 b=JXeTOZEi1z4HnV7Lw+kwTZj2aeQd6EQCx1VymxWNECAAzHiLzEsynP22AXHw91unnnEro/KE42sJDIeadyEGYOMAon0E+r4ObGmK38QrzOoF4F11x1KH7Imf3fFe9/SJkWGIb6y7dxRS24KDp41a+PrFljPxIyRBY2jGfwfRi/8=
Received: from CH0P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::31)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 19:06:22 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::7b) by CH0P223CA0007.outlook.office365.com
 (2603:10b6:610:116::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:06:22 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:05:42 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Paul Hsieh" <paul.hsieh@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, "Anthony Koo" <anthony.koo@amd.com>,
        Alex Hung <alex.hung@amd.com>
Subject: [PATCH 08/20] drm/amd/display: Clear dpcd_sink_ext_caps if not set
Date:   Wed, 8 Nov 2023 11:44:23 -0700
Message-ID: <20231108185501.45359-9-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 387cb9ec-2621-4541-bd45-08dbe08dcc64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jt/OOTUpFbbcJZBtyhWU4zX8xmXhpJLfa+T91G7ezmBk+VMJfo0SW4nZ8g43cvCtSOVDBqbN9ca64el84s1mP5OQRfJqL1KuLjB7jn+GjRF7EAPHaRxd7Ro/V9FN2rHOKjKnrBT9drfiCH2fWHQjwQnvTxipT0H75TNReJ4hyuDom7ywKmOsGYBPpXaOYFpMbyI9KbXrrQNMg8QDwATJDxi264pzHKwYldaDlwSz4Y6ap2bbiI73ss+5gO0+lGSyG+Z8Ts0q+CFPz5JI8ozNwyVHG3AFODAmBqnPufnX0TZqeuwH9wScMscQWq3ldqakZz056oyy8YcKkhfV7JdLtPXJc9+Yz96nYV6aqZACSf+gENRW26LYavjALapQ7zrBz5/0E7EljRzdLrdQ9jotNnc66IkXYP5+udjwNaI2rClpnnpBr2Re6rlmcUDUZPpjMm9f0CtbWWI6syDF/RERgGg7kgkwcxDQ6lSJRCU7wXVAN5DXYdxgzrzVr8cKeUgv35uWrwQWafyjlYE5RZ/ghSU0Vf8lqKuuzIFG1g894tXVW+4MsxK0KEgNrgTrIKFsQN85Dou26jeYfadn62OyPxTcuNI3wpomoLbmXXOnIR3ZDR5ggziDEe2tJpbaAdBDcPMTnMMAiaV8p+urxRxS5lh8Dzd4RZJyNf65sonfb38hRkyrU2nivP68BjZagxBoOYTwkfAuHul715oPqy3aJqbMft2MmTX3oxHy+ATn9go5RbDvorqeLOpGB8Bt2s50Ino6eNTw9IismMiVzJNGKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(41300700001)(44832011)(81166007)(356005)(8676002)(4326008)(82740400003)(8936002)(47076005)(1076003)(83380400001)(316002)(336012)(426003)(5660300002)(54906003)(478600001)(70586007)(6916009)(70206006)(40480700001)(6666004)(16526019)(36860700001)(40460700003)(86362001)(7696005)(26005)(2616005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:06:22.6440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 387cb9ec-2621-4541-bd45-08dbe08dcc64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paul Hsieh <paul.hsieh@amd.com>

[WHY]
Some eDP panels' ext caps don't set initial values
and the value of dpcd_addr (0x317) is random.
It means that sometimes the eDP can be OLED, miniLED and etc,
and cause incorrect backlight control interface.

[HOW]
Add remove_sink_ext_caps to remove sink ext caps (HDR, OLED and etc)

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h            | 1 +
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index cea666ea66c6..fcb825e4f1bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -177,6 +177,7 @@ struct dc_panel_patch {
 	unsigned int disable_fams;
 	unsigned int skip_avmute;
 	unsigned int mst_start_top_delay;
+	unsigned int remove_sink_ext_caps;
 };
 
 struct dc_edid_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index d6f0f857c05a..f2fe523f914f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1088,6 +1088,9 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		if (sink->edid_caps.panel_patch.skip_scdc_overwrite)
 			link->ctx->dc->debug.hdmi20_disable = true;
 
+		if (sink->edid_caps.panel_patch.remove_sink_ext_caps)
+			link->dpcd_sink_ext_caps.raw = 0;
+
 		if (dc_is_hdmi_signal(link->connector_signal))
 			read_scdc_caps(link->ddc, link->local_sink);
 
-- 
2.42.0

