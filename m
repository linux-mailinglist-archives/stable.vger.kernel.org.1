Return-Path: <stable+bounces-10449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62857829DEB
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 16:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9A91F29102
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD654C3B0;
	Wed, 10 Jan 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ySXN37LU"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134D3D60
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME1DUk+Kz+ytJ49qttR95I/ADlMVNZcAqo2rlT/FJMK+aQzkWJ2ypEG5HxryWAO2I0IMlVwGc8iXJ5y1QUme64OkShuMdfR5EdQQ06eiZN+cUndWFKiDHg+nHRP2vexLOq9kqwo/MkQf/WsW0RNpDfUmhpxTFNA5W6RcAkrPNDhd+AiCKwahid6eCKtsmuh4PoY05NZyUC1Qf6t8jBd3GJun/0aCA2/POB5i0ffKx9RMsUJPCggoImTbdtZuFy0Ecrfr40v9iz729rRxeFWAY5K+jcrVjbB9qfTJpv0RHrKWu1BRvYmGE/H9vGrV8/qfksDYzFtw/oKNOyQC7q3VwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSQWd7QCNP55yoeed/wa/rlFB94EByM7/9NQauWHYpE=;
 b=g627/tSDbvAvJMAaMlNi4QylW1z5+B2f/v+5dRnKbmwUn9fVVC2uJpQDgM629DAw6LDBoyGrdskfex1ij157vhMwxwPk/090mV/bf/VON9f33lz+dPYS+CkoUBdhLWZ/O29HP/Y8Itld1xlv8VupsvgWce1pGjpOmwZgFf2hu7kB7n3TwH4XxXNlHgwHYBk7DHkzutUcCp+CBH5ybpsjbegsrsERceK56ieeMuFh7CuoZjj8g4f/SGNLvlBhINfxtL+pkQrOdS+GJln696kG2pr4GSQ2rnsUVpZsoqTrh2LRQk79v7euaN5JhuTbyhvq22mz9nY5WHPgwcMVTB5aiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSQWd7QCNP55yoeed/wa/rlFB94EByM7/9NQauWHYpE=;
 b=ySXN37LUzPB9LweamepyWHa++RPLIY/XfdO7ZELPg4hkRiU1sGdNyUpEaTIB4usLllLU1VLv0Q9gD0EM+hmTzsD01h9nnBxBHdDFkSKfenVx8nXffyAqB3817nBlz2Iice+3CVIxDKA7JHZXhMgWzQgK2Ioak8rNiP4wEiDS+a8=
Received: from CH0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:610:e6::32)
 by DM6PR12MB4927.namprd12.prod.outlook.com (2603:10b6:5:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 15:50:06 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::68) by CH0PR03CA0297.outlook.office365.com
 (2603:10b6:610:e6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 15:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 15:50:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 10 Jan 2024 09:50:02 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
	<srinivasan.shanmugam@amd.com>, <stable@vger.kernel.org>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Qingqing Zhuo
	<qingqing.zhuo@amd.com>
Subject: [PATCH] drm/amd/display: Fix late derefrence 'dsc' check in 'link_set_dsc_pps_packet()'
Date: Wed, 10 Jan 2024 21:19:49 +0530
Message-ID: <20240110154949.518292-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DM6PR12MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 372605b7-bc23-485b-7593-08dc11f3d0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9y48tAMOy88z0dGwcs/CfEbyevx6L6kcdMKN6g8+fX47kwW0dwz/WOR/j9B6hJaYzLaPYtoPA92aF3BJoi1aLGYkL89SMdHTEYei5nX10RBt9maEo2F845M4B3YUqr/VEnNp1AK87BFV8v+povcdrfstx7m0TSTXSlltMLxGBObrGedTuFcLZJcMJ3xf6KxoZnCQsBYIwc45x/MR0vatkRxeK8j1oJPbk9fE6/5q5epUFg7Rh62i44eldCVWxl2Cft0G9K8Boo8GJE/831nmLEV1e6V56e5lQH15PNIh8XHC3aaXIpQ6LCRbZMhIZVXfOGCFu4gUb881n0oWvQ4n2Czz4C2VVPbat7FjxPZs7q4c4mbo9Jypbh18bv3LPB0HGwJGEv+t+KL8v1mwAeIquZZJ70BU58687xG+7bwgsQ5NaGoW/xXmzfDMravNJroGoazdZPQYUu9GsaLTOFX47kMqjlV1At0kyqRCimytWeIpL9Jbc5TdhPbqpyLcIxQ4uQ/7TiJNlVKcUasSJt8g5PgrD+WOOtRrfoILuQYs+eHH0FEXcAdtQRyPcMz0hq3e0lhPrplc8jK5XoE9SfhRFAFqOftyXd3rnoP80bMY2Tn2exmsTCIIy0T3xS7th9Zvjylui1mUY0BGdsixajzdvakAyRmTFMdnBPgnn4tE2D6mxSb0gtMG+cSb7oTp+vidLpXvhK0Xjv/bEJPFEa+LkyOM2jH66jwHlB5GxHEy4yqRtW3bs0uH1IaZTCMqMpn/NI3s7vCkGUjHI59mhMIp6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(41300700001)(2906002)(40480700001)(44832011)(40460700003)(4326008)(36756003)(426003)(6666004)(336012)(16526019)(478600001)(7696005)(8936002)(8676002)(6636002)(110136005)(5660300002)(54906003)(81166007)(356005)(82740400003)(1076003)(70586007)(70206006)(2616005)(86362001)(316002)(47076005)(36860700001)(83380400001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:50:05.6706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372605b7-bc23-485b-7593-08dc11f3d0cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4927

In link_set_dsc_pps_packet(), 'struct display_stream_compressor *dsc'
was dereferenced in a DC_LOGGER_INIT(dsc->ctx->logger); before the 'dsc'
NULL pointer check.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dpms.c:905 link_set_dsc_pps_packet() warn: variable dereferenced before check 'dsc' (see line 903)

Cc: stable@vger.kernel.org
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 3de148004c06..562eb79bfbc8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -900,11 +900,12 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx, bool enable, bool immedi
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	DC_LOGGER_INIT(dsc->ctx->logger);
 
 	if (!pipe_ctx->stream->timing.flags.DSC || !dsc)
 		return false;
 
+	DC_LOGGER_INIT(dsc->ctx->logger);
+
 	if (enable) {
 		struct dsc_config dsc_cfg;
 		uint8_t dsc_packed_pps[128];
-- 
2.34.1


