Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A07039A7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbjEORom (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbjEORoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:44:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A280B18AAB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB8CD62E56
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCC3C433D2;
        Mon, 15 May 2023 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172519;
        bh=Do4W/MMIjeRqXdmG2MP+NGl+aJN4qHyN3/szobTp1Bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8CZ4gMzSVRtcnxcXTPujWvI7DezcUvZXZl2IdzexLH/5FmC+UNgtd+Hc9vaHyeEl
         GnSH58T3QKMBKJ/7w/d8ipazzVWqcepDXIXNIewfF9ZGz+oMpj7vGE4ZXNItpTM06O
         4Wzkjt6pgdZ36w+xTIqAosEOwQtjon6LwMo3faj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nicolai Stange <nstange@suse.de>,
        =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 162/381] crypto: drbg - make drbg_prepare_hrng() handle jent instantiation errors
Date:   Mon, 15 May 2023 18:26:53 +0200
Message-Id: <20230515161744.130357486@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicolai Stange <nstange@suse.de>

[ Upstream commit 559edd47cce4cc407d606b4d7f376822816fd4b8 ]

Now that drbg_prepare_hrng() doesn't do anything but to instantiate a
jitterentropy crypto_rng instance, it looks a little odd to have the
related error handling at its only caller, drbg_instantiate().

Move the handling of jitterentropy allocation failures from
drbg_instantiate() close to the allocation itself in drbg_prepare_hrng().

There is no change in behaviour.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Stephan Müller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 686cd976b6dd ("crypto: drbg - Only fail when jent is unavailable in FIPS mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/drbg.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index a4b5d6dbe99d3..ecc6b167b89e2 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1515,6 +1515,14 @@ static int drbg_prepare_hrng(struct drbg_state *drbg)
 		return 0;
 
 	drbg->jent = crypto_alloc_rng("jitterentropy_rng", 0, 0);
+	if (IS_ERR(drbg->jent)) {
+		const int err = PTR_ERR(drbg->jent);
+
+		drbg->jent = NULL;
+		if (fips_enabled || err != -ENOENT)
+			return err;
+		pr_info("DRBG: Continuing without Jitter RNG\n");
+	}
 
 	return 0;
 }
@@ -1570,14 +1578,6 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
 		if (ret)
 			goto free_everything;
 
-		if (IS_ERR(drbg->jent)) {
-			ret = PTR_ERR(drbg->jent);
-			drbg->jent = NULL;
-			if (fips_enabled || ret != -ENOENT)
-				goto free_everything;
-			pr_info("DRBG: Continuing without Jitter RNG\n");
-		}
-
 		reseed = false;
 	}
 
-- 
2.39.2



