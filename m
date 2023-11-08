Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8197E5E20
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjKHTFA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjKHTEr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:04:47 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A930F3
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:03:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KboLeu74zoKKoM8iDvZNAMGyLg+csjzDG4gSWkfV+0KYqWR0tlbozOw7D/v7B9IzX/zeMuPTKcjxxDVMoNE/H+VB2G+zUteU51toIIY4kCF+GYAxmcjKcGdpYENOVhe4VPw7SahrxLpxbG2/+BibYip9c7pIhPqjk/PJIpaQ1itVxbqdm+M8JyA5grSa+9Nhgbqt5k/bD7BIFRFXiMY5w09KupfhUtlL2vR4vYONZWQfNCvHm3eWcBeK+iqwP3cxqvqkqD2hbXD97XsZx1HwLSJ9kMfrnEgaj0D9DHcwG2tc8mXJ+lUXfylu8EAYn/Vrac3MCzF2DKrLmmlAM6P9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alnOTl+gdmnz6nq3eaP0Mu6ucKHu5DdgrJf9zJlK+cw=;
 b=WxDRP7I0T0KOsIykRrbL/sGoCdjsbAzvRlRfUJau8VODhiW03HLAfR4B5MdYw3HpfBOt4V/TUA7cSMwkNnrht0ibb3mgQx5suDYgT/Y1ONvh9T/u+qvn/gGs0mP5YDf9wt2EuDZ2GTUqcfri00Iikbo77tAinByVo4ee/REbzMsXzoLMlDfhfOH3oiKNP+Y81XkbMi/cco2YNqVH4x0fA+6C9kCv+5C2Xz0t1Qvua2KL3SgSSwmuVAMORgbfbZ9L9z1uOlOVas4X7yNnzBGWLDNdysiI+u8YFJPeGpcjiR159r8kTNkPCWMnhQLdSpToJFifIXrxmiDYvl3xQBawLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alnOTl+gdmnz6nq3eaP0Mu6ucKHu5DdgrJf9zJlK+cw=;
 b=L1T7IeX57ZvB4o+rN32yUKMG/0pZGSrIcLisPKWDVGVNSuLY6zkQ8HY5BXhqppmW3R2QmymHXqC22Db+uiO2E3w8OVYZgJAD8/otDOLDXAgCrGkjmGIX1xebLc7N74TEAgUNlNaceDG9CXyRZWUuz4OZEWeJsT+yGQnQUr32UB4=
Received: from BLAPR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:36e::26)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 19:02:58 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::11) by BLAPR05CA0011.outlook.office365.com
 (2603:10b6:208:36e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:02:57 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:02:47 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 04/20] drm/amd/display: Fix DSC not Enabled on Direct MST Sink
Date:   Wed, 8 Nov 2023 11:44:19 -0700
Message-ID: <20231108185501.45359-5-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ab8e9f-faad-429d-2f4a-08dbe08d523d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7bzZXwT2Oxb77rgPh+/02Naq1aL712wIpnEb0EdBdwITHTkhpRQRESjlgt4YwIl30FQaV7Uqnb6dEXtTyzkjkRNhUDYj9gIJbCR8ooAY9zhftSqMKsUTgphglNPCCXzmerZSSlh7A3VdjNhD2T3eaEI42ujereRWaqim7d4VcfHqinWYfCAUzJDjywK1dklqT6Az8PVDzPOaJrQBpynELWEpuAk75xYdTtaTcx0ct/Oz8VNf07zc9XJDlDTmp+RJ6mzC/3Y7+JNBK7Uiv7OckbghrU+ceSkJlfrrNe1mDuZgeq84fFScYIyHN6GJcBe/94dqtJz+dEh3LHEYE6UwzLueoErVOcBa0jlTvn6NJIAxtHOtET1HdE21AG7Vx5ECCIkCb7bCYqEkUTkfL+szGAsP6olzygEAo32Xd74pbmYpIiZVq7lGYTisEuQoVMhaBB2DIcFQdIxfITSsu4CMsVqcxIOcp1itjlNDOTg4JdnjMW0x6C/9abGcvddQ0lcoinNBEYUP/mjSYR2unzrGx4zSPAV3nhoeGz2B/o6VhOqMSGdspYYnCFExXz72AuQDqde0a288eh32BOXZWI12Ye1Fu8gPik8od+bXLAu/r9BKt5wSvIitLsAYu9yHstJXPHXHcx3jKMBE67deZng+AsEtrRmSAD4pMl5XtWLpg7NsEZL1Y1BMzUJT+t4+bNAJN0bDc2gpiXOmW7WS3thv0Ln8RIOmGP+dkQQxUnhHaQIm2ileK8w5204lyMOlUZDKJ1DQEzqJNQ6H4+qEZRTZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(16526019)(478600001)(6666004)(47076005)(81166007)(36756003)(36860700001)(86362001)(82740400003)(356005)(83380400001)(5660300002)(2616005)(41300700001)(6916009)(70206006)(54906003)(426003)(336012)(26005)(7696005)(316002)(1076003)(70586007)(2906002)(44832011)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:02:57.7184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ab8e9f-faad-429d-2f4a-08dbe08d523d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fangzhi Zuo <jerry.zuo@amd.com>

[WHY & HOW]
For the scenario when a dsc capable MST sink device is directly
connected, it needs to use max dsc compression as the link bw constraint.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Roman Li <roman.li@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d3b13d362eda..11da0eebee6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1604,31 +1604,31 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	unsigned int upper_link_bw_in_kbps = 0, down_link_bw_in_kbps = 0;
 	unsigned int max_compressed_bw_in_kbps = 0;
 	struct dc_dsc_bw_range bw_range = {0};
-	struct drm_dp_mst_topology_mgr *mst_mgr;
+	uint16_t full_pbn = aconnector->mst_output_port->full_pbn;
 
 	/*
-	 * check if the mode could be supported if DSC pass-through is supported
-	 * AND check if there enough bandwidth available to support the mode
-	 * with DSC enabled.
+	 * Consider the case with the depth of the mst topology tree is equal or less than 2
+	 * A. When dsc bitstream can be transmitted along the entire path
+	 *    1. dsc is possible between source and branch/leaf device (common dsc params is possible), AND
+	 *    2. dsc passthrough supported at MST branch, or
+	 *    3. dsc decoding supported at leaf MST device
+	 *    Use maximum dsc compression as bw constraint
+	 * B. When dsc bitstream cannot be transmitted along the entire path
+	 *    Use native bw as bw constraint
 	 */
 	if (is_dsc_common_config_possible(stream, &bw_range) &&
-	    aconnector->mst_output_port->passthrough_aux) {
-		mst_mgr = aconnector->mst_output_port->mgr;
-		mutex_lock(&mst_mgr->lock);
-
+	   (aconnector->mst_output_port->passthrough_aux ||
+	    aconnector->dsc_aux == &aconnector->mst_output_port->aux)) {
 		cur_link_settings = stream->link->verified_link_cap;
 
 		upper_link_bw_in_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
-							       &cur_link_settings
-							       );
-		down_link_bw_in_kbps = kbps_from_pbn(aconnector->mst_output_port->full_pbn);
+							       &cur_link_settings);
+		down_link_bw_in_kbps = kbps_from_pbn(full_pbn);
 
 		/* pick the bottleneck */
 		end_to_end_bw_in_kbps = min(upper_link_bw_in_kbps,
 					    down_link_bw_in_kbps);
 
-		mutex_unlock(&mst_mgr->lock);
-
 		/*
 		 * use the maximum dsc compression bandwidth as the required
 		 * bandwidth for the mode
@@ -1643,8 +1643,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 		/* check if mode could be supported within full_pbn */
 		bpp = convert_dc_color_depth_into_bpc(stream->timing.display_color_depth) * 3;
 		pbn = drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp, false);
-
-		if (pbn > aconnector->mst_output_port->full_pbn)
+		if (pbn > full_pbn)
 			return DC_FAIL_BANDWIDTH_VALIDATE;
 	}
 
-- 
2.42.0

