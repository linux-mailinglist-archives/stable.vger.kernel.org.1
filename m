Return-Path: <stable+bounces-1484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3954C7F7FEB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF062B2172A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250412D787;
	Fri, 24 Nov 2023 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrjX9WE/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462833CC2;
	Fri, 24 Nov 2023 18:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C158C433C7;
	Fri, 24 Nov 2023 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851516;
	bh=YWVsro3dFMFECzqolT20NyjLWvQeBhdwLTM0YNfLFNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrjX9WE/+q0tyGqvWnCr6IDlFfN31FPkLDCprSIT8Fg9m3A+SrUqWWmW1WcHvJ1GA
	 mLNVYojDLsXXFW3ZXF94rxreqnGWtS44ZyYzxpnIIvhBFJlXAkx3F2CXb/E/MwxP8H
	 KLYKYjkE/03VzD2nM25jOxUZyu0TfOz/L2ouZaM4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.5 461/491] ext4: correct offset of gdb backup in non meta_bg group to update_backups
Date: Fri, 24 Nov 2023 17:51:37 +0000
Message-ID: <20231124172038.473882094@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit 31f13421c004a420c0e9d288859c9ea9259ea0cc upstream.

Commit 0aeaa2559d6d5 ("ext4: fix corruption when online resizing a 1K
bigalloc fs") found that primary superblock's offset in its group is
not equal to offset of backup superblock in its group when block size
is 1K and bigalloc is enabled. As group descriptor blocks are right
after superblock, we can't pass block number of gdb to update_backups
for the same reason.

The root casue of the issue above is that leading 1K padding block is
count as data block offset for primary block while backup block has no
padding block offset in its group.

Remove padding data block count to fix the issue for gdb backups.

For meta_bg case, update_backups treat blk_off as block number, do no
conversion in this case.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20230826174712.4059355-2-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/resize.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1601,6 +1601,8 @@ exit_journal:
 		int gdb_num_end = ((group + flex_gd->count - 1) /
 				   EXT4_DESC_PER_BLOCK(sb));
 		int meta_bg = ext4_has_feature_meta_bg(sb);
+		sector_t padding_blocks = meta_bg ? 0 : sbi->s_sbh->b_blocknr -
+					 ext4_group_first_block_no(sb, 0);
 		sector_t old_gdb = 0;
 
 		update_backups(sb, ext4_group_first_block_no(sb, 0),
@@ -1612,8 +1614,8 @@ exit_journal:
 						     gdb_num);
 			if (old_gdb == gdb_bh->b_blocknr)
 				continue;
-			update_backups(sb, gdb_bh->b_blocknr, gdb_bh->b_data,
-				       gdb_bh->b_size, meta_bg);
+			update_backups(sb, gdb_bh->b_blocknr - padding_blocks,
+				       gdb_bh->b_data, gdb_bh->b_size, meta_bg);
 			old_gdb = gdb_bh->b_blocknr;
 		}
 	}



