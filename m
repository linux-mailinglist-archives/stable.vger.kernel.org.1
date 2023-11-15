Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456787ECED2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjKOTov (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjKOTos (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288E1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcv036qcOW7YdhEy5RqPvoWbwRq8fbHWU4QhoypQdfMLCYnaUFPhfytwFoFBWre0tYlDd1YCyVBg6NlQc4NWentl8hHPBlohp9IqnQ5OBAruIexlqMofArMboCSY2TMeoewtyW8ewJoEDs0VL7Xr7sc7lpi3zVe1ehjCQ9p3hQHD1naWwtbIcTgOiXpk2R1uuRi9JFsabj7l0J/PYqlumDkb0M+wphQzNXSzPs5X/xs0E3Wc6t3OkCvLzVEttkJzqLGRVCgWlPc/d5xMjEHYcoarMutZzThteHSGfVZ+ycaVCEZHIuMCj26p8FCz063J3AZLi52vakRbSkmxxquh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRy3flln/0b2dqG7E/WsV4vtz+P75YHNO0WQxbTKDCc=;
 b=cIL4kgEEVqnRsI+6Qmq25t5VEyIHWfsZFnu+PGP6dpAdqt5wo4KP8COepUHffcNiKks6B3Pkch8u6e++W5F99Gc2Xzq+11LlwfOgt4RxlQhKAbBAJBZLkgicTXpPnku6c4S4iDhiAoz81FcvDDvekbzu1wIyPGa0ZsJB+LCrPg3OtlO+TN/8SMOvK1e2AtSv+PX0/aGE2YiuZviimEs6EDfc+cufPTTEyvCbnC+25r6hALFLLbeMAL1u4ksFq3X7K4E/8tjG6od1y4ShYX6XTv2OnPe4BT5X32euRF/I34DHu0z+OBzRHJ3z2z1ECYkA/UGudFpDphDdjN/4pdSkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRy3flln/0b2dqG7E/WsV4vtz+P75YHNO0WQxbTKDCc=;
 b=WGHMPnGyw42wAzWVEwdvzSkM9vCl+ojF/qfSDcRymSzzZJZPCSw/tNu65yFyHZU/Ok7oqdCd3gq+523PR9Ooe8eCytI9E+kdPlau9bDgV3a7Zqv3zvH/pEejMiYPVwpTHsg50Pk6188aJOJk3cqinCxNIAU+aqjMUassSirDios=
Received: from BL0PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:207:17::24) by SA3PR12MB8803.namprd12.prod.outlook.com
 (2603:10b6:806:317::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:41 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::10) by BL0PR1501CA0011.outlook.office365.com
 (2603:10b6:207:17::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:40 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:38 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        Zhongwei <zhongwei.zhang@amd.com>, <stable@vger.kernel.org>,
        Michael Strauss <michael.strauss@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 27/35] drm/amd/display: force toggle rate wa for first link training for a retimer
Date:   Wed, 15 Nov 2023 14:40:40 -0500
Message-ID: <20231115194332.39469-28-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 0112ed1a-c5d8-46a4-b9b6-08dbe6134efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YD0qn5fc4yQD+U1GrRzr3N5aWDI1vvg86o1Ih3oGa0grRyIxQfFOf/Yh6IBrhQvWjwyvFWwBwyvo8I29SQ6hRdZWM06a/WKJB9L6fRYlEO8nT0ZNnEy1bSWcuk6UMDM4tTiwQfbfZzfo1uqZcD5iL3sZ9iy5HYI9MV6arX+YXsnWMzNHEr5dGXfTxKYg2Kwctkre8xjsslNMdPISrpruDA5FDWHJe++ZWVDvHwBu7Gilt25QU5/EeC7NsgCWwr7HkoD2XVPFtNlS2wKbAEGcLYq21AL8FKNKnKhHi84ooc9/LwDJaho71vg3MvosG7JtZSyZAxJu52bWt5UQ8csbir8uLuhY80wfRz/tf+Gf2syY8bCxd50/ItBrox+904B/j9gzqRMvyf+z0UnS9i3QtaeX7ttdBl4Fm2OYG8++5UdpTSs1DFOVPdVT+FVNOKQ+3JjUl4IeoxMpWkhq0HYFtpPKGa7XVZZTYiy0VmLLpL9UWZKREdrapA9alL2aJnfzrHzF5ctHyJ+bzHwIA2B5qJLFDHtQ1DY0LvAME31D9xE6WNukrvXDf+yM+x7tw14l5YkguwukZVB10UIRKU7E+kuoL5TRWaOeJLK6PDdbu+7SNGel8qEK5ZXRyLEv681lYBDDmGZtMSLRdy/H8EttU5sgEptr6oRwq8JamPtqXkcZpSY7egDci0mNVpAblUBJ+yuAhMIdh9glxYR/npnb2E5vZ6vF/YbOutqHOe4tbLB+MJETfGAcf5H0S3209DspSI6neI/rvQzto+Q2B2uYk6srZLXn1/m61OlnC481w3kqeJ+CxpE9pLNV1f3sVQRp
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(70206006)(54906003)(70586007)(2616005)(6916009)(6666004)(40480700001)(478600001)(316002)(8676002)(8936002)(4326008)(36860700001)(82740400003)(356005)(83380400001)(47076005)(41300700001)(5660300002)(86362001)(426003)(36756003)(336012)(40460700003)(44832011)(26005)(16526019)(81166007)(2906002)(1076003)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:40.6409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0112ed1a-c5d8-46a4-b9b6-08dbe6134efa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhongwei <zhongwei.zhang@amd.com>

[WHY]
Handover from DMUB to driver does not perform link rate toggle.
It might cause link training failure for boot up.

[HOW]
Force toggle rate wa for first link train.
link->vendor_specific_lttpr_link_rate_wa should be zero then.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Zhongwei <zhongwei.zhang@amd.com>
---
 .../link/protocols/link_dp_training_fixed_vs_pe_retimer.c   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index fd8f6f198146..68096d12f52f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -115,7 +115,7 @@ static enum link_training_result perform_fixed_vs_pe_nontransparent_training_seq
 		lt_settings->cr_pattern_time = 16000;
 
 	/* Fixed VS/PE specific: Toggle link rate */
-	apply_toggle_rate_wa = (link->vendor_specific_lttpr_link_rate_wa == target_rate);
+	apply_toggle_rate_wa = ((link->vendor_specific_lttpr_link_rate_wa == target_rate) || (link->vendor_specific_lttpr_link_rate_wa == 0));
 	target_rate = get_dpcd_link_rate(&lt_settings->link_settings);
 	toggle_rate = (target_rate == 0x6) ? 0xA : 0x6;
 
@@ -271,7 +271,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,
@@ -617,7 +617,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,
-- 
2.42.0

