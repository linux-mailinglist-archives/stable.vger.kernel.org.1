Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2447F7A8067
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjITMhD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjITMhD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:37:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422238F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:36:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8935AC433C7;
        Wed, 20 Sep 2023 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213416;
        bh=gGaEcDi7iefmQiyEZnnW2ypN5MCpL87idCfoPtoUutk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLl7F9tlMKQYfOjRhgsJ8PcGuNDBjr/Txefd0Qh5xMsnvP20f8mlkVn4Mcq7WctSy
         m2JbuVIgndR60r6huDLy9PBnPanke9laU9oJqzuZJZwsR/9svjcyaZZ9sVEA0NNrvX
         kGFl7inR1POdvbzjXsRL/w7Pp2cjq24wsaA3r/HU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 5.4 229/367] fsverity: skip PKCS#7 parser when keyring is empty
Date:   Wed, 20 Sep 2023 13:30:06 +0200
Message-ID: <20230920112904.508183560@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -58,6 +58,22 @@ int fsverity_verify_signature(const stru
 		return -EBADMSG;
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


