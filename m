Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537157ED6BE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbjKOWDT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbjKOWDP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:03:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC16193
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:03:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4212C433C8;
        Wed, 15 Nov 2023 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085792;
        bh=OfIqcfuqM5xnF1Os/xQn1vdY0nXMw2chHGSFKhYwmw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcu2jB/XPTm9SqWzAXqGbXiAA1xxuQImLXxbGYiADSKLKU8MUEpBOb0cy1m4Hj48r
         q6GMjXs7D+q4WN2oiz7q4GhlXl0yZj2IyHB4K56MZVXY8l+qmiSFYyDd37yLS82aL5
         3n/7pC+l7HLh2U75Ng5TL/5YqaYRbg/S79yTbgYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 056/119] crypto: caam/jr - fix Chacha20 + Poly1305 self test failure
Date:   Wed, 15 Nov 2023 17:00:46 -0500
Message-ID: <20231115220134.362755024@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav Jain <gaurav.jain@nxp.com>

[ Upstream commit a8d3cdcc092fb2f2882acb6c20473a1be0ef4484 ]

key buffer is not copied in chachapoly_setkey function,
results in wrong output for encryption/decryption operation.

fix this by memcpy the key in caam_ctx key arrary

Fixes: d6bbd4eea243 ("crypto: caam/jr - add support for Chacha20 + Poly1305")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caamalg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index fdd994ee55e22..2db88213f13e2 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -553,7 +553,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 		return -EINVAL;
 	}
 
-	ctx->cdata.key_virt = key;
+	memcpy(ctx->key, key, keylen);
+	ctx->cdata.key_virt = ctx->key;
 	ctx->cdata.keylen = keylen - saltlen;
 
 	return chachapoly_set_sh_desc(aead);
-- 
2.42.0



