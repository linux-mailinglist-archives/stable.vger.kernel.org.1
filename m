Return-Path: <stable+bounces-27439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FB8790EA
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 10:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0121E1C21F3B
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C6B79B6C;
	Tue, 12 Mar 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJD0l7yr"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941948464
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235428; cv=fail; b=bWBjb6wdFoeTX7WoFm7sKMbZqGBoKgzIvV2cO6QBWatpD1tlkppzRTz8BXZtvkiN1CZm8oSojRmdU+lyeIw5rDMMLsN1M/FnazJgbvKbXGgKrhotMrMkEtI29qyjoAwxZwtzkQTvPfJqtvyT034mPbBOo/ThUhKSUB4/cx8Fokg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235428; c=relaxed/simple;
	bh=4AKDLObS+whgblxJtOYe2Y+N+12tmI8Y7B77L0MQb7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=so0+aX3EGbEPGKP8ZvrpGG/KwU7CP73MPRRo65r3aSPZpaMywAYDyjJMaudGXnVdeBrxU+rKh42F40YkCxif4xWBSIVaFCnpbgbuYctjPf2JNEPORL3Uv050WjGnc0ZF0LNZBvELgB0gYyxbMnKrNj8+Z7iHXsR3fTpdTKP+QF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJD0l7yr; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUx+jKrUXJDHmwYq2K44/4dSvfCX4EEY1gjWtFGItiu9hlnIfnC13UjTMjynMe4O3hxOLhgCyNlToFonaDxttt3HIYZQ+DvbTLzHQ7oFU0qEcGeL4t1WpmpHKySDDZip3+YUX6kfKQ4Ju8yA2fyNRftgNtvuUsLBS1hbB56JHwaWroS/4HQaD4OMisI8XbW6a5GeKcxPFZn0Lur1xUiX0/T93lKwgCVcqeBd1oOq6m5KlkWpIRgDQTggbwmEsh0DlZMkvOENwnAP8Qsh1YshjvAAWVJ+wXCCK4T2XheVBqxhQzai5XNiRHF2sALHmoFfPRFi2PrW37bEP/p8d8gQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImDZVyMycGhh97dQKon770vMNy2y0jpFQ+RG3fblygg=;
 b=cDi63S/UQyLo1fDSOeNovWvsHutFcQA89zVvYCRkMiFvHQ4+umiywrg252Qjg2M5aqyOHqDuUUwmkrvlQcRlR16Y89byR6oc70LJ0Cmgzh/CwEUdrMft+nI57oCXU2l1eHn9YyVvJOHqIbvOKJdaqGpyivGefR6ThKLupc4Byv3thIOWEztHLwQjniWH1ptH/CTgrY3pJEFSPhGrRvz1b4BEEbc4xJsfTLddNXDL1HK/RpPrfe/LpsG2V1Lvz2RoDB4u+E7IhqPD07iAc5xz95ZAuETegO2tKDSe8dQf1bNQvrkditOuDSpeUmC9WwuMK6xJNMEdw/Ut4DzC8Jl+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImDZVyMycGhh97dQKon770vMNy2y0jpFQ+RG3fblygg=;
 b=GJD0l7yrY4NMds94ITjw2BfAnSbI7G8GuamOFtZxQEa1BsrkbLEAmACVa3kch3rtZZtR8u8TArKP4Ip0IjpYGpTXjh96uuzws40W0mcJ/MVq9J/lqt2VXzsf1HnLtbaQ7Asuunx9TuSuTNiAVZ5oK/WsXWy4GKaNkmu61K4WXNM=
Received: from CYZPR14CA0015.namprd14.prod.outlook.com (2603:10b6:930:8f::9)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:23:43 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:8f:cafe::54) by CYZPR14CA0015.outlook.office365.com
 (2603:10b6:930:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:42 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:37 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Chaitanya
 Dhere" <chaitanya.dhere@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 27/43] drm/amd/display: Revert Remove pixle rate limit for subvp
Date: Tue, 12 Mar 2024 17:20:20 +0800
Message-ID: <20240312092036.3283319-28-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: e6eb01ab-54b9-4f46-34e5-08dc42761cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fWSGOJscG3D1BKM0e4WFErjO3eh8JbX/ymPtw7yiWDfBWPbDvoFirfOiJZi3WFoIxtEPjDuVAI2MIZx2aujP9eHiF8rNOh0cVrfCmjUlzCUAfl4m9w0aFE/vCBeA1u1wl+LEDIMgIf4CqkV2+c4XOQ0uBvxymDOav9krj7lUlFti2rluIKSZ0znh5/t+CdbrRwEN3+PphB0YMWO5PljqK7TPsperIr+OminxQlFNxpi9lKboC8fxcplFQgXZF9izpEOaGAQVxSlo1PRntwrn1sTUAKkDnLiMaF8HM176qU+cW5rQ4CHVULiFveBsJ6XM+hS2czIfpVVxSxd3VzNOFx9i4oNdblVzTjpnfyGh4uDUhhhJC79nUhGsj2FJrj4d3+Q1cuovEivtibs4e35gz5l/i4jSuxZmF1EO6Z2IkuX632K7JczrWkaFQDpWmIhfFSLlxq4+gJlFoX2u9IKzEAvju0i2J/MBzhdx/DeK1jhVnIi7AQK87lHBI6i7Q0kZ2EvRtv6SOHwRkeSTyd6HFp6Nc1KEx5bTWNhkXpYIH5VuMHaZRl0zKr+tccZaLNypD9avGjQX9UQrZUKOimR0ai6KXiRUr436O7D6djoMTVkC+Wz//oj+EHjA2nkLw4hSlot1ajyM1mUGKMBh6K8lEd/XENVZoQkeqHpiNff9Kj4Tv+6RBKSSKSiY1q90QXntlvL2+o0JMRQIbPFAEPIJ73ms7cpVlMoyH/w9s6CZxD3/JBVAeyp68mJ5D2cGsVIq
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:43.4934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eb01ab-54b9-4f46-34e5-08dc42761cc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

From: Wenjing Liu <wenjing.liu@amd.com>

This reverts commit 6cf00f4c4d5c ("drm/amd/display: Remove pixle rate
limit for subvp")

[why]
The original commit causes a regression when subvp is applied
on ODM required 8k60hz timing. The display shows black screen
on boot. The issue can be recovered with hotplug. It also causes
MPO to fail. We will temprarily revert this commit and investigate
the root cause further.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b49e1dc9d8ba..a0a65e099104 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -623,6 +623,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
+				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
 				(refresh_rate < 120 || dcn32_allow_subvp_high_refresh_rate(dc, context, pipe)) &&
-- 
2.37.3


