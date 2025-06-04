Return-Path: <stable+bounces-151462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F5ACE53C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 21:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA811795CD
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD420E030;
	Wed,  4 Jun 2025 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ziV+aVee"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64320FA81
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066060; cv=fail; b=CUAQCwr1AaV90e02SIIlH3SJHztz0LQ8jpOSLZeCtYRaXXlXqIeeY6Xg4pGBys9J92kzf5hLOuVIJvSQ/CdnqShPHkyo+ExFQ0aq2Ng02PJTYvTw05ajlwek1zXDuGv+xuCXl/8YAmS9DHui46FjjyanTfm8b7GOogMGW68O24Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066060; c=relaxed/simple;
	bh=ob+mOJE5zxLO1LugC33SMtltx08ZpVuqjClE4VqPdtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouIC10bOFaTXRLO+ttFicEwChkUp0j3eGT+1XbG0b4IYpY8ao4wuy8OXuKZc32JBgEcYuDKsJ8tJHvob6dlEvJfdYgb4rMKPkieTRmPuS6FKtbLQDrGPeom/WiO8ImfP5t5ww8AVph7z9erORwufvbvKdpVQxopDKmbI3ZNsbXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ziV+aVee; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAIcwu+k+f/AbKeQ64nF36AgZ1/e69gx7b2KKJa45oOchx0kMNURRcQuY6QTUttDZreevqYp/wXCTVao6tCzAJHe+C3bRQb0+knKjDaE8PtMgYfd63bUhXXkfFYLML7/yXv+CbfdG4a5+YXLrzlGd25CVo1VsE0pNeCh+pOGI8CBjr76bgACDflYcnQMc8oHAVdi7mRlFFerL7+CAgCf7IRbrKU4z9oYaBZ4QXwK3cruFp+Z5oXb4TfXMdBjJkB2t1y4mlY8SeS3ZHASAjQifykDGgAIEbmAtn1e7OxqZ6IPHnE/nnMuxCCAWhnX9y+mcVsQrSiIvhjP12wzsnDrsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsGP4hRAZ4k/H0QuRcp11u3P2j/HiMHFsF9U000l+oQ=;
 b=QtnoIJ3GLYbEhYcpP0XjeVDW14zCxKigi+b4ONDs/5iHGfBtbP+v3SJ83fkRCy6mW5J+wMo+q7UdLuVaCgU1ap/NC6tPNqJb6KgLTeCxkpegnNRNOt8Fp8JQKB7uX86vZhtWI35EYOMY1QJF6ZaDhdSmVMCuUROKgQWuSShhuk5nalCED1IoiYNV24zYxmyKXJRYGAGwa9rlPSzU922eesCb1DCVpnztdzpfInUWMUqtIh7QQhc5XIz0v74nMCD9C5gnhFoake9rybiqc+x9oX2LN9wGZgBVHX6J867LkL0Z/LYWIAhieB819gw3NvJA54/0VnvQSBo0Y047rRQleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsGP4hRAZ4k/H0QuRcp11u3P2j/HiMHFsF9U000l+oQ=;
 b=ziV+aVeePhQXPDkaWVRTlZfbC7RMsWGL8VaD+7G49dfjG6bwH/BR3HZyZg21hP6Zxl1rBW782I7t1/v4PRk1lK5aJdUwxirung9s/LvQ8+9Cw/5gv8vgCYiWPckCEpdM+L3+NV3rGsNI8dw9O9RdDiNuMmvuBl/+yJfzMaqVVm4=
Received: from DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35) by
 IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:40:55 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::e) by DS7P222CA0027.outlook.office365.com
 (2603:10b6:8:2e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 19:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:40:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:40:52 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 16/23] drm/amd/display: Fix mpv playback corruption on weston
Date: Wed, 4 Jun 2025 12:43:27 -0600
Message-ID: <20250604193659.2462225-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: a905b12f-86d8-45d0-0ace-08dda39fb8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhvdRqiKIoLbvX0rCKra0EwSEaqQ5EqIWwoNsrTPOd88k6B36heopb3gp5nS?=
 =?us-ascii?Q?AS5llWhNX9Rsoif7MocA682BXocgvxfHTgmeUhw6eVkqMCpJR/PWBfoscVwa?=
 =?us-ascii?Q?qNYLrhBa3nMjV7734qX2CwlQvZuYy7nF6z71HYmv1aBtpinOfQg40a+LPZ4y?=
 =?us-ascii?Q?VCfd/Ho5zQoCnQ7JYpl83OAzsSLn8mDYz+YdwO++VWac1mqs0mhWnII/rlrI?=
 =?us-ascii?Q?NpVR2lc5bf3Rf5/tkbp4aJRUc7462pjSvsfSsEqtOI74xmrPlYa5jbkqHGv1?=
 =?us-ascii?Q?DiiIxny+sCvjLyVkU/1ZIN26EAVj5NcoxGs5sojOKKPY9WndeSh9tRwie8V6?=
 =?us-ascii?Q?i/hI0i5WsZZxAX7S8txMrwk4+DUYD+bKEej58HyFLuRquaNbdFgTl2EzrHrj?=
 =?us-ascii?Q?QiWxqt3ebv6fXsmR7Gcwv+dYJZDXsM6DxQT/4LInGtI552Ed+DPtcw515XrA?=
 =?us-ascii?Q?M+ld1v9G0lrA7WVBm7D2uziJ+QA1bj14cWYCX9vOQTRgzVgGVwQNJf1GQcFp?=
 =?us-ascii?Q?cFGWk593nzoVZjKav9bf0dM0QxLftfMwjld20etw4m1S8+gu+qLF5etPAESv?=
 =?us-ascii?Q?jeEA5NoHG09EhGhzricN5Gip5jAxDVbHIwkSZyMs+qu29Ss7h17CgeQFBdrD?=
 =?us-ascii?Q?rHSbniMR3WANuEcsLQUIwAa2ZUGTTUU5tkKqhTOINxrNxdJQ0FTazWAJqeY3?=
 =?us-ascii?Q?KoThW+oK0ncpniFOweCqspSvUxXH/G2eNrr93oVS3lHq/9FyUrQQYffPrj43?=
 =?us-ascii?Q?38TgkxqgDzEyznvvo0s+qPxvlmPLQe0/iL+W11295try6IsRqlaE0hze+nAN?=
 =?us-ascii?Q?YLCRxPWr7Mj/pvdR/1dYYASIqhaTKZV2lq3ApGBBB7XmuZxcRBGvaMFi8Ve1?=
 =?us-ascii?Q?ZMlaxHePg9foO2+Gpfl6+/RHPVXxKWTbhl2BNc4AbFXmwFLcqruPy6W3VVZK?=
 =?us-ascii?Q?5U9E/5KbI00VqiPE92TdDMJS968ClXleWpvVZa8jZ/O7Brp26eR5De07IwLH?=
 =?us-ascii?Q?H5el2fm8RURF4VhfYGD5UAecSHYVWSc1N1Wiy9R0jQSpv7J8i7Oartb/7XIH?=
 =?us-ascii?Q?w6O/k6JulaHY8tydOUku2ddlQg3PbpNjCTYbwZi8Wzsmc15coIUtJzdSuwvG?=
 =?us-ascii?Q?aAfuSfRF/qWeAyiC0wM+jD33KYgFI5RqPA5HP9R5AX9OfY2PCS7WnibJ99zb?=
 =?us-ascii?Q?NzmwAv5pMtk/s9aYX3ifiYa9ePwtFEE1YrcguqGp+Wf9NlEuZGUS/uCrWMTv?=
 =?us-ascii?Q?MoZaZLM58NyNvRHDvghsE8GyXGOUM6tNa5TLqojkQryCeWTrqsAqsDQ9ocg4?=
 =?us-ascii?Q?5UWR2qiwkPxwWCLv5pxGQ4YF1q65wGyEN1U9tH9a3u1sJtZhUExDz45UU6pI?=
 =?us-ascii?Q?Y15STmjpHB7B0MVxPhCREfleiTGAFCLFnPNvAXkas7BIOjwTYlbug4IIsoDm?=
 =?us-ascii?Q?9zuie/FVTCf44Ix5VmQ71L4VdJDGW+kr7K9afK51wiydh7FpoMnXAAxdlKpn?=
 =?us-ascii?Q?R6Ju2/uPfbsK9RDhtZBWnM224kNilaR7I0F4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:40:54.9869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a905b12f-86d8-45d0-0ace-08dda39fb8b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579

[WHAT]
Severe video playback corruption is observed in the following setup:

weston 14.0.90 (built from source) + mpv v0.40.0 with command:
mpv bbb_sunflower_1080p_60fps_normal.mp4 --vo=gpu

[HOW]
ABGR16161616 needs to be included in dml2/2.1 translation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c | 1 +
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 13a12f38eb3b..19f794e46e0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -797,6 +797,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 		plane->pixel_format = dml2_420_10;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
 		plane->pixel_format = dml2_444_64;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 5de775fd8fce..208630754c8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -953,6 +953,7 @@ static void populate_dml_surface_cfg_from_plane_state(enum dml_project_id dml2_p
 		out->SourcePixelFormat[location] = dml_420_10;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
 		out->SourcePixelFormat[location] = dml_444_64;
-- 
2.43.0


