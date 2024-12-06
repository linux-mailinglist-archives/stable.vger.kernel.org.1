Return-Path: <stable+bounces-99953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FFD9E75C8
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BDB283B72
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C994220E317;
	Fri,  6 Dec 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0DPfHahB"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3D920ADD0
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502098; cv=fail; b=kT3arIjs2TMp+vGj+v/Sj+v5laVF9uejEV0zMbF7G/EGAg8xMoprp8L+fbWGVYolvaY7Rn3Ok+piFk8JwmJd/ZtTWUvaSqWQo0xlF6kd5ysunnfmVEFfkAnmQjEkoSBWusG5UF9RLnMWziWrwadZhMANYu4eQoPSE9vmx7JmL6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502098; c=relaxed/simple;
	bh=pR5Y2TW9PteA55lobE2+T30RxF0Uhjk0K7JBZOU9eRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uk7XsUdXgkx8Vv54bAzpLEidtOTIQpu75Lfo9rI/CXkB/Z99oVYurdgVrEWs9Bh8zmWRr17HHQeS5COfYbLu3SxUG9vBOF0UaDGRdgklp2dTBuUBvg26HnZ16zdXVI9ueGFN07tpE4Vm1jEAH5s2st1ZtVv9B/76DLP3QvG17Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0DPfHahB; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYHSIZQHxpc6SEWSaFZBM0GEBs2wxM2dnQ1NrLrIHDGBGnL0e2DBNK9b62qp/rFQWE60s57bQTDfEwZZbof6kDhMax/WUNYWOV9k3n9gUub/gjhpCzGdhSMb/ZSIo11j/SxbbTJL/6dUmGRE443D8L2xf+XWbE3Ce9sDaevf2Y4KHWtNeq8fj7LOuw/ZWsjZl7CaQ9UAIcVKNLnBHlDU8SuoHyc4hrYXBFSbUR5bF9nZWrJRjALayQigXNp0BDB1dI4Lp+0u0uopgb3OjvC3AZXaxi76btTCJ1hTA0NwUBIIGPrO5ovN2tLcBgwFl0Pp52LqpyB1jzZUxy1aFRYSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr9m/A8l62jsuJfFh8pL6wv2kmGxtVIcTyCeNuwJEGo=;
 b=YrBx0gYBhfTuIZ/BKSqAFdavPaEB8W7OMCmCkYoQQLl9olkzFAMC3+nNtmVI25ZS2MOm/9fqFVnkQwF/B87EtClX5/Sy4aZWnbnOJDl/+Mo3UvYNugvHYHTQ34NFJD3W4zhMGemCx+nwE5K+k9t7he3zGxazytbnoWsRvoAeAy4s46deDWGWKL7VjUq7P09pxvdXIU8dVUZixitjsdJBuYQoBuyKu7/8UmabsgOSwqxZcXJoXdXIFH1mVqW3oEP5SFDCYyCpiVYCtGmxJNlrhimdll07bCR2Fc5/9pd7oNtENDvwCVzmQl1awVxXlHYB5I/2kPpkBo8zu3SECS0pVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr9m/A8l62jsuJfFh8pL6wv2kmGxtVIcTyCeNuwJEGo=;
 b=0DPfHahB6TV0dkKlW99f/3WEDJ4yZzyEQuWifQtDbESJR9S5kjOu7QWSjYSxCgHJdf0V7mnlrbXom/xaRfiNeNwGAdZvqi/d1LSmUKbYdmc0saaoh7bL2E1GFI/6Ia9+1y4FcQrxRlLxrE7O2GkvuZ2vzPYyNPU30dckOsnZvMc=
Received: from BYAPR03CA0026.namprd03.prod.outlook.com (2603:10b6:a02:a8::39)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 16:21:32 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::8f) by BYAPR03CA0026.outlook.office365.com
 (2603:10b6:a02:a8::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 16:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:21:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:21:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
Date: Fri, 6 Dec 2024 11:21:16 -0500
Message-ID: <20241206162117.2496990-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 545bc045-248e-4493-5a8e-08dd16120bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Yd2Maod3Vlmnd2F7rTQspoTGi6HXToGI9E9shBUkqCNzJojUwbT7BrtMKV8?=
 =?us-ascii?Q?Mmijbz4oDEmRigBzuL9xrpWroGqk2jqt/R9lQHj5wcbYMQtSY8SqILEj+PP6?=
 =?us-ascii?Q?9WM+jjjsG/wEnA05a1mo+LsBr6jt2959UGcvmN9uV5fLCM7vhgf54YCQQsAg?=
 =?us-ascii?Q?wRcNklUfybCz5i8VpReiUPzBqXqhTgbw419vFn4qeYRzjASJNs1liJG6/14Q?=
 =?us-ascii?Q?ZEm4pPYc1NL2NzAP5rGoSSgNYMqAJ0EbEoU/9CVwQwOoIH2qnvnT7wRzYj4S?=
 =?us-ascii?Q?o2aXwBAiy4Py+dLMYMsMjJBBuPoXxFuBD7JxlRe2OjdPSLbl+8nX8cA6kh4f?=
 =?us-ascii?Q?kfVRn3pASImSFgshzNfzXlbOiuWiY375X78u5pr+mV7u0G0aEdVeLWJgO9OV?=
 =?us-ascii?Q?jlPTDEt7QXcNbFSeJ8CaP3JqpdY6YKjvmvvJq/ZIOTQhqXbEkHK1LtXAPIyP?=
 =?us-ascii?Q?si11FUGYsthXGRf1rjqdl8tqDE3sDtuqUF47FWDCRXTyDplR7hsCiViUzxk+?=
 =?us-ascii?Q?viw/jJLBKRLn8inhMmvG2Ey3GhuDrVlOgoR47yNIaW/JhYF1YQhsZFa8Ki95?=
 =?us-ascii?Q?6MvXZznTYLKF0JKU9rpp9clS+ygvlXK+2NDOvVOoQExTLKGiHVhBvBPDTGHB?=
 =?us-ascii?Q?8g3BIsFkgc9UXwvyN4R/aII5v10Iboh4mxY4GXW2EBlJ2777VhQuvqlRxAhk?=
 =?us-ascii?Q?KMZ5NhQQyV8dNKBZ2oPnjhdey6PknFqWjR0A8lv6lsTcshQsXA6icSGtrwZE?=
 =?us-ascii?Q?EBqb2nQgPOpKt0zmB2WcRtNb5quD/sx0nE4BUShMsQ0cVb8xwaMQxlR2a9Zx?=
 =?us-ascii?Q?BzPHt3A3Yzlh+v3Vk8/Iy6PFKQSoSD8Y8POxvg/+hrYYpvi+AU76hBWwkg3a?=
 =?us-ascii?Q?A0KLfwe1XoHVYIXLUo74twB8O9Pk1bJlBb+uROsqMWhxK+A9VE/vlIlPw1MO?=
 =?us-ascii?Q?WXDygBeVWMYsfIcauD8ui8ovTNE/jdRIs/MKiFHpj/EXNVoaq79mPwMPIEqk?=
 =?us-ascii?Q?Gqz5Qcp9FoKQoJ6oAWMJ2Wiv+YIl0qfC0ElZJ0DqAsrKxEwZRIeXQ3MfV+CZ?=
 =?us-ascii?Q?I5g0BmkCMNisk8qj5NyoL1OwUf3kDlQm1AoMAKeE3XHZtpfsPGZLpYiEFGHM?=
 =?us-ascii?Q?v/ygc9LdGdFOtyf2+Z24n5mhlhAYOBCoeQGzQY/nLkRZ5cU0QLIaGar8wOqS?=
 =?us-ascii?Q?fnMk+VB1zj3I/dqwEAn/pfRHr7ZRxh0IhB8SGjEVS7QATqbhnusPGp0pTP2z?=
 =?us-ascii?Q?NsrN911lnpHK2qVkZFU6yXmARkdCEgYilW8FaC5DREgUQxDJP9T/vC/6PzF3?=
 =?us-ascii?Q?ul5c1P7WjubnHYzWtD/4vSasaSS55oc7ATJ6SgVo5RuHaY2JBu/yhT7YO8qU?=
 =?us-ascii?Q?p6aTHeXhomiMFC8EC+MNfBE/4RUgyGSDB3SjQsAWwg2+Y5aDJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:21:31.9864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545bc045-248e-4493-5a8e-08dd16120bec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Streams with invalid new connector state should be elimiated from
dsc policy.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3405
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9afeda04964281e9f708b92c2a9c4f8a1387b46e)
Cc: stable@vger.kernel.org # 6.11.x
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a08e8a0b696c..f756640048fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1120,6 +1120,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	int i, k, ret;
 	bool debugfs_overwrite = false;
 	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
+	struct drm_connector_state *new_conn_state;
 
 	memset(params, 0, sizeof(params));
 
@@ -1127,7 +1128,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		return PTR_ERR(mst_state);
 
 	/* Set up params */
-	DRM_DEBUG_DRIVER("%s: MST_DSC Set up params for %d streams\n", __func__, dc_state->stream_count);
+	DRM_DEBUG_DRIVER("%s: MST_DSC Try to set up params from %d streams\n", __func__, dc_state->stream_count);
 	for (i = 0; i < dc_state->stream_count; i++) {
 		struct dc_dsc_policy dsc_policy = {0};
 
@@ -1143,6 +1144,14 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		if (!aconnector->mst_output_port)
 			continue;
 
+		new_conn_state = drm_atomic_get_new_connector_state(state, &aconnector->base);
+
+		if (!new_conn_state) {
+			DRM_DEBUG_DRIVER("%s:%d MST_DSC Skip the stream 0x%p with invalid new_conn_state\n",
+					__func__, __LINE__, stream);
+			continue;
+		}
+
 		stream->timing.flags.DSC = 0;
 
 		params[count].timing = &stream->timing;
@@ -1175,6 +1184,8 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		count++;
 	}
 
+	DRM_DEBUG_DRIVER("%s: MST_DSC Params set up for %d streams\n", __func__, count);
+
 	if (count == 0) {
 		ASSERT(0);
 		return 0;
-- 
2.47.0


