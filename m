Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFA75D49A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjGUTXA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjGUTW7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C31727
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE6461D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E712C433C9;
        Fri, 21 Jul 2023 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967377;
        bh=i8UTBl3mjBQ0/x6L3xSnQkIlQSHH35Ae/pt/60VrIPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeR2WlqxBiMHmxVrmi/MjdrNk4trcCOO6H3Ta5vaSLMqkcGVszZiF6iLgrbwztxLj
         CtiP5n8YHcsoyoo2uNhKRKeesuj4DUCUlfEDLv07VbhgU8cVKVACd6+dty00/hFXq1
         Nblixqw8qlY8ciexfS4jiszvUi7GmGkbp46nRLfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 6.1 113/223] ext2/dax: Fix ext2_setsize when len is page aligned
Date:   Fri, 21 Jul 2023 18:06:06 +0200
Message-ID: <20230721160525.689090100@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

commit fcced95b6ba2a507a83b8b3e0358a8ac16b13e35 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext2/inode.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1265,9 +1265,8 @@ static int ext2_setsize(struct inode *in
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


