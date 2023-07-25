Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8E76148A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjGYLUV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjGYLUS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C51990
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7CEF6168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4062C433C9;
        Tue, 25 Jul 2023 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284016;
        bh=R+aBN2v5N0Uho5287uk3JrYDnsoFpEGfPNxtbqp0zRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jU02eNfQOaFRJE56RWxn00lUSaNPJe0WOV5s7fDzO0Ev0n5yB/pJWvIkRLWUWAqjQ
         RJJ7mqcP7oIN2UQCKvGoim2Hm+LRq0GHLA4EQuSk5fAOAVirhL+JtuxBCrN+dy/PH3
         grBE+edy8xGqVYWkeVi5lqOM4p22z754DL9n9Kbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 204/509] crypto: marvell/cesa - Fix type mismatch warning
Date:   Tue, 25 Jul 2023 12:42:23 +0200
Message-ID: <20230725104603.081179435@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit efbc7764c4446566edb76ca05e903b5905673d2e ]

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") uncovered
a type mismatch in cesa 3des support that leads to a memcpy beyond the
end of a structure:

In function 'fortify_memcpy_chk',
    inlined from 'mv_cesa_des3_ede_setkey' at drivers/crypto/marvell/cesa/cipher.c:307:2:
include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  583 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is probably harmless as the actual data that is copied has the correct
type, but clearly worth fixing nonetheless.

Fixes: 4ada48397823 ("crypto: marvell/cesa - add Triple-DES support")
Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/marvell/cesa/cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa/cipher.c b/drivers/crypto/marvell/cesa/cipher.c
index 596a8c74e40a5..8dc10f9988948 100644
--- a/drivers/crypto/marvell/cesa/cipher.c
+++ b/drivers/crypto/marvell/cesa/cipher.c
@@ -287,7 +287,7 @@ static int mv_cesa_des_setkey(struct crypto_skcipher *cipher, const u8 *key,
 static int mv_cesa_des3_ede_setkey(struct crypto_skcipher *cipher,
 				   const u8 *key, unsigned int len)
 {
-	struct mv_cesa_des_ctx *ctx = crypto_skcipher_ctx(cipher);
+	struct mv_cesa_des3_ctx *ctx = crypto_skcipher_ctx(cipher);
 	int err;
 
 	err = verify_skcipher_des3_key(cipher, key);
-- 
2.39.2



