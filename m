Return-Path: <stable+bounces-25422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B586B76B
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B211C2463A
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0DD71EB6;
	Wed, 28 Feb 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xEm/KgXU"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205871EB3
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145856; cv=fail; b=DL8azzky6tGs9N9elfW19HmynN3IUxFEHRE63NaTP3PzHl7kaMOQXmwl3JRSXlKDV1IGJ1E3dM4S6FlnpYebUc5IzUr1XOyL4wRrn39U4SGn6HeBiChaO4jiBC8SWKpDufd3uUs4/83wEBMKEWZxYDwdtMlatpNw4UHHwgL1MhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145856; c=relaxed/simple;
	bh=fn09CB3353c4SdvKu9tjwa1PbYevkNKERcUbSa+XYk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAgLUVIqJc5E+HeRSdhCblLhvS79z4gqgLdbf4tqnbWYlZNY/Sip4SH3DVPTcPbCT4DtJwi+FW6JXbLVQcXrpXWFy+D+QVuQzLMNk/K46xw5C0TYH6QrwncWcZbXOtvWXcyn13nnW+RSkSTKODKKxo88c0DVgls2fF+rhBXHwlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xEm/KgXU; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jroKy5wQHlTjb6bODlseiif6Gp0JcoUEGcBsW/a647orr9+TPMC7EaV37KmSQVFNh1DxKlf1KP03fVS8Sa6iHXdmgP7xFa4cz+LOColR7OZCSfnlQD7Xtj5bqJqx1Ob93NiPJH3jSeM/YGlfPz030Xe0ekraKLFZH59noCXwFRGceva9VkpViBiSTdXGuFY9VaqzyQjKpZRjtsmpWVEx0VAL99YcyU5ZM90EcB4TOUqy3FlxemyqdFfpMPBWDKNNMic8C3GYiyXtDB3DQc8EKeA13IErKHxIrFPyHtM3Ipo1YqNhz8XTcMLEh5tjArjDTEyVaE4eUBcUrJT6jGXrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5jhnv+TqKsLL+QHPVoaMw3jEtDi7WFPTvSlPouoQwY=;
 b=ABbKYM88nudSzIzFsh5ah3wJb+PaaHkm5u+Xplux6mIMROs3MpqNCr4yGd8zYTHyzODDQNXee4VrOUwURT5Q/WgQ7S/PwPBYDY/nVEXUTg+eRD4EMOcuxxh9X83f6dINVWdfF0Kd2b9WpZdufd0LWJ6BQLFUd6IkjL1nxwHYIhfY8Xvs2Wv00pRYcDL9KCjB1HZ34cJEIgZzTi1fRoR8zGXsykFkCSKGXppX0ApkAgyUhpeqnBB3AVPlxLrvZxV47f54cCTQlxry7kYB9PZ/506Jl/QTDDAZwWBp5ByaRuES0q6RccTIG2n/kxdOC12pLLSyPe94ODnDu7ueWwzHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5jhnv+TqKsLL+QHPVoaMw3jEtDi7WFPTvSlPouoQwY=;
 b=xEm/KgXUsEtOAmM+kSzmzc4NoEJVVYlS8NBix0sm5N5rRFjqtyuG5BcKgZeXWf6EBik1DGDG9JdmtKrRI+Gk6Lb4VhGZp6LO5CTM926CMV8yG+tskyA5+4f8SjR7UsbK749ekQt4u43jzjm3XfH5Gz0c2Y8V8arL4SGB/1iYJsU=
Received: from CH2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:610:60::20)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:44:11 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:610:60:cafe::4f) by CH2PR14CA0010.outlook.office365.com
 (2603:10b6:610:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Wed, 28 Feb 2024 18:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:44:10 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:44:06 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Ryan Lin <tsung-hua.lin@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Chris Chi
	<moukong.chi@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 15/34] drm/amd/display: Add monitor patch for specific eDP
Date: Wed, 28 Feb 2024 11:39:21 -0700
Message-ID: <20240228183940.1883742-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c208020-c7cc-489b-1251-08dc388d408b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d1wX1AZvtemBceG4MJYsK9DC4XA9riUDltvDXSpqRWy7OyU7/DL46KBHPdQkxT7jyMZMad1khJ+TftOXK8yPSV1Pn8QvTzUK7nb77yqGOXoBEWYLhsh9acIxGtspyLLM4DfQhx/dttOMQH1fSHO4vPk2/ihpnWNd7uNEa7L2shLKIN8K1djXiRXMlrtW7TthGfIwi5NRt0FcN40A0bPe3zo32LFVpHbiLB1+zxr4tSW7nyrK9F0wsIOuYpTuhSfGNFNkqSY3Aw+mCVuundmjjPMWpQpovHU/bQ7m5Bnqbk4MWKjj+tqTmY9vo/3rK41Q2Fv2XTJSaSj6jmSHDRWtr8sXRch9/OiuUj5QZaaUp4D7DiYytqKP8xWsQgxk3TVhcGEpe7BxMubVdD12rpTGHWZKgq+wFVPOMcMYHNZ0tZpclllROmUFCltmsKX0odQftslO89349y6FyxtW1SuKiV2GWaX7hulvgZxDHOIADQp/QauoDewAs6g2/SNLux3uF3uCiFH53IuuqgDQZSTi9m/9izMNm0Agt3QV1yGD/gpotEDWwUk8S2QcNwJFbja+a/jKf+tsBTndfKoptXhizJgk0EBD4rWFEivuiSz2Bp0tgc8zmm9b7/uxyNOpB6Zdtu5aH48qshnJg+46/gwggtCfmcggCmi0JcnKXLYw3Gkun7ZZUn62e5sQEp/grHDVus/htAPFGSr5L1W/kF09W0015oaD4GcmzO0N+aB0+po7iS+5ABCVI1/6U1m55DY+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:44:10.3230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c208020-c7cc-489b-1251-08dc388d408b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240

From: Ryan Lin <tsung-hua.lin@amd.com>

[WHY]
Some eDP panels' ext caps don't write initial values. The value of
dpcd_addr (0x317) can be random and the backlight control interface
will be incorrect.

[HOW]
Add new panel patches to remove sink ext caps.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.5.x
Cc: Tsung-hua Lin <tsung-hua.lin@amd.com>
Cc: Chris Chi <moukong.chi@amd.com>
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ryan Lin <tsung-hua.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 85b7f58a7f35..c27063305a13 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -67,6 +67,8 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
 	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
 	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
+	case drm_edid_encode_panel_id('B', 'O', 'E', 0x092A):
+	case drm_edid_encode_panel_id('L', 'G', 'D', 0x06D1):
 		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.remove_sink_ext_caps = true;
 		break;
@@ -120,6 +122,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
+	apply_edid_quirks(edid_buf, edid_caps);
+
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
 		return result;
@@ -146,8 +150,6 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	else
 		edid_caps->speaker_flags = DEFAULT_SPEAKER_LOCATION;
 
-	apply_edid_quirks(edid_buf, edid_caps);
-
 	kfree(sads);
 	kfree(sadb);
 
-- 
2.34.1


