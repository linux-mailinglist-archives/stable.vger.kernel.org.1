Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3A7022B8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 06:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjEOENp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 00:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbjEOENg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 00:13:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2779610F3
        for <stable@vger.kernel.org>; Sun, 14 May 2023 21:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED3FE611CC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03771C4339B;
        Mon, 15 May 2023 04:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684124014;
        bh=VXwCyc+CYrnVpgPl5D/X/iED8f8oLu+UAHDr10q8BvY=;
        h=Subject:To:Cc:From:Date:From;
        b=2Umzr/sAlYUeI9iHooAhw8urE5GDdvQGeKYbz8ts7uCHaYCgji3y8QgCnw8IjRNRD
         3myb/Lc8atdB10vCbMS0pyC0XOkitlwMFBtEDGOCEMEOvLdKwYCXWGw2t2uDZsuT5q
         WEVcZKBK2dG5/Rcx9MVe+6tnwNwOUrf5aJEI2ag0=
Subject: FAILED: patch "[PATCH] ext4: check iomap type only if ext4_iomap_begin() does not" failed to apply to 4.14-stable tree
To:     libaokun1@huawei.com, jack@suse.cz, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 15 May 2023 06:13:21 +0200
Message-ID: <2023051521-buckshot-elliptic-0f14@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x fa83c34e3e56b3c672af38059e066242655271b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051521-buckshot-elliptic-0f14@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

fa83c34e3e56 ("ext4: check iomap type only if ext4_iomap_begin() does not fail")
8cd115bdda17 ("ext4: Optimize ext4 DIO overwrites")
aa9714d0e397 ("ext4: Start with shared i_rwsem in case of DIO instead of exclusive")
378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
0b9f230b94dd ("ext4: move inode extension check out from ext4_iomap_alloc()")
569342dc2485 ("ext4: move inode extension/truncate code out from ->iomap_end() callback")
b1b4705d54ab ("ext4: introduce direct I/O read using iomap infrastructure")
09edf4d38195 ("ext4: introduce new callback for IOMAP_REPORT")
f063db5ee989 ("ext4: split IOMAP_WRITE branch in ext4_iomap_begin() into helper")
c8fdfe294187 ("ext4: move set iomap routines into a separate helper ext4_set_iomap()")
2e9b51d78229 ("ext4: iomap that extends beyond EOF should be marked dirty")
548feebec7e9 ("ext4: update direct I/O read lock pattern for IOCB_NOWAIT")
53e5cca56795 ("ext4: reorder map.m_flags checks within ext4_iomap_begin()")
c8cc88163f40 ("ext4: Add support for blocksize < pagesize in dioread_nolock")
2943fdbc688e ("ext4: Refactor mpage_map_and_submit_buffers function")
a00713ea982b ("ext4: Add API to bring in support for unwritten io_end_vec conversion")
821ff38d192a ("ext4: keep uniform naming convention for io & io_end variables")
70cb0d02b581 ("Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa83c34e3e56b3c672af38059e066242655271b1 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Fri, 5 May 2023 21:24:29 +0800
Subject: [PATCH] ext4: check iomap type only if ext4_iomap_begin() does not
 fail

When ext4_iomap_overwrite_begin() calls ext4_iomap_begin() map blocks may
fail for some reason (e.g. memory allocation failure, bare disk write), and
later because "iomap->type ! = IOMAP_MAPPED" triggers WARN_ON(). When ext4
iomap_begin() returns an error, it is normal that the type of iomap->type
may not match the expectation. Therefore, we only determine if iomap->type
is as expected when ext4_iomap_begin() is executed successfully.

Cc: stable@kernel.org
Reported-by: syzbot+08106c4b7d60702dbc14@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/00000000000015760b05f9b4eee9@google.com
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230505132429.714648-1-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3cb774d9e3f1..ce5f21b6c2b3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3377,7 +3377,7 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
 	 */
 	flags &= ~IOMAP_WRITE;
 	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
-	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
+	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
 	return ret;
 }
 

