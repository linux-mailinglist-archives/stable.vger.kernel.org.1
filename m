Return-Path: <stable+bounces-54741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D5910BBF
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594BD1F21B7E
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A91B1420;
	Thu, 20 Jun 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vIJTzYy6"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701452B9DD
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900204; cv=fail; b=ZAZ24eA5HJmwLa1diovWYJ1l1Dun+NZ+sa7/ZDRHsLHIlCiIsiszKfQR8eVTdHQq+US1UyAEktQ94wF8hnvi9xkrI8GJ+PqW5IBUZU4DX0h7LxqRKCf5em2WRC2YVj6fTTQV0kMBjix1cQwNrjCvb4jzhHMcwrvrWe8ke+5GhRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900204; c=relaxed/simple;
	bh=A6/a5rLHQwR3AjmvzEWTFrIf7dIuaXH6WAd6KF7yO40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXuxoq52KW9BY7s9MtXcgEM/t+INiw55POmUwhAFo/OOhnTF/oWrFruHWXlvMp/G3GgHdnXEIxv4Rp7C4RN1g9nU7Cjy0CXhighe7hF9ftBrA77xYvFTDK0kUKtUuIQb6AxKZKvDvTqHADrTw9Ve/1cWv3l6guH0RbVBdEaudIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vIJTzYy6; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGgMh7YW5GOb85i0w20KsktvXQPZQtT8vK6p4MUec02hgqO3fcg7rKgqd1AAvsfr2bujW8yAba046BGJRZpJ4lELHPL3CN5vFu2boEfkLoXM4J3zduumA6Ah1aE1n1BnJB+m/+HWCS+TCHw31PR/72ve6ma0ju8JTb2IDfJAEDiXwnjZDYclBecnhQ/UNaliuP7ejBQvabmH4jET1FKATvDxlberTo9TKhiipBPDUOcBSPMRdABeN9bAU/X6Gl8rc41OmjhF47ifNxqSHOuObg94jtQGgGTVvL5Z3yAsqZXn4VWTXJ5fJAlxNF6yhlgMln3XfuLIFR7DUvM+pIQvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f56dujnCf89zcGXdgh9U4eWB3513tPpTBycJxQOt1xQ=;
 b=oCeQWL1toZKy6ynThsvphRYA+5RAVlfJHX0iZcDxxGWj6anOnMPT2EA9uUqiQlpcYeRwUinH5ALiguFvyf3qglTqdf2DMpqCmGjiglzWJ9s0P3n5fCiB4uWbh6VR0Zhhrs10r8I3TXZaCey3jcZprMCxYxfYuQKTQpdTrINCMcte4U0BZpv0nDS+RDaTFbFzdOm73AVdPMbu9FXziX0vKYLyPZu2XVig/aWklyJ9H4T/RgMozNLvFwZq372oUkr8VSGWO7C6MO3ASS7LrpnH8b1nxiMHd0jZ1GYz3R4BeTZv6jV7gwn+sX4DWSEPjh8XtUWGh40uTYwhKH9FAs1m6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f56dujnCf89zcGXdgh9U4eWB3513tPpTBycJxQOt1xQ=;
 b=vIJTzYy6Yb57QApIfc+7f2D0EZHk6uqQyopjwoIvhrvoaYI7wdBYwPqx5BzQqy+lJBYRmjtFf2H3txF1ZbYTJSfn+pXk4CfzGQhkacxJGe8p2BzHaxo4V9U4Dz75Z8rLbSc+rFn+UIiONUxXQSk94cBgy8ZupLRurxtLeK/XEns=
Received: from CH5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:610:1f1::21)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:16:39 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::61) by CH5PR03CA0023.outlook.office365.com
 (2603:10b6:610:1f1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:16:38 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:16:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, George Shen <george.shen@amd.com>, Chaitanya Dhere
	<chaitanya.dhere@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 19/39] drm/amd/display: Call dpmm when checking mode support
Date: Thu, 20 Jun 2024 10:11:25 -0600
Message-ID: <20240620161145.2489774-20-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfb35b7-3512-4286-35fd-08dc91445d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AW3UHnl0ZsVJguCoZq3Y/+UndKsSPui/gQgUcP8b4VukBBHmFSBt0yutjRFV?=
 =?us-ascii?Q?RA1boinzi3mIrdXIBGZLqQkBWb1VYdvhZSlhitGeqzGYaHMF9+MJe+1bJXuM?=
 =?us-ascii?Q?2iN0qzZCqkQccUKgq4XhtrH305FysDBncj80AMyn+MbvIDHkitQDVyS2qMiq?=
 =?us-ascii?Q?YvmwCJf/PXkXdQkYwDqUaRrNFHIdP/9LESJvaXIK5FojmiRsshei3yIf3Tnf?=
 =?us-ascii?Q?oc8xc4KnyEdHcVzt7d4GvYErO03kDoRtP564zySIz0RrzJjtvHWY7LlQ8HHR?=
 =?us-ascii?Q?quYzrXb3QFmkEy/lTVdrWPaNa4jE+r+H9F0sqYUI0IYn4Rn4Wf7Cov3J3gSS?=
 =?us-ascii?Q?9YMiuLDvlqADRSNwe9Z7z6iz7t59scf8VBNpJKZ5Er7zsrwA/QdsaCmV05wy?=
 =?us-ascii?Q?jPkBIW/2KWfFEVIVRKJ7bJgSIozd1Jou43ukHXjUWRGvsPf6YS6XLden4zP0?=
 =?us-ascii?Q?0VzwrBh+GVB2eaH1LawuaHUSGd+ObI+5sNeg/3vCGLfH+zrRiqZFe5PHDKie?=
 =?us-ascii?Q?4CPtEXtZvGRmyP9I2KvUG0MKZEU/anph7Cr9wQzT/289fQLbKtzBOnPFJsSc?=
 =?us-ascii?Q?7PZJnFsIk3y0GeUkMjwfZtIEpH0Ef4nr7HftKDztCCrz1XAZ5Exb+UPJEjsr?=
 =?us-ascii?Q?bjEUJHM2yGMYYb6M7jY0QRe53IhAelly4hgdkBxupRMOO2W6U0DhkdVZXMFr?=
 =?us-ascii?Q?QhrjcGkXIuAEkmMNhlj6XOddY4wneh8azSzeg1NjWo0pZFPGjhKxi8V+d5Eq?=
 =?us-ascii?Q?90ZvFAPN07zSAyCLWum5byGYe6/lBAG6xRzYKvsQt7+bOYPEisBcsHtgvp19?=
 =?us-ascii?Q?UYtZ1aqGTQiHLciT097ToODjbGt8Qpda4o3KlAyio2XpS4Qsro8rKz9g3WVU?=
 =?us-ascii?Q?QrT4KphfZPEn261piEpOaTWZ4tv37EcCnK7yBU9x0HRkEaVHQuy5kwX+ZVwx?=
 =?us-ascii?Q?/B3RwggngFQAl9Erd/oLyVBNNWOh+4YcMUmnkHmkkGrOrB8W1TjR0/W4IjmH?=
 =?us-ascii?Q?gLoyWm4QBKmDsK65iXsAO3V5XXPH7V7TZRHoQ5iPjkuZzD4G1QzW6QZ1yY3i?=
 =?us-ascii?Q?/jVvgnsEB5jdEpLwNDfwdcSifcOH6676Q9I9uCzRuzWtm3GXWTAU5DkuLOXf?=
 =?us-ascii?Q?EZFIQLsns4FqZ+NA3ScD1dfqPTdAMpfRtm0enXz1k0AOCOFsOre9EikfcFR8?=
 =?us-ascii?Q?vcusaB9Kguo+4Gi6wmI7fMLiw/dAepnaLaqxApzFdOX1mYuk48JIQDQaPF4v?=
 =?us-ascii?Q?8RjJvwlM33skooHrjAd4zrUFfmD3wiXuujfYgeIRehyHmDV838Aj7ptdKBHh?=
 =?us-ascii?Q?9WqSBtekPuppZPGpqVdMjxFVsJ8Nkb0IVBpHYC0lncDy7ppvpwFA+nxJtPjw?=
 =?us-ascii?Q?BZW5R0ER8nYan+7Iz88UFZq/EbmWESY2w1GubIs+76mjGmsv9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:16:38.6205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfb35b7-3512-4286-35fd-08dc91445d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838

From: George Shen <george.shen@amd.com>

[WHY]
In check_mode_supported, we should validate that the required clocks
can be successfully mapped to DPM levels.

This ensures we only apply dynamic ODM optimizations to modes that
are supported without dynamic ODM optimizations to begin with.

[HOW]
Call dpmm to check that the display config can successfully be
mapped to a DPM level.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c   |  1 +
 .../dc/dml2/dml21/src/dml2_top/dml_top.c        | 17 +++++++++++++++++
 .../dml21/src/inc/dml2_internal_shared_types.h  |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index b442e1f9f204..9c28304568d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -257,6 +257,7 @@ static bool dml21_check_mode_support(const struct dc *in_dc, struct dc_state *co
 
 	mode_support->dml2_instance = dml_init->dml2_instance;
 	dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
+	dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params.programming = dml_ctx->v21.mode_programming.programming;
 	is_supported = dml2_check_mode_supported(mode_support);
 	if (!is_supported)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
index 6f334fdc6eb8..2fb3e2f45e07 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
@@ -96,10 +96,15 @@ bool dml2_check_mode_supported(struct dml2_check_mode_supported_in_out *in_out)
 {
 	struct dml2_instance *dml = (struct dml2_instance *)in_out->dml2_instance;
 	struct dml2_check_mode_supported_locals *l = &dml->scratch.check_mode_supported_locals;
+	/* Borrow the build_mode_programming_locals programming struct for DPMM call. */
+	struct dml2_display_cfg_programming *dpmm_programming = dml->scratch.build_mode_programming_locals.mode_programming_params.programming;
 
 	bool result = false;
 	bool mcache_success = false;
 
+	if (dpmm_programming)
+		memset(dpmm_programming, 0, sizeof(struct dml2_display_cfg_programming));
+
 	setup_unoptimized_display_config_with_meta(dml, &l->base_display_config_with_meta, in_out->display_config);
 
 	l->mode_support_params.instance = &dml->core_instance;
@@ -122,6 +127,18 @@ bool dml2_check_mode_supported(struct dml2_check_mode_supported_in_out *in_out)
 		mcache_success = dml2_top_optimization_perform_optimization_phase(&l->optimization_phase_locals, &mcache_phase);
 	}
 
+	/*
+	 * Call DPMM to map all requirements to minimum clock state
+	 */
+	if (result && dpmm_programming) {
+		l->dppm_map_mode_params.min_clk_table = &dml->min_clk_table;
+		l->dppm_map_mode_params.display_cfg = &l->base_display_config_with_meta;
+		l->dppm_map_mode_params.programming = dpmm_programming;
+		l->dppm_map_mode_params.soc_bb = &dml->soc_bbox;
+		l->dppm_map_mode_params.ip = &dml->core_instance.clean_me_up.mode_lib.ip;
+		result = dml->dpmm_instance.map_mode_to_soc_dpm(&l->dppm_map_mode_params);
+	}
+
 	in_out->is_supported = mcache_success;
 	result = result && in_out->is_supported;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
index dd90c5df5a5a..5632cdacb7f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
@@ -870,6 +870,7 @@ struct dml2_check_mode_supported_locals {
 	struct dml2_optimization_phase_locals optimization_phase_locals;
 	struct display_configuation_with_meta base_display_config_with_meta;
 	struct display_configuation_with_meta optimized_display_config_with_meta;
+	struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out dppm_map_mode_params;
 };
 
 struct optimization_init_function_params {
-- 
2.34.1


