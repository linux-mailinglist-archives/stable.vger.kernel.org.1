Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FEB7036D7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbjEOROb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243872AbjEOROR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5BD106C5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8936D62B69
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C464C433D2;
        Mon, 15 May 2023 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170756;
        bh=cM9hCIJWkYH8wtlY+P3U/BCIGe/AsngQZFUXG+8Dzr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeWHj5wT1Yt5dWxiTiP5TTYnDkp0fHspQLN2wRjns56fdvr/LMNGdZsYt1ogDUEWu
         W+yIaamZNLIZm/9iI37qd2PE+lZAZYnPIG/UWocJccJ7wgqUkHU9JLRUsVuY16eb3C
         0kCIqJpfPp6ZibpCtw94rGUFcXK9nCdIj0Cv4yfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com,
        syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.1 231/239] ext4: fix invalid free tracking in ext4_xattr_move_to_block()
Date:   Mon, 15 May 2023 18:28:14 +0200
Message-Id: <20230515161728.641688504@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit b87c7cdf2bed4928b899e1ce91ef0d147017ba45 upstream.

In ext4_xattr_move_to_block(), the value of the extended attribute
which we need to move to an external block may be allocated by
kvmalloc() if the value is stored in an external inode.  So at the end
of the function the code tried to check if this was the case by
testing entry->e_value_inum.

However, at this point, the pointer to the xattr entry is no longer
valid, because it was removed from the original location where it had
been stored.  So we could end up calling kvfree() on a pointer which
was not allocated by kvmalloc(); or we could also potentially leak
memory by not freeing the buffer when it should be freed.  Fix this by
storing whether it should be freed in a separate variable.

Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230430160426.581366-1-tytso@mit.edu
Link: https://syzkaller.appspot.com/bug?id=5c2aee8256e30b55ccf57312c16d88417adbd5e1
Link: https://syzkaller.appspot.com/bug?id=41a6b5d4917c0412eb3b3c3c604965bed7d7420b
Reported-by: syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com
Reported-by: syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2564,6 +2564,7 @@ static int ext4_xattr_move_to_block(hand
 		.in_inode = !!entry->e_value_inum,
 	};
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
+	int needs_kvfree = 0;
 	int error;
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
@@ -2586,7 +2587,7 @@ static int ext4_xattr_move_to_block(hand
 			error = -ENOMEM;
 			goto out;
 		}
-
+		needs_kvfree = 1;
 		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
 		if (error)
 			goto out;
@@ -2625,7 +2626,7 @@ static int ext4_xattr_move_to_block(hand
 
 out:
 	kfree(b_entry_name);
-	if (entry->e_value_inum && buffer)
+	if (needs_kvfree && buffer)
 		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);


