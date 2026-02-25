Return-Path: <stable+bounces-219735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAtcKWSNn2nYcgQAu9opvQ
	(envelope-from <stable+bounces-219735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 01:01:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B719F3E5
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 01:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 138923018BCA
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A33EBF12;
	Thu, 26 Feb 2026 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1usAGt59"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4D17D6
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064093; cv=fail; b=sJBCHnnrNW2x+IMpLhiDW/7z4XbLmNVLW9aujkp3e+Zoa0rhf/kw4vTSvBY/Yxg+G66uw27CJKgrMd8JFeqrfiorqvVc5RaERO98jjj3pSz8vZ00PrSzkE2F18FwiSpFyUulMCx5iSS8CGzFs4YUmr9YISU5Gp3NoUMH2/Jc//I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064093; c=relaxed/simple;
	bh=M+WxzGbjORefaZmToQvNT22bXMl+OeYRhKPhI17y2+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oor3nCDo8V7pPryRMCzsH/LrFub8Ie7Q7SElNkcowlpdBFOO4xYYaicb/EgMkjNFBAQxZZmSntc43o/jE4GeqiMJEWBIVDtivFriee8mC6uF0cYCS8jNrUGCrAD/qFP83C/mTTfSknoXD2Y4ngx4sdujk8OC35jUmuwD1bGduzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1usAGt59; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAf+qPknX/t2qq/PGB4zOY8cPExWk3rNiLGEOFLP8rdYpltV8oY5BDrOPWy5W2gOyFNxFY8AT7zD69WQzhR7sGu78ZOJ6fpkRjm9WNL7ASuLPLdBDGllFuQ0CGoc3DTf/yRUsDt2NOgwCGvN9crTEKzDq55dJPpN7hOvgtFvY03vAf7oTg2XVZ8nt72B6A0eYksq5giv1XHV7GLs9+TH8IA8hc2rDFW8AvCxJwvdPXzV4SnTeNZFkUiR4VX3FKmG7931qbcDG52gQRlwjCper3pg9HR2TqWNTD4atauZ/y+JBA9wt6Nem37APs/F0RjUIkf7WOXyX60bx2dLeggvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnLrZ99d8gBIaO8PzNXZW2r/ZNX6mnHq4bYXCE4VSf0=;
 b=ltl/GyQ9rIiywCMiMCW+52C3d3HCzGRmqQxI1iGsp8AyS8L6dZ6LbTQAZmYOAZa1WDTk6tBV5GZgyBwymATWEdY7idcCV+7ObUkSwgcUY3Y55yiweNEnW6vPbvPfRSg4na/9+W2nJObQtM2pJX6by70CSOs3sEard7gFP5ROPrUPe1sETilcneaGyCl8h6EVBNGIn2l3+X+ZWGztP0lrDmHtxLAkd0FDJ0iYh2+U3jVlkxQxlOaVfJXXpEmqQ4yE7XyZcAx7+Mmw6H2Gy62gcOlTQbl0LlSr+Y3ZFvbA8N3eMPHp4OYni34cFs32gKbflU6aHjh6smTgtjzlw/vXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnLrZ99d8gBIaO8PzNXZW2r/ZNX6mnHq4bYXCE4VSf0=;
 b=1usAGt59+sev61v1VgrwUCHoTG7BaC3PcS629RL690XPi62TBSWE6tkPOAgyX68Idr2saPaniGEo+oTtL8IRxNQ8AaN4l6z96zL11yzd9vCi3OgTfFFPzJnH/Cioyr+r6xnx1GHzn6RjsWqC59eVr89RY9mdXwcCpPErOrUkdAo=
Received: from SN7PR04CA0094.namprd04.prod.outlook.com (2603:10b6:806:122::9)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 00:01:28 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::c7) by SN7PR04CA0094.outlook.office365.com
 (2603:10b6:806:122::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 00:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 00:01:27 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 18:01:25 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, Benjamin Nwankwo <Benjamin.Nwankwo@amd.com>, Aric Cyr
	<aric.cyr@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/8] drm/amd/display: Skip cursor cache reset if hubp powergating is disabled
Date: Wed, 25 Feb 2026 16:57:40 -0700
Message-ID: <20260226000048.68030-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226000048.68030-1-alex.hung@amd.com>
References: <20260226000048.68030-1-alex.hung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5a80ee-896d-45c7-4680-08de74ca3064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	YGf0VrClNI3ysAoVqI+C3ki9mkYU6X5OT1fwZ3RDyROEr0iyntC8Lf3l5izu/mhvQwU4apoCXgirY1/fE1D+nvZQWchdv3nCOQc7hK2T8YrwnCiJmyTsT7nTBdI+vC/35v8K2JXmGIt3wNIJuxjJntNtt8afXpuk3LKEAni0vt1kUwQLbweVgQTHfCO+e4UqtVoDot0I+amO0AI/MkFr9ozS99jsCzBSjbDDdStDfuELtRPkO4VXobxgMQMcINED+HUz5ujftoK5VBUvUu8NJVoICuVZsksGERfARx0pfXXRzsKTqHEpo9fkpkKDugd+5/jJ70vVkTtieLFNT9fi3PN/O45pPtyV5R7N2ZKh7+KCDpofgoCSnWGMRzUQRWE2C75RuRRFaCm9x2q6DQUimCUBI5U0+8bORB7OAZQ5Rf6AaLwfPqC4NlwSRuTdaQwalNm2lG4azYnzdVjVHqykVunAPX57cGw8ZN6n+O3o7t7LHIdAYGFaUt4a3O8mUKRORRH/ds1N6yeQMrmjin5qg6xzoIJEK408vkqHnThYoiFSolv5EVi4YZyc2FO0W8jMaO3y5/SCR18xVZAzOkzrhyrDZQ5cEUuacvJA97FcArFRuM2M9ETN3xHnAi/7lF5JvE6TuiBPB5CJbDyf8WCpuo/9h9NFRr8ezzgXJziuP+LJB6rP7Qadg3NuipAt4qQ5p0YGBdQItbhnj8rwej10ahXdzQAk2CzzLhbXM4euNDgHOWiu1iAnLp0a4F2sA/Pq1seTJYIgForbqUaK9pZbJKWCq3G4QIVC0cQuwS0Jh3XlCBnF3wA6kM4XAWUclcsnlFUAtqaq7g8xcdmNuVWbCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/bME6HiRmfKdw5dDIpdGWpsViO9rWDDievUx3DobfTmLDkppcFy1dzFGl9kOAdv0JXBKtdt+DmcK1ncok3WMkkw4Z+09ogm6ERenuCGTC9KvJHa+N5bVYTxE6RWY6nc9zRBAuG6otC4OzltLoTRDz8efA9MBhjfOGMos9XH9ZDG277bnnOqqqot9PKSqs6OxKturKqhNcxpkQe3SuSx60p7BJWh2aKKRXTbU/jrnvTxskt8yS3fZ0TMW39HwVdN3yAY7ZU/1SsB+GqFA+cT67sZZger3cw/AkZp8aKLEClEwugiRjQo9WY+VVB7XzC/NX9kzP85B2yix/RVDO06b46vGyiHpTg5J8hAIo4HpNNouE1GwaYCKhw3OTJ1M3sUaJ5i7IwwMfK3xEq1PHaL9iFh9YmFstFXEVT6/GGWj34qPmhIBN6G/ytnce2pJUHW2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 00:01:27.6653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5a80ee-896d-45c7-4680-08de74ca3064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219735-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.hung@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 074B719F3E5
X-Rspamd-Action: no action

From: Benjamin Nwankwo <Benjamin.Nwankwo@amd.com>

[WHY]
On pipe resets, cursor cache resets to sync with power gated hubp.
But dcn42 doesn't power gate hubp which causes a discrepancy
where cursor registers are still enabled while the cache is cleared.
This ultimately leads to a pipe's cursor incorrectly retaining its
enabled state, while the cursor isn't in its viewport

[HOW]
Skip memsets for dpp and hubp cursor caches if either
disable_hubp_power_gate or ignore_pg flags are true

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Benjamin Nwankwo <Benjamin.Nwankwo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   | 7 ++++---
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c | 6 ++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index ce91e5d28956..194dba734cc1 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -193,9 +193,10 @@ void dpp_reset(struct dpp *dpp_base)
 	dpp->filter_v_c = NULL;
 	dpp->filter_h = NULL;
 	dpp->filter_v = NULL;
-
-	memset(&dpp_base->pos, 0, sizeof(dpp_base->pos));
-	memset(&dpp_base->att, 0, sizeof(dpp_base->att));
+	if (!dpp_base->ctx->dc->debug.ignore_pg) {
+		memset(&dpp_base->pos, 0, sizeof(dpp_base->pos));
+		memset(&dpp_base->att, 0, sizeof(dpp_base->att));
+	}
 
 	memset(&dpp->scl_data, 0, sizeof(dpp->scl_data));
 	memset(&dpp->pwl_data, 0, sizeof(dpp->pwl_data));
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 6378e3fd7249..a2ddf81538e6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -548,8 +548,10 @@ void hubp1_dcc_control(struct hubp *hubp, bool enable,
 
 void hubp_reset(struct hubp *hubp)
 {
-	memset(&hubp->pos, 0, sizeof(hubp->pos));
-	memset(&hubp->att, 0, sizeof(hubp->att));
+	if (!hubp->ctx->dc->debug.ignore_pg && !hubp->ctx->dc->debug.disable_hubp_power_gate) {
+		memset(&hubp->pos, 0, sizeof(hubp->pos));
+		memset(&hubp->att, 0, sizeof(hubp->att));
+	}
 	hubp->cursor_offload = false;
 }
 
-- 
2.43.0


