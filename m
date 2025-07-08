Return-Path: <stable+bounces-160449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC26AFC35D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 08:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12DB3A292F
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 06:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D22236F0;
	Tue,  8 Jul 2025 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U1IMgBAU"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436322154D
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957670; cv=fail; b=Q/r/DrWqDb17QBRHMQA1ieGULLAR8rJ7a41Yyy3P9Sn4Wve6bEH7eLBxK45Cby2d3I7LpV/XxrK6K042Ko+YWdItSr1hv7c4uxkZOQsxKYmkm0jHNz9uFA85wAg+gCt54p9oF6T0S3pDFSji1Bm77LN/MZv70JR/pFPRze190y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957670; c=relaxed/simple;
	bh=trSkoLkzh0H2C5JniXhj0n7SWc9EjbI+AwG56kLxi7w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aCK1d7Hx/GIcvpyqu0H1wctxd7UAbT3wG2flGsZwdsOtCi4XT0btI9yPXST/zjs026pAKxTv3YQiDoBj6wBaZlJ3ZzMPNlJecI9XQDntZEMIllh39dGg3GqYDVGJAMrKKe7WPsZdDEMWGgbxbLyhLPsJ1DN8utmLW9+hiD1iRsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U1IMgBAU; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoLbqULUi/ITX/QmshLhLuBKUs3qF5ntCNmt5zzh8fvRJpWGlJWJqvJGYYrTaSTkVatV2WMv2u8Ov999KwGimTfYmVOhUGaxLsTOfHH3HItPzHFw3B36IhuuS8EtiU95dkJNWesf/NZmz8yojDgsxRnIdU/Je2On2hwb68Frwq/aguEfQ7Xt5+gqQMWS9pnP+5rhA863ecN1122OiKmlQ/+jmSwDd+GICqlmuXqdqDLKdkCvo5wBv0Sl40mV6shDjIxosMVIrOK18UnRnZVYx0EVoyVhYdZSarXWEVYVQ/3fXobfY4CI+Rcg44W7lyGirLsH7HPODeAU5aKXCi/SWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLFDxHBBMqyXEhmGp42qFOHkQRTL0f0n5DiR35BB8+g=;
 b=XZTuGYs2vVdYH+dx2AYhIObIXw/NhdgsHT6qJlMpsC/SYXLoHocgxRGhMafCE4hVXarHwENuoAOwWa7b4fki3muuxt13IUY1BeZZjsE+xLrgVEtCKVM+HxFjWNtCUFPrUa0wThSX/yuRGVzoBn/eUfrzzWlUbQUELcV8aSEjFJGSybCqk44nCjJtp+zn49J8vXMo9Cd9ELLDeScgmh90J0kUmZgDSZWo4LYOAYwN+/nODWtPcl9eUpiKWhl4rP8SHOhHVx397rRXIQR+iQ2a+ldzJEvzTLt04tKup/BziQeGm40K3KnDn9jdfp7hBuB7xFvWMYntJaPpydKgyhNZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLFDxHBBMqyXEhmGp42qFOHkQRTL0f0n5DiR35BB8+g=;
 b=U1IMgBAUIzXVdfAj1/8SAuIRoNU5U12ejLs8A+6TqZKvzjR1o2lOD+oKlxn4YTDq6q+7at/o2kAv4WiN1IoCvKuO/2Nht3ckSfQYAFf6w+BuZxbUspvoszthi5arAebwdudIqU8jg5Ust1B0j/L4EFLs0CgIOFW9Qd4N5aHa2YI=
Received: from CH5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:1f4::25)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.23; Tue, 8 Jul 2025 06:54:24 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::50) by CH5PR04CA0008.outlook.office365.com
 (2603:10b6:610:1f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 06:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 06:54:24 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Jul 2025 01:54:21 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
	<christian.koenig@amd.com>, <matthew.auld@intel.com>,
	<matthew.brost@intel.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
	<Arunpravin.PaneerSelvam@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/3] drm/amdgpu: Add WARN_ON to the resource clear function
Date: Tue, 8 Jul 2025 12:24:02 +0530
Message-ID: <20250708065404.4185-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: d520c6de-fc04-4e0e-5046-08ddbdec4638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THZUZHdEV0dqUEYwYnBUcEpPdTlZSkFBV0Jkek5BUmF0cnUveVdkU3dWcGh2?=
 =?utf-8?B?V3QxTFcyS04waVR1MGdnanB4SUZXbUVOU3F6Sjg1cXl1d0ZqY2lZakhDUUlR?=
 =?utf-8?B?MkJKb1BWWjhUY05haTUvclFWVGVsRVdUTFl2YVk2ckxKREVIUG9JU3R0QnJT?=
 =?utf-8?B?MGVueDR2QzlQODRMdW9yQVptRGE0QW42bzJUWkgyZnBhQnpDYktNNW41RC93?=
 =?utf-8?B?blVYcENuWFBFcHlWN2dKK09JVzZTdHJ4UkNZdkZXNDVha3I5ZVVrSHNZam5Z?=
 =?utf-8?B?OHB5bmp3dXRkOXVzNVlNNlZlL1RTcC9TbHltUjZHVFdraFQwOUhXT016czBX?=
 =?utf-8?B?WWhlWURyaHBPQVNQNkp5MklFQjBlbUV3eGxSb1FPN2FBVVl5MC9meTJTa3pk?=
 =?utf-8?B?UWk1enlHaXZ2bzhYMW1rcExEaVFHbGYza1dEZjViMU5pa1ZMeEpqMDVOQ2l2?=
 =?utf-8?B?TWpMOWR2REJ3WS94TXNOM0ZkanVxR1AweHVWNHYvbzh0YU5Pc3RtU3RDYitD?=
 =?utf-8?B?SjJJWitsbjYvZGRQaDcvSWhCTXppT29LSHB3Y1pRS0ZOaXp2ZWtWMWtDVVk5?=
 =?utf-8?B?aUU5VzVaTFU0SFlNRThCYWtMb29wNis4bWs3YXRSUXVtaGgvWVo4Q0JlaFVw?=
 =?utf-8?B?aWdFRktNdkpGRVJmd2lRNDNpbGpOdFpTMTYyT2w5OVZnZjRpRWV5azVvdjRm?=
 =?utf-8?B?dUF1d25GWnZDcU9Fb3JlbFhVMnFxaUMweHBCaXJzNUNIbXhkaTVvd0xWOUJ1?=
 =?utf-8?B?ZVdZVW9nODk5QzdTS2doMnJTWWhCV2IzNWZnRnlHWmJ5NVhNaUs5YjlTTjA4?=
 =?utf-8?B?OVZEa0R2ZVlFM2FMZThqQ3lvMzYvMUZ0Z1BWeng2dGY1TnhwbEhwQzREWWho?=
 =?utf-8?B?K212cFRtZ2haTjVJQUsyM3plVmxMcVdyanlDazJGUFJ4WmErOUxHblowbmlC?=
 =?utf-8?B?Ym1lNE11MjVCVmVYUTVhcU1DYWFvNzRKOGtlVmt4VERXRk1kNlQwcysyZ0pH?=
 =?utf-8?B?NFBZTW1hSk9iUGdwMHFOT29OK0pYVTVJMzZSWm9HQUM0S2NQK3RzYVVzVVg0?=
 =?utf-8?B?ODZlWUE4dUd0NXlkRGgybHJOenkxUXdCR2dLNHd5eFlydDBlUTUwdlZXZ2N0?=
 =?utf-8?B?anZaRHVvdHRJQ1FRVFpiamdVUEE2M29yYTlvYjM0eWhtSkNTcW1LR2dIeERv?=
 =?utf-8?B?WjNySFMvZGErYlFYcnhDQ21RajBLZjRFVHQvQTN4YmVxdkROelRnMitUOXAr?=
 =?utf-8?B?blFvS1lKSEpCNG44UVhrK1hRQWlNZzkrZFQyaWcrakl1NWZCMkNYV0hqc2Ro?=
 =?utf-8?B?ZG9LUmtwSks2bHR3ejQ4Sm5GcXJGTUcwVFVsL29CQUZlNDhpRDJNVmMwbXcw?=
 =?utf-8?B?R0dvdFRsUEFQZXdaL3dzOG5XV3lxekN6aXc4SEhMNm9WYUJFN1A5OUxUMTNI?=
 =?utf-8?B?UlZDZHorbWt4MnN3RFA0RnhkSHBNK0hQY29NS2IvWjF5RDVUbWpueEVTZEVT?=
 =?utf-8?B?YThjSjZDZVd4RnR3WTZIYVE5RUdNLzRqcUpud2w5QkV6ZmVEWHRuRENvalVY?=
 =?utf-8?B?alNQRlY4Wk9UODQxM3JNMWIzOG9oWDhpYWJUWmVGMEtlcXkrdWU4d1BsU2M3?=
 =?utf-8?B?TTdvNEpNUWtYQXFacWhiMC9PUWhabkFucGFDK1JsRXUydzRRSkdXdElaV2pE?=
 =?utf-8?B?ZXF1SHY0cXdDMTJWR2hDNzgvTkM4eEFVN3hiUWRBeE13NElHWGtad05sVE5N?=
 =?utf-8?B?dnM3U2R6RU1CbFA0MTdXVVRmL2FCZTVFN25TekU5dGRrOTlVSXVXT014cno5?=
 =?utf-8?B?VGlVd2ozUW8yNWJEUC9UeXlweUg0eHRBc1N4d01SOTVVZDl5SnM4Y05qT3JU?=
 =?utf-8?B?Y3lnRnZZWTh5N3d6WldCdUN3WDl6MDZHYnhyNU1VWGtWTktKcUgzb3dUd3Z2?=
 =?utf-8?B?elBnSTFrZEQzRXpxUW53YUtBTDlLbEJYUEhMSC9pa2ovQ0I1dzc4TWhBUW5q?=
 =?utf-8?B?UGg1VTBaNFBYd3FSM3l0enJzbThPcDZuaGVrcXBjR0FsN295RDQwcEptZjFD?=
 =?utf-8?Q?24tIMx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 06:54:24.3698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d520c6de-fc04-4e0e-5046-08ddbdec4638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

Set the dirty bit when the memory resource is not cleared
during BO release.

v2(Christian):
  - Drop the cleared flag set to false.
  - Improve the amdgpu_vram_mgr_set_clear_state() function.

v3:
  - Add back the resource clear flag set function call after
    being wiped during eviction (Christian).
  - Modified the patch subject name.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index b256cbc2bc27..2c88d5fd87da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -66,7 +66,10 @@ to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
 
 static inline void amdgpu_vram_mgr_set_cleared(struct ttm_resource *res)
 {
-	to_amdgpu_vram_mgr_resource(res)->flags |= DRM_BUDDY_CLEARED;
+	struct amdgpu_vram_mgr_resource *ares = to_amdgpu_vram_mgr_resource(res);
+
+	WARN_ON(ares->flags & DRM_BUDDY_CLEARED);
+	ares->flags |= DRM_BUDDY_CLEARED;
 }
 
 #endif
-- 
2.43.0


