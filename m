Return-Path: <stable+bounces-54738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC75910BB8
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CF7284A4C
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849FB15B0E5;
	Thu, 20 Jun 2024 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f0e/C2Aj"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5421CD3D
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900161; cv=fail; b=NlvkN+eSdLlMi0RwdJHsqm/kBzja4UPSqM+FbOlk7tcSuvoH41NRUW0bzBAu3KcPMNkaB2qCzz7m6xpwz8x2dapGqxwIycGBrjWY7qgEhre01GX5rRtV/L1pBzuhyxZqgvTaPxrXp24TIm84ZJfWew5nDGfJ1kqTnsBUcY83RVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900161; c=relaxed/simple;
	bh=U58gRi5qev8ql/+/hZ5cJlkw/oktgWYhie7pNB68HmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brxsoWum7eKCwjGbOCPo2H51jfVrNvac9HHf6hYElMequypoM0/KTTJc+MGKEfXSnDl8XU8sO7KRjBwtmMusUFQBQSeCD/4huTAbDlxw9bjekPtpiNTc8jRmSx3TI7CWqZSyHzt3n1FicoaZnjGpHb03XYQ5Pu4jgM5LLdC04CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f0e/C2Aj; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbp5sbnIU2WZCRAL1S2B5mx2STq6lS6Ks11ePN1ZweLVriv89KTFW6Wzl51Eb4J1+nkuDtxsRp4qp5wlKPr7F7j/8SPZ04iXp4zj/tlpCu4kqXRJzS34rZlCWCz1RrKwUgl4uMigd7sG9R7sEbN5Bnl9C+akIt8cBn18389jePWcExsji/WkO76/BPkjInMgrvQETBAoYVUNmVPh/UaovlcOPd74jDCBABgDZDsYNghYwNax/DS0x3odLSFWGUfP+5181hWlUwFhgq9YvdPFIUvGy3V58320XJovf3r7669T1WNlnDePhYE1U6JFLoQ/Z6qWO4/NQFCYQgkxALCPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3uoBTv3v0l81Witt9O4tQ/wQGwUy88QVP/ZA50OVpc=;
 b=fbSBLfPaDgOPbaJRBILNI9UgfEwTgcgID1zcsg1YfkTj5el4QoxEa+Hlu8ddp5cQjcBSPTVVyRfbQgrKl/jkgAgzfTioXbZ5BDuNkpXRVqmUkM+YGcQ7oEGtTRLx8OLZYLTW/457jnUWFqiZDFXYkHBKPqDqIUV/OIaoVzfyjKFhQySEiAHjPc5+qw9U9FU4xTknZFkQUDTer2s1opXbCeYZTu7LcMusa9D5sZYPy4BOnbDPsOQKavTQTxU7ljIYilTDPylzp/TEm6vWlv2RB8Z/rOJljD6/4tIMsEii9libvAJ/lvap0wBoodTzPbw7ZCJddDcMhKLlQ+k5UsP75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3uoBTv3v0l81Witt9O4tQ/wQGwUy88QVP/ZA50OVpc=;
 b=f0e/C2AjhNpsSSeOfl5Byg61PGfzjV8+P4P+mJl+CY8e61HPBU9L64zS1KZPR0m+glbRoFgyHx9f668wLOjIgSUTtjUnBHwAOfe/ehyokV7eHhqyUqSFdxNLISwzLXKlWZPNvEHZpOpLb/lGeRUnzG8rWkc1PmMWoiJrLWIZLC4=
Received: from CY8PR19CA0001.namprd19.prod.outlook.com (2603:10b6:930:44::22)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Thu, 20 Jun
 2024 16:15:56 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::4) by CY8PR19CA0001.outlook.office365.com
 (2603:10b6:930:44::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 16:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:15:56 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:15:53 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, Sun peng Li
	<sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 16/39] drm/amd/display: Use sw cursor for DCN401 with rotation
Date: Thu, 20 Jun 2024 10:11:22 -0600
Message-ID: <20240620161145.2489774-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cdb541-8969-474f-4866-08dc91444433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/0keOZokXPsytRQH7nLJmKhokerRvCeALPQfi5ae5gVFvDQl4nPrS+0cnMZ0?=
 =?us-ascii?Q?1aMKz49uLloJ3b1nu4tDt47nNIrjMEE1l8Vi4dj42t5sc7l3k8Nl6miTzdbw?=
 =?us-ascii?Q?FguF+S8DOsps8NFnEa6bFzsDSial69XWOyKjS7cUL4V3XkvmRjue/RnGTgqz?=
 =?us-ascii?Q?Rffh7JFmdSgBH3MLOwHE0jETVr/dLq0ss5jRB9szBE3rcfOEajvxk+AHeZDr?=
 =?us-ascii?Q?NghejP6BEkbBXn9hx0ktJUPwQmDPURqOWKNI9/7FgX8otUs0rqXRCBsF9FqH?=
 =?us-ascii?Q?+iSsZ5a8AOuj65x/LbLenMpJcDdg+ZuIBG2FmDHNQEBOHzFYUdU38CdTuGVE?=
 =?us-ascii?Q?Gj0+gYn1LwvRko0uX8wvTVn3XoLGsXayFizeOmzb16RWssRvDot3QZOQGD2G?=
 =?us-ascii?Q?sU5Ctl5dXrsOGKloSxzClkboVOKYbl7xlGuG77uy8GcUdlHmxzLM0oMLyC+E?=
 =?us-ascii?Q?rAKMZZj9VQHdEhr1TFJ3bimE3kNVEwuMHBbFaVk7lhJRk17HKXhU42ZtBGlp?=
 =?us-ascii?Q?pDfqxBiqOpvYs2bgZDjEgujMzb6pTJu+COkVoxHMMUMw6BWHgY3fmUE/mu/o?=
 =?us-ascii?Q?6fWjZW3zNYYZHq1N8QoY5fLsmQw9yGJVb6skPm4CX6IMaSTazyt02tzyerlU?=
 =?us-ascii?Q?vjgKh1dgiTw+CuE+rFU990XsRV0Qds5MrCE6SY0A558yr+4ARoLS/KeY8oKb?=
 =?us-ascii?Q?vGvBlISqC0wLN/D0FWipP1ahgcyN4+dc+iL9cr62JWY1wsF5sBHgQ+70PtKv?=
 =?us-ascii?Q?qCF6uYZkbZ14bGurTXjRBRLNUFXdUnULZ0BpPvO1mzzkOyxVsnmlTE7WaSQr?=
 =?us-ascii?Q?VS3PrKPQffzF+coK2MmOXbq6tpFCX4Tb5wDGjan3iHbiPdZkI1CK8oZqA4FO?=
 =?us-ascii?Q?8tQnF9oh6iZGqA7Zu8+VeGZR3nQjMHC17deD5OmaMxZ3b+Oa15mChPbgfT6h?=
 =?us-ascii?Q?YgfKkoU9DMzkbb0coAj++QF3Fkc4PDeLYbveVsaD9gZy64Mkr/cxRLPEnbIb?=
 =?us-ascii?Q?Ts8wWiYfVnvm8YppYAxRZb5WY3RTROwU1VRzQAZBpPcY6ncIvFPtA+hm8BzO?=
 =?us-ascii?Q?+StFd6TU7uoP5cgk27AtHe3ND7laa5vO0mpEi01NnZdKi4r12ROmyP1/tI5L?=
 =?us-ascii?Q?nsFiOP8fx++adOH4xNWjx5+t4N55aqWzsAVI9h3Yp+S+fgE05Ha6ED38WFS/?=
 =?us-ascii?Q?D5MfDIOBoXMurq+WTmZWxjXaE+UGU4ke0+ucNk0hvlWyNnXZegTcP7IIirjO?=
 =?us-ascii?Q?RdcGoK0vIJ4+q/OiQrbeqrFrhZyJcXr+aL70gVLNFwIHJjVV/UDoe4PtWYvE?=
 =?us-ascii?Q?9Mle1R0sGpnLUgIV+BvaFbjozSklfeN51ZpIF/E1m/0ggs56MNRJjz0evP2N?=
 =?us-ascii?Q?kWnCvA5CsSbABlGAp12uzNg0CgxW3eey7a2mqVjGPZ3zEx+ovQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:15:56.6689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cdb541-8969-474f-4866-08dc91444433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[WHAT & HOW]
On DCN401, the cursor composition to the plane happens after scaler.
So the cursor isn't stretched with the rest of the surface. Temporarily
disable hardware cursor in case when hardware rotation is enabled
such that userspace falls back to software cursor.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 34 ++++++++++++++++---
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 590e899ae3d0..89e371f870b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11093,8 +11093,12 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	int cursor_scale_w, cursor_scale_h;
 	int i;
 
-	/* Overlay cursor not supported on HW before DCN */
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
+	/* Overlay cursor not supported on HW before DCN
+	 * DCN401 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
+	 * as previous DCN generations, so enable native mode on DCN401 in addition to DCE
+	 */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0 ||
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
 		*cursor_mode = DM_CURSOR_NATIVE_MODE;
 		return 0;
 	}
@@ -11237,7 +11241,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct drm_plane *plane;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct drm_plane_state *old_plane_state, *new_plane_state, *new_cursor_state;
 	enum dc_status status;
 	int ret, i;
 	bool lock_and_validation_needed = false;
@@ -11465,19 +11469,39 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			drm_dbg_atomic(dev, "MPO enablement requested on crtc:[%p]\n", crtc);
 	}
 
-	/* Check cursor planes restrictions */
+	/* Check cursor restrictions */
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		enum amdgpu_dm_cursor_mode required_cursor_mode;
+		int is_rotated, is_scaled;
 
 		/* Overlay cusor not subject to native cursor restrictions */
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
 			continue;
 
+		/* Check if rotation or scaling is enabled on DCN401 */
+		if ((drm_plane_mask(crtc->cursor) & new_crtc_state->plane_mask) &&
+		    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
+			new_cursor_state = drm_atomic_get_new_plane_state(state, crtc->cursor);
+
+			is_rotated = new_cursor_state &&
+				((new_cursor_state->rotation & DRM_MODE_ROTATE_MASK) != DRM_MODE_ROTATE_0);
+			is_scaled = new_cursor_state && ((new_cursor_state->src_w >> 16 != new_cursor_state->crtc_w) ||
+				(new_cursor_state->src_h >> 16 != new_cursor_state->crtc_h));
+
+			if (is_rotated || is_scaled) {
+				drm_dbg_driver(
+					crtc->dev,
+					"[CRTC:%d:%s] cannot enable hardware cursor due to rotation/scaling\n",
+					crtc->base.id, crtc->name);
+				ret = -EINVAL;
+				goto fail;
+			}
+		}
+
 		/* If HW can only do native cursor, check restrictions again */
 		ret = dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
 					      &required_cursor_mode);
-
 		if (ret) {
 			drm_dbg_driver(crtc->dev,
 				       "[CRTC:%d:%s] Checking cursor mode failed\n",
-- 
2.34.1


