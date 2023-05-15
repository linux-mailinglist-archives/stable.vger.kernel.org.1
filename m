Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9E7033C2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbjEOQlO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242866AbjEOQlF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49AD420B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF106287A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F1CC433EF;
        Mon, 15 May 2023 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168862;
        bh=4pJEIKx4+a7gE73pHJQTqEAJE+KO8WjUlvrNjiZqzUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwPG7qNbKzlqvBZpDMiFaUBCN5JMKADYpo9Bq2L9v6xINHA4yXmft7jmZH3PAZni7
         ya5mhEHkBRJbB5fJxZrrWGwqVkoTl4lgFZU4UIGEQ52MSDO0e5SCGdsofi6ZyHafEQ
         ONakC6apVcDtQUobxR6FQXU3Dt/bt+IWj/g+tieI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
        Stephan Mueller <smueller@chronox.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 066/191] crypto: drbg - Only fail when jent is unavailable in FIPS mode
Date:   Mon, 15 May 2023 18:25:03 +0200
Message-Id: <20230515161709.604973336@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 686cd976b6ddedeeb1a1fb09ba53a891d3cc9a03 ]

When jent initialisation fails for any reason other than ENOENT,
the entire drbg fails to initialise, even when we're not in FIPS
mode.  This is wrong because we can still use the kernel RNG when
we're not in FIPS mode.

Change it so that it only fails when we are in FIPS mode.

Fixes: 57225e679788 ("crypto: drbg - Use callback API for random readiness")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/drbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 8b80fd3690ff4..0df8cc9bb5637 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1516,7 +1516,7 @@ static int drbg_prepare_hrng(struct drbg_state *drbg)
 		const int err = PTR_ERR(drbg->jent);
 
 		drbg->jent = NULL;
-		if (fips_enabled || err != -ENOENT)
+		if (fips_enabled)
 			return err;
 		pr_info("DRBG: Continuing without Jitter RNG\n");
 	}
-- 
2.39.2



