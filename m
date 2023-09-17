Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019087A3AEA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbjIQUKo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbjIQUKV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:10:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634212F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:10:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB16C433C8;
        Sun, 17 Sep 2023 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981407;
        bh=rCWLm6prmeO9GzqTzgw/lq8j47OkGqe3LvKUId17xSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5fP7KwwgrvoQJ0U1P11S1M83ixf4C3NNrqDIU6EgY1ePLeqskQKRidtzxFPQ25Cd
         LfotfVTsj+IqJVMVQI/lSmK47o6l6Uf4T1WkAjKpvCAh4+vie9hS2JXELNBJpl6+6A
         xGEtPrgRlNuByY6k0Es8Y0jVKqcLTHA+c5v2UbwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 5.15 049/511] crypto: rsa-pkcs1pad - Use helper to set reqsize
Date:   Sun, 17 Sep 2023 21:07:56 +0200
Message-ID: <20230917191115.059229808@linuxfoundation.org>
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
@@ -574,6 +574,10 @@ static int pkcs1pad_init_tfm(struct cryp
 		return PTR_ERR(child_tfm);
 
 	ctx->child = child_tfm;
+
+	akcipher_set_reqsize(tfm, sizeof(struct pkcs1pad_request) +
+				  crypto_akcipher_reqsize(child_tfm));
+
 	return 0;
 }
 
@@ -669,7 +673,6 @@ static int pkcs1pad_create(struct crypto
 	inst->alg.set_pub_key = pkcs1pad_set_pub_key;
 	inst->alg.set_priv_key = pkcs1pad_set_priv_key;
 	inst->alg.max_size = pkcs1pad_get_max_size;
-	inst->alg.reqsize = sizeof(struct pkcs1pad_request) + rsa_alg->reqsize;
 
 	inst->free = pkcs1pad_free;
 


