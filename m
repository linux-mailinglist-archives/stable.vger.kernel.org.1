Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1D75D476
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjGUTVe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjGUTV3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3EC30EA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C8861B1C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0613EC433C8;
        Fri, 21 Jul 2023 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967281;
        bh=1TyHJhm/cKUKXYfoT2LHqgNFgWf6b4bWWeS9DwREL/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/yBpafjI2KZx+pTfAJqhmjcp2grrsdxPHIg/BcSUwwFamQlSkLyIQYuVpzbuUyYN
         q4NQBefYODcnocgY4WLaUPcPBOCooQVwZS44J68lYb/GxKtMGTSmOiqssXfP82lc1E
         MSg2dW+wBrothR1+IKveGfZhJenpODJhcbPo3XUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        stable@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.1 106/223] ext4: get block from bh in ext4_free_blocks for fast commit replay
Date:   Fri, 21 Jul 2023 18:05:59 +0200
Message-ID: <20230721160525.390376717@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
@@ -6158,12 +6158,6 @@ void ext4_free_blocks(handle_t *handle,
 
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
@@ -6171,6 +6165,13 @@ void ext4_free_blocks(handle_t *handle,
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


