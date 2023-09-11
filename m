Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6121979AFE8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbjIKVjL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241248AbjIKPEz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:04:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CF0125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:04:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3B7C433C7;
        Mon, 11 Sep 2023 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444691;
        bh=gJ2if7JVhd9EzKXdMy2/WvkVlurddx1W3m5R8VRSIQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7R8yKAhN7YUw/3wPFMEHMD8POj0rSufyUuYh6x9Fyq7I0X2IXCJYPHsDEK7UNDVb
         sJb3MhDrYXLv+/2HtR7iAjZGtzRSt0ncMmfyeYgHdnpBPYxs997pp3+gZj5wD6UfuV
         qgFcepLvFaDKh1u4Q4glCJTaTfTg2o+QS3+0ZJ3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 6.1 080/600] crypto: rsa-pkcs1pad - Use helper to set reqsize
Date:   Mon, 11 Sep 2023 15:41:53 +0200
Message-ID: <20230911134635.978850494@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 5b11d1a360ea23c80c6d4ec3f5986a788d0a0995 upstream.

The value of reqsize must only be changed through the helper.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/rsa-pkcs1pad.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -575,6 +575,10 @@ static int pkcs1pad_init_tfm(struct cryp
 		return PTR_ERR(child_tfm);
 
 	ctx->child = child_tfm;
+
+	akcipher_set_reqsize(tfm, sizeof(struct pkcs1pad_request) +
+				  crypto_akcipher_reqsize(child_tfm));
+
 	return 0;
 }
 
@@ -670,7 +674,6 @@ static int pkcs1pad_create(struct crypto
 	inst->alg.set_pub_key = pkcs1pad_set_pub_key;
 	inst->alg.set_priv_key = pkcs1pad_set_priv_key;
 	inst->alg.max_size = pkcs1pad_get_max_size;
-	inst->alg.reqsize = sizeof(struct pkcs1pad_request) + rsa_alg->reqsize;
 
 	inst->free = pkcs1pad_free;
 


