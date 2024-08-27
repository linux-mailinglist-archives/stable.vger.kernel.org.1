Return-Path: <stable+bounces-71330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BDC961453
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F961F24900
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67B54767;
	Tue, 27 Aug 2024 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hcKnm/ul"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5EB1CDA1D
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776887; cv=fail; b=rIt1v9s9WRDnHwB7IKpFaRvgri0G+tbwqzsU6I8yEzDAyfZCY11vX2o6dFcyXb/LuKRIgDLBU0FzyhYzhEvByOxWgjk0F/Iv4/PBbS9oyT4FkxBrVIm+n7zSZTQIEl3DIfmGIfwX54FaLWJnKALrvT0aWDTfexvvCQv/7yXIaoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776887; c=relaxed/simple;
	bh=ktqiBCnVsDLalg/Xm6jiebdiOoh2fueo+tl8C2t+rGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+pgqtFDpGpJ++sjF9wp3z7yuCiPD5xitRC9LtWXFc0LFjxLClt/s2IcapJBxQ3MMcPCigW4bTkyIZSfWiRQhl/tnArQQXitQR+Jw5jgzd9K8Td49fKwEDpP/RIlRkmU8ihNVAjoJWhSDt+7d5w5cXLs7sVzQvqJ47dSAJG0Vzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hcKnm/ul; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+DEaBxh2mSVmkSArxERBXentCA7Cp1l8EgrqRPVOEzARTzM6IHUxOzCBXuh0D+cKg33zrkCtZY6t4ZIhNYV7qZQOHA+E7PwwxvSzkot/OjOeIxzzKQmUm39VOoJSHVqdqyNj2qiTW07Vw8b3BDXC4juh28pcyIfNH/VQCDRtM9Y06gWpMbAMBosr4w+9/uP9ZSC/iXcjHY4gekZ0uWqJRguVqTxZCe6iOyNLPtH5eBONL7TGmmreI7Q+Wjk1HygdsnkplR/aaMbb0+Eq/AaZQtIo075mdY6rg5xzAbFZU3+nmfXHcStoOD7P2Jiv8+35BnTUKmXJOzZ14GE8aDwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijdrDkPRYB552uz6vb52jwIQQDBNDaXmykAQTGCQpDA=;
 b=vazQlg5jPy5J0Jot4dPgttTuMqzEr46JA/YvmI+CKX9xHFQxnFZ8eTXKn2q0RFmBdANbf47mi/zuHeA66bRM9xAZxcY8h9sM8Day0wYSQZfN1E6MOJov12B1rpPvsJC3rBwhN7gsthFH+XASoFaUeLSd9L2/FVOVv1w3uf6kGwyOZGkuv/CrIyKOjEDFkkFvbZYoHGZCgN7hIxfIa5XLxkXFRSdCIkEcIGflTiiRwvPrDJW0d9ABv6ilTW4Zc+tUkEvsHxHCDKfpLjUhEMqugAQauATYybHdVBBSWm3Fk3VwhUfmoBxztGl6JO142bC36X5zf53TOHzWRM2SYNDm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijdrDkPRYB552uz6vb52jwIQQDBNDaXmykAQTGCQpDA=;
 b=hcKnm/ulpQH6MIkueXRc06jV8iEYg7wyQpFo4jHZFel1pIudr7MrevIWkk2de6fUnW2Chos/jPdtEqmA2KiFFSSRneTgtvlVfyy0TjiKswG8qPBYYkjpffGTJfgekyyiQhUv7zhQXpX0hDcbbz6zt7iOR/VRELMF4nt3vQc9tzA=
Received: from BN9PR03CA0712.namprd03.prod.outlook.com (2603:10b6:408:ef::27)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Tue, 27 Aug
 2024 16:41:17 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::e1) by BN9PR03CA0712.outlook.office365.com
 (2603:10b6:408:ef::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:17 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:13 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
	<aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
	<roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Gabe Teeger
	<Gabe.Teeger@amd.com>, <stable@vger.kernel.org>, Sung joon Kim
	<sungjoon.kim@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 11/14] drm/amd/display: fix graphics hang in multi-display mst case
Date: Tue, 27 Aug 2024 12:37:31 -0400
Message-ID: <20240827164045.167557-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: cabc3389-fd46-4cd4-6b9a-08dcc6b712bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vs5JdWOyp5m7pHfWAV1d8VSxXHnwywaHLJmGvagiAsMt2Xgo0oRjX8dOy5aZ?=
 =?us-ascii?Q?T7BS/jqHWFKA4LDRD7/nkxZhSq2xo1rKRZS4YMsVap7NPWhPXixmhqtlQDwF?=
 =?us-ascii?Q?gFKdE21DP/K/t4BeNr9hj7erAj+cXc3f+Glb56UzIMGCh7g0DZncOICFKHfz?=
 =?us-ascii?Q?lP4iaS4+ASNr9OLDD2HtK8RpVCuLl9iEeJFVgli2v/yOjZ04NulAyfivItXe?=
 =?us-ascii?Q?d97SOJhYS3lL2HaZutNspRGD3GdN0KG+vSamgrUmQG28Q5FzGL3X0GK/OoGO?=
 =?us-ascii?Q?wwbawM2au9iR98kZT8WbHG5P+3karPTHmMPsyYDnd4sK9mO6Gr8hLwI+8ja/?=
 =?us-ascii?Q?kuAi/LktYdRLFOXCbK0AfbY1ND3Nm1a00L03bqI1Lfm5Nf1NolUIO6vSBPuS?=
 =?us-ascii?Q?+1pUkqwvuY0ZkY2BnnNvzUkVNnyJ1Q9+nT5Zm4hW0Umh8H9zla9WZdGVOMne?=
 =?us-ascii?Q?tw6S4phaaYlsvUUkEUWR8S3x67seKU1MZIW9VdMOaw9KenUq7XedI8i33jBm?=
 =?us-ascii?Q?MkxRK7+HV382ZR9Q2wYYgOFBFfKkQzLjShvq4tjEQbkNgbPIoQ9qkq+2OC5u?=
 =?us-ascii?Q?hSkIUNgNUKUekJumEQqPO8sjQ8YKepRX9k8MKUPPbuO66SYS8aPERpXGYyzb?=
 =?us-ascii?Q?rYWMh3/jSYIa2ssHBIel9pZsMSWQ3Ii1Tr/M2K9V9xJi79fP1ppnu1xwOpPh?=
 =?us-ascii?Q?161eVKp7iegy77OIqWprQ+W5/qvHuCU35skRXQ2whuy5M5awHAYRdW01lWIP?=
 =?us-ascii?Q?Mvw7ZWv753LAGLwr/BAy25ZVwYkmAeGVQGMF37fVg/VZUMBF3BD3IclTA5OR?=
 =?us-ascii?Q?5o0rvauViPZWej2g4UhjOTlbxyau+me7bBD3NCKh1HzSV/GnVbWonTvQkNNw?=
 =?us-ascii?Q?afEUHLJGDrsh2uUverSBWjBRrWUtdzBYxrxmSl5MYFs8y6Pfg7h8i17JpbGE?=
 =?us-ascii?Q?V2cJxCqIFZnO7XRVynswYIL8UTSrYgsLRkVSL0msYMdQT8u342bef1w5AZ95?=
 =?us-ascii?Q?K617pzIdsTAEBdUE5kMLq0MAlzTB3gj/gWkmS3pKlxdJSZNqk/lynwDmD19k?=
 =?us-ascii?Q?stmk75iyxGf4cwPDvdKlNnSBQDsmYF9C1JupQOJ4yrtPwqpgaco05drb2ukD?=
 =?us-ascii?Q?N8wRx6vnsWw7UNDpMv6YwKNbnGyuTlwIU9rJzngUl31a0CztzSXF9CWCpYoD?=
 =?us-ascii?Q?KKgjfAz0jKaGTUWn02M2yRUomkKA/z9ASPT7TbQ9h/bsOjRUKPjXbkzEABbD?=
 =?us-ascii?Q?YjSqwgcFiVgFgRcHyYmCREHVi6vg3Sl6MFNLx8OfTTmLGp8SqO9X5Mc68IOT?=
 =?us-ascii?Q?8qpZSNK3eL28lIirfSSmhcai2jAdefO5Do3JpEn/peQ5mvm2KTW4w+/tnhjN?=
 =?us-ascii?Q?Dbo0S1x3mDzD/r0UxeG/A+c4skqQ0+i6Gjp8UNYdcz95Cj0ywd79PjLZ4Y80?=
 =?us-ascii?Q?k577IGAGDSjyNBR/EqWiiFQ512Hf1JPH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:17.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cabc3389-fd46-4cd4-6b9a-08dcc6b712bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837

From: Gabe Teeger <Gabe.Teeger@amd.com>

[what]
Graphics hang observed with 3 displays connected to DP2.0 mst dock.

[why]
There's a mismatch in dml and dc between the assignments of hpo link
encoders.

[how]
Add a new array in dml that tracks the current mapping of HPO stream
encoders to HPO link encoders in dc.

Cc: stable@vger.kernel.org
Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Gabe Teeger <Gabe.Teeger@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../amd/display/dc/dml2/dml2_internal_types.h |  2 +-
 .../display/dc/dml2/dml2_translation_helper.c | 67 +++++++++----------
 .../display/dc/dml2/dml2_translation_helper.h |  2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  | 12 +---
 4 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
index 3ba184be25d3..140ec01545db 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
@@ -101,7 +101,7 @@ struct dml2_wrapper_scratch {
 	struct dml2_dml_to_dc_pipe_mapping dml_to_dc_pipe_mapping;
 	bool enable_flexible_pipe_mapping;
 	bool plane_duplicate_exists;
-	unsigned int dp2_mst_stream_count;
+	int hpo_stream_to_link_encoder_mapping[MAX_HPO_DP2_ENCODERS];
 };
 
 struct dml2_helper_det_policy_scratch {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 7e39873832bf..bde4250853b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -733,8 +733,7 @@ static void populate_dml_timing_cfg_from_stream_state(struct dml_timing_cfg_st *
 }
 
 static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *out, unsigned int location,
-				const struct dc_stream_state *in, const struct pipe_ctx *pipe,
-				unsigned int dp2_mst_stream_count)
+				const struct dc_stream_state *in, const struct pipe_ctx *pipe, struct dml2_context *dml2)
 {
 	unsigned int output_bpc;
 
@@ -747,8 +746,8 @@ static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 	case SIGNAL_TYPE_DISPLAY_PORT:
 		out->OutputEncoder[location] = dml_dp;
-		if (is_dp2p0_output_encoder(pipe, dp2_mst_stream_count))
-			out->OutputEncoder[location] = dml_dp2p0;
+		if (dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[location] != -1)
+			out->OutputEncoder[dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[location]] = dml_dp2p0;
 		break;
 	case SIGNAL_TYPE_EDP:
 		out->OutputEncoder[location] = dml_edp;
@@ -1199,36 +1198,6 @@ static void dml2_populate_pipe_to_plane_index_mapping(struct dml2_context *dml2,
 	}
 }
 
-static unsigned int calculate_dp2_mst_stream_count(struct dc_state *context)
-{
-	int i, j;
-	unsigned int dp2_mst_stream_count = 0;
-
-	for (i = 0; i < context->stream_count; i++) {
-		struct dc_stream_state *stream = context->streams[i];
-
-		if (!stream || stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST)
-			continue;
-
-		for (j = 0; j < MAX_PIPES; j++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
-
-			if (!pipe_ctx || !pipe_ctx->stream)
-				continue;
-
-			if (stream != pipe_ctx->stream)
-				continue;
-
-			if (pipe_ctx->stream_res.hpo_dp_stream_enc && pipe_ctx->link_res.hpo_dp_link_enc) {
-				dp2_mst_stream_count++;
-				break;
-			}
-		}
-	}
-
-	return dp2_mst_stream_count;
-}
-
 static void populate_dml_writeback_cfg_from_stream_state(struct dml_writeback_cfg_st *out,
 		unsigned int location, const struct dc_stream_state *in)
 {
@@ -1269,6 +1238,30 @@ static void populate_dml_writeback_cfg_from_stream_state(struct dml_writeback_cf
 		}
 	}
 }
+
+static void dml2_map_hpo_stream_encoder_to_hpo_link_encoder_index(struct dml2_context *dml2, struct dc_state *context)
+{
+	int i;
+	struct pipe_ctx *current_pipe_context;
+
+	/* Scratch gets reset to zero in dml, but link encoder instance can be zero, so reset to -1 */
+	for (i = 0; i < MAX_HPO_DP2_ENCODERS; i++) {
+		dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[i] = -1;
+	}
+
+	/* If an HPO stream encoder is allocated to a pipe, get the instance of it's allocated HPO Link encoder */
+	for (i = 0; i < MAX_PIPES; i++) {
+		current_pipe_context = &context->res_ctx.pipe_ctx[i];
+		if (current_pipe_context->stream &&
+			current_pipe_context->stream_res.hpo_dp_stream_enc &&
+			current_pipe_context->link_res.hpo_dp_link_enc &&
+			dc_is_dp_signal(current_pipe_context->stream->signal)) {
+				dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[current_pipe_context->stream_res.hpo_dp_stream_enc->inst] =
+					current_pipe_context->link_res.hpo_dp_link_enc->inst;
+			}
+	}
+}
+
 void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg)
 {
 	int i = 0, j = 0, k = 0;
@@ -1291,8 +1284,8 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 	if (dml2->v20.dml_core_ctx.ip.hostvm_enable)
 		dml2->v20.dml_core_ctx.policy.AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter;
 
-	dml2->v20.scratch.dp2_mst_stream_count = calculate_dp2_mst_stream_count(context);
 	dml2_populate_pipe_to_plane_index_mapping(dml2, context);
+	dml2_map_hpo_stream_encoder_to_hpo_link_encoder_index(dml2, context);
 
 	for (i = 0; i < context->stream_count; i++) {
 		current_pipe_context = NULL;
@@ -1313,7 +1306,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 		populate_dml_timing_cfg_from_stream_state(&dml_dispcfg->timing, disp_cfg_stream_location, context->streams[i]);
-		populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_stream_location, context->streams[i], current_pipe_context, dml2->v20.scratch.dp2_mst_stream_count);
+		populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_stream_location, context->streams[i], current_pipe_context, dml2);
 		/*Call site for populate_dml_writeback_cfg_from_stream_state*/
 		populate_dml_writeback_cfg_from_stream_state(&dml_dispcfg->writeback,
 			disp_cfg_stream_location, context->streams[i]);
@@ -1378,7 +1371,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 
 				if (j >= 1) {
 					populate_dml_timing_cfg_from_stream_state(&dml_dispcfg->timing, disp_cfg_plane_location, context->streams[i]);
-					populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_plane_location, context->streams[i], current_pipe_context, dml2->v20.scratch.dp2_mst_stream_count);
+					populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_plane_location, context->streams[i], current_pipe_context, dml2);
 					switch (context->streams[i]->debug.force_odm_combine_segments) {
 					case 2:
 						dml2->v20.dml_core_ctx.policy.ODMUse[disp_cfg_plane_location] = dml_odm_use_policy_combine_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
index 55659b22d87f..d764773938f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
@@ -36,6 +36,6 @@ void dml2_translate_socbb_params(const struct dc *in_dc, struct soc_bounding_box
 void dml2_translate_soc_states(const struct dc *in_dc, struct soc_states_st *out, int num_states);
 void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg);
 void dml2_update_pipe_ctx_dchub_regs(struct _vcs_dpi_dml_display_rq_regs_st *rq_regs, struct _vcs_dpi_dml_display_dlg_regs_st *disp_dlg_regs, struct _vcs_dpi_dml_display_ttu_regs_st *disp_ttu_regs, struct pipe_ctx *out);
-bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe, unsigned int dp2_mst_stream_count);
+bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe);
 
 #endif //__DML2_TRANSLATION_HELPER_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 9e8ff3a9718e..9a33158b63bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -153,7 +153,7 @@ unsigned int dml2_util_get_maximum_odm_combine_for_output(bool force_odm_4to1, e
 	}
 }
 
-bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx, unsigned int dp2_mst_stream_count)
+bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx == NULL || pipe_ctx->stream == NULL)
 		return false;
@@ -161,14 +161,6 @@ bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx, unsigned int dp2_m
 	/* If this assert is hit then we have a link encoder dynamic management issue */
 	ASSERT(pipe_ctx->stream_res.hpo_dp_stream_enc ? pipe_ctx->link_res.hpo_dp_link_enc != NULL : true);
 
-	/* Count MST hubs once by treating only 1st remote sink in topology as an encoder */
-	if (pipe_ctx->stream->link && pipe_ctx->stream->link->remote_sinks[0] && dp2_mst_stream_count > 1) {
-		return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
-			pipe_ctx->link_res.hpo_dp_link_enc &&
-			dc_is_dp_signal(pipe_ctx->stream->signal) &&
-			(pipe_ctx->stream->link->remote_sinks[0]->sink_id == pipe_ctx->stream->sink->sink_id));
-	}
-
 	return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
 		pipe_ctx->link_res.hpo_dp_link_enc &&
 		dc_is_dp_signal(pipe_ctx->stream->signal));
@@ -181,7 +173,7 @@ bool is_dtbclk_required(const struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
-		if (is_dp2p0_output_encoder(&context->res_ctx.pipe_ctx[i], context->bw_ctx.dml2->v20.scratch.dp2_mst_stream_count))
+		if (is_dp2p0_output_encoder(&context->res_ctx.pipe_ctx[i]))
 			return true;
 	}
 	return false;
-- 
2.46.0


