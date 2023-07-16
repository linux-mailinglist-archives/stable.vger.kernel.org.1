Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6420755363
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGPUSa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGPUS3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8A90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68CF560EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FC8C433C7;
        Sun, 16 Jul 2023 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538707;
        bh=Ivuf+0SuMYrUq0yJBznwxLtuVdQP/7bUl4P8Ejn9llE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HV7dbWbIseLHCTPDe63VU1Za/BhBR+7EYWD1bHX1l7OV1sQz3+f2U/V2Ax2AUwJHa
         bpGBC++9R6bYj4tn+A//HUJXwEbUY1wj8jqfWDoPWFkSgMe8msZnOrGGaJgoeZM0G9
         KTUxfDuQfMzYeZ4RkkTNZZyjgDDULPgz2H3DxgeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 530/800] btrfs: do not BUG_ON() on tree mod log failure at balance_level()
Date:   Sun, 16 Jul 2023 21:46:23 +0200
Message-ID: <20230716195001.404517473@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit 39020d8abc7ec62c4de9b260e3d10d4a1c2478ce upstream.

At balance_level(), instead of doing a BUG_ON() in case we fail to record
tree mod log operations, do a transaction abort and return the error to
the callers. There's really no need for the BUG_ON() as we can release
all resources in this context, and we have to abort because other future
tree searches that use the tree mod log (btrfs_search_old_slot()) may get
inconsistent results if other operations modify the tree after that
failure and before the tree mod log based search.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1042,7 +1042,12 @@ static noinline int balance_level(struct
 		}
 
 		ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_tree_unlock(child);
+			free_extent_buffer(child);
+			btrfs_abort_transaction(trans, ret);
+			goto enospc;
+		}
 		rcu_assign_pointer(root->node, child);
 
 		add_root_to_dirty_list(root);
@@ -1130,7 +1135,10 @@ static noinline int balance_level(struct
 			btrfs_node_key(right, &right_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
 					BTRFS_MOD_LOG_KEY_REPLACE);
-			BUG_ON(ret < 0);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto enospc;
+			}
 			btrfs_set_node_key(parent, &right_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
 		}
@@ -1176,7 +1184,10 @@ static noinline int balance_level(struct
 		btrfs_node_key(mid, &mid_key, 0);
 		ret = btrfs_tree_mod_log_insert_key(parent, pslot,
 						    BTRFS_MOD_LOG_KEY_REPLACE);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto enospc;
+		}
 		btrfs_set_node_key(parent, &mid_key, pslot);
 		btrfs_mark_buffer_dirty(parent);
 	}


