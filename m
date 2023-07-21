Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6B75D2A7
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGUTCL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGUTCJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:02:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E95A30E4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 820E661D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C11C433C7;
        Fri, 21 Jul 2023 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966126;
        bh=HvG5c/nDsy0VF8UTuZmniUkLMAH7WxOVsBnmyLQIeWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K85/YOaZuv/DLhtwlR/VrgqQqEzT6CiseJShXdMjrsJ3dVoaskhXoq7GH0MGVXgKK
         0cIMWBH4s1Iq3Nlu2+JuEmBwt+WepvaXRTH/AN+PHMJ9T2xH3JWffQmN9L/c9w2/Lj
         T2LTyI/hZjER669pOzY/shXoYYp/W4hCU3TN4M9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 234/532] crypto: kpp - Add helper to set reqsize
Date:   Fri, 21 Jul 2023 18:02:18 +0200
Message-ID: <20230721160627.062222395@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 56861cbde1b9f3b34d300e6ba87f2c3de1a9c309 ]

The value of reqsize should only be changed through a helper.
To do so we need to first add a helper for this.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: eb7713f5ca97 ("crypto: qat - unmap buffer before free for DH")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/crypto/internal/kpp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/crypto/internal/kpp.h b/include/crypto/internal/kpp.h
index 659b642efada1..05b25a819d0d1 100644
--- a/include/crypto/internal/kpp.h
+++ b/include/crypto/internal/kpp.h
@@ -18,6 +18,12 @@ static inline void *kpp_request_ctx(struct kpp_request *req)
 	return req->__ctx;
 }
 
+static inline void kpp_set_reqsize(struct crypto_kpp *kpp,
+				   unsigned int reqsize)
+{
+	crypto_kpp_alg(kpp)->reqsize = reqsize;
+}
+
 static inline void *kpp_tfm_ctx(struct crypto_kpp *tfm)
 {
 	return tfm->base.__crt_ctx;
-- 
2.39.2



