Return-Path: <stable+bounces-86441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EEF9A03DF
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57920B28A81
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 08:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D152B1CEAD3;
	Wed, 16 Oct 2024 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQMz4nxj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD191CB9E0;
	Wed, 16 Oct 2024 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066430; cv=none; b=JSaa6YyFZeXPuiLcRuW/Yq6BQPHgDakTTnTHAGa92rMy91ewaw9AwcpaziVhHYY/RKDIZvXAI2J6zX/7CHB53fQTePiegNoto5nlWQbAFNQ7PggFNjMoohFx7pSrwrz/+PxydFwn3NsjhgC+Qg/CURvzJtcwv8JyLuDSqyJvVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066430; c=relaxed/simple;
	bh=rmBpEhEVE7Cfx7/ProAaXt8OTkpq/W8XwrVpBLTEBaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uk2iNNsKAuUEeudd3WX/JMbzi9VdMX0PELJTHQAvY6j1rVTiqUayhb4f1tPcMdVLNBwEy6sVIpPMaTlbrBJh5JjuA/qVImTZjG3qu6wofe0CZZCR+eYSZQXj0bmvqMLn2gjIWXFyhEX3eI0PWPAL9Ini+ojYAVbmFvxDYopAg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQMz4nxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1588C4CEC5;
	Wed, 16 Oct 2024 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729066430;
	bh=rmBpEhEVE7Cfx7/ProAaXt8OTkpq/W8XwrVpBLTEBaE=;
	h=From:To:Cc:Subject:Date:From;
	b=oQMz4nxjw8XiQMqw+jnIJ2KCrRngUSdK7bnkfdIXO9mQSS/8HctPkl61bB5jM9HaI
	 V7Luh8sxwgdamIvfGCk+aAE1zMxmJQ04kbp57Gpveew1w0y4mxGwba7IQnGmq1+ggu
	 vONY2hqqmYztjDluJBp4DWB6OQ7raYdT8hB4/RpRC6W82MxZY1Wv54NW4NMMM2yZZx
	 5QimjJP6TH3QPTMmxqfYGJhzzotOtnIlo7d0YDsyvq3AMnNoMiwdjRkI3xxJX0E8G4
	 +aTOseBks9euO3u0VZze2cP/iYC9MkrNuFNXKQk+rjaao5DYNkAX3V/5MggQCmZb0S
	 KHuxH0A1laWvg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+33379ce4ac76acf7d0c7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix to do sanity check on node blkaddr in truncate_node()
Date: Wed, 16 Oct 2024 16:13:37 +0800
Message-Id: <20241016081337.598979-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a f2fs bug as below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2534!
RIP: 0010:f2fs_invalidate_blocks+0x35f/0x370 fs/f2fs/segment.c:2534
Call Trace:
 truncate_node+0x1ae/0x8c0 fs/f2fs/node.c:909
 f2fs_remove_inode_page+0x5c2/0x870 fs/f2fs/node.c:1288
 f2fs_evict_inode+0x879/0x15c0 fs/f2fs/inode.c:856
 evict+0x4e8/0x9b0 fs/inode.c:723
 f2fs_handle_failed_inode+0x271/0x2e0 fs/f2fs/inode.c:986
 f2fs_create+0x357/0x530 fs/f2fs/namei.c:394
 lookup_open fs/namei.c:3595 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0010:f2fs_invalidate_blocks+0x35f/0x370 fs/f2fs/segment.c:2534

The root cause is: on a fuzzed image, blkaddr in nat entry may be
corrupted, then it will cause system panic when using it in
f2fs_invalidate_blocks(), to avoid this, let's add sanity check on
nat blkaddr in truncate_node().

Reported-by: syzbot+33379ce4ac76acf7d0c7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/0000000000009a6cd706224ca720@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 59b13ff243fa..af36c6d6542b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -905,6 +905,16 @@ static int truncate_node(struct dnode_of_data *dn)
 	if (err)
 		return err;
 
+	if (ni.blk_addr != NEW_ADDR &&
+		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC_ENHANCE)) {
+		f2fs_err_ratelimited(sbi,
+			"nat entry is corrupted, run fsck to fix it, ino:%u, "
+			"nid:%u, blkaddr:%u", ni.ino, ni.nid, ni.blk_addr);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
+		return -EFSCORRUPTED;
+	}
+
 	/* Deallocate node address */
 	f2fs_invalidate_blocks(sbi, ni.blk_addr);
 	dec_valid_node_count(sbi, dn->inode, dn->nid == dn->inode->i_ino);
-- 
2.40.1


