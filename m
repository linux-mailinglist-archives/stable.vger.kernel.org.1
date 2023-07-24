Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9891376023C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 00:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjGXW0u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 18:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGXW0u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 18:26:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA51BC
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vtb3bjOjV4A+BhtvgmGLFo4eFsFYZOeuzv1SdeZNLMYh9KfyiS0lDaGsTg+qOfuR2vzADcXUAMoeFVJDVi+Algr22yR9UzdOEFaKpruj9fNeJKptHEnzyjJ6vX/BbjoMhfJVcf+NO+ENB9oeMDtirhGqbV0/ufoyFifu+SpAbIDpELe08BR7p+oNB/ttm4jXcJmstttAbQRWf9S7La0dgVQilt62G2ZMt2hk9rv5A8qQ7W08izOFb5JSEeRYnj69+gHQNakou6gR8jkWK7k72OH/tQUdmifQLDAmgMdyIGiL9UU8OISw7RQulGuICUWf6sqfI5uRJS8hqITVCxrlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS6gRez0sb3i0CfgiTTjYH7fdV9xCxWrnwqTLuI93+U=;
 b=VQTed8W9O5SaqXXJc9qBy1vX6GiXYM0RGhpU09xsYDu0HpQ/dB9Er5AWvH4ljmYPt1lmi2zUqGvhTW77aUXrEuviiyDAVCmdrKBt4bS0nxr1jt3NLYUlyycNisfAniSmvwbw/4WBC2uLb69RMyW9/axhsRVjtEJtA5oLDaX4fYrDeudKj0JMUSoiaj+UUDg9YQEsHVgagHIssm403ZmqB2jKF5Fpxu+hRcOMhauf/4gRdR5USb0Nco9Jx1ORlTTkggAL7lWs74uqto+rojmjeMcISQ0ImORprsaen+jx2Z25YBAkSKk4/N+n+AN3Fh6xvIa5BxrqqdQW4jiwmH3PTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS6gRez0sb3i0CfgiTTjYH7fdV9xCxWrnwqTLuI93+U=;
 b=mmb+G78eXy+P7MdA3jxykxxUssPyGaXbxNWkaZF4sr0SDNv6937QuEjESSrkJhWIUI0plCIwMkfkkZRyfsGUJxmpoTSkKiKECoU5B5+YrxNa/5AwdkgbwVQZK9IsA4lzpJ1f8IZ/+8qB/idFzf5bZrGOH79w+e2zUpQic+M4dNE=
Received: from BN0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:408:ea::31)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Mon, 24 Jul
 2023 22:26:44 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::2c) by BN0PR04CA0086.outlook.office365.com
 (2603:10b6:408:ea::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 22:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 22:26:44 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 17:26:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 1/7] drm/amd/display: use max_dsc_bpp in amdgpu_dm
Date:   Mon, 24 Jul 2023 17:26:32 -0500
Message-ID: <20230724222638.1477-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724222638.1477-1-mario.limonciello@amd.com>
References: <20230724222638.1477-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d200420-2d75-46d2-a56c-08db8c950fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FkSqxwBhtZIcJ7jb25gYER2N2SuRrq88IB1HJ7YxqNxVAqzGF2f9OnLkTepPxN2VDf809J4eMYSlioVqFvLNo20wBs/bLYxfDRydMMeKJPt9NtlNWIz7uTrOSjrGo2S52RdsaGQ629kzOYcXBooA01NgZuy9g0loHEWKLsKIQzPiRtQsRY1X0aa6eoDj0B/z54e0qdM1uB0G460meoAQKQ2e7xuBWM2LBxmG+9dGEAAoIwCa4ef5n1KATuQJ0ID+hW7U37gFm6KcddFBdTNDXMMrwyfr/gzEhVquKnAfU+gndZ/dX0bbptdiQljXBgOC9gBX4o2RIWQcuWzT+3uHwR2WZf1dbOEFNXoL7iCULKNJNaZsNo2VKo53fo9rSxqXjWx7fXljLQp4AaGYUFHm62fNTuKsg1eziIuPM/iQ/ztDp6d9gnXtXqSFtzmAu6EukC68d4bGQ17K8o+xqoOq+7p93Hx/9P8DNjWOst6ccvDZsDUDissRT4yeajWt3iNJKTeYvahyGtLEE7xpTSgNJpWhd7FDk51LpuwZBsJS60q6WQR20Q0ciSDj5aKvyd7Emk2g5MBwjx0MADuQViTsXooSFDlU9olUhypu+49N64LxdhY7XKJL+wFupSSctrajZ/qf9f+HXW2GoN+SxqfBROhYFgoZ41/q1wufnX6owPincZxe+sGSboVorMbZAiMse+JCITJe8b77OnNWKUm7IqQUy5EUpNtFXoNHdCTeT2K134b4eybB7J9MusrhAJ/cGc2gQNL9hjky4/CR2RCYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(47076005)(1076003)(41300700001)(186003)(336012)(83380400001)(426003)(26005)(478600001)(40460700003)(6666004)(40480700001)(2616005)(2906002)(7696005)(16526019)(36756003)(86362001)(44832011)(5660300002)(70206006)(70586007)(4326008)(356005)(81166007)(6916009)(82740400003)(8936002)(8676002)(316002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 22:26:44.6788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d200420-2d75-46d2-a56c-08db8c950fdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

Since, the quirk is handled in the DRM core now, we can use that value
instead of the internal value.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6e5abe94c6eb9b281398e39819217e8fdd1c336f)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     |  6 ++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 11 +++++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b854eec2787e..e7c7ac47f86a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5714,16 +5714,14 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 {
 	struct drm_connector *drm_connector = &aconnector->base;
 	uint32_t link_bandwidth_kbps;
-	uint32_t max_dsc_target_bpp_limit_override = 0;
 	struct dc *dc = sink->ctx->dc;
 	uint32_t max_supported_bw_in_kbps, timing_bw_in_kbps;
 	uint32_t dsc_max_supported_bw_in_kbps;
+	uint32_t max_dsc_target_bpp_limit_override =
+		drm_connector->display_info.max_dsc_bpp;
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
-	if (stream->link && stream->link->local_sink)
-		max_dsc_target_bpp_limit_override =
-			stream->link->local_sink->edid_caps.panel_patch.max_dsc_target_bpp_limit;
 
 	/* Set DSC policy according to dsc_clock_en */
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e2f9141d6d93..994a37003217 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -673,15 +673,18 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 		int count,
 		int k)
 {
+	struct drm_connector *drm_connector;
 	int i;
 
 	for (i = 0; i < count; i++) {
+		drm_connector = &params[i].aconnector->base;
+
 		memset(&params[i].timing->dsc_cfg, 0, sizeof(params[i].timing->dsc_cfg));
 		if (vars[i + k].dsc_enabled && dc_dsc_compute_config(
 					params[i].sink->ctx->dc->res_pool->dscs[0],
 					&params[i].sink->dsc_caps.dsc_dec_caps,
 					params[i].sink->ctx->dc->debug.dsc_min_slice_height_override,
-					params[i].sink->edid_caps.panel_patch.max_dsc_target_bpp_limit,
+					drm_connector->display_info.max_dsc_bpp,
 					0,
 					params[i].timing,
 					&params[i].timing->dsc_cfg)) {
@@ -723,12 +726,16 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 	struct dc_dsc_config dsc_config;
 	u64 kbps;
 
+	struct drm_connector *drm_connector = &param.aconnector->base;
+	uint32_t max_dsc_target_bpp_limit_override =
+		drm_connector->display_info.max_dsc_bpp;
+
 	kbps = div_u64((u64)pbn * 994 * 8 * 54, 64);
 	dc_dsc_compute_config(
 			param.sink->ctx->dc->res_pool->dscs[0],
 			&param.sink->dsc_caps.dsc_dec_caps,
 			param.sink->ctx->dc->debug.dsc_min_slice_height_override,
-			param.sink->edid_caps.panel_patch.max_dsc_target_bpp_limit,
+			max_dsc_target_bpp_limit_override,
 			(int) kbps, param.timing, &dsc_config);
 
 	return dsc_config.bits_per_pixel;
-- 
2.34.1

