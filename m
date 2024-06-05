Return-Path: <stable+bounces-47964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 967878FC155
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 03:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7101F234B8
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 01:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F739AD6;
	Wed,  5 Jun 2024 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gunJ6VPE"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253708F44
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717551237; cv=fail; b=iUiWKGaN2GVKzjC2ERSOd2ui9FdyURBJ4P+NeQZLK4rMn4mOWLbSz6KQKs0ceP6NkjQjR33M/nuIGaXTaC94s9Bs+MmbMu8n6UAKDdXc0bkSkwIODzcn+J6NJdiub0R6nbs7bBxx0c8ALgw6nExZ06xChYqLcgHEOgPcYg3AccQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717551237; c=relaxed/simple;
	bh=sR/zub+n49uYHBLCtnkjLwn+TCHVlaiUBhH6IYZKCoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClVDvCebmkmw7T2XqhYjA55Y122jdtVH+528h6IyKKfC8ZrTlie2hrUerP6xaXP41WRuYZDyJe4Pr0Q6EJJ3BWZwovUJnFdAGReMpYJSYNuxKtZ2vMU4wB6ci+BBPQ9zTCj9Yr6bjH5CWzF4gZiCq9Is7HgFbAl4gTpgiimWyDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gunJ6VPE; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVElPE63X/VjyMXdlN57CZdsB422XPTQjOJtxNDMZ3QunYm0z+kuGgFDJp/Inpj8+Cj8JZhbKR4oNdLzLRySE7xYMvXF7SUzy0VNP5eFd/jGgNEh/lSZlXkTna2EX9mxf/c6uElBLcsbkZ25ZatFtSBaA80mq3a/tz0a0PvA0bwfS0WXfWrKR1xnG4HWt/52uT4modMSNJ3eIp2kjHaXPT4sWRXON1iZfIL7ZwodjHJR18CiVlNjJN/LQwLRrMLJd5Eitky36iPgg6/rO+1t0FshrqR9cYHHQjbuGVljkV7OAE5FFtNoymNLx+UlH/zDRg3SZB/wmQnlmN39JD4yJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcO/Aw/fnmR02h+TNfOalRZGjhnkbk0JnhGtAeRtE4c=;
 b=fE7rXvjI4Typ5WkGH3J7+db8oowI1t/C9t9J+RJjMXZGCfROZUh9UTjN6QdfrqfJnFp42+RvqYpnhG4kjLDJLOUpFTez/ToPXoUTi2Cptfmm+nkiXiLqkrzLEtlt+mev1YHUN5HZ2bkYDXlvSo+WiS5AHrp3e8kZ7euIXxPyEcXclAiBLtc4K6L2EUDtxYvEXeUZlcsmZiUM4DEDSqllKrVjup2jxlMbEAZZQVwe0GafVERsIM2mcW4/rF5p3JWJJuMSPf02SWtDzhxxDOFooNfbaHchP9sLne0O5YJMTkZz1I4x5LXTRS+457HoPKU92BEC13Sycr9BRtOhpqlGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcO/Aw/fnmR02h+TNfOalRZGjhnkbk0JnhGtAeRtE4c=;
 b=gunJ6VPEWbBXB+poIStGQTqk+NLNtmFtlsp5gTwBd7vlwiIKfD8jIRXfAD4GmjMbE9PcWQAYscXwHhOZm5iH8rN75LCRSqPvRDmoyuOF0/7OKvMNkCvytQ4DyV6c1B6kjOzVE98ZrietWwuJ8qJpWQCj/M79fjggBqxpk0fWh8I=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 01:33:53 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::61) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 01:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 01:33:53 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 20:33:50 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
	<Yunxiang.Li@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v4 7/9] drm/amdgpu: fix locking scope when flushing tlb
Date: Tue, 4 Jun 2024 21:33:16 -0400
Message-ID: <20240605013318.11260-8-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013318.11260-1-Yunxiang.Li@amd.com>
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 381d46dd-5e95-428e-6a29-08dc84ff8f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGpYU214WFpwQXVmTXp6Y1N5blIxbnRLVk1haXhMQUs3UEFQeXExZEpEVDJa?=
 =?utf-8?B?dGFBcWVFRWVjZDBWdmNnL0dZZmF1UXNYQ3RoaFBpSzc2b0x6SzY0cWJBU2Nk?=
 =?utf-8?B?bFRYbURmeW9CTXc0dUVFOTJCVGd0WGhWalAwdEdIZVBqRkI2NjhFSVN0QVN3?=
 =?utf-8?B?Yy9VRmxlZXpQbVFZbW9qMGc0a0I2d0swakF4KzVqaTQvR2JNM0NtekJuQ0c4?=
 =?utf-8?B?US9qcGdOOHhEOTJwb1pGb25scVliU3JuZVM5ZTZ5Z2Ivelhyc2sxS2x2b1BZ?=
 =?utf-8?B?K2FSU09rV0xTbzNRM1hHUm12Y2tzWnlWd25HY29NaGNpUGFyMTYyNC9yc3dP?=
 =?utf-8?B?WHJYZVdhcXQwcERhSG54bHJhM1k3aWkwQjhGTW1rbHVsazlEb1R3QlVWenZS?=
 =?utf-8?B?RWxpMUFQcXNEeTNUbWlDdXZkV01aTGk3Zko4OXpwRXVsMHJmMUlLNisyMWpZ?=
 =?utf-8?B?Q3RwOU5CUnM5TzVGMEZ4M2M4RHJsRnFUcEc3VW5NdXBmZEdOSnR2MGxNcFoy?=
 =?utf-8?B?OVZ4T2RwLzVSTExPQVFFcW9mTzIrd2IvZWJ6ZjZMR1ByQ1NwK3BUQ3U3RkYz?=
 =?utf-8?B?cVJDMnBqVnJyVHM4UjZ2bWEvbDR0dUl3SkxwOXpEUmNseHZzWXVHWEtDMXNP?=
 =?utf-8?B?NjJhcVowd0wvUGw1S0ozUC9VYUhGeUtmMFJ4aW5VdlpNenFNOUdQemlSRllL?=
 =?utf-8?B?ZE1NUG8yMGtDZVNrYjFwVGhRVThiNURNUkk3Mk15TE9MUjNBVEJoTVdmNEpL?=
 =?utf-8?B?eFE2cFduMjJ5K2h0TFNFcXIwdVZidVNvQXZ5SDlpM3l5a0twZm1KWnhIWHpM?=
 =?utf-8?B?MUpvOFJ5NmZyZlNSc3IwT1ZzNjhZQ2JDbE1lQTdEQkVnL3FCM0cxckFuQmFO?=
 =?utf-8?B?NS9PVEsvdGlZQTNKd1FJOEgrQ3doSXBvNDk1WkN4Q2N2LzhJTDlCU1RzSFV5?=
 =?utf-8?B?emw1cm5sYmYyc1RsQ2RLTDFoMXhCVU0yVnFUT3RsZTMyL1dxd0g3NlFDL2lQ?=
 =?utf-8?B?UWlYREhtaU14clFtd3g1OE1zb1dDSmNVZXdSazlKTTRnQk91WFZJVnA0RnVO?=
 =?utf-8?B?ZVZTdEJ5K1drNk5WVTQ1LzdVK1kvY2dCWDd0bUxRbi9RcklJUUxqRlREMXlX?=
 =?utf-8?B?ZyttK2ZQb0ZlRExiTitFRTBwaUF3WG1PengrWnNaMnZsWkp0UmJvZ3JaUUFK?=
 =?utf-8?B?MTlOMHVlbkt6ajdoTW1za1hTMU82VHpqcE9OMWthZnVvZ0tsdUpEc0JhcWdo?=
 =?utf-8?B?bG5VNHRhMG5Vell3ZG5oVElTNUlDWVFSVW5aZERDVFp0SXZsRm45cEJrQnVG?=
 =?utf-8?B?Z1NjOVZNK1hhaVJqQm1KbE1TdENRRk5jTklpUVdPYnpKYjFEaUJ4azJ1ZXc5?=
 =?utf-8?B?M1gwN0M2cXlObWNrNnl4UWFSUWpTbURYL1pYTldRczVpODZUZ3R6bkQzSzQy?=
 =?utf-8?B?OHdHNzQxcHg4VGJ3eGYxM0VjVlV2aWZPM0tXdDRBOEJtN3FVZHF4am8xTTlv?=
 =?utf-8?B?c1JtRmQ1RXZvRTljVVl3VURiQUNDYTV4K0k4QlhGaXNuRXZxcjdnUURlZEZv?=
 =?utf-8?B?aHFUdlBHZDdlMW5DVjF0RVJBQ3hxQTZzeThsNVEvc1F4TURISklFN1JjbzM4?=
 =?utf-8?B?OXZ6MXZEMDY1RGVzS3Zpd1dLUXlWTS9ZYXFSM1JZYUw4NzR1T3pkamNteHZP?=
 =?utf-8?B?TDV6Wm5KdlQwaHlJdjBTYnV2WnExNnJxM1NCYytKWEowLzJZVnVmQmRWNkQ2?=
 =?utf-8?B?M3FaRnBwMUM0OU9yTi9XdUhqYUlKUnVJU2d0eGJEclFrWUNLRy81WjRLTitC?=
 =?utf-8?Q?9cph/uXFQxtp6HXnD39OjoKNvLLi4k3a5eU/0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:33:53.2984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381d46dd-5e95-428e-6a29-08dc84ff8f30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425

Which method is used to flush tlb does not depend on whether a reset is
in progress or not. We should skip flush altogether if the GPU will get
reset. So put both path under reset_domain read lock.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 66 +++++++++++++------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 660599823050..322b8ff67cde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -682,12 +682,17 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	signed long r;
+	int r;
 	uint32_t seq;
 
-	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
-	    !down_read_trylock(&adev->reset_domain->sem)) {
+	/*
+	 * A GPU reset should flush all TLBs anyway, so no need to do
+	 * this while one is ongoing.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
 
+	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 								 2, all_hub,
@@ -701,43 +706,40 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 							 flush_type, all_hub,
 							 inst);
-		return 0;
-	}
+		r = 0;
+	} else {
+		/* 2 dwords flush + 8 dwords fence */
+		ndw = kiq->pmf->invalidate_tlbs_size + 8;
 
-	/* 2 dwords flush + 8 dwords fence */
-	ndw = kiq->pmf->invalidate_tlbs_size + 8;
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			ndw += kiq->pmf->invalidate_tlbs_size;
 
-	if (adev->gmc.flush_tlb_needs_extra_type_2)
-		ndw += kiq->pmf->invalidate_tlbs_size;
+		if (adev->gmc.flush_tlb_needs_extra_type_0)
+			ndw += kiq->pmf->invalidate_tlbs_size;
 
-	if (adev->gmc.flush_tlb_needs_extra_type_0)
-		ndw += kiq->pmf->invalidate_tlbs_size;
+		spin_lock(&adev->gfx.kiq[inst].ring_lock);
+		amdgpu_ring_alloc(ring, ndw);
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
 
-	spin_lock(&adev->gfx.kiq[inst].ring_lock);
-	amdgpu_ring_alloc(ring, ndw);
-	if (adev->gmc.flush_tlb_needs_extra_type_2)
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
+		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
+			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
 
-	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
+		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+		if (r) {
+			amdgpu_ring_undo(ring);
+			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+			goto error_unlock_reset;
+		}
 
-	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
-	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-	if (r) {
-		amdgpu_ring_undo(ring);
+		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		goto error_unlock_reset;
-	}
-
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-	r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
-	if (r < 1) {
-		dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
-		r = -ETIME;
-		goto error_unlock_reset;
+		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
+			dev_err(adev->dev, "timeout waiting for kiq fence\n");
+			r = -ETIME;
+		}
 	}
-	r = 0;
 
 error_unlock_reset:
 	up_read(&adev->reset_domain->sem);
-- 
2.34.1


