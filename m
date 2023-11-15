Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2675C7ECEAD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjKOTo1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjKOTo0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:26 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9629E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPqi279BeugB1Ys3lzFFv/VqaAOPfzS6gnO/umOsjPABQGdiDF2Q/Gklh1YhN9km+WgsAd2jUGD6hFAorBDzfBa3ukgVBuB3yYbGRgh1H84BcxLEF5jyWkHLgYRmtTkAPX+dEYsEcbaMgk5LjyKTJTPs6+i3rGddOzCQl+vacCag93Ku+8MArdrSQuBVKaWI3haQT3wbd4nBWihBO6jl6hfnAgpfMy4VXnjF6OWgfpr2f/C+ud1sCSfhDmCFLwfck6ZaCDeeLOGg/sUb8tEIob2cGrL+Pa6caE41MTIh4aDxKCWE4d3mmb3sWac2XVgWMgQkFTts1oXk6WC3AdhOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0JRzzvGMbcNlAMOZG+qesTWPAxNj4MojAmOsAN+L88=;
 b=avAiYyB7evJjMWOO6O+B1nZmPU/Kx/Wb5SwaPxXG8VCuKT4sF9gDwZV2ByQ4Cj9L4gSHviB34jEzqtcdEnPlQBQStkPLQFO7YBk0vOy38RunCc2P+ULwY/z1Y/9XXWscStqUltq+v95ziZc0fG+bRc8pzRXBU06xJLdBLNgtbBUWlb0SdJD1NPzCx0PcFdC1uc4zXRnkGXnlfryN2W6VZf9D5rOHu3LueGwQ4v4wtp6JuE0ULUWqsDWcKN7U/Vo9eoF+3nxr/ucRdDIUBa65iaGSKB/RhXPO5CkxpExhQJ+Rwfaqot2jVp61WQKYlw/mYnRi2MhcPAtQF22TfqssJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0JRzzvGMbcNlAMOZG+qesTWPAxNj4MojAmOsAN+L88=;
 b=rqny3M8dC1oufm/IzGmQbH/4INRzAwePsTKjSnYseWhQvyw+v0SuzkfsPMtwhpSNaHgNWROhKID78MNROCgJutm7AQHCnZ9huTeFhZCZIDGkWys8YuvJ26Fzi2LEYlJBE2B3uKtt2c8G1hy72DkD0FhBZHnOE0N/Ah7nB4iZZ4U=
Received: from MN2PR15CA0039.namprd15.prod.outlook.com (2603:10b6:208:237::8)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:44:15 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::c0) by MN2PR15CA0039.outlook.office365.com
 (2603:10b6:208:237::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:15 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:13 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>, <stable@vger.kernel.org>,
        Chaitanya Dhere <chaitanya.dhere@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 06/35] drm/amd/display: fix a pipe mapping error in dcn32_fpu
Date:   Wed, 15 Nov 2023 14:40:19 -0500
Message-ID: <20231115194332.39469-7-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9c2c2d-a64b-4694-b6ca-08dbe6133fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFmFyMmoG2nYP1NzyKO/qsAKUbTAtKw2DbJbaKQ+grmDUqlS0oibQn41FBRgfx2+SrsrAiKeaN9yIpY6UVKrpvD2lvmayFI10SesVRkRhOWdQNz2TFLq9F1NbyJgPZyu9RYQ8TOQiLev5VNbfw53RCSJe5tEYBWoESOEiX9n598iI+ErdacHcm+QKBBhih3SAC2XC8NLzTDTUNtyObfPSGi1+z+ijppYLebPiX/+BWwTh6DHA6j8RzRyCpw+sBCZvC3tLY8JDxBrqqPkiDXKACTi1wAbImgfSB67pHkFIGFZKwKllqZId00OvAs2bEx66dGE8RejIxmKRPYDGaRGp1HoWGALnTEXYJOnE8uSnmGaPPHBrfjlodznxXkUD3AbgmUz9JGnwuX/vh3VXEDihyxNfNSnxuvIAbQIhUIb5qft+GXUqM/JVhS13hTCo42Ez5uCCbkEjLYNVBmDqwrEupFOxMtB6zokemMNfWOr02b7Gys/0DYBpjcMIes2Zh8ypOzx2vdXvjzGSEz2aZIFtBOJL3gZafH7ZfTLIPAdqxhUkwq0ZHiionLWwrx56/xl5JH+4z/YyASam7iGZxK19tobgP70/5Y5rrPWomJtD3OUPh/JW+vW2/+vxtnx6Ho30/5i1U63VXTLK2OyuGhvKtpHCwk0LXwglQ6ZjGw2O99Z4T1uny9dHDaGUbFjQusCObpciOWp2KkLIc5SBdtjifO2LCMe3N0CVh0a84RWDa4Nu3utWwhREcN0EiuBrpkzGV5xEgN7Xkagr8j0WsbDcWWdR6bepTihQF88pHjm2dk4IAfhxdxjcZunT7W8wEZL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(36860700001)(81166007)(2906002)(356005)(5660300002)(86362001)(44832011)(336012)(16526019)(426003)(83380400001)(82740400003)(1076003)(26005)(2616005)(41300700001)(36756003)(478600001)(6916009)(70586007)(316002)(70206006)(8936002)(54906003)(4326008)(8676002)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:15.2326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9c2c2d-a64b-4694-b6ca-08dbe6133fd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
In dcn32 DML pipes are ordered the same as dc pipes but only for used
pipes. For example, if dc pipe 1 and 2 are used, their dml pipe indices
would be 0 and 1 respectively. However
update_pipe_slice_table_with_split_flags doesn't skip indices for free
pipes. This causes us to not reference correct dml pipe output when
building pipe topology.

[how]
Use two variables to iterate dc and dml pipes respectively and only
increment dml pipe index when current dc pipe is not free.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9ec4172d1c2d..44b0666e53b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1192,13 +1192,16 @@ static bool update_pipe_slice_table_with_split_flags(
 	 */
 	struct pipe_ctx *pipe;
 	bool odm;
-	int i;
+	int dc_pipe_idx, dml_pipe_idx = 0;
 	bool updated = false;
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &context->res_ctx.pipe_ctx[i];
+	for (dc_pipe_idx = 0;
+			dc_pipe_idx < dc->res_pool->pipe_count; dc_pipe_idx++) {
+		pipe = &context->res_ctx.pipe_ctx[dc_pipe_idx];
+		if (resource_is_pipe_type(pipe, FREE_PIPE))
+			continue;
 
-		if (merge[i]) {
+		if (merge[dc_pipe_idx]) {
 			if (resource_is_pipe_type(pipe, OPP_HEAD))
 				/* merging OPP head means reducing ODM slice
 				 * count by 1
@@ -1213,17 +1216,18 @@ static bool update_pipe_slice_table_with_split_flags(
 			updated = true;
 		}
 
-		if (split[i]) {
-			odm = vba->ODMCombineEnabled[vba->pipe_plane[i]] !=
+		if (split[dc_pipe_idx]) {
+			odm = vba->ODMCombineEnabled[vba->pipe_plane[dml_pipe_idx]] !=
 					dm_odm_combine_mode_disabled;
 			if (odm && resource_is_pipe_type(pipe, OPP_HEAD))
 				update_slice_table_for_stream(
-						table, pipe->stream, split[i] - 1);
+						table, pipe->stream, split[dc_pipe_idx] - 1);
 			else if (!odm && resource_is_pipe_type(pipe, DPP_PIPE))
 				update_slice_table_for_plane(table, pipe,
-						pipe->plane_state, split[i] - 1);
+						pipe->plane_state, split[dc_pipe_idx] - 1);
 			updated = true;
 		}
+		dml_pipe_idx++;
 	}
 	return updated;
 }
-- 
2.42.0

