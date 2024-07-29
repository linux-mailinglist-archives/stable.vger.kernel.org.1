Return-Path: <stable+bounces-62542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC4593F540
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A3A282DB2
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0E3147C82;
	Mon, 29 Jul 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RBF0X0F+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E731147C74
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255856; cv=none; b=k9zRuxsPEW7r4JPx7I1lqu47ot8r594uELguJOfJ3Af1E9UBhhZqS6nO2+9oQSv02sVnxn9OkmK6wxRu1fLXjv0habO3ZcOGH9oFFY4w8qgmMenkN14ICSneXAVYMMtDmMlxxOG6hfR8hM6lk59UjcnaFJa5iGPgIF+zgFVWhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255856; c=relaxed/simple;
	bh=sNFKIGeGHadJtjyceD3WglHLJaYOcdagqg6iOh77SpM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Syk6hnaO7+kcr5YTB63hTyRcx2RO4eiHHyhJCoW/oCKAREZE2OSg090Qo2Xs0aIxLSup4RMCa16nVUDFLBsBqwN/sfJWC1eYo181PchCb2VgDzLbk8c8x6QXUyP0xUuYs9TfjZlGuReCwrqUHZGa7+TYKsWjXQ+w/RMNUV+WMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RBF0X0F+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99556C32786;
	Mon, 29 Jul 2024 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255856;
	bh=sNFKIGeGHadJtjyceD3WglHLJaYOcdagqg6iOh77SpM=;
	h=Subject:To:Cc:From:Date:From;
	b=RBF0X0F+BsnWfW6uFzsNCS8ntdhAMEJpD2riTPPljifM9ecf9+HaZ8conZU+U/W0l
	 kV+DLMdP5IKhPop7K+X5hRGVTG8vIC4sRAmsjxDLRP+CeusFf1AT6jArgOC5rpGeYq
	 jBeeBHl/j2bTCVpi/W7A43dP2F02WRDVDUSeGSXM=
Subject: FAILED: patch "[PATCH] f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid" failed to apply to 6.10-stable tree
To: jaegeuk@kernel.org,chao@kernel.org,willmcvicker@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:24:12 +0200
Message-ID: <2024072912-upstream-tropics-2c8a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8cb1f4080dd91c6e6b01dbea013a3f42341cb6a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072912-upstream-tropics-2c8a@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

8cb1f4080dd9 ("f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid")
21327a042dd9 ("f2fs: fix to avoid use SSR allocate when do defragment")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cb1f4080dd91c6e6b01dbea013a3f42341cb6a1 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 18 Jun 2024 02:15:38 +0000
Subject: [PATCH] f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid

mkdir /mnt/test/comp
f2fs_io setflags compression /mnt/test/comp
dd if=/dev/zero of=/mnt/test/comp/testfile bs=16k count=1
truncate --size 13 /mnt/test/comp/testfile

In the above scenario, we can get a BUG_ON.
 kernel BUG at fs/f2fs/segment.c:3589!
 Call Trace:
  do_write_page+0x78/0x390 [f2fs]
  f2fs_outplace_write_data+0x62/0xb0 [f2fs]
  f2fs_do_write_data_page+0x275/0x740 [f2fs]
  f2fs_write_single_data_page+0x1dc/0x8f0 [f2fs]
  f2fs_write_multi_pages+0x1e5/0xae0 [f2fs]
  f2fs_write_cache_pages+0xab1/0xc60 [f2fs]
  f2fs_write_data_pages+0x2d8/0x330 [f2fs]
  do_writepages+0xcf/0x270
  __writeback_single_inode+0x44/0x350
  writeback_sb_inodes+0x242/0x530
  __writeback_inodes_wb+0x54/0xf0
  wb_writeback+0x192/0x310
  wb_workfn+0x30d/0x400

The reason is we gave CURSEG_ALL_DATA_ATGC to COMPR_ADDR where the
page was set the gcing flag by set_cluster_dirty().

Cc: stable@vger.kernel.org
Fixes: 4961acdd65c9 ("f2fs: fix to tag gcing flag on page during block migration")
Reviewed-by: Chao Yu <chao@kernel.org>
Tested-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 362cfb550408..4db1add43e36 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3505,6 +3505,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
 				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&
+				__is_valid_data_blkaddr(fio->old_blkaddr) &&
 				!is_inode_flag_set(inode, FI_OPU_WRITE))
 				return CURSEG_ALL_DATA_ATGC;
 			else


