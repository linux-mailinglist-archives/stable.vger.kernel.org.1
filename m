Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24867CAB4F
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjJPOYa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJPOYa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:24:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DB89C
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:24:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3B1C433C8;
        Mon, 16 Oct 2023 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697466268;
        bh=73Q+X8gRwVJodVh8+NHPOYxWeuOvAWFRgAex7T2LS54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHSSA2fng82E/ZrVec/Id874YW46RkPPGzJK398Y6NYi45bYmoosD5jRWCvui9NiR
         iDMDo33FOs3dfcMsF9VPf55DR8xEx7utlTLp/AXPUnajlqRKPi3cwcQ08FKCoBOL8T
         E4h8JZzGcwicWfcnnVLF+VB8Qk3RAPbKto26+qaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Tatu=20Heikkil=C3=A4?= <tatu.heikkila@gmail.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.5 018/191] dm crypt: Fix reqsize in crypt_iv_eboiv_gen
Date:   Mon, 16 Oct 2023 10:40:03 +0200
Message-ID: <20231016084015.827734362@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 152d0bcdf1efcb54a4fa20f694e9c7bbb6d06cbf upstream.

A skcipher_request object is made up of struct skcipher_request
followed by a variable-sized trailer.  The allocation of the
skcipher_request and IV in crypt_iv_eboiv_gen is missing the
memory for struct skcipher_request.  Fix it by adding it to
reqsize.

Fixes: e3023094dffb ("dm crypt: Avoid using MAX_CIPHER_BLOCKSIZE")
Cc: <stable@vger.kernel.org> #6.5+
Reported-by: Tatu Heikkilä <tatu.heikkila@gmail.com>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index f2662c21a6df..5315fd261c23 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -753,7 +753,8 @@ static int crypt_iv_eboiv_gen(struct crypt_config *cc, u8 *iv,
 	int err;
 	u8 *buf;
 
-	reqsize = ALIGN(crypto_skcipher_reqsize(tfm), __alignof__(__le64));
+	reqsize = sizeof(*req) + crypto_skcipher_reqsize(tfm);
+	reqsize = ALIGN(reqsize, __alignof__(__le64));
 
 	req = kmalloc(reqsize + cc->iv_size, GFP_NOIO);
 	if (!req)
-- 
2.42.0



