Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E737A3CA2
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbjIQUdi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbjIQUdM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:33:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA39C10F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:33:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02C8C433C7;
        Sun, 17 Sep 2023 20:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982786;
        bh=xiFftyu+Oc18rpCNVTWNd49TTDCIAON+ByVjudvIB5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULgF8M+VRJMOOLGgzW9jtEY/GJtHffViZ7G6ZvlURwn81rmcmtJJilTdhslQst7ol
         KAt4fvcXEGqSPpDGfJ7kl1K5hta36hvtRfpDt0GgOpE7Y0EB8OtZcF1uc1Jw+jATB3
         wz0572tsB+t2Lvz+Oa24PInqobNWWOowBB/c+TWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 5.15 353/511] fsverity: skip PKCS#7 parser when keyring is empty
Date:   Sun, 17 Sep 2023 21:13:00 +0200
Message-ID: <20230917191122.328146125@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 919dc320956ea353a7fb2d84265195ad5ef525ac upstream.

If an fsverity builtin signature is given for a file but the
".fs-verity" keyring is empty, there's no real reason to run the PKCS#7
parser.  Skip this to avoid the PKCS#7 attack surface when builtin
signature support is configured into the kernel but is not being used.

This is a hardening improvement, not a fix per se, but I've added
Fixes and Cc stable to get it out to more users.

Fixes: 432434c9f8e1 ("fs-verity: support builtin file signatures")
Cc: stable@vger.kernel.org
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20230820173237.2579-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/verity/signature.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -54,6 +54,22 @@ int fsverity_verify_signature(const stru
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


