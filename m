Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3717ECB56
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjKOTVn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjKOTVf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:21:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE80D79
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:21:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F21C433C8;
        Wed, 15 Nov 2023 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076091;
        bh=iUcrxUccJBAN3lNCUsFWgmQK7BKdjBoqBxApRbBwRaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcD8T1th7frG82JNGRwYQjPIlvsbzEhUvCpgg1kgGEufhJ8xnQu6sgP/Xk1AGMkvp
         nXkF+bxgkGUva8ixYatw3xucGEouxFsPnipFmunWxPEyQnzMCp1CvyHo+3/vmtJF+W
         zir/Lp9GVOMVv5L14fqEgLC/1OJJc+LrX1oQTmNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 071/550] tls: Use size_add() in call to struct_size()
Date:   Wed, 15 Nov 2023 14:10:55 -0500
Message-ID: <20231115191605.624788017@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index ce925f3a52492..57e4601eaaf50 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1488,7 +1488,7 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
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



