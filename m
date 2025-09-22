Return-Path: <stable+bounces-180992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDCFB92610
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9301904694
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA2313271;
	Mon, 22 Sep 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="gE5718K9"
X-Original-To: stable@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938B1DA23
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561459; cv=none; b=ambEdSa9qXZJbWagxJzVSIArUo2IiIVt7K2PMDg31+++EytTfdzDRDNFO5ZltXsA0f/ApHm7/5uSGCMSUe8HRnlmD6X1SX8O+UcTFKCOp3iS10KO9Q/ZwujQUDhRB19FGrkMFlILWYCJA2hD+DyFFH+C6LzDOcZF86nSgaDVUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561459; c=relaxed/simple;
	bh=S4xN49pFSnTdw5ThYmz+Wn6pjq+tsVauICQ1qMWCpnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJx6xdsoqmS9xxuG+1noHUuqlUkl4XevBtT3ls9wU3Q02sJZ/sxmViC5mms1k4j/4Vt7CRAVl2FgKojYbCiEOP9p0Ti+edZjZ6vdQWfovlQGt1m24hu9oxsl0fmDCfq/+6YKUsX4l9SEyhSQ6xP3Pk123Zd+hEpsm+5FEDx3SEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=gE5718K9; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
From: Eric Hagberg <ehagberg@janestreet.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
 	jack@suse.cz,
 	Eric Hagberg <ehagberg@janestreet.com>
Subject: [PATCH] Revert "loop: Avoid updating block size under exclusive owner"
Date: Mon, 22 Sep 2025 13:17:04 -0400
Message-ID: <20250922171704.3863333-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1758561456;
  bh=D6UkrGFKZSIXKn1LHMGQGcdRlspiSD4TG+RBYmQeVRU=;
  h=From:To:Cc:Subject:Date;
  b=gE5718K9sKqecUKfLjNm2LGOVgnGXYonOOKxC0Qkw098sAZPBeq5n9SozGsbtGDdd
  NaR5IEnTzMJ6eHpXbJdbYZiTwXUcudALvY9fkaNqZdbRyT6oeEtm6CiJcp1B2KynIt
  2Tup/QWarb/8sChMkUt8OWcy6DmdWQwZCzHSbqmBfU9P3oJE5jFRXzHSMKuwp97JOI
  G3hhNAc+7ZAxOYS3nsj3y6Jyej80bVj6B/S5iMlvi0BEeMLkvswG26b2HQ9wwb+zaw
  lrHsW23iKLq737djB2JTKSvIJM2uwQ6g2gEH993fFU5gp/eqcY94xgSVhPjHRUNUn3
  ZVhBmd80xsXYA==

This reverts commit ce8da5d13d8c ("loop: Avoid updating block size under
exclusive owner") for the 6.6 kernel, because if the LTP ioctl_loop06 test is
run with this patch in place, the test will fail, it leaves the host unable to
kexec into the kernel again (hangs forever) and "losetup -a" will hang on
attempting to access the /dev/loopN device that the test has set up.

The patch doesn't need to be reverted from 6.12, as it works fine there.

Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Eric Hagberg <ehagberg@janestreet.com>

---

--- b/drivers/block/loop.c
+++ a/drivers/block/loop.c
@@ -1472,36 +1472,19 @@
 	return error;
 }
 
+static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
-static int loop_set_block_size(struct loop_device *lo, blk_mode_t mode,
-			       struct block_device *bdev, unsigned long arg)
 {
 	int err = 0;
 
+	if (lo->lo_state != Lo_bound)
+		return -ENXIO;
-	/*
-	 * If we don't hold exclusive handle for the device, upgrade to it
-	 * here to avoid changing device under exclusive owner.
-	 */
-	if (!(mode & BLK_OPEN_EXCL)) {
-		err = bd_prepare_to_claim(bdev, loop_set_block_size, NULL);
-		if (err)
-			return err;
-	}
-
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
-		goto abort_claim;
-
-	if (lo->lo_state != Lo_bound) {
-		err = -ENXIO;
-		goto unlock;
-	}
 
 	err = blk_validate_block_size(arg);
 	if (err)
 		return err;
 
 	if (lo->lo_queue->limits.logical_block_size == arg)
+		return 0;
-		goto unlock;
 
 	sync_blockdev(lo->lo_device);
 	invalidate_bdev(lo->lo_device);
@@ -1513,11 +1496,6 @@
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-unlock:
-	mutex_unlock(&lo->lo_mutex);
-abort_claim:
-	if (!(mode & BLK_OPEN_EXCL))
-		bd_abort_claiming(bdev, loop_set_block_size);
 	return err;
 }
 
@@ -1536,6 +1514,9 @@
 	case LOOP_SET_DIRECT_IO:
 		err = loop_set_dio(lo, arg);
 		break;
+	case LOOP_SET_BLOCK_SIZE:
+		err = loop_set_block_size(lo, arg);
+		break;
 	default:
 		err = -EINVAL;
 	}
@@ -1590,12 +1571,9 @@
 		break;
 	case LOOP_GET_STATUS64:
 		return loop_get_status64(lo, argp);
-	case LOOP_SET_BLOCK_SIZE:
-		if (!(mode & BLK_OPEN_WRITE) && !capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		return loop_set_block_size(lo, mode, bdev, arg);
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
+	case LOOP_SET_BLOCK_SIZE:
 		if (!(mode & BLK_OPEN_WRITE) && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		fallthrough;

