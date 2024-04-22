Return-Path: <stable+bounces-40384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2688AD0CE
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 17:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170BDB23759
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95DD153BCA;
	Mon, 22 Apr 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s+ov3JZV"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2202E153583
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799794; cv=fail; b=UuanhhobFb7NucO4Z1U6bl7NL6Si9pzHCYVpT2w8QhgFGT2G8I3p7d3HyQzAZ+KQyfi2XyC19eXBd11In/C/pEzJTrwgNlJBMpNSGQTpO/G/AM7idXAHj24h7g4oHdrNd+zEi+pnFZOnlfn9H28CV+dElTZ8jWutatTkwuO7fjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799794; c=relaxed/simple;
	bh=l2EoAWhwObWWkgTbLs2V/oNO3E/l7qqCYpzuSkEoKhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDwMCCSjzsbbno+9F4gH8bfAwXBgAgF9Y8Lzf6cxZayiTAui7Xc9xDy1EzISFHCOIoAi8qmJbU9Az8AHpqmICMZlPOcrrlGjQXYVfERLLcw13LEKHLe+SNCNryHoRH8IKwdPPeCZ4I1CzEMekSKNnjEMdNLC4C1uwiXX2botF/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s+ov3JZV; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+gHjszpTjbZj+XQv0L/bZCwSBmmS0lbAb8ZMjZDC6Mz1rc4p5biacLbMSKhO4ALOuf2K+6AvddNgoNcTGfQHLbC3UMC+9XPAWh+wPTc2E1k+bfg8SVDkoP815CxULeAB9oYYUYirlEfFHn8cLWs4S3fzr9HtVPZdpF7MWfy/JWuYSPz/bxj9Tqfb7MUPsvpw1PnY012GI8Qu+ggMDIMe8D0JfE4QriW3WYylTyoNRu/PAcGizWmQj32FKQfkEj6JSERVpV6USGzHmt/031LutVnZ8S99qDXvkTcFhoqrlDDUJFO62WPshjENru5oDRBYQJR4/LL8WOuq00BtFR6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX6bWcwddbuxcFlwEnPgX/SWt5Us5wJsB1GPn6fk14w=;
 b=LZiB8AQwTWCcFDbGuLaVgNY4emhfTVujxY4x0MTQUpDo269GZZzKqxtFCatMrtLAs5uYvAjTPsNkqo/HLZXNSiGw8r8LitYLUFi08xg1Cf0GB1FiGUQ4iBPwadXGQn4w+PW2hb25oKwuWlQNEnPY0U9WUg7trBlIgUEkJ5+tuC2QovNUpFOyoCbsHGA4KFzsQG5aeg0Wm1ksKcJoRWLht2qvzlsgrn0xkC4IP8SV/UGIEFJ2pTMpjdqkT5JJZUEeazNpGFhthc6FxBzy8OTDcPnskxOzR9WsMq2lkOq4v+vfq1kU2H1T2pFWeNEltHNiJ7fSqYoYMraQuRTPtfMCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX6bWcwddbuxcFlwEnPgX/SWt5Us5wJsB1GPn6fk14w=;
 b=s+ov3JZVtpfM8eEpnAehAo4r7W54E0z1GebaGcqBPFbCDHT9Cizwqc6TJlKc4E2/MI30oC0EZEgYTEKwldLJ2GRgvLmly9sMn59N/4JRwG18uRN0o2I7Y8+14K3ZTQs4j3oqH0s3JwAFgNTwECRBQstJLfKXv8NhPA7yO/EPE0w=
Received: from SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::29)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:50 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::e) by SA1P222CA0164.outlook.office365.com
 (2603:10b6:806:3c3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:49 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:29:43 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Natanel Roizenman
	<natanel.roizenman@amd.com>, <stable@vger.kernel.org>, Nicholas Kazlauskas
	<nicholas.kazlauskas@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 16/37] drm/amd/display: Add null check in resource_log_pipe_topology_update
Date: Mon, 22 Apr 2024 11:27:25 -0400
Message-ID: <20240422152817.2765349-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: e3eb823e-4ea8-48e2-d283-08dc62e10cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mOOrj795O8yjLUXIQ8q9FR623A4XzxvPHnOp6chfkHpYCI83xImNqyZlsKZl?=
 =?us-ascii?Q?yb5m62j35L9Tj9gM+i/cjFNCdj/n8wfIMiLOgMshlvXJkgtphQ/TB/6CzGLn?=
 =?us-ascii?Q?WPIU+0zD4ikpwNoXhqEfhjLn04xwzNlsgAX710cWhgAEX9Rzrfbxi2p+mHue?=
 =?us-ascii?Q?6tanIZxCS0sum5OdBAlonm4C9f2LKgsAdIJydc/uOZOJ+MMW28rpwizTNpOf?=
 =?us-ascii?Q?7PJi5nWsC1OSghjXQgmY1faXD0ab9ncmHNAS0R4E3r5/79+cA3JQPL6ylCC1?=
 =?us-ascii?Q?6ImShYe7TomRAAXFewbArOEk2pf/aYK9NrgkjZWP1h8hIquDzsEl/zgeKORM?=
 =?us-ascii?Q?DznX5NaPgl2ylRCR3gIzqQPJ4gunwFO0cPgr19Rn0MKwlyNtHDFh5k/JP3WZ?=
 =?us-ascii?Q?HnxWr5edC1S/FIMFC9OlCMfQy0xmnzy72AAc0yHEGRmVRXa8SXpVfutGzx8C?=
 =?us-ascii?Q?oaXmKmoeQcpJVNSZkEsQFpgn5+Mq6PBpWDu9T1zkxHGD1BLnynnufhrbmdth?=
 =?us-ascii?Q?aKZmK1CqUJriLcCpsG/fF3w1BgJTmnARx5bgqIThy/ezI+HmxlGKH6s/+oxL?=
 =?us-ascii?Q?kpUuxYJyYzLnzbf2yBf6TSR61OzU07rS13NCxpEM8wUEWGmazCzYU+kgmkdA?=
 =?us-ascii?Q?H5PGhztIPxuXv6jr0VSF7HV3rgAjige9xk/XJ8Y7HpTxMLcrYi3o6IeRWM9a?=
 =?us-ascii?Q?hSBaCtFvFWEpnkd8b6YFMVDphSX0E1m2NYah/kZI5WcR0a3RsI1N8/bEM7C8?=
 =?us-ascii?Q?qb7k04drJX3jLmsU0wMOaCLM70RVv8RmMcT62TIrfAChNa9/UBwaM4pfyZQE?=
 =?us-ascii?Q?pINrCFpLR3mgVJG7Gk+pEGP1rITojntCPiSDu0ijbIuhfrjc/OBW0UYpWR7q?=
 =?us-ascii?Q?3z/U/R+i49NGeoXWBBpBtE5IAlrCVofvb7yptjJdi/zpiihS04xqSMVJr9Bz?=
 =?us-ascii?Q?ToZqS5JVokiJvFKDvKEo9qUMWc37oPBT0gSKbPw69QgbV/XUVrCyMmKuhfNv?=
 =?us-ascii?Q?HsOWoAIlH5kfa+ygjEleXzH8NUpfIQdOi4LLXhYWGc70zfWmqgKPqbu/RSOt?=
 =?us-ascii?Q?dmZfpmbQtJiG7PH1vKUl9yNVasHWMpfD2DksjS9vwtJT/ibEkOWoUd5B27H1?=
 =?us-ascii?Q?I5tcec6FYhyYbO42IAqJzLzaulbjnC6FY79RD7GMbCrqCmkHvYiIWFT2/wJh?=
 =?us-ascii?Q?vv+IOOINHpps5lV3yoG6UuztZx62cYUlvYCluSsyRFzaKf0ztDR+8JpR+Vmg?=
 =?us-ascii?Q?/53QqDpz3PiURRR/4ny4YrBUXCuEGvAor2lT6weSvyOrFLW4BNx3fhlFrUXR?=
 =?us-ascii?Q?DTUD7ks52hs+bwk+GCXCf+UhRBY+NUYl59FHTOKYgUvPnWd5dFSy8DUmRiQz?=
 =?us-ascii?Q?SuOnDBU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:49.9876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eb823e-4ea8-48e2-d283-08dc62e10cba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919

From: Natanel Roizenman <natanel.roizenman@amd.com>

[WHY]
When switching from "Extend" to "Second Display Only" we sometimes
call resource_get_otg_master_for_stream on a stream for the eDP,
which is disconnected. This leads to a null pointer dereference.

[HOW]
Added a null check in dc_resource.c/resource_log_pipe_topology_update.

CC: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Natanel Roizenman <natanel.roizenman@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c6c30919cdd1..77c9c3ee755d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2295,6 +2295,10 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 
 		otg_master = resource_get_otg_master_for_stream(
 				&state->res_ctx, state->streams[stream_idx]);
+
+		if (!otg_master)
+			continue;
+
 		resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
 	}
 	if (state->phantom_stream_count > 0) {
-- 
2.44.0


