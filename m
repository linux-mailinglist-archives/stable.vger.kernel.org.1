Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7F735447
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjFSKyX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFSKyG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:54:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED5C2941
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 642ED60B42
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777B1C433C0;
        Mon, 19 Jun 2023 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171958;
        bh=t6BM1ispRrrUdWx8WNvPLixKSPnfmDzRY+ZEq6s6z9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGhbc9htZfQAyEPvqU7u1TiGKeL0JeWMpAo6A7Ri64zinvdzlrIzUiysQXBuovViF
         AhSeA2w82UXpj3oU5Kgya/8+VPAJkwxRFqbhBK9/5Jg2OnJLNDQ+GvP55Mc7imywel
         W1/bClpI4Wc/vcuXtx8ZsaQ+CIFCryzs0QLgZ5GE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+b0a35a5c1f7e846d3b09@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 24/64] nilfs2: fix incomplete buffer cleanup in nilfs_btnode_abort_change_key()
Date:   Mon, 19 Jun 2023 12:30:20 +0200
Message-ID: <20230619102134.150257161@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 2f012f2baca140c488e43d27a374029c1e59098d upstream.

A syzbot fault injection test reported that nilfs_btnode_create_block, a
helper function that allocates a new node block for b-trees, causes a
kernel BUG for disk images where the file system block size is smaller
than the page size.

This was due to unexpected flags on the newly allocated buffer head, and
it turned out to be because the buffer flags were not cleared by
nilfs_btnode_abort_change_key() after an error occurred during a b-tree
update operation and the buffer was later reused in that state.

Fix this issue by using nilfs_btnode_delete() to abandon the unused
preallocated buffer in nilfs_btnode_abort_change_key().

Link: https://lkml.kernel.org/r/20230513102428.10223-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+b0a35a5c1f7e846d3b09@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/000000000000d1d6c205ebc4d512@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/btnode.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -285,6 +285,14 @@ void nilfs_btnode_abort_change_key(struc
 	if (nbh == NULL) {	/* blocksize == pagesize */
 		xa_erase_irq(&btnc->i_pages, newkey);
 		unlock_page(ctxt->bh->b_page);
-	} else
-		brelse(nbh);
+	} else {
+		/*
+		 * When canceling a buffer that a prepare operation has
+		 * allocated to copy a node block to another location, use
+		 * nilfs_btnode_delete() to initialize and release the buffer
+		 * so that the buffer flags will not be in an inconsistent
+		 * state when it is reallocated.
+		 */
+		nilfs_btnode_delete(nbh);
+	}
 }


