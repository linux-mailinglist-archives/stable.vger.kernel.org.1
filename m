Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845DF7A7C75
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjITMBc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjITMB3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:01:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FF0B4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:01:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9EAC433C8;
        Wed, 20 Sep 2023 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211279;
        bh=s2vc7+2lfXXVJX7ZscKTSG7Ap+3Lq06ckWfpxRDgW1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdKlgZAkB9ECCqLyhBCFf9Y6u3vUK6wDpcisBHAjByZSGGiAiUnniUZL/I74vRlvX
         C2YVyvwkHECDTIX0qzp0jPz0pBqpSzm0KD2ScksRu/JYrsG27QYt5mmfiCw1M1HCTr
         Ur/RdZehRSUmpI+/PrNt1nLQUgPTH+ZmVBsPG4hM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sabrina Dubroca <sd@queasysnail.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 4.14 034/186] Revert "net: macsec: preserve ingress frame ordering"
Date:   Wed, 20 Sep 2023 13:28:57 +0200
Message-ID: <20230920112838.175666993@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

commit d3287e4038ca4f81e02067ab72d087af7224c68b upstream.

This reverts commit ab046a5d4be4c90a3952a0eae75617b49c0cb01b.

It was trying to work around an issue at the crypto layer by excluding
ASYNC implementations of gcm(aes), because a bug in the AESNI version
caused reordering when some requests bypassed the cryptd queue while
older requests were still pending on the queue.

This was fixed by commit 38b2f68b4264 ("crypto: aesni - Fix cryptd
reordering problem on gcm"), which pre-dates ab046a5d4be4.

Herbert Xu confirmed that all ASYNC implementations are expected to
maintain the ordering of completions wrt requests, so we can use them
in MACsec.

On my test machine, this restores the performance of a single netperf
instance, from 1.4Gbps to 4.4Gbps.

Link: https://lore.kernel.org/netdev/9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net/T/
Link: https://lore.kernel.org/netdev/1b0cec71-d084-8153-2ba4-72ce71abeb65@byu.edu/
Link: https://lore.kernel.org/netdev/d335ddaa-18dc-f9f0-17ee-9783d3b2ca29@mailbox.tu-dresden.de/
Fixes: ab046a5d4be4 ("net: macsec: preserve ingress frame ordering")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/11c952469d114db6fb29242e1d9545e61f52f512.1693757159.git.sd@queasysnail.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macsec.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1311,8 +1311,7 @@ static struct crypto_aead *macsec_alloc_
 	struct crypto_aead *tfm;
 	int ret;
 
-	/* Pick a sync gcm(aes) cipher to ensure order is preserved. */
-	tfm = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
+	tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
 
 	if (IS_ERR(tfm))
 		return tfm;


