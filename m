Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99775BE42
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjGUGHb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGUGG6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A22A2D45
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA688610A6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63207C433C9;
        Fri, 21 Jul 2023 06:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919602;
        bh=I95HTumpfCwzg0VawN0ZVJRac8jf2Xh176zoK7z6xi8=;
        h=Subject:To:Cc:From:Date:From;
        b=AQ5LPvgrLIzrM1y4yLnaIE+8A/gDB7WgsB3go+KGrsx2o8ho7mBBAVeSW5/DIerNb
         THAaBtg34bFOq+Z3s1QLcn8EHJYqj6WJPL2R9NWLfvjHRVHgIdPpGDp2m+2OuFf2op
         j9Jhz3fqbW4lumuC3xYcIcDP27KTH4JCjY2fc9CA=
Subject: FAILED: patch "[PATCH] ext2/dax: Fix ext2_setsize when len is page aligned" failed to apply to 5.15-stable tree
To:     ritesh.list@gmail.com, djwong@kernel.org, jack@suse.cz
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:06:40 +0200
Message-ID: <2023072139-gently-poster-a61c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fcced95b6ba2a507a83b8b3e0358a8ac16b13e35
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072139-gently-poster-a61c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

fcced95b6ba2 ("ext2/dax: Fix ext2_setsize when len is page aligned")
0cc5b4ce7a37 ("ext2: remove nobh support")
67235182a41c ("mm/migrate: Convert buffer_migrate_page() to buffer_migrate_folio()")
eca66389744d ("ocfs2: Convert to release_folio")
f132ab7d3ab0 ("fs: Convert mpage_readpage to mpage_read_folio")
9d6b0cd75798 ("fs: Remove flags parameter from aops->write_begin")
8371f30cf774 ("fs: Remove aop flags parameter from nobh_write_begin()")
e621900ad28b ("fs: Convert __set_page_dirty_buffers to block_dirty_folio")
7ba13abbd31e ("fs: Turn block_invalidatepage into block_invalidate_folio")
128d1f8241d6 ("fs: Add invalidate_folio() aops method")
5ad6b2bdaaea ("fs: Turn do_invalidatepage() into folio_invalidate()")
3acbdbf42e94 ("Merge tag 'libnvdimm-for-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fcced95b6ba2a507a83b8b3e0358a8ac16b13e35 Mon Sep 17 00:00:00 2001
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Date: Fri, 21 Apr 2023 15:16:11 +0530
Subject: [PATCH] ext2/dax: Fix ext2_setsize when len is page aligned

PAGE_ALIGN(x) macro gives the next highest value which is multiple of
pagesize. But if x is already page aligned then it simply returns x.
So, if x passed is 0 in dax_zero_range() function, that means the
length gets passed as 0 to ->iomap_begin().

In ext2 it then calls ext2_get_blocks -> max_blocks as 0 and hits bug_on
here in ext2_get_blocks().
	BUG_ON(maxblocks == 0);

Instead we should be calling dax_truncate_page() here which takes
care of it. i.e. it only calls dax_zero_range if the offset is not
page/block aligned.

This can be easily triggered with following on fsdax mounted pmem
device.

dd if=/dev/zero of=file count=1 bs=512
truncate -s 0 file

[79.525838] EXT2-fs (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[79.529376] ext2 filesystem being mounted at /mnt1/test supports timestamps until 2038 (0x7fffffff)
[93.793207] ------------[ cut here ]------------
[93.795102] kernel BUG at fs/ext2/inode.c:637!
[93.796904] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[93.798659] CPU: 0 PID: 1192 Comm: truncate Not tainted 6.3.0-rc2-xfstests-00056-g131086faa369 #139
[93.806459] RIP: 0010:ext2_get_blocks.constprop.0+0x524/0x610
<...>
[93.835298] Call Trace:
[93.836253]  <TASK>
[93.837103]  ? lock_acquire+0xf8/0x110
[93.838479]  ? d_lookup+0x69/0xd0
[93.839779]  ext2_iomap_begin+0xa7/0x1c0
[93.841154]  iomap_iter+0xc7/0x150
[93.842425]  dax_zero_range+0x6e/0xa0
[93.843813]  ext2_setsize+0x176/0x1b0
[93.845164]  ext2_setattr+0x151/0x200
[93.846467]  notify_change+0x341/0x4e0
[93.847805]  ? lock_acquire+0xf8/0x110
[93.849143]  ? do_truncate+0x74/0xe0
[93.850452]  ? do_truncate+0x84/0xe0
[93.851739]  do_truncate+0x84/0xe0
[93.852974]  do_sys_ftruncate+0x2b4/0x2f0
[93.854404]  do_syscall_64+0x3f/0x90
[93.855789]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

CC: stable@vger.kernel.org
Fixes: 2aa3048e03d3 ("iomap: switch iomap_zero_range to use iomap_iter")
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <046a58317f29d9603d1068b2bbae47c2332c17ae.1682069716.git.ritesh.list@gmail.com>

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 26f135e7ffce..dc76147e7b07 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1259,9 +1259,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	inode_dio_wait(inode);
 
 	if (IS_DAX(inode))
-		error = dax_zero_range(inode, newsize,
-				       PAGE_ALIGN(newsize) - newsize, NULL,
-				       &ext2_iomap_ops);
+		error = dax_truncate_page(inode, newsize, NULL,
+					  &ext2_iomap_ops);
 	else
 		error = block_truncate_page(inode->i_mapping,
 				newsize, ext2_get_block);

