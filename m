Return-Path: <stable+bounces-89389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657CE9B736A
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 05:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918B5B239E2
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 04:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419487F460;
	Thu, 31 Oct 2024 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="qeYnaxJO"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D83BBE2
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347537; cv=fail; b=rGQk07rBrjaDJewIosTi5Ii1OJK8M3epxeafxQIOrtCGwDJFH9XFKOqseftP0cIAAZEFEXh3Sdpmh6rBLCkTRrbszdc4qhB0JHqJR7eH65mCDJlpGYHag+e3ftmVDkmSmFAZM3g2hM/uJv16qtnB9kfZo75GYLwvAAepgSwozmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347537; c=relaxed/simple;
	bh=pqE8+2BxaA21n3+zXi8PFDkfEJkp5eAf5sXJSWr+AIY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XJs9l4toJueld+95KqZkMhzkMXu9vsO6AnuwWetkpL4Ll9SEmyOpzigLin5n45uQzS2DnBqYYDr2i4W6odKVTPdSzoSDC9dYXIxX3FD7d2vCAGD4sKy1BldQ+ZnwZDPaVQa/sH6Sc7NlUJOYBHpJYHaw3z1glt28glLOazuX1fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=qeYnaxJO; arc=fail smtp.client-ip=40.107.255.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G67x4YjxPG/iie5VhGKZQVQAhOOSUwkO/cBIIkFLGHutUAw7fXxck9hu3oy9At8qCTVncmID/zjxB8TAPAbnW6cdTcRPjnI0ES1qqIdoCEbRaNCfZIykW2Sc//sdhF1VKh8GCFs2xM2AzP3n1Te4QuVCFXH0Gs/Fge8k+TQBDcrjkaN6thq1lyHxIhRZAAKMvOc/mGAFFwFpSbs+wNWjAC0Ux//ird4sEvH8ohB57KL8LoOJd1MUSQjveDrxapx+6wrBXhVLebxv9RI7AK3+buaFcpArWu5yhg2yXh6b0w6QL1MLB25Jdd+xYRQ6wR1hV0Zv3IYOrqHZi1IbDnj0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwfYGKcZ3sdBSUr1SUXfP6bool/cXOybTNygpe88UEc=;
 b=WnS7HRQXTfOx/1t4Y9vIts9z631csxSHWRJTVpdmFLnm5jmhgC+FFDwEi7BZlalXb4xrXFabnpCFoDyq+M7uyaaFfDHmBSjc7StTyZCoFQ6yWMJ2uKW5hzcLZnHxKpqxXJQ3p8kCjkhb1rJ3hCTvsxaGlv2p8eDDgyxzeWUJkEHi0ivLfHm1cJOZDYfRb8xIhkTsigJRy2YRxA+pkhu9t8bx0hhXX/8GxHIuSfcLTDUjq7u8TIph3MF+NY1W1+2xt7wEHbjg0Rw8XSTh/KTKfa6g/wTXdgI1ASPOqkI4rxt/QflCVDnC8yZ6aH80YjMVnBK+gOaS0Ibnm9WYCXssoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwfYGKcZ3sdBSUr1SUXfP6bool/cXOybTNygpe88UEc=;
 b=qeYnaxJOjuCCmMqwNnCQMoxRNnl3+QB6ZhHSzwwPK3CfHyV8PJ8IzDfq25u5Mi/43BhghKduZ6me7P+avv1NLb54lc+wSXNDsxv8zjmOGWXDSK+ARSNq0+tS9GwB51AFDR5svJMAaawj8whffMuk2hvSAsFrEE/AyUQvTMFXqTXAAVqZw1SXtFJH8Ht8DzyC119/zonfAHeYORyE++H5tceM4H08V4gmJ8PcVq+1+80fNdWkCfu7XVlMqaByNpyVOaYCAxKM3vGg3NABPVeSqlkMffZCcFUjah0AoHnGQwi17y0iMlGHXYYbc4ylyXoK8AFfVYqJEi4/AweSf053Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12)
 by SI2PR06MB5018.apcprd06.prod.outlook.com (2603:1096:4:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 31 Oct
 2024 04:05:30 +0000
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd]) by SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd%4]) with mapi id 15.20.8137.008; Thu, 31 Oct 2024
 04:05:30 +0000
From: Xiaoguang Wang <lege.wang@jaguarmicro.com>
To: virtualization@lists.linux.dev
Cc: stable@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	Xiaoguang Wang <lege.wang@jaguarmicro.com>
Subject: [PATCH] vp_vdpa: fix id_table array not null terminated error
Date: Thu, 31 Oct 2024 12:05:14 +0800
Message-ID: <20241031040514.597-1-lege.wang@jaguarmicro.com>
X-Mailer: git-send-email 2.43.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::20) To SI2PR06MB5385.apcprd06.prod.outlook.com
 (2603:1096:4:1ec::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5385:EE_|SI2PR06MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dad4a8-c2e7-4594-5394-08dcf961427e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h/+szCwgIhH9bzC9YOHjryKpU8vPq9arOd5cGtih2ZXvwuPrbvM/ni8t+RJF?=
 =?us-ascii?Q?OnevA7zz6bwu61yYwU/Se2aOrYb/8NMYowfgyp/4gG/biYgHamc3M+k5dzZe?=
 =?us-ascii?Q?kz/7uimTP85+XjptOt1MdV6fLYefngtH6Jo74lWePwIedligqZjYhdekGLU+?=
 =?us-ascii?Q?oN3LfcpDsicVoeV3Z7utFopAOyA3KN4uuVnO/rbBUtWTFjZ3mL278kSmoQhO?=
 =?us-ascii?Q?5vxUpb24Z6cqoTqoRxkfcpSzcsZSxLDjU5T0KbnZcke6a1MWPO0xtOGOF4B3?=
 =?us-ascii?Q?uVmGDD1Hq+AhOwa1mm7kMYAl/tromvha0o/IiDCPt+eUL5r+mlsQssSa+mng?=
 =?us-ascii?Q?dfd46esfcyiop2r3zzHmFT+rGLl2JlerJn/VEd0ajSUAIhtmXuvEx2W0hHOK?=
 =?us-ascii?Q?+g/thzpg/xZ5gns9V7HrDMDNBklGb+VUaSkj4R3+/qcR+m6bYicSxLJ9HuJR?=
 =?us-ascii?Q?Rtx7LwB+8JJmyZj0t3qpodR8zqralR/ynUv/iwEZlBIrlpGpn9zbttiup+LQ?=
 =?us-ascii?Q?D+dOnnQtsTgmozErmmxgPAGR4MelRi7hFIY1R6QTp1OoCCxsGZ8E9zdF/Iud?=
 =?us-ascii?Q?PGUhVXIhN0SfLpUrTFIeAb6W/SBvx+VQFlvmIbAOOf3O4TPI7sTX1JKwYnCr?=
 =?us-ascii?Q?P3gVIjMYTJc57nMKg1jSoXBjz2/+p+AsBFKW3PFwxBHhya0xNYHR5p5vGHZb?=
 =?us-ascii?Q?abU3rPGGoV3pnN9YNQag1RmzLKV1GioIAAN4ecNM2E94+rx/MIM2PA7Za0Ez?=
 =?us-ascii?Q?sbBPq5kwA+PkyGeSaZuUNAfwFYTHWCMwh39nX8RJH8/HgNTZSW2EbZt+/Kb8?=
 =?us-ascii?Q?ZnNgxwSBXQVrOTv6nqGT/HbvX8Yk3FCsLekuruPPNJZ2M3i1zbuNTu7LFoXE?=
 =?us-ascii?Q?ihKjOfpNSsizEL5xKY0dDGTg4WthM9BXXSut9VNHTLmJXhrWsbOs61BsTIV1?=
 =?us-ascii?Q?piNgg6akOH8O7OiayyyHFkVCw8uARJT6q08skMsX5J32UV+oolUS/8mv0u9p?=
 =?us-ascii?Q?IP3LFuh7n210DVe1yUiAwaAyzg/pnlV79mtzE5XwBIojoOy70WUhCTjAJZlT?=
 =?us-ascii?Q?ByXYZl1/aAyvpPHar0UNbR+B01NFczD/OxDUormD29DslWd6KdrObCOPwcP4?=
 =?us-ascii?Q?uCQKxLME8x6FwBIWukm9GBueIA3y87ZOMcL+JgZUz0tXAFRnxmrHPQHgbPbn?=
 =?us-ascii?Q?UM0J4I3p0pNn2jbM+YwbNgYQsDUXgKKr+yQbU5hi5l1d3oYvpedljiDUOkau?=
 =?us-ascii?Q?s5kzLlvJO7BUma/+XYoNvGiCDbf04R4MmgUwyDiN79uRkT/IrR9Ohnk+95lN?=
 =?us-ascii?Q?y01LCHiuIUIR0IaXAm2mlIiLWBoEZ81lmuwYChA2MvFJjs3oBAtRysYKaJV6?=
 =?us-ascii?Q?LxnHA9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5385.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+9zh/K1AMD4FBRa5HqE384q75QjqbdDzErgDKJ2MTRmC2dHLA33JpjpKUt2C?=
 =?us-ascii?Q?ikC1FoZTmenSRQOtIop3z90VCFxjhGCQ3PmXtsvdDyiQyepwwtn3bnXvQemp?=
 =?us-ascii?Q?NY4Fc49wflMxJnUfBnUbXT5eCuFNnr+4JHWnoYymhzrFMFeq17ZcpTKWCT4J?=
 =?us-ascii?Q?8pUumUB5IOKV24C5iy3m6zvzLF6Xg8OT+iiXTDi/PO4RXfgx97lfBcUKwOJ8?=
 =?us-ascii?Q?OjBTxRH++A1Hr9+MJvdQ69XhhQmwBJPruSiZLEDhcH27JDS8jsfGyaOae5/Y?=
 =?us-ascii?Q?/RkNCB73TtrnR8V8idoTQH/AhUqsrJs0Ycvgnstrh8S3SCBIfqnulg3tkwdm?=
 =?us-ascii?Q?8Eibch3E2DFZTZ9Nhbqxk+t1F/I5gYVL/AROGb6eiqItx0eydlyaoTqzwOEd?=
 =?us-ascii?Q?r8kshNXt8ARo6KYx0HjAiHVl+HgjQAMYo/hjiwJtNfeZSkh9jqgqdaNc7lex?=
 =?us-ascii?Q?B0M2CjwAB0Y3n5BPR1fOt1TCYeSxi+hvZZjemVMtY3t2L2s9abawu6nz6WHU?=
 =?us-ascii?Q?gaNLE6U21haxpfZ3RlDfSN4szKfZerZ1cYgwjsYQTihB3xT7vpkB1yFcFrtX?=
 =?us-ascii?Q?cVYIue6wC99N7GePZhV0woATlOnhMjAoMnzCh9vjk3uAnJEVCFFBZDNTMqMV?=
 =?us-ascii?Q?Xr1FewOv9r8LSlDyTotK6E+1Ki1z1C9MMJ7SYsmR7yOgFdvZku6xDyQ+0x2W?=
 =?us-ascii?Q?WqtINf2QZvf2+hrcGjMkR6Qm7fxJkE/cAY9Nfp8Zxuy0R5vOezKo6dMMitPi?=
 =?us-ascii?Q?CL9/3B+jlyc45ExsjFebALttn1FVOboiRRl4IS7qwg5XrJ+BTqIBp5cDFj2a?=
 =?us-ascii?Q?f6JHcDj5Ij6YT5I/uab1inSMgXMMWnOzQPrItrwBiOCwYppCVKa8eU0ymNe7?=
 =?us-ascii?Q?ae8scxDk+YHRIp2C4jNSSCasMrnagEDgKMTz9RAryWlhEeEdvKRMiuHPXayr?=
 =?us-ascii?Q?sjqj2ilYvvEFYP8oW7Ae6GvQlKUYAU9Q9BSZpq0Z2pD7xLlWZugR+RXDWVxs?=
 =?us-ascii?Q?4lhvssUGP1aa5GT3S3YmqrcxXw2GaGZl124m0maSA1gu1o2jiaP+H2eQyjSP?=
 =?us-ascii?Q?gYpsoC7To1b7NeeFqbs0Z4dCFzr1o4tWyvEZME1Iy6bJTvyFHF/tHCj8Hfcr?=
 =?us-ascii?Q?J0HFDApZjIctnOlnFeLfyVQZcS/g30iKKlgfNEAr3bbWLZr+/bEEz9HIocIs?=
 =?us-ascii?Q?5UUWLYf0if6dY/IS12+o4ocM3x+lqSro/1HkEKygUoxF+15HXRQUBETNs5p8?=
 =?us-ascii?Q?VcLOy0UxVllBNdYPxcSpwxhw9RVZ/7oGc+9o4zzmnwQiFY9ufymGZcIkkj/R?=
 =?us-ascii?Q?BHoGBdj1wt6c9CtpcKIn1+SNZ4/bYsxp/YjqXgRnlMzpRH+kq4ZaLf4sjg0C?=
 =?us-ascii?Q?TIcbIP2xpAU959OtGLukHDUdl9UmL3y16gJiRXErpb19M2GitQnU8URl77KW?=
 =?us-ascii?Q?K5rG+0oEcgtx8M28qcNIJkbOSaEVoAx6KvyNpKjeWeChf+VdwzSPA0NJ7hmG?=
 =?us-ascii?Q?pvxGkheVrKLR6WgDBPEGte8wtS0c2Xleed+QClFYJyuUggEnO/kU0Hnxl+Iv?=
 =?us-ascii?Q?lzKOhadx9/yHVufZSwtbJC8kkKK02wyV78MgQfhQHzcuTJIQ1tP9gNLlHNo+?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dad4a8-c2e7-4594-5394-08dcf961427e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5385.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:05:30.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gm3+/32aZFR3EOIajIJ3YT/nlBSJNDklMdv38o6YTS2fGulFF3OT/i36rchBlC7V1irNGBbbwwB94moQKtsRVqw9BNiaTIt0p22yo7XYh/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5018

Allocate one extra virtio_device_id as null terminator, otherwise
vdpa_mgmtdev_get_classes() may iterate multiple times and visit
undefined memory.

Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index ac4ab22f7d8b..74cc4ed77cc4 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -612,7 +612,11 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto mdev_err;
 	}
 
-	mdev_id = kzalloc(sizeof(struct virtio_device_id), GFP_KERNEL);
+	/*
+	 * id_table should be a null terminated array.
+	 * See vdpa_mgmtdev_get_classes().
+	 */
+	mdev_id = kzalloc(sizeof(struct virtio_device_id) * 2, GFP_KERNEL);
 	if (!mdev_id) {
 		err = -ENOMEM;
 		goto mdev_id_err;
-- 
2.40.1


