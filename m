Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB56FAE6D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbjEHLon (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjEHLo1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253AF423A6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B3663626
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB43C433D2;
        Mon,  8 May 2023 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546229;
        bh=EqagkdeRNuNe4SklnDsc3XOd2KWiWQmNAHWLKGvDmHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9x0hsKuvGwRvJ+3jhD9rgN1kkqFBQTD7ZFTw9tQtQCEhN5CaWNWsOCngMqwo1Fdu
         45/y6WKVFp18NQBEYtRWwr6nrTtZzdC7IM6kG7TeA9Er4wBt8u2EJIucEj95PRNptM
         QXzzo9KPeTrkd6VnUO39PCzmXe+NS/5kTlTc2PPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen Zhongjin <chenzhongjin@huawei.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 300/371] fs/ntfs3: Fix memory leak if ntfs_read_mft failed
Date:   Mon,  8 May 2023 11:48:21 +0200
Message-Id: <20230508094823.966016981@linuxfoundation.org>
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

From: Chen Zhongjin <chenzhongjin@huawei.com>

[ Upstream commit bfa434c60157c9793e9b12c9b68ade02aff9f803 ]

Label ATTR_ROOT in ntfs_read_mft() sets is_root = true and
ni->ni_flags |= NI_FLAG_DIR, then next attr will goto label ATTR_ALLOC
and alloc ni->dir.alloc_run. However two states are not always
consistent and can make memory leak.

 1) attr_name in ATTR_ROOT does not fit the condition it will set
 is_root = true but NI_FLAG_DIR is not set.
 2) next attr_name in ATTR_ALLOC fits the condition and alloc
 ni->dir.alloc_run
 3) in cleanup function ni_clear(), when NI_FLAG_DIR is set, it frees
 ni->dir.alloc_run, otherwise it frees ni->file.run
 4) because NI_FLAG_DIR is not set in this case, ni->dir.alloc_run is
 leaked as kmemleak reported:

unreferenced object 0xffff888003bc5480 (size 64):
  backtrace:
    [<000000003d42e6b0>] __kmalloc_node+0x4e/0x1c0
    [<00000000d8e19b8a>] kvmalloc_node+0x39/0x1f0
    [<00000000fc3eb5b8>] run_add_entry+0x18a/0xa40 [ntfs3]
    [<0000000011c9f978>] run_unpack+0x75d/0x8e0 [ntfs3]
    [<00000000e7cf1819>] run_unpack_ex+0xbc/0x500 [ntfs3]
    [<00000000bbf0a43d>] ntfs_iget5+0xb25/0x2dd0 [ntfs3]
    [<00000000a6e50693>] ntfs_fill_super+0x218d/0x3580 [ntfs3]
    [<00000000b9170608>] get_tree_bdev+0x3fb/0x710
    [<000000004833798a>] vfs_get_tree+0x8e/0x280
    [<000000006e20b8e6>] path_mount+0xf3c/0x1930
    [<000000007bf15a5f>] do_mount+0xf3/0x110
    ...

Fix this by always setting is_root and NI_FLAG_DIR together.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 136236a25da60..359eff346910e 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -257,7 +257,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			goto out;
 
 		root = Add2Ptr(attr, roff);
-		is_root = true;
 
 		if (attr->name_len != ARRAY_SIZE(I30_NAME) ||
 		    memcmp(attr_name(attr), I30_NAME, sizeof(I30_NAME)))
@@ -270,6 +269,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		if (!is_dir)
 			goto next_attr;
 
+		is_root = true;
 		ni->ni_flags |= NI_FLAG_DIR;
 
 		err = indx_init(&ni->dir, sbi, attr, INDEX_MUTEX_I30);
-- 
2.39.2



