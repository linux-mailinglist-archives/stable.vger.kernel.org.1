Return-Path: <stable+bounces-163232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7757B087FF
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 10:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A020170B91
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735581FAC4E;
	Thu, 17 Jul 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MmMttbUj"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2B1EF0B9
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741319; cv=fail; b=hz0k1V/+xHdZ3o+V5eVkb5TOs/GfFXNkPgoQQf8mDBJaseJnhQoTjFFgja1dN+Digq7iAW+kzw9rEvHkC75MzRbJGDH3a2bGo1nfKzNeCJsII6o60dT/ETYxv9tgbwmiHVePxS0C3SF5tpiisPAoGSW/9hOrRqVg5V/QlhAXNwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741319; c=relaxed/simple;
	bh=48GjZoT96K0EaPSaf3BxOk0r/ps5umWe14OTHwp/rII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AtmfJcsehXUMRiRJNoKufetj1O8nzQSF5Xt9lwogixFYJQrEShkMsJlCuLkGCPaj+ADV6igEt96F7XjMa1ukbSmmp/JEAnUMUMBaVgvTd1oRnhzToq0Zb7C1s+CvT/Ze5Y3KD0XwtrYAOcHG5wJyoRjUaj1szdlw33/lrQpjv4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MmMttbUj; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaGuS5fKRHVq8BsD2nnAMWSCUBoBETJtFqsuI8iSzankgrxWWEUwJWCsSdkhCyKMrldpkpYE0dWbeSxJYuHpRAdoPLMquDbnp56diCsJ9GqM+skMCzE/JawROcDbHTSoIWOeeJ3SV/CI1HrE9TLJy4YJATrZl2PZ9mKOI4uv11ltMPllr5G7EH1qK7pkGSNXhXfxy+bKuYJho93v4vKOOSw+wJ+ghkYJuKa6AkTVCaxGTv25KLUtR1wqLgtVBErvrF9+EaENw2m/QR8+AcuJ/KLpQgk8pb2Cwhl3ZBsgw78VRVM6TML0QyAr1f+qwPgGbllgGMG4s+ZdWm0OJr+ntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfie1Z3JSZbGuMD4fAFdIGmBcv6Jb/6URqCi2wYPU0w=;
 b=X8c9ZdAChX7BX1+f5Eg3W31YZk4+nn6riAN8SxaqPzBS+8wGRDiPx9jJA3NYOFfcPnDj14OJoJ9eqnQuOlYvBAWlT+oXyKa7Mu6/SKpXGCK86JftGxKFVgpbzhQrEkrVePh5isj2aNo9N6f80AeIzGkRFaKlAVrr0RSKml5U4JDmvd9xEm+VSvSTkUkqTUOF0hiQ6BJn7CHRXtQhYt21l9kiZskiETFRkewTCDvQmaUwRbhGj9zbFaT6kEitkpaY5CrJ0Bq6RSkt1Uk0eim11u+WyaD5H1qs6p4IT1d/2OZP0Fu6S9kAV5H+E4tFm/ofHi1ezJF/SpGy08NfJCVpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tfie1Z3JSZbGuMD4fAFdIGmBcv6Jb/6URqCi2wYPU0w=;
 b=MmMttbUjWuJyxTY7AwAfUArCrDE6hvHnc1JtsPbWsuMbD6qbcUPjJXtTWmv0jGvQ3sQFEMxjJhJBinecjXcv26AgNKeiXugKq6mRYwwxCT8H9Id7IwkkGE9jZQhKRO/MXSIzzidtEZPE03loGw/kySVkIQLpTaLfe0AT7yBQtuY=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 08:35:10 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::de) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Thu,
 17 Jul 2025 08:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 08:35:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 03:35:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 03:35:06 -0500
Received: from lcaoubuntu-server.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 17 Jul 2025 03:35:06 -0500
From: Lin.Cao <lincao12@amd.com>
To: <lincao12@amd.com>
CC: <stable@vger.kernel.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>
Subject: [PATCH v2] drm/sched: Remove optimization that causes hang when killing dependent jobs
Date: Thu, 17 Jul 2025 16:34:58 +0800
Message-ID: <20250717083458.920583-1-lincao12@amd.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: ef66ddb4-b53b-411c-acd7-08ddc50cd79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzE1Q2dBY05qb08xWVhDRUlZeVdQVVNzZGRZanBWdStGdW9VOU96UUE3L1hk?=
 =?utf-8?B?YXZHOS9Vc2YrK2xQN2cyUTdoUnQ0bGowY3l5Rm96Sld5RmdoT0lFTU1BUmlU?=
 =?utf-8?B?endJQWM5THYyaUJiVFdlMUxVOEZaRFZ5YXFWQ2k5cjJCM2FRTkJxUG84ZlFp?=
 =?utf-8?B?NlZJVzRmdEVHS2NyK1FqSUtWN1BKZ29vNFBYTnoxcDZUT0cxdGh2THpRUys3?=
 =?utf-8?B?WVU2MG5jWDVHWXNWZUdERGZwZHIzSTJLcmVzTGU2Y3pLYXhVbE1YS1o1bHQy?=
 =?utf-8?B?N2pSMk8wc1FuNWJhd0oxVkRVb0VNQ2s2bFM4dHIrRmdKeXhKYWo2Vm1PN1F0?=
 =?utf-8?B?TzFPdmtWc2RmUXpyMXpsaGdMNUtuMnpUNUFadTVPN3RMbDNnTXNxWWx6ZDJT?=
 =?utf-8?B?OUlRYzZyUzZObklCM3JFSjB2c0EzSWcrSWNXRTVFck9tb3NEMkh4N3RxSTBh?=
 =?utf-8?B?enJVNFRQK1FZM3F4Z2VXMjdIeENNN3UvMHV6MHJDYU9JTmxlMFlyU2NzNjV2?=
 =?utf-8?B?Qnp4Tmc4bURSQ2tseTlGM01HWE1qR0FqZ3hpMmV0bzRpeVBNNm1uSWtnMlVC?=
 =?utf-8?B?Z2NFUEZuMEVKQ0srRFpRVFlFemxUV3I5YXhnTDJFelFVOFkyc2NXbkVocE5K?=
 =?utf-8?B?YTdPUm11QmlMVzMzelpsTlFXZmhiRk1TeEUwdlRtRnhUR25CR0wvM0F4eGNV?=
 =?utf-8?B?aWRrSk5reWdsNEQ1T1l1UkJuNlU5SVZySjA0S09PN29qSHhlUEhiM3p2Tzd4?=
 =?utf-8?B?aXluWFBVWEcyeWowT1VhTms4QytJVDlVUzZrK0tjclFTM0g0cnpKQVM4disr?=
 =?utf-8?B?V01wbkFkYXFxN0NrTVNBUzl5ODR4Z2JOTkVoaXdWTWRmUmVqY1dFVFBabmNL?=
 =?utf-8?B?ZXdUZFI3U2ZxZGVvUmZOOE0yVWR4akVRTk1mUEF3aGkrQkxFV1VNZ0NCaGlO?=
 =?utf-8?B?c1M1RkJpM0JMMnMwVDE5RFRjbTV0ZStuZW1aTm9NTENKczVhTE9tRllDeGYw?=
 =?utf-8?B?cGN0aEViOVQwQ0NTazdwTmJ6Wk1Hd2pOcUJsRHE0MjdDQThEejVXNGpEY2pQ?=
 =?utf-8?B?UjhxeGc3Z3NDU2d1eG1YeGN4Wi9zUGVuUDlkT0M0d2ZNenFpeFZVYWF0N1V2?=
 =?utf-8?B?eE43VlB2dTlqMzBzNytMUkVGMjVVT24rUVl4ZmdKYjl0SjlINENRYXNLY0ph?=
 =?utf-8?B?MkZUOU5IT0NXTk5jbzlkWnZmZDRHZzU1TlM1NGUwUlRSM08yaWpWc2Rzb0dH?=
 =?utf-8?B?UmkxL1BCLzU3RHRFSFVaaGVONHdUVTczWlRrZkVYTGFvNVRsdE85elN5L3V2?=
 =?utf-8?B?ODdFOU5kakZZcEdQVmlvSmhRdk5iV3Fpa1ViYzVpT3FlbDJFKzBCc1pERmgw?=
 =?utf-8?B?clRpNzBiTlE1RDhab0FNbVU2QWdYQ2tObDRIUnRkMnQ2RkZuSTE4K0Q1Y083?=
 =?utf-8?B?OXloZGdDNmdkeGlyOXNSUGQzRVkxbkxyNjRnNDdFM0I1TkhXK2FIczN5SjdU?=
 =?utf-8?B?ZDBiRWxmWmllcE44cHdhWG4wdTVUTjFpb0w4bHI5azc3UkRnTlZQTEUwOENL?=
 =?utf-8?B?WFZTNUh1SHVLTlM4d29QT1ZnYjJBUzZPQ1FuZ014U3Q3YldJVXdwU2phZ0pB?=
 =?utf-8?B?SW14RkNMWGR1YzlCa1FVZFVmbzI5YmVrZURuOUJqMDhweFRRSlR0YmdPeDhE?=
 =?utf-8?B?STdIdzc3QUErQm1lVGQ2MGtjM3hydFBEaTYyTk5PaG1aMGNuQmhxM2E4ZStE?=
 =?utf-8?B?N25FZFhMckFQKzZ6UkNSWVl4VXdLTDUwd2dHa3FLL1o2Q1FXdWUwZjlnVzY2?=
 =?utf-8?B?b0NUb0JISTNqbERkd25RNFVGMkpDSVluZkJNRWFSN01KK3FjQjJySXFkZUV3?=
 =?utf-8?B?eGMrZTVEdG1GbUNoaFZKdGdqWVRPY2xGd1B1cGRjSHRrTzYzNGVxYVpFTzh2?=
 =?utf-8?B?MGlydndsYzF6cE1RdFlxMUsyMytOcFhGZ2hncjFhZG1lYkRsaHd5Rnd2MTEz?=
 =?utf-8?B?ZUNZTURnYUFTbjBpdkt5YXJOR05YN1gwR256UzhLcGZBbnYvNDJ6ak90TWM0?=
 =?utf-8?Q?K4iTqN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 08:35:10.2651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef66ddb4-b53b-411c-acd7-08ddc50cd79a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914

When application A submits jobs and application B submits a job with a
dependency on A's fence, the normal flow wakes up the scheduler after
processing each job. However, the optimization in
drm_sched_entity_add_dependency_cb() uses a callback that only clears
dependencies without waking up the scheduler.

When application A is killed before its jobs can run, the callback gets
triggered but only clears the dependency without waking up the scheduler,
causing the scheduler to enter sleep state and application B to hang.

Remove the optimization by deleting drm_sched_entity_clear_dep() and its
usage, ensuring the scheduler is always woken up when dependencies are
cleared.

Fixes: 777dbd458c89 ("drm/amdgpu: drop a dummy wakeup scheduler")
Cc: stable@vger.kernel.org # v4.6+

Signed-off-by: Lin.Cao <lincao12@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e671aa241720..ac678de7fe5e 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -355,17 +355,6 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
 }
 EXPORT_SYMBOL(drm_sched_entity_destroy);
 
-/* drm_sched_entity_clear_dep - callback to clear the entities dependency */
-static void drm_sched_entity_clear_dep(struct dma_fence *f,
-				       struct dma_fence_cb *cb)
-{
-	struct drm_sched_entity *entity =
-		container_of(cb, struct drm_sched_entity, cb);
-
-	entity->dependency = NULL;
-	dma_fence_put(f);
-}
-
 /*
  * drm_sched_entity_wakeup - callback to clear the entity's dependency and
  * wake up the scheduler
@@ -376,7 +365,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -429,13 +419,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
 		fence = dma_fence_get(&s_fence->scheduled);
 		dma_fence_put(entity->dependency);
 		entity->dependency = fence;
-		if (!dma_fence_add_callback(fence, &entity->cb,
-					    drm_sched_entity_clear_dep))
-			return true;
-
-		/* Ignore it when it is already scheduled */
-		dma_fence_put(fence);
-		return false;
 	}
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
-- 
2.46.1


