Return-Path: <stable+bounces-38161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB32F8A0D4A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668D7285A25
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6FB145B05;
	Thu, 11 Apr 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m4SHaXGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BF1422C4;
	Thu, 11 Apr 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829743; cv=none; b=oacDthu9/1NSlGhKHNlaOqQ8LxRTR2Pne6nZNrt9miifqiudSRfdTxGASmAjQswDFe4AFjE4vQB6woGfyIvLhMHmdfkkBk28pfOIV9lBwah1+qMnv8X5JCk/vblWWTG6pnnEKZZZyVnVDQTYDKS2BReJOjCVYAM1dzmrS+nadmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829743; c=relaxed/simple;
	bh=ygSlADDSXDLsSuaBpbH+D+JKInx1ZZrg4qQcgqAjpg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idAuPC+UJPwzlp8FzJcVBwSgKuEsoQqDobiIhHbIit9gs0DZH+jj7bynT395if54FLGKt3Gr+lq2WmoHf3hh6XvCgBHkgve++r+2nDwGLnFqle8tdB96Nm7DpsDgFw4hfk/n9BiKM9xcrl1KRkkEsgTs/L0tkmaSD/hnv5ugqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m4SHaXGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5557CC433C7;
	Thu, 11 Apr 2024 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712829743;
	bh=ygSlADDSXDLsSuaBpbH+D+JKInx1ZZrg4qQcgqAjpg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4SHaXGOC/ORbf64Etl9FAzPbYfKRown+D9B4zKwgpzPAKmkXLE2titnsenIFAP3J
	 wUGpv80ImsR2zlj8/XfPsPU5Mc6L0JjbVsbj9wdInSo5UIL/4cWhS4J/Qokkr1y3Pp
	 kciW8uSroZOuZ8Gf8xKLlqAnOEjDHb9KHsXjfuRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martijn Coenen <maco@android.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH 4.19 091/175] loop: Remove sector_t truncation checks
Date: Thu, 11 Apr 2024 11:55:14 +0200
Message-ID: <20240411095422.304818113@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
References: <20240411095419.532012976@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martijn Coenen <maco@android.com>

[ Upstream commit 083a6a50783ef54256eec3499e6575237e0e3d53 ]

sector_t is now always u64, so we don't need to check for truncation.

Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -225,24 +225,20 @@ static void __loop_update_dio(struct loo
 	blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
-static int
+static void
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	sector_t x = (sector_t)size;
 	struct block_device *bdev = lo->lo_device;
 
-	if (unlikely((loff_t)x != size))
-		return -EFBIG;
 	if (lo->lo_offset != offset)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, x);
+	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
 	/* let user-space know about the new size */
 	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
-	return 0;
 }
 
 static inline int
@@ -972,10 +968,8 @@ static int loop_set_fd(struct loop_devic
 	    !file->f_op->write_iter)
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
-	error = -EFBIG;
 	size = get_loop_size(lo, file);
-	if ((loff_t)(sector_t)size != size)
-		goto out_unlock;
+
 	error = loop_prepare_queue(lo);
 	if (error)
 		goto out_unlock;
@@ -1280,10 +1274,7 @@ loop_set_status(struct loop_device *lo,
 				lo->lo_device->bd_inode->i_mapping->nrpages);
 			goto out_unfreeze;
 		}
-		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
-			err = -EFBIG;
-			goto out_unfreeze;
-		}
+		figure_loop_size(lo, info->lo_offset, info->lo_sizelimit);
 	}
 
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
@@ -1486,7 +1477,9 @@ static int loop_set_capacity(struct loop
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+	figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+
+	return 0;
 }
 
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)



