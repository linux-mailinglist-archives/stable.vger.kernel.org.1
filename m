Return-Path: <stable+bounces-7516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B358172E6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A34B2419C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B23787C;
	Mon, 18 Dec 2023 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xUtFBoi1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D19129EDD;
	Mon, 18 Dec 2023 14:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044AEC433C9;
	Mon, 18 Dec 2023 14:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908678;
	bh=hIk5xbXCbfafCPhFdd94aubjpTC3rIMoW3PIoRHBrTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xUtFBoi1LU/TywCj/JZIq75UgtlFOqlOi7G/cqG3JD7nfJUbYRAWgEMh9TmfAAAjJ
	 2HT0BgMypc/N28cc6YBzDvs9FJbbboF9lVV5+TV+/pbORVZIbDF6UiqshjaQHoNYJ8
	 wJeyapIBJ3E+RoutzYvoA5yjqXCrrWX+M6X67I9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 5.4 34/40] ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS
Date: Mon, 18 Dec 2023 14:52:29 +0100
Message-ID: <20231218135044.051972789@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135042.748715259@linuxfoundation.org>
References: <20231218135042.748715259@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit 2dcf5fde6dffb312a4bfb8ef940cea2d1f402e32 upstream.

For files with logical blocks close to EXT_MAX_BLOCKS, the file size
predicted in ext4_mb_normalize_request() may exceed EXT_MAX_BLOCKS.
This can cause some blocks to be preallocated that will not be used.
And after [Fixes], the following issue may be triggered:

=========================================================
 kernel BUG at fs/ext4/mballoc.c:4653!
 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
 CPU: 1 PID: 2357 Comm: xfs_io 6.7.0-rc2-00195-g0f5cc96c367f
 Hardware name: linux,dummy-virt (DT)
 pc : ext4_mb_use_inode_pa+0x148/0x208
 lr : ext4_mb_use_inode_pa+0x98/0x208
 Call trace:
  ext4_mb_use_inode_pa+0x148/0x208
  ext4_mb_new_inode_pa+0x240/0x4a8
  ext4_mb_use_best_found+0x1d4/0x208
  ext4_mb_try_best_found+0xc8/0x110
  ext4_mb_regular_allocator+0x11c/0xf48
  ext4_mb_new_blocks+0x790/0xaa8
  ext4_ext_map_blocks+0x7cc/0xd20
  ext4_map_blocks+0x170/0x600
  ext4_iomap_begin+0x1c0/0x348
=========================================================

Here is a calculation when adjusting ac_b_ex in ext4_mb_new_inode_pa():

	ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
	if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
		goto adjust_bex;

The problem is that when orig_goal_end is subtracted from ac_b_ex.fe_len
it is still greater than EXT_MAX_BLOCKS, which causes ex.fe_logical to
overflow to a very small value, which ultimately triggers a BUG_ON in
ext4_mb_new_inode_pa() because pa->pa_free < len.

The last logical block of an actual write request does not exceed
EXT_MAX_BLOCKS, so in ext4_mb_normalize_request() also avoids normalizing
the last logical block to exceed EXT_MAX_BLOCKS to avoid the above issue.

The test case in [Link] can reproduce the above issue with 64k block size.

Link: https://patchwork.kernel.org/project/fstests/list/?series=804003
Cc:  <stable@kernel.org> # 6.4
Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231127063313.3734294-1-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3182,6 +3182,10 @@ ext4_mb_normalize_request(struct ext4_al
 	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
 			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
 
+	/* avoid unnecessary preallocation that may trigger assertions */
+	if (start + size > EXT_MAX_BLOCKS)
+		size = EXT_MAX_BLOCKS - start;
+
 	/* don't cover already allocated blocks in selected range */
 	if (ar->pleft && start <= ar->lleft) {
 		size -= ar->lleft + 1 - start;



