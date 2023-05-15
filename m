Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E290070345A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbjEOQrT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbjEOQrO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:47:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056875273
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93E836291F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD71C433EF;
        Mon, 15 May 2023 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169225;
        bh=pxGqeHSv+OrPjKOpEJvIgsbeu2BN14LR7HeoGqP4ChQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3dIQX2GHEoLzW/MqD6bP/hwZzxvzXwPKKcAvQgz31VVFycvK4S465aLVlfv7aN8H
         6UAYHidwR9PFTheUQftnMAu4NI2xYlZFXYc6oQJqccOVlg0Ik8SgqHfCHvHUM27oDC
         6Sl+eKPCAhKgbiU96YpkdB1MesV7NKTk/qTX/0Wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com,
        stable@kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.19 181/191] ext4: add bounds checking in get_max_inline_xattr_value_size()
Date:   Mon, 15 May 2023 18:26:58 +0200
Message-Id: <20230515161714.056413127@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 2220eaf90992c11d888fe771055d4de330385f01 upstream.

Normally the extended attributes in the inode body would have been
checked when the inode is first opened, but if someone is writing to
the block device while the file system is mounted, it's possible for
the inode table to get corrupted.  Add bounds checking to avoid
reading beyond the end of allocated memory if this happens.

Reported-by: syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1966db24521e5f6e23f7
Cc: stable@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inline.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -32,6 +32,7 @@ static int get_max_inline_xattr_value_si
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	struct ext4_inode *raw_inode;
+	void *end;
 	int free, min_offs;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
@@ -55,14 +56,23 @@ static int get_max_inline_xattr_value_si
 	raw_inode = ext4_raw_inode(iloc);
 	header = IHDR(inode, raw_inode);
 	entry = IFIRST(header);
+	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 
 	/* Compute min_offs. */
-	for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
+	while (!IS_LAST_ENTRY(entry)) {
+		void *next = EXT4_XATTR_NEXT(entry);
+
+		if (next >= end) {
+			EXT4_ERROR_INODE(inode,
+					 "corrupt xattr in inline inode");
+			return 0;
+		}
 		if (!entry->e_value_inum && entry->e_value_size) {
 			size_t offs = le16_to_cpu(entry->e_value_offs);
 			if (offs < min_offs)
 				min_offs = offs;
 		}
+		entry = next;
 	}
 	free = min_offs -
 		((void *)entry - (void *)IFIRST(header)) - sizeof(__u32);


