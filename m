Return-Path: <stable+bounces-81529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A209940C3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D71D1C2074B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB516FF26;
	Tue,  8 Oct 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJkQTTUL"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135F1791ED;
	Tue,  8 Oct 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372739; cv=fail; b=pNLlnyFjyPt/BMOZHczPHub4M0MPmhDefaY0c2ah1BeQsKap+HK3+zH2Y5sRQFUdetelKnYXdMTIsQC8oO9kRm7a8lsx/5PCecLosTW1lLrAG8394tSridQy7rcwRnnhNeHtWznx0Gvul+XHhkfU9oeij4iQCkHrFJs7MtCdEk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372739; c=relaxed/simple;
	bh=QJit5NpGArFmDBupUByyAEu5KpXHu7yf4ALf+ON50kw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jy7w7igbDrWyLuh4z0quRMN8p3hOaJXIwuPh/61/d/A+hwnxAdPOavkPX4dd1Ir0H1koQZzl/9S+Ou2dx1H4V5cK7lRBCpcjHBZ0P1E6zRP42wXGQoooVBW5bf1iatjXjqaxrUcHsJMjdL3UAm4Zc/zfq5rMjJyK6d6gCz81sTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VJkQTTUL; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDwxYpfIlH9Wgyn8clcA8G44owWjfKvlexvu2sowDPHv54MIWrQG1kKFQKNfmW+BwDIolXZLEySwYCR6DMddo0Xblh4N2/tKZOlkaUxkGK+cGnkMFeyz4DBlciOrdhF8UCLeE6zu1ZeAH2wevdovIhPCtcQmFmoocKB60Q3FPdQoOiuNdLDzt4Ci+w/Y9kRQQE9x+8z60dQnQhNVy3W+yBlbCflVvgVE6HIA1q3zLukRMcM8uHnHIUiqUtXIA96nftNIFOdOflXVhxOBZsGHdAfjQ1zJhL6Vn5T+PBX2iSz1jlOKYJd3YWqWcFkN5IDZedoEkqDosLk0A7d2lwmI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIrTafYvUs/SQVSBu1JFq2xnjjOVF1j2qPafoBaktKY=;
 b=gC5hLYCs9F2+s3NTxSUiUro0ktSKsg7L6Dl0ak4xEfVt/oHtyZd+C90kvzgxrm+UCfx5S78/zoPfTWSkw2psU/qanfaRoAZoEs0DIbE42IW1BoRJw5LYuOzQn82KDI8m2XO2+EJBbluIXunTWW1ufvAeSPdO2GYVvScSiUd/zYSIDEcALsNhV3nPl//xZneh8c5+d5/8Z8iKmhk8tII1MwbJxX2j4UVm1/WbshvKE9FJzhwoTno+Rm7TGw3bjE/+pbkxEsC7ovrzeXW47b+1VQ1FdIjlmU46hiNvDEaTmZrBJSmCrF9GceJWMzj0f6SfUNCTjQkTbwdCoypOJayLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIrTafYvUs/SQVSBu1JFq2xnjjOVF1j2qPafoBaktKY=;
 b=VJkQTTULy1qJ2bUEzDM4scrZ/roAHCigaVNFicL2kJkIGtKPWdP9zdu7xnJ6IuEXTT5Gyc1YkgwoYlGxW+wijrcwkvnKLmJ7Ihwkwr+OS46Aor+tGCELraUh9HFSKr3f9PXGtOcgxI/b0krX/klizYwBmhpnTKdXGrU3BQVLLzZdrDhQ5JprrEaABY4Ea/HiHnjl4DBKil5Rvi5dwIxLwPo5KplUB3MFLeQ3rvQ4ZDWcLSP7h4Uge0GPJ+v9gqWMS29Id7yoERaINOn0OvY68HJaJfTaw3x5CNUbYNYYY8PIXV+eq9ZHxVTHa7yQel0lzyc90r2xQWKmf06tz7d5vg==
Received: from BL1PR13CA0112.namprd13.prod.outlook.com (2603:10b6:208:2b9::27)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 07:32:14 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2b9:cafe::2e) by BL1PR13CA0112.outlook.office365.com
 (2603:10b6:208:2b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 07:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 07:32:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 00:32:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 8 Oct 2024 00:32:01 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 00:31:58 -0700
From: Yonatan Maman <ymaman@nvidia.com>
To: <kherbst@redhat.com>, <lyude@redhat.com>, <dakr@redhat.com>,
	<airlied@gmail.com>, <daniel@ffwll.ch>, <bskeggs@nvidia.com>,
	<jglisse@redhat.com>, <dri-devel@lists.freedesktop.org>,
	<nouveau@lists.freedesktop.org>
CC: Yonatan Maman <Ymaman@Nvidia.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 0/2] drm/nouveau/dmem: Fix Vulnerability and Device Channels configuration
Date: Tue, 8 Oct 2024 10:31:01 +0300
Message-ID: <20241008073103.987926-1-ymaman@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0d09a8-58cf-499c-4a7b-08dce76b5472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W8Az60HKZA8LGJyYLC9WlEX1xICB5nrpsiqkvqQ4ktoV30ONZ9bnSiBqhP4E?=
 =?us-ascii?Q?jTg6SIofNWgp5mUVnPEjMWSMTgw7ya53SVhJBkXNEfhzYwnR2p1GX9xuxxeH?=
 =?us-ascii?Q?JDfC8HWGidx4jXozX9ZvQ9Ot/B/uQWUF3HZ9BtvMFAo46RBZEbsCUPOsHpBF?=
 =?us-ascii?Q?wsER3sJzuFXfFlbhPFmWJPWjD7FaObC0TezAGodroNvk1kg8yc3WAMtaVJrl?=
 =?us-ascii?Q?HsBaG/5TLmuHwZnEvKGp1YvrMsz/Zm503mRnzmmPymNi8eSNBSb+uYMh0AEI?=
 =?us-ascii?Q?HYfmPukHaZVMAG3vP3rSm4ibvWcnrWsTMv6bT587NjGgTVF4qvaKELYjsfEY?=
 =?us-ascii?Q?98bU2IHUdrdtYwZ/AkrowLSpnPJs/pmN1zOHzg0w13IAKQRmf+odN5Wrkq9Z?=
 =?us-ascii?Q?H8AdKu0HoCksJ0nr1iv43nc56U9D/QbAQal4GkYxpsd1ZhD4RaHBv2dXfwZ6?=
 =?us-ascii?Q?0CDdUqHqvKSomB2Yz86CZyjqrggbFcXCixk7mOKvb7svN6ZRmFl1jALyQdY/?=
 =?us-ascii?Q?IyVRVJZAGQHNxk+fZq3O4JB4GymJov0PuEu1otp8uiaIamHitaA5+YH15+3I?=
 =?us-ascii?Q?zV13+N3uESsbys8YhW4NeU4NHE8LvTwudUM3uKCQWl3rm1fizNkSs7i+KIUc?=
 =?us-ascii?Q?FXUjZk0rmph4zSXZLJv7epW7gk1pljqPJzw2rK+9QYMLDaGJM49LbeAtsyq5?=
 =?us-ascii?Q?9b7SjMUmmiT+W9N0kcKWQntpaeBecHBmMNKo85CtBAK44b492mu7RRV94W5r?=
 =?us-ascii?Q?qwFgvDL6AfSt8IPU9dok7NhSE6M2Bw1BXR47FHElILrjyMbwSg56Roj40aA8?=
 =?us-ascii?Q?bSH8b1DduZgMh/OMYOqXW/qMv6FC8+OgT6VV8sFiyI34HY4fAs/MQi2aQfKb?=
 =?us-ascii?Q?j1rxjvbJ4yjrx9cyiiP44pTFVBY1tBUn7o0Q1juACaRq+KykfJvcuSd0367m?=
 =?us-ascii?Q?cyVV8eIfYmxwfH/fmuALjDcBD9jJh7kE/eA4nqz9rFFDSpbnDNv7s8w1z2AF?=
 =?us-ascii?Q?ar10FqZr5hTjyCHHpx0WwYP/h9IfgVWtmku8VMeSrAiv/p7McmaQb9qO5bo9?=
 =?us-ascii?Q?//VpCrQS1J7yJLJ+k8IePjLfQ61c0kL7QDvHubypm4Y4mHB2KwqvwwFmnZ0y?=
 =?us-ascii?Q?0vlC4+ANvodsB7vMnC+GcHwY39nopJshRP2ZnUy/AL4hhsz0b0oVsZxm4ZZZ?=
 =?us-ascii?Q?EZdnZHPvqjcOQ78YzDE6e3vo4ZMKKtKjs/+ZR+B6UK9L1NN/5hqryhs5ODrk?=
 =?us-ascii?Q?EyAigbAZ3smdyj7Je6ra9etghAtofo/o+gOH8zBLJos0MymwlrwkBOmpsf19?=
 =?us-ascii?Q?S2MkJ40IKimDevU4Ipv7xdmsvfZ88esnGKdO0wCAMfOXlEZqQq/JeN3/LkA6?=
 =?us-ascii?Q?3TcdqL44SbjMmE0C1ecCvVhYqnz0?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:32:14.2186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0d09a8-58cf-499c-4a7b-08dce76b5472
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

From: Yonatan Maman <Ymaman@Nvidia.com>

This patch series addresses two critical issues in the Nouveau driver
related to device channels, error handling, and sensitive data leaks.

- Vulnerability in migrate_to_ram: The migrate_to_ram function might
  return a dirty HIGH_USER page when a copy push command (FW channel)
  fails, potentially exposing sensitive data and posing a security
  risk. To mitigate this, the patch ensures the allocation of a non-dirty
  (zero) page for the destination, preventing the return of a dirty page
  and enhancing driver security in case of failure.

- Privileged Error in Copy Engine Channel: An error was observed when
  the nouveau_dmem_copy_one function is executed, leading to a Host Copy
  Engine Privileged error on channel 1. The patch resolves this by
  adjusting the Copy Engine channel configuration to permit privileged
  push commands, resolving the error.

Changes since V2:
- Fixed version according to Danilo Krummrich's comments.


Yonatan Maman (2):
  nouveau/dmem: Fix privileged error in copy engine channel
  nouveau/dmem: Fix vulnerability in migrate_to_ram upon copy error

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


