Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DCC7ED3FA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbjKOUzi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjKOUzh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:55:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF1EE6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:55:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D4DC4E779;
        Wed, 15 Nov 2023 20:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081734;
        bh=sOFDhADzDslnLqDyVIamNC34Dx/3xUetyEYcj7iVDvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTFfoxoUM1s18r44/hHFpSrLQBgoiIj1VTFLyhVS8bw/0k0X/kGWprsBn5gPZ1cBm
         9Tq58EYfNfv3DiLu0zsHubgp+wd76cBueqSCcYrYF5FtUCUhkBY5Ul0OnKTqiHKj5N
         bDiin6YTkuBIhQPxZimgaKvbQ8vGbVw9yVl2Fl/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 092/191] crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure
Date:   Wed, 15 Nov 2023 15:46:07 -0500
Message-ID: <20231115204650.091547917@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 5a40c7d10cc9a..43bed47ce59be 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -636,7 +636,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 	if (keylen != CHACHA_KEY_SIZE + saltlen)
 		return -EINVAL;
 
-	ctx->cdata.key_virt = key;
+	memcpy(ctx->key, key, keylen);
+	ctx->cdata.key_virt = ctx->key;
 	ctx->cdata.keylen = keylen - saltlen;
 
 	return chachapoly_set_sh_desc(aead);
-- 
2.42.0



