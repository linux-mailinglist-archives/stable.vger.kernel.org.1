Return-Path: <stable+bounces-75864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C568A975867
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032C4B2A5A4
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1581AB6C7;
	Wed, 11 Sep 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0pVWno6S"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481419CC05
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071829; cv=fail; b=d/QUxj+JaZMk6+hxnK9OC06HYQ6xaC/ueHBPpX6/A32A7Gp1g5DmJCr2AWaxXZGv2mBkZoS8Rgy3pnGQstV3RzAMahoN1eRRJYd2XOuRN458GX4l0qgRAQwthOwXzgWtKK7bwRvFfKOWX/2NGqIA0gzuhIzzyhzqwGIJbQeiI5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071829; c=relaxed/simple;
	bh=uVuH+//TSOPj+gwcoZOZas9f270Revp2ToSpRIGNiLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFDBq9eX1IiBbVsf5hkdlc+kJG+Zzc0fiEL00mYUbmQmJThMw6GVg+nRw93t1PWuN3D0s72lRFre8XTMObLsO8dIm6//zabgfquY5vsgeO8CSL+ucuAWH8KrHoCrQCdHZ3d4TKtW1E9bgVvADuL5OCnjoa/vhQ0uGGbFeu/WNo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0pVWno6S; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiUiTPsygxQ0M2g57HSvyXuMC0Rxyrhp2HOqegAAaTWUGV6UNvOYNvvG9BjgSAossQbA9xae0ABHfDgBTTdnbqGDKRps1pEbUW4+k1rErpQSF/K3bEs6ddVmd1a1WRJuAmDp0M7CJ3CQZWJDP9HnafhNvPkTjWVwbyyVSVlsKdCHqP9Ar7pMmedunFn4Z+Urqx35SbfWT36eWfi/Dwwu4TiBtGjxe0MBk4X2TYNDfUFHyBdfvr/o4rbz1xpiMoOErbacDoxxyKuLkYampMYfNg/7fjLkp77ZFeMpJ/+80Q8L4He1Yy7EeYfIhq2J5o0J07nGgeoKmJ2C4Z59VSSDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiYQGO/5TSRTRchoclreBd59MxAyvtby8cVgTImCHrY=;
 b=yNarK3vBNMPNv9hg0AeH0oQ9sFbuVSjN8i2i/kCgGePVIcfwu2PZwXbqMJbii3b24fpH7JyPmMXf+n/WQqSef/0JaO43Qt6YpCpZPlzsrRmrJhfWhLLfYy2H9Cka0b5zt6s6osw/pLKepMSvnEN+FseKT9nKg45TU5E+S4j+YEFUfNSbo+e9meqJ1TzpCwv/YYNpvO0BKUy8rJP6hjoB6W6kTaJtpS36sUcROW8M9hmFRQBTRj6PSCWZKR+gxINGv3VFGXLZdgfBX8qo15ydNO6h4elpCtpsWaw4u0FuPAdwA9EwEA3AdqdsyByF3o5clkhnx9XA5hV7RcLc0imwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiYQGO/5TSRTRchoclreBd59MxAyvtby8cVgTImCHrY=;
 b=0pVWno6SwaGUnrhC2NH3XVGI+TPxMMD1eJV96SzPzkpNvtJD1O1zF3X+zrhYgRJQ8T4CZFiHQRmG1dQ3PAGeqsdlYcnyJev7ii5GIyNiT9X3qeuSFu5ANB4jq1aJsaoh1tG/m6YK/hA5P8rCIgjWIgXu40K/NmlCyBoWUgiefUg=
Received: from BN9PR03CA0930.namprd03.prod.outlook.com (2603:10b6:408:107::35)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 16:23:43 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::d0) by BN9PR03CA0930.outlook.office365.com
 (2603:10b6:408:107::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:23:42 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:23:40 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Charlene Liu
	<charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 09/23] drm/amd/display: Block dynamic IPS2 on DCN35 for incompatible FW versions
Date: Wed, 11 Sep 2024 10:20:51 -0600
Message-ID: <20240911162105.3567133-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf10d3f-4a31-4a1a-e575-08dcd27e1a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nK1LUmSY+pRerJADwZrnVIQjFb3WSaNzTLGrO3/Q+iFroeq3Nz6e9vBltLwV?=
 =?us-ascii?Q?hCruXZe/zLLXh9Yem73HkA0KZdRn3huTHmM4wg9W/Iqg/RdO4naFfZR+sP4k?=
 =?us-ascii?Q?zRvBLzMuPSL2MOY9ZMABuHf34adEkIbxv3wF95Us37Uo49X5zuDEyN91VI05?=
 =?us-ascii?Q?RPYmA1Tte9gVyxb6ZWPO1DXpnWy10UZGC2Sp7bZqpmaJasqbPWNj22eicAlO?=
 =?us-ascii?Q?lLZQHne8aETveI4D9hC3aJ/bC6X8wMFdbQMM8R2kr0gpvjgM3xXJWC5fwn1C?=
 =?us-ascii?Q?b6XUU9WfQJsDAQV4pDiNUmnqM166AXdC0z4EeEKGtsEBG7pB2OGx2g06NQG7?=
 =?us-ascii?Q?HKS75+22/s12VAZzGgu3+maSyChJNeQS7QjLQ8yhQMTP/+EkstCeMfaRNN1x?=
 =?us-ascii?Q?vpmJY914N28SnFkqw61EUNFlyt+PuYZ17N5VA0hCLy0zEWbKSlg8dYJYCM4x?=
 =?us-ascii?Q?CQVqGHPYpe2CVfTpnPbl7/Mw+RlDNsy91DgFfh+Z9Fnhyc1NNfmxTQ2nDfGB?=
 =?us-ascii?Q?r8l5WGHrlAQDkW8pO+k/I5qJEsxJhVrysYZb3ZHAiVeTQhPfU7KhQHgZj7UD?=
 =?us-ascii?Q?EEbcpZU7CfA79GkckPuvjjX1GkyZLe//BjMOTxpwdd19YrPtgdQcSNf84g7j?=
 =?us-ascii?Q?wZ/UbEGFn8Lkcd5mbGIdi1+TZWHAEfwbt21nijWAcSXAVeNu8O8ViJoPILUV?=
 =?us-ascii?Q?2hY62A/iuVlqZbAq9ftpi95ys4Tp0BHI1aiLG83OPvrkVHZyOg4/MU/q/HMz?=
 =?us-ascii?Q?bsVclT78IVWgdqG4baD49TrHkAXbf2dUwjrXxcMJuOgk75ZM6FHwkdDAQe4y?=
 =?us-ascii?Q?z8tLfgiITi9L38TB6zI4TWT5wGhkXvtNJEf8JI0ODWGeZ+44Y1LT8MB931pi?=
 =?us-ascii?Q?7vXI+4XxRDmzWzT4RAzeK8xutYv0hlasO6X4UPNR6pD95W91rpSofgjOnY9T?=
 =?us-ascii?Q?euFhHyIFE1XJ2sAI4NHXVhNCEDV7M2mIMVj1OClOEFFCGyQh4ehOEeAZ18i9?=
 =?us-ascii?Q?zyEXZ4T85V/ISAI46+BXCyfe/JyQGLEFw3j1yMNLH1crP7Fj2FpIk5+SSBJW?=
 =?us-ascii?Q?fFfP0evTTDgJSL48aCCDYsyn9AZX/zTeOoM2BSPym8gYSnlavHUi4d5DPCWG?=
 =?us-ascii?Q?j0FxDNPRgfm7PKgcm7ve6PFBZH5vM4aVv+L1CgOQCaO4/N0qwXNqkHCc4fgV?=
 =?us-ascii?Q?6pBD6C7mZtNostUNOR5TGmkrADZqrmMKYPKNswtxy2ixntKT94pbfATJX3PP?=
 =?us-ascii?Q?n7bi8vj/JO2xD6JyYiDvbeT8+h1Q9FL5ONPe8q6km8XEUTetxxPM6RK0/rji?=
 =?us-ascii?Q?FKFOV/+FEiO2Ri20Wwjez3Ab/yRRrf6/yUBGgKoEbfcTR7I0MocCgwZxKccm?=
 =?us-ascii?Q?ChVb9WkyYv3CY3+G+R91s4Vsa2EzfRm3m1Zhjff8+FhZwZLZsCLVvntll2jz?=
 =?us-ascii?Q?w7IKpA5TAqLUpaUOgPE9GM6Ea+BCrup/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:23:42.9125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf10d3f-4a31-4a1a-e575-08dcd27e1a5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[WHY]
Hangs with Z8 can occur if running an older unfixed PMFW version.

[HOW]
Fallback to RCG only for dynamic IPS2 states if it's not newer than
93.12. Limit to DCN35.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 97164b5585a8..b46a3afe48ca 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1222,6 +1222,12 @@ void dcn35_clk_mgr_construct(
 			ctx->dc->debug.disable_dpp_power_gate = false;
 			ctx->dc->debug.disable_hubp_power_gate = false;
 			ctx->dc->debug.disable_dsc_power_gate = false;
+
+			/* Disable dynamic IPS2 in older PMFW (93.12) for Z8 interop. */
+			if (ctx->dc->config.disable_ips == DMUB_IPS_ENABLE &&
+			    ctx->dce_version == DCN_VERSION_3_5 &&
+			    ((clk_mgr->base.smu_ver & 0x00FFFFFF) <= 0x005d0c00))
+				ctx->dc->config.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		} else {
 			/*let's reset the config control flag*/
 			ctx->dc->config.disable_ips = DMUB_IPS_DISABLE_ALL; /*pmfw not support it, disable it all*/
-- 
2.34.1


