Return-Path: <stable+bounces-27436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590CA8790E1
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 10:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490D1B221F7
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A876177F2C;
	Tue, 12 Mar 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sQSlE6CE"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A457829C
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235356; cv=fail; b=cOQnsVU78Xp8WnhDOAh27+UP4FF/Mz/lD+mQCOBt2ZtN+Kv1netly3T593cpNy44n4fcufyAVVfx/jpgSNKv7LztsMu1bmSFuRAlGCGMuIIl1UPc7nGRMkfiRP/URI+O8RwscH+iu5GrQrwWEDZIxIjayFmWqDZHxCHkAPSaZZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235356; c=relaxed/simple;
	bh=Gmoxt6Z3Pnfnsg3AD9NAMEhHGlQZeRIvk18x5n8/hvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXmy5ktnx2B7Yl4lh+bq/cYLfsu94YA69/4/n2n0GW8LzEKZN5cKba7RgtKdEhXQQcSPej6TTL8dK07NUOYYA3yQZHH6FBSPFKFKG/+qxOTGKO1coIaJYOnIXKBTmi/DdwE2p41zEkbAvEy0YdVw0/bKRcnJiE3DSWFATJZc8Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sQSlE6CE; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duT14pbKbuM1t8Bx8xI+9YtRg0ezxE4YE4GADTQHCyOuMMosb2Ieny3f51qYTWbnr2+T9pd+q8iPvYqHFxJb8+1Vo8xeU+muFCJp6YyXIDfMJMnGUQ6yQOV+OgLCkS9C/5ziybUfDINZscotHblOv4/lTc4l7H4t3bqW008qnlh2skpmOySymAaMn1tsB7cdFNtIKlEfjKRnqT60v0SshhNCjj0/fXU/XzxBIdzOiPGT4r4Jwwji2HznbjY34O6udqNzQWqidvqOC2t3hIAHhPbKOZhnvwHvl6gImRRNmXwBETirHzoEuwTZW09e7fgH/fBsH03+TPQDL1hxJrszUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajKHErVFl2bYo1EDkA1GpdZXk9Fzln6XK7qzmAQyses=;
 b=GYMl6wW7W9wy5ZyyUBme3VnwO1ZmFlh8keDLHl5WgKbx39b/b7NZchjLP8MhVWu631G76DM2iwggKNqGsgXUk2FPNogaviffYlgGcBHsg4aj4QD8+Go9MEXFcjDjcCByNWaidc3FftW3SYuhBI92CUCqHYJgQvdiOCVbS4rE059E7p8+ejb4QOLM2aM+weZ7rdWPuuBWCufVWTTYj39jUnsc8VeTgeHI87h8bNZO7VfItjjlPSc4xNVS3dbbyJkdsD/E2f8YCT4zLc/UItVCAEs32UhJfx3b8DImnFYF4DSA1twoKmMYSvn6oJ+LSXZ8O9g8Rl7vvpJISgogKUbDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajKHErVFl2bYo1EDkA1GpdZXk9Fzln6XK7qzmAQyses=;
 b=sQSlE6CEOtzNFnqO8XNsOvnz4N8oEFyyImdy+Mk9rT2Kkqtfnd6OBx8dL4WMSXhJOOpIOEK6voEbzttQyOruamNyQNuhTgzncAh67HujA5PXMHqFVSZOh9r0EVBZj3tR8YfMiKy4luzPnr3zFaP6PSiWOsui1ubSfaPNDorjK7Y=
Received: from BYAPR07CA0075.namprd07.prod.outlook.com (2603:10b6:a03:12b::16)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:22:31 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::87) by BYAPR07CA0075.outlook.office365.com
 (2603:10b6:a03:12b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:29 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:24 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Martin Leung
	<martin.leung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 15/43] drm/amd/display: revert Exit idle optimizations before HDCP execution
Date: Tue, 12 Mar 2024 17:20:08 +0800
Message-ID: <20240312092036.3283319-16-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc09383-9915-4561-11a3-08dc4275f1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+SFi7NYhecJ9uruE9bvSn1rH3l7PoZZnZ87phRXAyrehl8oNui9hTgrlkJ0MPY9kYe4RNSexwvpl/DtscrotcgLruEaFrfusRh395vMcEYG8w7CvkjdYh5kOUasp9cqS2SaiD9npXFVoS9KC+B5dwnf39jTZcmRcZDoPryPTEkvK6+EC7ZOboTbW/c9HeeQ694vqNfHePkHguqILFFJ/bwTLlJ52baLlYxzu617l41nu+JCxS8ouhaEPSuQUKMe96TvEBbsh4E/l2HvGx6EjccZ2bEBQ1ftfEHPeLWz3l6DZpEIsVBU/LNAiiJcJDjzCNt0h7LfOoahHwnw2aiW5ljnBsQLc5nE61l8kfblRtzSLLRB1ccLQsgtEHVzl/cAvLcsowjYfAzOjGGYyDLBuxm0jaOCAbjRWfYH9331Igg/m5qTLEQuiP0HFe4kMe+07FUv+wRMFxJ10/2jbrzCBddalvaCBgMgsaoMyfZl3kuXgtaiGahjycL+VSgLxh8NurkCPlvYCKV06BfwsusEkH/6pD2pehv+qcq88UtocA0HZknWyNceEcIP/iSVebab0EXVyJr4N1Vgxo+Xaf3PGGPS8CnQu0TLCI+76684KAMdsSz92rrlY3EEHpGJYlJZr5ExEymHHB1BVR2q3Ja8RPuvuzqHF/KQ0I+shim8tlJNjR8mbQ/rI023b6flGwyNIU6NweBGxRzwk7/www/GyrNcQDYn/L86AB6vnzH3L1XynbnC3UQt9YpZnyYf4J9LT
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:31.1725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc09383-9915-4561-11a3-08dc4275f1b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178

From: Martin Leung <martin.leung@amd.com>

why and how:
causes black screen on PNP on DCN 3.5

This reverts commit 520b0596f978 ("drm/amd/display: Exit idle
optimizations before HDCP execution")

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Martin Leung <martin.leung@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    | 10 ----------
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |  8 --------
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 9a5a1726acaf..5e01c6e24cbc 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -88,14 +88,6 @@ static uint8_t is_cp_desired_hdcp2(struct mod_hdcp *hdcp)
 			!hdcp->connection.is_hdcp2_revoked;
 }
 
-static void exit_idle_optimizations(struct mod_hdcp *hdcp)
-{
-	struct mod_hdcp_dm *dm = &hdcp->config.dm;
-
-	if (dm->funcs.exit_idle_optimizations)
-		dm->funcs.exit_idle_optimizations(dm->handle);
-}
-
 static enum mod_hdcp_status execution(struct mod_hdcp *hdcp,
 		struct mod_hdcp_event_context *event_ctx,
 		union mod_hdcp_transition_input *input)
@@ -551,8 +543,6 @@ enum mod_hdcp_status mod_hdcp_process_event(struct mod_hdcp *hdcp,
 	memset(&event_ctx, 0, sizeof(struct mod_hdcp_event_context));
 	event_ctx.event = event;
 
-	exit_idle_optimizations(hdcp);
-
 	/* execute and transition */
 	exec_status = execution(hdcp, &event_ctx, &hdcp->auth.trans_input);
 	trans_status = transition(
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index cdb17b093f2b..a4d344a4db9e 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -156,13 +156,6 @@ struct mod_hdcp_ddc {
 	} funcs;
 };
 
-struct mod_hdcp_dm {
-	void *handle;
-	struct {
-		void (*exit_idle_optimizations)(void *handle);
-	} funcs;
-};
-
 struct mod_hdcp_psp {
 	void *handle;
 	void *funcs;
@@ -279,7 +272,6 @@ struct mod_hdcp_display_query {
 struct mod_hdcp_config {
 	struct mod_hdcp_psp psp;
 	struct mod_hdcp_ddc ddc;
-	struct mod_hdcp_dm dm;
 	uint8_t index;
 };
 
-- 
2.37.3


