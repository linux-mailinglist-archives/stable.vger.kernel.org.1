Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F00754E5B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGPKXg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGPKXe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7DB1BE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B086460C79
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA5CC433C8;
        Sun, 16 Jul 2023 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689503013;
        bh=4q8rkkp9pN+b+/GJsAnYUVvC/j6HUJjt2HDzqbMayfs=;
        h=Subject:To:Cc:From:Date:From;
        b=Gu9Rkg/8ofBaq3XvihONAu9LORlcsUh0EP2UwI9WlzJS4quQZaWXBedvEQ1TtWGls
         NQJtDmqR0SVGUHiAT60tMk7lbng6VJR1XMcjn1ft27fAj/P6bYddj0mZM200wUed3d
         1P3oSPx74DWK/R5EnwRW28b961RGbIR9BWp7bG3w=
Subject: FAILED: patch "[PATCH] btrfs: fix extent buffer leak after tree mod log failure at" failed to apply to 5.10-stable tree
To:     fdmanana@suse.com, dsterba@suse.com, wqu@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:23:17 +0200
Message-ID: <2023071617-easeful-catlike-d302@gregkh>
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
git cherry-pick -x ede600e497b1461d06d22a7d17703d9096868bc3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071617-easeful-catlike-d302@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

ede600e497b1 ("btrfs: fix extent buffer leak after tree mod log failure at split_node()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ede600e497b1461d06d22a7d17703d9096868bc3 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Thu, 8 Jun 2023 11:27:38 +0100
Subject: [PATCH] btrfs: fix extent buffer leak after tree mod log failure at
 split_node()

At split_node(), if we fail to log the tree mod log copy operation, we
return without unlocking the split extent buffer we just allocated and
without decrementing the reference we own on it. Fix this by unlocking
it and decrementing the ref count before returning.

Fixes: 5de865eebb83 ("Btrfs: fix tree mod logging")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7f7f13965fe9..8496535828de 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3053,6 +3053,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
 	if (ret) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}

