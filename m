Return-Path: <stable+bounces-35875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4C897953
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 21:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ED4288AE5
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B91553BE;
	Wed,  3 Apr 2024 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KQ85CRzn"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243EE1553A1
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173917; cv=fail; b=q8AEsIBI3VNXEGh+82799D8tH7RJJM1WMJAEQD+N4e+MPbK72m+6+KjWnNv+VRkcnPrfMrJQ6uTpNTKLE6i8+EBukqgsxDyOXkXGA/4TSw6T+klwfdDJsK71dV5XKntZLtlKiBVcltyEr3i0fb9GHK/7O+nvgJ5Qn6xwoHYTb08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173917; c=relaxed/simple;
	bh=uI0P/9Lg1UQgXn3E6ZaoMhHZvVnvM8ZHXmX41t3rLyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drQ70+eWtWw7gPhfjyW2nddsg6OAD+KHFbjJUQ6W+bThCEyX84bd0FcrPuzDV2fxWUI0NWp47ipaeACdMf6w2xnAK+k2QpPRE9uXRKYLs4JGIwXlNPWziPG2DLSYtv8ihwtxOKqoUM/7SNkeSgh0hp0EwXrA6coQ/64dWyrzsvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KQ85CRzn; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUffEG1ObHnt1X0N89Wz8odL/9L4ErK9TCsP7Ym5D047BO3bIJlKbiiKY+fudxF+Rp5IWKvGsAx/HZvrK6t6/ibFVROYt8J+ociJhJlQY88zphzvp/di+rtWEYj7r2PDnX57yLEgvUutZA2gQ6xxBmCHsqdF+pa3zKsJyX0LvdlEfrHuxmemSa7wcuxkXmJCVshvxaqLrEZuJot4g2uNFpzepp/LviARE6QcGMEIdey6VOKqlr9RdhPyCXyPwi9trsV0orUfwvkL+V6YuAwncFyBdRvrMvBby3tT1f9aHkg4Jz1xCod/4GNkGHD4vmiO/Uz//YK9ybjgANcvQ28JPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDLtnducm6N4p3rMTUU+46Uq9I3fDtkac5Vi1Z66FZA=;
 b=C9NrCMZiWOxjBal7aUgfVUSwHf3VehjtfKc9RsMST8wCUt+u4HXPPJnIKjLwZTX1kQNhhAaYAuKnfQIY/IfQrvWrr2QWowTJYkvTxs7UU63JWMWipLO1Caln6d0NBJfsfXdtMIaMXIoA1YmdUHQlsQswX6pRg4JAeUSTMIo49vHcq/3ADLgWFhdOVHkX1K/hOJ4Q529eioMcZQhLfw39hloORp68GP+qLWiUGSAnViI4wkAENu4EjON+IJD5CGNxbD520H2AixMgOSb6iqEZKODnfsXHOg1SYcnTbq5s/NCCvgrlSBfuYKXRVtiiBLs2HN/emC4KQ/P3SxLOGQeB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDLtnducm6N4p3rMTUU+46Uq9I3fDtkac5Vi1Z66FZA=;
 b=KQ85CRznwS1IJlIqM+sqTk65rkh/nR5V5VKSghB7ECO11n4hbwZk3e5feLqyaEZEhT6gidXwuXkbyOWiRvBA2o9FPX8NptqVA4UlfagEh3QOLYMJ/AdzSBXFtd0szN0EImWFfs+qHM0RG9N26kPDQ+HS9/obf0l5f2iEChbo3Pw=
Received: from CH0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:610:74::6)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:51 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::9d) by CH0PR04CA0061.outlook.office365.com
 (2603:10b6:610:74::6) with Microsoft SMTP Server (version=TLS1_2,
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
 2024 14:51:41 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
	<harry.wentland@amd.com>, <stable@vger.kernel.org>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>
Subject: [PATCH 12/28] drm/amd/display: Set VSC SDP Colorimetry same way for MST and SST
Date: Wed, 3 Apr 2024 15:49:02 -0400
Message-ID: <20240403195116.25221-13-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: f25c8b7e-b348-4a9b-8aee-08dc54177fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gFa7Z0Hn3SFpg02qQj7bfG+xSs0pKh8qAgxCIQBFE/G+21L5QPT4uUu+mW9dFAlV2FkCUKsIXeLbp+hwmbXk/KbaOsmzUELIYcqoxgRUVZVbHi5jJ7OVhcAkgV8xgTReY9hFc0cOiAml1ZMh22IJoBM5jrGSAX1mYrqMu0C4gqWE7UE59u0vaNdHoV39AEDkYMhKT/g7eJVU+Sn6a73Vzy3dDfqKNyg/GyrWfv+II2ysGnC/74ewUp6ZLfqCRqa8C2AK0eQdFv3+kMHr+CYVfij9o28nRp+22F/57XxKlzdKqARPF2JNoqSHsbWC0d8pom4R35IhV+u+dteCTXNGs+Y89xW5eXNZs4KzGmBRXPKSbgPBho9CRLBUqVonGVFBzCId42WVMgksJgkM0vBFVveh7aYuD++OjpAyjN6o+ANhH39WpNos72M2QAiWjHZJ/W/m8xzt0517jBmHKgAfRfsRkfRVjQ3df5a3wMFKF9bHRTXn9bgxJaPp4IzkBi9zmloF2Yjia9BSaUJeMU/F0cAAB8c6R/F5d9JHF53tvWFSZb/Hs+IzC9CQrQmPuJIxarHl6D5dDg3Ovnpz4JIp1sc+1RZHUvea5y13cTKGjfOEplucT+55MErqS984hz/Xha6QAEeNwlxukzlpGyUkpu/Avm0lxoTdKVnTxzCrRgVi4w7x2XUpWBk2HSCjAhRrXJ69VWzohZ47gavpWdb5L6LzWxRiZl6B0/BLycKeGfdpqA5sxWD4paZmz1RK6UxT
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:48.4865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25c8b7e-b348-4a9b-8aee-08dc54177fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740

From: Harry Wentland <harry.wentland@amd.com>

The previous check for the is_vsc_sdp_colorimetry_supported flag
for MST sink signals did nothing. Simplify the code and use the
same check for MST and SST.

Cc: stable@vger.kernel.org
Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 56779e6544b0..d52701f6d1d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6333,15 +6333,9 @@ create_stream_for_sink(struct drm_connector *connector,
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
 		//
-		stream->use_vsc_sdp_for_colorimetry = false;
-		if (aconnector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-			stream->use_vsc_sdp_for_colorimetry =
-				aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
-		} else {
-			if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
-			    stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
-				stream->use_vsc_sdp_for_colorimetry = true;
-		}
+		stream->use_vsc_sdp_for_colorimetry = stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
+						      stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED;
+
 		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
-- 
2.44.0


