Return-Path: <stable+bounces-75860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ED197583A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E71C230DB
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E11AC440;
	Wed, 11 Sep 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bUbulC/T"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50867224CC
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071800; cv=fail; b=Zb+SFw5AEYh+ZdI2htsKczai7SOVxZJz+9AEZnHZKCuQITLhX5AJv+yd4zDQO0bMKIsOIgqwlL+POcymvgXFwYj7GBoccUrfahFrsHX+vbOWS5HVqKF1egpHtdNAqM816GH9lG3JX6F03YgrzPUQ6/r9GSLrS/3P95PLFh7IGiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071800; c=relaxed/simple;
	bh=LOKiyvY4/IgMHZ/rQD30640jXf5DDJduITRfub0jiM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd3m/hhIIbXeBzrLF/F1rp6zek9Gm6O2EpXTxAUorFrThKyQsll1LT1BlvGAsK38S2KH1XvlEYCNvn8GCZK8nA9ZmovzylefxtJnQJv5eY2FsmIryoX6YjwTIGlfe8/5LpUWEbwYGaAt1ccG53W61njgUYpHPOLE0JLBnaZjEr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bUbulC/T; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwhsVimrN/ubvBLo4hRs65Njir721GrYrePvgx2uKTBjpE2AEkgk9kQD9zDP75ZQO7e+diSDzxMhdnQ8kepIqWKtWOLKu+kA8E8gPfG2qsx0FLnaXgUk/kv9Dxdjr1QC8nBLiHuUUrbSGpJDucX93fR5rdQvWnvva+0cRFkoz/5EKqkQtH5o8VjGFuUB/rGqRPFLpywLj8DH9sQXygKajEc4h8JkWiFvBXU6dQeXT+kPY/25KYjPPKSlEFxl+kVplRJHhyM/s9rI7gpamKacQqHdLdsyVtmA4j9pY7D/sTKpaOB4zGqrRpAFsa2cSsPk6r7N0oLxEr1LwNsXmomKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHubtdSs29pBkTB3JZ1qvs8sqjPs5K05r3PLkZzfg98=;
 b=HaQ32tDY3Oyi6MBl1jQgeEj6/8lVcafx8aglMbvAyXAOfodsE1rS1uKmvWXP9G5VRvfh6iWK+zUC9Oi9tOINdtk9oO9ORWUgzV4/PksC1U2Z5Og9FFNcwlKc+NiZubOAQgRsH+IDrTnorCF2dQI5QLTLNsLLW8BBbjwcqJnNjH0lk+AlBP8hD/CPLajCSsgSGSG5bjHu6h4+oOyHJYEruAz+xZpdYSB+3E7+C32P6dqr4j9NBvMl3FXqym1xpdalW6N76IRQkFf69N54tKGFpxlXaTS+n5H5knwJHgM5ZHO8FqiytpAsx2uTHeuy1j/eTNxGJsHfq+shzwrE+Fsg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHubtdSs29pBkTB3JZ1qvs8sqjPs5K05r3PLkZzfg98=;
 b=bUbulC/TPH/h6J4rSEuhI/3qRH6IdQGBG3IxbxDPzkgJL0WD+WBBuXzlraKVU/vrXBBQeSTGAzCtD/iHxfn0KBtHiUGaghGVihZiUGncYgWdQ2jBpPtim7hYEFIV5wWUllH4jXbtmoz3BX6/TispuKbrnbko70mYkFe5gSLPXxw=
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 11 Sep
 2024 16:23:15 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::8c) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17 via Frontend
 Transport; Wed, 11 Sep 2024 16:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:23:15 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:23:12 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Dillon Varone <dillon.varone@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alvin Lee
	<alvin.lee2@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 07/23] drm/amd/display: Block timing sync for different output formats in pmo
Date: Wed, 11 Sep 2024 10:20:49 -0600
Message-ID: <20240911162105.3567133-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 5928819d-0abe-4bb3-f03d-08dcd27e09e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6zol7NNV/xwcfuj3fFN+uip3i1qZM5FTVFqTBuTXzFu8Jxdx7wllH0FRDrb?=
 =?us-ascii?Q?ko8MMEeWsoVRJKxg64alfsIvlLt76fwD99kT98halfx0F56jRAhxxeBrWUdx?=
 =?us-ascii?Q?pjkwPDcI463V5ZYcraUOp1ze4THsJqMn54d3X/+2h+EJa10htV3p59iggC/V?=
 =?us-ascii?Q?JYV1dfYb0BmoR8hJs6JTGpHHt/N3ZtzFUPuV0PWqj/XQDuuPdOLM5070Fzdm?=
 =?us-ascii?Q?nQTA90CeT29cRsokoECUBMurh54kIrdBRg/2n72KGh/VGicXo5LksCa+yHsu?=
 =?us-ascii?Q?j4mclcPeoGSbEoDVC7tih0ik+New/qXFT6gou/pJesi4sFEP1KZDGzJIfJ5s?=
 =?us-ascii?Q?ozDwCFrWdx4xVah2KdVnipeN5YBhXHzTngT5IcFC4eIXFC3ksmvLH09Nk1c2?=
 =?us-ascii?Q?chLScr4Ae0lVv7+uwWbtwx1GbyF5GmqKC4YbEwhBtf6tU9v4PQNwmDOGTPjQ?=
 =?us-ascii?Q?8aH3QbOFlwTQvqgx8cqHvTC3mTb112SXjHbq4OD06SzeXyxkKh13Lg3Lowoe?=
 =?us-ascii?Q?cvumYoi9KCmcYdTy9kzQ7rYr8RyAwB7dHx5cwYvFdzu61pCa+J90qWaVU46X?=
 =?us-ascii?Q?WfuiGI++MqL3qdvHrnQBD0Gkhvoalhwt0gX1L2PgGJWGCCB5J1cL2E1SWPNH?=
 =?us-ascii?Q?ZkA/0TMZ12yvf05ACpqMylc5QH4vIQnvUZsguX50Sb+n1i+3Z8ixgTORQLFO?=
 =?us-ascii?Q?76xDsf7p1qeTmqNaBALj/5EYw3RiihrfFWDNKVunkCEDP/CC5icKPAC4Zn8f?=
 =?us-ascii?Q?gR6MExaADcdH//DCjLDx2vn5PfES0awQ0TMZkFZd3ZewqpGL5hie4R32/FwZ?=
 =?us-ascii?Q?saK/3aH38T8zn/MBsj1GbqZOtylM2/DAe8zuFu8wDxmqdGLMPCmXBSu4orRe?=
 =?us-ascii?Q?z54jFuRA7TXkCumKYQ7h0LruF/+83jCAowjFZeGPKnNsqEIhGB+CRN9WUN29?=
 =?us-ascii?Q?MGfpafCUKHKHrRqncV81wPJz26FkBPKKrU2n+r0sKrUeYoS7V97S9scEv4Ny?=
 =?us-ascii?Q?J/+Wt4xyf7djVKG+dQtAhSnhF+eAk/fbsj0NNfxWT9QUjtw3lXHYlXUpWT0O?=
 =?us-ascii?Q?vzLKr4iRZqJsUL2eLSArV3Rit80+44UcPYioCFi4thOp1CidzZWAeHym+Qv2?=
 =?us-ascii?Q?gYP9+eeMfz3tziokBVGdDlx3S+bQ8DPDH+yi/p2g5AIXY53k+Exp1WjSbXFx?=
 =?us-ascii?Q?O/v8J0erVUzNqpQPT2MeYHJuzzIdC+fL57ncLJxjF3kubbbHPtjAUcUqkabs?=
 =?us-ascii?Q?60yLwlYIyMMfQ2NHFjntiY/6qEzeB7JRXN7uWHaL7M7xcJaPha2QagSr8Fox?=
 =?us-ascii?Q?4u1rKcVizV3w3oeAlG4jCKJnDDgz2M2hUt8tl4i0HWwUz0r8r6TIqtDZbUri?=
 =?us-ascii?Q?3UotKSxxtItj67ELcUqF75UsOtvBjuGiV3fOgXX/x563cHZ3nCWcRm5hFUJE?=
 =?us-ascii?Q?eNtFEYHyI5Ft1hpF5RSOzBEpQgLvpKlO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:23:15.2828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5928819d-0abe-4bb3-f03d-08dcd27e09e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

From: Dillon Varone <dillon.varone@amd.com>

[WHY & HOW]
If the output format is different for HDMI TMDS signals, they are not
synchronizable.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c      | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index d63558ee3135..1cf9015e854a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -940,9 +940,11 @@ static void build_synchronized_timing_groups(
 		/* find synchronizable timing groups */
 		for (j = i + 1; j < display_config->display_config.num_streams; j++) {
 			if (memcmp(master_timing,
-				&display_config->display_config.stream_descriptors[j].timing,
-				sizeof(struct dml2_timing_cfg)) == 0 &&
-				display_config->display_config.stream_descriptors[i].output.output_encoder == display_config->display_config.stream_descriptors[j].output.output_encoder) {
+					&display_config->display_config.stream_descriptors[j].timing,
+					sizeof(struct dml2_timing_cfg)) == 0 &&
+					display_config->display_config.stream_descriptors[i].output.output_encoder == display_config->display_config.stream_descriptors[j].output.output_encoder &&
+					(display_config->display_config.stream_descriptors[i].output.output_encoder != dml2_hdmi || //hdmi requires formats match
+					display_config->display_config.stream_descriptors[i].output.output_format == display_config->display_config.stream_descriptors[j].output.output_format)) {
 				set_bit_in_bitfield(&pmo->scratch.pmo_dcn4.synchronized_timing_group_masks[timing_group_idx], j);
 				set_bit_in_bitfield(&stream_mapped_mask, j);
 			}
-- 
2.34.1


