Return-Path: <stable+bounces-75872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8DB975860
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717CA1C22A5D
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1A61AE872;
	Wed, 11 Sep 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="apmPtI3l"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC541AC440
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071997; cv=fail; b=lPH3pQbc7YLWksDEc1Xx/Ye1yQQ1VQjID1HJH/Tnb3aFq/V6McOv/sRa2MO7/CYLp+EnViz+++leLgW7v0wVw8QfJGo7Be/sqQju0Z/Gx39/Oijbhd4H/j9lmusFKtgGPerpDVYetsblYtJxFGS/tu0bG6wsOQIthDa9MX+k1wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071997; c=relaxed/simple;
	bh=rFtUGE0wj4iemJnTi6et715cRO8K/Cc1JeRf+IFCPKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvLQ7suJktVxxPNuNAwt/0rOvk+ItvylZyiiowQtyu7Zb12nTwtKakY/Qf737V2FEydyhHmXBPnihKIwSCJGNaux3qUqKtV2XjwHAW+VOe4iv0c7UHS0hHukk5/MTg8E79czv7ODqGBpkXfm1G1JaG4YzMI47YOlvlYvx0l+hh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=apmPtI3l; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMFYcLRvmP8pXr8aA8WrFTTj/HHbufK+meGcqlGbqCD7CuApHmnCL+IcIspKsWoZFLi+B7I8u6dNkJ+XgHks+NrO37SAa4zJXJzWqNgGhm415nSFzEu2rFVTLW82HYvYcQgVER8xG71/XUmyw+0WzcpdMMVdHIc/iZMgHJ/Rr1hqOwymntvxgEemyoEts78bdYoVxCR5BUSK+FCSHCJPLy8UuVbnsR5NOYRfpVy4cS0/ZoYpEPetxvMPFpFGZf8McpbR8A/XKOMDwZQtqDrXkcYk14T05nPNDz4Z0nLpMYcHDjYzw1qBh98fsSqKBxcj88uVRz40J7kVpRuqZ6BFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG313AsoHNDpc4zaeLyotAb8653VnYGahUzquyAqMyU=;
 b=sbLoJfS1qJsHzXppfYnX3MZJCrEHwUSysBGMqFAej1AwNOc5zhDxLyClPcw6ZJeHIOvgbZC3OGTweFgPYrbsPCiSecEyN7piaYpTAOEXU7quG3mmTYkxmBDK7UeDmySk38uDQ2aESCZeM+kxV8Pmd3dIiNl27ZmZlPlmz8vvQ85VXyBJM7r85oRoMInRs3tsx9BdCoc1/4ywOWMcw/AQUMxmeNidUKrw8mGAha7XE0sRUTY8Yc7LtIORFaoCa6/GuHnRKl1HkMtrl0DtMCOieHmTcCPi/OOppLahZwVvqnnTfnKZSseIqTz4ueGobPLWicOsjUCRzA3vWkBsfD1u1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG313AsoHNDpc4zaeLyotAb8653VnYGahUzquyAqMyU=;
 b=apmPtI3lHYXGDRNoYwrh8/tIFp4nEBq1afh5XMW2rBJciSMvP6zewK/iyiLxYYga1kxL0yNJnjQ8rxu846JH82LrWO+s8roB5fe7EupupIB7mHr0BDRu9K/WrUIPgcOQ0b7lRCU9jqHmU9c5EUIEYssnyqbcCXeqX5yVeiC2F3s=
Received: from CH2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:610:60::30)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 16:26:30 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::90) by CH2PR14CA0020.outlook.office365.com
 (2603:10b6:610:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 16:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:26:30 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:26:27 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Roman Li <Roman.Li@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 21/23] drm/amd/display: Update IPS default mode for DCN35/DCN351
Date: Wed, 11 Sep 2024 10:21:03 -0600
Message-ID: <20240911162105.3567133-22-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 19abaec2-8dff-4fc8-6d95-08dcd27e7e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXJk7sQkBUV9j9XyPN/kvD3bcGEyzJwOIjGoYnihjnRefbACrBy3ZfBTL5tg?=
 =?us-ascii?Q?qFEX8+zilCUefELLod0v0NaCobCDsZiQB2GdcA/sKu/GTKk5X9sOaJG4CSbe?=
 =?us-ascii?Q?nB0NkcrjMqi9QJKjLzsZG4iVjhcrVaYPPxY13pcH5qo97fRVPWCyOciBx+It?=
 =?us-ascii?Q?vOCWqb4eGzvl72dEa6Y6RD1KZze1neudO1hH+APLyPimOrnSbRlWgfv81Mkb?=
 =?us-ascii?Q?J13cATxQ9C3+yxCdTBkXqs0lhAATOQ9tZbhJAY/8jBwSh3AMm+iO+dSL/OnA?=
 =?us-ascii?Q?dIil5wMjuHSVBrWX4sFE1/4ucYlxeK7gVcgI/rbIl4DtpKRScZTjx1nGIoB8?=
 =?us-ascii?Q?dO004X2bRJ7lCzzHgeE87cNYwpWBZ6vgtM4vl5vkr51fDPUwe7/ujHinS31F?=
 =?us-ascii?Q?Bk8k+yyvLO6yNN1E40QNfwPnWRFhUXStf2AyOvBTWewdpAjEDIQtfiZ/7gBK?=
 =?us-ascii?Q?vNTVOhDgRSIZR/TY0/sCKp77UIuj/ZjJ6U9zIua6SIQRkvRBbElEmHsEe1kC?=
 =?us-ascii?Q?QK975xrZnyau9DL6x6vo1tH9kfLep2Vkaku3XI4lHYoehYbSZyA12Dx+wixP?=
 =?us-ascii?Q?RO/GaLuSHhDzZZMgA7EWd+zjd+eO7GW0y2KsoiA0JoFZr2aC1aI9Jyptoeg4?=
 =?us-ascii?Q?S/NXyIzs4C8TRu4H1uengZvzF6b4vm3hPERLdPGIuzMQBMM8Jx8DEV+urP3Q?=
 =?us-ascii?Q?Ndumr8cB0TiO4JsHlW3hshK0IJbAdKCW4+A87B/b081KHepVlbvARDwXlwz8?=
 =?us-ascii?Q?uJAlNfuGtKC5n4tYxS0gNO0820SdLG7aEA5B8s63k4HgIPPNiM+cWhEeG1pg?=
 =?us-ascii?Q?KUawLLqd92wuwTIGkjc6BbDdwEg/Cu+/FWvcSD9p/HZNMxGosRxlZ1DcEl/x?=
 =?us-ascii?Q?6Qq8IoRbuiSQrid4ku34wSZLegmM/ed/HndEeSyCQRxukfdCLUa0NB/zAULI?=
 =?us-ascii?Q?/X30G7hx2to1PfRmLgcJ/BVNu6Em8PYcKCVhO4VbCOmcpkrl2XCOWEUMnp2C?=
 =?us-ascii?Q?JgdIrUPwJ/tEf0g/5LBUg2Picq7DUpAtLVjNxNQfPCzJQAgICvOpPtnvoSSY?=
 =?us-ascii?Q?+FljzCcK7xpfn/Dn943CzVCCJBZaDm9a7IvcNS5/8fFCOu5vK6KVnNeCdUyf?=
 =?us-ascii?Q?5HJ71QeC0Vxa9EQZnr5q+81ETBbO+WFuApUy8iVzIjlqjLKG7MxrYTGNZPvj?=
 =?us-ascii?Q?6ylV/l0f8nrQ85QbZNCKvGG5s3igYcuwooYlqUfw98ok1ztjMPmvQNePzglW?=
 =?us-ascii?Q?zarkcex9w0aUmDddRJE2NTO3yvS7ECTaFhr338IGrhh8jfGP8I900RYzTAP1?=
 =?us-ascii?Q?vok/bnlqh3sKJ+jJkyDF1hnDzq5rw4ZQudVZbPmJcI5VCJPrTcku2Ai3/f4M?=
 =?us-ascii?Q?j/CKh7NsgIwblG7gDLtYzmJKRSQ5Y8toxzZCv1DA6Eu+MCbZocvdS7AnnUhi?=
 =?us-ascii?Q?89wpktaTIGCqk6h4UIc5gq3KnoTh/A6t?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:26:30.5833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19abaec2-8dff-4fc8-6d95-08dcd27e7e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645

From: Roman Li <Roman.Li@amd.com>

[WHY]
RCG state of IPX in idle is more stable for DCN351 and some variants of
DCN35 than IPS2.

[HOW]
Rework dm_get_default_ips_mode() to specify default per ASIC and update
DCN35/DCN351 defaults accordingly.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 50 ++++++++++++-------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c77982245f60..c50880422502 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1771,25 +1771,41 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *
 static enum dmub_ips_disable_type dm_get_default_ips_mode(
 	struct amdgpu_device *adev)
 {
-	/*
-	 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
-	 * cause a hard hang. A fix exists for newer PMFW.
-	 *
-	 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
-	 * IPS state in all cases, except for s0ix and all displays off (DPMS),
-	 * where IPS2 is allowed.
-	 *
-	 * When checking pmfw version, use the major and minor only.
-	 */
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(3, 5, 0) &&
-	    (adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
-		return DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+	enum dmub_ips_disable_type ret = DMUB_IPS_ENABLE;
 
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
-		return DMUB_IPS_ENABLE;
+	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+	case IP_VERSION(3, 5, 0):
+		/*
+		 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
+		 * cause a hard hang. A fix exists for newer PMFW.
+		 *
+		 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
+		 * IPS state in all cases, except for s0ix and all displays off (DPMS),
+		 * where IPS2 is allowed.
+		 *
+		 * When checking pmfw version, use the major and minor only.
+		 */
+		if ((adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
+			ret = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+		else if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(11, 5, 0))
+			/*
+			 * Other ASICs with DCN35 that have residency issues with
+			 * IPS2 in idle.
+			 * We want them to use IPS2 only in display off cases.
+			 */
+			ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+		break;
+	case IP_VERSION(3, 5, 1):
+		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+		break;
+	default:
+		/* ASICs older than DCN35 do not have IPSs */
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 5, 0))
+			ret = DMUB_IPS_DISABLE_ALL;
+		break;
+	}
 
-	/* ASICs older than DCN35 do not have IPSs */
-	return DMUB_IPS_DISABLE_ALL;
+	return ret;
 }
 
 static int amdgpu_dm_init(struct amdgpu_device *adev)
-- 
2.34.1


