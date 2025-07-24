Return-Path: <stable+bounces-164544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789F9B0FF06
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A980E546B07
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A9A1D5ABA;
	Thu, 24 Jul 2025 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkmWXv+n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FC1A316C
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325860; cv=none; b=kLadOEsRfBPh9hKh22neUrdv3RwrYNUiEuyPJZy4t79H9uG18xGAZA4NXtkJcZoCdZeP0LET2O6fzOaHPLPMggAGJBeYllryACCScwbE6P77V2olWP8EjASXCR7LZOWLiKLywKwxqmSOKOXyOz9YEUQWTD3ZkhgCEs+wZ4nPKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325860; c=relaxed/simple;
	bh=ykISAG2IG4tYq6ITzjQ8M302ZIS0ViewbaEXFFtriCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emk5WAMRETsKLg+ake6ZIRa2cSN85Et9v1FmrTKuyj+a4bN2dY7c426TTS6nrt3xMwZ7JocqywKZjH2Bsfo+wgNmCCbdY8hrsumbDaUgHYg7Je0lESV5WyxDYt2pCdzg0zYwX+Dbxbc7joFIfW+wN0t7h4XNpW4+zIjTWqKqAfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkmWXv+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6494C4CEF4;
	Thu, 24 Jul 2025 02:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325860;
	bh=ykISAG2IG4tYq6ITzjQ8M302ZIS0ViewbaEXFFtriCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkmWXv+nMsxen47HMPk3Z550ny8ALWuJHcgO/BK9B/isfOgqEENsUMvpVPGnvZI18
	 LcTX9xgIKgcMjhHy4mnUT6F5g+KRZZ2agSOBDwK0PwjSxrYEgToVjaDzv/ZPoSI/fq
	 m3m+be1y2lM9TYQDqajqYC04SWPocric6eVuHQWTDyueFnvswfRRAL3U6DYaHWM3zI
	 CHu77BhJdwD1z5SezH/RuVlOjtVebzX5rbOhBM2PzE8LSDfQM3nd20su0e+t4mCGBD
	 M8+Ts9XSsz+BxY9l+G3ZuFVzzDO5KwblTPSO1DQI2kYr6nDFExuX/i90jfeRuYXKlo
	 fvFFVYhrkWcwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Liebes Wang <wanghaichi0403@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 11/11] ext4: fix out of bounds punch offset
Date: Wed, 23 Jul 2025 22:57:18 -0400
Message-Id: <20250724025718.1277650-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724025718.1277650-1-sashal@kernel.org>
References: <2025062009-junior-thriving-f882@gregkh>
 <20250724025718.1277650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit b5e58bcd79625423487fa3ecba8e8411b5396327 ]

Punching a hole with a start offset that exceeds max_end is not
permitted and will result in a negative length in the
truncate_inode_partial_folio() function while truncating the page cache,
potentially leading to undesirable consequences.

A simple reproducer:

  truncate -s 9895604649994 /mnt/foo
  xfs_io -c "pwrite 8796093022208 4096" /mnt/foo
  xfs_io -c "fpunch 8796093022213 25769803777" /mnt/foo

  kernel BUG at include/linux/highmem.h:275!
  Oops: invalid opcode: 0000 [#1] SMP PTI
  CPU: 3 UID: 0 PID: 710 Comm: xfs_io Not tainted 6.15.0-rc3
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
  RIP: 0010:zero_user_segments.constprop.0+0xd7/0x110
  RSP: 0018:ffffc90001cf3b38 EFLAGS: 00010287
  RAX: 0000000000000005 RBX: ffffea0001485e40 RCX: 0000000000001000
  RDX: 000000000040b000 RSI: 0000000000000005 RDI: 000000000040b000
  RBP: 000000000040affb R08: ffff888000000000 R09: ffffea0000000000
  R10: 0000000000000003 R11: 00000000fffc7fc5 R12: 0000000000000005
  R13: 000000000040affb R14: ffffea0001485e40 R15: ffff888031cd3000
  FS:  00007f4f63d0b780(0000) GS:ffff8880d337d000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000001ae0b038 CR3: 00000000536aa000 CR4: 00000000000006f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   truncate_inode_partial_folio+0x3dd/0x620
   truncate_inode_pages_range+0x226/0x720
   ? bdev_getblk+0x52/0x3e0
   ? ext4_get_group_desc+0x78/0x150
   ? crc32c_arch+0xfd/0x180
   ? __ext4_get_inode_loc+0x18c/0x840
   ? ext4_inode_csum+0x117/0x160
   ? jbd2_journal_dirty_metadata+0x61/0x390
   ? __ext4_handle_dirty_metadata+0xa0/0x2b0
   ? kmem_cache_free+0x90/0x5a0
   ? jbd2_journal_stop+0x1d5/0x550
   ? __ext4_journal_stop+0x49/0x100
   truncate_pagecache_range+0x50/0x80
   ext4_truncate_page_cache_block_range+0x57/0x3a0
   ext4_punch_hole+0x1fe/0x670
   ext4_fallocate+0x792/0x17d0
   ? __count_memcg_events+0x175/0x2a0
   vfs_fallocate+0x121/0x560
   ksys_fallocate+0x51/0xc0
   __x64_sys_fallocate+0x24/0x40
   x64_sys_call+0x18d2/0x4170
   do_syscall_64+0xa7/0x220
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix this by filtering out cases where the punching start offset exceeds
max_end.

Fixes: 982bf37da09d ("ext4: refactor ext4_punch_hole()")
Reported-by: Liebes Wang <wanghaichi0403@gmail.com>
Closes: https://lore.kernel.org/linux-ext4/ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com/
Tested-by: Liebes Wang <wanghaichi0403@gmail.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20250506012009.3896990-1-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fe1d19d920a96..eb092133c6b88 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4009,7 +4009,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
 
 	/* No need to punch hole beyond i_size */
-	if (offset >= inode->i_size)
+	if (offset >= inode->i_size || offset >= max_end)
 		return 0;
 
 	/*
-- 
2.39.5


