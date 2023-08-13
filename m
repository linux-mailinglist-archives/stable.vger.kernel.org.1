Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315E977AD3F
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjHMVsQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjHMVpx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D692D61
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE8960B9D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2378DC433C8;
        Sun, 13 Aug 2023 21:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963151;
        bh=TjDUOUnjDNyM7y1Mj9fP/mQvNjTx45ffVAsYa8F/XyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwUxR83HTiKGYI05e4lkiwQpCHaO3ckZkMd5c3fkriKDeojq5kghmACCP/xdL764h
         Uo4Kxosj27mqqgj3rmuzANc83RFdcM4zgXsX/fnS/pdIaCXAsmHbH9nBal2iiHyR9v
         YjQqsYNEscMKICZYV/D4ZKa371fhaq3d8kq5kNGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 71/89] btrfs: exit gracefully if reloc roots dont match
Date:   Sun, 13 Aug 2023 23:20:02 +0200
Message-ID: <20230813211712.905642804@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 05d7ce504545f7874529701664c90814ca645c5d upstream.

[BUG]
Syzbot reported a crash that an ASSERT() got triggered inside
prepare_to_merge().

[CAUSE]
The root cause of the triggered ASSERT() is we can have a race between
quota tree creation and relocation.

This leads us to create a duplicated quota tree in the
btrfs_read_fs_root() path, and since it's treated as fs tree, it would
have ROOT_SHAREABLE flag, causing us to create a reloc tree for it.

The bug itself is fixed by a dedicated patch for it, but this already
taught us the ASSERT() is not something straightforward for
developers.

[ENHANCEMENT]
Instead of using an ASSERT(), let's handle it gracefully and output
extra info about the mismatch reloc roots to help debug.

Also with the above ASSERT() removed, we can trigger ASSERT(0)s inside
merge_reloc_roots() later.
Also replace those ASSERT(0)s with WARN_ON()s.

CC: stable@vger.kernel.org # 5.15+
Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/relocation.c |   45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1905,7 +1905,39 @@ again:
 				err = PTR_ERR(root);
 			break;
 		}
-		ASSERT(root->reloc_root == reloc_root);
+
+		if (unlikely(root->reloc_root != reloc_root)) {
+			if (root->reloc_root) {
+				btrfs_err(fs_info,
+"reloc tree mismatch, root %lld has reloc root key (%lld %u %llu) gen %llu, expect reloc root key (%lld %u %llu) gen %llu",
+					  root->root_key.objectid,
+					  root->reloc_root->root_key.objectid,
+					  root->reloc_root->root_key.type,
+					  root->reloc_root->root_key.offset,
+					  btrfs_root_generation(
+						  &root->reloc_root->root_item),
+					  reloc_root->root_key.objectid,
+					  reloc_root->root_key.type,
+					  reloc_root->root_key.offset,
+					  btrfs_root_generation(
+						  &reloc_root->root_item));
+			} else {
+				btrfs_err(fs_info,
+"reloc tree mismatch, root %lld has no reloc root, expect reloc root key (%lld %u %llu) gen %llu",
+					  root->root_key.objectid,
+					  reloc_root->root_key.objectid,
+					  reloc_root->root_key.type,
+					  reloc_root->root_key.offset,
+					  btrfs_root_generation(
+						  &reloc_root->root_item));
+			}
+			list_add(&reloc_root->root_list, &reloc_roots);
+			btrfs_put_root(root);
+			btrfs_abort_transaction(trans, -EUCLEAN);
+			if (!err)
+				err = -EUCLEAN;
+			break;
+		}
 
 		/*
 		 * set reference count to 1, so btrfs_recover_relocation
@@ -1978,7 +2010,7 @@ again:
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			if (IS_ERR(root)) {
+			if (WARN_ON(IS_ERR(root))) {
 				/*
 				 * For recovery we read the fs roots on mount,
 				 * and if we didn't find the root then we marked
@@ -1987,17 +2019,14 @@ again:
 				 * memory.  However there's no reason we can't
 				 * handle the error properly here just in case.
 				 */
-				ASSERT(0);
 				ret = PTR_ERR(root);
 				goto out;
 			}
-			if (root->reloc_root != reloc_root) {
+			if (WARN_ON(root->reloc_root != reloc_root)) {
 				/*
-				 * This is actually impossible without something
-				 * going really wrong (like weird race condition
-				 * or cosmic rays).
+				 * This can happen if on-disk metadata has some
+				 * corruption, e.g. bad reloc tree key offset.
 				 */
-				ASSERT(0);
 				ret = -EINVAL;
 				goto out;
 			}


