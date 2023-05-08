Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71F6FA8EF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjEHKqd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjEHKqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:46:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0C26E86
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B62C6628B3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8385C433EF;
        Mon,  8 May 2023 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542748;
        bh=TK7+vglgGcrJ+yIpt4V833bB+fthppqXYskoSxF1zO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnFDIQpQK2TYS7WKvC3OKlTPWxxdm+k73CxKTiP6ZAa2oYfFKFJSfNNZm9jibosBZ
         d3Y/eTMqml3pR6q1OnEUyAj3Wcstf59/92AZmLbeyQGyI3syjR1CFRr04frzFVfwkf
         9d6RBdh5VtBqvyoszpkL29ZFKTRw6tjc43Zf/O8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+a8f26a403c169b7593fe@syzkaller.appspotmail.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 536/663] fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()
Date:   Mon,  8 May 2023 11:46:02 +0200
Message-Id: <20230508094446.349135692@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

[ Upstream commit 254e69f284d7270e0abdc023ee53b71401c3ba0c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/namei.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index c8db35e2ae172..3db34d5c03dc7 100644
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
 
-- 
2.39.2



