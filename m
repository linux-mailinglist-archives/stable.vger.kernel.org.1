Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1C377A31A
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 23:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjHLVoB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 17:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLVoA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 17:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61FD10DB
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 14:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F74C620A6
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 21:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6540BC433C7;
        Sat, 12 Aug 2023 21:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691876642;
        bh=ubnCisUZ6f+ZkHf5LwomoU3H/KqoX+hPpD3YlGY2Wxg=;
        h=Subject:To:Cc:From:Date:From;
        b=Z53kGSxKqIVGslLqQlacwK+5RCHa0wCAnQNmg0XpkCYipNWEXwg9EbqTa6B3wXz4a
         BH5EABXOnswr69mrhcqWo+985cAYrE+ID0JLIIwIRSxRyIicuLr8+PPZ83nB0iAv03
         VJYi2CCvn9boHoAMqY/1V/SLQRMp4ZiPr3tK2ri8=
Subject: FAILED: patch "[PATCH] btrfs: set cache_block_group_error if we find an error" failed to apply to 4.14-stable tree
To:     josef@toxicpanda.com, dsterba@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 23:44:00 +0200
Message-ID: <2023081259-hammock-private-d316@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 92fb94b69c6accf1e49fff699640fa0ce03dc910
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081259-hammock-private-d316@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 92fb94b69c6accf1e49fff699640fa0ce03dc910 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 2 Aug 2023 09:20:24 -0400
Subject: [PATCH] btrfs: set cache_block_group_error if we find an error

We set cache_block_group_error if btrfs_cache_block_group() returns an
error, this is because we could end up not finding space to allocate and
mistakenly return -ENOSPC, and which could then abort the transaction
with the incorrect errno, and in the case of ENOSPC result in a
WARN_ON() that will trip up tests like generic/475.

However there's the case where multiple threads can be racing, one
thread gets the proper error, and the other thread doesn't actually call
btrfs_cache_block_group(), it instead sees ->cached ==
BTRFS_CACHE_ERROR.  Again the result is the same, we fail to allocate
our space and return -ENOSPC.  Instead we need to set
cache_block_group_error to -EIO in this case to make sure that if we do
not make our allocation we get the appropriate error returned back to
the caller.

CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 911908ea5f6f..f396a9afa403 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4310,8 +4310,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			ret = 0;
 		}
 
-		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
+		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR)) {
+			if (!cache_block_group_error)
+				cache_block_group_error = -EIO;
 			goto loop;
+		}
 
 		if (!find_free_extent_check_size_class(ffe_ctl, block_group))
 			goto loop;

