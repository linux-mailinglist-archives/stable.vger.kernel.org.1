Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBBB7695ED
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 14:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGaMSO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGaMSN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 08:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6011AC
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 05:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EFEA60DF6
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EDEC433C9;
        Mon, 31 Jul 2023 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690805891;
        bh=/hTfaBLzn5kWi9zo6zjgo9+GiMdeBsEdtfB+0nBIe+c=;
        h=Subject:To:Cc:From:Date:From;
        b=Y8wIhvU1fi43U5lj5ro4/1etyPC/zNG8cls8iCtm0Z5dyK/ueBxoIyvmdY8Y4ydr1
         t7pmZe0QLtc6+5VYpGtNFMWq2Vy/b5YZh2beI3Zbl2kiJkrG29ZhZs8shw9Ow5wug8
         1X+Dpwc99EU7iRUCPDdi27IxCOBUgjtmyMriC9Ro=
Subject: FAILED: patch "[PATCH] btrfs: check if the transaction was aborted at" failed to apply to 5.4-stable tree
To:     fdmanana@suse.com, dsterba@suse.com, wqu@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 31 Jul 2023 14:18:05 +0200
Message-ID: <2023073104-derail-catchable-a802@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x bf7ecbe9875061bf3fce1883e3b26b77f847d1e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023073104-derail-catchable-a802@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

bf7ecbe98750 ("btrfs: check if the transaction was aborted at btrfs_wait_for_commit()")
d0c2f4fa555e ("btrfs: make concurrent fsyncs wait less when waiting for a transaction commit")
bf31f87f71cc ("btrfs: add wrapper for transaction abort predicate")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf7ecbe9875061bf3fce1883e3b26b77f847d1e8 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 21 Jul 2023 10:49:20 +0100
Subject: [PATCH] btrfs: check if the transaction was aborted at
 btrfs_wait_for_commit()

At btrfs_wait_for_commit() we wait for a transaction to finish and then
always return 0 (success) without checking if it was aborted, in which
case the transaction didn't happen due to some critical error. Fix this
by checking if the transaction was aborted.

Fixes: 462045928bda ("Btrfs: add START_SYNC, WAIT_SYNC ioctls")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index cf306351b148..f11d803b2c4e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -931,6 +931,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 	}
 
 	wait_for_commit(cur_trans, TRANS_STATE_COMPLETED);
+	ret = cur_trans->aborted;
 	btrfs_put_transaction(cur_trans);
 out:
 	return ret;

