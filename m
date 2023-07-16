Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17D67554B5
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjGPUdW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjGPUdV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD2BA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27D7160E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3826DC433C7;
        Sun, 16 Jul 2023 20:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539599;
        bh=nnhv7U5CrjEbE1R5xTTZ4LZqsX35OjpY8yCtVGsa1nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYoUf4u72LBNqAO5/jT+azG1LP9XWXO29Oc+rAKQOSuf13dGuxmdYHga31q+gzHST
         pAtsqecdNRDox7Y6vHEx+J9HIXgKwsjGCbGc5anRt6K6jWRVdIoM+DcZHiHHMH5MOf
         81v0OeAvoi85FacTJMAhdDtBOTeKu9GjAY5iiRlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 064/591] evm: Fix build warnings
Date:   Sun, 16 Jul 2023 21:43:23 +0200
Message-ID: <20230716194925.534533736@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit 996e0a97ebd7b11cb785794e2a83c20c1add9d92 ]

Fix build warnings (function parameters description) for
evm_read_protected_xattrs(), evm_set_key() and evm_verifyxattr().

Fixes: 7626676320f3 ("evm: provide a function to set the EVM key from the kernel") # v4.5+
Fixes: 8314b6732ae4 ("ima: Define new template fields xattrnames, xattrlengths and xattrvalues") # v5.14+
Fixes: 2960e6cb5f7c ("evm: additional parameter to pass integrity cache entry 'iint'") # v3.2+
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 security/integrity/evm/evm_main.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 708de9656bbd2..b9395f8ef5829 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -40,7 +40,7 @@ static const char evm_hmac[] = "hmac(sha1)";
 /**
  * evm_set_key() - set EVM HMAC key from the kernel
  * @key: pointer to a buffer with the key data
- * @size: length of the key data
+ * @keylen: length of the key data
  *
  * This function allows setting the EVM HMAC key from the kernel
  * without using the "encrypted" key subsystem keys. It can be used
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index f1a26d50c1d58..a338f19447d03 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -318,7 +318,6 @@ int evm_protected_xattr_if_enabled(const char *req_xattr_name)
 /**
  * evm_read_protected_xattrs - read EVM protected xattr names, lengths, values
  * @dentry: dentry of the read xattrs
- * @inode: inode of the read xattrs
  * @buffer: buffer xattr names, lengths or values are copied to
  * @buffer_size: size of buffer
  * @type: n: names, l: lengths, v: values
@@ -390,6 +389,7 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
  * @xattr_name: requested xattr
  * @xattr_value: requested xattr value
  * @xattr_value_len: requested xattr value length
+ * @iint: inode integrity metadata
  *
  * Calculate the HMAC for the given dentry and verify it against the stored
  * security.evm xattr. For performance, use the xattr value and length
-- 
2.39.2



