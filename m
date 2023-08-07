Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3047771AD9
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 08:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjHGGzl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 02:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHGGzj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 02:55:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE0FE78
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 23:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2099061521
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 06:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31512C433C8;
        Mon,  7 Aug 2023 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691391337;
        bh=ojM7BjKlG/4EzDRvaOks07ZBYQIS8sSlnxOeC5KtUO0=;
        h=Subject:To:Cc:From:Date:From;
        b=dsv0pTiy2bVHlWgF+NyWEaUUssTL+g79XylxREJ7NM96leG0/8w3J+ZrgfPcXu5Y+
         27yw47Uu6dHvrz9UqjBjecz56sPl8d7Dn3YxwlUYx7qZn7lFrFeMvw1meQb0ibeWIk
         fzRnp/eGi94s1WiSPsUuNbSfo1bg47APrA3DPQJo=
Subject: FAILED: patch "[PATCH] exfat: check if filename entries exceeds max filename length" failed to apply to 6.1-stable tree
To:     linkinjeon@kernel.org, Yuezhang.Mo@sony.com, dfirblog@gmail.com,
        sj1557.seo@samsung.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 08:55:34 +0200
Message-ID: <2023080734-remarry-tamer-aabe@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d42334578eba1390859012ebb91e1e556d51db49
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080734-remarry-tamer-aabe@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d42334578eba ("exfat: check if filename entries exceeds max filename length")
20914ff6dd56 ("exfat: move exfat_entry_set_cache from heap to stack")
a3ff29a95fde ("exfat: support dynamic allocate bh for exfat_entry_set_cache")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d42334578eba1390859012ebb91e1e556d51db49 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 13 Jul 2023 21:59:37 +0900
Subject: [PATCH] exfat: check if filename entries exceeds max filename length

exfat_extract_uni_name copies characters from a given file name entry into
the 'uniname' variable. This variable is actually defined on the stack of
the exfat_readdir() function. According to the definition of
the 'exfat_uni_name' type, the file name should be limited 255 characters
(+ null teminator space), but the exfat_get_uniname_from_ext_entry()
function can write more characters because there is no check if filename
entries exceeds max filename length. This patch add the check not to copy
filename characters when exceeding max filename length.

Cc: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reported-by: Maxim Suhanov <dfirblog@gmail.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 957574180a5e..bc48f3329921 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -34,6 +34,7 @@ static int exfat_get_uniname_from_ext_entry(struct super_block *sb,
 {
 	int i, err;
 	struct exfat_entry_set_cache es;
+	unsigned int uni_len = 0, len;
 
 	err = exfat_get_dentry_set(&es, sb, p_dir, entry, ES_ALL_ENTRIES);
 	if (err)
@@ -52,7 +53,10 @@ static int exfat_get_uniname_from_ext_entry(struct super_block *sb,
 		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
 			break;
 
-		exfat_extract_uni_name(ep, uniname);
+		len = exfat_extract_uni_name(ep, uniname);
+		uni_len += len;
+		if (len != EXFAT_FILE_NAME_LEN || uni_len >= MAX_NAME_LENGTH)
+			break;
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
@@ -1079,7 +1083,8 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			if (entry_type == TYPE_EXTEND) {
 				unsigned short entry_uniname[16], unichar;
 
-				if (step != DIRENT_STEP_NAME) {
+				if (step != DIRENT_STEP_NAME ||
+				    name_len >= MAX_NAME_LENGTH) {
 					step = DIRENT_STEP_FILE;
 					continue;
 				}

