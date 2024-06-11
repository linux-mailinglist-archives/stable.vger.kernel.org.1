Return-Path: <stable+bounces-50173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 137529041D7
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 18:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B9B1F26205
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC45F870;
	Tue, 11 Jun 2024 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rlPW94jf"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550096DD08
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124757; cv=fail; b=jBxEEenR+zMqJRGsurkhjtrs+8iCVN+9aWlJCWV2jbeq2dUOAoIA/cHfK+eLvYdnrg5UubzEX70mxedWRA506lyf6gCpyZ4xic3+s0VD8pL2GWdYyf7x5yK6n1cZr95KCVGXzJ2p4AbEantXGmp8WYyb+KFx6QW8lWhOMJGt6RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124757; c=relaxed/simple;
	bh=nU50JliDgKXtc+29/TAWISQJD0xL0pfIzWjupLhbXTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAvDEcsuvuy1jIy7hcENGQWIyqdECVyoYzNrbxrb3xxM2fIg476RQ0rP36eUARfnUTdoCOhOVQWz32/bjIwPJ3RfMMx9IY6QtyL1uE3qvvRtO05RCHEcD6Zb4yieWK1EYBJ+QzoPUci7L7EJIEyFOWo8GaPAKx78XPsshmm2SAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rlPW94jf; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIqoFo4CiNrQxE5YZ0nyrVnKnfvFVEH4XHDHRHoRynMI78HjdvIt7pNKeY6U3pdYO4pPJIEmrHeHJ6kG4cmeEFJ5PJCYr1Gp56sdsOH03knqJhjsm0de1RO+mYVUM8Dr86Kx5UGktHqOWJ8DYe7CIf0gsv+zQ5CtjomFNfrKZZ1gP+35ImW5E8YNQeyrvHUJmTPnIUCUp3og1tg/hCTJyVTz2mSpHet3uJVFct4UL0IsoCM8wmODoqUAE/gqfPR1AHICxwNuRH7Dh41OnTVMAaSTHhfcK5mXwetDBGVcOkIbsKIx2M7+CRpiOhMyLS+h2P03oh7ZAl5sVClmiMQ+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vAiLKiQHeip6jOYVAskbX09vwcE/1lBM3PtnpUc4js=;
 b=ILROljuR96GLmZ5K/KxxEKaOrEOxVjvCWNEMu3C/YqwqYdQD7I+yJVJOFjuKLHHV5NdYsDpMPUhpC5XmBwy2vozaVGQq1zduIbrtSkgoygBMpNrN4857Eanfzi5v0LYQm986Wg8r6CEiXwbHsfMgRkAvBrgzkyBUclW6h51fZQ5wJNtCgbXdVto5vFfTQV2y0cdlVngIzMHTiEwEslcJfHgGTGvdODn6WvzFiTsDf6KI62edIG0c58RXRPHABwlS6PNdUr2Q3dTGnCFt0qwe43Zebc0y3oVhESzE/flXDQ3jWh/1FWpU/QXwYZZ1057eXS/wXJpiY6KaUtTfOJjrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vAiLKiQHeip6jOYVAskbX09vwcE/1lBM3PtnpUc4js=;
 b=rlPW94jfq984/SZ9y+xEw6mcIUyvF1++h7z46/o4YjglZVuucdGYBRjHSbqFz+B1kuKdJ8m+6w974mOHJ2tniHEqLG+JPOuzzClBciL8BbwXp4iYFg3lVK7OSKIVH/oHQ5ZOqSka9W8o9FuZp7qxsQTc0S2hn1pb8oabfaCoPG4=
Received: from BN8PR07CA0012.namprd07.prod.outlook.com (2603:10b6:408:ac::25)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:32 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::da) by BN8PR07CA0012.outlook.office365.com
 (2603:10b6:408:ac::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:32 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:27 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
	<Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
	<qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
	<solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
	<hamza.mahfooz@amd.com>, Dillon Varone <dillon.varone@amd.com>,
	<stable@vger.kernel.org>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 11/36] drm/amd/display: Add null check to dml21_find_dc_pipes_for_plane
Date: Tue, 11 Jun 2024 12:51:14 -0400
Message-ID: <20240611165204.195093-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fe911e-1705-4979-d17a-08dc8a36e331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CJy32k//bxt92z3EEpJ/eIJEmgIPwPDxkZ+Y1H/EJuPum6PapwikwQqQ0aC4?=
 =?us-ascii?Q?yv6TprlsO/cGIbkwXV+NeWYPh4vdpRxhu4rkJ4DcTWH1cvgYLOUL01R6Zbkf?=
 =?us-ascii?Q?jfzN2FeAWl8BIjiQLzDx3VcWVoXMp4qSReciwhs35/31HyQ6AG/BjiWNSIIb?=
 =?us-ascii?Q?Kt0RvV67LOV8YhfuS2aH9GZpmvBY6Z5XFy4O/LqnwSw19H+L/PpQY0myO/k5?=
 =?us-ascii?Q?5mSyblbwrUCobvLj+hYvrvqceLTIA+nXWXvgxUd84IvF48pO2FcCfZbALyYo?=
 =?us-ascii?Q?0TmZfIbuexYcdkMIU0gI8Lxz002hGTw/Oa/pLl716NtqyL2dwFdA45guf31M?=
 =?us-ascii?Q?foJZDth15iPvgBbfLzO19qtr7pA9byYOBXlZL/rCF3HEIjLfkb4OT+3o8n20?=
 =?us-ascii?Q?u0RNddUCu6D+mOny9CLFmfIkEMjYrj8KXwDADy/G0VWqb+1sQ8sFdwKlfu5T?=
 =?us-ascii?Q?nfEngEmTpEqTfwmnoq6uL8hoz+VSp4VHFueaVWbaFJwMSjHrLOMWUso1B4Yc?=
 =?us-ascii?Q?jStAHFglucabbIWBjLbmPPPwkL8ostMUR63OMGzSDQZLROWN6n8r+zUa6iR1?=
 =?us-ascii?Q?2j23mrCtD7CcLP6cw4+F6LnMSri4totQvG8VZ4mEPMu+bYPup8fIYpTCUJQC?=
 =?us-ascii?Q?IXPEwwslFAz178TvVsLOkB22QPH3lUdMaPGs57arW076z+v6+CWL8G9Zpsl+?=
 =?us-ascii?Q?BCTdmhwcyzdyfAw/TVnp5dqlgO0aaCdt9z0tXftSEwyENAzJBtCzPQJOgtrV?=
 =?us-ascii?Q?RlP86DNzG+ydP4Q8k2sxrts3QJAPMtOEKpEjZaHIcywg6SvjmkCxMABddeeo?=
 =?us-ascii?Q?in3VAYqaCGC/kvy6BtfiT7LQbZorZkWs/b/y1OYO1deMiwJ70/pS6XmWEuZH?=
 =?us-ascii?Q?ynaryHKNJ1wMGoPADmy2Xj1G5t7lGhf1sn5gKZ2OY3MKYG/QREJpcJpIOEr8?=
 =?us-ascii?Q?oX7gvl/xNjlVCJ/DNRoQPSsiuZVZRmA+P8q6eKP6VaNJhlQt9xRQE49rSvNO?=
 =?us-ascii?Q?v5YzxUs7AS35hSqQ7WD/e6euLqp+scSMA/HudhI4aXQ4kc3TUObaKpMJH09s?=
 =?us-ascii?Q?NG3qMLHC6shPb/uTYcwBLOPtjEFJgRnRK3iSXilyUloB90MfvQOBSJfqkMRJ?=
 =?us-ascii?Q?Q2/H0TtYyA01uhXipeK9FDlsmRDcigOUqt+ykHPHsGb6pzCsTDp8Acv7wboX?=
 =?us-ascii?Q?KfDKMDh3abPkTi8VfVgzJd5Wn90nHVywbljsOWsqwkLIe9jpHIjYcfeyTvYY?=
 =?us-ascii?Q?+xbb5BrPbJ8lATXO5tj5nhzPO6FSK/R8Kj/TZdSvak6ZgQLWo/MB4YJPlnTs?=
 =?us-ascii?Q?uNoyG9gpv9u81NsAwQUjwQG6fYvaKHoBIxwAtDX0UPyu5LIrP5fop33Ydy2N?=
 =?us-ascii?Q?Yni3kdJZqob/dJErV0bl6XPKZqnAtA3/U3RhvbBRgIpm16dypQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:32.3546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fe911e-1705-4979-d17a-08dc8a36e331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060

From: Dillon Varone <dillon.varone@amd.com>

When a phantom stream is in the process of being deconstructed, there
could be pipes with no associated planes.  In that case, ignore the
phantom stream entirely when searching for associated pipes.

Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c   | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index 4e12810308a4..4166332b5b89 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -126,10 +126,15 @@ int dml21_find_dc_pipes_for_plane(const struct dc *in_dc,
 	if (dc_phantom_stream && num_pipes > 0) {
 		dc_phantom_stream_status = dml_ctx->config.callbacks.get_stream_status(context, dc_phantom_stream);
 
-		/* phantom plane will have same index as main */
-		dc_phantom_plane = dc_phantom_stream_status->plane_states[dc_plane_index];
+		if (dc_phantom_stream_status) {
+			/* phantom plane will have same index as main */
+			dc_phantom_plane = dc_phantom_stream_status->plane_states[dc_plane_index];
 
-		dml_ctx->config.callbacks.get_dpp_pipes_for_plane(dc_phantom_plane, &context->res_ctx, dc_phantom_pipes);
+			if (dc_phantom_plane) {
+				/* only care about phantom pipes if they contain the phantom plane */
+				dml_ctx->config.callbacks.get_dpp_pipes_for_plane(dc_phantom_plane, &context->res_ctx, dc_phantom_pipes);
+			}
+		}
 	}
 
 	return num_pipes;
-- 
2.45.1


