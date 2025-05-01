Return-Path: <stable+bounces-139313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E9AA601D
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE52A1695C8
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F51DDC07;
	Thu,  1 May 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VOR0FgjU"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8D1BF37
	for <stable@vger.kernel.org>; Thu,  1 May 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110163; cv=fail; b=EEuCOcK8TruTAWNuATUCM9s+MLGuPWblElJS8bZpjv1qJieBX5Y++NTSrUT1HhgT7mEg4I+bTdfMywpungW4Caijsx6GygN+0d8TwMIwiaRv1KCgE7SOlegYYM8QvAXqFXApxM5JbnH4+uajr3aELb49mtOCkzRhX8FemR4mmSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110163; c=relaxed/simple;
	bh=2tZ6D0P6HDn4Aodvem4mwIVS8jIoHZQWTqRS4zr045c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZZ2QKF8zO0vfy2Yme7dUzXdYrBh4o4xsz2BO+N+umkOdqWnnO7X/kwWQzbw/fIUY0vWYDTIOIrMV3OKWWZMMpR37m++TqyJkGo1Hj00yyaLCkkJq0E5cJFW4lFG0jMsD7Kg3N1OfQj7WDa800Jx3JG6t+iKvqEtgN+OxoWVZgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VOR0FgjU; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljtRqymWiEjkos+u0IeDbuwv6Xrx7Z6P6C3/CzJjdQ37yliECt6Qr+4oqoAeFAIY896Yc9Mp/sIBDc+gLWg8/mHD9Fm3JSq2SvCmmSnChiR6LM9Igjm2s9R4V/8tmb/A3ty2VhaQ9OQf5Z0hLDIflurT3ENiWUSWjx5mFiesirRGyrJJ+eO/lOdnXykr4vgjlvhk6pveyWTldVfg7K/Glo802avcpgesegGJOjYAzsyeXZ3oMUxzytVdM3QPyRJoegmoYxpA1DDrcLonFeKJ1s2TaOxN6IgAaxbO7big4l40LWiDQKg6KIoCjteo1vyRS9qqn4Z+bKByx2j7OXhlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbFD5xM5yWDlccDQ24Y7WXsNvKnx28xYePZJxx2S4Nk=;
 b=fhFYMra5iBhOV0QV2Jy93EzrxHtAktsQphByd7M/jQfM0Lzzb7PYnvNHCZDu+m0NyJ+OEgZwqC16ffHIyZ7ZuBaDitUCG0jz3vHUCEhMz1Mklw2ezqdU9RP9dQeWIYISatO/P87TlHE/qk+BnPvd71n3yl4b6Lv0h61BgzI3zuPMXg8UQG7/Yej/vBFewZfufzVVjbZTvHzJMmMHaCyEecrrLfFwqBrESyk2zKrY1gU0EkOTM0cqde8oR5TYtuLN9ohOcoJCUW5YAIcyMBu9ADHIS/l45REWg3B1V7xti1yr7A7Apu8Kqex67FR3wWoolUGUjObn9g3sGDQfwPlnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbFD5xM5yWDlccDQ24Y7WXsNvKnx28xYePZJxx2S4Nk=;
 b=VOR0FgjUwI7qNItFbK4EYWZ9PZ/ua62GSyJ7enHMgShRvmTRuBhoIqtmAwi3H5odmvYmYhpxm9b+vO58pp6h24CbQG52fnJaluoSqc9Av65xXxRzO05/GkRWBvAHE0V/1vTm/VVI4wTQ+oHZOQscxfv2W6PM8kb8nxKI00lKAlo=
Received: from MN0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::20)
 by DS4PR12MB9585.namprd12.prod.outlook.com (2603:10b6:8:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 14:35:55 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::c9) by MN0P220CA0010.outlook.office365.com
 (2603:10b6:208:52e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 14:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 14:35:55 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 09:35:54 -0500
From: <sunpeng.li@amd.com>
To: <stable@vger.kernel.org>
CC: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>, Mark Broadworth
	<mark.broadworth@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.14.y] drm/amd/display: Default IPS to RCG_IN_ACTIVE_IPS2_IN_OFF
Date: Thu, 1 May 2025 10:35:22 -0400
Message-ID: <20250501143522.41336-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042837-embellish-dragging-2996@gregkh>
References: <2025042837-embellish-dragging-2996@gregkh>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS4PR12MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e42390-e2b4-437d-911a-08dd88bd7b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9jOAhKLusc6smFl7PXWpTkvcsj8Q9IBl6ddHBp7A/x9JrBmr0+xRcm6IsU0X?=
 =?us-ascii?Q?hUlyIeX4lFj6fqHKqX8kpCdgiVwEyHMC5GjoT5glGy4PJ2ODv3TBRFZVhDd1?=
 =?us-ascii?Q?fv5V9721a+82J/+7Zd6v3LFrtE+wwOFYwyCYcRzg/tpuOEk4HYuwnqhssxX1?=
 =?us-ascii?Q?C4FU/2nYf+7yx/V947N1ONZrly2OqmN4WeobzIu3PdtF0N/uplOW3zp9eIXr?=
 =?us-ascii?Q?TVFZ/Lqed6qhGaID21KuBLXJYPmkSxrhfI+VGTGzizFX5EWK9G5Iz0P3DiNR?=
 =?us-ascii?Q?scCa8vm+BBUfEfnVYmMIX3XBbbDhkSGNbtB0SdZrTX7w5t4ttQZyN0HlU8lP?=
 =?us-ascii?Q?OrsOehI6bKTY4fgwqhClYZhYudV9PVaBTQha6abr6UNItkNTPab+uIBazKxA?=
 =?us-ascii?Q?kp501kcFDhDTbLcZNNWXtfxl2xrnsQOHo3PvaLbYxmzHZRFxq2+q/46cN85V?=
 =?us-ascii?Q?xNbVzv6lbxM6Zcle3a6uUvzL6oGq+qC0u5aOkIKJ5lmM+prW3zQA5IaaHtkj?=
 =?us-ascii?Q?zdJQ2NvNoukgeSTOCKgR+kfxWfaqa7X0pHk9CJyv5gUeUzYYp4mZmObzbkpR?=
 =?us-ascii?Q?yBoX44XRWswdv/DPHJ4Z8H+8CCD/FB2vvLCwEzx1DsYmBcr7QNZfdoXTEf+P?=
 =?us-ascii?Q?/PLjjhWAD6dYH8lnUunraYMBl1oFC5AuFTLO+MV9qsnmJ5QA4tzyq3AmR6ue?=
 =?us-ascii?Q?kZKPBTq9n8HYPSMGuu71sBhZ1IxsGiiIelQaAGy98hIPjpTxGcfxek1NYbrS?=
 =?us-ascii?Q?BexHOMYScA92FPKKD8LaHePvM0yDqHFVvpNe0k2YF6RQapyTC3nfsEpUIi0g?=
 =?us-ascii?Q?eCTHmiGfGPCAeTnI2Pet0l4YXhoLPEoufemg/mn9bMq6b84Hk5vYxBP8vkCh?=
 =?us-ascii?Q?oVxgtIGz4dox0HfoiThnybYYLw8O5NLlqrbojQaAcdaeju2RTc4LcJ7taKIY?=
 =?us-ascii?Q?qkgzUkqEJ/8FuCpE1KlaQ8eieBPsZ1jSSulTvu5JIXGS0++98MHA8bRkAegV?=
 =?us-ascii?Q?0d9dlls1IM/lyI1X+yn1w3SI/N3mtKI0r7SHShjkT9GgUCqSw9zyAXVJSfSx?=
 =?us-ascii?Q?U46TDXReOcP3WJ8sjpALRxJPKUmPFZAsLInPx5fAyfkn6QLI7LiEaNs1VCst?=
 =?us-ascii?Q?J5vZ+z2lYfUJqN4bZuKO4yGQMsppIpxcxMU2rKS98aI/TzP547VRUrZxbZl+?=
 =?us-ascii?Q?e3BdykHyn3AZNzBSdArzeNSAkDGqL978DVbU+QhiSBOsnixcx/lz2H3Gae2j?=
 =?us-ascii?Q?OXoCmsXZP3MP1BPZ1OgE3G4jIM8+mXCJN4mzVnZwizmVeuHc0C1iBkMKvpKY?=
 =?us-ascii?Q?piPPaiOGn206zq2Zozmb5HJgcYDVdSbfaTqDmiikezvtnXfOzuXrDbVjeNoQ?=
 =?us-ascii?Q?znhj454rojtydd1y7xKJJsfilQEG+J8Gn3TTxNmRaCV/eHdAjqQKaUEbCgOb?=
 =?us-ascii?Q?VUlTdvaJLhlW1u2b70+ONYTInZec4nIWv7kMA1bRR1kiT2M2GVRLwIjT5KZE?=
 =?us-ascii?Q?4+vw2nqE73z9YtK+n9P3tHrHbbwdeZZPy7VJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 14:35:55.4861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e42390-e2b4-437d-911a-08dd88bd7b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9585

From: Leo Li <sunpeng.li@amd.com>

[Why]

Recent findings show negligible power savings between IPS2 and RCG
during static desktop. In fact, DCN related clocks are higher
when IPS2 is enabled vs RCG.

RCG_IN_ACTIVE is also the default policy for another OS supported by
DC, and it has faster entry/exit.

[How]

Remove previous logic that checked for IPS2 support, and just default
to `DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF`.

Fixes: 199888aa25b3 ("drm/amd/display: Update IPS default mode for DCN35/DCN351")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8f772d79ef39b463ead00ef6f009bebada3a9d49)
Cc: stable@vger.kernel.org
(cherry picked from commit 6ed0dc3fd39558f48119daf8f99f835deb7d68da)
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 80a3cbd2cbe5d..f38a68beaa871 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1912,26 +1912,6 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(3, 5, 0):
-		/*
-		 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
-		 * cause a hard hang. A fix exists for newer PMFW.
-		 *
-		 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
-		 * IPS state in all cases, except for s0ix and all displays off (DPMS),
-		 * where IPS2 is allowed.
-		 *
-		 * When checking pmfw version, use the major and minor only.
-		 */
-		if ((adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
-			ret = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-		else if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(11, 5, 0))
-			/*
-			 * Other ASICs with DCN35 that have residency issues with
-			 * IPS2 in idle.
-			 * We want them to use IPS2 only in display off cases.
-			 */
-			ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-		break;
 	case IP_VERSION(3, 5, 1):
 		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		break;
-- 
2.49.0


