Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841727E23B9
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjKFNN5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjKFNN4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:13:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7572100
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:13:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB99C433C8;
        Mon,  6 Nov 2023 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276432;
        bh=VjMR2W0hr/3qYMG6WlwNLeUpMrUj6GlUKHs/I6Jjy8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2mfEPyGc7Xe/AKDehsBIC1K7/I8kRmj76a4YRKloteqN7T3bGVxchOYLe0qm4xsBm
         9ay6gIw6JElfF/2HAN6lllWf7etJ2qjWM1vlDzYwkNnBWpBqPPvh0K+L5Inmr54bMR
         CehJp/dxrRFM+lOzN41k23aWrXcXgVSF4PLvgico=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 12/62] fs/ntfs3: Write immediately updated ntfs state
Date:   Mon,  6 Nov 2023 14:03:18 +0100
Message-ID: <20231106130302.270309184@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 06ccfb00645990a9fcc14249e6d1c25921ecb836 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 9c0fc3a29d0c9..873b1434a9989 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -953,18 +953,11 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 	if (err)
 		return err;
 
-	mark_inode_dirty(&ni->vfs_inode);
+	mark_inode_dirty_sync(&ni->vfs_inode);
 	/* verify(!ntfs_update_mftmirr()); */
 
-	/*
-	 * If we used wait=1, sync_inode_metadata waits for the io for the
-	 * inode to finish. It hangs when media is removed.
-	 * So wait=0 is sent down to sync_inode_metadata
-	 * and filemap_fdatawrite is used for the data blocks.
-	 */
-	err = sync_inode_metadata(&ni->vfs_inode, 0);
-	if (!err)
-		err = filemap_fdatawrite(ni->vfs_inode.i_mapping);
+	/* write mft record on disk. */
+	err = _ni_write_inode(&ni->vfs_inode, 1);
 
 	return err;
 }
-- 
2.42.0



