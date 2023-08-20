Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2A781F0B
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjHTRgt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 20 Aug 2023 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjHTRgr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 20 Aug 2023 13:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31112724
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 10:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F4A060BA0
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 17:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E6BC433C8;
        Sun, 20 Aug 2023 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692552794;
        bh=WENwwukqvqLnh0i70wqLdjnC9+i3wzyAPZzzsBwu9GM=;
        h=From:To:Cc:Subject:Date:From;
        b=eK/Pj2PDOw6jbR+ynm+yECSoWnkZi9Rc3RDtiMFJFwqkdk18F5shl80G1K3gaUhh1
         hEdJriIWbIxefsn5Jcn1ai/Fe0pFfibiEBRlVdz+N/UhVfJJtpr48OkuO5vC5tD9z0
         7nf3mWpQwAgQ6wJCYC3bvPhwyqfrpej6as3YI4/sdZZMpMHSFb98waMAS7F3HY+hOg
         gFLw65u0yb4zhJ85XhLme3By0rS6Ql7Ae1rlUHn9+/robFW7syDT/sR1iYnb2EmVUV
         7FNeTRfgsJwiMrTBahR5RywGoXA7ezpYINelM8MCdAkM5DB0hpu1ThYtdmfUdvnFvR
         +DT9QDvFLjmjA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     Victor Hsieh <victorhsieh@google.com>, stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v3] fsverity: skip PKCS#7 parser when keyring is empty
Date:   Sun, 20 Aug 2023 10:32:36 -0700
Message-ID: <20230820173237.2579-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If an fsverity builtin signature is given for a file but the
".fs-verity" keyring is empty, there's no real reason to run the PKCS#7
parser.  Skip this to avoid the PKCS#7 attack surface when builtin
signature support is configured into the kernel but is not being used.

This is a hardening improvement, not a fix per se, but I've added
Fixes and Cc stable to get it out to more users.

Fixes: 432434c9f8e1 ("fs-verity: support builtin file signatures")
Cc: stable@vger.kernel.org
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v3: improve the error message slightly
v2: check keyring and return early before allocating formatted digest

 fs/verity/signature.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index b95acae64eac6..90c07573dd77b 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -55,20 +55,36 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 
 	if (sig_size == 0) {
 		if (fsverity_require_signatures) {
 			fsverity_err(inode,
 				     "require_signatures=1, rejecting unsigned file!");
 			return -EPERM;
 		}
 		return 0;
 	}
 
+	if (fsverity_keyring->keys.nr_leaves_on_tree == 0) {
+		/*
+		 * The ".fs-verity" keyring is empty, due to builtin signatures
+		 * being supported by the kernel but not actually being used.
+		 * In this case, verify_pkcs7_signature() would always return an
+		 * error, usually ENOKEY.  It could also be EBADMSG if the
+		 * PKCS#7 is malformed, but that isn't very important to
+		 * distinguish.  So, just skip to ENOKEY to avoid the attack
+		 * surface of the PKCS#7 parser, which would otherwise be
+		 * reachable by any task able to execute FS_IOC_ENABLE_VERITY.
+		 */
+		fsverity_err(inode,
+			     "fs-verity keyring is empty, rejecting signed file!");
+		return -ENOKEY;
+	}
+
 	d = kzalloc(sizeof(*d) + hash_alg->digest_size, GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 	memcpy(d->magic, "FSVerity", 8);
 	d->digest_algorithm = cpu_to_le16(hash_alg - fsverity_hash_algs);
 	d->digest_size = cpu_to_le16(hash_alg->digest_size);
 	memcpy(d->digest, vi->file_digest, hash_alg->digest_size);
 
 	err = verify_pkcs7_signature(d, sizeof(*d) + hash_alg->digest_size,
 				     signature, sig_size, fsverity_keyring,

base-commit: 456ae5fe9b448f44ebe98b391a3bae9c75df465e
-- 
2.41.0

