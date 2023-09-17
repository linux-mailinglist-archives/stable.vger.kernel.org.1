Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366257A3C12
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbjIQU0O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbjIQU0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:26:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E510B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:25:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BA3C433C8;
        Sun, 17 Sep 2023 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982359;
        bh=07TZftQeWRhSku28gLhFpUpxyta9Btg4/2uXBlQXisI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1bcQTiK++ImDpyyn0F0+E9GpG5lBdyBY5XuEE4lAIv3UJyRjWQXhT3KBwXf9/Htq
         OUuqKyq6rVILi00NQDcru/7m8uB14KJZFsranUOAaQDxWWKji+QxfQk8qpOOmDaT+G
         XOSWpKxpEAPrbiFPd6v/zhehYy3iXFOvCuUflYLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksei Filippov <halip0503@gmail.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Subject: [PATCH 5.15 228/511] jfs: validate max amount of blocks before allocation.
Date:   Sun, 17 Sep 2023 21:10:55 +0200
Message-ID: <20230917191119.314302300@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Filippov <halip0503@gmail.com>

[ Upstream commit 0225e10972fa809728b8d4c1bd2772b3ec3fdb57 ]

The lack of checking bmp->db_max_freebud in extBalloc() can lead to
shift out of bounds, so this patch prevents undefined behavior, because
bmp->db_max_freebud == -1 only if there is no free space.

Signed-off-by: Aleksei Filippov <halip0503@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_extent.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index bb4a342a193d4..6420b6749d48f 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -508,6 +508,11 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
 	 * blocks in the map. in that case, we'll start off with the
 	 * maximum free.
 	 */
+
+	/* give up if no space left */
+	if (bmp->db_maxfreebud == -1)
+		return -ENOSPC;
+
 	max = (s64) 1 << bmp->db_maxfreebud;
 	if (*nblocks >= max && *nblocks > nbperpage)
 		nb = nblks = (max > nbperpage) ? max : nbperpage;
-- 
2.40.1



