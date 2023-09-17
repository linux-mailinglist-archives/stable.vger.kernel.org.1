Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0F7A39C6
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbjIQTyK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbjIQTxz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6E9132
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271A9C433C8;
        Sun, 17 Sep 2023 19:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980429;
        bh=7JUK5qU/MgERhMtPsREwjnZL6DhEfEsDOxE2Vw6RNSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZizUZPMBnZd3H+KVcMe0aRM++wAyU8yAwN3715A8vFU1s8ZYTbmXWwHFqjNIt6da
         1GPQ9xMhXv6MsSAZcwy6VsesHH8E/GX/ThG+P7/JUQgsJgavRvK8l4W7tZlNQ/iZ/w
         Esk1mqby1QF1extV1pjCfM5jYBWzr19anMYGowq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Eric Biggers <ebiggers@google.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.5 189/285] ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}
Date:   Sun, 17 Sep 2023 21:13:09 +0200
Message-ID: <20230917191058.146582468@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luís Henriques <lhenriques@suse.de>

commit 7ca4b085f430f3774c3838b3da569ceccd6a0177 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/crypto.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -33,6 +33,8 @@ int ext4_fname_setup_filename(struct ino
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, iname, fname);
+	if (err)
+		ext4_fname_free_filename(fname);
 #endif
 	return err;
 }
@@ -51,6 +53,8 @@ int ext4_fname_prepare_lookup(struct ino
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
+	if (err)
+		ext4_fname_free_filename(fname);
 #endif
 	return err;
 }


