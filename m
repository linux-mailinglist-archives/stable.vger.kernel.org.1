Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB937A7D1D
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjITMGr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjITMGq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:06:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FBBF9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:06:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEF3C433C8;
        Wed, 20 Sep 2023 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211593;
        bh=hPA21x/qxxXXCRBKvyhKEXCfQQx6nWH5W/sjrkEbJDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogLcJVrQvEsukfGhbqYWZZbZJMHt8+4eDTj+Rbzxyycu4yMO/FVS44hNyZSm58DQ4
         G25BW8eVPtqzJ5tZU9y+pIAXFCEsnLZXSTwTkdKlt6FFhR8NmlfA7xoQ06uJZI0hpO
         63MZ4KftLTgOgfVLBgwF+WPvIvQ4QTAt9a1QuGho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 150/186] btrfs: output extra debug info if we failed to find an inline backref
Date:   Wed, 20 Sep 2023 13:30:53 +0200
Message-ID: <20230920112842.385259756@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 7f72f50547b7af4ddf985b07fc56600a4deba281 ]

[BUG]
Syzbot reported several warning triggered inside
lookup_inline_extent_backref().

[CAUSE]
As usual, the reproducer doesn't reliably trigger locally here, but at
least we know the WARN_ON() is triggered when an inline backref can not
be found, and it can only be triggered when @insert is true. (I.e.
inserting a new inline backref, which means the backref should already
exist)

[ENHANCEMENT]
After the WARN_ON(), dump all the parameters and the extent tree
leaf to help debug.

Link: https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e59987385673f..deb01e59da027 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1703,6 +1703,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		err = -ENOENT;
 		goto out;
 	} else if (WARN_ON(ret)) {
+		btrfs_print_leaf(path->nodes[0]);
+		btrfs_err(fs_info,
+"extent item not found for insert, bytenr %llu num_bytes %llu parent %llu root_objectid %llu owner %llu offset %llu",
+			  bytenr, num_bytes, parent, root_objectid, owner,
+			  offset);
 		err = -EIO;
 		goto out;
 	}
-- 
2.40.1



