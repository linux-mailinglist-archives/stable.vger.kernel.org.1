Return-Path: <stable+bounces-139314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10977AA6041
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699344A58FF
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F32A202F67;
	Thu,  1 May 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJUEf/iv"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2F1F874F
	for <stable@vger.kernel.org>; Thu,  1 May 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111154; cv=fail; b=JEUC6QkdjBxgpO1/VTghV5gr/6tdm1Lyt2O7ny17OxZ3aXTfgE26dAOShVeIjw6OwgakPPhYengu+ZqxTEXG9KqA52Q6EsBa3xz38gWVryEiNKnJu7S8RfVTQes6qHA0xqTIEIKzZReFlB3fj3ruVhKWQVeHTEWg+46KaV42paU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111154; c=relaxed/simple;
	bh=Ic8PF58smRZAMnYRqpmKK2HuX6hC3eF1a11h8hj8nFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnWx22IPSYwVrNybBNDVbiwoNUc2TrbXRNN2pSV2tgJj1AhqatS9qGSR3H8uivCnWP2Cqsw2aDugUY56RILFBNpA6PMClnF0ezTw3o6fuzeUnl0fyiOHxLeVRBMHJftysR2Cl7zCtejbNMxFKvgNXk/vUgLoI3WxmCrtSJ5BLC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJUEf/iv; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ0okPk4zLqqVvPWXP2nZzHVbaqcY1bPjqx+/KQ3lXlpi7bm0gUEmW088I1nLz2X5n73+W3FXPoNy23/wr9TUtfirCrXyZnWE1HJOD7/+HGjyPgiPbAwVUllGenZkMhHFRMcHGUBioSlm0msZDM+P82eR7fWPqwYs1nkfTQseARJCGnu3mX2fdBTGDF3vEbd2sIg5KaNqCCvjMJ70dkoOFYbPvGle3ugJ7KDwnTFJDaq4oJCtTCai+Ttv6gY35dWsGykEhcJg9mtWgy1ujze0a86JqO8r2n2vXXWawhXSz0gTvD2e62uRpdfqefDR8j6Rewqh2+lcaqNLRML6XmlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl78xA/M4t6HwFg41lQrXQDLYNtZT02R+Kh8q80rvEY=;
 b=VkUdV/h+rlEuiw6a4jeZyRvA9sJDfbmFgF+M35Td/a5Q/vzDGP6P/MMLnwpUAH4830sclW7RrlaC6YHXktbGNVWYfWd7R2vLq01VzynBfVNuNhzpY2j3bEnDCI/eyKqiWOmL+CiCeb8OlWZPNA2sk+fW601gQWJAxfTkIavTTusDe1lFRld2DBg3tSe4IvNzgk6ERil8wrCfC0Gnjxoxk/Jc/K9UM4VUed6OLo5xjtag6kUll6JGfqM6KsfJt35fMXssE6Wne44HHOzmzs0fYyKuRdYpiczTQ7Be8Parr/vBWcnCjkQdUCDGZDIRzhQ1SAHvbMxWvva+dTNoWC/5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl78xA/M4t6HwFg41lQrXQDLYNtZT02R+Kh8q80rvEY=;
 b=GJUEf/ivs7OgfR90sxYRoRcKHPtBsMFW7ynvDSEqHiWJk2hVpePzuhk4BaXwBm7WDkhOT6d6+uDGEgP54RLZiMhld8oQIzPvIDVvCsu7rQMPeI2A8YAZ7QAuhlb4jwloGk0DLNJiLfH1347ha7EpBd2kuvp+9q8NCo8awCou3IY=
Received: from CH0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:610:75::19)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 1 May
 2025 14:52:27 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::19) by CH0PR04CA0104.outlook.office365.com
 (2603:10b6:610:75::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 14:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 14:52:26 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 09:52:23 -0500
From: <sunpeng.li@amd.com>
To: <stable@vger.kernel.org>
CC: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>, Mark Broadworth
	<mark.broadworth@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12.y] drm/amd/display: Default IPS to RCG_IN_ACTIVE_IPS2_IN_OFF
Date: Thu, 1 May 2025 10:52:08 -0400
Message-ID: <20250501145208.89339-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042838-flinch-defeat-6a51@gregkh>
References: <2025042838-flinch-defeat-6a51@gregkh>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c237a8-1ae7-4936-23b2-08dd88bfca31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eVfNJ+PUwP9JOlbEVvmLQQWf3h6tH4DAlOvFicTJ35vj2NSgyE4NVHa0/8ZD?=
 =?us-ascii?Q?2D8GxFAGlRR3QxSHSYLNczpzE2vD7ZJ9gcxMYQxXI6De+Flf8LQHxDyFM9U5?=
 =?us-ascii?Q?4EYSNQC370DHQ4308GRAfs5KNSKA9QsV5gT4n7am9gYnN0aIw7K9QAV1HU4f?=
 =?us-ascii?Q?KieMw5D5Mql3WKZ+ADOrpM0TytxoExdOcmHHeagC7UZjnMQlv8iJ2IboFFiX?=
 =?us-ascii?Q?y2n8UpcmY3PjfWM7iOWQzMf2ogQfRaFgM3iEaFAuGzWUicMgscxY8cSdwmuK?=
 =?us-ascii?Q?e/M7lpiUDSlxPB+YTXi+pLD807QtHwUsFLV8wTqXFJMb7wbwFajrJSrGoQty?=
 =?us-ascii?Q?OxWNJV9nQbym52hV3zvvdvPK+FIsOB2Hjm+QOIIMqr7m7Y60zvmJyqb8ITZC?=
 =?us-ascii?Q?ti1FrGE8v2IByyC1TJWXwx77BOWPjadGcIHpPdf9b1aueStmzSiBL8GASopS?=
 =?us-ascii?Q?1mANkKUJnF2FpLEybYnsHEbXsK54bRojz/0pNREd3HoIj10PPYZJW3K7KVet?=
 =?us-ascii?Q?3UclcS68RLl+6UHE47MAsBc2rikzoo8wWbp+oDS3GD1zzEQ6zqfcZU3OgVg+?=
 =?us-ascii?Q?ZF+7dMn9Z/9ExfAeJAuKEYBm7wtRfUohuxrYNLy8VdGfOoQeH66Kmn60+gzi?=
 =?us-ascii?Q?2MAgIKo+UqoycPPiFJhj/X9po711uEFE2sg7P1sH75k684xjwafSuE8ovpXF?=
 =?us-ascii?Q?QDPsqd6oy5keTJuusGEafQJWtKV1/X3NtoTBKpGW+XW1LDU0JQqtpXSWeJFY?=
 =?us-ascii?Q?KYwdmTXE1+S7y5kyqWvi68qT3pzr8kOWXqiLRrVdRD5qd+gL7iEi3m/Um/L/?=
 =?us-ascii?Q?p1eo5pSEveQtupz+1MwQ3YKtJ696d5W0YGFyZQl49D84+fvEKJb9vp6iSVpA?=
 =?us-ascii?Q?Sk5AA0KvedhKi75Fiu09dJnNh72nhUfRjFrxazvqpsM52M36hNiS8OH6xAEV?=
 =?us-ascii?Q?GzJ7aVKCBJw3kRE9JNwn4wtkpwf4Onh8SBv5tAeFu3dE9NH3ZJQKuYEmhXjF?=
 =?us-ascii?Q?ahhfGVdRrnNm1ULqSRaJkQVGTO6FeEmLLTLXdFnT0gSCy3QPJMqtxT8NYofv?=
 =?us-ascii?Q?hPQtWQJSizYgJbYch1t9DTcOskXoau9MRNP9JttJNpodkJndelITti1K5Zj5?=
 =?us-ascii?Q?g7li669xAQQxzxeQmyj8W6/OMRagaVa6tDWITByMngCxKis1v14n/KuEkgDX?=
 =?us-ascii?Q?O/8QxF7DLJ1N5DWNLodBBzfb7inSajt48gzEOuoeG+1jxLPoE/L6mbng5dqG?=
 =?us-ascii?Q?xXOqnk3eyHUFlic2pGRpMixvJzv341qcDsZ4Gv6Hal8ZOF9EiFIzHR7XeaKa?=
 =?us-ascii?Q?t0xp6AW6cmlgUu4VQqSTjZwZ2I8mKjsGCfoNVxtcs452zNT6gLGq+0hCKQuM?=
 =?us-ascii?Q?OQiAiaABhyHisGmYkFtiVqOp+8Pc794TjlzVtI3J+80oxFxr49g6TJai0hj6?=
 =?us-ascii?Q?1TSKMsZn0PkUgBMu90Ry4ASs69CkQUt2lC67DyN3c6Oax3ieSuRfesExqQwq?=
 =?us-ascii?Q?L7racsYk+Ma1HxM+Xip2JTgsFiiaz881BQAQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 14:52:26.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c237a8-1ae7-4936-23b2-08dd88bfca31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860

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
index c22da13859bd5..9d00ae14ff8fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1887,26 +1887,6 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 
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


