Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4977B8A51
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbjJDSeS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244391AbjJDSeR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:34:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08306C4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:34:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B142C433CA;
        Wed,  4 Oct 2023 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444453;
        bh=ZGkzdKJ65adkR+pcci+EKjRxW7o0SS9LPgaMeBSvru4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ays9UR7A9Y3YTnHQ4P58Gi7Lny0HnwJtE16y16bYeN+rEFlsZ+Xiokv06R1amfJBe
         kzOgszQ77A23GxQ9OW08mj5FPDzqQPi53/xz5JMBZCnhNUUFscDvyu17mXZV8du44N
         cnTW7X5Btu/JZi6h/RCFZbUY6BZBXCV0WrWo/IFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.5 256/321] crypto: sm2 - Fix crash caused by uninitialized context
Date:   Wed,  4 Oct 2023 19:56:41 +0200
Message-ID: <20231004175241.126277021@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

commit 21155620fbf2edbb071144894ff9d67ba9a1faa0 upstream.

In sm2_compute_z_digest() function, the newly allocated structure
mpi_ec_ctx is used, but forget to initialize it, which will cause
a crash when performing subsequent operations.

Fixes: e5221fa6a355 ("KEYS: asymmetric: Move sm2 code into x509_public_key")
Cc: stable@vger.kernel.org # v6.5
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/sm2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/crypto/sm2.c b/crypto/sm2.c
index 285b3cb7c0bc..5ab120d74c59 100644
--- a/crypto/sm2.c
+++ b/crypto/sm2.c
@@ -278,10 +278,14 @@ int sm2_compute_z_digest(struct shash_desc *desc,
 	if (!ec)
 		return -ENOMEM;
 
-	err = __sm2_set_pub_key(ec, key, keylen);
+	err = sm2_ec_ctx_init(ec);
 	if (err)
 		goto out_free_ec;
 
+	err = __sm2_set_pub_key(ec, key, keylen);
+	if (err)
+		goto out_deinit_ec;
+
 	bits_len = SM2_DEFAULT_USERID_LEN * 8;
 	entl[0] = bits_len >> 8;
 	entl[1] = bits_len & 0xff;
-- 
2.42.0



