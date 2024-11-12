Return-Path: <stable+bounces-92838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9779C645C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4839B3863D
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44525218D7B;
	Tue, 12 Nov 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1C+8bm7M"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BE21894F
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441511; cv=fail; b=EoRzBT2MlHwrZIPux8CZSTYTXq/zhe1Qc5nUdYmB13c7iVOmXrWSOiyVSwJx/bvdkieyAFyAf8vY0XJcdXom0PvT5thDVfhDXCKC0vmVjyJRTaVmBs6VBSASXTPYLNbM4A94So5PeDedlZEoHnJiA9lB3BJHrMUuuK8ENrjwilQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441511; c=relaxed/simple;
	bh=zWcA0l0COkrxB9ltOJwrt1TMb3pbpL/uo6uW1+Fnxy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYqbuX5R4BAzldU/ddagV2aRrAtTf4LGNVgtyAg5MzebFa8eLB8Qm3JRwiGpPcoEDf2vctxKuLIPEtJ+MxQ+xm179E9giuAxg1bzX2kXVtCBopl54F1TtH7rjUe8juv7BsV3aDzADurSmsL6g1ptSYw6TiE9LrzTbmrmgLP5YOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1C+8bm7M; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLsR4g8aM9sa2SJBJoGNNo7PXfW4xRt3zWxR++V1hHW07Kaq/xryi283aXDRJh0VeSr+C9LVf+JYtKFaFZiMr/sZU0/hOAeFaLu82VwuaVkIdcZ760OC2rYMwEqviR+9vLmNWgPzL0d3xZejr4KypqzG00QBHzQtVSeqKsIQZkDnIrlqGcjtMAJdXEJtRbJSXdeemwu9euFyC4kmJbycoYA3ITr+Dc2CKOgYePSt18dNXkc706d1s8BbD2NcIv4GuiNktoFcTnUUjVzLnwlJMew9UZK6xUimj4cbaoFAKn0oAU3XfStv3hG83q/7JfkpZa3stPW3+RxA1bHiORQQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPfSx3IJwF1qVJoBjqQ9/vhUaMWd1QmQV/1t+0nIXrA=;
 b=ps76PYNnMHBCw7p1XBALnOo1pWlT4kFOChpZW+odjiEffusxLD2YjP1NePbeXqaamI5vBpYG0T5AbzGhTZMTostZfERLeRC/nSKMzOXfKwjKJnmYot7EzoZGejEbV2uwicv+vAPe7zSS4WiR/29XGLuTfy8FqGlJ4P69D3S4c2ws7dwSlla8S1COmdULu7L66R505R3Ob1mdE/5c7uN8wHjzI+/gF/Y1AZajetGb51IjHQTULY7XYUE3pME4BzdhoEFziXCMQPS7uvpDIRhSqbzAFzRQvYcOHpx4GxIja67c8be7rdknqffTZyNjKMU3VevUOzJFTgWf9606D80tpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPfSx3IJwF1qVJoBjqQ9/vhUaMWd1QmQV/1t+0nIXrA=;
 b=1C+8bm7Mc6LNcBBnScnBvYG/Kbxi4Y9vzwtcE1FLEHhMc8om+pc0QkzCChTsFMIjRXuiEX3m8lNYmYwkmifKJnzo/tP99TOPnF5ToS3vBOH9mm7tskw9hgdFdxaxBtJAC7hpFSPk50UDtkXw/m9ec6JE2/BeV9QY53BXs+zl/xo=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 19:58:22 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::c6) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:22 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:19 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Dillon Varone <dillon.varone@amd.com>,
	<stable@vger.kernel.org>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 4/9] drm/amd/display: Enable Request rate limiter during C-State on dcn401
Date: Tue, 12 Nov 2024 14:55:59 -0500
Message-ID: <20241112195752.127546-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 248cbc1d-e496-467b-f206-08dd03545c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3tWY7CUCG3tQjjT4S9Tdr+wGPffm4x97MA14w3KAHjGsBRsz7FIw0XIVw7OE?=
 =?us-ascii?Q?VFKFK9Rj190tsJO/GhuPPlWdutPHY5qmt05hrWb+2hDJxyb29g5g21KBZ6yv?=
 =?us-ascii?Q?PESi2kAuiU52cUFUzySet246KUuAZQQZa6C+D36BKhOlfbbz+xXZE8k7xYCd?=
 =?us-ascii?Q?Y/sFh+mjmTIe35mkXuT8gpoSweswf5X/dlDP7MmehvQHfKOdxOGG5Xt/Ailw?=
 =?us-ascii?Q?NZSRetDXpw6GsDSAWESEng1bXvOAoFs5z5Kx1E6qgjan1rsJHU3goPpX5dfw?=
 =?us-ascii?Q?u+VDGfZXFDGil1uFfMlElv5hRBW18LJkdVf+bKvmtzB+nigiDA5WRr8KIQ+x?=
 =?us-ascii?Q?oarbp0n20YTCJNSEQIBdq7U0ECQn1J5c6cHwiJXVzDqFPSyUS16KrVuJkEVP?=
 =?us-ascii?Q?HbKMUPdbyYfZVU+yiutKFMv1EM6no0F54VU+nQclbVG3MioH2hrZOzEWOTI5?=
 =?us-ascii?Q?OBSVP7uSJ48tALo+gw/t05AIi2dhp8BY1ImTegDxPCy6Evq6nbClt4GQ+KMn?=
 =?us-ascii?Q?frucYIw2AZ35TyVDUOg9wNMlAMZnjWhpU0ARSDT0SLReNB+STB2rxt/BIY8c?=
 =?us-ascii?Q?HB/4sEsKDZHbtVEi8HD8hArydHO10wjvnJ0AZ6EBnQVQIdaZ56AIDcAIhNoO?=
 =?us-ascii?Q?vW1agaH68E1FPV+mUNuO/JcweuiPpIsl3oRYc1x+BTaKaYbTEfNKHJm91LzA?=
 =?us-ascii?Q?P07fmpy/Z3vnZXE9DE+HHisfMo3DXIjcTufA4drj4QGDJ60sQ3/bAsxb4Q97?=
 =?us-ascii?Q?0BX0TijbiV0vcex6K4pN/TYNl7b3hU0HYrgzRtXAZFbwbU9YB1UvqDHybsW4?=
 =?us-ascii?Q?9SirPySkOvM28gcz+t7ENIpliwQ56jcrzNIe3kw14IwMLijPgVvpMoYxckxL?=
 =?us-ascii?Q?kZxXPf297wzmsfwOQuE0NhDRdZvMAQON2fnpEoe/KQxIz0tuOWVUz/Q9R7ws?=
 =?us-ascii?Q?ulLQXI5vCA1ujDlSFqI6evoOSMVV6jsL2YdkVQlYQmbHqn8E7iOPbFeSBR87?=
 =?us-ascii?Q?FKQlwcDyLNl9f8yH4gDLMjvvMRtew7Ooou8B5UNBtG1HOTlPcvNKs/f5kTCb?=
 =?us-ascii?Q?bi9Yj/SAmMMyPagHdhgkfKFx0fZ6k72dv6JB5tok24YszK9RScmYaVU/Xicd?=
 =?us-ascii?Q?S/CAHxd6S4HNKcJ/X1j/pltX5eGziozvqqCq9kK5CEsTu7eHcZoKKwYBDK4m?=
 =?us-ascii?Q?x6KhRfd2xNLp/MqGieyOcX6RBtcrX0u3WuDxSYYnsxgMvFbvUe0q52NeAzmF?=
 =?us-ascii?Q?/ZH2dzr/sNXV94ECkox1Fht3vMPhlAlD8/9PlOMnMk3RHCTX/lcMQ1GhA3P1?=
 =?us-ascii?Q?bR+JzFCvKYC/++fEOjS1YiXz66Cit7SWeSBaNAjt6sRwtsnMBvYIGgMKgpkh?=
 =?us-ascii?Q?LzQ5y8LZXefmQJi0tNiTwBTZjTdNTLqK7sEeGfoyE8Sw1I57uQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:22.0258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248cbc1d-e496-467b-f206-08dd03545c9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
When C-State entry is requested, the rate limiter will be disabled
which can result in high contention in the DCHUB return path.

[HOW]
Enable the rate limiter during C-state requests to prevent contention.

Cc: stable@vger.kernel.org # 6.11+
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  6 +++++
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  8 ++++++-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.h    |  1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 24 +++++++++++++++++--
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |  7 +++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 13 ++++++----
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  3 ++-
 8 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 92e43a1e4dd4..601320b1be81 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -11,6 +11,7 @@
 
 #define DML2_MAX_FMT_420_BUFFER_WIDTH 4096
 #define DML_MAX_NUM_OF_SLICES_PER_DSC 4
+#define ALLOW_SDPIF_RATE_LIMIT_PRE_CSTATE
 
 const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_bw_type bw_type)
 {
@@ -3886,6 +3887,10 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
 #endif
 
 	*p->hw_debug5 = false;
+#ifdef ALLOW_SDPIF_RATE_LIMIT_PRE_CSTATE
+	if (p->NumberOfActiveSurfaces > 1)
+		*p->hw_debug5 = true;
+#else
 	for (unsigned int k = 0; k < p->NumberOfActiveSurfaces; ++k) {
 		if (!(p->mrq_present) && (!(*p->UnboundedRequestEnabled)) && (TotalActiveDPP == 1)
 			&& p->display_cfg->plane_descriptors[k].surface.dcc.enable
@@ -3901,6 +3906,7 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
 		dml2_printf("DML::%s: k=%u hw_debug5 = %u\n", __func__, k, *p->hw_debug5);
 #endif
 	}
+#endif
 }
 
 static enum dml2_odm_mode DecideODMMode(unsigned int HActive,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index 4bd1dda07719..9fbd45c7dfef 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -200,6 +200,7 @@ struct dcn_hubbub_registers {
 	uint32_t DCHUBBUB_ARB_FRAC_URG_BW_MALL_B;
 	uint32_t DCHUBBUB_TIMEOUT_DETECTION_CTRL1;
 	uint32_t DCHUBBUB_TIMEOUT_DETECTION_CTRL2;
+	uint32_t DCHUBBUB_CTRL_STATUS;
 };
 
 #define HUBBUB_REG_FIELD_LIST_DCN32(type) \
@@ -320,7 +321,12 @@ struct dcn_hubbub_registers {
 		type DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD;\
 		type DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD;\
 		type DCHUBBUB_TIMEOUT_DETECTION_EN;\
-		type DCHUBBUB_TIMEOUT_TIMER_RESET
+		type DCHUBBUB_TIMEOUT_TIMER_RESET;\
+		type ROB_UNDERFLOW_STATUS;\
+		type ROB_OVERFLOW_STATUS;\
+		type ROB_OVERFLOW_CLEAR;\
+		type DCHUBBUB_HW_DEBUG;\
+		type CSTATE_SWATH_CHK_GOOD_MODE
 
 #define HUBBUB_STUTTER_REG_FIELD_LIST(type) \
 		type DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A;\
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
index 036bb3e6c957..46d8f5c70750 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
@@ -96,6 +96,7 @@ struct dcn20_hubbub {
 	unsigned int det1_size;
 	unsigned int det2_size;
 	unsigned int det3_size;
+	bool allow_sdpif_rate_limit_when_cstate_req;
 };
 
 void hubbub2_construct(struct dcn20_hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index 5d658e9bef64..92fab471b183 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1192,15 +1192,35 @@ static void dcn401_wait_for_det_update(struct hubbub *hubbub, int hubp_inst)
 	}
 }
 
-static void dcn401_program_timeout_thresholds(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs)
+static bool dcn401_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
+	bool wm_pending = false;
+	uint32_t temp;
+
 	/* request backpressure and outstanding return threshold (unused)*/
 	//REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, arb_regs->req_stall_threshold);
 
 	/* P-State stall threshold */
 	REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, arb_regs->pstate_stall_threshold);
+
+	if (safe_to_lower || arb_regs->allow_sdpif_rate_limit_when_cstate_req > hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
+		hubbub2->allow_sdpif_rate_limit_when_cstate_req = arb_regs->allow_sdpif_rate_limit_when_cstate_req;
+
+		/* only update the required bits */
+		REG_GET(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, &temp);
+		if (hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
+			temp |= (1 << 5);
+		} else {
+			temp &= ~(1 << 5);
+		}
+		REG_UPDATE(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, temp);
+	} else {
+		wm_pending = true;
+	}
+
+	return wm_pending;
 }
 
 static const struct hubbub_funcs hubbub4_01_funcs = {
@@ -1226,7 +1246,7 @@ static const struct hubbub_funcs hubbub4_01_funcs = {
 	.program_det_segments = dcn401_program_det_segments,
 	.program_compbuf_segments = dcn401_program_compbuf_segments,
 	.wait_for_det_update = dcn401_wait_for_det_update,
-	.program_timeout_thresholds = dcn401_program_timeout_thresholds,
+	.program_arbiter = dcn401_program_arbiter,
 };
 
 void hubbub401_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
index 5f1960722ebd..b1d9ea9d1c3d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
@@ -128,7 +128,12 @@
 	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_DETECTION_EN, mask_sh),\
-	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_TIMER_RESET, mask_sh)
+	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_TIMER_RESET, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, ROB_UNDERFLOW_STATUS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, ROB_OVERFLOW_STATUS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, ROB_OVERFLOW_CLEAR, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, CSTATE_SWATH_CHK_GOOD_MODE, mask_sh)
 
 bool hubbub401_program_urgent_watermarks(
 		struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index e8cc1bfa73f3..5de11e2837c0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1488,6 +1488,10 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
+	/* update timeout thresholds */
+	if (hubbub->funcs->program_arbiter) {
+		dc->wm_optimized_required |= hubbub->funcs->program_arbiter(hubbub, &context->bw_ctx.bw.dcn.arb_regs, false);
+	}
 
 	/* decrease compbuf size */
 	if (hubbub->funcs->program_compbuf_segments) {
@@ -1529,6 +1533,10 @@ void dcn401_optimize_bandwidth(
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					true);
+	/* update timeout thresholds */
+	if (hubbub->funcs->program_arbiter) {
+		hubbub->funcs->program_arbiter(hubbub, &context->bw_ctx.bw.dcn.arb_regs, true);
+	}
 
 	if (dc->clk_mgr->dc_mode_softmax_enabled)
 		if (dc->clk_mgr->clks.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
@@ -1554,11 +1562,6 @@ void dcn401_optimize_bandwidth(
 						pipe_ctx->dlg_regs.min_dst_y_next_start);
 		}
 	}
-
-	/* update timeout thresholds */
-	if (hubbub->funcs->program_timeout_thresholds) {
-		hubbub->funcs->program_timeout_thresholds(hubbub, &context->bw_ctx.bw.dcn.arb_regs);
-	}
 }
 
 void dcn401_fams2_global_control_lock(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 6c1d41c0f099..52b745667ef7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -228,7 +228,7 @@ struct hubbub_funcs {
 	void (*program_det_segments)(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_seg);
 	void (*program_compbuf_segments)(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase);
 	void (*wait_for_det_update)(struct hubbub *hubbub, int hubp_inst);
-	void (*program_timeout_thresholds)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs);
+	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
 };
 
 struct hubbub {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 7c8d61db153d..19568c359669 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -612,7 +612,8 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SR(DCHUBBUB_SDPIF_CFG1),                                                 \
 	SR(DCHUBBUB_MEM_PWR_MODE_CTRL),                                          \
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),                                    \
-	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2)
+	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2),									 \
+	SR(DCHUBBUB_CTRL_STATUS)
 
 /* DCCG */
 
-- 
2.46.1


