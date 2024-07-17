Return-Path: <stable+bounces-60480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9527D9342BD
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA1CB2126D
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 19:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEE6181B8E;
	Wed, 17 Jul 2024 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CN1CXAS2"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D528DD1
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245251; cv=fail; b=X3920v+DJ3E+1T/sY3Q9Ymvu3T96uW8DNzzKKkbgXc9PJp2Og3uMvewcm1dSp6fVoSBonYZeAcHYTuQXLWAFeonm5nfxmecGeseGDfrqs+ARS32ykczCDKjJwQFZ1nqilnG68FI2OejZmmg+oLiptBasJ0n/RF4Ao7frRzfGWhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245251; c=relaxed/simple;
	bh=zoBs2lCLi8x0RB0ZTGydammcCTOemlJdJli808ifaxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldwuqAKJdDDOYNexH9I+tEBhwOdvpJQrw163+rooDmpPIzAduP0Y3iLvx32jxA+73DYvgPS6QR+FOJqt/8Jb2aqmTGP+aEbPa0FZK4yQdzqlzHa40o7Fb8NtcT2K5bh+CPRaHdh+BOupAHLHYq0hr0mY08kTc93jXF0v0Pq7LD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CN1CXAS2; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/NglFXbYDD9LTlJZ83isoWPFhTBrLgAyWqbJRQPahWehm9kdatambapC8jZJfOTp5dTWNe9RoGvBmCpQ2YIuoQX1XA1yeuVoYovdNgB7qgWDRbMReXIR50EdNVSpzJz9BGFi9y/pfpKkAAOTsrrJXSfFEiBFHsS/Ak8AWn+VHQrMtPXF8L+rk6seyZq9/KlYVZkdj39uRQsqwCrQJffODWANKb1qrQf/APOTlvqGmA8xitbDyul6luBIwn7vDOaQMGh/d8OCRQETCMvBygxKlsbPlShUbP7DeiaFsmmLj7NUov0PCaG9g+Z9kJexh92pBlJxwCUrpBtwoUCNSFTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe65HBUZSp0X+yMj7nMQ8bfqLNmbNa6R+qesarg0Z/8=;
 b=o452aNBVNqPfgiMlTX3Pe7JfUn6oUlql+SUNqRTePOC7ERqJ+2uf1kOToTwd0NZdW/AoMTnz7WI2k9H9wlyieB2+o+/t4M/hpVeey4KpbPs57V8GXe0wBG5oDhOsFGK3u+zoTR4auHTZWxOVRhr4lNJxf60r+A+Q32nOPtuKM0lzNDwJVgcmY73FT7JH51TpT4CnCsuwf7cDKCVtpOkfU08gQrOdecGCDM8dU+MtbT0RMo4XhAwP2wQZBc0nYfdqqSQeckEo57Et98fKs6Rqo07f+2827NQWVQhqKPQrq5DvHuaz1QYBhbMF8H6cuoqnMijuZ4iRxLjuneM18YKdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xe65HBUZSp0X+yMj7nMQ8bfqLNmbNa6R+qesarg0Z/8=;
 b=CN1CXAS2MfTezNgK7xm8vm75QheVO7iJU+/fuyi8bKRvczBIRwdWuTwc20immo+UUAML7A8fAQTFanxAwTG/2NDJbxcebKa0yt4aFkKwT0evuKckdyzauyvPbXDakXgFOD3+fXpzvsIYUY2TpsosPuppJkb68y3xbdZ2P9Y3uNc=
Received: from DM6PR13CA0014.namprd13.prod.outlook.com (2603:10b6:5:bc::27) by
 IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 19:40:45 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::9c) by DM6PR13CA0014.outlook.office365.com
 (2603:10b6:5:bc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Wed, 17 Jul 2024 19:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:40:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:40:44 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:40:38 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Gabe Teeger
	<gabe.teeger@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>
Subject: [PATCH 14/22] drm/amd/display: Fix Potential Null Dereference
Date: Wed, 17 Jul 2024 19:38:53 +0000
Message-ID: <20240717193901.8821-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 380c1b24-2377-44e8-a687-08dca69859ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K81MlquWh6G3aAeVxpA2xr/TJApQEw5oN02yjLwXVSLo2HrCYh1YPYGvee3g?=
 =?us-ascii?Q?ap2rflokbJOOI3JvkrJRVa5M8W6y8tMIuGUW8/Wlj7df7LieEBXdltKwwUnM?=
 =?us-ascii?Q?e4ZqoSJBDMREgCIlVxx+bv8dZBZY2YSTr+lXbAh0JwIm90f2gQp2E6HSlnPc?=
 =?us-ascii?Q?w1dXs8C7lMy90v5KlJBUInRjuUhucGcG724Mt7WyABHwYmeLRUKb/zGA6FWv?=
 =?us-ascii?Q?mUvKsjPqoeqaPrxYrYDGeSjfcniFFaQKl+3dGqrVmoWi6aYjZR/HyAiUbdle?=
 =?us-ascii?Q?rku/qHtVKurcKwaYL7JKTFvKhXDCd3ugGU5welavpizJoNzcg+eJJmzxSBtL?=
 =?us-ascii?Q?zWrs1z4PaK+T1VoYYRhh3nvJIljBzeGO8HVtbKpH2rATo6PopSy8+wx9FSQS?=
 =?us-ascii?Q?RrSENFRY5onhK3j24pyrDpxNu6zTSj2J6NBXhhbgWHRmTb2eymsENZc/zRIo?=
 =?us-ascii?Q?jKK7nRsG+8rkYZscYY2HdcAO/U9u9toL1rKLby334nAecNT+sD/X9twtrogy?=
 =?us-ascii?Q?TqEik3T+UK38z757AgdwrFP06qEwFTp1e3H3mMIPRht2h9PGho6bWnVmvuAk?=
 =?us-ascii?Q?u5NUywnTkqAo5vdnTn+EEC++LEPjbItG4oWaPXOJV90vJTcGiH8nsN8sJKWf?=
 =?us-ascii?Q?XZXWkEQzO71kwvP/3zBCDDP6ncek3pIchlnzTSjho3rc8QEp5HWc9sMoJWhQ?=
 =?us-ascii?Q?ieZpyv9Gqt80idP/UDCoaUsMPZujHQcsmvusyAh3dwI3Qz/JmHzFQB0vDmXb?=
 =?us-ascii?Q?w80QBx23oixAXCSbVmD9rrN3tVGtUM0UVOt/IN94/QGjBFUNol3Z01FzKLgf?=
 =?us-ascii?Q?p06e0dnWl2OZQIVxdpNTWKjg57YzKtVCp73Q8rC+Y9LDcgr6XoOBa1DHcyZ3?=
 =?us-ascii?Q?F91X8Ly01lAolJxeR4UJwp9CpDbOKf4G6iCHfMJxG/2NZsPixE64BXcYZT7s?=
 =?us-ascii?Q?efjrehtxXrjMWfKdLM2+oXRj8Q6DsZLqaw6NtyKsYXQgUbamz/bCS2h4C9xp?=
 =?us-ascii?Q?trd+KWUBTEjcez3uYN7H6Qaoe/Lg4p6CozzDi5PXsrfh+/thFEtLPRRaYWgp?=
 =?us-ascii?Q?JLAtF7nBxNegOB6JAvjBHMX3txy84fJZEFcTU26aIbzXFr8WWoUDNBBadjOi?=
 =?us-ascii?Q?KVVZ1nW7sE1xj/2RfliaC6mSBRVIsWdohCrOgptYiWnEMuMD2u4qJIju5Svz?=
 =?us-ascii?Q?dOYs6YDBf9nQKo+GAwKL29lhgq7KU/KGtK0ho1mqi8YDx1fsMM6dvq1z3mUm?=
 =?us-ascii?Q?TCNxfjojsxrhlwuTZrnGY34Khj4EvBzCOfPHqsfRTLlGDhbcGulbbYtL+1TO?=
 =?us-ascii?Q?w6JOwL9l1aU31g8Anr5kFc6+ztGOOt5XMFAzwEMmoRMbzeVS19YrMOf8a57f?=
 =?us-ascii?Q?mrPRCnrqtfoFpLsPH3k9oq/pXDmLwc7Tn8dJWsfpwGzd+VjDS97WnhiCPMf4?=
 =?us-ascii?Q?9zhJWTVFZljbS8NOcKIRN/hbCakhKYxN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:40:44.8532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380c1b24-2377-44e8-a687-08dca69859ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Gabe Teeger <gabe.teeger@amd.com>

[what & why]
System hang after s4 regression points to code change here.
Removing possible NULL dereference.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 248d22b23a6d..2d5bd5c7ab94 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -139,9 +139,9 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 		old_pipe->stream != new_pipe->stream &&
 		old_pipe->stream_res.tg == new_pipe->stream_res.tg &&
 		new_pipe->stream->link_enc && !new_pipe->stream->dpms_off &&
-		new_pipe->stream->link->link_enc->funcs->is_dig_enabled &&
-		new_pipe->stream->link->link_enc->funcs->is_dig_enabled(
-		new_pipe->stream->link->link_enc) &&
+		new_pipe->stream->link_enc->funcs->is_dig_enabled &&
+		new_pipe->stream->link_enc->funcs->is_dig_enabled(
+		new_pipe->stream->link_enc) &&
 		new_pipe->stream_res.stream_enc &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled(new_pipe->stream_res.stream_enc);
-- 
2.39.2


