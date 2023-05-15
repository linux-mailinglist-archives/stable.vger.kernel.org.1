Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347DD703650
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243661AbjEORJC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243441AbjEORIn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916493DD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0799D62ACB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0481DC433EF;
        Mon, 15 May 2023 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170387;
        bh=8HqKZbdm+NdWuMjFruEQj0mnHgrk5sNmmaxBCSov924=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKAwXyUKOFSmWMKcBg+KEtXq13pDuYuWMXSi3h3VKjBc9A3jc37CPX3eel20jvOZl
         oogDFkjSR3tNAo8bnFexmyPLPObPUiu74LjwuW3H8YfhrWZ90fT9ufYMG2PEGJ3QsI
         n6MtX+iMEsuHrB8bb4qTfSmSfMPRTq8W5fJL6/Bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 113/239] btrfs: fix encoded write i_size corruption with no-holes
Date:   Mon, 15 May 2023 18:26:16 +0200
Message-Id: <20230515161725.087577224@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Boris Burkov <boris@bur.io>

commit e7db9e5c6b9615b287d01f0231904fbc1fbde9c5 upstream.

We have observed a btrfs filesystem corruption on workloads using
no-holes and encoded writes via send stream v2. The symptom is that a
file appears to be truncated to the end of its last aligned extent, even
though the final unaligned extent and even the file extent and otherwise
correctly updated inode item have been written.

So if we were writing out a 1MiB+X file via 8 128K extents and one
extent of length X, i_size would be set to 1MiB, but the ninth extent,
nbyte, etc. would all appear correct otherwise.

The source of the race is a narrow (one line of code) window in which a
no-holes fs has read in an updated i_size, but has not yet set a shared
disk_i_size variable to write. Therefore, if two ordered extents run in
parallel (par for the course for receive workloads), the following
sequence can play out: (following "threads" a bit loosely, since there
are callbacks involved for endio but extra threads aren't needed to
cause the issue)

  ENC-WR1 (second to last)                                         ENC-WR2 (last)
  -------                                                          -------
  btrfs_do_encoded_write
    set i_size = 1M
    submit bio B1 ending at 1M
  endio B1
  btrfs_inode_safe_disk_i_size_write
    local i_size = 1M
    falls off a cliff for some reason
							      btrfs_do_encoded_write
								set i_size = 1M+X
								submit bio B2 ending at 1M+X
							      endio B2
							      btrfs_inode_safe_disk_i_size_write
								local i_size = 1M+X
								disk_i_size = 1M+X
    disk_i_size = 1M
							      btrfs_delayed_update_inode
    btrfs_delayed_update_inode

And the delayed inode ends up filled with nbytes=1M+X and isize=1M, and
writes respect i_size and present a corrupted file missing its last
extents.

Fix this by holding the inode lock in the no-holes case so that a thread
can't sneak in a write to disk_i_size that gets overwritten with an out
of date i_size.

Fixes: 41a2ee75aab0 ("btrfs: introduce per-inode file extent tree")
CC: stable@vger.kernel.org # 5.10+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/file-item.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -47,13 +47,13 @@ void btrfs_inode_safe_disk_i_size_write(
 	u64 start, end, i_size;
 	int ret;
 
+	spin_lock(&inode->lock);
 	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
 	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
 		inode->disk_i_size = i_size;
-		return;
+		goto out_unlock;
 	}
 
-	spin_lock(&inode->lock);
 	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
 					 &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
@@ -61,6 +61,7 @@ void btrfs_inode_safe_disk_i_size_write(
 	else
 		i_size = 0;
 	inode->disk_i_size = i_size;
+out_unlock:
 	spin_unlock(&inode->lock);
 }
 


