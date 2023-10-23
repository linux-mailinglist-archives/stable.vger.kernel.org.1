Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA17D3466
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjJWLjU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjJWLjT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:39:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC4EE4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:39:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BA9C433C8;
        Mon, 23 Oct 2023 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061157;
        bh=NWFJwP6bqD1rR5TYHK1nXKlmJFI2WY11MrqN+LDM8o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AiE0Ym5mec6Z+6BAsjJLR1dToMzUs4tB4rKL4DsUHNUpEi9CEJ/ZCTkUQXq43BrT7
         p6y24Xpzx5gGK/HtKBRBOrpB/ZR8UQaipVS9Ksllh6NchzoTfl3AFD7fktoLfE6NYW
         1TsFlAs5aDAdeVIWXDW9kRgpyPlq8r4qGRmA8uBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 092/137] btrfs: error out when COWing block using a stale transaction
Date:   Mon, 23 Oct 2023 12:57:29 +0200
Message-ID: <20231023104824.003250697@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 48774f3bf8b4dd3b1a0e155825c9ce48483db14c ]

At btrfs_cow_block() we have these checks to verify we are not using a
stale transaction (a past transaction with an unblocked state or higher),
and the only thing we do is to trigger a WARN with a message and a stack
trace. This however is a critical problem, highly unexpected and if it
happens it's most likely due to a bug, so we should error out and turn the
fs into error state so that such issue is much more easily noticed if it's
triggered.

The problem is critical because using such stale transaction will lead to
not persisting the extent buffer used for the COW operation, as allocating
a tree block adds the range of the respective extent buffer to the
->dirty_pages iotree of the transaction, and a stale transaction, in the
unlocked state or higher, will not flush dirty extent buffers anymore,
therefore resulting in not persisting the tree block and resource leaks
(not cleaning the dirty_pages iotree for example).

So do the following changes:

1) Return -EUCLEAN if we find a stale transaction;

2) Turn the fs into error state, with error -EUCLEAN, so that no
   transaction can be committed, and generate a stack trace;

3) Combine both conditions into a single if statement, as both are related
   and have the same error message;

4) Mark the check as unlikely, since this is not expected to ever happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a648dff2becec..8bc1166215138 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -549,14 +549,22 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_err(fs_info,
 			"COW'ing blocks on a fs root that's being dropped");
 
-	if (trans->transaction != fs_info->running_transaction)
-		WARN(1, KERN_CRIT "trans %llu running %llu\n",
-		       trans->transid,
-		       fs_info->running_transaction->transid);
-
-	if (trans->transid != fs_info->generation)
-		WARN(1, KERN_CRIT "trans %llu running %llu\n",
-		       trans->transid, fs_info->generation);
+	/*
+	 * COWing must happen through a running transaction, which always
+	 * matches the current fs generation (it's a transaction with a state
+	 * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the fs
+	 * into error state to prevent the commit of any transaction.
+	 */
+	if (unlikely(trans->transaction != fs_info->running_transaction ||
+		     trans->transid != fs_info->generation)) {
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+"unexpected transaction when attempting to COW block %llu on root %llu, transaction %llu running transaction %llu fs generation %llu",
+			   buf->start, btrfs_root_id(root), trans->transid,
+			   fs_info->running_transaction->transid,
+			   fs_info->generation);
+		return -EUCLEAN;
+	}
 
 	if (!should_cow_block(trans, root, buf)) {
 		*cow_ret = buf;
-- 
2.40.1



