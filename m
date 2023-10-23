Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3987D31AD
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjJWLL4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjJWLLz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:11:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DADC1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:11:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384C3C433C7;
        Mon, 23 Oct 2023 11:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059513;
        bh=HfVQleODybMbqbGeG3osDZG3BUQ5hXnUB5HrGJXs6xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1//9QisYyB8LxdXWW4BoxB5kZL4nXP1fX1qPtjLAz+2zlSRf5idBQOVUl91hRxfz
         OjT5j8Jui6+W+0pPcOwBu0/hTMRVptZFqP/iE7fKmj4gENmGwzzOWFD/+J+yQI+8E8
         hqgUQI6J1A8IjTRAm7OdjhbVuUcGcpL6m2wKWbaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.5 202/241] KEYS: asymmetric: Fix sign/verify on pkcs1pad without a hash
Date:   Mon, 23 Oct 2023 12:56:28 +0200
Message-ID: <20231023104838.785220081@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit b11950356c4b416d2e87941f3aa7a8bf089db72b upstream.

The new sign/verify code broke the case of pkcs1pad without a
hash algorithm.  Fix it by setting issig correctly for this case.

Fixes: 63ba4d67594a ("KEYS: asymmetric: Use new crypto interface without scatterlists")
Cc: stable@vger.kernel.org # v6.5
Reported-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Tested-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/asymmetric_keys/public_key.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index abeecb8329b3..1dcab27986a6 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -81,14 +81,13 @@ software_key_determine_akcipher(const struct public_key *pkey,
 		 * RSA signatures usually use EMSA-PKCS1-1_5 [RFC3447 sec 8.2].
 		 */
 		if (strcmp(encoding, "pkcs1") == 0) {
+			*sig = op == kernel_pkey_sign ||
+			       op == kernel_pkey_verify;
 			if (!hash_algo) {
-				*sig = false;
 				n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
 					     "pkcs1pad(%s)",
 					     pkey->pkey_algo);
 			} else {
-				*sig = op == kernel_pkey_sign ||
-				       op == kernel_pkey_verify;
 				n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
 					     "pkcs1pad(%s,%s)",
 					     pkey->pkey_algo, hash_algo);
-- 
2.42.0



