Return-Path: <stable+bounces-42851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350738B85FA
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AC81F23572
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF674C635;
	Wed,  1 May 2024 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="leVSCRv5"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E357F
	for <stable@vger.kernel.org>; Wed,  1 May 2024 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714547995; cv=fail; b=c6UGbtXEJZldh4725Wd1PC85RzYeusMlAlGR0L0lgcOhf6gK5d0ju6bcOw293j8UeBk51ra0UQr3Xkj4CJ6al3HkP+LB2Up2i5klTRrnT7S9rUZS3IPopFs6ZlvRI2nsyro/GQ7818ki05PwRpidXqVlTXDNU9aNDlscMJBY6ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714547995; c=relaxed/simple;
	bh=46ExRwx3SjzNN53cTAPFU9sz1QWInkzSLN1+tZmgPT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQvgO38Vgu76AhhrM6Foh9Rn9F2OOYcRM8xvTpL4z5+wHi/isi6sl2NmPp5gqpO7ztH3Ag7ijr2wkHN7vq1z9MVvnhNPeY/sg9oE1XIrgP2kpBg37LG+IwYoAZkyxAOqbwpAkHWWpCNk/EGiAPAPSzLwCE9FrE8C48WHH0AXS0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=leVSCRv5; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etUrWbYfD/Oz6ynBSHzn7MDjfMTKImHpWm4j0sAvlF0zPg885dvVnd68LKgNbkfASCXGoR/w0UYX+LY6/aKdykvLTCzx8arsjpltoHKYHdPca6UHMtCszUQ+jJkiqrKkRJqaihpxRUFsSf3zB5FNfz14iLBK8oJaHH4CEfgpjS9KKAjeHHeD8BZU4AOh4LYp01sJFOaKyrK3FjI/gv9TOJ8CakejaM9Tf8EUoNMhgl7S4wzkJZegXWyNkgbOchiJyjv6KAvmeKWNUeIu3YKjA2soaA0G5peSzhaUTkFMNZmdcMRjhyliWkz78XgKhIxuj3p5QYbCHgcCrDGhBkEJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3qZqrBtF9X4fvuhPuso62sNYXRhhcbEVEAwuXmxbnE=;
 b=hAOSdOTHkkhnkfclpI4JetOhF5AWhfrFZ/zap2uKDCPEVaHQtbi9gxWeh/zcSwM8WT/O37dpgl3BRnI/DKontXfMAB69B6wurfST6qXhnqwONWHqCaEWPDpiBUXy+Vna6WVHeAHVgE88FSaG2/rvF63Q2RugC8N/G9MyU56MxH0x1OVPmviwix4k+vp0D4WwBOj6ZR3ojAU+eFD2TuHKSFA5XvTKsf+n9pXiA/iERHviOrhDJqVxQlnzpAtFYqs+9xeASM/EUELaREjixvTg6oTGa2E4cyKG/QX7Wv2/klhRjzp3e1tQoOTHIqCeD/kI562diI8HXRDk0ApSieX98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3qZqrBtF9X4fvuhPuso62sNYXRhhcbEVEAwuXmxbnE=;
 b=leVSCRv50cYNpziulh5WPfvF00tEWXeQKe4ed0AKz3fAgNDsj/AX091sAN8Xz+QkaM0betLjnAUz0Nai7OhayG8hAgIV8NB1tzSEHFOFxvclUGqLqiU9eMmwF0C4MpNg9Hf6w/FdUh5r7bEwCtg+un4YeMoHFDF59f5bCFkNJm8=
Received: from SN6PR05CA0034.namprd05.prod.outlook.com (2603:10b6:805:de::47)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:19:50 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::b6) by SN6PR05CA0034.outlook.office365.com
 (2603:10b6:805:de::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 07:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:19:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:49 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:19:45 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
	<nicholas.kazlauskas@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Charlene
 Liu" <charlene.liu@amd.com>
Subject: [PATCH 28/45] drm/amd/display: Fix idle optimization checks for multi-display and dual eDP
Date: Wed, 1 May 2024 15:16:34 +0800
Message-ID: <20240501071651.3541919-29-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c77250-b58a-40fe-1b84-08dc69af16e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eBcl9W7zfWMsGb7zE2IIJ7fRNsVoaPy/UedYnH3oJoI2XL8UaSybs0XqyQsK?=
 =?us-ascii?Q?Mp+JP9DCL1eJ3kKa3zkULWYiAIAcmjGNyYvI6C18BmMyIOqcMY3aZTyQx3+2?=
 =?us-ascii?Q?ZyIvA42XRXaaS9k3hW39UC7SDzppA3ldeaJEuXIvblwEB15OwkY3hXZWVvNq?=
 =?us-ascii?Q?wvN0WW518lvtmUz6sw9WuYf7czw9nN5D5LZ8UzaYEmRkVgDstyVbwd7quIjk?=
 =?us-ascii?Q?fHH/KPmCjLbbvb1lDz1Saq4NImswcQvHofua1fDk0fITQ0FtQZT2hDinOK9P?=
 =?us-ascii?Q?yrA83Oi1vLTRzowPooGH0rgT8EhntjGLEieXDFqAKM/qrqaxscgfBw0FAOc9?=
 =?us-ascii?Q?HgmTGfOOnZLlf4zRC4s8BbXm7Mn1SejSdV2/I9+wh9Jm4lG+gbquiKY2xpUC?=
 =?us-ascii?Q?7+7xbgc/Q4/GOk08GEm3mHxyxzHRPhSh4ti1HqHRwz8i/nM0tm/+qrHpbMkf?=
 =?us-ascii?Q?coaBUL5OkbiSuLTHmf2+aGnUjvQhebH3cWcjcMWv5ouphEZM0XteqyTbBPsR?=
 =?us-ascii?Q?sEoEGwrGcxjFY4ALhQWs6lfeTehnf9SbbZulaceBcgxRTayDQWB1SQ8oUX8L?=
 =?us-ascii?Q?55ZW/EHlzhCafKzBnizVuuG4w/vnhEdzE5XxIrfAhqIyhSi5GEZu8UN606C4?=
 =?us-ascii?Q?GVMdWERDlLvqQNzJDlNhgc6jZ/7KlpQs0bSL0ETeQu/bYjKBYsCMYE84DIK2?=
 =?us-ascii?Q?mzYwJhjbYFYt//Bf7TurDb2m7z4I/DQeY9n9bfYnuL/mplJWE3U5gvjTHsBi?=
 =?us-ascii?Q?S3C/5CA6B2QunybvHSZtSKjB905GIRH0KOQAhGQMhVpJU7t6s/oLV3310fgc?=
 =?us-ascii?Q?nBSlKZJORQxUVtl0mIOwtMryzC93yHHrldsRTl758jkDiA163vh3ZDlAxhNM?=
 =?us-ascii?Q?12oGYoTxvwtT1coWKgPA4E7YUf3tLIFUjSBol9sdtInueaS56qTHRolj5RBC?=
 =?us-ascii?Q?1nHvYK57RWSogzAnqlRNE1qEMYrsxBi31Wqx77pinLyuVu3xbHHGaYVI56eH?=
 =?us-ascii?Q?FSIkHL4P5VNj+X4r3K3fxU+vEWYs7mDUT1U15DQEJf/nfSWOicGXxn6hMNL0?=
 =?us-ascii?Q?k/Blfp1obFXd0AN9WpxlwStn6vGS41+Yy1rLQPkzmMqE3XsnXxnqUNGoWZ7D?=
 =?us-ascii?Q?CdRuWqe0gdSnfIBMYybj3MioNyy7tPTXKWMEMga+QQAPb7n6YxnIY3bvw3es?=
 =?us-ascii?Q?Tve5lgU806qQn3pOOnPaFQCdw5Zjcl2uqu0cGa5ka8gcuX3rDw1DPuxFOfe3?=
 =?us-ascii?Q?xKC4yiCkFqByCRvei56xNSoLCY1f0JIiAKz5oDH8/DNRGfHEpft0q+H5Eu3a?=
 =?us-ascii?Q?QrfAB1P/phsAbELCMd6Dtm/ea8nKBh9/Fm3VovbXjdFTRqUME5I2AjIMpwBO?=
 =?us-ascii?Q?eEALxSs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:19:50.3318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c77250-b58a-40fe-1b84-08dc69af16e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Idle optimizations are blocked if there's more than one eDP connector
on the board - blocking S0i3 and IPS2 for static screen.

[How]
Fix the checks to correctly detect number of active eDP.
Also restrict the eDP support to panels that have correct feature
support.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 1c71a5d4ac5d..bddcd23a2727 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -660,22 +660,43 @@ void dcn35_power_down_on_boot(struct dc *dc)
 
 bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
-	struct dc_link *edp_links[MAX_NUM_EDP];
-	int i, edp_num;
 	if (dc->debug.dmcub_emulation)
 		return true;
 
 	if (enable) {
-		dc_get_edp_links(dc, edp_links, &edp_num);
-		if (edp_num == 0 || edp_num > 1)
-			return false;
+		uint32_t num_active_edp = 0;
+		int i;
 
 		for (i = 0; i < dc->current_state->stream_count; ++i) {
 			struct dc_stream_state *stream = dc->current_state->streams[i];
+			struct dc_link *link = stream->link;
+			bool is_psr = link && !link->panel_config.psr.disable_psr &&
+				      (link->psr_settings.psr_version == DC_PSR_VERSION_1 ||
+				       link->psr_settings.psr_version == DC_PSR_VERSION_SU_1);
+			bool is_replay = link && link->replay_settings.replay_feature_enabled;
+
+			/* Ignore streams that disabled. */
+			if (stream->dpms_off)
+				continue;
+
+			/* Active external displays block idle optimizations. */
+			if (!dc_is_embedded_signal(stream->signal))
+				return false;
+
+			/* If not PWRSEQ0 can't enter idle optimizations */
+			if (link && link->link_index != 0)
+				return false;
 
-			if (!stream->dpms_off && !dc_is_embedded_signal(stream->signal))
+			/* Check for panel power features required for idle optimizations. */
+			if (!is_psr && !is_replay)
 				return false;
+
+			num_active_edp += 1;
 		}
+
+		/* If more than one active eDP then disallow. */
+		if (num_active_edp > 1)
+			return false;
 	}
 
 	// TODO: review other cases when idle optimization is allowed
-- 
2.34.1


