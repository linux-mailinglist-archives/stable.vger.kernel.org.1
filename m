Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727F27A3A2A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbjIQT7c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbjIQT7Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:59:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC2812F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:59:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF09CC433C7;
        Sun, 17 Sep 2023 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980750;
        bh=bJaWUCa1vzsWC9RXCByak0J0fqI7t9vFy1vruR05C6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8nAuym9AUtpwNYxn2E/tPN2d6vSR6QfDm650t1tyVNASXbasG86P/u3LQWJEyPTd
         ZcHIV8AcCco7BG1gNTTMjq6DXVSLy4Yo8RQ1/jkYWBKoNBg/X1BZO/OCibe0CdnwWV
         hL3trqCTLeNtZR5UZGk8p1sLKpxqqVKk45BKL2ZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 282/285] net: renesas: rswitch: Fix unmasking irq condition
Date:   Sun, 17 Sep 2023 21:14:42 +0200
Message-ID: <20230917191100.900503614@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit e7b1ef29420fe52c2c1a273a9b4b36103a522625 ]

Fix unmasking irq condition by using napi_complete_done(). Otherwise,
redundant interrupts happen.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/rswitch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 4e412ac0965a4..449ed1f5624c9 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -816,10 +816,10 @@ static int rswitch_poll(struct napi_struct *napi, int budget)
 
 	netif_wake_subqueue(ndev, 0);
 
-	napi_complete(napi);
-
-	rswitch_enadis_data_irq(priv, rdev->tx_queue->index, true);
-	rswitch_enadis_data_irq(priv, rdev->rx_queue->index, true);
+	if (napi_complete_done(napi, budget - quota)) {
+		rswitch_enadis_data_irq(priv, rdev->tx_queue->index, true);
+		rswitch_enadis_data_irq(priv, rdev->rx_queue->index, true);
+	}
 
 out:
 	return budget - quota;
-- 
2.40.1



