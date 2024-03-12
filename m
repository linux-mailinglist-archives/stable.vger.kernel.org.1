Return-Path: <stable+bounces-27440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E68790EB
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 10:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CDC28745C
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A38464;
	Tue, 12 Mar 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D8JComJH"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868DD78267
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235463; cv=fail; b=dQhQFcu4PbwZAelMQ1eZEGpHhA/vLnZ6goOElD2KDdlgZwThiz735Sn9NahjFffjfvn/voMvYuxXLnIHpZgRewfmd1xzvfei8NS09FYTooZIun5q/K/dC3sAPExHh9ycb+dJhurQSO0bv9yb2SbMGNil3wQIhgnehPxA/eXbBOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235463; c=relaxed/simple;
	bh=kmgUVH7eeQvn1s9NP4l0TaLJi711C+SRdQ8njvTDTeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpGQb9lgEmhvY38TwIpE7AJ+BA9HLGQDbFO69PWiluIUKv2Ni8DCln/j5SwlGYt17dM2yZROsEOs00V1tyGnrl+3kEcJ6blhNnV8NaWDEon+vbmZS3pYToKm2y0Gwtxx2sySb9N6E/cBzqK8VT0euPqsSjGbc/manTFUsz512rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D8JComJH; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRIuDTT3FKj4uDJWlXikY0Zs6mF9Zk+icu0cvWIi+G1ouIibSFNy4pt3C4gdeRkqw7Kl8N20zbMb5Pc+S6ev6wsmXCtmnuJEd4ESAhVYib3zcmkqqfC6m0PGzFRxl52Z8sXA3T+gY3V7vd8cceIXIKguJO1OszD+yHjPhDE97V1eTWzZQArOVTRp125rAXWkJptjPsNsMUiXEjTLH+Obv8jaiavAfcG0E6OtA3niqcvxToEnk18hmSfa5HIOr4hliSryeVdyGx3TQyGxip7s9MaQ7mGNwxND6lzd3oLUR5JkzhhCCBxEzOUE29muYvEVmWYRgWlCqfIH0cXjlnkXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzyyT2p6ZjtVnHGFy68MmIsilMm6Lj9zO+aAb17wUHM=;
 b=ejxXWkaWiDQASAai7g4k+DE1YkwVj45YnqBQ1v8UDF0mEKnPGWXE/6CJhQCFV28U+8hWLndpXIZlTpugVtd0u5z99rfXkzYzHFVkM7LgcwXxw238arbgXKkXcB+w3e+R8mIZrjy9IqN5AGgMK6AH6gi4UoBb+gUl1jfafy9igyCEEy0VnbwajSdTOlREOd4Zl1N2mqn4GTlo9VsTK+nvc9t72Nboex4yDBeixZE8X+IhdclMzhTZDOaf28BKtkK1D9GkKDmvn/R6yaayTYXGp7UJBRAeei26T3P6xYHgoUvkCqLPgLv4cFQZ6jLNqKsjYnbyg7vxmT9Edgaj+18Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzyyT2p6ZjtVnHGFy68MmIsilMm6Lj9zO+aAb17wUHM=;
 b=D8JComJHv9rnoIJkj5+i1zj+ELSFcVvlPZZw3hYiaf2lUC6ljsTcffBS4HEzOIqAOx3C34OF4bI1Ig3ZzoeZgxYMwKOT2uucNKOxhlZscNtVMrd5ho0xklTUGW4yU0kaewqwKFp8hszvdc2HFP0LTLT7G4AwLen6uf2o4AJ6YpI=
Received: from CY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:930:1e::10)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:24:19 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::34) by CY5PR04CA0020.outlook.office365.com
 (2603:10b6:930:1e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.37 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:18 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:13 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Charlene Liu
	<charlene.liu@amd.com>
Subject: [PATCH 33/43] drm/amd/display: Prevent crash on bring-up
Date: Tue, 12 Mar 2024 17:20:26 +0800
Message-ID: <20240312092036.3283319-34-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce64ddc-619e-44be-0cc2-08dc42763229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AL4WGOLgFmq8xBMxDYs7phvVSyuLXA4tJseABzVaJszFR3wSAvdYKSlFfIKVOU6lbvqYNCFNECHrlDLVKN9pW4ymaT6MVbg/U+U58+BiPOYFx9vFbARoY2BUNC8vU9/2k3Xg0jfeZQAhiILSvhSDnegg6L2bKcnF/0ecF18mZlV5vMcq/8A8n8baqXjMwcneyL8f81nH0RBtM/2OFrFqmj7IBurR0roH7DfF9vv2M3/GoKijyo55cl+ebi9Ysab4UXJAKkm4Oro4QkpatKcGaus0+Mn+090dnFv2Tidy+9CO8gn7hlfX0T+u+nF16M6TvZlbtR3S1U7gN8e4IzUdabanetGlDJ2WwLIR85eNdskuTx9egT9aqLvYaxE0TGDWtLWozP9fMptkQqXUi2iAohdc8rO3vlRDf5rGQfwAXra1TBNKx8yFiRGC331IhlY3Dx1gZEsk6d0U4MswCAsK/lAbY4D4FQp5/vRtJfETFlEH2DGS8FqhvkfgG+V8+YUqFKOn/DbwzO9Cp837OvMu4CujSjTqhB2Wq9DiNLuXxvhgKO+xoLhE+0C1H886fHmy68zaGsOz7HhZum5724LLHLEE5qainizrhfwew+ulU27A+b5vCxhFHCVguwaFNw5CUVoLzsJYadT0g18cQDYyexEQ+Tfjz0FdjQTem1fKcDSi3If6BmgxFBnsrSy3sZCVF8DRhTAA2o17iwcW93Mm8mInxc80Q1YhsmC1x/9II+PqyvQr4X/x0kL+85+TVYnA
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:19.3642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce64ddc-619e-44be-0cc2-08dc42763229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270

From: Chris Park <chris.park@amd.com>

[Why]
Disabling stream encoder invokes a function that no longer exists
in bring-up.

[How]
Check if the function declaration is NULL in disable stream encoder.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 9d5df4c0da59..0ba1feaf96c0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1185,7 +1185,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		if (dccg) {
 			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-			dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+			if (dccg && dccg->funcs->set_dtbclk_dto)
+				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 		}
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
-- 
2.37.3


