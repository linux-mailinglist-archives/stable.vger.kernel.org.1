Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30909741826
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjF1SnB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 14:43:01 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:49633
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230496AbjF1SnA (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Jun 2023 14:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsLxT8hh4cEpT5OKb7TuvUeXJYwA/uSaDj3nuG7J0P87DudFVYd3qZDohM+xrVSUotZ07HT43K+dHaugsHohhLazhIvguGRE93wYCpTuZHdD9qTuBJbHyDGn+W6DhxkUjJUE711FtxNJwJX8/2IsSaHMpuppMv7wFfWAxGf/uL2SAaa+YUPf6nJoJZTdfxmhc9FRM1GeNJJn7Sl4A/0Ui7lVwpax9et7y6K8qwrq+Trw/0IEhGlq0DXDUos2rK7eG/5ttYA5lWsaCHauYK6VzwWTRxs4PBtKiH8rpmCy1uDO2zb1huPAKfBtXYTkLWP63tfkPKwCdtxU3q2jrIPYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrLSNLoj31Q2fU2Y8greJ7uLyvmkYzRxEb59p5dXi7o=;
 b=I9vx/aT9vOgu3nnzS8nJigq7PI6P+UqKDW2WGyjD0ullIqC07I86tYjAuaSlNNHNfpOC2RKE6CtG87lGrJd9r9jm/JyYrcKO6/yr61DoySFvYpQTkX+giK+nobdhKBntZbtE3SCV/M3kYGd/a3ftH4GDEZKodLTo7Cxkm+xoM3F1CTFOYv/3zLGFSR2buvhcurDOjTVMnRAf022CD33HnN73BPf+gn6kECZAYUjd6+haNX5ZxEtPSrIK1jXcW1HBqWWaAaLNNC/CyH8GEvAtmXRtPFRkgmIj0BxzZRhc6XzM4JdnsAwoMdy1BfvMVVRg9dIWaANIWF/zT5cJBX75Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrLSNLoj31Q2fU2Y8greJ7uLyvmkYzRxEb59p5dXi7o=;
 b=bXTjxGyyaMxM/op54Iwvw7lYeSpK53GaPEooAXg6eYxKushXsdk3tClTuMoOPMd3iSfpiKJGE1fAzficjQZ5W0Rfd2ZAdD5n6IdWtOVta91g7G/C+6ZppUKlDfKSklWUWhP0TKLqWt2D/9/hnj4PYrCMN2r8+3M1rrdjz59Vhbs=
Received: from SJ0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:a03:2ef::30)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 28 Jun
 2023 18:42:57 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2ef:cafe::f1) by SJ0PR03CA0205.outlook.office365.com
 (2603:10b6:a03:2ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 18:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 18:42:56 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 13:42:54 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Linux Regressions" <regressions@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5.15.y] drm/amdgpu: Set vmbo destroy after pt bo is created
Date:   Wed, 28 Jun 2023 06:16:36 -0500
Message-ID: <20230628111636.23300-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c643601-7eec-481a-f919-08db78077d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zeQyc9NLqIMJ+v6WMztVFX4YmOoZE3DtRS+4Rqy8ljEnWf7gvgBfXjETX5CtTkId3BB8pGZOdtmGYvbA5EY3VMv9fW5GcMmwuOItZSfx1apLZlnfGFObM1NfDCRZ//noqYxa2ac84eYtMysAZWZDRz6GPmwGimiClqlBQlrJHD2MTFrLVXWZQoc8m99GRxLbDO6eXJBBloh+kzrBKMcan+JRoMWghkZnwQ0MJICAF1i3KVsFFXMlkTShZmAXFE2uqv62j+sHrVDsZVl3LXPENhM0nkHnWPMRn2+dCjJakc34PVtzaJqz7fECNS1nXWRcgukCuZ8H3sk28UON/v7BK3ywscCBNdL9wMSkq+yZWvZUnEmWD92QH3wkjM/GoKzInY1PG0yTt5q/tCkuY2s1bHJrK9H4pPbXYjRny/fXuW3s9lRdjPcgCgHUBZpo6h2F07xn218hXsfJ7P28z5RUcTeL+tYaqhLttYNFzh5p3gagM2qxz8ma9S0KEkGQjZiTKKl9sGdXYJu1DcNgPAl+0ytlzQ+St3pOnPCnI5FjGIwXr5g3iwc356dK9Qav+p6LqoqUOXaqca29Y8ZKQSic8DYMRsdOe2ccLfYzmrxf+W/O33pH60nExHG+xEuOfNG00w+q7cME99mjCQgpyKX1Mmea6kVl6V0q4BaxZGtwo7bBHlb9cwvpNm1ZaKu3dzB/sk2VC16C//vXo1b6dbTwy941N8PbGANYR49Azxu31Ws7OdbaT348unS7BitI4lX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(66574015)(47076005)(478600001)(966005)(1076003)(336012)(2906002)(54906003)(7696005)(26005)(6666004)(2616005)(83380400001)(186003)(16526019)(426003)(44832011)(86362001)(41300700001)(70206006)(36756003)(356005)(5660300002)(4326008)(81166007)(316002)(82740400003)(70586007)(40460700003)(8936002)(6916009)(40480700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:42:56.2020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c643601-7eec-481a-f919-08db78077d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Philip Yang <Philip.Yang@amd.com>

Under VRAM usage pression, map to GPU may fail to create pt bo and
vmbo->shadow_list is not initialized, then ttm_bo_release calling
amdgpu_bo_vm_destroy to access vmbo->shadow_list generates below
dmesg and NULL pointer access backtrace:

Set vmbo destroy callback to amdgpu_bo_vm_destroy only after creating pt
bo successfully, otherwise use default callback amdgpu_bo_destroy.

amdgpu: amdgpu_vm_bo_update failed
amdgpu: update_gpuvm_pte() failed
amdgpu: Failed to map bo to gpuvm
amdgpu 0000:43:00.0: amdgpu: Failed to map peer:0000:43:00.0 mem_domain:2
BUG: kernel NULL pointer dereference, address:
 RIP: 0010:amdgpu_bo_vm_destroy+0x4d/0x80 [amdgpu]
 Call Trace:
  <TASK>
  ttm_bo_release+0x207/0x320 [amdttm]
  amdttm_bo_init_reserved+0x1d6/0x210 [amdttm]
  amdgpu_bo_create+0x1ba/0x520 [amdgpu]
  amdgpu_bo_create_vm+0x3a/0x80 [amdgpu]
  amdgpu_vm_pt_create+0xde/0x270 [amdgpu]
  amdgpu_vm_ptes_update+0x63b/0x710 [amdgpu]
  amdgpu_vm_update_range+0x2e7/0x6e0 [amdgpu]
  amdgpu_vm_bo_update+0x2bd/0x600 [amdgpu]
  update_gpuvm_pte+0x160/0x420 [amdgpu]
  amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x313/0x1130 [amdgpu]
  kfd_ioctl_map_memory_to_gpu+0x115/0x390 [amdgpu]
  kfd_ioctl+0x24a/0x5b0 [amdgpu]

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

(cherry picked from commit 9a3c6067bd2ee2ca2652fbb0679f422f3c9109f9)

This fixes a regression introduced by commit 1cc40dccad76 ("drm/amdgpu:
fix Null pointer dereference error in amdgpu_device_recover_vram") in
5.15.118. It's a hand modified cherry-pick because that commit that
introduced the regression touched nearby code and the context is now
incorrect.

Cc: Linux Regressions <regressions@lists.linux.dev>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2650
Fixes: 1cc40dccad76 ("drm/amdgpu: fix Null pointer dereference error in amdgpu_device_recover_vram")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d03a4519f945..8a0b652da4f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -685,7 +685,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 	 * num of amdgpu_vm_pt entries.
 	 */
 	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
-	bp->destroy = &amdgpu_bo_vm_destroy;
 	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
 		return r;
-- 
2.34.1

