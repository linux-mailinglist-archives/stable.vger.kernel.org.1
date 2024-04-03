Return-Path: <stable+bounces-35872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C55F897949
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 21:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB631F24CE0
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E831553A2;
	Wed,  3 Apr 2024 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bkdrVILg"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875B155310
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173913; cv=fail; b=qRISedloSThTRtvjd+U8G3bprFf14CEL2KBb612eC8NzNJkfU/OLVTQYi3uTbiAJ5zY9Wv7ch7vgYaUTU4Xiuce6o874bkfDqvSn9KnrN/jecIjlHcOcTgvSA/swZjLT/k/iWYq4dgjnSjhYjc9yFez9pdqF2mSxtrfEjuWwdzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173913; c=relaxed/simple;
	bh=walMp2wrap8h9rT0yyjxv5abBC5L+mI4Qqml+19icqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psA2LEDvnC3cCAiQtmpVm3nQ8a7PPkQpArt0ioUp6lIn0BgxmstbxLgX7ebhi66I70xDrOTHr5Cj5AZ2BKu3Qt5/kyMY0Nf51cuGb1FN9mSvJmlosIMmpc7dEYyL6WjHDxKl88wqIC37GgIutTqNlrI2hreqPN9+lALGiTr26Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bkdrVILg; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm8rK0b7M+tHr8ovlziiCwAAH3cLw/pfG0jTnUJbEyK5Rxgfzgo8Wh05RJj4plIl/jRTbhNx+VZVLSns4/HdDmrYDZ0CNv1YvsNvNtb3aWvgh0UtEVYV5LnjI3p5eB0wpNf81yhQczjLEPgOoIvAt3AvbfG7KcqGGNgYj16emhXRIVnsoYVSIJL7dyqTc2uDmp5EDpfMsoPBffigive0w2CMqz5beUTMs3CuW4MgbyhJ7sNdzagGBHYSe2UXhzwDXcq7/7n1KuUrM8QNQcmSd8XWSwll0VpXkhBQGddaKYhWvNkzNBCKRnr7qryJ0K3hKmTAxeYlYySEdyO5WqiYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqJzgR0PmJKqvuPhQ1ZFHeLfAbongaXucmj+b0rIZiY=;
 b=hJ6tD2B9t8sLoyxff6gjz9HOzLFBHnjKVkJGR+Rwk6w9jVumL/lx06EmlHuHbBVOAklvBAJpDoXos6TX1YRL5SWPm3B8bqQ/E+RjflSaxhw6lZm4FNuF1qqFQwbJwFsvo49G2IRiYhgeIYkySALj3TNXNA4yQ5KF4bA5Xe24PV+YSXcQec+9r63oMPN2KO3UKKtriUcEF1MKjt+JS54EiI1fJ7qAotqggeAVDgdrdjTz3HHctbTrDlcNkezAwHkUQvBIuCspfGFZRarr6bvp5yfsgO16zfrcuzh/l6LglQeAe2ZjDXMbxipJHuFB3gTdB3oKcUx1ZMa1C9j9TBY52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqJzgR0PmJKqvuPhQ1ZFHeLfAbongaXucmj+b0rIZiY=;
 b=bkdrVILg00+1FvMkOgp3b90xDjScJSf8QN0HMoRDLmzRlmJ0BDQqLAU2Ac2ixL6cqJFX60uGOM9AZ1TOCe4mo25MI80q2rAxxeO7w/4vAJ4rZQFaD5RcD7kYpDi6ZP4ml+A/twm5judir3e/LN2nBLd0dvEWCfWMY9/Wp78279U=
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:48 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::53) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:48 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:40 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
	<harry.wentland@amd.com>, <stable@vger.kernel.org>, Joshua Ashton
	<joshua@froggi.es>, Xaver Hugl <xaver.hugl@gmail.com>, Melissa Wen
	<mwen@igalia.com>, Agustin Gutierrez <Agustin.Gutierrez@amd.com>, "Hamza
 Mahfooz" <hamza.mahfooz@amd.com>
Subject: [PATCH 11/28] drm/amd/display: Program VSC SDP colorimetry for all DP sinks >= 1.4
Date: Wed, 3 Apr 2024 15:49:01 -0400
Message-ID: <20240403195116.25221-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 79708715-ba1d-4ce9-c90d-08dc54177f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ybu7PX8I/EhzdauRfFPYIupO4O/mzv2qK7I9aEh42hfPVdeAqMVtNY+ShW6Svm27G5Bnp0QMcjpBnmug1tr8nUqPlDhsbACS3DuxbgIl1q3LYaup0kZ2x/MOWSacpc633ABI2iE+L+t208wGBERymsvSoB58SNGJEx6Arv6DtLcO5qy8TKIpyo1tDgG7eqYCT4oae+A2YP6psp8FCMhd5alABWd2JYmWEevzKiXdZh0Sb2hUpCnCAiZPFMpwJlKkCbq2drad6MGU7k1PT1smLKy3mK9mH4+6EPjjvA/j6vAixjR9QOQUiALsALpAtyzEc3rM8yfKT+hC7ovSnhXPqaGDiWayBq5FeST6WtiHX/NPj9g9evSL5E8WQ4JPaf7PdgjnZY2bXtwzkigD4mk8vCm2FS3S8KExncWTFCpYvLaQxn5oJvPfAQzqPQBzKx0BFoW23YV7ZwTSiPtpirr9mJ1SAlAst73qA3ss0plAF9SKxleeW7ddJgeL9ClTb1t8qDWWFb3hrqGqh2yBREVXTSalFCgQtTx+dRmTbBHN7iI8K3STCFzvOEH9gGRi2JYXgtPXgY954FtEidOfFQc7cgtUjnDvYNkZQ2+uB73lFoScbZ6CUu23DIruWy/7HabwEniGAtSF0kIoQ2uJtzPRzbNf6J3ASN6ip4KUVsbiWQP2zvh6W0reGCjVDyR+vY0pUAkL/e1qd1ScdOZWVX9xhvEJdxxNUOr8JPD+VeF/zlJ7GbJu8RToSXSaB2q618H1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:48.0490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79708715-ba1d-4ce9-c90d-08dc54177f95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349

From: Harry Wentland <harry.wentland@amd.com>

In order for display colorimetry to work correctly on DP displays
we need to send the VSC SDP packet. We should only do so for
panels with DPCD revision greater or equal to 1.4 as older
receivers might have problems with it.

Cc: stable@vger.kernel.org
Cc: Joshua Ashton <joshua@froggi.es>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Agustin Gutierrez <Agustin.Gutierrez@amd.com>
Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9220acbdf981..56779e6544b0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6326,7 +6326,9 @@ create_stream_for_sink(struct drm_connector *connector,
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
 
-	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
+	    stream->signal == SIGNAL_TYPE_EDP) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -6336,7 +6338,8 @@ create_stream_for_sink(struct drm_connector *connector,
 			stream->use_vsc_sdp_for_colorimetry =
 				aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
 		} else {
-			if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
+			if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
+			    stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
 				stream->use_vsc_sdp_for_colorimetry = true;
 		}
 		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)
-- 
2.44.0


