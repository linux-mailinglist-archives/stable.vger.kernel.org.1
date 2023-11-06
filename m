Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5A7E240B
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjKFNR2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjKFNR1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:17:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADA91
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:17:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087D7C433C7;
        Mon,  6 Nov 2023 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276644;
        bh=2esReb3NOlhtVSyL8vFUAHo1aOaRNgTkV6tYltet7i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tz1WojZjLDIO3hcxJOlp2tubmYtk0N7piJpQ95BlNhv/NwfkZaj8fS5qxdfOi8g7X
         fWyGFgxPuWyq6qkVYzw1Er8KAn0Go5CttmdwQSiVS4FKZNwaf185EX5qeAKABwt21f
         e9V9JKlg37qaza4d4qAXE6N+ml/8hY3EM63JyBE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 20/88] fs/ntfs3: Write immediately updated ntfs state
Date:   Mon,  6 Nov 2023 14:03:14 +0100
Message-ID: <20231106130306.524494450@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 06ccfb00645990a9fcc14249e6d1c25921ecb836 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 9ddb2ab23b954..fbfe21dbb4259 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -983,18 +983,11 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
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



