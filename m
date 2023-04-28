Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19096F168D
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbjD1L2O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjD1L2K (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395459C0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D73736130B
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0D2C4339B;
        Fri, 28 Apr 2023 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681288;
        bh=bvvK0FZOOJPNcBFWnT98CrXg6kgZ6IaaBvnrFFwtlbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iBK5CO4jDlRrv2GPqObg5ZCGx6fngN/sCWpEv/82l19qKcZXM+rw9spLDup2qVCu1
         nIlbxbyB13dojAE2p3oi+QqVqZsrdlUC9PLEXsyyWN/wH0EIOm88bF4Uzb2J8DPDL3
         bG3HSwp70au/3ats9E2TaUZkmTtZ7N6SygH3FNUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 6.3 04/11] fsverity: explicitly check for buffer overflow in build_merkle_tree()
Date:   Fri, 28 Apr 2023 13:27:39 +0200
Message-Id: <20230428112040.046587104@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
References: <20230428112039.886496777@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 39049b69ec9fc125fa1f314165dcc86f72cb72ec upstream.

The new Merkle tree construction algorithm is a bit fragile in that it
may overflow the 'root_hash' array if the tree actually generated does
not match the calculated tree parameters.

This should never happen unless there is a filesystem bug that allows
the file size to change despite deny_write_access(), or a bug in the
Merkle tree logic itself.  Regardless, it's fairly easy to check for
buffer overflow here, so let's do so.

This is a robustness improvement only; this case is not currently known
to be reachable.  I've added a Fixes tag anyway, since I recommend that
this be included in kernels that have the mentioned commit.

Fixes: 56124d6c87fd ("fsverity: support enabling with tree block size < PAGE_SIZE")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230328041505.110162-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/verity/enable.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -13,6 +13,7 @@
 
 struct block_buffer {
 	u32 filled;
+	bool is_root_hash;
 	u8 *data;
 };
 
@@ -24,6 +25,14 @@ static int hash_one_block(struct inode *
 	struct block_buffer *next = cur + 1;
 	int err;
 
+	/*
+	 * Safety check to prevent a buffer overflow in case of a filesystem bug
+	 * that allows the file size to change despite deny_write_access(), or a
+	 * bug in the Merkle tree logic itself
+	 */
+	if (WARN_ON_ONCE(next->is_root_hash && next->filled != 0))
+		return -EINVAL;
+
 	/* Zero-pad the block if it's shorter than the block size. */
 	memset(&cur->data[cur->filled], 0, params->block_size - cur->filled);
 
@@ -97,6 +106,7 @@ static int build_merkle_tree(struct file
 		}
 	}
 	buffers[num_levels].data = root_hash;
+	buffers[num_levels].is_root_hash = true;
 
 	BUILD_BUG_ON(sizeof(level_offset) != sizeof(params->level_start));
 	memcpy(level_offset, params->level_start, sizeof(level_offset));


