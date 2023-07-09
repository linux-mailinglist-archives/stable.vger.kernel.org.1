Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F4074C3B2
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjGILfQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjGILfQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:35:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F10F95
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 147B460B51
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D2FC433C9;
        Sun,  9 Jul 2023 11:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902514;
        bh=GkWTux36hETjWavF7BEv1VhI2waDC62Dp+gNcL3pfn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbbtP20su8QOrMXQY3jrMaMzVAm2Yzb1rJoMaYp1mI+t+dl3YGdPCRsRX0dgrSvcX
         5VMyBuOQ4EGKSdpbp499FFle4XrWGzwjb8BOvoKL4xc9AeSOxOCGsolrV4GhRxHb/Z
         Ligt7CJsHhhNrUmhQaP+Ka4yspf+NFhpQcp0n/zo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joachim Vandersmissen <git@jvdsn.com>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 404/431] crypto: jitter - correct health test during initialization
Date:   Sun,  9 Jul 2023 13:15:52 +0200
Message-ID: <20230709111500.651894380@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Stephan Müller <smueller@chronox.de>

[ Upstream commit d23659769ad1bf2cbafaa0efcbae20ef1a74f77e ]

With the update of the permanent and intermittent health errors, the
actual indicator for the health test indicates a potential error only
for the one offending time stamp gathered in the current iteration
round. The next iteration round will "overwrite" the health test result.

Thus, the entropy collection loop in jent_gen_entropy checks for
the health test failure upon each loop iteration. However, the
initialization operation checked for the APT health test once for
an APT window which implies it would not catch most errors.

Thus, the check for all health errors is now invoked unconditionally
during each loop iteration for the startup test.

With the change, the error JENT_ERCT becomes unused as all health
errors are only reported with the JENT_HEALTH return code. This
allows the removal of the error indicator.

Fixes: 3fde2fe99aa6 ("crypto: jitter - permanent and intermittent health errors"
)
Reported-by: Joachim Vandersmissen <git@jvdsn.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/jitterentropy.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 22f48bf4c6f57..227cedfa4f0ae 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -117,7 +117,6 @@ struct rand_data {
 				   * zero). */
 #define JENT_ESTUCK		8 /* Too many stuck results during init. */
 #define JENT_EHEALTH		9 /* Health test failed during initialization */
-#define JENT_ERCT		10 /* RCT failed during initialization */
 
 /*
  * The output n bits can receive more than n bits of min entropy, of course,
@@ -762,14 +761,12 @@ int jent_entropy_init(void)
 			if ((nonstuck % JENT_APT_WINDOW_SIZE) == 0) {
 				jent_apt_reset(&ec,
 					       delta & JENT_APT_WORD_MASK);
-				if (jent_health_failure(&ec))
-					return JENT_EHEALTH;
 			}
 		}
 
-		/* Validate RCT */
-		if (jent_rct_failure(&ec))
-			return JENT_ERCT;
+		/* Validate health test result */
+		if (jent_health_failure(&ec))
+			return JENT_EHEALTH;
 
 		/* test whether we have an increasing timer */
 		if (!(time2 > time))
-- 
2.39.2



