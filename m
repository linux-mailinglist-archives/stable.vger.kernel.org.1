Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A386E75CE44
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjGUQTN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGUQSr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABEB46B6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A2C161D3E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C89BC433C7;
        Fri, 21 Jul 2023 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956254;
        bh=HJPMXDpv01cAKA9MYhUmAPqdMfx6e5PK/majPaMz8C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLZrr4H0OMZNnGFC5OByrmgVANZHDXm39i5F1lMCmHab3Db2cdTH5GJLgZz9uh15l
         oxzMC1gqnW01BMwmDKLBFMy3hb9vHdJbb4vboU/M32SpTddWUdN42CICAlBoxjEPo9
         mWTCjq1b2MmKwR9IbmbtA28NmJa5Fngbwgtgnsc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Sean Greenslade <sean@seangreenslade.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.4 154/292] ext4: avoid updating the superblock on a r/o mount if not needed
Date:   Fri, 21 Jul 2023 18:04:23 +0200
Message-ID: <20230721160535.518020086@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit 2ef6c32a914b85217b44a0a2418e830e520b085e upstream.

This was noticed by a user who noticied that the mtime of a file
backing a loopback device was getting bumped when the loopback device
is mounted read/only.  Note: This doesn't show up when doing a
loopback mount of a file directly, via "mount -o ro /tmp/foo.img
/mnt", since the loop device is set read-only when mount automatically
creates loop device.  However, this is noticeable for a LUKS loop
device like this:

% cryptsetup luksOpen /tmp/foo.img test
% mount -o ro /dev/loop0 /mnt ; umount /mnt

or, if LUKS is not in use, if the user manually creates the loop
device like this:

% losetup /dev/loop0 /tmp/foo.img
% mount -o ro /dev/loop0 /mnt ; umount /mnt

The modified mtime causes rsync to do a rolling checksum scan of the
file on the local and remote side, incrementally increasing the time
to rsync the not-modified-but-touched image file.

Fixes: eee00237fa5e ("ext4: commit super block if fs record error when journal record without error")
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/ZIauBR7YiV3rVAHL@glitch
Reported-by: Sean Greenslade <sean@seangreenslade.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5980,19 +5980,27 @@ static int ext4_load_journal(struct supe
 		err = jbd2_journal_wipe(journal, !really_read_only);
 	if (!err) {
 		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
+		__le16 orig_state;
+		bool changed = false;
 
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
 		err = jbd2_journal_load(journal);
-		if (save)
+		if (save && memcmp(((char *) es) + EXT4_S_ERR_START,
+				   save, EXT4_S_ERR_LEN)) {
 			memcpy(((char *) es) + EXT4_S_ERR_START,
 			       save, EXT4_S_ERR_LEN);
+			changed = true;
+		}
 		kfree(save);
+		orig_state = es->s_state;
 		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
 					   EXT4_ERROR_FS);
+		if (orig_state != es->s_state)
+			changed = true;
 		/* Write out restored error information to the superblock */
-		if (!bdev_read_only(sb->s_bdev)) {
+		if (changed && !really_read_only) {
 			int err2;
 			err2 = ext4_commit_super(sb);
 			err = err ? : err2;


