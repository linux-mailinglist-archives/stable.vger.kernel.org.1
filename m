Return-Path: <stable+bounces-54746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD6910BF6
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493A81F21BA5
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578381B14FA;
	Thu, 20 Jun 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3SkEsZGi"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4F1B47A8
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900307; cv=fail; b=joAojwJx/5mFHD4+BIyfKehH/8wkvZT4oNcWZKfj9qkgPPvPosrTTJRecoC4v4Fp5WqS2Oo5c0AB0/P7TrT+xvoUYM3nEhf62i4/tQb22YuO5LXEUu2OK7PgCxCeGOa5W+n5DLmzSGrOyvuadHWiMI94B2C4vEJbIw0K/CZ4AgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900307; c=relaxed/simple;
	bh=j7AMXNS42atB4O04stcPhf+OONOn/bJ2f2VBIapr9aE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOHX1nwbGgyNcGj9xtWyoRGgdbzPnDTzChI6PRbJdryQ8WM6Eq1tXITLHAXrr3jwfYCsvsvRSIsstuKTjuKdtrcsRKPh9Tbv6ejlXt4uOmyk/KaTn/VAxgHlOJQfjjWQl1OH+7FOooJ70mtz7eawWSnKXA2TJE20I1SMGEBNQec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3SkEsZGi; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq8IdIOZ/Z2yJqNZgrLYFjvKlr32to0EAERcK4zUhSbaxazNEvqd+SUHbD5ARMG4uZFuSOJv4M+IyDhRZ3yPwjmlAdmC028F5GQZrgBQ06VPcpcLrGlCBWt9a1lzT0gYwJCz4H1b7Hmp/E2BckV1frglNQVXoOo//RrHjDHo9fJWBabun4lRmzlApQzRTTpN3K3hxjHYbuzWROQ40kO1s3Upl3JgAlS2sV5cpYJ6j4RnOTXfI+0+Q8NuXTMG8R6q6K014+GgQT875/Zdn3Bo2itMo0Xfhz341MvLkJZ3yFp8N4iDm6lNfp82S3/+Zc/Ccirg/xOBQx0+sKwyG0QfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5NmWurVfel4SODg5n5vwMR1DjrI/zxq0B1Gn0zxkVU=;
 b=Ng2kYxTbL1kJaY5k0nSUUgrKqfoozrrka8pL1M+1QsJZt0u/8JuMUG4aXelzw2V0yiMabe6S2LxQ4PzUOt/Eef+rp/IhNuJ5xPv0jYBX9L5B3B5NQac5KmS8KzeHBjRx0aoyxUuYQU74IByrZtwel0HtE9t+ZAjByMtyiaaCvzEJ3E9yJUX2gIusEOcvyMu5h7IxA8rg3c4gXeRtlsWM4KRI/HZsmlaa1W0xbIy0BUa7UBWKr3yozG2rCmPxzOXX8PncX0k06SwntAkXtubOO+02QVdNofenf6U+uS8mkIS8v3IDIPnMtBRnsLXKt12erR4ONhuWGuJuRYPhRBqRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5NmWurVfel4SODg5n5vwMR1DjrI/zxq0B1Gn0zxkVU=;
 b=3SkEsZGi3wE7A1PeEdshgZPTYKMJX6ZYd1s4q13Q5bjz3pMNvFEMzS8e3uC/oQTLter6Rh/SlVMcF8ldFc7LP2XnP15QFQs1l7wxihk+0OJTs4IpKA4WUZCw2fc+/Bc3MFNbJLpaC7WtE0tMB0Yz/3Z7n2b7nEeq7FBMgM1dxGA=
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:18:20 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::49) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:18:20 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:18:17 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Samson Tam
	<samson.tam@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 26/39] drm/amd/display: Wait for double buffer update on ODM changes
Date: Thu, 20 Jun 2024 10:11:32 -0600
Message-ID: <20240620161145.2489774-27-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: b51e9dec-89a7-42a8-d36d-08dc914499e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SWsTAkg3WIXGfXOn69Uwv5m8QWOkZo3+CaK0ek/lNGNYFgdYAEsFgnfCGnNt?=
 =?us-ascii?Q?dD1TCYsCO7U3W23HF0CDB2fTSdImIvwgKFjx3DDga8vEWRWLr0vQ/Lbpyojo?=
 =?us-ascii?Q?LSdVI58P6Mnoq39PLu5X4ayg2iNagml6fW6b/myOqOTpCGoS4wL+5IL/VRWP?=
 =?us-ascii?Q?hODaEE6CWxXFOyf8Iy0VUu1+mhuxA5D+Zi2pY5Y5xHv5woN0rLggDBDyeeNV?=
 =?us-ascii?Q?MYT0osgpu2eBBWBetbkOLfMvtxX4ZXgFyUnfvNsQuI0xQIgiI6nCAhF4nyrK?=
 =?us-ascii?Q?SnwZWo32TxYwNAx9Dx8fYWUqocrbaHyCpAMHFLucCZ7lqCBws/uQs7Iu+Qw8?=
 =?us-ascii?Q?+bQrAvq6nNunEvkXatgs9bldPf0E3Jsz5Vzut7fyDH+sPOG1uxaWlN+oH82S?=
 =?us-ascii?Q?LHRgO7njhhNNyA73ed1fdCu3ij2TwwEI+Ym6JNNjOISdN/xL6VfWQzqFRnu1?=
 =?us-ascii?Q?p19FIxaQNS0IZGGjk6Tb6YxHLV6H+718pI6QqV+XMROBgHQGN+/U+1kMBBhK?=
 =?us-ascii?Q?Plwjj1+zJDsZxFqXS9vEqIAhoACJKeyV5ix6kdBTyucGNBymhzWdySHLiUnK?=
 =?us-ascii?Q?pSd/J2BuQf58iVFdHscNChXKKpPnf8QhhWsItkqKopocTXupN0bLXFGJDfq4?=
 =?us-ascii?Q?ekmqHddxEztbRT0D8mV6CJ80QCsnwXaTvluXXhhsmCo9+9EtmjMPbZi/pcG/?=
 =?us-ascii?Q?YMV0zku7Jc3nfr5VqJhQfb0nVLavpidcwH57Rd/60jJKxQTEtJyLq+vwwmEV?=
 =?us-ascii?Q?wu8VVlSRXNOryKMcaCXGGjbzWZcidTDp+IQhypC8NK9o+ounG/qqKqVCb/mE?=
 =?us-ascii?Q?WxbM52/FkncxaB2pvQSJ0xGPQWJD94t97MYmoTAPZeBbbkIQSatKB+VjYxfc?=
 =?us-ascii?Q?SRCVIV40IZueALY+9m032uNG1+Ux+vcQjGVxTpzACe5Ph6ex5a7oKGUXO78M?=
 =?us-ascii?Q?y+jVL+l3Fq+DVC4qAxHHzUt1jE182Jbo9poBHeVL4lPTPSQlrIupfxrEQ8mb?=
 =?us-ascii?Q?tbn+/rTwdujXyPlaMF7UMjJ5bS7zmOws0oEqH1rfxwvKUkKGuYqFNIqy/4/G?=
 =?us-ascii?Q?kwnYxiAvud9079Wl9JHy7R+yBHCmpSSdZVnZ9VUGyBGjW0Jp9Xy4BvAPwv7l?=
 =?us-ascii?Q?OdUcPK9o3zPRwLQj/AH3sTHB7C6yqVP4nP+aATLnu0vP/VyGazfOepyocuWu?=
 =?us-ascii?Q?lhJnu8Uw+H3EBr0nF+0iHkQkO8AcSUlOSzryRhGbT2dPVtTeyzJfG1R7f9KX?=
 =?us-ascii?Q?uxDm8o2x6hqWO8oQTTUiAvrNJaThg+TLRVjA1xP1myMHz707Yy87kOeQah1s?=
 =?us-ascii?Q?vkhf4Q+hy6KiOjCRbYzAlMOZLvDSyC8PJOWO1BIcGmEBblFQeO8+JK2oMGAX?=
 =?us-ascii?Q?jaNbIxbwh4AR2kPNa3gtwSrNfQOJHAZ+GfRArOiqq8Q3+iZt8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:18:20.4413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51e9dec-89a7-42a8-d36d-08dc914499e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205

From: Alvin Lee <alvin.lee2@amd.com>

[WHAT & HOW]
We must wait for ODM double buffer updates to complete
before exiting the pipe update sequence or we may reduce
DISPCLK and hit some transient underflow (pixel rate is
reduced before the pipes have ODM enabled).

Reviewed-by: Samson Tam <samson.tam@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 23 +++++++++++++++++++
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  3 ++-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    | 13 +++++++++++
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  2 ++
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  1 +
 7 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 4d359bb9b1ec..36797ed7ad8c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2227,6 +2227,29 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		/* When going from a smaller ODM slice count to larger, we must ensure double
+		 * buffer update completes before we return to ensure we don't reduce DISPCLK
+		 * before we've transitioned to 2:1 or 4:1
+		 */
+		if (resource_is_pipe_type(old_pipe, OTG_MASTER) && resource_is_pipe_type(pipe, OTG_MASTER) &&
+				resource_get_odm_slice_count(old_pipe) < resource_get_odm_slice_count(pipe) &&
+				dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_PHANTOM) {
+			int j = 0;
+			struct timing_generator *tg = pipe->stream_res.tg;
+
+
+			if (tg->funcs->get_double_buffer_pending) {
+				for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_US / polling_interval_us
+				&& tg->funcs->get_double_buffer_pending(tg); j++)
+					udelay(polling_interval_us);
+			}
+		}
+	}
+
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
 		dc->res_pool->hubbub->funcs->force_pstate_change_control(
 				dc->res_pool->hubbub, false, false);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index cd4826f329c1..0f453452234c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -340,6 +340,7 @@ struct timing_generator_funcs {
 	void (*wait_drr_doublebuffer_pending_clear)(struct timing_generator *tg);
 	void (*set_long_vtotal)(struct timing_generator *optc, const struct long_vtotal_params *params);
 	void (*wait_odm_doublebuffer_pending_clear)(struct timing_generator *tg);
+	bool (*get_double_buffer_pending)(struct timing_generator *tg);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index e3e70c1db040..369a13244e5e 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -562,7 +562,8 @@ struct dcn_optc_registers {
 	type OTG_CRC_DATA_FORMAT;\
 	type OTG_V_TOTAL_LAST_USED_BY_DRR;\
 	type OTG_DRR_TIMING_DBUF_UPDATE_PENDING;\
-	type OTG_H_TIMING_DIV_MODE_DB_UPDATE_PENDING;
+	type OTG_H_TIMING_DIV_MODE_DB_UPDATE_PENDING;\
+	type OPTC_DOUBLE_BUFFER_PENDING;\
 
 #define TG_REG_FIELD_LIST_DCN3_2(type) \
 	type OTG_H_TIMING_DIV_MODE_MANUAL;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 6c837409df42..00094f0e8470 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -297,6 +297,18 @@ static void optc32_set_drr(
 	optc32_setup_manual_trigger(optc);
 }
 
+bool optc32_get_double_buffer_pending(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t update_pending = 0;
+
+	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
+			OPTC_DOUBLE_BUFFER_PENDING,
+			&update_pending);
+
+	return (update_pending == 1);
+}
+
 static struct timing_generator_funcs dcn32_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -361,6 +373,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.get_double_buffer_pending = optc32_get_double_buffer_pending,
 };
 
 void dcn32_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 0c2c14695561..665d7c52f67c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -116,6 +116,7 @@
 	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_DOUBLE_BUFFER_PENDING, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_VCOUNT_INIT, mask_sh),\
@@ -184,5 +185,6 @@ void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combi
 void optc32_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
 void optc32_wait_odm_doublebuffer_pending_clear(struct timing_generator *tg);
+bool optc32_get_double_buffer_pending(struct timing_generator *optc);
 
 #endif /* __DC_OPTC_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index fd1c8b45c40e..9f5c2efa7560 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -459,6 +459,7 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.get_double_buffer_pending = optc32_get_double_buffer_pending,
 };
 
 void dcn401_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index 1671fdd5061c..3114ecef332a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -94,6 +94,7 @@
 	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_ON, mask_sh),\
 	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_DOUBLE_BUFFER_PENDING, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
-- 
2.34.1


