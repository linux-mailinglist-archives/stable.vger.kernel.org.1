Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5287D32E2
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjJWLYp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjJWLYo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:24:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB9892
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:24:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43F8C433C7;
        Mon, 23 Oct 2023 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060282;
        bh=Z1SQ45qHpzJ2QYltwWA7vXA3S9Lz4dSRof8jE0QOXJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxRGoBy7zGo+G5F/Cv/aAq+fparbRMn0hLLxsg16g9+1ENWIN44ZI8oMWEdgpzRYQ
         n0jkBMtX/moIXIopJ6l50F9uxmGqs486IHwKcqW3nzVeF9h0PqqxLGIwD6oPE/OCSP
         HKzJlgfN6wzH/EMoajBVFJCX4P2soFNvy0IJXOP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 120/196] btrfs: error when COWing block from a root that is being deleted
Date:   Mon, 23 Oct 2023 12:56:25 +0200
Message-ID: <20231023104831.902305905@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a2caab29884397e583d09be6546259a83ebfbdb1 ]

At btrfs_cow_block() we check if the block being COWed belongs to a root
that is being deleted and if so we log an error message. However this is
an unexpected case and it indicates a bug somewhere, so we should return
an error and abort the transaction. So change this in the following ways:

1) Abort the transaction with -EUCLEAN, so that if the issue ever happens
   it can easily be noticed;

2) Change the logged message level from error to critical, and change the
   message itself to print the block's logical address and the ID of the
   root;

3) Return -EUCLEAN to the caller;

4) As this is an unexpected scenario, that should never happen, mark the
   check as unlikely, allowing the compiler to potentially generate better
   code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 98e3e0761a4e5..98f68bd1383a3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -563,9 +563,13 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	u64 search_start;
 	int ret;
 
-	if (test_bit(BTRFS_ROOT_DELETING, &root->state))
-		btrfs_err(fs_info,
-			"COW'ing blocks on a fs root that's being dropped");
+	if (unlikely(test_bit(BTRFS_ROOT_DELETING, &root->state))) {
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+		   "attempt to COW block %llu on root %llu that is being deleted",
+			   buf->start, btrfs_root_id(root));
+		return -EUCLEAN;
+	}
 
 	/*
 	 * COWing must happen through a running transaction, which always
-- 
2.40.1



