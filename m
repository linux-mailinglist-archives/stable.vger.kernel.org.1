Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE66FA9FE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjEHK5n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjEHK5T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:57:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534302DD7A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C88C3629BF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC30C433D2;
        Mon,  8 May 2023 10:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543380;
        bh=vuFlVCZvohpKggK+AEqrKbeZh0Codm30iAObI7PGUj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eu7oL3lKMbvHO59V6OYfE8xraoQP13CGA0B/Qdcxuh+aVCpQXk2DBew6NIq2fo4WP
         GVAleiM97gl09aXyegYR9opJcKCMy+TIp3j5EuGYiJz1m7B2bR8gUk2pnzFDweFpoi
         u7U+W6qW1GOPPul+rD9uG0nkMYIswYt64gPSV7r4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.3 071/694] ksmbd: fix deadlock in ksmbd_find_crypto_ctx()
Date:   Mon,  8 May 2023 11:38:26 +0200
Message-Id: <20230508094434.856012238@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 7b4323373d844954bb76e0e9f39c4e5fc785fa7b upstream.

Deadlock is triggered by sending multiple concurrent session setup
requests. It should be reused after releasing when getting ctx for crypto.
Multiple consecutive ctx uses cause deadlock while waiting for releasing
due to the limited number of ctx.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20591
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/auth.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -221,22 +221,22 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn
 {
 	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
 	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
-	struct ksmbd_crypto_ctx *ctx;
+	struct ksmbd_crypto_ctx *ctx = NULL;
 	char *construct = NULL;
 	int rc, len;
 
-	ctx = ksmbd_crypto_ctx_find_hmacmd5();
-	if (!ctx) {
-		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5\n");
-		return -ENOMEM;
-	}
-
 	rc = calc_ntlmv2_hash(conn, sess, ntlmv2_hash, domain_name);
 	if (rc) {
 		ksmbd_debug(AUTH, "could not get v2 hash rc %d\n", rc);
 		goto out;
 	}
 
+	ctx = ksmbd_crypto_ctx_find_hmacmd5();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5\n");
+		return -ENOMEM;
+	}
+
 	rc = crypto_shash_setkey(CRYPTO_HMACMD5_TFM(ctx),
 				 ntlmv2_hash,
 				 CIFS_HMAC_MD5_HASH_SIZE);
@@ -272,6 +272,8 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn
 		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
 		goto out;
 	}
+	ksmbd_release_crypto_ctx(ctx);
+	ctx = NULL;
 
 	rc = ksmbd_gen_sess_key(sess, ntlmv2_hash, ntlmv2_rsp);
 	if (rc) {
@@ -282,7 +284,8 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn
 	if (memcmp(ntlmv2->ntlmv2_hash, ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE) != 0)
 		rc = -EINVAL;
 out:
-	ksmbd_release_crypto_ctx(ctx);
+	if (ctx)
+		ksmbd_release_crypto_ctx(ctx);
 	kfree(construct);
 	return rc;
 }


