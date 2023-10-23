Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8622B7D3468
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjJWLj1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjJWLj0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:39:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ECEE8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:39:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CDCC433C7;
        Mon, 23 Oct 2023 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061164;
        bh=HsHU/hxIx6OGgHyNYdylrWbEX6I6fNxyiLps4g40wZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2aXvemiAwNVdH6rzRyeMEm0jR6+u02HDjzxCjc8G84ANhyykTPcsRpfD0Ch17/+07
         vFIkFgbRFswS80ZACPXv29wXzhzgfvJzP0xGXxnL24Bp6nsanrXmqnTbB0CkeO9psi
         FAjw0FsqQk8t/EqWSQHUQUxAXFR+VZnpGPQUKWyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 094/137] btrfs: error out when reallocating block for defrag using a stale transaction
Date:   Mon, 23 Oct 2023 12:57:31 +0200
Message-ID: <20231023104824.061862411@linuxfoundation.org>
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

[ Upstream commit e36f94914021e58ee88a8856c7fdf35adf9c7ee1 ]

At btrfs_realloc_node() we have these checks to verify we are not using a
stale transaction (a past transaction with an unblocked state or higher),
and the only thing we do is to trigger two WARN_ON(). This however is a
critical problem, highly unexpected and if it happens it's most likely due
to a bug, so we should error out and turn the fs into error state so that
such issue is much more easily noticed if it's triggered.

The problem is critical because in btrfs_realloc_node() we COW tree blocks,
and using such stale transaction will lead to not persisting the extent
buffers used for the COW operations, as allocating tree block adds the
range of the respective extent buffers to the ->dirty_pages iotree of the
transaction, and a stale transaction, in the unlocked state or higher,
will not flush dirty extent buffers anymore, therefore resulting in not
persisting the tree block and resource leaks (not cleaning the dirty_pages
iotree for example).

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
 fs/btrfs/ctree.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8fe6aaa7b11fd..8b53313bf3b2c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -680,8 +680,22 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	int progress_passed = 0;
 	struct btrfs_disk_key disk_key;
 
-	WARN_ON(trans->transaction != fs_info->running_transaction);
-	WARN_ON(trans->transid != fs_info->generation);
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
+"unexpected transaction when attempting to reallocate parent %llu for root %llu, transaction %llu running transaction %llu fs generation %llu",
+			   parent->start, btrfs_root_id(root), trans->transid,
+			   fs_info->running_transaction->transid,
+			   fs_info->generation);
+		return -EUCLEAN;
+	}
 
 	parent_nritems = btrfs_header_nritems(parent);
 	blocksize = fs_info->nodesize;
-- 
2.40.1



