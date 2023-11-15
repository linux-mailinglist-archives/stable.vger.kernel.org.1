Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C381E7ED469
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbjKOU6B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjKOU5f (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92D172C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83195C4AF76;
        Wed, 15 Nov 2023 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081417;
        bh=jKPCp6NnqQiRiXUkD6+XJzKjNkY4u3hFXLbLZlTLoiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yQVTszIQ0geZtDWBrgrJktnO864jVfCrbBhlsoZwYZgWBcWdxhdii4d+mb/K5pKbN
         Gc/FI3frN1ZxVUjuKv7oVenHRdy7RaswhofVlbEuvfKaIsU/moQ7Eed3sja9vHa2yL
         mTAShsT53xrjgo/2wBR+qiaezUtgKJD2GyAogDq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 134/244] crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure
Date:   Wed, 15 Nov 2023 15:35:26 -0500
Message-ID: <20231115203556.400038951@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav Jain <gaurav.jain@nxp.com>

[ Upstream commit 7b8c6aee0d5b864e70c0da82583f9862e374eaf3 ]

key buffer is not copied in chachapoly_setkey function,
results in wrong output for encryption/decryption operation.

fix this by memcpy the key in caam_ctx key arrary

Fixes: c10a53367901 ("crypto: caam/qi2 - add support for Chacha20 + Poly1305")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caamalg_qi2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 6753f0e6e55d1..35c4e29033d55 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -639,7 +639,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 	if (keylen != CHACHA_KEY_SIZE + saltlen)
 		return -EINVAL;
 
-	ctx->cdata.key_virt = key;
+	memcpy(ctx->key, key, keylen);
+	ctx->cdata.key_virt = ctx->key;
 	ctx->cdata.keylen = keylen - saltlen;
 
 	return chachapoly_set_sh_desc(aead);
-- 
2.42.0



