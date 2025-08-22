Return-Path: <stable+bounces-172341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB3AB312BB
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C811CE5EE0
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C1B27E1B1;
	Fri, 22 Aug 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dpDJgTEK"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D3214232
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854341; cv=fail; b=ViJ7KZX8epMMFciqCReW9NP9hdUnwbUM1iumc3ziySMrtGTJJs8SF8Q+WfESZkuPhs1N3dnnk2ZocAUNhaYFTtLI1zUC6bWMEFvIbycd7HCxx6F9RTeEBnfvjs5oM69ZVB2N8/YCEa6eDFKxtnwB826+6tBeSU9f1sixKmMyb1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854341; c=relaxed/simple;
	bh=2RNjCs/PMM+HSA0vCwad3dR1SaYRAuNIdeSTeeV+J7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HT2tq5LgywDqsvGfqtw6Bep+H0sEq6b1zj0yTGq44hah+HxOCEP/MR8ZlblJCu7oJ53hNjSx5wziOkkXsCtQ4MOSMHO2Z8I9hM6ESGXuJm1Q7eBCeoF1D4563Y+L+04CsLBXS87/o8VnPVQwm3jIZzQnhD4QD2OLRQpTiJ9CtSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dpDJgTEK; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DecNLoJibIBh0mO2vrFvo79B2by8enISFa8qsib3pHhJSZhtgvO8sub14WzjPTSaNLh58zWFmuVfYAqxlwhnGF81RSrHxgxSp2AEBuXmTCXRRci80/aCpWPBI/K/fATHkJlk58VirbKg8M/GCHDUIXlKPTWN+zzOzuIwTjfG8p7fXteolbL9miFMemDG1KulZERMBS+2AqJInvaRgYQ6oXhVMGzBonmLOrM4eGG6aJrk0VrdjKF6/p1Vj+h1e5nrMXWWAlRer/l2t4ZVl35NLGTVS0rwdg125V3D3LnHOYZl+haUMQhLmqxmhUGRjuVj7L3neq2jh8U0gfex/4Yg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LAU185cNwK7ZkKz1x7gpJix5CZ864DMYCU/8ho/lEw=;
 b=WeGPAruOgTj5Ro+bNn0b/DtjWdxRip/GNDfNMAnL+1EKPi4B9M9JS4n/Cn88bqmT3dXicpSeBOclUK9T70kSx2V5BZd69qoYC2kIWU0Mr2lQmdXqwhDyWX/a8Mr/CfilYI8xoh42+YOVhxdOBxCV1ts9VkWKKmAv/8guMm9Jvc9iX/8Khi/ZTJJXtoke05nQx7jPIwxlq8wrEKckbnlvljFJwjfQd626zch7S0k7ifcQEB4kjyVxk3GcJ/NBlKWnuq9cV6MNoUF28dYXuR7GL3X317joexqINMGC00TWZGDaOgJv+JTE1Up+FwIvRYxWD4tDs6qZ37WaRH2+BWmMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LAU185cNwK7ZkKz1x7gpJix5CZ864DMYCU/8ho/lEw=;
 b=dpDJgTEKmY3YJ1DeDMWEKozWZvacw/5/h7tvBzipZTrTyZx0rbPsHet01zs0V8wjVW5yX01W4++yHdNayLKdRjgcSK6uRV2AXT4E9sPbwEUjIOh5HWMEVVOKzzIMG5UEuxPp1TO0eFlFroWt6ZhdHa982CVyeQi65J94wp2mgSoiDsH6M4t7pF0yIBI0wq8kPYBlsDjHYzQIsVH9mTBwWzHxhWi3pMZfAREUlqWqF95riEXoyj4L7jWTwxaLH07iZZ87gA2xbpekVAnF24LIlVkGiVL7ldquQCFRuoragYx0GT/+HF126Uz38+6in9dnmmCQ44veCQpVC0Fdw0zZwg==
Received: from BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 09:18:54 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::b0) by BYAPR08CA0051.outlook.office365.com
 (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 09:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 09:18:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 02:18:45 -0700
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 22 Aug 2025 02:18:43 -0700
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtualization@lists.linux.dev>, <jasowang@redhat.com>
CC: <stefanha@redhat.com>, <pbonzini@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <stable@vger.kernel.org>,
	<mgurtovoy@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	<lirongqing@baidu.com>
Subject: [PATCH] Revert "virtio_pci: Support surprise removal of virtio pci device"
Date: Fri, 22 Aug 2025 12:17:06 +0300
Message-ID: <20250822091706.21170-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a1e7f1-886f-4c9e-dec5-08dde15ceaa5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GqRvJS1H6YaJ1/Ab8eX57AA5HvuMJ7E3GrAkSlcZuKaG1tcbDqur0gAS97gx?=
 =?us-ascii?Q?O2cn/odT0l5ltJWh1qWY2miD0Sw1ExC2ShTwj8Rj+Wvhn8Uyof43H2PTTNPy?=
 =?us-ascii?Q?wyv8EE678D4EvFCksbGVIJ3qS6U5nAue6EzZFFDfC+pvlL7WrLVCArihaqNe?=
 =?us-ascii?Q?0mq8/+xp2dRhcWsD3ulTp/933H4Twa3SD2nRpMDSp0Es+WctfQSKqaH2ipsI?=
 =?us-ascii?Q?ENyxOn5W3663kAiF0pNkwn6ySFHoGNDJTkowtXT0wGv06dXDrk3qvx8t4Zqy?=
 =?us-ascii?Q?9hAmO2WZyT47sZUj6j1hZAYJhIAbw+p3S5Zj7IPE8b3liJu5DnAx9z2Pw2i0?=
 =?us-ascii?Q?6F9J9pN+GTLsqL3jL3/Z42bdrxN9VmGxICTb6LhR46BwScp0SWlije0rQ0gc?=
 =?us-ascii?Q?8pXqAdcJt7LACgezapwaTf97I7hN7+XByydnoHhqqItxzgsPMB5/Sv3XBLCv?=
 =?us-ascii?Q?xi8nXh88T3QyayXhjbDKLh/LxncE1J+fdJbmKDaLZ5v3T4Jz5MThXJfXFxvZ?=
 =?us-ascii?Q?+Zq4XHPjp8RLND3EynXmI9ZLJEc93lHvSakKgJLtBYUhReWjjkfDI94Dcwz4?=
 =?us-ascii?Q?DB5l2Vso332HEB3FK0zPGh7PSBAj2IhKfLODZYVRmlQyr3rxCKJfcqoRAcI3?=
 =?us-ascii?Q?rBR66RIfhMmqrla3bzbgXdiG1Y4PSr2wNvykHK7KD3O2pWyMuNpjGnmdEdfL?=
 =?us-ascii?Q?6HwaInNoPTHThU0/UEm4OjTirIx5BcUp6gk4v4VAfnUtoK3vPi/bPtNEuMN/?=
 =?us-ascii?Q?xLp9T+TmdlCD60hfLj/eoOEkbvAvducQKodA2EXMO6ZiMH9Boze8WuUsypLm?=
 =?us-ascii?Q?HZtmkiytttY7PD/LIX2herMPq89u2krJidGd93xbiL7vQcLQQJo8148Eys4B?=
 =?us-ascii?Q?AoLa23/m9JKsBdSoMCvwA5j6UcIfKvDceJuMzFMKyJY2/uC58kVHotUL4r2l?=
 =?us-ascii?Q?EU+/ch0uIzl8XJQ1aQjvUKJCJOyJIi7zLGwm9dKe/KbAaVWPmiNiONRRe+fT?=
 =?us-ascii?Q?bxtiPvYy3yCNcuggyggz2MXG+XtQfR8RD38MFSb9C4bejPyzG5JML/QWNQ81?=
 =?us-ascii?Q?M87AM1p1TZUDTl1hBLmoJcIdLtolFL/XqHg5cSidaLhfWkcCxmIKpTTjgMyj?=
 =?us-ascii?Q?PJHZZ3gRJ2FKXgRUL/dB9CsHH6xKTEdhF0e1j1fGI+nMAvIM7rkqTJfY60xK?=
 =?us-ascii?Q?BsPSvcOMy3hnUJU9CzJfou+Ar/DACD5Lq1sLE15DhJpAbbA8XOs7fcFbmldx?=
 =?us-ascii?Q?/Nu2nvG2vpBagyZaCyvWpRMtg7Tu542yJR8slLXylJC2FTN1u6H2OwFC5R1l?=
 =?us-ascii?Q?s03c4H0z0mx7p2PEZPO7wZARFekU2EHzvgAfAmRDah8DrnpaYtN+wlw7E8v6?=
 =?us-ascii?Q?YAMF6fBlNm/aYnNFclsG31YToGLB3DV71J3k/nUYvDFeaIL0bnJsyDm6i95s?=
 =?us-ascii?Q?1amc0RmeZ2c2pdeXQuks4vSDygFn1zqyb59DgjjhfYyFh13YGSQlcQAzXFip?=
 =?us-ascii?Q?Lwgorhp2uM1pWHy/Z1Lh0T76VxsmVC9qa+VuaKcaz58XjA1miGwiCrgRwA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:18:54.6170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a1e7f1-886f-4c9e-dec5-08dde15ceaa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device").

Virtio drivers and PCI devices have never fully supported true
surprise (aka hot unplug) removal. Drivers historically continued
processing and waiting for pending I/O and even continued synchronous
device reset during surprise removal. Devices have also continued
completing I/Os, doing DMA and allowing device reset after surprise
removal to support such drivers.

Supporting it correctly would require a new device capability and
driver negotiation in the virtio specification to safely stop
I/O and free queue memory. Failure to do so either breaks all the
existing drivers with call trace listed in the commit or crashes the
host on continuing the DMA. Hence, until such specification and devices
are invented, restore the previous behavior of treating surprise
removal as graceful removal to avoid regressions and maintain system
stability same as before the
commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device").

As explained above, previous analysis of solving this only in driver
was incomplete and non-reliable at [1] and at [2]; Hence reverting commit
43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
is still the best stand to restore failures of virtio net and
block devices.

[1] https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6C638DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
[2] https://lore.kernel.org/virtualization/20250602024358.57114-1-parav@nvidia.com/

Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
Cc: stable@vger.kernel.org
Reported-by: lirongqing@baidu.com
Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d6d79af44569..dba5eb2eaff9 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 	struct device *dev = get_device(&vp_dev->vdev.dev);
 
-	/*
-	 * Device is marked broken on surprise removal so that virtio upper
-	 * layers can abort any ongoing operation.
-	 */
-	if (!pci_device_is_present(pci_dev))
-		virtio_break_device(&vp_dev->vdev);
-
 	pci_disable_sriov(pci_dev);
 
 	unregister_virtio_device(&vp_dev->vdev);
-- 
2.26.2


