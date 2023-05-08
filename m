Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D76FADD1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjEHLil (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbjEHLiH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E94411AE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D55566329C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ECFC433D2;
        Mon,  8 May 2023 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545854;
        bh=phMYKKDD7fkJ/82gkeFWpH6i03l/fxNaYtTWU7IZSc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxr1K4ZX3cpbXnUC4WXRhTJJuuY5c3/JbmV+P/Kpt2uOT0coZbeTGdApqcnf1fk4W
         UN+Lq++S0GhoHar7xovAe3ZTi9HooTUgNl+RnOeFfEt/rKqJFe/acO1LG3r+WdK1be
         FmOzNQBV+Re8CkYfFwSC2jClot+M3YyLwOwuLAZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suman Anna <s-anna@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 176/371] crypto: sa2ul - Select CRYPTO_DES
Date:   Mon,  8 May 2023 11:46:17 +0200
Message-Id: <20230508094819.125071903@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Suman Anna <s-anna@ti.com>

[ Upstream commit 8832023efd20966e29944dac92118dfbf1fa1bc0 ]

The SA2UL Crypto driver provides support for couple of
DES3 algos "cbc(des3_ede)" and "ecb(des3_ede)", and enabling
the crypto selftest throws the following errors (as seen on
K3 J721E SoCs):
  saul-crypto 4e00000.crypto: Error allocating fallback algo cbc(des3_ede)
  alg: skcipher: failed to allocate transform for cbc-des3-sa2ul: -2
  saul-crypto 4e00000.crypto: Error allocating fallback algo ecb(des3_ede)
  alg: skcipher: failed to allocate transform for ecb-des3-sa2ul: -2

Fix this by selecting CRYPTO_DES which was missed while
adding base driver support.

Fixes: 7694b6ca649f ("crypto: sa2ul - Add crypto driver")
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index b46343b5c26b4..a40883e118424 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -905,6 +905,7 @@ config CRYPTO_DEV_SA2UL
 	select CRYPTO_AES_ARM64
 	select CRYPTO_ALGAPI
 	select CRYPTO_AUTHENC
+	select CRYPTO_DES
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
-- 
2.39.2



