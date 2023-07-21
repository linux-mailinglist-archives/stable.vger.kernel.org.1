Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1014675CE41
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjGUQTI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjGUQSm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE6F449A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD55E61D30
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD64C433C7;
        Fri, 21 Jul 2023 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956249;
        bh=SddjxaRI4Hw5yygKZ/wydDOvflw/HWXzkp0PZqMloiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w3OBQS1HhEVebT2OWkPCWlUjGb1Qe3wBDHbcN7m7RdVig2y2pe4+fuNrCaZnyDTWv
         pV7fDQS50ntdQB33sgt6fdAwyHZnzYDfIoyRjXMDmM0nFebCqDHo7xteQtj1uKxd2Z
         8OQDNtGo4AUsQw9HGLq02c/snkPNrY1lQS1Nix9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        stable@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.4 152/292] ext4: get block from bh in ext4_free_blocks for fast commit replay
Date:   Fri, 21 Jul 2023 18:04:21 +0200
Message-ID: <20230721160535.430884265@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit 11b6890be0084ad4df0e06d89a9fdcc948472c65 upstream.

ext4_free_blocks will retrieve block from bh if block parameter is zero.
Retrieve block before ext4_free_blocks_simple to avoid potentially
passing wrong block to ext4_free_blocks_simple.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: stable@kernel.org
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20230603150327.3596033-9-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6328,12 +6328,6 @@ void ext4_free_blocks(handle_t *handle,
 
 	sbi = EXT4_SB(sb);
 
-	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
-		ext4_free_blocks_simple(inode, block, count);
-		return;
-	}
-
-	might_sleep();
 	if (bh) {
 		if (block)
 			BUG_ON(block != bh->b_blocknr);
@@ -6341,6 +6335,13 @@ void ext4_free_blocks(handle_t *handle,
 			block = bh->b_blocknr;
 	}
 
+	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
+		ext4_free_blocks_simple(inode, block, count);
+		return;
+	}
+
+	might_sleep();
+
 	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
 	    !ext4_inode_block_valid(inode, block, count)) {
 		ext4_error(sb, "Freeing blocks not in datazone - "


