Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0046754E4F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGPKTG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGPKTG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008F186
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE2B060C7D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE321C433C8;
        Sun, 16 Jul 2023 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689502744;
        bh=NhBpBX4Yxy3Tn4aAPGLRUb1AS2W0lrtGfk0z1KQK/mE=;
        h=Subject:To:Cc:From:Date:From;
        b=2XOBk1RFUSlVwI7+WxsRVI5eHXqivlwjHyUSCNcSrwdQQrllTEXxtEMdeJ+5hde12
         YhYeLDByS/h4qFRU1EEJSfoOocqp35Mt9rUynuQPfnYZBFN3yTxPpfBC/FYjBLToyw
         CTn02sJ4BZ/WpxYrdLBI7/2woFXT04I3LpakqJfc=
Subject: FAILED: patch "[PATCH] btrfs: do not BUG_ON() on tree mod log failure at" failed to apply to 5.10-stable tree
To:     fdmanana@suse.com, dsterba@suse.com, wqu@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:19:01 +0200
Message-ID: <2023071601-gristle-construct-2916@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 40b0a749388517de244643c09bdbb98f7dcb6ef1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071601-gristle-construct-2916@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

40b0a7493885 ("btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()")
406808ab2f0b ("btrfs: use booleans where appropriate for the tree mod log functions")
f3a84ccd28d0 ("btrfs: move the tree mod log code into its own file")
dbcc7d57bffc ("btrfs: fix race when cloning extent buffer during rewind of an old root")
cac06d843f25 ("btrfs: introduce the skeleton of btrfs_subpage structure")
1b7ec85ef490 ("btrfs: pass root owner to read_tree_block")
bfb484d922a3 ("btrfs: cleanup extent buffer readahead")
ac5887c8e013 ("btrfs: locking: remove all the blocking helpers")
196d59ab9ccc ("btrfs: switch extent buffer tree lock to rw_semaphore")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40b0a749388517de244643c09bdbb98f7dcb6ef1 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Thu, 8 Jun 2023 11:27:40 +0100
Subject: [PATCH] btrfs: do not BUG_ON() on tree mod log failure at
 __btrfs_cow_block()

At __btrfs_cow_block(), instead of doing a BUG_ON() in case we fail to
record a tree mod log root insertion operation, do a transaction abort
instead. There's really no need for the BUG_ON(), we can properly
release all resources in this context and turn the filesystem to RO mode
and in an error state instead.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8496535828de..d6c29564ce49 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -584,9 +584,14 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
 			parent_start = buf->start;
 
-		atomic_inc(&cow->refs);
 		ret = btrfs_tree_mod_log_insert_root(root->node, cow, true);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		atomic_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
 
 		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,

