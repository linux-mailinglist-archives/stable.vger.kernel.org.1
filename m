Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1904D76C5DC
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 08:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjHBGy1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 02:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjHBGyA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 02:54:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9C2D76
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 23:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHpsH7JHMZUFzra2CdNsVtPvUc0opbpxDUxAERxX7dbnq1trGUSc54LKBj7cb0+/8WkSKwS00kIspT8KCH8hyFvO/UQb+Zg1TqXUY5bjKulLyf8zcIqNxFK+9cZNxDxG6EGN5x0zbZWtcytyYvhUbd+h6lEx2jcgjrC59Ge656uXgy2x/GsCUUSF7lwbSi0AJrW+9JWiuKHUDqguZeiyM6gqz7JKvt8fXuIzYRUHJLV7l8FTVq9efyw886vERStyVS15zJon/nwvf704wGZNcgwaWLa074VSQCwHuBUHqlRijkDBvUHwoPl8guFoxp+H1yCz4LQIeaMob9MmlTiGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MU2iGCZdk9W/nfPTRvYp0IZceWcbHfMplwUNHA53LxM=;
 b=TyFh847L/62cMcvoQL9g+vXC6cvGP9hQxof+HLak6xKfwDg+uxklB8Pv8nmVuWmAf88t7l29z4K2FEzJuJd/45wMPape6byXXSRNZiCG9pq2u4CTn4u9t9RwaXTIPOVOj0O/vBN+L3gGibOBDU4oQxscfCY07XImgRKVEzFDHO5+3ymeCJOow+FIsPkgkbrEIs4kwVtMnjv2RxUwJ4hZZMwTjfJ+MrkS+CEtMs8W6EcsRNSTJZJwhCmDfeTtMgWe/t4uMycqwma53L9ExRbV5MQ4ZauYf8LYdfnuxc9QLzqiQXCgdhWRFrYu4ez3Iv9Gsl+89p1qSmbgpRfAzxCcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU2iGCZdk9W/nfPTRvYp0IZceWcbHfMplwUNHA53LxM=;
 b=Q/e8VPXoq/Nx8KVRsceotW40IYmwReyyMM9V1QXBlE21C1/iqTfYc20FNWkF87ooQnyuVnuJC36n8izMLfQ4oCDC696iC/MDsy/ewTY5QhhLfpbYY+rTOH7J3/gU6wJzS26ULJvhQqCC7zi50/vuCOzr7M/GGN0tlFvwfK7ZHcU=
Received: from BY5PR17CA0031.namprd17.prod.outlook.com (2603:10b6:a03:1b8::44)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:53:37 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::4) by BY5PR17CA0031.outlook.office365.com
 (2603:10b6:a03:1b8::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 06:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:53:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:36 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:53:32 -0500
From:   Tom Chung <chiahsuan.chung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Swapnil Patel <swapnil.patel@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Wenjing Liu <wenjing.liu@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH 20/22] drm/amd/display: Fix backlight off cmd for OLED panel
Date:   Wed, 2 Aug 2023 14:51:30 +0800
Message-ID: <20230802065132.3129932-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c79f96-2417-46d3-ed0e-08db932532b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRYAjX2fzryqwWZWWotUIZfjRODL1Xf3wQlS6k+HpK7cBgB8pLLf/0Jv0VfbMFE7EX1AkUeOHm7ZZs/iEfNQFeAeoeu85oozwQSgoDxl9fYXqBHPfcfYTO2RKprW6UMRA58ssVFkIVhAUBNmOuxRONQ0OooUpWT0S84KGnPHgBwSaZz5mhsW6+qXWUIjmmv+pos3X0Lfotm3anITs+epbewgFFPI79zkHOj8IBDsgyLJ4XGw75cIBoXWTm6lVpm+dSacfEmCc1cjMexcs8POcKHF6Ovpb0cfuwhaM4mzj97FONH5SX/QxUR6HHdaA2aiEPo0NGgW1SyEBw6iWOaEu0876MXgOvxVDQ9T4J3c6T+UzaNhAvWorD4VjYUo/HIjSyt6k+bmXScpxaiU+faAixkXyHnhCNgix72sNJ6/r4H2Ofh0lyvPq0BpSK0H6KkrLvZ4LLayg0ubczK+kobKsZv+/vud0lU7UeFv3qsL3ErAaMlGB9X05od6cI8XkB/aEywq5Xd8KAIF44BAYWorUT7WUYGRj5N+v2xn8OdSj45VED13Hf7aOmXhAQXkPMAhR8YQ1OEQuPFBieyh2LvtinaCyz9vi7NLFOifgQQCzolkgk0ar+qQukzoXBZivNkN3AUNI/tbxz3e3k14sYqk3UYy/2rz2pn3oUNn2EiPWeiM5H901NI2oXmHTq8rqGbfNpw/zbRbvxA7bywZQZXCQBhEx0YK6s6uG2z1V9PG8t/mjwfDEXaO3kElM9ZnpshfVUXvFheEqQAPgCLC3c+QHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(83380400001)(478600001)(54906003)(40460700003)(8936002)(8676002)(36860700001)(426003)(36756003)(2906002)(5660300002)(41300700001)(356005)(40480700001)(316002)(1076003)(336012)(186003)(26005)(81166007)(7696005)(86362001)(70586007)(4326008)(6916009)(70206006)(2616005)(47076005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:53:37.5260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c79f96-2417-46d3-ed0e-08db932532b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Swapnil Patel <swapnil.patel@amd.com>

[Why]
Currently driver fails to send backlight off command while
powering down.
This is because in dce110_edp_backlight_control, current backlight
status isn't being acccessed correctly for OLED panel with AUX control.

[How]
Add support for accessing current backlight status for OLED panels
with AUX control.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   |  3 +--
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  1 +
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../link/protocols/link_edp_panel_control.c   | 19 +++++++++++++++++++
 .../link/protocols/link_edp_panel_control.h   |  1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index bf2d7fbaccd7..e50da69a2b97 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -965,8 +965,7 @@ void dce110_edp_backlight_control(
 	}
 
 	if (link->panel_cntl) {
-		bool is_backlight_on = link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
-
+		bool is_backlight_on = ctx->dc->link_srv->edp_get_backlight_enable_status(link);
 		if ((enable && is_backlight_on) || (!enable && !is_backlight_on)) {
 			DC_LOG_HW_RESUME_S3(
 				"%s: panel already powered up/off. Do nothing.\n",
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index f839494d59d8..dad730792a9a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -273,6 +273,7 @@ struct link_service {
 	bool (*edp_is_ilr_optimization_required)(struct dc_link *link,
 			struct dc_crtc_timing *crtc_timing);
 	bool (*edp_backlight_enable_aux)(struct dc_link *link, bool enable);
+	bool (*edp_get_backlight_enable_status)(struct dc_link *link);
 	void (*edp_add_delay_for_T9)(struct dc_link *link);
 	bool (*edp_receiver_ready_T9)(struct dc_link *link);
 	bool (*edp_receiver_ready_T7)(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index ac1c3e2e7c1d..cab68b5c80f3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -211,6 +211,7 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_is_ilr_optimization_required =
 			edp_is_ilr_optimization_required;
 	link_srv->edp_backlight_enable_aux = edp_backlight_enable_aux;
+	link_srv->edp_get_backlight_enable_status = edp_get_backlight_enable_status;
 	link_srv->edp_add_delay_for_T9 = edp_add_delay_for_T9;
 	link_srv->edp_receiver_ready_T9 = edp_receiver_ready_T9;
 	link_srv->edp_receiver_ready_T7 = edp_receiver_ready_T7;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 8b360c09e0e8..adebcef00e74 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -243,6 +243,25 @@ bool edp_backlight_enable_aux(struct dc_link *link, bool enable)
 	return true;
 }
 
+bool edp_get_backlight_enable_status(struct dc_link *link)
+{
+	uint8_t backlight_status = 0;
+
+	if (!link || (link->connector_signal != SIGNAL_TYPE_EDP &&
+		link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
+		return false;
+
+	if (link->dpcd_sink_ext_caps.bits.oled ||
+		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1) {
+		if (core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_ENABLE,
+			&backlight_status, 1) != DC_OK)
+			return false;
+		return (backlight_status > 0);
+	} else
+		return link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
+}
+
 // we read default from 0x320 because we expect BIOS wrote it there
 // regular get_backlight_nit reads from panel set at 0x326
 static bool read_default_bl_aux(struct dc_link *link, uint32_t *backlight_millinits)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index fa89bdb3a336..f2ab8799ddf1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -57,6 +57,7 @@ bool edp_wait_for_t12(struct dc_link *link);
 bool edp_is_ilr_optimization_required(struct dc_link *link,
        struct dc_crtc_timing *crtc_timing);
 bool edp_backlight_enable_aux(struct dc_link *link, bool enable);
+bool edp_get_backlight_enable_status(struct dc_link *link);
 void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
 bool edp_receiver_ready_T7(struct dc_link *link);
-- 
2.25.1

