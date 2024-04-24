Return-Path: <stable+bounces-41341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119D98B04ED
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 10:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2ACB23E24
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E67157489;
	Wed, 24 Apr 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5rl0ymz3"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E591581EB
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948759; cv=fail; b=itx2uZIGrRFANEa4LI/8dLSbawwYynjdYlil5S559KL7Luvp3X5gerfxKTTFvVMX0N+cFJ7DD142jsbeCSv38kU0Kls5s6g6l4TyysFn1olyHod59aDUABq51+33pKoF4Cx1D1gh6vhTH6C+x2t073bBEvNxtrZRvARk02K4r0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948759; c=relaxed/simple;
	bh=7LJXkym0R4UTK7IHzEl4LhdiQlpZBHQChtikJlsM5wk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCRsMGPE0sYfOdKtJd2Xw5Ve8c/ln5z8lKlriJc74EYPD3kJrL7XBN5hQgHsET4h8FFY2QypyvM33FBrn66w6GGGJ/KlnaS/6/0Aw3ZymUQ0Axz+NGqT61UPTJ6FoKALGPwxj1cgLqA/RX466XDte0uX90nWlV6fANzD/atbctQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5rl0ymz3; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeRgBp1aRFA5d1V8B5G4GcFFQ9b044SlgQKYLxgwyU0E5XF1qgZdSPygzWIpAfei8HIIdcvx97vd/d/2ByrKOl7LXYrhYu/XXgqJOVahsWaJhDH67E9O9A0GNVvugtIiT2sC00OeFovO51fFDZvwlGBHkZfX9XwfHEJrqjyhlE/99wLbFcqiUa5Yl6McVl3OaH8NDrMXBrzgz9Mg+eSQeLuSHESUUCCi7llPt26CwsMrFvmS8/iLgKtsBImhW8cKIoTk9a5uYCgskhWGe5QWbhL4Uw383ZUZ9pT/jw/4ufB7r4BorN2s+H4B9jy4sT92Z2jopm9XpiygpsLMYzopBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t67RwO2pvFSrZ5S2xFdWWkqvNe7d4s8Sx7Ua5nIxS0=;
 b=SvRCnnFX89JEYf6/XTjJKvKURaGJa2xmgmMtbO6HhYZWrFTsmHEXkXxew/5FAYiY831xgFbOMyQgC9VwsdgfPnHaNRrANrs7EX5tgATvy2PNqs871iiUe9m17xdLXI/vc6TMgtrVQ2s+8I1RVJueHs9DOjR7OW2vNfNFzIPbJ5f6aNPAUNYb4fbMiWuswhp2ZpVrG3W/vZyGtOEZ0SiPYO4vRDGknmpMGW8kyGGXWXtHwrKgPNYsJaQxywIZfZGKkbWgsstZw6W7SV8WlGq0/iMGTEHsRDGTkQ2FwF2IEt/2/0u606JIdSd6bVburGFeBsb5mNo786KeW53QJ8LdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t67RwO2pvFSrZ5S2xFdWWkqvNe7d4s8Sx7Ua5nIxS0=;
 b=5rl0ymz32PExUjWoSnemoC9C07mm+qTvmQ+CZ/7E5fh5KuNTqzGBPnsHmbPbNsIJRWdk0yu5yfyHpr0go3QJ5fWiDuOjYPrfiM9cL+tneQye7VSyniJ8UcsUmjNRd61XYAJltsF0WKj3sAfdO5yR24WXCeZJu+rF9pHv8heP+0U=
Received: from BN8PR15CA0054.namprd15.prod.outlook.com (2603:10b6:408:80::31)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:52:33 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:80:cafe::36) by BN8PR15CA0054.outlook.office365.com
 (2603:10b6:408:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:31 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:27 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 23/46] drm/amd/display: Defer handling mst up request in resume
Date: Wed, 24 Apr 2024 16:49:08 +0800
Message-ID: <20240424084931.2656128-24-Wayne.Lin@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 971c6351-d91f-47ac-e5f5-08dc643be13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?meIpAF83ws+VyxyrzecY+fkQrZR4s401C0J4QhE+lf9kjNnSRC4HSSNFj6Ak?=
 =?us-ascii?Q?OziQ0Giz0ZVidyJ1X3YNcODhtmoaDkcYyuVZ7DDhLCPhOedE3DdRty41AQT7?=
 =?us-ascii?Q?kWjl6fxma5Dxfw5oDnZkbMJSH0RMHP5erUFHZiCXDBoQjJxPfsxcTV86UKDd?=
 =?us-ascii?Q?s09feMfvJXQjYJTney3kDAWqk4suOPoQOvjquMx9LhQeZSYHAPpmxjT4E5IT?=
 =?us-ascii?Q?MYLVPhX4/1pwdaXmvImscqF8Psjx7soOspfKFnFVJdXBZZnbY/wqrdeUEoFz?=
 =?us-ascii?Q?HUhYmw7+D5twGQiQg/eLF38+VLiQ2kMD3a0zal6HUKtlil1b5RGEnzFeH0l+?=
 =?us-ascii?Q?wHdl+5U6pw0MniADgMipDRu68IpeGjbmqDRaLeny0nwdNQHMv9jr6phP/Eqx?=
 =?us-ascii?Q?yj8iAHOYqXSSdP5dXB+Bslc8SxvdqZkAtd2+jK2sAOO26nYgWW9vJrswwuPr?=
 =?us-ascii?Q?fIvW9iA2H+GiE5Jx6tPKupeWV7MgmMmGmsLELyZXzUsbNaqH6atbRj3NFxho?=
 =?us-ascii?Q?uGHFXUnvKnKVWXJpFEsvUGxOXwvQ9VJU4rFTZb5bypuie2fVCUo1ZwAAuTuE?=
 =?us-ascii?Q?b4Vp11gAWZPTeNPxujxQhz/LYQj9aUddN0WdD9MFXrtxFGgd3dYFlrfbJe3y?=
 =?us-ascii?Q?nb1n/mDOo+etdRBegaEQwBz8dms7veL3W0Inr80Wrr9jyHAjjrcCfgKc/Y6N?=
 =?us-ascii?Q?yeDAzP5HQov1fAODB29rsnl8sCzDiTmqW+zEupPnYm25zX4w68abPNk9LAmo?=
 =?us-ascii?Q?cDjLZFWXxYlPHYkIkf7jasLfqk/PlLnXWAFo7rHkwzkMTbLy+FZOCX4egQTv?=
 =?us-ascii?Q?/P8MnVbQgwQz5ddtjzvFwDHMyD+uH58J76jqJdCT/gA38SMfm97dOaSWPPhy?=
 =?us-ascii?Q?hvsO0McyQsCiLw3WltYCSl350YGAmyPI397wjD+/3JnyyTIRulw6w7KKRnv4?=
 =?us-ascii?Q?HS+SQdL2QCPP22ogEuTY+E/2LCsRluGR5BS1fdjVO20E8KNPNcqVzWWnXxO+?=
 =?us-ascii?Q?SOMmAYZ/fGWaOF8jUN2UIWNoxVrOCOjQlGW/YCwuw0G8nZ8TySNNUjpN251G?=
 =?us-ascii?Q?KGwr/nnNltkYEf4YgRJENo1SJ92LO3B8t2/JBs2Y80rQl4cYiD1l/Cn3o69o?=
 =?us-ascii?Q?Hri/LjkDl8wpWcQyOeBsJlkRQA1JzL+2BkaQBPX1GzgPcsVxbhwrTLb664g3?=
 =?us-ascii?Q?oDVgXVTM+zEN4YnEqUAbeo1pKQAd10Pf+6IFm/22mXwFfNkXLFEJnjDv0pzS?=
 =?us-ascii?Q?TUqjNMkv1kh+XT9O6bWf1utuYUP24D/3mryoal1y1mmO+15p+eIUHf2epcF/?=
 =?us-ascii?Q?RU2QdurXma55jU2i7hcYMse+4mG6yIO/N7QqsTCPZspNNaGiceiroOkJoic7?=
 =?us-ascii?Q?nUIQwlY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:32.4102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971c6351-d91f-47ac-e5f5-08dc643be13b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667

From: Wayne Lin <wayne.lin@amd.com>

[Why]
Like commit ec5fa9fcdeca ("drm/amd/display: Adjust the MST resume flow"), we
want to avoid handling mst topology changes before restoring the old state.
If we enable DP_UP_REQ_EN before calling drm_atomic_helper_resume(), have
changce to handle CSN event first and fire hotplug event before restoring the
cached state.

[How]
Disable mst branch sending up request event before we restoring the cached state.
DP_UP_REQ_EN will be set later when we call drm_dp_mst_topology_mgr_resume().

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9d36dba914e9..961b5984afa0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2429,7 +2429,6 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
 
 	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
 				 DP_MST_EN |
-				 DP_UP_REQ_EN |
 				 DP_UPSTREAM_IS_SRC);
 	if (ret < 0) {
 		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");
-- 
2.37.3


