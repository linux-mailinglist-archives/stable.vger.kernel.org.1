Return-Path: <stable+bounces-62545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3493F543
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A441C21E51
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED21482E4;
	Mon, 29 Jul 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h6GgI8e/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE51465A1
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255872; cv=none; b=uzuDo6xbMQdTAr3lPkh8wcdU/uHRfI72SiZbAf+P0JSrAqsFIF91dXdn2swtqByDu937PcjWCX6PCtaaksC2RhnnXF8lUQ5rd/G7VvOGJX2qOMzUL6YGcBEtapbO4AoBTqqGkbIS1+E2SsDuCneWrz56aC3nF2DdfnA7D0OkZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255872; c=relaxed/simple;
	bh=l6sUDkym2aiZF+uqPMGuhGZhBrD65G1oMxa/v3KYTZY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kjfD5V2d+jfWYRCMDEFp7yv4dVzbuLgSSsRkOJA6N0zFcpHfCmKOmOvj6efP3+PkJ1L6A78LdtTs30qOKUS4YfJbCFqJCctfoZMKBxRtFTfakpMbpZZDFNmgbSQZp/Z17jWmeS+YMgI54Znebb5RQ038GwjKp/f8gKtPhL2Ry+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h6GgI8e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F77DC32786;
	Mon, 29 Jul 2024 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255871;
	bh=l6sUDkym2aiZF+uqPMGuhGZhBrD65G1oMxa/v3KYTZY=;
	h=Subject:To:Cc:From:Date:From;
	b=h6GgI8e/LIb/QeOAovIW43IoOU7cqOHG4kaWb5OAn0gA3Lf24nBn5Fw8wrbcVR7bJ
	 p6XcbyG/wK06r6DRtO0knM18S1AX1HqbgMbRlvGPGoY7J6WbQzE0kkH4si/pbwsoi4
	 1U1j+eYE6JhzU0wDmElKIAwF28NfRYSJwLFMsOU8=
Subject: FAILED: patch "[PATCH] f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid" failed to apply to 5.15-stable tree
To: jaegeuk@kernel.org,chao@kernel.org,willmcvicker@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:24:15 +0200
Message-ID: <2024072915-exclusive-powdery-eeb5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8cb1f4080dd91c6e6b01dbea013a3f42341cb6a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072915-exclusive-powdery-eeb5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


