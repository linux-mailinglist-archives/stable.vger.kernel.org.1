Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28C7ED324
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjKOUq1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjKOUq0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD374BC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3083EC433C7;
        Wed, 15 Nov 2023 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081182;
        bh=8JVZBlAIfDDgam422cNFAA/nmpNz+nzxDQsr6N5vxts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKfMRP2J+/Idd+iEsxmhX8lF3+qgpDhN0ug1VA9LgftmYD9xbZnevRn5NXz8Zr38Q
         xQV7QbkhV4jLIBcG9GynBAP+pC4k8KtMx1uu3mzsHfwRiqN8w3hVy3esQZtLcaBr1Q
         IUstQBbvRes6v0U0t36eoCytbvrV8uXPwW9xRW8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 88/88] btrfs: use u64 for buffer sizes in the tree search ioctls
Date:   Wed, 15 Nov 2023 15:36:40 -0500
Message-ID: <20231115191431.338512411@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit dec96fc2dcb59723e041416b8dc53e011b4bfc2e ]

In the tree search v2 ioctl we use the type size_t, which is an unsigned
long, to track the buffer size in the local variable 'buf_size'. An
unsigned long is 32 bits wide on a 32 bits architecture. The buffer size
defined in struct btrfs_ioctl_search_args_v2 is a u64, so when we later
try to copy the local variable 'buf_size' to the argument struct, when
the search returns -EOVERFLOW, we copy only 32 bits which will be a
problem on big endian systems.

Fix this by using a u64 type for the buffer sizes, not only at
btrfs_ioctl_tree_search_v2(), but also everywhere down the call chain
so that we can use the u64 at btrfs_ioctl_tree_search_v2().

Fixes: cc68a8a5a433 ("btrfs: new ioctl TREE_SEARCH_V2")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/linux-btrfs/ce6f4bd6-9453-4ffe-ba00-cee35495e10f@moroto.mountain/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e3f18edc1afee..23beabb489231 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2045,7 +2045,7 @@ static noinline int key_in_sk(struct btrfs_key *key,
 static noinline int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
 			       struct btrfs_ioctl_search_key *sk,
-			       size_t *buf_size,
+			       u64 *buf_size,
 			       char __user *ubuf,
 			       unsigned long *sk_offset,
 			       int *num_found)
@@ -2177,7 +2177,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 
 static noinline int search_ioctl(struct inode *inode,
 				 struct btrfs_ioctl_search_key *sk,
-				 size_t *buf_size,
+				 u64 *buf_size,
 				 char __user *ubuf)
 {
 	struct btrfs_fs_info *info = btrfs_sb(inode->i_sb);
@@ -2249,7 +2249,7 @@ static noinline int btrfs_ioctl_tree_search(struct file *file,
 	struct btrfs_ioctl_search_key sk;
 	struct inode *inode;
 	int ret;
-	size_t buf_size;
+	u64 buf_size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -2283,8 +2283,8 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
 	struct btrfs_ioctl_search_args_v2 args;
 	struct inode *inode;
 	int ret;
-	size_t buf_size;
-	const size_t buf_limit = SZ_16M;
+	u64 buf_size;
+	const u64 buf_limit = SZ_16M;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-- 
2.42.0



