Return-Path: <stable+bounces-159167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A47AF0366
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 21:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EB61C076BA
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C826A0E0;
	Tue,  1 Jul 2025 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CT7Dxb6r"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D6433A5
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396994; cv=fail; b=A/Kd3jqXooKif3x81W3F/8oCSLUAMdFPzbySbiRy4s1vlAAKP9H/8A0E10H1XTww8AsAqvCB9RHMexqrnuxqhiJjLQCi0Q/qNqJUNVtG9Gq7dELx08Ek+uCCWh1VUChd7r6k118AMlQWQnkZe9mNOToNlD1uL/sJtkI5hOpcYY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396994; c=relaxed/simple;
	bh=gx2ULPNq+dHsg2oKtuVGlQR8vMExMbElI1EeCsqmGbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCMe6QIn2kRqzlvvfvVuH3fcsVj5SRQFkCp7bVjUhRTmnUr/HxIgYBMyan0C1vKjGE+2AxkY0ULwxevSwqgL4828EWZGHf7Lkhsl8FBtnTzSzoq551HQuw207XWXWbv1zDilZVRuIohSqsSGYlicD4v5RZagoRlkXPf0yXGXWZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CT7Dxb6r; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ydid3hFSN4BTq6md6pkEdUg+MgFinv5PPmqgkpVGwDcVWBWUioRedawKhtBZhlA+dhCuSGZ1WRgXgWd8aoFJneHqDveKUDfxOUw7+Yo612psWKRvVZeUA41Jb53hpwyW+/0ZkSXX+Csb6d73ZJVZge/I+V8Zf40DKb6tJxDiUwx1nhb5O3Iv9olvYonuu4TlFB56/+2VLQ+kPU36GBE+bPyIKLgpepcjXjMLyII/3J4M5vI1w8w7v3fhs0b94NZVJHTVQ4wNokGlhP+nXMkxnXnzSclleQ3VdX00eE/ZfwkzyL3/odEZP+fmHWy9/ehd3BNCJXLM2YDVxi4gu2lxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV5XSf9nwcN9+Nsoey0Y2anC5oKojJd9nD97wkwueEo=;
 b=FvgLAiHB7zNo7+hJFouMXAqrZdkgpjcICAVQRSQHUgkSG6h0PykODcDkhKX4jYoGgmhbcKB4cPq0vcQQ8QpQK60WOrTUDKIxmok5mBKQZE4VOdY6kmAf183Qn28HsHnh7cIFlqElp3sGMmdyq/j7SoUZ5yg9bJIvBB/wW8G20UsXoVv6eo2p3OQ1Gbc9/MG/uodo27HHd5w8s3OvF3yRsouvgwDcYy6050wvBXyAhhSMGUZWyP+M9ufAC8BG9IEl4d+ua8KBZOssAteHBx4jrxA2+uNSP+fDBSoEFRB1IvwXMR/XPj921nxzMGItaZOKLktbu1h0zdK/abfio/lUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV5XSf9nwcN9+Nsoey0Y2anC5oKojJd9nD97wkwueEo=;
 b=CT7Dxb6rMFperX18TpMAHV41FNnFjEN9b0dVCQ1U484pJnuVvtHj9okj7fN8rOL7YCpJlL10U2zE3TxeMzHmz4cWvofLGsLbfLzBhpga31R+h7FeE1KKirkQyr1c5gLDD7FQ5odBJVqM5MW4Mjc5AvSfeBhjMgTtBvHwGERgJGA=
Received: from BN8PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:70::48)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 19:09:50 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::a6) by BN8PR04CA0035.outlook.office365.com
 (2603:10b6:408:70::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 19:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 1 Jul 2025 19:09:49 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Jul 2025 14:09:46 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
	<christian.koenig@amd.com>, <matthew.auld@intel.com>,
	<matthew.brost@intel.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
	<Arunpravin.PaneerSelvam@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/3] drm/amdgpu: Dirty cleared blocks on free
Date: Wed, 2 Jul 2025 00:38:20 +0530
Message-ID: <20250701190822.5272-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 9706f302-683e-4c76-1c61-08ddb8d2d9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHo4bGRnY1VtcDY0ZFNUVHRYK0NHSXc2Zk1qRlJabWp2TDc1Q2NKTXRtSUs5?=
 =?utf-8?B?UTdJWEVDTzcvUVdvWWRMM3lGSG9rdUZGNE44ODF1QVUreWd0UWozTTlqMnNu?=
 =?utf-8?B?YlRrTElvRU1vV29DK3pEZ0lMV0o4TFMvRVd3aUgvYlFQeDJQTGZ5Q0FwYy9B?=
 =?utf-8?B?dFA5MzBtQ3RHWkVSaFVNaUZJQVJqWFRGaVJDNFBkZFR1d0F3aXJGV0J4YTl0?=
 =?utf-8?B?Zm9FK2hIRmwxdWt4a1VsMWloRXpMYnZZMmFiRWJWS3pEOGlhTml1eUlZdHM1?=
 =?utf-8?B?RHUxc2ZtMzVyL3ZscU1uS09MYnFmYjVCNm5EdS9PbGREbmVoOFdzZlJZMXQy?=
 =?utf-8?B?WW0zcVcxYUFDdEVVRXBpRGlwTjcycDlodFF3ZXZqSWd1RzlleFpaZG9pS2dV?=
 =?utf-8?B?bVRzc21KbVJYbm1QN0M4UVhXUEhOZitiZ3VoM2FtYVJ2b2lZL25JWGFNbGNC?=
 =?utf-8?B?QmNtY09FL3NiNVd0VW9nY0FIQUJUeDVMQlRKNVo5Sm1IRlJ5enZQTXA2N1g5?=
 =?utf-8?B?TklkVFViRjhFQnM4bWNtQkpHUlNzWDdibXlGYTJ1YjY1VUFYaTg2bFloL0J1?=
 =?utf-8?B?Uy9MZkJBUWJvdzFNblpFVUxnckNsc0lVVGFWR0tWeVcycUNLK2w1YlExSGxk?=
 =?utf-8?B?QXhpTzRoaEtrK2dDMkxiUWFPSWZWM3BVVEtCR2pOc0drWHZyVVI0SGhXVzd5?=
 =?utf-8?B?UkxTMXFIVFRkNmxTZ2ZWVXJNNWhVdlBiN21LSHZ1ZHlOT0xDbGdJTHdVcVd0?=
 =?utf-8?B?bVBJMkdsUk0wWmlUS0c4Qjd5TERqNlF5UnZhSnhlSjF0NTdNbXBBZTJ2L05Q?=
 =?utf-8?B?a3Z3NDQybE5ld0FIOFp4aUdzSDNaUVNBbHRIT0l0ZUZ0TitJUWU1UGxLYWo0?=
 =?utf-8?B?R3RkUXRhY0hGc1RueFNRRmh1T3BmSDJNeGFZbVBmd2s1M1ZjZXl6cjNET1NX?=
 =?utf-8?B?MEh0eDNLMTBqTkhNRkFqSUV5dENSTGU3azlGbGlMb2x4SU9mTlV5Z1lDNTA4?=
 =?utf-8?B?cnZiT2VveFNEQ1JFQ2F0bzZ2NkpGdmN1KzgvUmZlK2pPZG1zRnRRUDVSNUVq?=
 =?utf-8?B?WTBKb0JkdDcrekVmaVBxWko3bWtVK05jcjVMeDAxck9sY0RWZGpETlJ5ZzlG?=
 =?utf-8?B?VlBFT1NVQUpRL1lXekR3aGlEQ0RiMWpKbkcyUGNsc01aMkRCbURqMnpPVWhz?=
 =?utf-8?B?MjFZTHVNS1dXSGlhcGw5MDdWbXFESEtqRzNiY0dJSGR4bVZzYUp0YVd5dmJO?=
 =?utf-8?B?U1lHajh1WFJza0dtc3ZtWW1pMWY3WURiSHdlNVdkVHZSZThTVmtxVkNNNzRJ?=
 =?utf-8?B?eXhoanY1WlFKTFJTVWNmMGo5bit3MWlqcTU1TzMvTUVqSDJNdFhwcS9oMHBI?=
 =?utf-8?B?TDN1L1BGaXVsbXpYMXpJR3VJUUZramc3U2FzYlBtbDdkL2xVWlBzRGZDQ1dV?=
 =?utf-8?B?d2FnTWZWa2RjMjZSR0dWQWJtcCtuNXNGSi94d1VZNDFFOE1VS084cGhTY21y?=
 =?utf-8?B?bEZCWnpUVzcydGdzaXdkQmN2OHB5SGJtSlovOWJLOVlIRUFvVGh6SlZKOTZl?=
 =?utf-8?B?RkkrVkFTMmt3Y0ZDcmd5amxRQ0NTS1BqRkxyUXBZNUlzd1g5TEJEKzJTNHU4?=
 =?utf-8?B?V09zclVRZnVabU1Kd2xISDUrQ2JIMU16SjQxT21qanp6M0lPdHNXR3VDVjVE?=
 =?utf-8?B?NlhhaWE0L0tCRmhuaDZIU1YrTGJJZ0dVNUhCZUphM3VvOHFXSFgxRkZXRURZ?=
 =?utf-8?B?NjNxS0loN3JER0R3WHhBZ25oS0RTODNPM29ZUUNpZWNybG9HbHYySWhkL3pR?=
 =?utf-8?B?bUUvc0hwT2M5bWlBejIwN05hWTMvcFRlVVpKNXJ5SEc1WjdET05sRDdCYmY3?=
 =?utf-8?B?aVdtWWVRdXAzQXFQZHJaM2NQb0lOQmFTRitBSTcrM2pLTTZnZ3BsMzF6MEpO?=
 =?utf-8?B?SXJXd2NEU0EveTRHVzVJREZoZFUrbGZhWS9TbkdHRzlVRWNsZmovdnM3NHYv?=
 =?utf-8?B?RGVBbkpXcVhnZlhtTm1mUi83TzRtR0Q2ejJJbytNOW5TbFhZNVJDb1F1Y0xp?=
 =?utf-8?Q?gXlG2W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 19:09:49.5616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9706f302-683e-4c76-1c61-08ddb8d2d9f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

Set the dirty bit when the memory resource is not cleared
during BO release.

v2(Christian):
  - Drop the cleared flag set to false.
  - Improve the amdgpu_vram_mgr_set_clear_state() function.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9c5df35f05b7..86eb6d47dcc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -409,7 +409,6 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 		if (r) {
 			goto error;
 		} else if (wipe_fence) {
-			amdgpu_vram_mgr_set_cleared(bo->resource);
 			dma_fence_put(fence);
 			fence = wipe_fence;
 		}
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


