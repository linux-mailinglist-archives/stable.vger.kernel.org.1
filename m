Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6367A7EBB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjITMUV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjITMUN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:20:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D07F93
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:20:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F8AC433C8;
        Wed, 20 Sep 2023 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212407;
        bh=d75NEs53D+MrAnB5JU+rQffFL7BUU9/n6Hg+6jPN+Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geFZGm6XTBwtYOmHvoipCEyfK7x1/Gss+ype7CXbFVbkBd63LYDqwYt+XbmB/x+VC
         BOEIu2OCszEZpoSPc04+L878Mvmxf3IcRA3m6ujakMGlUr7Wj+Va/6Krp0J6+OPjzX
         QVo5FA/goeeZWNg3M5TDsoUSZeiiQigJbPcZry34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 238/273] btrfs: output extra debug info if we failed to find an inline backref
Date:   Wed, 20 Sep 2023 13:31:18 +0200
Message-ID: <20230920112853.706283568@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index d71f800e8bf60..bb05b0a82c8ba 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1549,6 +1549,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
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



