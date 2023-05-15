Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C900B703861
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbjEORcQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbjEORbh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:31:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AFD84D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E8562094
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A633AC433D2;
        Mon, 15 May 2023 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171710;
        bh=869JPjm8BrTCNzpF2FJl580eYMjSJ9ykLkFepzB+MFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRYTy2FoqoUlW5D5hcyEmklPzv+KbAleKo2yus95UNqRgXCxHPx/WyPdeUNVimNYV
         ruCbd+EzQyAOjn5eZPqQBFO3CpbC1qsNZtsmr/oWI91wM+PtmR/SsalmWUzUUYuYT7
         z5YWCbOIaf2577VT9y6i3qMhObj5aef9fjtg29a0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 054/134] crypto: engine - check if BH is disabled during completion
Date:   Mon, 15 May 2023 18:28:51 +0200
Message-Id: <20230515161704.950352944@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit 4058cf08945c18a6de193f4118fd05d83d3d4285 ]

When doing iperf over ipsec with crypto hardware sun8i-ce, I hit some
spinlock recursion bug.

This is due to completion function called with enabled BH.

Add check a to detect this.

Fixes: 735d37b5424b ("crypto: engine - Introduce the block request crypto engine framework")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 4140aafcff16 ("crypto: engine - fix crypto_queue backlog handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/crypto_engine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index cff21f4e03e32..fecf6baaa4f7d 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -53,6 +53,7 @@ static void crypto_finalize_request(struct crypto_engine *engine,
 				dev_err(engine->dev, "failed to unprepare request\n");
 		}
 	}
+	lockdep_assert_in_softirq();
 	req->complete(req, err);
 
 	kthread_queue_work(engine->kworker, &engine->pump_requests);
-- 
2.39.2



