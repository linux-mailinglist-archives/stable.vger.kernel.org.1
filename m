Return-Path: <stable+bounces-41344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CEC8B0515
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 10:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230D81F2436D
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0A1581FC;
	Wed, 24 Apr 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jP6xK6rS"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF5158A15
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948859; cv=fail; b=slxXgN2D55hDaDMCRpF2mx6pnZGarjbm/UfVgvAyH+Al3D03rf03cl/V9fECKxEySYwGfDEdBsX1cSfl9wpNf8HfabH4raQBne6a92pWDbEaBpOHef7nH9HgrM69E0MDI1jJFn5BLAj7579o3gui/0KamtNVId5tPxMs+KlB7H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948859; c=relaxed/simple;
	bh=h7ARA9n0PuvNDJGip7BSjzhFe4sTJSc9HsthltHOu3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrzJcdTIfFpkH3Rwq33eUmDl3VFkhHuCGwFxDfpap4eXn/fIJOk+0r9uNdvRPr6j6muAYsSP+msvklVVpY76+j+gCtX1iz+aPar/hEVf5xrXKmRX4r/xGEgJ3ik5g2nTW0mYbJa1n2hwT4y+Fjtnt3GETK93D2Sql4EemDjhaHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jP6xK6rS; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkW40Yu7FNhm3wHUavG2QoVD6/x+k+9J2BKLR5weTIRQWHjMvEMfbxZzy5V/1T4jPEJTcLAqFo3DPPw7gJ5PkNq980XcQXFKdnzuWz4mjvECOaxVmhZBlxKdEmq/pKRaBw237C5Xb15VwWtKstNrP7cVyRhsrZb7OqQFz+gbFufOHCLsdHveCDmWnGuP7L0j44ERZYJmbu7qhfTH8JUdX2Me971ygIDAiI4J2llX99681e3WG5dy5ePfatK61gI0r3O69YJUe46RCmbTkr8iwsyE4AehykbW6IwBjhwTfPr6MmqZM6LiSYRs3KZEarU2WbabrgvzjW3bTNVX8k5NBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT9hv1UjtaX/+in2pG3iGc11vyQYAztwi+YI6lOrF70=;
 b=jjcf9dIa+s7sMm9JimO1BGxuBLU9B08SGf9DduY0c3fCMfUuILm1FLffejdPGb+NH5ehAUKCJULLsP4iEWWCksSbuP2UN6Hv7YvJ/KsOiaJFd3iPaD3an4aYHfHBzHwm9pyaiwNyBcp0fiVAvolOFEpAURbCwutuVCCkK6S/7CCjAtS/Zms4DANqJ5t4S8hhGMm3HGBjXYJ5v7g7OPnibN+UR32kQIMgMPDcrFMFKU+VRa6xYVWQpQMjNis+lg1Gol4STwvyzBOU/tt1j0TxiF5O6wFsQZiAcXlYA2KGrrUZeT9dZRyWnJMCpMWdyiaxkq2VwCz1RXK0KNSsqYan2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT9hv1UjtaX/+in2pG3iGc11vyQYAztwi+YI6lOrF70=;
 b=jP6xK6rSjzAQ8DdY9bNdrfG/xYc27YxIs0KJs/IZJFrHdR0q0/xJylwHwEtLZiR6vqxtsjzmtMvnluhHAnsiQFj4T8S4E7XaZznqfoHQ4dj58+pZywQyjCv/fBCX9k1gHkKvFBAEDFB27QaVs0DgOLwsX89eckeZ2IWwJpGACAk=
Received: from MW4PR03CA0150.namprd03.prod.outlook.com (2603:10b6:303:8c::35)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:54:12 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::d2) by MW4PR03CA0150.outlook.office365.com
 (2603:10b6:303:8c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:54:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:54:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:54:10 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:54:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Swapnil Patel
	<swapnil.patel@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wenjing Liu
	<wenjing.liu@amd.com>
Subject: [PATCH 43/46] drm/amd/display: Change ASSR disable sequence
Date: Wed, 24 Apr 2024 16:49:28 +0800
Message-ID: <20240424084931.2656128-44-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 6587ab8c-8065-44ef-ec61-08dc643c1ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZ/feC6BXfOwMgo6b2SZTHBU1pHYri2d4BLiWj5Z4FXbbAmWt8vheXxlszXN?=
 =?us-ascii?Q?4tynAe/Db/EVnHjWj14BbOBSDZuXDnav6p/OSE98vWQ5LLlnOrgrkuDwapAC?=
 =?us-ascii?Q?mjQRWkPLZ2jT4gAgYsMCMy4xcKcOsxrEx5mUixM7RGDiB/vQ4ClPZcOqKL9u?=
 =?us-ascii?Q?ra8k4eVmgk0RGnoutxQkIpmwknMnpIOFXwKscUwzkaPHwpkQhtLgkSm7VnXC?=
 =?us-ascii?Q?Um3/WedZGZhvusDNLbUhUY/TjncJ02lF7uTB9S3PP42RuApOs134exa002F4?=
 =?us-ascii?Q?NJNdW5Fe0WZzVwt0b6oC04O4Xt57WHoo7F3Oo87pwROw+dXi2xWIN7PMu7cO?=
 =?us-ascii?Q?c22zj7g5vUvwnC3Bk8wwUDEs9gfV/POa1k26rlE9pZ1epCl5aQCsDQvUSzzx?=
 =?us-ascii?Q?CmflcaFN6hHD7goGyC8tvMl1WbJLzsKGRUemzBPGo3R5R/bxVL40jLddkuQw?=
 =?us-ascii?Q?4Q/3aCB7yqptXRsf0EcrckiD8EjIO0DhPhQGf0Vlo0m+zWcMOKwRLwCZHjWc?=
 =?us-ascii?Q?c7Nw70dzwoiduRTf48ZUxDPxHxkWNneYsVuv4A/1Qx2EVlxJMQvHuxWhSJtf?=
 =?us-ascii?Q?1u5khQtX6Fy3aAAnC7FBHeURUXZIW77QNNKHuKBn9VoNBRGRTSrXqkqRVsn8?=
 =?us-ascii?Q?d0xx/9imTEzvR0rxzd1tnnbQyzx3GQnNUskG1K9aC0FdUx7+V8bSdAQDszv+?=
 =?us-ascii?Q?NkLDSjojtr2iSHxGvG7U8F8g14K6/65IIYIsmo4U33HOsf6vOrW8I3Gst93r?=
 =?us-ascii?Q?9OW9rUFlFeCGUAedSmQcsVUNk4gCL02u3TS099I9Ovofimqrort4ZBrl9y5r?=
 =?us-ascii?Q?wX3Q0OSJ6L/xV9GEOvjpzgDCOAJBQM+Iybq2PC+4B7s2Q5DWiogUe1Moh86G?=
 =?us-ascii?Q?soIS/1XSAPNWSVF94voozuDKo8enJlvZ1LCXsQXLxdlzZSvaHN7aZRV5sqZb?=
 =?us-ascii?Q?SE/L3YZsvpgucGke0TsWLQv8/RpxVlR89L5jt7YUNiheKVhScPamtd2lGj8R?=
 =?us-ascii?Q?6SkCe5VElTIvmMj+PGphHlHxascchSYSQ3u2+P+afxDAgSwtF3m0fXSvYlw9?=
 =?us-ascii?Q?YLYzdjSncakY2JL/+Ps8BKTS6vsyO2sD5ox5a2aKzIyd9jDuh+snCRr00Jml?=
 =?us-ascii?Q?3rbk8NSZKpi5i2m4kkuvc1Z4fLCiV0L1nzMvTJdvHLrw/GeFm8iRFwY0IIy0?=
 =?us-ascii?Q?Prd18zjq7TxHHN7MYhtLIGOjyZBA8FCS8JetqQZvZW5oarUvlE8akeMQSlRt?=
 =?us-ascii?Q?S4e2oQyKsutjuInNhrtjNJ+PsZZ8kl9vYr19Zmd6wNwVUvx11Chnc/fZuxgS?=
 =?us-ascii?Q?WepYGt30YiH8uTAsGI25Zpn9Y0XCL2zbTIFMqKhZ9lfHGcGe2anl+gUWmshi?=
 =?us-ascii?Q?LHcH2megsvAo9KWDRv3wBOZJgRCc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:54:11.9565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6587ab8c-8065-44ef-ec61-08dc643c1ca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790

From: Swapnil Patel <swapnil.patel@amd.com>

[Why]
Currently disabling ASSR before stream is disabled causes visible
display corruption.

[How]
Move disable ASSR command to after stream has been disabled.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 16549068d836..8402ca0695cc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2317,8 +2317,6 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 
 	dc->hwss.disable_audio_stream(pipe_ctx);
 
-	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);
-
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
 
@@ -2372,6 +2370,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		dc->hwss.disable_stream(pipe_ctx);
 		disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
 	}
+	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);
 
 	if (pipe_ctx->stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
-- 
2.37.3


