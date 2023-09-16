Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB997A2FE8
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjIPMPQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjIPMPP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:15:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA389CEB
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:15:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E7C433C8;
        Sat, 16 Sep 2023 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694866510;
        bh=mC/wxuORxN4hcU/6eoiQJXMak4dy5rQt6G1xorxrv6w=;
        h=Subject:To:Cc:From:Date:From;
        b=gZMmaWxr+yBCYbVuXPCcNqRrJXKPkXBj5JeDVzhZheyeyYEVDnDZtL2zTRPXB/+TG
         7OREMwb8cqa/9HwuuYrSQyhMHYxPzWEG+AYFNbFxg1GmC+TIXuWEFpMnh2kei5OHWP
         xSfN60BYBYQS4AEkyPF+CrnflrNNXU2eCiTiZ190=
Subject: FAILED: patch "[PATCH] ext4: fix memory leaks in" failed to apply to 5.15-stable tree
To:     lhenriques@suse.de, ebiggers@google.com, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:15:07 +0200
Message-ID: <2023091607-removal-popular-03e9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7ca4b085f430f3774c3838b3da569ceccd6a0177
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091607-removal-popular-03e9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

7ca4b085f430 ("ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}")
3030b59c8533 ("ext4: cleanup function defs from ext4.h into crypto.c")
b1241c8eb977 ("ext4: move ext4 crypto code to its own file crypto.c")
5298d4bfe80f ("unicode: clean up the Kconfig symbol confusion")
6661224e66f0 ("Merge tag 'unicode-for-next-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ca4b085f430f3774c3838b3da569ceccd6a0177 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Date: Thu, 3 Aug 2023 10:17:13 +0100
Subject: [PATCH] ext4: fix memory leaks in
 ext4_fname_{setup_filename,prepare_lookup}
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the filename casefolding fails, we'll be leaking memory from the
fscrypt_name struct, namely from the 'crypto_buf.name' member.

Make sure we free it in the error path on both ext4_fname_setup_filename()
and ext4_fname_prepare_lookup() functions.

Cc: stable@kernel.org
Fixes: 1ae98e295fa2 ("ext4: optimize match for casefolded encrypted dirs")
Signed-off-by: Luís Henriques <lhenriques@suse.de>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20230803091713.13239-1-lhenriques@suse.de
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index e20ac0654b3f..453d4da5de52 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -33,6 +33,8 @@ int ext4_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, iname, fname);
+	if (err)
+		ext4_fname_free_filename(fname);
 #endif
 	return err;
 }
@@ -51,6 +53,8 @@ int ext4_fname_prepare_lookup(struct inode *dir, struct dentry *dentry,
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
+	if (err)
+		ext4_fname_free_filename(fname);
 #endif
 	return err;
 }

