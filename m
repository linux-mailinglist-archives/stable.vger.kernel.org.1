Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B4755447
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjGPU2k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjGPU2k (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:28:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D829F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B3C60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A81C433C8;
        Sun, 16 Jul 2023 20:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539316;
        bh=efCbspyroixbJA/CraV/nl7DXydC2xlMfnXf3gnB8+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzkXnizzog+cGdIwiHQzc1wcFTzkXfRjvSB7aOw1zc/Amc9ItL0wQC+71tYplfGgn
         Se2YL/RZSF4HMM+QGHvzZ0Hgs08wS/zLkh//Ir7S7fYsFTG+Ypx6X5RBZ1B+51E4Rd
         1PFw3Jhnuz2Xi51/3UIfTLZcllw4kBTeGq8eh4/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 765/800] btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()
Date:   Sun, 16 Jul 2023 21:50:18 +0200
Message-ID: <20230716195006.919201337@linuxfoundation.org>
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

commit 40b0a749388517de244643c09bdbb98f7dcb6ef1 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -583,9 +583,14 @@ static noinline int __btrfs_cow_block(st
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


