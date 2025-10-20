Return-Path: <stable+bounces-187964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624ABEFD20
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B21274F005D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798F2E1F13;
	Mon, 20 Oct 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BQKWtxYj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425572DA779
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947736; cv=none; b=mK2mn4CtA9xkOilo8oftYgWtaIYPqy/WCESpjL0YMkdQ2Bni595PfQCpK15NMPqscnwShz/rDu2OAearaSx7PZ7asmKWaRnK7IwGnARPPPAQTuKH7srUmnlhAos61pXNAIfY4XiUj2+zNDBL0hKr94MLQRNs1GYlFFzc6jzhZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947736; c=relaxed/simple;
	bh=cixKSqJbJLSDjVgNiIw59kputtSxMwflGeO41CTcmjw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U+N2zlnULGR4vQS9Mz5zzxXt6BVTS0anoPHuQ5ZeAT8JIFQr6hyir4fAQPDOes/FirsJhVvrvopXcQZGb/WyCSbPaB2ImCVtyPdC+lkSDihIiC4Rg+dmRva70csa3gTvCWS7KdVOcLu0r/xwYAxIUzD0IRxwxy2kM6P49h+JaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BQKWtxYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54422C4CEF9;
	Mon, 20 Oct 2025 08:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947735;
	bh=cixKSqJbJLSDjVgNiIw59kputtSxMwflGeO41CTcmjw=;
	h=Subject:To:Cc:From:Date:From;
	b=BQKWtxYjgGSfRqb+P0occNtw7BjkNLQ0kr8D4tNu0vp7PLkpMsnJYNJOgjKdsLadu
	 3cG4XCX6aeH8iPQDGhTLHTsatrf5cdGW6A4WDkPkqH29Ch7KAHoUsQBBCU58p41B7X
	 YrPyxIOefRwDzphUlI9nOlviWOA2M0vBPCOjLQOM=
Subject: FAILED: patch "[PATCH] f2fs: fix wrong block mapping for multi-devices" failed to apply to 6.1-stable tree
To: jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:08:52 +0200
Message-ID: <2025102052-work-collected-f03f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9d5c4f5c7a2c7677e1b3942772122b032c265aae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102052-work-collected-f03f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9d5c4f5c7a2c7677e1b3942772122b032c265aae Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 7 Oct 2025 03:32:30 +0000
Subject: [PATCH] f2fs: fix wrong block mapping for multi-devices

Assuming the disk layout as below,

disk0: 0            --- 0x00035abfff
disk1: 0x00035ac000 --- 0x00037abfff
disk2: 0x00037ac000 --- 0x00037ebfff

and we want to read data from offset=13568 having len=128 across the block
devices, we can illustrate the block addresses like below.

0 .. 0x00037ac000 ------------------- 0x00037ebfff, 0x00037ec000 -------
          |          ^            ^                                ^
          |   fofs   0            13568                            13568+128
          |       ------------------------------------------------------
          |   LBA    0x37e8aa9    0x37ebfa9                        0x37ec029
          --- map    0x3caa9      0x3ffa9

In this example, we should give the relative map of the target block device
ranging from 0x3caa9 to 0x3ffa9 where the length should be calculated by
0x37ebfff + 1 - 0x37ebfa9.

In the below equation, however, map->m_pblk was supposed to be the original
address instead of the one from the target block address.

 - map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);

Cc: stable@vger.kernel.org
Fixes: 71f2c8206202 ("f2fs: multidevice: support direct IO")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ef38e62cda8f..775aa4f63aa3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1497,8 +1497,8 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 
 		map->m_bdev = dev->bdev;
-		map->m_pblk -= dev->start_blk;
 		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
+		map->m_pblk -= dev->start_blk;
 	} else {
 		map->m_bdev = inode->i_sb->s_bdev;
 	}


