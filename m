Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ADE755466
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjGPU35 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjGPU34 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82123D3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DCD960DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BB3C433C8;
        Sun, 16 Jul 2023 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539394;
        bh=alRoF2r4u/LOYSlw63bqPvhwLo00F56nZB4PX8IDM3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fLgKIOL9mGLIXvupplFYdng/a6ZzLrMICel3qxEOF2hjX35sUzZYfFPDMDb2WTqK
         fsMziBDZtEbVXCIJ9a07SbK52WypZycLdHCJ0TPcw144ahOVLaP4E9aaA0349sR6/T
         h64Ec5I7uUm/Wt+/wS91dP30VSUlj5UW6no/6FPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 763/800] btrfs: add missing error handling when logging operation while COWing extent buffer
Date:   Sun, 16 Jul 2023 21:50:16 +0200
Message-ID: <20230716195006.873044341@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit d09c51521f22f9cbdfb1cf63e5c456077c622c84 upstream.

When COWing an extent buffer that is not the root node, we need to log in
the tree mod log that we replaced a pointer in the parent node, otherwise
a tree mod log user doing a search on the b+tree can return incorrect
results (that miss something). We are doing the call to
btrfs_tree_mod_log_insert_key() but we totally ignore its return value.

So fix this by adding the missing error handling, resulting in a
transaction abort and freeing the COWed extent buffer.

Fixes: f230475e62f7 ("Btrfs: put all block modifications into the tree mod log")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -594,8 +594,14 @@ static noinline int __btrfs_cow_block(st
 		add_root_to_dirty_list(root);
 	} else {
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
-		btrfs_tree_mod_log_insert_key(parent, parent_slot,
-					      BTRFS_MOD_LOG_KEY_REPLACE);
+		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
+						    BTRFS_MOD_LOG_KEY_REPLACE);
+		if (ret) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		btrfs_set_node_blockptr(parent, parent_slot,
 					cow->start);
 		btrfs_set_node_ptr_generation(parent, parent_slot,


