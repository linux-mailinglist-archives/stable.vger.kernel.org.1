Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8904D791CDD
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbjIDSc1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbjIDSc1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:32:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA394CE2
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68A17B80EF4
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E96C433C8;
        Mon,  4 Sep 2023 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852340;
        bh=1W7EXoN5hKKFBJ5N5qyFGaH2A+KdMXe5QKI3159dN9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0IaJsooOZTOjuxxCJhygcS8Uw7Ilt2GDWpGqkV65ndpapKcemoVWNIQfmlWBL2Px
         TtLenKYi1XCa4rM6B1J9RZGWqNVSZSXw7XAXAezDd/VUgRWAYYg2hP9zD5A5pfxfG/
         bjDERXxoIGP2GwvRcNYve3/7VPCfeS3sByd6uf0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+cdfcae656bac88ba0e2d@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 32/34] nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse
Date:   Mon,  4 Sep 2023 19:30:19 +0100
Message-ID: <20230904182950.098387817@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit cdaac8e7e5a059f9b5e816cda257f08d0abffacd upstream.

A syzbot stress test using a corrupted disk image reported that
mark_buffer_dirty() called from __nilfs_mark_inode_dirty() or
nilfs_palloc_commit_alloc_entry() may output a kernel warning, and can
panic if the kernel is booted with panic_on_warn.

This is because nilfs2 keeps buffer pointers in local structures for some
metadata and reuses them, but such buffers may be forcibly discarded by
nilfs_clear_dirty_page() in some critical situations.

This issue is reported to appear after commit 28a65b49eb53 ("nilfs2: do
not write dirty data after degenerating to read-only"), but the issue has
potentially existed before.

Fix this issue by checking the uptodate flag when attempting to reuse an
internally held buffer, and reloading the metadata instead of reusing the
buffer if the flag was lost.

Link: https://lkml.kernel.org/r/20230818131804.7758-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+cdfcae656bac88ba0e2d@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/0000000000003da75f05fdeffd12@google.com
Fixes: 8c26c4e2694a ("nilfs2: fix issue with flush kernel thread after remount in RO mode because of driver's internal error or metadata corruption")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org> # 3.10+
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/alloc.c |    3 ++-
 fs/nilfs2/inode.c |    7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -205,7 +205,8 @@ static int nilfs_palloc_get_block(struct
 	int ret;
 
 	spin_lock(lock);
-	if (prev->bh && blkoff == prev->blkoff) {
+	if (prev->bh && blkoff == prev->blkoff &&
+	    likely(buffer_uptodate(prev->bh))) {
 		get_bh(prev->bh);
 		*bhp = prev->bh;
 		spin_unlock(lock);
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1025,7 +1025,7 @@ int nilfs_load_inode_block(struct inode
 	int err;
 
 	spin_lock(&nilfs->ns_inode_lock);
-	if (ii->i_bh == NULL) {
+	if (ii->i_bh == NULL || unlikely(!buffer_uptodate(ii->i_bh))) {
 		spin_unlock(&nilfs->ns_inode_lock);
 		err = nilfs_ifile_get_inode_block(ii->i_root->ifile,
 						  inode->i_ino, pbh);
@@ -1034,7 +1034,10 @@ int nilfs_load_inode_block(struct inode
 		spin_lock(&nilfs->ns_inode_lock);
 		if (ii->i_bh == NULL)
 			ii->i_bh = *pbh;
-		else {
+		else if (unlikely(!buffer_uptodate(ii->i_bh))) {
+			__brelse(ii->i_bh);
+			ii->i_bh = *pbh;
+		} else {
 			brelse(*pbh);
 			*pbh = ii->i_bh;
 		}


