Return-Path: <stable+bounces-89924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD39BD6F6
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 21:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED361F22DBE
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE09A21219C;
	Tue,  5 Nov 2024 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jLuhe9jV"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328AD20D509
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838290; cv=fail; b=qbikYBnRjxXgtyk1/qlielRbZ92nIfr/gqA5REqplcqTwp+Kw8z6pGB7NctpRbc6phBO0Ran3/sfZfccFDIyw472crTfIsJWjNTqqyZqmiXktC4EUFWrPUPqt3t3TgrwWw94V2iXl8Mz4A+e//x/tFRv6DsTwqrFa3NNVOxnOAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838290; c=relaxed/simple;
	bh=Iur0Rtu25tCnMYJCbwy42oftad54zPHlmgrK1f02ZF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XS/MRTxAO7HOMaXgi2RMvTzH+OhaqTG/ohM4zZaGnSiXvjwOIUaiSf6WnPEQpTANnVjXwFh78I69ar8WiUtqbdag2rbIvhSOkGh6p3blBrD4EedMkIkBqXsuRc/MIxDAKvZ4PBoJwMDbyZHUwOfLOZS1RJpnaHlISVL+TwQlP6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jLuhe9jV; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCm0isbYTJVf0lXGKh3xts0s4PIgM6TBwOzTBiRG/ksjfJ/yje4r3odPZBI1M5UZeN3fUv7u2a1S0T5XJgM9AiDAWTD0con2m2q4p6MgcQfBD3Y5J3YW9ZkWslGnoJkSfKpGxuieNBgNX/o5YYRCXs4oWChxe88JP/+uq3zIh4H1nh71iZcZMNMXcKSlp9xBqEyi7eozf5EOUUsbiGsL6aESQt5KqgyoNHLPlUY+eSYk/2y7iGdzo1QLLQ3HN10g2CTPVWqDsqohxLEs3Keg1XAWW7K3LtAg/rwNBXfhIxNMN/7rDBoRYOeEIGpgO7wtlPtDPsFqpulpA62aEj+GVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp4EFSOc0IRJJfuMJB/LY0bddSDbEWKUh9Abjr1cURc=;
 b=C9wKbjm5p3+dZZBLP/+RPCTr+Dh4SqPXH8X3fBqfz19tfw/Iu1ebL1/9xEDW9H4FfoHpK8elLN8W/8YW3ufz0Vu856RlXWbkaIjKpDPhGChX+5Gy+tkcCtWXVeepBv2owm714tMNjiEFx0f6MgfUXNmyYGrTKaO2Mt5ndVtSppjrrYcb3g2ivg4PkbXn6MSn3wpA8GdFlZ1kOmQRsST0HQiNDfoZoVh60eiUE5h162BV4y1ZZT+YYuHZHO0Ma8PZ/9akXv6ooInsuU1sNpx41t9XPFtmToeQnUoambzO6lW58kVatvNyerJcOTLU9CTLnTczHLtZL63WKZDZaZggQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp4EFSOc0IRJJfuMJB/LY0bddSDbEWKUh9Abjr1cURc=;
 b=jLuhe9jVEk0Acggn3OGjOW2yieqdnADMykuo7xBLzMfRit2HLnbP4S8M4EJKFbqFb3Wd9fQE6VYduuj1fw8Zwlm+c7RcjFrpuvrTAfhtvYRQ63fJwd0Kgd68iLFGhGVnC2hT2Fprxpvh58GHPZHsYta7j8cVVH4gekIjk2EBMZM=
Received: from BL1PR13CA0153.namprd13.prod.outlook.com (2603:10b6:208:2bd::8)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 5 Nov
 2024 20:24:43 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::13) by BL1PR13CA0153.outlook.office365.com
 (2603:10b6:208:2bd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:43 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:38 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Ryan Seto <ryanseto@amd.com>,
	<stable@vger.kernel.org>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 11/16] drm/amd/display: Handle dml allocation failure to avoid crash
Date: Tue, 5 Nov 2024 15:22:12 -0500
Message-ID: <20241105202341.154036-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3c1631-ca45-4553-8e9e-08dcfdd7e240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owtkuRjC5uGLMVOR42wQClvrO4rPkDDuTD8T2PsaT1RazY01WUA+8WhTjavQ?=
 =?us-ascii?Q?EpvEOES5CFoKafUc4dSGYDzNgCkARFTTUR8QtHjJMrG0y+D+GceZpi7TW+Qp?=
 =?us-ascii?Q?3/5EGD4dXp7grBUbpyGRFOWSXEioG8wshrT8v8aV6Wp5jSjo5EfMZ6eW5tN5?=
 =?us-ascii?Q?4/M60pRnVz4c6k/8jnVbvSrndLZFdMUoERFAppkq+2AZCOte9tG9CGnY+Vl0?=
 =?us-ascii?Q?FDVE1VRGCqJaQqH5TTmAKDdhm3OVWY5m3qBR5WZ2qzz1RS8niSrJTevd6J+g?=
 =?us-ascii?Q?64z7oaSMOoGEOvrajBoi4WujDMNqQqngWzVW571AXzodIMEUhy47U3YHZ/mX?=
 =?us-ascii?Q?yWqBJd0jaRp7H/d27tACtNjoy4tFwWk/JVJEQTkjtoxxxHxZujww8cMI6DqR?=
 =?us-ascii?Q?gqqMy4fBaAvPbRxcKmXpgnlNfA9kvyydhzGkMJy6zrrD3TTmKtQn131PvqvM?=
 =?us-ascii?Q?e+zFfQO/0E8VaDCyV36mRtkC6huvVU7qk1KtmLc3Iq+wlFTZjYNhhBIrUNoW?=
 =?us-ascii?Q?m8YshbgESttuJ8f5MRZXj6LfHNbFwYiJLb1LJgr0qFmGjV/AwNXVgRvZka47?=
 =?us-ascii?Q?QhMAvTV7EUz40URu5adLZfb7aWe5GlTWC2LsslPbx9nYOvtO9EMYzz9PkMpY?=
 =?us-ascii?Q?6NCKXsbuJAMx3R9o88Y4VuhvDco1AOeMFRtI/8eMjnWrxOIUhfFs8Zj8cYv4?=
 =?us-ascii?Q?vS90aDyKS1U/EYlT8WdVRFbM2x72MosG5fJqXWS2Zz4DPn0d2GiVV7vXNvCZ?=
 =?us-ascii?Q?gIfqFAALOAUfOO8dijwaCuJ0m8fWt3dYLC3jqSR2pXCpe4yko/tGKDcUiPdQ?=
 =?us-ascii?Q?sawK0bXu3kj2N5MBOSZhwdzkMBlIWs/6t+UKezT5RpQ/D8bULRHmVcLM6c8t?=
 =?us-ascii?Q?ES1+/Z79U+wpr3CFI6wT+Nf5ngb1mqO13T5kESRpkoBq6tjaX1dwR/hdiF6O?=
 =?us-ascii?Q?zRJhpREeiPjNyALhpAUn1AQYpzDZ40kSf9kJ9hIg7keu8jAvfvRVuVt/PqPo?=
 =?us-ascii?Q?9LaFTDBZrrkZfzCWUGWfcuGc0j3wR+vO2dOGCwL5ecTQUF0Mw0rq5aTxSRik?=
 =?us-ascii?Q?La5l4TVA9Wodv1cVSytC+vO7O/ftryQAjLFSF5rtTEQr56c+nuHrE8kVf6h1?=
 =?us-ascii?Q?3dzA6aCqvKWZuc075wn+ShWaNGvSV2+zrL7C+PvUsuH8//2fIFkasGLF4NQt?=
 =?us-ascii?Q?BmpeDqXLZRjoNxqFxDgkDMPyKFyE7Mm6Sg8Jf4ZtecIzpCdcvZ4Vn1L/9pAN?=
 =?us-ascii?Q?y7bLhJMUZES9volTUl5H+gGGtmNrLwNJBzEpF8KwT3PT+q3TeIYvryRyuE+W?=
 =?us-ascii?Q?OunH/VlNPUFQyjHw/dMN/kRPY0jKIfBrJ2qwWRFJb+ElHGXs7zk659wDpQt8?=
 =?us-ascii?Q?KutClAtgKvFn4DhTVjn2d3QW1GjGEu76SngxInzDJgEXM+sb5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:43.3414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3c1631-ca45-4553-8e9e-08dcfdd7e240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119

From: Ryan Seto <ryanseto@amd.com>

[Why]
In the case where a dml allocation fails for any reason, the
current state's dml contexts would no longer be valid. Then
subsequent calls dc_state_copy_internal would shallow copy
invalid memory and if the new state was released, a double
free would occur.

[How]
Reset dml pointers in new_state to NULL and avoid invalid
pointer

Cc: stable@vger.kernel.org
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 2597e3fd562b..e006f816ff2f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -265,6 +265,9 @@ struct dc_state *dc_state_create_copy(struct dc_state *src_state)
 	dc_state_copy_internal(new_state, src_state);
 
 #ifdef CONFIG_DRM_AMD_DC_FP
+	new_state->bw_ctx.dml2 = NULL;
+	new_state->bw_ctx.dml2_dc_power_source = NULL;
+
 	if (src_state->bw_ctx.dml2 &&
 			!dml2_create_copy(&new_state->bw_ctx.dml2, src_state->bw_ctx.dml2)) {
 		dc_state_release(new_state);
-- 
2.46.1


