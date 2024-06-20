Return-Path: <stable+bounces-54750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B351D910C0B
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F161C2191A
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D448B1B372F;
	Thu, 20 Jun 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p2k/ucA5"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0551B14F3
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900383; cv=fail; b=XZmsijvADqiWAPGrjtqV4CNTCuP6dHeXm8EQIajsT9sox96pABzaWZtaudbS93SEYeLIMCLsQz5D095jwBmEg5NbabbPCS4qFQ1xJapxdQ7gKs0/lR/4PB+QZNk4FKtB0o3LBwERWTi2Nf6qVXBU3uc8OcwAz61dwFCLcKbLcBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900383; c=relaxed/simple;
	bh=4/9J3RPPort4PNACvXotB51Utv9mGmA0JNWraZUrA8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kU6fwnrkqN+YHFjbBYhnMmIFGdINQIykhM963QyM44/dFE7OIXcIylu3pl9Yq7gfItrsALBeERUL6KERAmoFyw9RDBz20qYMvelJsonUEBGfySoemC+FgfDROpKUS/mqoKoPxzkreQuv7KRmR7wSwaiLEW6cIPiN/u0qEM+4piQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p2k/ucA5; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXa+mFqtwbuBzbA6q6ZJo/R08BWjNTTAYFHit5Qaf8eI6KHL2/vPSGcr2hgNVk4Ujhr1gUXcVrRqcOzrFxenqrcxXq1UYiKxFCmb7y9LHH4MqEDelCItDSXTUdGDDRvTYpsXa+ongWOE6y6Qlt/sSqETWvfON1G2mVvaL3Y//k0Ev7cMupf9F5ZHHIQ/jYjjI5ZcmfVAaQHsxZPVWg3yNunTiaMPlR/q3g8beSt3zJqPtlf4BbZ5p6nd9LrXV0kpvd0azxWtBgPAEdZUENs2ShC0JLrq6zalSvw+HHozF91WC1oUf/v8vi17IXPIlubB2Ne0K7ilocrQMVYo6pO3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnXUgeOSF0JivaiRg5TfJSeICSk4lQ71cEPFRhQ+nEk=;
 b=XAW32KkquQu7vLksRGCqrjKK7ChIT/DAncjEa0tV5CU5iJh2dvd3M6UGUUTHbxGd2vLYJkRBd8wtOVSWRI0hUku0DG+I2r4Ut04b85imwAcOkRKxRhwDkSjPfRFEY8/l4LtAQHmFQRciFc/Zsix7e3roNUSmkirX3yHbEVJsElCaJLt2ZBVRmrqCXfYv6cad3irI1aoACQf9h1ioZ8rKDExkzltTTsCPRHkpV+ep7cwB1omGdGpoCsPVc5+gMxdmuHIxGmElxQwuiW2BUw1dG9r19oltoy88T7FGwIje9fCyScrvFCSTn+3ZWqM0StDCCZGb7O2Ri3XmoD7RQlBaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnXUgeOSF0JivaiRg5TfJSeICSk4lQ71cEPFRhQ+nEk=;
 b=p2k/ucA5uxmoHr5os3AMHMWQYq2uZty7jHxyWRMCDOloFTf7ijOeZVRUEU1Hi4vUBq/+472fGhzO+lX9/cCWzoi/eFGjcosCP4zmlZCJ02A4iIGbVCjM7yiAEWZq5lcDBCtN77G+ANhk9IdfoTxsOdhuF7LvwmdexObaNuG8dJU=
Received: from CH5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:1f1::11)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 16:19:38 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::b9) by CH5PR03CA0013.outlook.office365.com
 (2603:10b6:610:1f1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:19:37 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:19:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Relja Vojvodic <relja.vojvodic@amd.com>, Ilya Bakoulin
	<ilya.bakoulin@amd.co>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 31/39] drm/amd/display: Fix 1DLUT setting for NL SDR blending
Date: Thu, 20 Jun 2024 10:11:37 -0600
Message-ID: <20240620161145.2489774-32-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 1548bac3-054c-4952-6994-08dc9144c7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BS1ecctwnwCjo44ljDHMDMc/pIpQLcrLaO9QTiz+Ehg0z0gHlJgThQ/v4XWL?=
 =?us-ascii?Q?1PUcCyNiHEYNUueur4DLqm4T4mDam/6CCXVJiG7rPcPE1AqBy6TFNNSJMJUK?=
 =?us-ascii?Q?fIueAP/W9a0ruaz/hQbTY6gNSGUisLACBZw8J4U/8IqMvATrIwuBQUx8om7h?=
 =?us-ascii?Q?up9+eL1wvLDS5UAFqohKOsJo0PAGLZ/Lp0TMXkf3t3YDFJEmiXvESXovf2K8?=
 =?us-ascii?Q?Epm+Ph4Ux8F130ggM/3W5K+g4hg0Ei7IVqDvzrIOnxU9dl+L92lxT+tejoBf?=
 =?us-ascii?Q?GDTOiQDgjhy9OQxrc3erdVzsmAJE1gsW+H2w6qtXGNIxhnkIV7K7MxmB9wsM?=
 =?us-ascii?Q?QfMiOuqXRn2ym2eGJOHf1uze8wQ6k+Eq8Mq8gCo5bTkqnkLvY8KQ2cDBCsWq?=
 =?us-ascii?Q?dO1Jt8Dm0YLzRP/UFyJkCl0HDV2i1fsfxVtbefduAepqyY0fxAoVqrpfEpdw?=
 =?us-ascii?Q?xqAShWVEUD/lbgn2RyJPHgqD6MgX2cWTyS12hPj+Cj0EFz3MMIaPSAUkB/pn?=
 =?us-ascii?Q?8U+7I2JhphTCmqhsWmOdC68Yt3C+Jx05b30LbYP6+ks5UC3OjBkqGLgz8d94?=
 =?us-ascii?Q?h7jfJGlGCKGFoTJTNRuu/PaJbgzFapTTuoznsYBUM7lsyAHQjxqSFGiihy6q?=
 =?us-ascii?Q?TDp4AXSvbmmpsAc6Fx/U5psJutDq8FO1EuTwRPIoEPAoV/tctNYHsL/FlmDf?=
 =?us-ascii?Q?acUqsc4PWia0FDwxy7NOi/8SnLHxaEeu22IAiUALDLRud08ZMsyRcHPaAtye?=
 =?us-ascii?Q?+JF5U0IDyYoAY7ycymis6MpjXSllqNF9a4PQXcVlvtPLbdwkdnTVOyLpPbaV?=
 =?us-ascii?Q?HP5oV8oi2LZ7/RddyFMCLyKVX7IvhdUxeXOWlQtE7lXLArdkun6EcDQR0pi0?=
 =?us-ascii?Q?a/r/mkvdMZN2xpCqlroTCuu1VU/vzztXDQBMrJYB6wVnjEWBVcL+wEeCTeLZ?=
 =?us-ascii?Q?42T5iyo99YUTgxt98n2GCYMv6qIvdIFZGZ/SX3MvKXAfrxahbLXNXw74ICBi?=
 =?us-ascii?Q?6V/E98t4d02ZKmBeZzV/zdZsQ3kn0VZqcP9LwhZDzMJu+StK1TFLg1g5nVjQ?=
 =?us-ascii?Q?Hjh53D7p9KzrWCfUWjoUgvu4x1aC9RTkztheJ0oomAuyagJO0hjyGkktz+d2?=
 =?us-ascii?Q?VwnRisbO0ULs7TGoMAydin/J9XjvZ0WbqFmX9ASWqZLroCSUIb1fx9HAcvzQ?=
 =?us-ascii?Q?ohru96TZgRLrja9tmlQkhyNpjgkC3X3fu082HGSy0kHCxxGUX1i8RPeDx0a0?=
 =?us-ascii?Q?E4T76NvZ9QgvD1qaU6V5v1Rc27NZKWfQgni2phX6efhsFFjhcbvToo19SNbS?=
 =?us-ascii?Q?h9MGJLmGovfyc9SPmc/mVzgGIV9ERqwy/F4BX7Yi3nPRJZZPBqHTIiCYU/qv?=
 =?us-ascii?Q?GwekmvLCEVuqkkZVwCW6Nq9YoduaYQG2pAE+pHaCOxG8FqTfYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:19:37.7383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1548bac3-054c-4952-6994-08dc9144c7f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919

From: Relja Vojvodic <relja.vojvodic@amd.com>

[WHY]
Enabling NL SDR blending caused the 1D LUTs to be set/populated in two
different functions. This caused flickering as the LUT was set differently
by the two functions, one of which should only have been modifying the 1D
LUT if 3D LUT was enabled.

[HOW]
Added check to only modify the 1D LUT in populate_mcm if 3D LUT was
enabled.

Added blend_tf function update for non-main planes if the 3D LUT path
was taken.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.co>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5306c8c170c5..b5a02a8fc9d8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -502,7 +502,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
 
 	/* 1D LUT */
-	if (mcm_luts.lut1d_func) {
+	if (mcm_luts.lut1d_func && lut3d_xable != MCM_LUT_DISABLE) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
 		if (mcm_luts.lut1d_func->type == TF_TYPE_HWPWL)
 			m_lut_params.pwl = &mcm_luts.lut1d_func->pwl;
@@ -674,7 +674,7 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
 	pipe_ctx->plane_state->mcm_location = MPCC_MOVABLE_CM_LOCATION_BEFORE;
 	// 1D LUT
-	if (!plane_state->mcm_lut1d_enable) {
+	if (plane_state->mcm_shaper_3dlut_setting == DC_CM2_SHAPER_3DLUT_SETTING_BYPASS_ALL) {
 		if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
 			lut_params = &plane_state->blend_tf.pwl;
 		else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
-- 
2.34.1


