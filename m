Return-Path: <stable+bounces-89832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1709BCE05
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEF41C21159
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007E01D5168;
	Tue,  5 Nov 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="fT0tWxI4"
X-Original-To: stable@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021117.outbound.protection.outlook.com [52.101.129.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAFD1D79B6
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813730; cv=fail; b=jsN57rSD8FLEdZaRq3N4dA9PXQTpxeh3f/y43qYHi1VK/NGc8WnBdJojin7CEc5yMk40Sc0S5gVKpK+B6zt4anXbqvCYs+Md5/l4tQPVmLB//KBQz0iIjgb0Jsw7+yDPG06xR+kYRlXsSH/gUOw7WebhczXBwcOHQntiKA4tX/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813730; c=relaxed/simple;
	bh=2M2iyTGrlLynXA+aviYjNkiBBa/NXEm36sUyb6FtNis=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BFq3OJ9+OzgfnlBX34VZrkAewMxBItid/WlcfQ0XgbHeJvFtE0qWyavjySYDjBgJy83Nubvn6tyMQWMyjFAEZ/1kfRWAfhuDgjd0WYPh4HW0U37NxoaafY1qdvBAoxsLM5wVYjmxtVhEYf5F9sDdcA49ODpbfxRpMryzC9HAluQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=fT0tWxI4; arc=fail smtp.client-ip=52.101.129.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyZa/vzeaTR6ZCLefTjcmyd/gAL8+9aIFP2WBvWuhFrKu36lMNJoKTIRbtYmtvdLeQgxs6UJdrlqP92AOkb3spsyzFfxRGLsjZPiXp4ceMYQ5fQERJ6h1v3cVaxz9LwRvUA94mQf24jfSOrCzXAEuqdkVo8hp7zxlXk/JsXyEq7GSIatSYKcYv6NwStd3A+LxzxhHUuGHQDFrGk3jBNZ1nz9NU8dQ0hDaie/NVwBU7KoVb+jC3zybCoMQDij/iQJRzKmDxfPlBgkFPeEqdfcOl/AUO3rtQeIuz4kc6hsAcmtZywXhYLRV2/DfHAsoq5eqpU8kQwSdfvydvhGHeN1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKwrnr/NfCllW6uKchKWYgcvwLzCrCCJyUvVyN+NjdY=;
 b=yxdAHW7jGrNnqP74n3HmYM7EUyiYv2HdngHGH3B3tyhj6WL7eXRc5V1fKPYHime9hmE2K6oanoQSxJjZPeWow6Ajg2sh1M/7B6YQLHcbkg1iD84A6jaJ66nB+eTiawMierS+c+SmRe1AV3CXJAqJEyrQyRet5xdmDSo6p+dqgBPO9atThWQcY1QrY679kiJtCwZD8+c8TwlLWjgVBftEtPzAEscU0CKcNqKL2v4RzYmpcKSf32ElthUXbglP4jufhEdcc0jCLORBjR5HMHIUaQjN19BRLENRacAFXlomXBiXAwJxugkKiRyhuwlaDDvcfCtXQcPOL8qmd8LSNvQq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKwrnr/NfCllW6uKchKWYgcvwLzCrCCJyUvVyN+NjdY=;
 b=fT0tWxI4l6sZrhMaUAki3MTSre0qOMGSnzNcAT4pLNjQgNlkhEAzQrXr/YA0QvOXg8ehd+UrCJ8e4GSAUXjbz/gtRpdru+T7JPJOodgxWAqxmd3OMnuBeP9zKP1itItIsJIujJIP7Di3yiVd9LIpKGiNpnRte1IRT5JdGexbyr3CvQdJDpGYfknP5ibFymjRAjy4RkCqEtgq/q82Hq6znf8VzTiRs/m8kn6XtxJPiT2ZG8Rekz82PycGY6sneJatRmfZblgzYqYkGA4nYHt7XHMg5xUNris4a8RHN2H7LatHAfzNfZWoQQGfpsH2CoyCcFvbdoRuZsaxhYURByqcKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12)
 by TYSPR06MB6501.apcprd06.prod.outlook.com (2603:1096:400:47d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.16; Tue, 5 Nov
 2024 13:35:21 +0000
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd]) by SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd%4]) with mapi id 15.20.8137.014; Tue, 5 Nov 2024
 13:35:21 +0000
From: Xiaoguang Wang <lege.wang@jaguarmicro.com>
To: virtualization@lists.linux.dev
Cc: stable@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	Xiaoguang Wang <lege.wang@jaguarmicro.com>,
	Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH V3] vp_vdpa: fix id_table array not null terminated error
Date: Tue,  5 Nov 2024 21:35:18 +0800
Message-ID: <20241105133518.1494-1-lege.wang@jaguarmicro.com>
X-Mailer: git-send-email 2.43.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::13) To SI2PR06MB5385.apcprd06.prod.outlook.com
 (2603:1096:4:1ec::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5385:EE_|TYSPR06MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf4c1fd-abc9-4e25-cff8-08dcfd9eb1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HumfPV6w7Mb3CKNEmfMUI2YH728FVxpLKsm5vsgQBzIVSXtel/VfoXBwVmwB?=
 =?us-ascii?Q?BIfYN6H6BvbfAZOPlskg+LU5xmE24dL3Tb13Fby9Fxg0eW94snu2GNKkDRo3?=
 =?us-ascii?Q?d5GOuFBBPrVKAnykgJmTNY9qVi5bvqvVAc0POz/17xcvM+mSAgnsUpx86qJw?=
 =?us-ascii?Q?CZxSB083lABbSAx1McdLZuIvdfMj61Bs4HyQHJP5Ui0nJi6RXo2zNXtHk0Km?=
 =?us-ascii?Q?4sO9kToecDkaOBrmhmAk5v5F6T5CtV9/4O7WuCnolPpwy5/kZH4x76Cr8tZX?=
 =?us-ascii?Q?bQYOn8LnQhvgiSv+7I7164S5aTyeQgQM4apnsDCVOh7pL2CRfFlU3zzSDq6E?=
 =?us-ascii?Q?EGv4d90RTD0odWcTJr1UeYYfc1NDJN6NYsGtld3X0wkzaaXtO4zEhlJ72FeJ?=
 =?us-ascii?Q?FsxjZsXsC7XrfgH/N2hXvMQ/mfrgcFq/W8+g4Py0NGDY6fgr2FZsMLBvMcPm?=
 =?us-ascii?Q?vqIBZO5l55hs1Q1p4es3mSv2x0JVW7QrTuD1jMP8Y+Ry1m+QGW9ZD65i1nLR?=
 =?us-ascii?Q?U8RaskSA5gL4taPRLBK6wpnwniYlN73z5P/ojqqOu9IWQwHxEFwy2wj4IQBM?=
 =?us-ascii?Q?v8Z0AVZiA7x3PaEo7PcHsyJVLY0uHiiOboV8TITHFxmYlFc8C27Ow0TETk2G?=
 =?us-ascii?Q?F+kUQM2hczL33oJNn2dgDPoI4qHlPdp94bcy+fkwnLqEpMfgVTm6xulHLrfS?=
 =?us-ascii?Q?b1zW4348KgmAu+5cUwrs5DLhKMosRaX0Sk36Vw0KWgeqNc3/Z2ksWbFJyjK4?=
 =?us-ascii?Q?ai/U9O5KehQkrAjij02KCbOsbJfSWX1ITT4TrRg/6v3FThr19sV6KJxXf9ET?=
 =?us-ascii?Q?+fgO678nyGo33LSnAVJQtS4Jw+mIBo4AqcwSfTXwetU2urQHweR1le8izDUe?=
 =?us-ascii?Q?R2FX42BYlo0GtwPTDWXZY9sEs6j61Ul3AWz6/quoiJYbW/5t0BG5/S68c+33?=
 =?us-ascii?Q?h0e3KLyFgqUQ3IDeneul0I0dayxluhR1IkDnexgWoOYJzn7mDcoZLjprMrlv?=
 =?us-ascii?Q?58ed5SfpsdeL8IZAufNCKnNgubYaPtWNZ/iMcCsJdy6R4Prh9b+GUOcXLk0r?=
 =?us-ascii?Q?2m0toRYTU1vuccp3nadauhnJpTLG6JAyhObavtmkX4sTIGH1ydlW8paA57yr?=
 =?us-ascii?Q?FKrq7ES84RVWcCK+N9NIV/7JXF9xpWeQ2ovhOPgA9X1hN+gL7fPXl36vtkoA?=
 =?us-ascii?Q?anIZX1HIrAmQ5zOBLtHCp7pJSgLJjjLU16Q5IiAV5HxbljWMqYqeTRxUB/h+?=
 =?us-ascii?Q?xCRG6rxX7dYyO97XjH4dZJBzEvdS7InoTPCN/MZoca0hfvS9ALx4Hd2lLhTg?=
 =?us-ascii?Q?hCl7y8tFpWtjE9kvRm86xUw96Lp6QxOU7juCs2cZvAQkmC6NqrKFCI/c4Npf?=
 =?us-ascii?Q?uUB6EQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5385.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7PP5iuSXwCWn8WQhvgTBij9MUSgFwYSov6sCRt8qxucjjXCawMa0XaiPH9j?=
 =?us-ascii?Q?G3LAddKR0Rm04G9nFeYJLGYwwcReDxRi9Np3E++BounG9n7UDoX7l2k1KuZI?=
 =?us-ascii?Q?HidplxMGCSJpMQWrw1VLTR0JBAc7o/zDV0DCAz+GO8VFQY0kiqP1RGnxSgey?=
 =?us-ascii?Q?T/VgySj91SOFUCNIzX9FKU1tRCfF9XmVVb8KpSU/QEvWN+T5A3v7p6UyNVhL?=
 =?us-ascii?Q?W7TN7BUn8HaxR7bDbjLigbfbMOiJ4lUX3UpdIA+P7YcCEzjdTBgsYj0JcPka?=
 =?us-ascii?Q?CUoAzpwB5dH8r8cISc5lvbzZTa+2ccS3ZvZBIk05XRLGn34F6VXJQirY3EQG?=
 =?us-ascii?Q?EFUHHT0AcLHshLDqx751LreIzdVAV0z216/+oUcDwtS3mFvZ6tb1UCVvVkRX?=
 =?us-ascii?Q?Jd+i0yDcABFiu6ZCICWCO44HdL2XR/ksE/Jt3CXoDKfo4dMqmFLpLlKSHM5J?=
 =?us-ascii?Q?ReFL/CzBH5vX9qMAbnSOHFRopNxoXfOsN7X2r/NycthKJ+VkxwHNWQStiPkl?=
 =?us-ascii?Q?I2OdO2gZrJmqKkgSLueE+wlEaVs8JcBQxdguUp8fvO2znQM/ByPupOptY4fn?=
 =?us-ascii?Q?eoS+i3BPE1UNvnVrFNXpdcFAX96/PfVD6m7sKiHkyzJNEQ9Iqb1bVmAmFsEl?=
 =?us-ascii?Q?6oZ+GGXTvliVYzNhTv6OSX1bmIrEaEhwY+VGHSZz+3qMNxVZAgv5AY9rHZZk?=
 =?us-ascii?Q?z3O1ECKund7XO7TtjQrP6vdtGzbODllPJgt5xug7KsbMLfJ1pnB8io2A5xnY?=
 =?us-ascii?Q?nFLSRPm11+jC5VTjIGRXSiHaiWg9CrVKkVY5NX8pcpRRm1nHWbMqDfUxheYn?=
 =?us-ascii?Q?pLeY/2kCN6l4a5nYmev0IBaTqfQ7IUL+9jNZqctWzuDvDr/bqLryjamHPhVn?=
 =?us-ascii?Q?1apRadACdxviuib2V2d3EVEqkzc9Tl/AK5sINEqmLUNCgW0jog272ndkfY1O?=
 =?us-ascii?Q?/+OVNOAm8GH9tOvu8lwRSoSW7lRLvDvN2HZ+p9zeQMUp6tBl42kLd4eLHOca?=
 =?us-ascii?Q?lIpxNZXPxl+dgKe2oU0jLJ6Iz60eI4Q5XIXI49hikgVa3SyV9RzZfUclsvTg?=
 =?us-ascii?Q?x1Huv6qYR0mPQvQihiKFor6uslgKH1MdHqrCdFE6j0YrfIiIlbGo4Qe56Hfi?=
 =?us-ascii?Q?6gYWHrXhyQ+alBzykRkoaFM3hKXhfMBUBcTMMuS/z7Dm3fGAHzlAjcQh7g6m?=
 =?us-ascii?Q?MRfdZtOUGpBiLHxlSJMdEdn/pQhtfE4MjSX7S4ZU+v126g9xoU9sJvFqizbl?=
 =?us-ascii?Q?gka+IT/b2ybs7XdlGSij/FYcUK2ZlsqGUvIeRtmUsTcodNVirVDGlsKpMSjQ?=
 =?us-ascii?Q?igKaizltrnpHkqzjytWT+2a9mM+uDlHVeOKPp/sZoUvxmMa3+u99B7oQF4Ze?=
 =?us-ascii?Q?z5CQm4jVjkJgg4o+iaXlQaykahLTJTPo4AJKHW5qlHe/govOa5opn+5xc2ri?=
 =?us-ascii?Q?KipQKKw2oEtKZN/gUUvVW7degTWYbCSrJpGBedpCY2P0rBz/ZLy0Id6IMj7Q?=
 =?us-ascii?Q?sOInV63eoe3gXl+K/8l6HhqdUuvuwKt0ZiK6pG8tBUh+zx3N9SB5baObEw8n?=
 =?us-ascii?Q?mG7SH6BkB7xlMiXHaAklMFxsc3frH8veO1Mmvzq+HZGwxT99ozaJBgSYaFWL?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf4c1fd-abc9-4e25-cff8-08dcfd9eb1a9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5385.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 13:35:21.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5Rnj6c5NKKqR7fSxSvbIYDkQPcM9eNxjw1cVpkuZO1m+fx/27NQ/a4/royhX9C98fO8x/lm+S/blXoTivwEQAnocHwuiojIdBmWQ+BEFk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6501

Allocate one extra virtio_device_id as null terminator, otherwise
vdpa_mgmtdev_get_classes() may iterate multiple times and visit
undefined memory.

Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
Cc: stable@vger.kernel.org
Suggested-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
---
V3:
 Use array assignment style for mdev_id.
V2:
  Use kcalloc() api.
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index ac4ab22f7d8b..16380764275e 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -612,7 +612,11 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto mdev_err;
 	}
 
-	mdev_id = kzalloc(sizeof(struct virtio_device_id), GFP_KERNEL);
+	/*
+	 * id_table should be a null terminated array, so allocate one additional
+	 * entry here, see vdpa_mgmtdev_get_classes().
+	 */
+	mdev_id = kcalloc(2, sizeof(struct virtio_device_id), GFP_KERNEL);
 	if (!mdev_id) {
 		err = -ENOMEM;
 		goto mdev_id_err;
@@ -632,8 +636,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto probe_err;
 	}
 
-	mdev_id->device = mdev->id.device;
-	mdev_id->vendor = mdev->id.vendor;
+	mdev_id[0].device = mdev->id.device;
+	mdev_id[0].vendor = mdev->id.vendor;
 	mgtdev->id_table = mdev_id;
 	mgtdev->max_supported_vqs = vp_modern_get_num_queues(mdev);
 	mgtdev->supported_features = vp_modern_get_features(mdev);
-- 
2.40.1


