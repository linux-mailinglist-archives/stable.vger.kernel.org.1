Return-Path: <stable+bounces-92075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2B9C3983
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 09:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DD8282381
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECE15A86B;
	Mon, 11 Nov 2024 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NLoeYKnp"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9415AAC1
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312601; cv=fail; b=o0iUKLpIWFdpBERQAuwsrMINq2CnIQYlDdfnLg0dQ5x6XT1SlwaJFynTBhgZ7jpIUgwhi3/+wA7kLReyGY283G1P+f75vlj1848cTjliyeC8p9u/15FZX0CpLen2NTysB64wOKDlvyM8OHRudIiASssyA+aSKQSUNB/53rI9FGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312601; c=relaxed/simple;
	bh=y8gXbldHnT7CmFInjZvGlfJu3cYR8gS7wN1gtMC95MA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KTk6f3epkv9mMwR1xEGm/JTWjoD4gYG9m+34H92ch/SOjDfP6LRAt87rbKbBcMpXtiDcHUd7mO6ypJ5cx77Pw3H3GX85pAz7Pmm/zeHBr2P+Bgsed0T174fU3DuAF0V7yyjs+/TEt62xxeg8AGYBMg14uaXqx0rxBAdrl6JxwIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NLoeYKnp; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5xSkHKOcm7JMLNKajIv+y4F6H8yE2DHRCP9RWZOANLF61UO6z9DQyr4JTZp76DA6+AXAYt0CFIlcwmxovw8XC+LXD9M9fwZJ0uSmYcK+ye8rDXEOFyom1XDy6q6XRCeNJ1FljZbvv4BvRKC6ojPyCO5kZIWsHHa3eqj0nPRK/IkqSe406ir6T3dmUWAkjJkthxT+Qf/5M08lCoRUh2gJ8p5mIabI9iB+McykpIOwP+X/LvCXXL1i5xJTOv+K5uGKe2stFerScKQge37I6lz10lNPt0E5tctbt6KMswLdV9zvG3LC+W7Ucx19BJQipaTVFXo+/qa4IcXQobpVRx2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBR09qSKov2s0pt007GrDWJR4nZmmgyn4cnHXpszAWE=;
 b=JKgvLtooKcdyTE8xl8SWw1JQKIXD4oa/fPTStnbZvz3LeQT+XEHYsbEVm97J/EXw5CE8rmxdrXnZUtoM0l9iF7XJcGQlFcFGwrVTEJYkxMraGWJlS6xq3MCjT+xBl2w4MrMn05pIUXa8oZUa8a7X5GGD3VeMYlBzg+tR6lDnxnOJr7W3Ya0wCuNFwjKhOLzKejdxJdBiRgsyzbj7JKAUfnnVNVc3i87tcZIQxXW6DyUCjtQ9TQy30u8AJeJpCO9wJIfjZj+TSlGucFx5l6gIbvCu9sva/4Fy/7eMXH7wyqcxeLRLGhTelM0nfdiWOAxrRvpn8mYh+Z5yUwuXMEGAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBR09qSKov2s0pt007GrDWJR4nZmmgyn4cnHXpszAWE=;
 b=NLoeYKnpctSlZ3BE7GY5LPPE14sX+vZ6lefaNZtkeWd6UujB1si03G53yyossqojPUQ9MCPAK9gThIWfpZ9G0WYrDH4w+J8kZCJvjlziToHZSVr97KDee1gqyNT4RboTIMIjQt6n29C0BaiiMGcMaqDKaKn6VBYhomAauSRntNk=
Received: from SJ0PR05CA0152.namprd05.prod.outlook.com (2603:10b6:a03:339::7)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 08:09:56 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::be) by SJ0PR05CA0152.outlook.office365.com
 (2603:10b6:a03:339::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.12 via Frontend
 Transport; Mon, 11 Nov 2024 08:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 08:09:56 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 02:07:16 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
	<Arunpravin.PaneerSelvam@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: Fix UVD contiguous CS mapping problem
Date: Mon, 11 Nov 2024 13:36:31 +0530
Message-ID: <20241111080631.353282-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: c49be5cb-067b-4f89-e033-08dd02283aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L1QtibqTD0dVC0eYv2qGQCx16nffNajeYobxMn9DqUhTE3RKCl4/xIyVmYgm?=
 =?us-ascii?Q?FqtrfltAtjf9r+SFk9+4YoNXv/wwHzBEu3axPiOoNMp1h70p+P+sfGwy+ikk?=
 =?us-ascii?Q?KzeuzjZ9LLWLqd4gpmTovRRRCNDfCyvMwG7bzyYvVcjIhL/wJFgKSGI5qdqm?=
 =?us-ascii?Q?ABl69YbJI7ep/u//IBVWDfbkJjpBGI72H/B7y4Nn44aKsuZ+QSPEooIWftZ3?=
 =?us-ascii?Q?2isQCtxe4lrPycAm2vQrcVktMWyj2uQCW6aNg3JJ2kEI7RX81XdaVnHezCbu?=
 =?us-ascii?Q?Mh286JcSlUaTKFyMn682gXYq54qKEdjZxxhBKoqmNymdEwR33bKO+vBxk/o5?=
 =?us-ascii?Q?1tDhVGXg8DL4gj1xxap+JBhZqhapxqHBDqFCILROIq9/nsXphNBhHvCHN4vL?=
 =?us-ascii?Q?xmP4ZpmhG+tmv70stYFVBLdxZF2nPlUVM6EwoZ6BEb3h1ia2GNoKXWn/o9xi?=
 =?us-ascii?Q?ffFjOOJZHD0zIOfADlSeVg/K5f2zMj4A7yMSqYzovXp5253TVJhOQoAGqLJD?=
 =?us-ascii?Q?u49v0cV/qkPmvjWuyJOtAA0Q//4QLFqrygRwWttQmMDp//GnvD/NxgTsAvVI?=
 =?us-ascii?Q?VimT9FkZB+61uxd2tIFk7cSs0VczN6Hn1Lizwpei4BDiWewoC2w80sj3Gmzi?=
 =?us-ascii?Q?kXfWmVhDIbA1S7QnYzbqQomBeuKge+JkuV92JJaeHSjZn6DleKURbif05M3a?=
 =?us-ascii?Q?f2eELxTsWWyuep4dXTJlFn8hbsdOJwE4bU8+FX6p1oNrRNukryOcL0Q3Wxss?=
 =?us-ascii?Q?z+aAfaVAaUESl156TTNaDDStB3hXijtAMoaADZiBUSpCcqcyVJZ75TQ9ZfJp?=
 =?us-ascii?Q?hgou+huY8+kpctIZ9v3qanB0JAyZsSTjDzFLWPD7cB4eio9X0WAcMkVHpPEk?=
 =?us-ascii?Q?obp1Zn4wRlRZqNVorHWn++k68C9Op9x5+UAfobz/lBEQ6kvnCOBU+kuP/iiK?=
 =?us-ascii?Q?HyKWdfqqG6JGmxKmaaPkCA31L2N4cDldDbU4LCu01JTNXles5q+5lDpQUEvo?=
 =?us-ascii?Q?ZX0bvB/GDlcHIV5Q1QfKJtjxa51bT406EfMvx4n8swYI7TmeoL6ty5qKnNTf?=
 =?us-ascii?Q?rtG/+3FycWUhuWe1hudEtrCaAahW2cIc5LhzdbbZkFtAGKWn01Htp7duPkBv?=
 =?us-ascii?Q?6/aAPWXvepJ9oZoLSrd7lWFuFFOIeOx1NOjk9NqFK7MPa1qs96sd12T3TJ2A?=
 =?us-ascii?Q?X2Rf8wgcnpj7TCkHhBl8qqZWKfNv1nH9Grt5pQN4WX9x1Peo7IKx5Ux+qgQn?=
 =?us-ascii?Q?dMSlYmo2fHsQ4OSYNpPDVYyKwpFs2es8N8ABjMuKhmlZETEmLWwWZUtzH/CU?=
 =?us-ascii?Q?vfZ9+cJK7KjMFtnGL+k4WE0EC1loziC9GDTGQru8ofXDhqCX0zNAeUg4FOTF?=
 =?us-ascii?Q?ywysGNM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:09:56.0490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c49be5cb-067b-4f89-e033-08dd02283aac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297

When starting the mpv player, Radeon R9 users are observing
the below error in dmesg.

[drm:amdgpu_uvd_cs_pass2 [amdgpu]]
*ERROR* msg/fb buffer ff00f7c000-ff00f7e000 out of 256MB segment!

The patch tries to set the TTM_PL_FLAG_CONTIGUOUS for both user
flag(AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) set and not set cases.

Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3599
Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3501
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d891ab779ca7..9f73f821054b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1801,13 +1801,17 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != &parser->exec.ticket)
 		return -EINVAL;
 
-	(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
-	amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
-	for (i = 0; i < (*bo)->placement.num_placement; i++)
-		(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
-	r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
-	if (r)
-		return r;
+	if ((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
+		(*bo)->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;
+	} else {
+		(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+		amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
+		for (i = 0; i < (*bo)->placement.num_placement; i++)
+			(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
+		r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
+		if (r)
+			return r;
+	}
 
 	return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
 }
-- 
2.25.1


