Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1D703AA5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbjEORxs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244943AbjEORxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9550115EDA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C242C62F9A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF91FC433EF;
        Mon, 15 May 2023 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173085;
        bh=+SOGQE0DgX13jVQ0Tn87AsDmy9C8r4Qo2nsoo/oOqTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWNdo4OUDk49cdUQ3eR4ljVsbrEb8KFUz7IJZ5200f01Hpen4TlY6kBYkvNCWGdxi
         5OHTlv3FExcIGFxK7/In5WZvs95ZarP6VuBx20qPhJpYfC2yVxBENswaIAPGZU2Nsy
         3qbOL0OclzFjdKwxdNftRPOG7qasbiIFJXpsWoEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+91dccab7c64e2850a4e5@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.10 363/381] ext4: fix deadlock when converting an inline directory in nojournal mode
Date:   Mon, 15 May 2023 18:30:14 +0200
Message-Id: <20230515161753.310726298@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

commit f4ce24f54d9cca4f09a395f3eecce20d6bec4663 upstream.

In no journal mode, ext4_finish_convert_inline_dir() can self-deadlock
by calling ext4_handle_dirty_dirblock() when it already has taken the
directory lock.  There is a similar self-deadlock in
ext4_incvert_inline_data_nolock() for data files which we'll fix at
the same time.

A simple reproducer demonstrating the problem:

    mke2fs -Fq -t ext2 -O inline_data -b 4k /dev/vdc 64
    mount -t ext4 -o dirsync /dev/vdc /vdc
    cd /vdc
    mkdir file0
    cd file0
    touch file0
    touch file1
    attr -s BurnSpaceInEA -V abcde .
    touch supercalifragilisticexpialidocious

Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230507021608.1290720-1-tytso@mit.edu
Reported-by: syzbot+91dccab7c64e2850a4e5@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=ba84cc80a9491d65416bc7877e1650c87530fe8a
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inline.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1172,6 +1172,7 @@ static int ext4_finish_convert_inline_di
 		ext4_initialize_dirent_tail(dir_block,
 					    inode->i_sb->s_blocksize);
 	set_buffer_uptodate(dir_block);
+	unlock_buffer(dir_block);
 	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
 		return err;
@@ -1245,6 +1246,7 @@ static int ext4_convert_inline_data_nolo
 	if (!S_ISDIR(inode->i_mode)) {
 		memcpy(data_bh->b_data, buf, inline_size);
 		set_buffer_uptodate(data_bh);
+		unlock_buffer(data_bh);
 		error = ext4_handle_dirty_metadata(handle,
 						   inode, data_bh);
 	} else {
@@ -1252,7 +1254,6 @@ static int ext4_convert_inline_data_nolo
 						       buf, inline_size);
 	}
 
-	unlock_buffer(data_bh);
 out_restore:
 	if (error)
 		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);


