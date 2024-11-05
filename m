Return-Path: <stable+bounces-89923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E1A9BD6EE
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 21:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A144283BC5
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60621219C;
	Tue,  5 Nov 2024 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eQem/2kZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85A1FF7C5
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838274; cv=fail; b=GyMFp0Qk/bojYhyeyMvpXm3yOcr/UvhDOdByCXAew0vVkl8Su0QMnBpvjmnw3gakpmj78fSUNFczpwrEW+agQgxHnikZq8kutxN/dYWGGVftj8DDL3rVpTCrsN8pCEoolXsPuJHZ3JtOFWzmebxDZfeOHNb+jUe7EuwmywgdX7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838274; c=relaxed/simple;
	bh=XKg/Ll5kztodqXaVShI7uYmoL7rG4mg0lYSxpqeDmBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ml6MV+39Td5UQVoWTs3pOmF4u8q8gTKrnLfNHNrs/FxcWAugc7mu+xDwnyza9mIyFczioGL2dmUTiCB599K2RcEnGCtuNNW0xKRxs1xt9+7O/SYYq5gCEkbb4/R8JfzI+c7ZAUdxA96WEWMO3As3Q81U1Ytz+ZmpU/cXG5q1pHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eQem/2kZ; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHmewwgHbmsMIaTNdoJBcyd1jjfzV8fd5FKkpxam7l5uPjLtl2Fpxl7HL1gfvsDqfCqoCMPv0VI+kDqD1tWwbbn3PCnI3RmkhfhpiS4NNTajVeXhXzY+CEkB0/t8rUD6ALPlk5bsutbFL9RXcv8SaABV6LdWF7YA+LVchUwE9IdGNZUvo/5ZMRdJ2W+LbmoubOxrZOhHxZzL0j6kYK9I81IFhNUzVGEaQ8Afu2yEWcOyRfyfJJvFTH7dFkkqdN65DDrZEnPpfC5voBoC/PSzSNFWWfVdYB5Om8KS6SYHSTGqx/1Yc7UcwZqVYBJ5LKx855Gp1+UpTLNHrK4qCOlUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnedXOB7ZDUVGSL0Ed7qEl93Indtneu5ewmoLlaYXuo=;
 b=j/YyPDOFjmJi+sJT1XCs9C5cV22HSslowFFENq27fiPk10/AT0cd+/LFeDrXztF8D0FkdK7hbKlZJw08EFUXQXfKun3Y1Wob/TsIjN7wK9Vsa1PFkDIzjWaP9zjNPC6rtNz7Pfk5zFDwBF2OLOFTwj5vrLd+/tOwlTjMuTsRK6l7NTIwzDSIdsVk9hSyqyTzsEtXC8nSQ8PKTtPnwjhDWeZuSdYl0AP+t/2iwtd0UwOcb7ReU0CEY32cMmXo2HE390RquvNLq5Nzrtd0mooZBBMZvZ9Wr+SHblXt5wLP5JWmwHeOnQypIaCZ8Y2GYBnAQZP77PMYGL4lLoIshhibTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnedXOB7ZDUVGSL0Ed7qEl93Indtneu5ewmoLlaYXuo=;
 b=eQem/2kZXgXhw7neiBmrw5UfUw7EoSGn9ejB4X2XP033ALOnygBSHoi+31/3x60XVgDT1i8xCs9s/4NNTbEoeANfIBg6HXnR4ip9BP59M1lKQjb/1m4+tzZQ6lmHZNvBJNfJzhZCXEOnVvKxm48qRCpsv63iifYpi2+6dqsSFrk=
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:24:28 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::6f) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:27 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:23 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Fudongwang <Fudong.Wang@amd.com>,
	<stable@vger.kernel.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 07/16] drm/amd/display: always blank stream before disable crtc
Date: Tue, 5 Nov 2024 15:22:08 -0500
Message-ID: <20241105202341.154036-8-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf7f2df-d42a-4094-b1a3-08dcfdd7d906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ytXoe9Ox7mKWs92rCZvR3CWOC44WoVVh7LzxdInCJMU2vQ7GUeZDhlbKUYxw?=
 =?us-ascii?Q?DuV8Zsw14skUJX7yDGItLMoTTwNbE6jXOoBVGOW+aWAeyV8tJG0teytMUOhh?=
 =?us-ascii?Q?u7icZg8DJ3oeqaWG0CjPWysgiGr+yFwwpL2kBWlm74AT+LD+Hfu2PPjQQHiM?=
 =?us-ascii?Q?bwNdEFCA54BKQZrFuwlDGQMXyATdOEwQmliblN2SL2t1QJU4BHXiPyFYUpeD?=
 =?us-ascii?Q?JYyKL5ssEZcp5Qk7S4vUbHO0oSqMj6am6CWDGoMUbaKffOj/RwwqgpI5NMlR?=
 =?us-ascii?Q?20wa6zDfhSlcNWtjBjahr17CpiyLvV0h39B+nyAOITpj8uIVS6FWQAQIj4z7?=
 =?us-ascii?Q?3TJ+UM8B9tBoG/PvBg4vt8ni2aXH0FGG9bW/LL1WYsasHyP4Q2pkspD1pZxO?=
 =?us-ascii?Q?wEHQbX5i0JOyJSs+8jgzeJb2ru+5dUOYFGSnTAzRqgIEE7xBoTCLt2GB2Ujv?=
 =?us-ascii?Q?p577RvJN7OdrctSMuqFcPr8T2QsyXLpBejmW7uu0kuySQSvIFmdLEG6+5Zb3?=
 =?us-ascii?Q?7BhlJeD+D+78TLy9TiOlhTQGndiLOyxxt433HYSvz2H1XKN6TeQFcEYkJ/9X?=
 =?us-ascii?Q?aKuwpI4UDf1pUNLAf3D//R5PUcWHbxb421HNC77AYYyAg8Ciww/5rfGPLGXy?=
 =?us-ascii?Q?bPDUZq3vt/0W/9FTVOeql91tgtMKBjFSHI31UwtqBeCEY7hVkG44u1Ppk8Rr?=
 =?us-ascii?Q?kZHsJ1t5cBoqEtGNL6BVEKBQvkxF7yaYUvVr6hi9CFt8rp2kbUa1lfnww9M3?=
 =?us-ascii?Q?FS2AwqwK45PHVo1OfGazcRO0bJPo1w4BXDI5KEs38Fqe7UxsoS/QT/Gbkiw1?=
 =?us-ascii?Q?c6bRFo78w20LF1a7WYza6Z1S6/5/sipoq6/vON0Wwm54uZfTSXqA5K3MMHNK?=
 =?us-ascii?Q?VY01XmJI4UwlwowYvt4flw685gnjxJFDEphJQzSc9TewE2iBZSdhyPU0Gd2V?=
 =?us-ascii?Q?nviN+JlsPL6DvxAaUMyS1BbvOm0Yx+NWQoTrJoFmuNtT/5WSUyhj3jT286nT?=
 =?us-ascii?Q?8l9tkQolzKmpkEZCH8BD31G1JZWshl9AXsCGGbTo4lejzfy1WOz2Q/iSQdsa?=
 =?us-ascii?Q?Kro5zT7io2wQnGm8F1ow39NOOn2KIgOkl7c6xz4QdtAPbYyc6OQ4GdXQkozw?=
 =?us-ascii?Q?r7NkO88qMarZmKOU2B+HSXXaWpP0GKqiQSNkXIZAELqhyDCdHTv8REO0RzIZ?=
 =?us-ascii?Q?sbF17Oqzrw6XBpmNWB6dK6I/Faz2Z2B9dGjJF9Lh87Q2/eilUYYff0sK2M0W?=
 =?us-ascii?Q?a6X3xxtu1++Fo6gUCkA8J0CliSHgJuNjtWdrzuH/2p7+0hGYLjPEdw3VZ+kr?=
 =?us-ascii?Q?4/JfOfWBICKGwJ/DCRVlROEY9/n3Jtms9UoBnCmlvSTOTISrs1xCSFeMkYcu?=
 =?us-ascii?Q?cfgAKck2LnuMFg2Frh3QQ4Q3XSZXCc7pxdk8EgzRbihXfp/5yQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:27.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf7f2df-d42a-4094-b1a3-08dcfdd7d906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918

From: Fudongwang <Fudong.Wang@amd.com>

Garbage will show due to dig is on. So blank stream needed.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Fudongwang <Fudong.Wang@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 036cb7e9b5bb..59b2e87317e3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -519,15 +519,18 @@ static void dcn31_reset_back_end_for_pipe(
 
 	dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-	if ((!pipe_ctx->stream->dpms_off || pipe_ctx->stream->link->link_status.link_active)
-		&& pipe_ctx->stream->sink && pipe_ctx->stream->sink->edid_caps.panel_patch.blankstream_before_otg_off) {
+	link = pipe_ctx->stream->link;
+
+	if ((!pipe_ctx->stream->dpms_off || link->link_status.link_active) &&
+		(link->connector_signal == SIGNAL_TYPE_EDP))
 		dc->hwss.blank_stream(pipe_ctx);
-	}
 
 	pipe_ctx->stream_res.tg->funcs->set_dsc_config(
 			pipe_ctx->stream_res.tg,
 			OPTC_DSC_DISABLED, 0, 0);
+
 	pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+
 	pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
 	if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
@@ -539,7 +542,6 @@ static void dcn31_reset_back_end_for_pipe(
 		pipe_ctx->stream_res.tg->funcs->set_drr(
 				pipe_ctx->stream_res.tg, NULL);
 
-	link = pipe_ctx->stream->link;
 	/* DPMS may already disable or */
 	/* dpms_off status is incorrect due to fastboot
 	 * feature. When system resume from S4 with second
-- 
2.46.1


