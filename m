Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C37030E9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 17:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbjEOPFJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 11:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjEOPEs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 11:04:48 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A95911C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 08:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHV4rKQWoFmR9LSK78TlCRgSg/B9BHMyKJbxSbPzI1ZPiJENB5GfWNjYdR4+O1bEWGsPKiooqNhoHkBhAU08EBVOHJ11pcSmEBZWOtkTdcMlseBagb4M3sQjgKiYnlivdaZI5XZI7rNBEnNljcbDCPZZUjKMgeUWxAGQ9dsBaETZ6vgfWhT5cLuQFZU1PnituVBAqUM5C9asDbC7843pexANlh5TzxKASmVe2pjucnl2rwWaXtcyrhuxx6U0ljc2u+Wu6Vsrv418OTXttvf3oBbtIrZqsSnivSVGF5vvvDE5s3cx3FUqh/K/Tt9Bra3flMJjH91iMOVYWXYa10kAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9hJRwHKEPUEP4ICHaUGKgXNmaOuSiQ1AxyIWmGINb0=;
 b=mX1WbEPPgby5bs3nIlxYok52cVG+Z/w4zbO4JTXFfQzT2NB7OpnuFO0Brv2PXS4Hdn7ssyJPOyN6bqYEYfTHBegFIHkut7l3K9FBjSxzsF+2eEGJ6SDtTsYsR/hK06RW0SVFyzBts1YEjaTGlhMmhKkptmsLkULDg+IQO/fGG9uA/jChPlC9A5bkYcI4iBW1knefS1/M+Xy2vfyXZyLD1YkyrqkZV1P61JNJJ5/tMpFc9If/cv83iykwBGxrsKfjIVmumfi3PQQ/XlwVA6nJ84+/li1Azptrg+tjhOY0OQFnWf25E7gnIefmhlvjBAUBSh1Pdd1f4E3My92QYjHWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9hJRwHKEPUEP4ICHaUGKgXNmaOuSiQ1AxyIWmGINb0=;
 b=GoctSpj9CGMNiLE3+s/kJcYKADOvVMFCOc9EIc4M780i84ziheeZcFlUU3UkVkgEhUjoCchtXXI7u2UoPkhtkJS7vFBGbyD6mhHM52ptQYx4TLJ6Lsdf1lVYrOae8G32NWyT/aEcLZjaQ/9rsY9CS29nffKEmQQ7ISdGGW0QtI0=
Received: from BN8PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:94::32)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Mon, 15 May
 2023 15:04:43 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::a7) by BN8PR03CA0019.outlook.office365.com
 (2603:10b6:408:94::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 15:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 15:04:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 10:04:42 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix hang when skipping modeset
Date:   Mon, 15 May 2023 11:04:26 -0400
Message-ID: <20230515150426.2197413-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: b090fbca-a820-4950-ec53-08db5555b738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pocsa69lIDhIubL48sM84PXU++2IzuU5Q4oE3LHTLDKGx8lmimhOfm28WaC81NJtb875XUQUeMjmX20F9kicmeBwDRGwbq2VtV+WeALoxwbVTcxrQ8yT4sXjo2DhiOxX6Hl2xYUUG0Pz/FN/mxsvQBn3G/TBDZIE8i4x9ng4xlJix4UKf+k5vltzu+TxULUGZ+yomUzLNrtIUY9ZaZrJdeIZB+9eVw/vjacELehkk5FWSFtcwAAPtF755FwpzLA1flo5dKinyI0+hVv+m55wZDBjsXh6qJmU8rU50BtMaujGasGGwFpW+wOZusa1I74XCAyI6xVLHm0uSRfechYzfpATpA28UtwFZPzgyOja4ChK84x6wavhO/S4e3RNQTCjvuoW0w+TVHoNXjR9a4ahWSlJMYwTxNIsomkJ90+cQOn3vbux3ejqZtt3b8K4DWWrm7bN4chVmskWGsFZWGThIJ1Wgd/P1WC6FIbqkWENzl0tw6gUXbHLcQ7NjIJij1ZdOKxYwCZ0MTmXIRRUVTWe5uyoN1e8qHAiyynJS7Cw2bmYWWDyLFic31au0mx5CE3nweM0G/YKFLjGHCMct3X165x2I4ohaftvpn/UfQVL0lQU/pzmW9ZQjS47v0mnlMi4E9GvyfPQYA22jubIPJMKRVYxFhnOqnqK8eByd1WT7Wjb3KR8l+bfg6O3TizTicFFMLIRhmn/xdxpF6olaHI04FIuCkpfvlbmD3T4yziu+PXC4IsYYpazGH79S/Vfj8kE+keIUV6M5+Vir7QFKoaV6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(4326008)(70586007)(70206006)(7696005)(316002)(110136005)(54906003)(478600001)(86362001)(81166007)(36756003)(83380400001)(336012)(47076005)(186003)(36860700001)(2616005)(426003)(16526019)(1076003)(6666004)(26005)(8676002)(8936002)(2906002)(5660300002)(40480700001)(82310400005)(356005)(82740400003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:04:43.7130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b090fbca-a820-4950-ec53-08db5555b738
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]

When skipping full modeset since the only state change was a front porch
change, the DC commit sequence requires extra checks to handle non
existant plane states being asked to be removed from context.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit da5e14909776edea4462672fb4a3007802d262e7)
Cc: stable@vger.kernel.org
---

Fixes a hang with freesync video enabled.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 62af874f26e0..a1ac06eca37a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7950,6 +7950,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			continue;
 
 		dc_plane = dm_new_plane_state->dc_state;
+		if (!dc_plane)
+			continue;
 
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed) {
@@ -9601,8 +9603,9 @@ static int dm_update_plane_state(struct dc *dc,
 			return -EINVAL;
 		}
 
+		if (dm_old_plane_state->dc_state)
+			dc_plane_state_release(dm_old_plane_state->dc_state);
 
-		dc_plane_state_release(dm_old_plane_state->dc_state);
 		dm_new_plane_state->dc_state = NULL;
 
 		*lock_and_validation_needed = true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d9f2ef242b0f..0ae6dcc403a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1707,6 +1707,9 @@ bool dc_remove_plane_from_context(
 	struct dc_stream_status *stream_status = NULL;
 	struct resource_pool *pool = dc->res_pool;
 
+	if (!plane_state)
+		return true;
+
 	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i] == stream) {
 			stream_status = &context->stream_status[i];
-- 
2.40.1

