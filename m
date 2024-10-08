Return-Path: <stable+bounces-82879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC91994EFB
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17BF1F21A24
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392441DE4CD;
	Tue,  8 Oct 2024 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jArlyN1r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4C18C333;
	Tue,  8 Oct 2024 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393733; cv=none; b=IbPBYIDNLLeM1SU0s1SHde6Ri5qfNzcvYPc9iYKDME6Clk+zduNkttTJra5sPuo1Ji1EE6dB5MbLzbfaJTiYSVUWeLOVoJkLFOlE0l727KlFlOq486xQ49teWvomrayYlV1RtTLMhYaEXV0meWFFs9c/+6pHMcx/g3J7p0RsRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393733; c=relaxed/simple;
	bh=CIoxFeZ2LD+cX12sON+sqEcndh3EaPMkA0ZFtQbRRGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGzoJD/V+5wrSpOp0TKEgtnHQm3wb6G78rWo20W5hMPYcG96i5AeIHoy378TMkS74NEAoPoGHjwIukjYdMQFLL/grvZTKtf6xLbX8AH6LGAIUQ7y2b51WcKox/sltsNdf1qyqUAZ+Wbry67Ie5I9GoEkacQ2AxQI3HJHjfgULLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jArlyN1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58239C4CEC7;
	Tue,  8 Oct 2024 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393732;
	bh=CIoxFeZ2LD+cX12sON+sqEcndh3EaPMkA0ZFtQbRRGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jArlyN1rau8Az6tdKSv9m2Is8fXDax22NZZ7QqBi4UJcWtCOk/xLdtOnMRh+8VR1j
	 8k9hchJOuOEFuDUOJiw+2LLpKES5ZtMGD9Z4nbo8Pq29SKJVes1kxNlxvAsmEkp7+z
	 s6H0KN5yw0Tx3njvCMxbsUC3yyWFvQfEaJm0aOKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.6 240/386] ext4: fix double brelse() the buffer of the extents path
Date: Tue,  8 Oct 2024 14:08:05 +0200
Message-ID: <20241008115638.842426386@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit dcaa6c31134c0f515600111c38ed7750003e1b9c upstream.

In ext4_ext_try_to_merge_up(), set path[1].p_bh to NULL after it has been
released, otherwise it may be released twice. An example of what triggers
this is as follows:

  split2    map    split1
|--------|-------|--------|

ext4_ext_map_blocks
 ext4_ext_handle_unwritten_extents
  ext4_split_convert_extents
   // path->p_depth == 0
   ext4_split_extent
     // 1. do split1
     ext4_split_extent_at
       |ext4_ext_insert_extent
       |  ext4_ext_create_new_leaf
       |    ext4_ext_grow_indepth
       |      le16_add_cpu(&neh->eh_depth, 1)
       |    ext4_find_extent
       |      // return -ENOMEM
       |// get error and try zeroout
       |path = ext4_find_extent
       |  path->p_depth = 1
       |ext4_ext_try_to_merge
       |  ext4_ext_try_to_merge_up
       |    path->p_depth = 0
       |    brelse(path[1].p_bh)  ---> not set to NULL here
       |// zeroout success
     // 2. update path
     ext4_find_extent
     // 3. do split2
     ext4_split_extent_at
       ext4_ext_insert_extent
         ext4_ext_create_new_leaf
           ext4_ext_grow_indepth
             le16_add_cpu(&neh->eh_depth, 1)
           ext4_find_extent
             path[0].p_bh = NULL;
             path->p_depth = 1
             read_extent_tree_block  ---> return err
             // path[1].p_bh is still the old value
             ext4_free_ext_path
               ext4_ext_drop_refs
                 // path->p_depth == 1
                 brelse(path[1].p_bh)  ---> brelse a buffer twice

Finally got the following WARRNING when removing the buffer from lru:

============================================
VFS: brelse: Trying to free free buffer
WARNING: CPU: 2 PID: 72 at fs/buffer.c:1241 __brelse+0x58/0x90
CPU: 2 PID: 72 Comm: kworker/u19:1 Not tainted 6.9.0-dirty #716
RIP: 0010:__brelse+0x58/0x90
Call Trace:
 <TASK>
 __find_get_block+0x6e7/0x810
 bdev_getblk+0x2b/0x480
 __ext4_get_inode_loc+0x48a/0x1240
 ext4_get_inode_loc+0xb2/0x150
 ext4_reserve_inode_write+0xb7/0x230
 __ext4_mark_inode_dirty+0x144/0x6a0
 ext4_ext_insert_extent+0x9c8/0x3230
 ext4_ext_map_blocks+0xf45/0x2dc0
 ext4_map_blocks+0x724/0x1700
 ext4_do_writepages+0x12d6/0x2a70
[...]
============================================

Fixes: ecb94f5fdf4b ("ext4: collapse a single extent tree block into the inode if possible")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-9-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/extents.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1877,6 +1877,7 @@ static void ext4_ext_try_to_merge_up(han
 	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
 
 	brelse(path[1].p_bh);
+	path[1].p_bh = NULL;
 	ext4_free_blocks(handle, inode, NULL, blk, 1,
 			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
 }



