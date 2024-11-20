Return-Path: <stable+bounces-94074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5CB9D316D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 01:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF8CB220AE
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75C4A23;
	Wed, 20 Nov 2024 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z8DqRkZt"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99DFAD27
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062779; cv=fail; b=aLTVOIY8QZFSizng/GmIPL6R6IQPe0UzyjLkHy/Ri8BiDlE3QHLriqKEn8rZ7Bu08tLWfaM66NzNjijsb5OJ+EtOTuRjYgbZEWT/EdPu2H2SH+fKXniLWJLJzZMC5IFICKgNwHQiYTiLWByxrfZ8Q8U5ArAmqbQ2ypMSwqF7Ea4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062779; c=relaxed/simple;
	bh=9JYQAFyS1D9X0oPeDGw6xp9yj4atVSJtZeEuOJ/9oiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOypvFcyHXwYEFMk0oE4pxIC0YGv8gANR16EWhbwDm9uh7/mwh4+wbCqyurYQWGq4+Dh1v0bTljWC/PVaHdwfB4TdwTwUoC5n1uVJqhaCm9XTJu4sULPkTeRsdWctE+jj9MUTIqP0OLMPSMO829aa1Bp8Xunz8jyvcr4C5r1uIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z8DqRkZt; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBPdzjq0VeufBYq4uR1k7EQdYa2jh3d1Rt1wBtdqfAm8Z2QuA0vpJ258fc7jS59ePp5yuTDqqAFmYGCQcrCW0AKjeERndhmwaGxpBu/fuJIUY4y76BVNE5jVvgbI2qAZAhFuAJ6tyDoES3vsKwjCSkt9E8TXSAN/zNExo9uqctWkqeWxzZGs30h5zhRaQpcyDW+2X/KeknIPPPdMRScH5zvC37LNUc7KcqiSUMp138S4gkOx6Y/GjiWFhbi5N36rPpNLTgY3c3sikw2s/5GnN1VRC6wky0t7BjJz+1WBbnCGjJi/KOdUfDqyfwPK4XFpwub0kxKCeRfPh06+7qFyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3uhmt0DYi7N57q+qG7wM1hDF5bYEyQYRInv9oI1mHI=;
 b=RStxyCfar8ZwHbLuL2gRLx70gqD9FzhOCRQOsR0hOhLy8OyEFNz0TlXJy7ZPI1hD3wYls3dKBbFx1PymCKURGpbDs5ikz09bxkO2iSZFTPGy6iUZyp+aMPLuXy2sY416gcfE3ap3Lw/GUFbf0zeFJINEa5cJvXTbApIYCFhxrGBdGuU88qW4zJ4zgXekcaOOg+ckGO7xF4QvOiVbVPT0P+qmxCf22XKxh8yPO/eMmZ39G67edsE+xVg3Iu97VGUR4EKyk1ekTayCUFTX+AF+GeMNHtvc4O6NRDo4FalT6bh+nyAtfVA051r0GfYhqxxZ4OcjFgCpNB7N3AwuE3BLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3uhmt0DYi7N57q+qG7wM1hDF5bYEyQYRInv9oI1mHI=;
 b=z8DqRkZtxMZ2Mp52CfaUGQGgw5WROVvTxooPJXYwcKJgzlBETkegJuzv6sxu4pYXKXT12w0Ju/VBjApY9q13FZnfgY/mkPVx0WMQBYvsellxMxEzMkcV1MgB+/Tfvd7xUF3pH8qZd80ZJ05LPuC/b2JNgN9jtW9wHPxMV6BFE5Q=
Received: from PH7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:510:339::13)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Wed, 20 Nov
 2024 00:32:53 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::a0) by PH7PR03CA0016.outlook.office365.com
 (2603:10b6:510:339::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 00:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 00:32:53 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 18:32:50 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
	<jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Peterson Guo
	<peterson.guo@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, George Shen
	<george.shen@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 1/9] drm/amd/display: Add a left edge pixel if in YCbCr422 or YCbCr420 and odm
Date: Tue, 19 Nov 2024 17:28:29 -0700
Message-ID: <20241120003044.2160289-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120003044.2160289-1-alex.hung@amd.com>
References: <20241120003044.2160289-1-alex.hung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 1508d25d-bd41-41d9-5329-08dd08fadf05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AyjYjzNTCx+SYSUiiBxfwzABSlyIQhthSqj6Pd/b6+d8rALK/5YyhSjEBEdF?=
 =?us-ascii?Q?yEBcJL/iFx5q7o1Q181gc7aTXL6XuBro1dW2kYtqySvz3L3lth2YsPbRnDGr?=
 =?us-ascii?Q?yKd2hkONpWYjUXXxcco72ZT/vZuHL9g8cGiAQfx0AwWzGBor5U+dwsFqeg9t?=
 =?us-ascii?Q?iJoJ0FGZYlnmbcZx4lCZ4ch8Rp2hZkEVzNEN8e0pJ3DSOr2v2p9TQu4Dz9BR?=
 =?us-ascii?Q?dx76CrmvR3k6UMxkuMJwXcr/yjmqsaQxxVxEfQoA4tfHdX+zajqfe2RVh3Hg?=
 =?us-ascii?Q?FiEpg9q/O4bQm0OC7zxNbVKPQ/RuIWvo7mJyAbuVj9JM9K+PX4SEaQUSfGvh?=
 =?us-ascii?Q?csjQFmKDHEmBRKXjVqGZ3nqQgsfc6eHqNXYXPRvKuaRxfg3qpXwgGNZqui64?=
 =?us-ascii?Q?rgiIDgCkXMV6lbaPY/fsFMgi/qrc068sQrZST4VNXQUyUeAaxTA7+0YGAWjy?=
 =?us-ascii?Q?h7eRDdwO2OisIlD5SFRSZPGVHQtUbHN17ywCkqcXSFrRcNGGb0FHbwbMJBR/?=
 =?us-ascii?Q?BhRbS2yfnSFWCmeY3YDheyLuV+8Ivo6RFBSJU2LKZfXEhXh+AzEGtVr2UiqS?=
 =?us-ascii?Q?rFsY1x6W50KOmi/FgZpZQ9kRcroSgp47sX/W3qdVhLnd3pEvrnkbsyAfIYR8?=
 =?us-ascii?Q?6siD2hJ3NDWEL9yT75uOlLs5lcfSvXVqcGFOg9RfnMNLNwahwjj721mXdjNG?=
 =?us-ascii?Q?j22ulvll8aieQXD5pgMGHRaoRPQ5r4k0dMN8VV79xzSs7SKV7JtDYazirZRl?=
 =?us-ascii?Q?ESiAKiCG2zs/A1QknS+a2IC3T/Oukssw+LUb+GIkfH5tl691BgVu7Uy6KMFr?=
 =?us-ascii?Q?X0bE1WqGP7Sy2wWoLDNGZhlsl86t5+NlGFCi5MAdeNGIQi69lfdN7nAGZGmb?=
 =?us-ascii?Q?EwG/h2XDCDyOhJdp9YJH5YIpaLlYwtz+FLiNezs6PighmPtNAmIp1sH2mHQF?=
 =?us-ascii?Q?vkwsGEZh5pqr7fwqt9GeD6rIBm1OCRheGbwORjPLMsdcAqL2i9Bj5HbhmCfX?=
 =?us-ascii?Q?Wg7hoOShxvIsb9Pz25PZr3HWvlQYRfZ745zmyK/imaEiO+jR+TVM/RjUfwj+?=
 =?us-ascii?Q?T9XKmnpzxuRng6BKj8AXbRDQQmGN03KBwOAM3O8SImaQzIe/HnI64PvNSXse?=
 =?us-ascii?Q?t59nQJP5jqoih7wUo5H/Tec+8WTyiEzr0rLrG2Ra35sN8bu228g5g4H4Z0wh?=
 =?us-ascii?Q?3j2/N05SK/qUAEDto1EvXDnxd1jx6A4DLTsR7UIisGA+GgY1+mIGjY6dePuD?=
 =?us-ascii?Q?rh7EI5ySHMdaNrnQBfreMRgPYeiJ9tPNkX35YaMElIV6+IrcjdXLolh8jGti?=
 =?us-ascii?Q?m/qfub3sB38oVeGph1sJdwyErXS+1n4FEt3VadWGm2zn8SrdbmNPvolyQcDC?=
 =?us-ascii?Q?ik9cBVEJClOKosh48oOxT4U5MDTofr9T+eAYM4iE1reJJxLmuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:32:53.1274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1508d25d-bd41-41d9-5329-08dd08fadf05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

From: Peterson Guo <peterson.guo@amd.com>

[WHY]
On some cards when odm is used, the monitor will have 2 separate pipes
split vertically. When compression is used on the YCbCr colour space on
the second pipe to have correct colours, we need to read a pixel from the
end of first pipe to accurately display colours. Hardware was programmed
properly to account for this extra pixel but it was not calculated
properly in software causing a split screen on some monitors.

[HOW]
The fix adjusts the second pipe's viewport and timings if the pixel
encoding is YCbCr422 or YCbCr420.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Peterson Guo <peterson.guo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/resource/dcn20/dcn20_resource.c        | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 189d0c85872e..7a5b9aa5292c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1510,6 +1510,7 @@ bool dcn20_split_stream_for_odm(
 
 	if (prev_odm_pipe->plane_state) {
 		struct scaler_data *sd = &prev_odm_pipe->plane_res.scl_data;
+		struct output_pixel_processor *opp = next_odm_pipe->stream_res.opp;
 		int new_width;
 
 		/* HACTIVE halved for odm combine */
@@ -1543,7 +1544,28 @@ bool dcn20_split_stream_for_odm(
 		sd->viewport_c.x += dc_fixpt_floor(dc_fixpt_mul_int(
 				sd->ratios.horz_c, sd->h_active - sd->recout.x));
 		sd->recout.x = 0;
+
+		/*
+		 * When odm is used in YcbCr422 or 420 colour space, a split screen
+		 * will be seen with the previous calculations since the extra left
+		 *  edge pixel is accounted for in fmt but not in viewport.
+		 *
+		 * Below are calculations which fix the split by fixing the calculations
+		 * if there is an extra left edge pixel.
+		 */
+		if (opp && opp->funcs->opp_get_left_edge_extra_pixel_count
+				&& opp->funcs->opp_get_left_edge_extra_pixel_count(
+					opp, next_odm_pipe->stream->timing.pixel_encoding,
+					resource_is_pipe_type(next_odm_pipe, OTG_MASTER)) == 1) {
+			sd->h_active += 1;
+			sd->recout.width += 1;
+			sd->viewport.x -= dc_fixpt_ceil(dc_fixpt_mul_int(sd->ratios.horz, 1));
+			sd->viewport_c.x -= dc_fixpt_ceil(dc_fixpt_mul_int(sd->ratios.horz, 1));
+			sd->viewport_c.width += dc_fixpt_ceil(dc_fixpt_mul_int(sd->ratios.horz, 1));
+			sd->viewport.width += dc_fixpt_ceil(dc_fixpt_mul_int(sd->ratios.horz, 1));
+		}
 	}
+
 	if (!next_odm_pipe->top_pipe)
 		next_odm_pipe->stream_res.opp = pool->opps[next_odm_pipe->pipe_idx];
 	else
@@ -2132,6 +2154,7 @@ bool dcn20_fast_validate_bw(
 			ASSERT(0);
 		}
 	}
+
 	/* Actual dsc count per stream dsc validation*/
 	if (!dcn20_validate_dsc(dc, context)) {
 		context->bw_ctx.dml.vba.ValidationStatus[context->bw_ctx.dml.vba.soc.num_states] =
-- 
2.43.0


