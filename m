Return-Path: <stable+bounces-66737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F294F149
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C71C22076
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7280817ADF8;
	Mon, 12 Aug 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kRMprAoS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2C14C5A4
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475283; cv=none; b=qtSrEwWDrWy+uqD4acTwSa4KdVD9CH3jEVf0nTlmhNq/Q3D4vpdIhUfbVhG5Vj4ncp2fcHB1OOh+RYME2S+UFcrfjtivjCSRiyyeNBGCLfAWBHLuoYTkF/1icBoM6AnAHe/7Y3ymHfJuJ6cIwYtWXkmYuPvvcxMT7PnJ+BoB8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475283; c=relaxed/simple;
	bh=eYO/jfziGTKHEoyp6LkFHz3f9EHuoZ0nH/4wBFqK7EA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r9QRUMfBejvZtJKmOVU4JiyAyep6sgS2qn3SL3kgiTtkB0T8GPWeumtSMRRcRWmxS2fRgES951m4dbHiS3GuDMYOosRm1ECiU4kSJkppOPifJtwEsMYkgLwtXiX/V8P+sNE9tXr7bJ596bnuKoLG3X8+hZ9NJFYUjl5Fm5nSELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kRMprAoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A686C32782;
	Mon, 12 Aug 2024 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723475282;
	bh=eYO/jfziGTKHEoyp6LkFHz3f9EHuoZ0nH/4wBFqK7EA=;
	h=Subject:To:Cc:From:Date:From;
	b=kRMprAoSv+wKEzsWUiijJznmScMqwlWvl8P0Z07kFyL+LstIeHBwKUQp36h6Vkxbe
	 8QSNe1X4vYoMPbEP4XXb1m2Q1hTxw2qpA1g44636YJqpv0LqZqh018EHsNr4CpSccj
	 iP7UhLTDlT/GI5Fs8QZDsep3iiBriln7/VLTRHF4=
Subject: FAILED: patch "[PATCH] btrfs: fix double inode unlock for direct IO sync writes" failed to apply to 6.6-stable tree
To: fdmanana@suse.com,dsterba@suse.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:07:51 +0200
Message-ID: <2024081251-startle-trunks-6fb5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e0391e92f9ab4fb3dbdeb139c967dcfa7ac4b115
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081251-startle-trunks-6fb5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e0391e92f9ab ("btrfs: fix double inode unlock for direct IO sync writes")
56b7169f691c ("btrfs: use a btrfs_inode local variable at btrfs_sync_file()")
e641e323abb3 ("btrfs: pass a btrfs_inode to btrfs_wait_ordered_range()")
f13e01b89daf ("btrfs: ensure fast fsync waits for ordered extents after a write failure")
41044b41ad2c ("btrfs: add helper to get fs_info from struct inode pointer")
b33d2e535f9b ("btrfs: add helpers to get fs_info from page/folio pointers")
c8293894afa7 ("btrfs: add helpers to get inode from page/folio pointers")
4e00422ee626 ("btrfs: replace sb::s_blocksize by fs_info::sectorsize")
dfba9f477306 ("btrfs: add set_folio_extent_mapped() helper")
418b09027743 ("btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given")
b0ad381fa769 ("btrfs: fix deadlock with fiemap and extent locking")
6a69631ec9b1 ("btrfs: lzo: fix and simplify the inline extent decompression")
2c25716dcc25 ("btrfs: zlib: fix and simplify the inline extent decompression")
55151ea9ec1b ("btrfs: migrate subpage code to folio interfaces")
8d993618350c ("btrfs: migrate get_eb_page_index() and get_eb_offset_in_page() to folios")
13df3775efca ("btrfs: cleanup metadata page pointer usage")
082d5bb9b336 ("btrfs: migrate extent_buffer::pages[] to folio")
09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
ed9b50a13edf ("btrfs: cache that we don't have security.capability set")
397239ed6a6c ("btrfs: allow extent buffer helpers to skip cross-page handling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0391e92f9ab4fb3dbdeb139c967dcfa7ac4b115 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 2 Aug 2024 09:38:51 +0100
Subject: [PATCH] btrfs: fix double inode unlock for direct IO sync writes

If we do a direct IO sync write, at btrfs_sync_file(), and we need to skip
inode logging or we get an error starting a transaction or an error when
flushing delalloc, we end up unlocking the inode when we shouldn't under
the 'out_release_extents' label, and then unlock it again at
btrfs_direct_write().

Fix that by checking if we have to skip inode unlocking under that label.

Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000dfd631061eaeb4bc@google.com/
Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9f10a9f23fcc..9914419f3b7d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1868,7 +1868,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&inode->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 


