Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF56FAE72
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjEHLo6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjEHLog (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBE310A07
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E9326367D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A786C4339B;
        Mon,  8 May 2023 11:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546241;
        bh=7vmQrYF7q/34xC0SNPHT++e7H8K9Wk9o2nxkom5ATFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWBK3gfZ1KjtQ+NbM4JMNSS12DaRre68hv6YKcPlv7zlmQ068yGa/alzF1JLuRXG/
         PBQwUeKCQrY8a2UnjThccQkCKDjwcY87Id/t1j2YUqe5cye9khQ2RWAS0SbZmt/jq3
         BecLapY0gSKpcXqjIANWQVTcBIMDbOFfrrBtvT+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+9c2811fd56591639ff5f@syzkaller.appspotmail.com,
        Zeng Heng <zengheng4@huawei.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 304/371] fs/ntfs3: Fix slab-out-of-bounds read in hdr_delete_de()
Date:   Mon,  8 May 2023 11:48:25 +0200
Message-Id: <20230508094824.123445642@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Zeng Heng <zengheng4@huawei.com>

[ Upstream commit ab84eee4c7ab929996602eda7832854c35a6dda2 ]

Here is a BUG report from syzbot:

BUG: KASAN: slab-out-of-bounds in hdr_delete_de+0xe0/0x150 fs/ntfs3/index.c:806
Read of size 16842960 at addr ffff888079cc0600 by task syz-executor934/3631

Call Trace:
 memmove+0x25/0x60 mm/kasan/shadow.c:54
 hdr_delete_de+0xe0/0x150 fs/ntfs3/index.c:806
 indx_delete_entry+0x74f/0x3670 fs/ntfs3/index.c:2193
 ni_remove_name+0x27a/0x980 fs/ntfs3/frecord.c:2910
 ntfs_unlink_inode+0x3d4/0x720 fs/ntfs3/inode.c:1712
 ntfs_rename+0x41a/0xcb0 fs/ntfs3/namei.c:276

Before using the meta-data in struct INDEX_HDR, we need to
check index header valid or not. Otherwise, the corruptedi
(or malicious) fs image can cause out-of-bounds access which
could make kernel panic.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Reported-by: syzbot+9c2811fd56591639ff5f@syzkaller.appspotmail.com
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c   | 2 +-
 fs/ntfs3/index.c   | 4 ++++
 fs/ntfs3/ntfs_fs.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 88218831527c2..59f813cbdaa8e 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2575,7 +2575,7 @@ static int read_next_log_rec(struct ntfs_log *log, struct lcb *lcb, u64 *lsn)
 	return find_log_rec(log, *lsn, lcb);
 }
 
-static inline bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes)
+bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes)
 {
 	__le16 mask;
 	u32 min_de, de_off, used, total;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 37688cf6e3d05..f62e0df7a7b4e 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -802,6 +802,10 @@ static inline struct NTFS_DE *hdr_delete_de(struct INDEX_HDR *hdr,
 	u32 off = PtrOffset(hdr, re);
 	int bytes = used - (off + esize);
 
+	/* check INDEX_HDR valid before using INDEX_HDR */
+	if (!check_index_header(hdr, le32_to_cpu(hdr->total)))
+		return NULL;
+
 	if (off >= used || esize < sizeof(struct NTFS_DE) ||
 	    bytes < sizeof(struct NTFS_DE))
 		return NULL;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 8aaec7e0804ef..e571e7643596e 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -575,6 +575,7 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 bool ni_is_dirty(struct inode *inode);
 
 /* Globals from fslog.c */
+bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
 int log_replay(struct ntfs_inode *ni, bool *initialized);
 
 /* Globals from fsntfs.c */
-- 
2.39.2



