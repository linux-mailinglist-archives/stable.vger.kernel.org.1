Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733547ECEDB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjKOTo4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjKOToz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622F1BE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftP0FEiZidFo67uM1FcmQEzv/SmPjThPCz+kK7TeDSfc2dFDCwa2rMzDLdCWu1jok4jjrGoJUBMVxqZOcANb7T8D+pSJWoc3CSxNXc9bQI/A0xfzbiIcaNBtHM/E23rBrcl+fJ1SWikuZhyRp6cBSpl6tGprnWkRb/ukVOS1UT3x/E5/RkRwDJrAFPT+NUCj3iMwLUPFXJHjKDEIDUhVUfR7NEgZ7NQOVgnIoRrVJqHfq1ro2z9mcoI+T/s3k/InAvdCJak/fqloB8tDU2C1p3TRwcL0mmsnBP9ooScOdLii7+qJqXXRJsv6KAVZwhBpVbAaq1sqpqD9PAxoxRAnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keynJcTnQInbedDTgst2S7nfq2edSUBkA9wb/x301NA=;
 b=A/1/xX9DWhibVyXkaLHAVdXkXIcU2nV3SVzYRVqOYm61xQyP+QT0bk5ieyolGwltbUmwZ+NTRvrS6qTrUIHslDi49NeV/XjROZGXypkDkDI6+0ohaYaHw4o/gZf1tmb47fj2VPmP6VsLnbEnVm0cfYptTftmWzvjAIWQ/7W7N6at62Ny1KsrdKy1SjcRJoaDC8qzyLbuxGqbH4ZaJ7spZ1yXdZXJYDyJBckasohBOO1EnctV+codwWiHb3ULMlS5aFYvP10vrsY8I6ckhEEhX9DmTEQOdV+pYJAh8hpfAQDEGqu6m9PMWWWcbOlp6WYVrXmdtQ/F9LXJ7siG8nsEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keynJcTnQInbedDTgst2S7nfq2edSUBkA9wb/x301NA=;
 b=NJDFbHgJACA2q9ZLuapilA3W+x49YqVFhCN33wZzfnoVr7eVf0ZnDxoSf8bObdD8guXpq7GiRCS8MDJXHpF9C5AQ61kZh0eh6P6IHJAeBL/zq8GI8CsmNnVKZS5yWVMJ5NIZqG93JsVHcngZSkQewnYf+E4v1bf8B3Go3duApUY=
Received: from BL1PR13CA0109.namprd13.prod.outlook.com (2603:10b6:208:2b9::24)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 19:44:46 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::2e) by BL1PR13CA0109.outlook.office365.com
 (2603:10b6:208:2b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:46 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:45 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Taimur Hassan" <syed.hassan@amd.com>, <stable@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 32/35] drm/amd/display: Fix some HostVM parameters in DML
Date:   Wed, 15 Nov 2023 14:40:45 -0500
Message-ID: <20231115194332.39469-33-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e54dc2c-d889-488b-ecf2-08dbe613528a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93XgfvebYYm/E8JY3ecLnhylzKvmppY658NScUeR5vf3+RUIpGKavdLdM6Qq/lEll43J9KmfQdvVymLP84cVU9JoPCB5NZMzgaDfSwRlGka6JNr7uHYuBlCT/0NyLeBYyA9KVJ7PbdX9jAaukxj2wFx4VvRU8U7LvKDJZA46+ppLIKabZn7QKVfh26gI4WwnTyHDRHUxOAjxw/lMRzrKVaOqJP4iBU9RexF+Vz3vSm9xofrCUgz/QtaO8tCDI/TkSPiEBZNF/zcRlVCeixKCk4FWgdJQJKoIaya+xPKM7voo/HlWOpaf/+xRcsOUKJwvDsdlqe/hBBxmX8dgd3IlEAYTiRnmCwht3YYSCHY5Rqh3hoTDbRyDdeJ13vUbB8hvpDwb7G7Ryjd2s2krFlU3dBY0H96x66jzal5ESoYacyYmS7Yq/MmBWMbqyNC1kBFLif0d4H9EVZdRf1QVY04Y20C1gRGGeA0Z5JMEFkfNsm9AmGh1fj0wEBg86OB09F5zsZ75NxhJFEED5dpbkHSRVJFwnJqkLV82re3Uz7GQMFd7FpgiFM+zqRpMFQS9/ncYptb532L/NQmTRsBzWpn2X4UmUGkIPzVkmGrIA7p7ilSbPuZbdFG1RFUgZsoBzk1NHWZwMoxG36S8gx8jkGf8mzdXqjTQR6Pw9Z+Z+g1kWpY2zsyBLI6At988W9hnbqeYWZ+1XUu5PyRL+ktO2Wh26Q1U9UphU2KgkEEE018AI10dfHMwUzXdTv1HSUVPeGv8bSqo830uW6SB/luJJfD5KOjh8GBns5beLVyyKEYEE5KKF8CSGBk/gLXzhZuw2z7d
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(316002)(54906003)(6916009)(36756003)(70206006)(70586007)(4326008)(8936002)(8676002)(83380400001)(16526019)(426003)(2906002)(336012)(47076005)(26005)(36860700001)(41300700001)(44832011)(1076003)(2616005)(5660300002)(82740400003)(356005)(40480700001)(478600001)(81166007)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:46.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e54dc2c-d889-488b-ecf2-08dbe613528a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
A number of DML parameters related to HostVM were either missing or
being set incorrectly, which may cause inaccuracies in calculating
margins and determining BW limitations.

[How]
Correct these values where needed and populate the missing values.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  | 35 +++++++++++++++++--
 .../display/dc/dml2/dml2_translation_helper.c |  9 +++--
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 21c17d3296a3..149cb1c1b525 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -330,8 +330,39 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 	dml_init_instance(&dc->dml, &dcn3_5_soc, &dcn3_5_ip,
 				DML_PROJECT_DCN31);
 
-	/* Update latency values */
-	dc->dml2_options.bbox_overrides.dram_clock_change_latency_us = dcn3_5_soc.dram_clock_change_latency_us;
+	/*copy to dml2, before dml2_create*/
+	if (clk_table->num_entries > 2) {
+
+		for (i = 0; i < clk_table->num_entries; i++) {
+			dc->dml2_options.bbox_overrides.clks_table.num_states =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dcfclk_mhz =
+				clock_limits[i].dcfclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].fclk_mhz =
+				clock_limits[i].fabricclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dispclk_mhz =
+				clock_limits[i].dispclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dppclk_mhz =
+				clock_limits[i].dppclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].socclk_mhz =
+				clock_limits[i].socclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].memclk_mhz =
+				clk_table->entries[i].memclk_mhz * clk_table->entries[i].wck_ratio;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_fclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dispclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dppclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_socclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_memclk_levels =
+				clk_table->num_entries;
+		}
+	}
+	dc->dml2_options.bbox_overrides.dram_clock_change_latency_us = dcn3_5_soc.dram_clock_change_latency_us * clk_table->entries[i].wck_ratio;
 
 	dc->dml2_options.bbox_overrides.sr_exit_latency_us = dcn3_5_soc.sr_exit_time_us;
 	dc->dml2_options.bbox_overrides.sr_enter_plus_exit_latency_us = dcn3_5_soc.sr_enter_plus_exit_time_us;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 48caa34a5ce7..fa8fe5bf7e57 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -1057,9 +1057,12 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 	}
 
 	//Generally these are set by referencing our latest BB/IP params in dcn32_resource.c file
-	dml_dispcfg->plane.GPUVMEnable = true;
-	dml_dispcfg->plane.GPUVMMaxPageTableLevels = 4;
-	dml_dispcfg->plane.HostVMEnable = false;
+	dml_dispcfg->plane.GPUVMEnable = dml2->v20.dml_core_ctx.ip.gpuvm_enable;
+	dml_dispcfg->plane.GPUVMMaxPageTableLevels = dml2->v20.dml_core_ctx.ip.gpuvm_max_page_table_levels;
+	dml_dispcfg->plane.HostVMEnable = dml2->v20.dml_core_ctx.ip.hostvm_enable;
+	dml_dispcfg->plane.HostVMMaxPageTableLevels = dml2->v20.dml_core_ctx.ip.hostvm_max_page_table_levels;
+	if (dml2->v20.dml_core_ctx.ip.hostvm_enable)
+		dml2->v20.dml_core_ctx.policy.AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter;
 
 	dml2_populate_pipe_to_plane_index_mapping(dml2, context);
 
-- 
2.42.0

