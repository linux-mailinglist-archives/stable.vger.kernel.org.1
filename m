Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6FF775C3B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjHILZO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjHILZN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A40BED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:25:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC3B963259
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF9BC433C8;
        Wed,  9 Aug 2023 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580312;
        bh=p94nl83yJD6eUrRCtdIAjj7zKXeRltVVEBcKvCQh0d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcmuNMNDgR4hCK7sKWOJz82IThdAqEu5+Bf7brPFgWlfdn+6TlJnPNkERVYi8A8/T
         gD1OSZu/TMtcjjec2OBD2fuzg+H8+P7XjVSy7ZSOZnOed91Vj957IAGyOxrjKmbokZ
         HDodUkpk/NMpASsm1JgYzCFsTAokTVTqQJ0tfLKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 273/323] btrfs: check for commit error at btrfs_attach_transaction_barrier()
Date:   Wed,  9 Aug 2023 12:41:51 +0200
Message-ID: <20230809103710.556859322@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Filipe Manana <fdmanana@suse.com>

commit b28ff3a7d7e97456fd86b68d24caa32e1cfa7064 upstream.

btrfs_attach_transaction_barrier() is used to get a handle pointing to the
current running transaction if the transaction has not started its commit
yet (its state is < TRANS_STATE_COMMIT_START). If the transaction commit
has started, then we wait for the transaction to commit and finish before
returning - however we completely ignore if the transaction was aborted
due to some error during its commit, we simply return ERR_PT(-ENOENT),
which makes the caller assume everything is fine and no errors happened.

This could make an fsync return success (0) to user space when in fact we
had a transaction abort and the target inode changes were therefore not
persisted.

Fix this by checking for the return value from btrfs_wait_for_commit(),
and if it returned an error, return it back to the caller.

Fixes: d4edf39bd5db ("Btrfs: fix uncompleted transaction")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/transaction.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -703,8 +703,13 @@ btrfs_attach_transaction_barrier(struct
 
 	trans = start_transaction(root, 0, TRANS_ATTACH,
 				  BTRFS_RESERVE_NO_FLUSH, true);
-	if (trans == ERR_PTR(-ENOENT))
-		btrfs_wait_for_commit(root->fs_info, 0);
+	if (trans == ERR_PTR(-ENOENT)) {
+		int ret;
+
+		ret = btrfs_wait_for_commit(root->fs_info, 0);
+		if (ret)
+			return ERR_PTR(ret);
+	}
 
 	return trans;
 }


