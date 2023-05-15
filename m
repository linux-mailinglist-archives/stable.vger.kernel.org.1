Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5C703789
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbjEORWW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbjEORWD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBBD132A2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C6762C39
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E22C433D2;
        Mon, 15 May 2023 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171209;
        bh=phV9mAp46YRgXmsCAh0zCANCV/rtaTL/l9opcLFudXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfGO9sUk7CFtGR8E0QYZZ3zAx+C/fJjNaMjffvy26E571FKOdfiROX8osBDjllm+2
         kfaoX/05cAPyTY/795oZkC4zZsR+RxZTclCqKUw3/c5FqVTS7rN9EjCPS2thiv5lJg
         Qu0s2HvzMZWLT26G8NvDxCDuLMDsTP4vfnZYu/Z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 106/242] crypto: api - Add scaffolding to change completion function signature
Date:   Mon, 15 May 2023 18:27:12 +0200
Message-Id: <20230515161725.081105591@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit c35e03eaece71101ff6cbf776b86403860ac8cc3 ]

The crypto completion function currently takes a pointer to a
struct crypto_async_request object.  However, in reality the API
does not allow the use of any part of the object apart from the
data field.  For example, ahash/shash will create a fake object
on the stack to pass along a different data field.

This leads to potential bugs where the user may try to dereference
or otherwise use the crypto_async_request object.

This patch adds some temporary scaffolding so that the completion
function can take a void * instead.  Once affected users have been
converted this can be removed.

The helper crypto_request_complete will remain even after the
conversion is complete.  It should be used instead of calling
the completion function directly.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 4140aafcff16 ("crypto: engine - fix crypto_queue backlog handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/crypto/algapi.h | 7 +++++++
 include/linux/crypto.h  | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 61b327206b557..1fd81e74a174f 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -302,4 +302,11 @@ enum {
 	CRYPTO_MSG_ALG_LOADED,
 };
 
+static inline void crypto_request_complete(struct crypto_async_request *req,
+					   int err)
+{
+	crypto_completion_t complete = req->complete;
+	complete(req, err);
+}
+
 #endif	/* _CRYPTO_ALGAPI_H */
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 5d1e961f810ec..b18f6e669fb10 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -176,6 +176,7 @@ struct crypto_async_request;
 struct crypto_tfm;
 struct crypto_type;
 
+typedef struct crypto_async_request crypto_completion_data_t;
 typedef void (*crypto_completion_t)(struct crypto_async_request *req, int err);
 
 /**
@@ -595,6 +596,11 @@ struct crypto_wait {
 /*
  * Async ops completion helper functioons
  */
+static inline void *crypto_get_completion_data(crypto_completion_data_t *req)
+{
+	return req->data;
+}
+
 void crypto_req_done(struct crypto_async_request *req, int err);
 
 static inline int crypto_wait_req(int err, struct crypto_wait *wait)
-- 
2.39.2



