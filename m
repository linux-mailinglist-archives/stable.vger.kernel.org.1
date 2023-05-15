Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D13703791
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244075AbjEORWx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244030AbjEORWh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136B10E51
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36ABF62C37
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE50C433D2;
        Mon, 15 May 2023 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171215;
        bh=gNPcKuGT0Edu8VI/jqqMS5OfNqZziwP+C1sNimQk2/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHjeDJGU4IzTEE7hwYwmbZunQ4pTeubVHrdEJzcKOD8N8LXL6R7DwAs9GcTxwW42V
         Z0LOFNw8spMiC10WyuWBhAnMDMElw4GT2yl7fatJgRJnPulhuENX8jprktP6tvSuQ3
         06r2lGKgTrtFw5+zXu83QBTUKVWzEEIkP6/cj/dY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sylvain Ouellet <souellet@genetec.com>,
        Olivier Bacon <obacon@genetec.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 108/242] crypto: engine - fix crypto_queue backlog handling
Date:   Mon, 15 May 2023 18:27:14 +0200
Message-Id: <20230515161725.143374234@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Olivier Bacon <olivierb89@gmail.com>

[ Upstream commit 4140aafcff167b5b9e8dae6a1709a6de7cac6f74 ]

CRYPTO_TFM_REQ_MAY_BACKLOG tells the crypto driver that it should
internally backlog requests until the crypto hw's queue becomes
full. At that point, crypto_engine backlogs the request and returns
-EBUSY. Calling driver such as dm-crypt then waits until the
complete() function is called with a status of -EINPROGRESS before
sending a new request.

The problem lies in the call to complete() with a value of -EINPROGRESS
that is made when a backlog item is present on the queue. The call is
done before the successful execution of the crypto request. In the case
that do_one_request() returns < 0 and the retry support is available,
the request is put back in the queue. This leads upper drivers to send
a new request even if the queue is still full.

The problem can be reproduced by doing a large dd into a crypto
dm-crypt device. This is pretty easy to see when using
Freescale CAAM crypto driver and SWIOTLB dma. Since the actual amount
of requests that can be hold in the queue is unlimited we get IOs error
and dma allocation.

The fix is to call complete with a value of -EINPROGRESS only if
the request is not enqueued back in crypto_queue. This is done
by calling complete() later in the code. In order to delay the decision,
crypto_queue is modified to correctly set the backlog pointer
when a request is enqueued back.

Fixes: 6a89f492f8e5 ("crypto: engine - support for parallel requests based on retry mechanism")
Co-developed-by: Sylvain Ouellet <souellet@genetec.com>
Signed-off-by: Sylvain Ouellet <souellet@genetec.com>
Signed-off-by: Olivier Bacon <obacon@genetec.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algapi.c        | 3 +++
 crypto/crypto_engine.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 9de0677b3643d..60b98d2c400e3 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -963,6 +963,9 @@ EXPORT_SYMBOL_GPL(crypto_enqueue_request);
 void crypto_enqueue_request_head(struct crypto_queue *queue,
 				 struct crypto_async_request *request)
 {
+	if (unlikely(queue->qlen >= queue->max_qlen))
+		queue->backlog = queue->backlog->prev;
+
 	queue->qlen++;
 	list_add(&request->list, &queue->list);
 }
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 48c15f4079bb8..50bac2ab55f17 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -129,9 +129,6 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	if (!engine->retry_support)
 		engine->cur_req = async_req;
 
-	if (backlog)
-		crypto_request_complete(backlog, -EINPROGRESS);
-
 	if (engine->busy)
 		was_busy = true;
 	else
@@ -217,6 +214,9 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	crypto_request_complete(async_req, ret);
 
 retry:
+	if (backlog)
+		crypto_request_complete(backlog, -EINPROGRESS);
+
 	/* If retry mechanism is supported, send new requests to engine */
 	if (engine->retry_support) {
 		spin_lock_irqsave(&engine->queue_lock, flags);
-- 
2.39.2



