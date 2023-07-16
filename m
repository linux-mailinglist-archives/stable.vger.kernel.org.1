Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892875561D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjGPUrm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjGPUrl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8595CD9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D18460DFD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5AAC433C8;
        Sun, 16 Jul 2023 20:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540459;
        bh=0tcqVNSTf99UKfOObiqCCc26cJ6qUzBuwXHjnm5pMvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUuSpqxzfpFKpmhszJRJKpWLNrZ2U+ehTRr9poXX3cuMI2NZsCgfjEZLnU3Mf+5ct
         Ph/F4SCD6SlOtuzrlUjah90Hf0XcRACCjCdVH52zRnP0BDTiNcKIZ4He30njB8HUiG
         tDD6Yz1FAkNV5nKiMsbHHEVcH9u82W0a+TbWx/NM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 343/591] crypto: kpp - Add helper to set reqsize
Date:   Sun, 16 Jul 2023 21:48:02 +0200
Message-ID: <20230716194932.784082721@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index 9cb0662ebe871..31ff3c1986ef0 100644
--- a/include/crypto/internal/kpp.h
+++ b/include/crypto/internal/kpp.h
@@ -50,6 +50,12 @@ static inline void *kpp_request_ctx(struct kpp_request *req)
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



