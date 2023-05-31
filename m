Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95CA7175DD
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 06:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjEaEtG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 00:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEaEtF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 00:49:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE342C0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMBoKlzQNzO9eT49YE7MS417rTIlIEsPUJ9T8fGMy2iS16WmIC5Bi+7YwKQmNgrCMT3YQguERF74WuK3UxkrnIMnkzLbgQltWS8+sezvba2bpeeyOn0tS5Byp7vlxplPXWxomyppQ0I//w3qYlo9j/s90PGiJromAlJ+LOUSgO1VcRlPzNQx6vMYAJlFMyDQ7GY+Ac8yuWh/UnyEl0MNQw9R4re2wijaAu5d9WJljiAUf1V8CEUhUIwIBDfKX784jdM4YdrtF0RpfYDzVtJQSGIn6y+S9HYl8HjkLxiTjBG9DEBJeOo0kuq802W2kbaNNFXdDfLB59Dei5rmqHOsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzzLyS8suUIv3yZ7mk6TMDRDe/me+P1kr/ZMUNJ75Z8=;
 b=EaTfgcKzLdT6CV2KLARyeFtfo2aIwjLQucN0yqeoucOJth5GB73WMRPvbwqTYr2EXPJeFVL5955GJFyg+AOym179qkEeXPLSEHaC/jKFe8O5Ul6O107yBvbsLWkLVaP0M+gT7vmjSBfbgO3J+aclCeBf4mizDU1TTw2P2TsX3NjzGHCIzSctUhm1jYlXZrFlJlvuI52QWyJvwSO5kQFXS9Xe2W0uEH9eeCqupaOUAQVIbP2WnQswuGscz9Y39KPH27rdJPPh3+gGOCIj8Ov11QGBNmEPuS+ejQYIBQ+SDfkJWaYYheyh6jBCWnDyh2fxvmegBoDzi0D9ZkIMTrqoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzzLyS8suUIv3yZ7mk6TMDRDe/me+P1kr/ZMUNJ75Z8=;
 b=WAjL/L4W1qEOpN1jBHG7ba/T4uDJnN8YbwiOCFnjrT25DA3epNhLLcDNzDsCRJwgf4Tbdr7cuw/YBceL2f2StAXJcCiVNEBWFvCRMAEQL5I+N/0vuEYPRQm4mWMdg8apO8yhYTJcl6NTp+JQ3meJ4DpQ7WWtnKsfqwQuJU6i1dg=
Received: from BN8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:ac::32)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 04:49:00 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::b0) by BN8PR07CA0019.outlook.office365.com
 (2603:10b6:408:ac::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:00 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:48:55 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>,
        Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, "Charlene Liu" <Charlene.Liu@amd.com>
Subject: [PATCH 03/14] drm/amd/display: fix dcn315 single stream crb allocation
Date:   Wed, 31 May 2023 12:48:02 +0800
Message-ID: <20230531044813.145361-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fd2e23-4e62-45c7-4d3e-08db619259b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zy2VCtpxLa0GKBl2MpKxDqyRGaPDatIkpBSC8AY4UzSxXKuLTMLaAtOA+KjuUNXHDrvD2lU9llzgRUWC4qnD6NEapB1YwuLX6daMIcwoeO/K83R9Em0tWdy8Udb8/I31U/YINsB8DivxAJKaki2dcjR02oe7ktn6GC7nuWv7gHim7Nbds3aIVrh866jsFTpDQXnXku9f0oxe5GwbPlN43PBrtKI/2PtA2Epj6lTFWZyNy8xvHw22JA25XsRpg4laKN4GkoMsnNMzg3TePSjEbN4S6L1hPRJO96f2Ng/ezBUpoa2BeAYQoBJaVm0hBuPgfHolWaZAxEJwJAQaNDlhFbloMD1BATLFHIPi4k3YajvNZvy3e906LdhRNPZ1g8vVYt5G2E1NukY451MalhXaDSZz0y7N9J2vnatFbqqGidAVCIyW6GRnj5g3XnNN5vEZuDZsRDuJ60f1sAlRymsXcleWyA1AGTugiOwk6MggeJv7VIONE5JllNP1PrarJi33u54qX6HrXcrtHk3ajreKkDnXk54CJXKsANKQbdwWguXRtNcOwCO2Yllq8cTs21LmqFTJgeIMdDCNPecpVuYvWfMWW8rw/+rV62kNNwO+Q9K6hp3d0Kvu1rjHesIHkrANDfd9cu7JE3D/2C6mUTWk9RGn6p1JxltUPSZYfTOxJT3r1wtVQACmoDujtFOjE1KzqIAvRpwQxHLxCl+8Z3ZqM6Pd4IQDGhx0iJlKQdyHBS+Nid/4/ZKJr++88KDA5Kiz03NPYBMW7f6rNIXNpMrTwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(36860700001)(2906002)(336012)(426003)(86362001)(47076005)(70206006)(81166007)(4326008)(41300700001)(83380400001)(70586007)(356005)(6916009)(36756003)(186003)(82740400003)(44832011)(2616005)(1076003)(26005)(8936002)(8676002)(40460700003)(5660300002)(82310400005)(7696005)(478600001)(6666004)(316002)(40480700001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:00.0590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fd2e23-4e62-45c7-4d3e-08db619259b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Change to improve avoiding asymetric crb calculations for single stream
scenarios.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dcn315/dcn315_resource.c   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index cb95e978417b..8570bdc292b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1628,6 +1628,10 @@ static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
 	int i;
 	struct resource_context *res_ctx = &context->res_ctx;
 
+	/*Don't apply for single stream*/
+	if (context->stream_count < 2)
+		return false;
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
@@ -1727,19 +1731,23 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipe_cnt++;
 	}
 
-	/* Spread remaining unreserved crb evenly among all pipes, use default policy if not enough det or single pipe */
+	/* Spread remaining unreserved crb evenly among all pipes*/
 	if (pixel_rate_crb) {
 		for (i = 0, pipe_cnt = 0, crb_idx = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &res_ctx->pipe_ctx[i];
 			if (!pipe->stream)
 				continue;
 
+			/* Do not use asymetric crb if not enough for pstate support */
+			if (remaining_det_segs < 0) {
+				pipes[pipe_cnt].pipe.src.det_size_override = 0;
+				continue;
+			}
+
 			if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
 				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
 						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
 
-				if (remaining_det_segs < 0 || crb_pipes == 1)
-					pipes[pipe_cnt].pipe.src.det_size_override = 0;
 				if (remaining_det_segs > MIN_RESERVED_DET_SEGS)
 					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
 							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
@@ -1755,6 +1763,7 @@ static int dcn315_populate_dml_pipes_from_context(
 				}
 				/* Convert segments into size for DML use */
 				pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
+
 				crb_idx++;
 			}
 			pipe_cnt++;
-- 
2.40.1

