Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400537ECEC9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjKOToq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjKOTon (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:43 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B5AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us0r6Ri3n+PjsVophuTr4hCUB3d/Dvqwv1+3oB5i+3XCmvpke0I6dKldA9sVOpyoPha7Sjk1oNYLNRiV6pvzpXAkRE3vRh/yCb9wowq4oNguY36TodCpEPJcy65EPjRulmH7jcZx/5qK8oXp7wgL7JXL5s4gkz4P7x9a4cktN77H0cbouGDsd///lg+gn5JtlAwSDXw9xS8S0cfREfFot6/eNGkzcrv6f2gOQLyNpXHnddzLb2LKZsKP2FowiFYMJsCtspIcFNZUW0MifrB6Tb3Kh4jNIygpytO3NeK441Pm89H2a2duFm/D4b62cd5w2TSpnjyuCleybArWZr/APA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVXEJcoS0NeS0GwHYHY8H8tu3MHwnf/cAllOEJhQFvE=;
 b=Jpt6L3qJO1JIm19rMcq6ljqCeVhJByJbKUOxObvdCd79IXe7xi0PhZHhlRWoFO+neNKD//C4F2BJtnKmVvjEs92fhgXMThX2TgemeBZA0AaOZ8FA5kBKT8jf0ZHoBp6F65ZwUPYXVio3Bg9Ed1+sfzs5LyZyRupwijA8GAuW5KGcXaMoec4XJxtRfF6Dg1y9oOda46V8YjC2Sen/MB4hpAFI5cKhotot1hTU5pmEbxoD+6DeYIr+ibocTHpaMg8UGsmGx2MeEfGLH/w54+/onSAOqx4qwMkY1ZpgrAWJaGbvcPHLJGxgggwzF+XZRnZ/4gwnGYZ2jCZk86IjtId8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVXEJcoS0NeS0GwHYHY8H8tu3MHwnf/cAllOEJhQFvE=;
 b=vmZdSa3oai9UtrvtPlN23hpke9JRx1GHOUli0AgTVBjJaj4JnLsc2w3RCp+NSGWhjY2qQCJ2GDyeZ+0wSvepQQC87M2Ayad8VVNnA8IYnI2lJFhbVBu8qEtEhstfycvS7AiU0owMUKQ2dSrXWQRHikK5T80OUGW+VLEoJbqxZ/4=
Received: from BL1PR13CA0097.namprd13.prod.outlook.com (2603:10b6:208:2b9::12)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Wed, 15 Nov
 2023 19:44:34 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::73) by BL1PR13CA0097.outlook.office365.com
 (2603:10b6:208:2b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:33 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:28 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        Camille Cho <camille.cho@amd.com>, <stable@vger.kernel.org>,
        Krunoslav Kovac <krunoslav.kovac@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 18/35] drm/amd/display: Simplify brightness initialization
Date:   Wed, 15 Nov 2023 14:40:31 -0500
Message-ID: <20231115194332.39469-19-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: d768075f-82b3-4d57-0d2f-08dbe6134aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvgTGCsYC96ZsFksQln09JBYo1LFjYQoQEDPEX0oNeXuDWxn5uNgNL6H0myBCYKABrBvgGxd7YMzfIwKprUkwesTPoKURPeW1Sw8CDz8CkX03MR7utLb9eUS567E3nUvETaNHz8LwzcTiwNuOmIP/D2Q1Dm9HCBPU1xHgqXVJPczOg2dSyglzMgSGg2F/x5NTCd8MuIUWcfN0RzJQrMndxDpDvwJgZNrWdeo+iWTEcob9wIHJ4h+szt8brFPx99Ik5jQ1IHhNAlRNUgOoArPsjqAbxbez2NEgYhnJCM88xiWEtv+z+lw2Vm13PziYvHw33P8/bgvJJ2iRq/tchgg4Vypwt0IaMpjrAA/O1Zaeq+vEJdTNaf4zBFQWTwj7EQOxIwsCmOWY64KVka/zgdxqHy1UXDKLynOpuB1T+kdE4ABVno6aMXzf91IAvM8QcNwa7PbwKGSJY9BcoczWI606q/Ks3ZxQcvCN1fsvshE3DBkrGTbB5HAaRGfOXSMY/nkj0NK9BwDg6/tk1vYJ5+bkGegrom0pnPVv4Tca+MzlG7kUle2q5ktZ/+NFxuJIwWPMfNOaXz9ogfXIFRVKct1LYMgXO1i3e8hLzGtSED9wBqWEGKK5dPFKq/PwgSGXMNMC2NlD/o7RRkkB3ZDtI8OJdeg4O/PpvCGM+i52C59LJRlGpErJnt+OcpvSelk0+MB/XdmDZsku97U24j93UJDg+5CQ+TehUJZ/ajHcGx5uXZjErBvyYQ5/9YB0ILO0dv5N6Xwhmyxqa1nUK6pUOGRzzrGD/9iRYMmxrA2J0u35nZND9CnRMsWoKnedN2HX5yg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(70206006)(478600001)(6666004)(1076003)(70586007)(426003)(2906002)(41300700001)(26005)(44832011)(2616005)(54906003)(8676002)(336012)(4326008)(6916009)(8936002)(316002)(5660300002)(81166007)(36860700001)(82740400003)(83380400001)(47076005)(36756003)(86362001)(356005)(16526019)(40460700003)(40480700001)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:33.4281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d768075f-82b3-4d57-0d2f-08dbe6134aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Camille Cho <camille.cho@amd.com>

[Why]
Remove the brightness cache in DC. It uses a single value to represent
the brightness for both SDR and HDR mode. This leads to flash in HDR
on/off. It also unconditionally programs brightness as in HDR mode. This
may introduce garbage on SDR mode in miniLED panel.

[How]
Simplify the initialization flow by removing the DC cache and taking
what panel has as default. Expand the mechanism for PWM to DPCD Aux to
restore cached brightness value generally.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Camille Cho <camille.cho@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h              |  1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h        |  4 ----
 .../gpu/drm/amd/display/dc/link/link_detection.c |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c  |  3 +--
 .../dc/link/protocols/link_edp_panel_control.c   | 16 +++-------------
 .../dc/link/protocols/link_edp_panel_control.h   |  1 -
 6 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 42ae3edd9015..85fa77d623f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1610,7 +1610,6 @@ struct dc_link {
 	enum edp_revision edp_revision;
 	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
 
-	struct backlight_settings backlight_settings;
 	struct psr_settings psr_settings;
 
 	struct replay_settings replay_settings;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 4a60d2c47686..a2f6c994a2a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -991,10 +991,6 @@ struct link_mst_stream_allocation_table {
 	struct link_mst_stream_allocation stream_allocations[MAX_CONTROLLER_NUM];
 };
 
-struct backlight_settings {
-	uint32_t backlight_millinits;
-};
-
 /* PSR feature flags */
 struct psr_settings {
 	bool psr_feature_enabled;		// PSR is supported by sink
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index f2fe523f914f..24153b0df503 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -879,7 +879,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
 			dpcd_set_source_specific_data(link);
 			msleep(post_oui_delay);
-			set_cached_brightness_aux(link);
+			set_default_brightness_aux(link);
 		}
 
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 34a4a8c0e18c..f8e01ca09d96 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2142,8 +2142,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	if (link->dpcd_sink_ext_caps.bits.oled == 1 ||
 		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1 ||
 		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1) {
-		set_cached_brightness_aux(link);
-
+		set_default_brightness_aux(link);
 		if (link->dpcd_sink_ext_caps.bits.oled == 1)
 			msleep(bl_oled_enable_delay);
 		edp_backlight_enable_aux(link, true);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index fdeb8dff5485..ac0fa88b52a0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -170,7 +170,6 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 	*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits;
 	*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
 
-	link->backlight_settings.backlight_millinits = backlight_millinits;
 
 	if (!link->dpcd_caps.panel_luminance_control) {
 		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
@@ -288,9 +287,9 @@ bool set_default_brightness_aux(struct dc_link *link)
 	if (link && link->dpcd_sink_ext_caps.bits.oled == 1) {
 		if (!read_default_bl_aux(link, &default_backlight))
 			default_backlight = 150000;
-		// if < 1 nits or > 5000, it might be wrong readback
-		if (default_backlight < 1000 || default_backlight > 5000000)
-			default_backlight = 150000; //
+		// if > 5000, it might be wrong readback
+		if (default_backlight > 5000000)
+			default_backlight = 150000;
 
 		return edp_set_backlight_level_nits(link, true,
 				default_backlight, 0);
@@ -298,15 +297,6 @@ bool set_default_brightness_aux(struct dc_link *link)
 	return false;
 }
 
-bool set_cached_brightness_aux(struct dc_link *link)
-{
-	if (link->backlight_settings.backlight_millinits)
-		return edp_set_backlight_level_nits(link, true,
-						    link->backlight_settings.backlight_millinits, 0);
-	else
-		return set_default_brightness_aux(link);
-	return false;
-}
 bool edp_is_ilr_optimization_enabled(struct dc_link *link)
 {
 	if (link->dpcd_caps.edp_supported_link_rates_count == 0 || !link->panel_config.ilr.optimize_edp_link_rate)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 39526bd40178..b7493ff4fcee 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -30,7 +30,6 @@
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 bool set_default_brightness_aux(struct dc_link *link);
-bool set_cached_brightness_aux(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
 int edp_get_backlight_level(const struct dc_link *link);
 bool edp_get_backlight_level_nits(struct dc_link *link,
-- 
2.42.0

