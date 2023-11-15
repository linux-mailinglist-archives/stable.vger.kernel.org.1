Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D57ECD4A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjKOTfh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjKOTff (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25149E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205E8C433C8;
        Wed, 15 Nov 2023 19:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076932;
        bh=UPmgo+O8kX//RCtw7MPyPO3jy3cxSXOCslIX6sm/OT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQAxprl/aw5RV/+sUhVlTYoCNGb7dFMxr+W5ftHl0izNN1laHJdxwpPtAigGSxQfb
         C8UzIlJQ7odAqz0wdiyqmdbGDYf94f06mqFdHl3U9pkzng80xgJ0CBiChqXqPp/e9k
         M8jRJsASXmnEonwhge6HAzEKS/UzZTXf7EOW/Hko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 068/603] tls: Use size_add() in call to struct_size()
Date:   Wed, 15 Nov 2023 14:10:13 -0500
Message-ID: <20231115191617.832388703@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit a2713257ee2be22827d7bc248302d408c91bfb95 ]

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: b89fec54fd61 ("tls: rx: wrap decrypt params in a struct")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e9d1e83a859d1..9634dfd636fd6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1491,7 +1491,7 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 	 */
 	aead_size = sizeof(*aead_req) + crypto_aead_reqsize(ctx->aead_recv);
 	aead_size = ALIGN(aead_size, __alignof__(*dctx));
-	mem = kmalloc(aead_size + struct_size(dctx, sg, n_sgin + n_sgout),
+	mem = kmalloc(aead_size + struct_size(dctx, sg, size_add(n_sgin, n_sgout)),
 		      sk->sk_allocation);
 	if (!mem) {
 		err = -ENOMEM;
-- 
2.42.0



