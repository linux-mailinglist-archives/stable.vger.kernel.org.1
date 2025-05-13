Return-Path: <stable+bounces-144190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBB6AB59DD
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1847B2779
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377382BEC3B;
	Tue, 13 May 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j8tmetsy"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A92BE7AC
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153782; cv=fail; b=QO0/FpwwApEKFkfQjEeUBaTKM9ajHVOjuSFvZ3N4LnES2n3dCpOYHNQxU7Bu7daUY70I6XXnSTN7i1qoLA5tk9RDGNgZlWeEUy0RFg+LGB3r4FJdUIcin5tNvIoDQceVSXDJTaVc5AAGsd1F6tBVXzK1fHA4kUezXpROVh9PwV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153782; c=relaxed/simple;
	bh=Ccuz9ZUM4HWqXxF8jY/BjEVxznMaYHVOld/2rscD+Yw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gc3vlXDHUDyc7WZ7YumKSs8IC1IQdOCeMmDrxtvkoDAlSVg/v8iURr3CxiP37+L01DCB0Iy4Rlvu1bLvgJTYuttowXWUHp/cSBn2P6+vNk5r+S2ANGoNcmjYaOOwJAqYwh0iNTX5BCGz6m2zA8Sdd3pTLT91d8QFQY3xWVmVeJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j8tmetsy; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdN9ISgtq7dRJTv6cgPx6Bv1dTlSHAXaUYZTrAB+trh5eQiqyYCChjuL3AbkbcVDAmFA5SeJDO+xncjnqBCTqrO5imwF/r00iwaFXP0KfO8kZv1374rcnR0BkmR05giyb0wNsCjMw5iKPCRsOUfINNLMj9Elxj442Qb4Prjydti/95agPga4MALzUok5ZxmjrDsFlBi/Siv/0D1W4VRZJGhM7CehxbEW4Q4ujix3+U441QRTxkj6DVrH3anERNhtrK4koDzQWBPyZG/w0EDmpoRZVXapZnrJPjNtKLaPFjOoK/QTboETCSw4U34KcymyU4brsl84e4O0iXp4zbGdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KiNrSMvDilswwrC9HHMEItA7+hFUsxEwu/4NEGIRso=;
 b=LeHjCXHK9gFP2Py/5J6UqXGEVLzgdWzbKw1Q0hZILT0Jk9tj8cd8xilpc6wmp57YXpeWcmnuAaxTROL5ZzGssxfb/XJoEuIWIbPDzLmC1nZgNiM7oNfOa45HB4njM2Sc7AZcoyRihFSuWMIMyRn3ePIX4gKwECt2Z00n3aEvch3R2r4IlSnsnDvGz3sec9lPNggxfP111arXbkNb1T6+g1o6NCHwx1xXDlkPdv6wL3UodImxrK/JwYgsbO/lWHR5Mtye3TCjlV5UW6o/OpLxAtN4bwWyGd8O+JeSqJA8HL2rFWMNCi2djDLBdnBB6sDK6kvf//HTNIzm8JVHUOu9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KiNrSMvDilswwrC9HHMEItA7+hFUsxEwu/4NEGIRso=;
 b=j8tmetsybshj3wxfy2vonnBQ1TYxngFKDS2KuHBpvQlbBUuiabwotpb6BsmYr/pdAEonl78GQaYaUosV8vQBM89J1phkRSzWIoXqn6ISwzas7caNryju5H1ENYnofAj7Ls/ikgtHUTsz3z/N3gdXSJa7OOsUlsnqo/VWQdcoNpw=
Received: from SJ0PR03CA0295.namprd03.prod.outlook.com (2603:10b6:a03:39e::30)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 16:29:27 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f6) by SJ0PR03CA0295.outlook.office365.com
 (2603:10b6:a03:39e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.31 via Frontend Transport; Tue,
 13 May 2025 16:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.1 via Frontend Transport; Tue, 13 May 2025 16:29:26 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 May 2025 11:29:25 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
	<ruijing.dong@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after written for VCN v4.0.5
Date: Tue, 13 May 2025 12:29:11 -0400
Message-ID: <20250513162912.634716-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: a157f931-e890-4f3d-7a16-08dd923b542b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yMIMepvzYvEDgrMs6rAxVCt54kaN1AZa2/05LngmeY3XtuZYCz6ZzJfNWwXk?=
 =?us-ascii?Q?dsMhpzMcbAG628Ef9kBXRS21q14A4d2OB2EHB4Oupio5crAe1WQe1RywNYb7?=
 =?us-ascii?Q?qT+xW2USwYTkH4dZpsRgyQOb/h37hxhgxv7Rrx7b/lSP6D4XKpKbfmdADjL5?=
 =?us-ascii?Q?lT4gFvy7gWE0h+jZri3XpciafbA8Drurmm2NNZgLJiB3Rupd5U5xZiv9yMM4?=
 =?us-ascii?Q?hAbIUSBwapFu7ncfMtdoZCb/pCBCOjIkNHTMrjUtiIBMrT9E+MyHaOaDdyyV?=
 =?us-ascii?Q?w6Aeqw61q6Sao3PhqVeudDvNO2WhN/KiZmpPAE5ESLKI9Ru1CxKOzjVNMbmj?=
 =?us-ascii?Q?Wj1iuQFsC4B9U993UHALB7RIlOeJNEoqV5kiHy3/vusxw8Yi6B3IllsG+v4k?=
 =?us-ascii?Q?gbbClEKAW58sQZNcgGcf/Wr25FsNeLH5xwAMcx/p4yfUhMgItMfI5LLsh5Mv?=
 =?us-ascii?Q?DImx5NvEncYmnVbYrTVC/7Hfw1MaAjVp6oiPIA1XuLsq6NMniHzvM9GerfRS?=
 =?us-ascii?Q?lH1qiQ+3UM7OYV5IOiIIvN02+hLIk5U6U8OOU62D3MScibkEktodVBP6Hgzk?=
 =?us-ascii?Q?zIgjVVDYMzirGJqwmCSrN/0ooZRphuuBRuz9DyGG/5xX5u/ivKeB3jD2E6rd?=
 =?us-ascii?Q?yA/ruz3iuYCdE31t/S5W1n7w6R6k5nGiHJTtQ0QJHkQaekKEv0JiTi8oRsDC?=
 =?us-ascii?Q?AxydGECByV5L3wA5JqKP3Ms/JgcdcrGCB5bdQZt0lv6S+urP8dX2tG81LreM?=
 =?us-ascii?Q?euvYle9ip8kjoMCwcqGIR15gEjVp320/BKMMDPAXU+cG8BSmsoSnrPzNmgfi?=
 =?us-ascii?Q?DjRGhWqX3yWo1/C2//GHuVtl6EoM+LDgF+LXU5gV/IpAtoaXGSXZqLzjXNJh?=
 =?us-ascii?Q?DV4LMeKrMdpzhNb3rbZickbOiAaRWElTQXgPHmQC90PwzqxxrWSdCwYXHGrL?=
 =?us-ascii?Q?bHqHhPbxqw+Kufdl8fyZzrTsCpbOcfewV/rBdu6SaUZhtx5QRIULFDVoq+HF?=
 =?us-ascii?Q?9Of+Add2sjfYYcS7WJuB/gBQkJxD9XJXJ9rIaXi77yMMOeRp6MV3eEztjb11?=
 =?us-ascii?Q?wOY234CUdA6wQGsQy8+luyG37/kztS2u1YhDKrteeoXdlXbfI6sE0i/oAkya?=
 =?us-ascii?Q?u1hsfMAPqpp0as/XQgF+SRftfPYJiwI9Xpfcbihef1Nsf4vAnPHEswr26uuh?=
 =?us-ascii?Q?bjkUZCZEhETDeFsUwMHW7X+ptaLAWQEEsCnyXQ9Rb+DDl8WIfpmXnuH3EKdk?=
 =?us-ascii?Q?lFWMv2vzlnOgKz8q9NwJatZcmE2djMezqKQG7aeQ3jb3n5M8ScAnb4V7DvFa?=
 =?us-ascii?Q?6j27Ap+iXsEoX3FXe0T0vUaiiKSkgQltzqUPryjZP04QPrjptFeHP7tJmytv?=
 =?us-ascii?Q?TI7t+LNeMKPu6AOodYTagkujjo6HJnjFOfV9113pg8hoLF98Bu8cKWhzMgTH?=
 =?us-ascii?Q?7/urMONZwnP4unk1KZyMF7+m1Aqf6xyABHlP3Zb/a8+y2CgHW3bwWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 16:29:26.8111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a157f931-e890-4f3d-7a16-08dd923b542b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958

On VCN v4.0.5 there is a race condition where the WPTR is not
updated after starting from idle when doorbell is used. The read-back
of regVCN_RB1_DB_CTRL register after written is to ensure the
doorbell_index is updated before it can work properly.

Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ed00d35039c1..d6be8b05d7a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1033,6 +1033,8 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
 
 	return 0;
 }
@@ -1195,6 +1197,8 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
 		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		     VCN_RB1_DB_CTRL__EN_MASK);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
 
 	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
 	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-- 
2.49.0


