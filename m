Return-Path: <stable+bounces-76770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC4397CDA3
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 20:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2911F239B7
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7AB1CD1F;
	Thu, 19 Sep 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0vCKBVWU"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89237200AE
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770885; cv=fail; b=gMXd7lJq5ASHTIYMcWwAwlN9tNfRU1JCd8tdjTLiyDWS9LdmN5MecVgKuZgDnr7KAq/+qEpB79YlrcGjADHjy4ywzKzSOG9rY8W+cXQD9fdnvcdAKZB3V/BOZhZ9eoxAjs1vQ2pKzvvK0ebcUdjHmiYiqIVd/1P54woxW0Kmxtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770885; c=relaxed/simple;
	bh=4PU9xmXFk6bvnB9DS7dQgcF22I/7rvgI5y7JGIrvAlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cerC8hqAFVge8CVkjV2tl55H5TckQUPtkr+vJ60+H/4jQLKDt861n3GOLyQ+oiP+5HXVY4bcdEewgMYzPIxD4nXZ1jvFgOuP/jYHzcqjf9l+IIY6hFvGdOP6lYRCeqDiUkAo2deVsySd65WlWW2G0ZlTJw3G7Tknhb7UC8Ddb9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0vCKBVWU; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qqb7H/WpdoeBU3AVNpGH+QDNKxl+OTCFQAWVHy4MCF3qdm7I4jljgcfCC8DOq+d6w7vAmnq/D31M9BqbbnggJ8cIO+FaHmXpm7CV3h910iXPTyC/6ZQvArBuCViD7v6g+M4701SsE7MYvDIaPxmmz6Ss5g/4yvmghw0qEOl3+OcBjw3VqaT7wTwy+9y+AOFbEO0h3q2ESjGcQwGzUDUwSCIRHqpsX5m7bV/PXHtpANYIdKevYuryE/mSJM2LQKatS5x+LD7VOyUOqx7TTZZgbYmn5qrrDbAya5yheVdzja7K69jPO76hLH5woPtdD1sIpw/cs6ihSmXpknhHesvdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2XiZNHmynGpU27Hhny7g4Tfzje8Ro3RDYvxdDCZkKc=;
 b=YO5YixelCn1BMHX8hx3pM++rxITNPJRaO2otoZP2tbS/GnTFh9MUVIrs+MDBixHHIry5G1RPWiU+ibim1xK2y3WohWRs6U3TMvfoJE7t6/xHm7BR/HN1qDfgIzlD6YSpUQrS7/YgVmUKZ2bwkFCueOt/uRJcMVACjmU2RW8ZNCC/5c8gqydx4TIz22OCfnC8eweIapf0h4IajaLxTgORtG/l5tBvgv8QaLsc2lOYIF9Ahsezk9aZOVbQtIqWv/jsjvE3EqCjTiIwz2phk1gbOs1m6CDQ5+E5GYKfeV6A4YH7/FkaFVzmKjqdbwriaI+szedXH3Ci6LgsKSwiNheXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2XiZNHmynGpU27Hhny7g4Tfzje8Ro3RDYvxdDCZkKc=;
 b=0vCKBVWUWVy+wICeAQbdnh04DyNYqUornH1eAkYo2kBUxP6LraCPznwjr6zxNtIZQMiKvg6KTeyhGh8YzjoD+oQw25wgeeHFBouL9IKAkn8p2nPRRsWHt7QWi6dt18CkxT5rC/mH40J6JOD2iWA7LPnKoBqFriSVCyJXiTvgC0Y=
Received: from PH7P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::9)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 18:34:38 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::df) by PH7P220CA0058.outlook.office365.com
 (2603:10b6:510:32b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:37 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:36 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Yihan Zhu <Yihan.Zhu@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 01/21] drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35
Date: Thu, 19 Sep 2024 14:33:19 -0400
Message-ID: <20240919183435.1896209-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc15999-d029-4bdf-9aa2-08dcd8d9b7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wSK5GAR8XAC3xPLel1uZpGeJD01NgehUkizcHfmTMEkat1hZLfugQP0Rqs/t?=
 =?us-ascii?Q?2+vC8fcqvSPUMQv+7gNYO4bbUSyMaUL2KS5sBT5APeX06VepTc19ZxowRW8d?=
 =?us-ascii?Q?tOrjAqCsaDsDE2GAb1kytqna5Rh9pQpNHMIhk6HuohxUkS8+hia0gU3w6/or?=
 =?us-ascii?Q?TUUrTioSRm80PSSJiNDkWb83/nSd5fWmoOPpHp+JG04m8wPiN717kTjtX2DP?=
 =?us-ascii?Q?UQAJJle0MKliIt/7FeISGm4535tYKRlYSs1Ynrc5Fjy7HxOUn8Blr0bRguXj?=
 =?us-ascii?Q?4ndhBQZSJ3JZCFHimL6FHw8Irt6OoznHUIHqDej14h6cty/GW8/sLeYpCTiP?=
 =?us-ascii?Q?lodVlJbKuk3Uz1D1E5QGw/jaIQtM63ijPKy3WOEirNrSTeYPIh/7E2uaSnoB?=
 =?us-ascii?Q?gymmEnNksDBrBRH++TzriTkLLathwH5eNtj7oyAesX/zmhb/RIZWO3YDtCPz?=
 =?us-ascii?Q?ddURi/NZ+89ouxRgxfkvXmQ238hwbrygJVOIfenPbaoLaUPXukuO98g6fQ6Y?=
 =?us-ascii?Q?PTABqlXxovc5E6ccj0CRuCzIHxTKV+K4JL3OUzr88ChN7JzF+L4PCpDdfsag?=
 =?us-ascii?Q?SNH2HV71X0Z6NnwyRQnKfadBof2hIgI1VnQby7Clb4UkvTxwRJ9vAxcZlFyx?=
 =?us-ascii?Q?8u75XXURnjGdGWFWwgVhmFMZEQ4E22NyOPP1wVR/xoDsGBrIWnjSyN8bxKXF?=
 =?us-ascii?Q?Q5uYGQtxm0K6SH4WMaGXdiqJUhe65bBtbGLcijRD6nnxcA5VJk04B9Lyq0kh?=
 =?us-ascii?Q?Q49QMkLkYFIp1D84H+xpb944z90/cuzKflPTCZ8lyW2NKXgWubpNCLqVg+MS?=
 =?us-ascii?Q?B/WOa4G8Zwoa3pMeDW0hfdstZCdCAkUQX07OX+mC8y9z21uC8P1AjGAAAN5f?=
 =?us-ascii?Q?FQfBGTui79wOOGPP098xZGxBD8lmTiW6+vT2vtV3Vgod5qzoddiFES9pWvhN?=
 =?us-ascii?Q?Efxj2LfcEsTplnORZTZ9KmznLIRZLsQ3FjsuO/0J7D63tX5e5iRgN5wWA1/s?=
 =?us-ascii?Q?kIpBhsUcrHcMONvp/cOnD2ZKBmVhTjZ15EE9le4L7ic+b+6Re4kuj48njSqB?=
 =?us-ascii?Q?NatktQxwPGr4h+lch98VqujchCFyknSRafP6BewcqsrppmlUAVYvAKf1HoRt?=
 =?us-ascii?Q?1rZWGeUN5zC0eDyFBRNHgNpLSnKvMy4BwFIM4ujpWpnQ5GGx0yd1keCH+hN3?=
 =?us-ascii?Q?F9dKWKYaQWcc+PB6hGAh/woGBW0bVn7YGXxULamIc/Azhnw6WrGJNN36Yg4z?=
 =?us-ascii?Q?wOppW4KWnNWiQQN6Cx2kbY5kr8Z6AtDda3RLWo2yf8IR0uAE4mlSdio48wfJ?=
 =?us-ascii?Q?FwNdRxp3/0wonGKDJhkrQTF5wYWVG02d+AaWuxNl7M4Xlh9Q6+KJWAwyyRLu?=
 =?us-ascii?Q?cBSl+LtT1tNSsTTI7HHfl3d0WiFQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:38.3177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc15999-d029-4bdf-9aa2-08dcd8d9b7dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
Mismatch in DCN35 DML2 cause bw validation failed to acquire unexpected DPP pipe to cause
grey screen and system hang. Remove EnhancedPrefetchScheduleAccelerationFinal value override
to match HW spec.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index c4c52173ef22..11c904ae2958 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -303,7 +303,6 @@ void build_unoptimized_policy_settings(enum dml_project_id project, struct dml_m
 	if (project == dml_project_dcn35 ||
 		project == dml_project_dcn351) {
 		policy->DCCProgrammingAssumesScanDirectionUnknownFinal = false;
-		policy->EnhancedPrefetchScheduleAccelerationFinal = 0;
 		policy->AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter_if_possible; /*new*/
 		policy->UseOnlyMaxPrefetchModes = 1;
 	}
-- 
2.46.0


