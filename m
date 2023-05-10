Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E556FE7FC
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 01:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjEJXL7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbjEJXL7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 19:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE988A1
        for <stable@vger.kernel.org>; Wed, 10 May 2023 16:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB5760BBF
        for <stable@vger.kernel.org>; Wed, 10 May 2023 23:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3727C433EF;
        Wed, 10 May 2023 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683760313;
        bh=gNSFWKDqkLSxdABMt+tJAz7yySpSbafaarlXfGgui9Q=;
        h=Subject:To:Cc:From:Date:From;
        b=eIfRfOrGIetWVaLZWi30UOfvqe6i33Y+gmevW1eZI4BtQY7ITzlZ1s6+sXH/Tsff9
         nOS3uPp/vRGDNS48RIlIOX6Tb5+KKAM5FpW2q5X+VsUaDB/RJYsYiZpznC2yelfBr+
         3dBE1rkDxqfDi/osdy1Z1IWt2spjtU6gSxHTLUXI=
Subject: FAILED: patch "[PATCH] fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()" failed to apply to 6.2-stable tree
To:     zhangpeng362@huawei.com, almaz.alexandrovich@paragon-software.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 11 May 2023 08:11:38 +0900
Message-ID: <2023051138-refueling-ought-706e@gregkh>
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


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x 254e69f284d7270e0abdc023ee53b71401c3ba0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051138-refueling-ought-706e@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

254e69f284d7 ("fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 254e69f284d7270e0abdc023ee53b71401c3ba0c Mon Sep 17 00:00:00 2001
From: ZhangPeng <zhangpeng362@huawei.com>
Date: Fri, 25 Nov 2022 10:21:59 +0000
Subject: [PATCH] fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()

Syzbot reported a null-ptr-deref bug:

ntfs3: loop0: Different NTFS' sector size (1024) and media sector size
(512)
ntfs3: loop0: Mark volume as dirty due to NTFS errors
general protection fault, probably for non-canonical address
0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
RIP: 0010:d_flags_for_inode fs/dcache.c:1980 [inline]
RIP: 0010:__d_add+0x5ce/0x800 fs/dcache.c:2796
Call Trace:
 <TASK>
 d_splice_alias+0x122/0x3b0 fs/dcache.c:3191
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

If the MFT record of ntfs inode is not a base record, inode->i_op can be
NULL. And a null-ptr-deref may happen:

ntfs_lookup()
    dir_search_u() # inode->i_op is set to NULL
    d_splice_alias()
        __d_add()
            d_flags_for_inode() # inode->i_op->get_link null-ptr-deref

Fix this by adding a Check on inode->i_op before calling the
d_splice_alias() function.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Reported-by: syzbot+a8f26a403c169b7593fe@syzkaller.appspotmail.com
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 407fe92394e2..8d206770d8c6 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -88,6 +88,16 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		__putname(uni);
 	}
 
+	/*
+	 * Check for a null pointer
+	 * If the MFT record of ntfs inode is not a base record, inode->i_op can be NULL.
+	 * This causes null pointer dereference in d_splice_alias().
+	 */
+	if (!IS_ERR(inode) && inode->i_op == NULL) {
+		iput(inode);
+		inode = ERR_PTR(-EINVAL);
+	}
+
 	return d_splice_alias(inode, dentry);
 }
 

