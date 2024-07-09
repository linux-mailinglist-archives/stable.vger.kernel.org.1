Return-Path: <stable+bounces-58584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239192B7BC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBF81F245B5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3250615749B;
	Tue,  9 Jul 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/30ylKK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2868156238;
	Tue,  9 Jul 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524383; cv=none; b=cvLzFYg7f1uAEI5lMSlz1Win9/jo5FY2EpVOT0KBkti4pUc80EAu8yy6l8L0zHw+rsFiYh6U3irDCb9gUbTMLmyMguZCdkA2k4/PKHcyDUPSl8hdlgKWrWKO8zsSil1VaI7U8VQVgdkX94MuGr6sJd4Q/Du2ZTM//PdfqM7la9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524383; c=relaxed/simple;
	bh=Fy7sztzIZn+8eKZZoihvilL+DsXlE/JRezU194J3kmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmSPeB55N6eDLGwHtUBoP29VdlXG03fAGWh5YKksxoKtVgDI/GciCAkgNq3m7ylDVX9oUkWZJpDN99h5gEPxXp4orCYC7N8ek5TPztMnSSNH0Bb7rojMrDtNfWsxpj1vcZWF6NO0f4LLWxGBMJd7YolM0bvUNH2brUvrQKxcEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/30ylKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DC1C4AF0B;
	Tue,  9 Jul 2024 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524382;
	bh=Fy7sztzIZn+8eKZZoihvilL+DsXlE/JRezU194J3kmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/30ylKKxtCYZvGHtMwUcsGQ7mhNowbnx7QFUZqxSdRKHlliiMaipZBxducpZ0y6/
	 gtHOLFOrz8WAsrPgZZUMXXyYXtCqmW0L1o8CbfwmV/i4qdM+mvjaXt48pKuIJNfuMz
	 jvD/2V06ePMybfYfN+ZeCrJndEkR5PMB8VHnLcOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.9 133/197] nilfs2: fix inode number range checks
Date: Tue,  9 Jul 2024 13:09:47 +0200
Message-ID: <20240709110714.097003490@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit e2fec219a36e0993642844be0f345513507031f4 upstream.

Patch series "nilfs2: fix potential issues related to reserved inodes".

This series fixes one use-after-free issue reported by syzbot, caused by
nilfs2's internal inode being exposed in the namespace on a corrupted
filesystem, and a couple of flaws that cause problems if the starting
number of non-reserved inodes written in the on-disk super block is
intentionally (or corruptly) changed from its default value.


This patch (of 3):

In the current implementation of nilfs2, "nilfs->ns_first_ino", which
gives the first non-reserved inode number, is read from the superblock,
but its lower limit is not checked.

As a result, if a number that overlaps with the inode number range of
reserved inodes such as the root directory or metadata files is set in the
super block parameter, the inode number test macros (NILFS_MDT_INODE and
NILFS_VALID_INODE) will not function properly.

In addition, these test macros use left bit-shift calculations using with
the inode number as the shift count via the BIT macro, but the result of a
shift calculation that exceeds the bit width of an integer is undefined in
the C specification, so if "ns_first_ino" is set to a large value other
than the default value NILFS_USER_INO (=11), the macros may potentially
malfunction depending on the environment.

Fix these issues by checking the lower bound of "nilfs->ns_first_ino" and
by preventing bit shifts equal to or greater than the NILFS_USER_INO
constant in the inode number test macros.

Also, change the type of "ns_first_ino" from signed integer to unsigned
integer to avoid the need for type casting in comparisons such as the
lower bound check introduced this time.

Link: https://lkml.kernel.org/r/20240623051135.4180-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20240623051135.4180-2-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/nilfs.h     |    5 +++--
 fs/nilfs2/the_nilfs.c |    6 ++++++
 fs/nilfs2/the_nilfs.h |    2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -116,9 +116,10 @@ enum {
 #define NILFS_FIRST_INO(sb) (((struct the_nilfs *)sb->s_fs_info)->ns_first_ino)
 
 #define NILFS_MDT_INODE(sb, ino) \
-	((ino) < NILFS_FIRST_INO(sb) && (NILFS_MDT_INO_BITS & BIT(ino)))
+	((ino) < NILFS_USER_INO && (NILFS_MDT_INO_BITS & BIT(ino)))
 #define NILFS_VALID_INODE(sb, ino) \
-	((ino) >= NILFS_FIRST_INO(sb) || (NILFS_SYS_INO_BITS & BIT(ino)))
+	((ino) >= NILFS_FIRST_INO(sb) ||				\
+	 ((ino) < NILFS_USER_INO && (NILFS_SYS_INO_BITS & BIT(ino))))
 
 /**
  * struct nilfs_transaction_info: context information for synchronization
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -452,6 +452,12 @@ static int nilfs_store_disk_layout(struc
 	}
 
 	nilfs->ns_first_ino = le32_to_cpu(sbp->s_first_ino);
+	if (nilfs->ns_first_ino < NILFS_USER_INO) {
+		nilfs_err(nilfs->ns_sb,
+			  "too small lower limit for non-reserved inode numbers: %u",
+			  nilfs->ns_first_ino);
+		return -EINVAL;
+	}
 
 	nilfs->ns_blocks_per_segment = le32_to_cpu(sbp->s_blocks_per_segment);
 	if (nilfs->ns_blocks_per_segment < NILFS_SEG_MIN_BLOCKS) {
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -182,7 +182,7 @@ struct the_nilfs {
 	unsigned long		ns_nrsvsegs;
 	unsigned long		ns_first_data_block;
 	int			ns_inode_size;
-	int			ns_first_ino;
+	unsigned int		ns_first_ino;
 	u32			ns_crc_seed;
 
 	/* /sys/fs/<nilfs>/<device> */



