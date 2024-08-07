Return-Path: <stable+bounces-65526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E2794A23A
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 09:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C19A285737
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 07:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB81C8242;
	Wed,  7 Aug 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rjzloz2B"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6671C7B94
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017463; cv=fail; b=pokF2aYSgI1tgi3zn0NL08h4Y1l7fxS0egd/0+iiqSxYvEPgFE7RAp9h8emKTRwxyJH6JDDCqrEDi5JBEf+Hogb5hbBf5X2c23xreLM/8W8d2kwh5XWARWJ5ot2ZKGOZxWYI4fDiNaaXbm8k4hNfGFvlehVIPhJtTaNljDIUCac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017463; c=relaxed/simple;
	bh=CVH0qD4lbdPn++Ys32RESPJDxFebuKs0B8oJsr7Q95o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0t6CreCZeYZrCg55+dSwfY0PyzGjz8u2jnIYcCyGSXtRPc1aXfWIDTs2tVKfoRrvQvFNAwnocJcNIOf8s7a1wIYyvt6HXKnbvluV+Kb40MWeXBlURMvLuh3CMyVi9HJQwm5DqHzJqWneJI9w2oSRX9NT7uRiOgVfcw9CfALK8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rjzloz2B; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYyDRntAv2j6FINzz4EWOcg6K/9YLl21Y5sktBl2Bmj5Psjccr+MNRNdtsaVDSUkpXrjvecSBbSwLkpEhDRRX8IHf0yqtJoBaHBEUKQva8h3Hgsj4XuDqw2sVjv248VcnDSFShEp7UyqdrdJ4hO3pRc0NdOFxz5MQQSWbInEECUFygv+er4aqa+5jPd1LTPAEZccvXvTOLyM6LpnjkOU3FzHUrS+vCLRlgwN9AnM64hourGVeDAZgY/ddKxTy2e6F4iS6PtuMxcHJE5gGsgHtYGHV8uBt9Z6VOdgpCcCOo6Qngt3muQQFjlbgdlPeApkBfCQqgQBvDVUS1COD3T0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M1TVKM9G1Mv3X4M9JOIgbWtNnOX36iZ2Ty7etgcT7k=;
 b=opeXT5PsQCXaVhAktl18H/CuNUPXJBslVRBjMOyivH1pmzA0w1rs2+BjhvjNRYT0X4GqbZf+9QFoQBJ7MvSWRuQF+IrgYZfR1pRfV3WhB7gFpXRkuUcjS6Mo+V2vrK/idoTLkY8X+B+jNmd/DXSE2ye7wqtI269yuDjhlYVz5HGD+YpJaiCCHZ4znNz4rTXmTaoQQneVEsYWFOGyYBQj3gFirvMqdBKGQXFuct733Nxd49RMUIdObS3+jvG10dw/At4jTpJJk0rQySukSF6nqYz8CP5fkZ//yJYnXwVK76oAnWVa9AdxF4aPiEaH+nvs88A2I5NNw1vq7V4MqruQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M1TVKM9G1Mv3X4M9JOIgbWtNnOX36iZ2Ty7etgcT7k=;
 b=rjzloz2B9GCNuFvlxNyw/GhLKvSbhJP3HN+mPvgHa7J0CTkgWj8ocZGLPaSmHy5HIgiOvrOMeEe8waF+1TnjiCVYyaCAaVab9NsWTXzZdGklguvScDc/BYC8PoHLfuomRsNsIFKq4g6mZu/21/8NXaXmIMLZjw9nMtcXMVlRTy4=
Received: from BN9PR03CA0137.namprd03.prod.outlook.com (2603:10b6:408:fe::22)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 07:57:38 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::ae) by BN9PR03CA0137.outlook.office365.com
 (2603:10b6:408:fe::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:36 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:33 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 22/24] drm/amd/display: Adjust cursor position
Date: Wed, 7 Aug 2024 15:55:44 +0800
Message-ID: <20240807075546.831208-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 29cd77b4-55ee-4d03-573e-08dcb6b69af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uTvO6Kr1iIpVhI5hKXOw3O3xCBX7osNXMpK22p6Nit+/bW2YeWWOOHkCMX9F?=
 =?us-ascii?Q?ngvUB0NmevOaz+4Q8Wfcx/Xw4CvDgeGhsxuwM21sqpk4A5sLgM3ZUpUZvsAV?=
 =?us-ascii?Q?q9iS/InmtuN5PZMopoZtvY87oBWiXRSONbbr5fUB3F6iVkTtfTLQwXW7MYWl?=
 =?us-ascii?Q?hkOl+4pMc4VHD71/RMMfSuTv3lwQV3mvVO/5zoNleaxn0JdbfXDevjinnp27?=
 =?us-ascii?Q?ydjmOib4eFxQwqm/KargNUwHQHdXq3KdH9IAbbOJPSRLNYVIpj54BSQCEeu5?=
 =?us-ascii?Q?2iulb4XjJ/XpGn9ASrZpjsnMcOJ9VBLIoGo2eglWR0vpegC/ItirvFRN1sjQ?=
 =?us-ascii?Q?P25u804JVhK0w7i51UkekkMsmDEACIL62+LXjfIy0NSRKK5Q9aw09B6cWwNB?=
 =?us-ascii?Q?Si1HL2PW3A+G3L2w3hXDTTgu4vxToWSttajXDuuSmwsrVLIdvb2AZe6OeNOx?=
 =?us-ascii?Q?vajKC0HEg/gD1UWgq3WRTxypJ8uKdT2M1FhN3h3NCKci8EGkglZksKqNVjdK?=
 =?us-ascii?Q?8LvYAkFttH/4Nt+J7qManAIIm0LxOzaVAzEjWRWhBqSbveDrQBzIchePPfK9?=
 =?us-ascii?Q?mPGqxULcZrLul8IySHW+DAs5ZLN+BgplkMsSfNZAbyVxNWR7PpzHEz3zvFbx?=
 =?us-ascii?Q?9rBT2yzklpYAqsYKULAl/46FzxKfi72vpsPxSa9VFPuc95GGZ4YBdok7eJDA?=
 =?us-ascii?Q?p7dF25GO4c/K2IpUj6pwoE3epZJ+7/OACPCEQ7PSkMY0yUVw7Odj9O3Y6Kk7?=
 =?us-ascii?Q?23nrvRYk3+DiF7+vXYN14pulUfX5xvYm8xrs5ZvI1RaJPPa/1pCpmOOVWX9h?=
 =?us-ascii?Q?3pVwApAQ3vi0diDzuw79qZqFnHXKiE5VZQOXnIZg0vLGMIxRHlz+HSZrDnSH?=
 =?us-ascii?Q?9Oe6EicERuINLci5nlKz9U9ZgT1f25HK+BkeZ4YcOjJOHUt6w5b9nZNYCC1F?=
 =?us-ascii?Q?z+dzRi+Wb3pfGJMgiYZaZhSyq0gPIoR7TiXnvUid+Ad3EbZt5cAHCj3GeTgu?=
 =?us-ascii?Q?/P96Vtgo1+Ypam9eMAnrarosvYQiNtNF7ka/UAkNvQ4wwCoiy5Y2lKaLhZGr?=
 =?us-ascii?Q?1/CcI04KWquU3ROXtFV0nF8nU6Seu/OZkYNstgO+Tdy6tX8EkLvUdGQVDcxu?=
 =?us-ascii?Q?fvZu1AjCyarmflU9xw2EihKH22nHoNJorxGxr3HhVm4HK85OZthEu69WcKuh?=
 =?us-ascii?Q?BI9j23Wl6zXQLC33PYBH412us33tyzT6buESa2Javp6H4giDvpfrjiqp0rEc?=
 =?us-ascii?Q?EyMcs6UPJB89N237mfL3l9Cs79acpHvtYMAwj2WoZ1s8uL83c5sI4kacdO0M?=
 =?us-ascii?Q?6hT4Koh10N87Z+zH16w/bTWHGEb/FYW8AHss3Na/U/mWDf1utZhZMIXG38JI?=
 =?us-ascii?Q?694GpqKOqVkH4NcPOfS7d/UiFxB8W7lgbQnfSyk1Dz4vOq6973TgXIWWQ1iH?=
 =?us-ascii?Q?jS2FkZY+d/8VO9wReSmM5J9Nj6vR0DRW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:37.9412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cd77b4-55ee-4d03-573e-08dcb6b69af8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[why & how]
When the commit 9d84c7ef8a87 ("drm/amd/display: Correct cursor position
on horizontal mirror") was introduced, it used the wrong calculation for
the position copy for X. This commit uses the correct calculation for that
based on the original patch.

Fixes: 9d84c7ef8a87 ("drm/amd/display: Correct cursor position on horizontal mirror")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 802902f54d09..01dffed4d30b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3687,7 +3687,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 						(int)hubp->curs_attr.width || pos_cpy.x
 						<= (int)hubp->curs_attr.width +
 						pipe_ctx->plane_state->src_rect.x) {
-						pos_cpy.x = 2 * viewport_width - temp_x;
+						pos_cpy.x = temp_x + viewport_width;
 					}
 				}
 			} else {
-- 
2.34.1


