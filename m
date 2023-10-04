Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9D7B88C1
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjJDSTM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjJDSTL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:19:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5DAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:19:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AF5C433CA;
        Wed,  4 Oct 2023 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443548;
        bh=uzcVI1YMNbpUuL1ORaiG6QunW4/i63BKUwLHOjLcqhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTV3A60hOEwYXJJL7X0Nny9ixknc2gUzx+zkJHIvXlBirBQUZTvXMx+SnwdehsmMq
         K7xnzo3K3hz4lOGWOh8sFOMHwXJKYAirnEGd1iku/xbctsNG8dAFO71qdsKwaftinv
         4oVTSNRx+L3XfaLYFVo4bTgPU23QCWZ1jVSKMlPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 196/259] tsnep: Fix NAPI polling with budget 0
Date:   Wed,  4 Oct 2023 19:56:09 +0200
Message-ID: <20231004175226.269608428@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerhard Engleder <gerhard@engleder-embedded.com>

[ Upstream commit 46589db3817bd8b523701274885984b5a5dda7d1 ]

According to the NAPI documentation networking/napi.rst, Rx specific
APIs like page pool and XDP cannot be used at all when budget is 0.
skb Tx processing should happen regardless of the budget.

Stop NAPI polling after Tx processing and skip Rx processing if budget
is 0.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 00436a6f785e8..2be518db04270 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -930,6 +930,10 @@ static int tsnep_poll(struct napi_struct *napi, int budget)
 	if (queue->tx)
 		complete = tsnep_tx_poll(queue->tx, budget);
 
+	/* handle case where we are called by netpoll with a budget of 0 */
+	if (unlikely(budget <= 0))
+		return budget;
+
 	if (queue->rx) {
 		done = tsnep_rx_poll(queue->rx, napi, budget);
 		if (done >= budget)
-- 
2.40.1



