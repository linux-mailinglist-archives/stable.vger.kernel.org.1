Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CCA703A40
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbjEORuJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbjEORtt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3847218A8E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E946B62EC7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01933C433EF;
        Mon, 15 May 2023 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172864;
        bh=FuBBhW+Fb+wpfcQoxvDf4Xp4kQxaDmn4xLUi0Qa+KpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bk8Obo4biXZw6TnuzamXcVkQRqOZEt0fUyih9cA8U6JK9vGXuhnWIvt6ibLyuewbx
         eoZSymEAnpmUN16JCUyd7KhEo+LuMOQfxfEcn0O8W6Bj2gcuXwu05rkdwL5c73BvAu
         uPuZyOfycr3Me48MkmmzrVPma08D79QToJaqA7Js=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 261/381] ext4: fix use-after-free read in ext4_find_extent for bigalloc + inline
Date:   Mon, 15 May 2023 18:28:32 +0200
Message-Id: <20230515161748.521117945@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 835659598c67907b98cd2aa57bb951dfaf675c69 ]

Syzbot found the following issue:
loop0: detected capacity change from 0 to 2048
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
==================================================================
BUG: KASAN: use-after-free in ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
BUG: KASAN: use-after-free in ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
Read of size 4 at addr ffff888073644750 by task syz-executor420/5067

CPU: 0 PID: 5067 Comm: syz-executor420 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
 ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
 ext4_clu_mapped+0x117/0x970 fs/ext4/extents.c:5809
 ext4_insert_delayed_block fs/ext4/inode.c:1696 [inline]
 ext4_da_map_blocks fs/ext4/inode.c:1806 [inline]
 ext4_da_get_block_prep+0x9e8/0x13c0 fs/ext4/inode.c:1870
 ext4_block_write_begin+0x6a8/0x2290 fs/ext4/inode.c:1098
 ext4_da_write_begin+0x539/0x760 fs/ext4/inode.c:3082
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
 ext4_file_write_iter+0x1d0/0x18f0
 call_write_iter include/linux/fs.h:2186 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4b7a9737b9
RSP: 002b:00007ffc5cac3668 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4b7a9737b9
RDX: 00000000175d9003 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f4b7a933050 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000079f R11: 0000000000000246 R12: 00007f4b7a9330e0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Above issue is happens when enable bigalloc and inline data feature. As
commit 131294c35ed6 fixed delayed allocation bug in ext4_clu_mapped for
bigalloc + inline. But it only resolved issue when has inline data, if
inline data has been converted to extent(ext4_da_convert_inline_data_to_extent)
before writepages, there is no EXT4_STATE_MAY_INLINE_DATA flag. However
i_data is still store inline data in this scene. Then will trigger UAF
when find extent.
To resolve above issue, there is need to add judge "ext4_has_inline_data(inode)"
in ext4_clu_mapped().

Fixes: 131294c35ed6 ("ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline")
Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/20230406111627.1916759-1-tudor.ambarus@linaro.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 6c06ce9dd6bd8..2c2e1cc43e0e8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5805,7 +5805,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 	 * mapped - no physical clusters have been allocated, and the
 	 * file has no extents
 	 */
-	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) ||
+	    ext4_has_inline_data(inode))
 		return 0;
 
 	/* search for the extent closest to the first block in the cluster */
-- 
2.39.2



