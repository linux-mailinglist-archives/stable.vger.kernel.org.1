Return-Path: <stable+bounces-62956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487994166B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361131C23065
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F271BBBDB;
	Tue, 30 Jul 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="icOb0SE2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B41BA87E;
	Tue, 30 Jul 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355188; cv=none; b=CF7ZQGaEhIY68c3Qw21KbXTPb28l8YOgZnADEohwZF68V9JjIVbtEBEc97ZHTa0DuWAyY2qL7AWHVJpd+gFqVyTJn+KwY7wMN5I/8IfvC0PERWluBmr305GzRXKu61uZNZPWRaPIvws90L80gy14wHvh1kWL1ENp7Rhh5aZJjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355188; c=relaxed/simple;
	bh=PhXW4m3m8wTrxWINJD6Y0dzs5PxhB9EG+4aXmibQ7xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sb9ovfMDP6RoYzBNIcpp38AyVvMYZAfIEa5cCiJUkSX5c+b6fbPHsX83NM1Mq23eRg017/7TD3Tnk0ZUEgVECxqC0rWjPLwA4UFMRw+zzHD6p3LDYDaQYEVcsy+ikXVmQO22UduyFGAa1jIAIwj5KQX6yxcLMTCKKLcwlNVlVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=icOb0SE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA33C32782;
	Tue, 30 Jul 2024 15:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355188;
	bh=PhXW4m3m8wTrxWINJD6Y0dzs5PxhB9EG+4aXmibQ7xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icOb0SE2UKRlqiN6AM1F/3nGeYArrQooYj8KOcf7EaxS5WyhxCr1S9xhKr98PKaL7
	 e0Bq5WIdghA6n6ERRdjciuPjLz1S3cXmOldG5l2n16oTxdlCR/qdM8VqTiGYS8XyZS
	 wqwCGr2VqCnTVE2pz0lXS1/3mgjxzwQuAgLBmdfE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rusty Bird <rustybird@net-c.com>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 027/809] xen-blkfront: fix sector_size propagation to the block layer
Date: Tue, 30 Jul 2024 17:38:23 +0200
Message-ID: <20240730151725.729423470@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 98d34c087249d39838874b83e17671e7d5eb1ca7 ]

Ensure that info->sector_size and info->physical_sector_size are set
before the call to blkif_set_queue_limits by doing away with the
local variables and arguments that propagate them.

Thanks to Marek Marczykowski-Górecki and Jürgen Groß for root causing
the issue.

Fixes: ba3f67c11638 ("xen-blkfront: atomically update queue limits")
Reported-by: Rusty Bird <rustybird@net-c.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Link: https://lore.kernel.org/r/20240625055238.7934-1-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkfront.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index fd7c0ff2139ce..67aa63dabcff1 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1063,8 +1063,7 @@ static char *encode_disk_name(char *ptr, unsigned int n)
 }
 
 static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
-		struct blkfront_info *info, u16 sector_size,
-		unsigned int physical_sector_size)
+		struct blkfront_info *info)
 {
 	struct queue_limits lim = {};
 	struct gendisk *gd;
@@ -1159,8 +1158,6 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 
 	info->rq = gd->queue;
 	info->gd = gd;
-	info->sector_size = sector_size;
-	info->physical_sector_size = physical_sector_size;
 
 	xlvbd_flush(info);
 
@@ -2315,8 +2312,6 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 static void blkfront_connect(struct blkfront_info *info)
 {
 	unsigned long long sectors;
-	unsigned long sector_size;
-	unsigned int physical_sector_size;
 	int err, i;
 	struct blkfront_ring_info *rinfo;
 
@@ -2355,7 +2350,7 @@ static void blkfront_connect(struct blkfront_info *info)
 	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
 			    "sectors", "%llu", &sectors,
 			    "info", "%u", &info->vdisk_info,
-			    "sector-size", "%lu", &sector_size,
+			    "sector-size", "%lu", &info->sector_size,
 			    NULL);
 	if (err) {
 		xenbus_dev_fatal(info->xbdev, err,
@@ -2369,9 +2364,9 @@ static void blkfront_connect(struct blkfront_info *info)
 	 * provide this. Assume physical sector size to be the same as
 	 * sector_size in that case.
 	 */
-	physical_sector_size = xenbus_read_unsigned(info->xbdev->otherend,
+	info->physical_sector_size = xenbus_read_unsigned(info->xbdev->otherend,
 						    "physical-sector-size",
-						    sector_size);
+						    info->sector_size);
 	blkfront_gather_backend_features(info);
 	for_each_rinfo(info, rinfo, i) {
 		err = blkfront_setup_indirect(rinfo);
@@ -2383,8 +2378,7 @@ static void blkfront_connect(struct blkfront_info *info)
 		}
 	}
 
-	err = xlvbd_alloc_gendisk(sectors, info, sector_size,
-				  physical_sector_size);
+	err = xlvbd_alloc_gendisk(sectors, info);
 	if (err) {
 		xenbus_dev_fatal(info->xbdev, err, "xlvbd_add at %s",
 				 info->xbdev->otherend);
-- 
2.43.0




