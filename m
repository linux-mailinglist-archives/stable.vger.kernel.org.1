Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F597A305A
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIPMzR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjIPMyv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:54:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F31AD
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:54:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6547AC433C8;
        Sat, 16 Sep 2023 12:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694868885;
        bh=tf0UhxKiDvD8w1WxUwx7WZMVVB+ynT8OG1LKLMvH+Ww=;
        h=Subject:To:Cc:From:Date:From;
        b=xJZsy4KES9OtMuGFrp56MxlQ/bwPjVOpZFCh2RxDmrnuH/qryQVn/R021hJlz4ALk
         rYPmPHuQsyr/cWDE9OlPfbiBrSZLHQGm4u4UCq1+1yjBTSK/q6M7o96cI8sMouW33I
         jfrP6NgyVcrIGlQnpw/kmWBp73qhwmo7OFpiyEko=
Subject: FAILED: patch "[PATCH] btrfs: don't start transaction when joining with" failed to apply to 4.14-stable tree
To:     fdmanana@suse.com, dsterba@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:54:42 +0200
Message-ID: <2023091642-bonding-pessimism-6fe2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 4490e803e1fe9fab8db5025e44e23b55df54078b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091642-bonding-pessimism-6fe2@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

4490e803e1fe ("btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4490e803e1fe9fab8db5025e44e23b55df54078b Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Wed, 26 Jul 2023 16:56:57 +0100
Subject: [PATCH] btrfs: don't start transaction when joining with
 TRANS_JOIN_NOSTART

When joining a transaction with TRANS_JOIN_NOSTART, if we don't find a
running transaction we end up creating one. This goes against the purpose
of TRANS_JOIN_NOSTART which is to join a running transaction if its state
is at or below the state TRANS_STATE_COMMIT_START, otherwise return an
-ENOENT error and don't start a new transaction. So fix this to not create
a new transaction if there's no running transaction at or below that
state.

CC: stable@vger.kernel.org # 4.14+
Fixes: a6d155d2e363 ("Btrfs: fix deadlock between fiemap and transaction commits")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 815f61d6b506..6a2a12593183 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -292,10 +292,11 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->trans_lock);
 
 	/*
-	 * If we are ATTACH, we just want to catch the current transaction,
-	 * and commit it. If there is no transaction, just return ENOENT.
+	 * If we are ATTACH or TRANS_JOIN_NOSTART, we just want to catch the
+	 * current transaction, and commit it. If there is no transaction, just
+	 * return ENOENT.
 	 */
-	if (type == TRANS_ATTACH)
+	if (type == TRANS_ATTACH || type == TRANS_JOIN_NOSTART)
 		return -ENOENT;
 
 	/*

