Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ADF73EA37
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjFZSom (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjFZSoj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECA4188
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05CE660F53
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA0DC433C9;
        Mon, 26 Jun 2023 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805072;
        bh=ipbiuNGSXrDk9u7Gr7P6Gix0EtRb7BDU/U0fCwdGs10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYK/pVs12ckixtTzNnVwst3r18d2ElVETfESB2kmDXkOwF7NLcXMUmNQ0D0Kvvw3B
         9vQEfOI/s7vb0r1yF1TdIxJ2kGlDhWfi6ta8OnU21mLWQXqBjEypXpxq/fNMM9PBdh
         avk9h4FhktSsx98rT5s1aqdAptOKLObR78SiLOjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Wahren <stefan.wahren@i2se.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 41/81] net: qca_spi: Avoid high load if QCA7000 is not available
Date:   Mon, 26 Jun 2023 20:12:23 +0200
Message-ID: <20230626180746.137306561@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
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

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 92717c2356cb62c89e8a3dc37cbbab2502562524 ]

In case the QCA7000 is not available via SPI (e.g. in reset),
the driver will cause a high load. The reason for this is
that the synchronization is never finished and schedule()
is never called. Since the synchronization is not timing
critical, it's safe to drop this from the scheduling condition.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qualcomm/qca_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 36bcb5db3be97..44fa959ebcaa5 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -574,8 +574,7 @@ qcaspi_spi_thread(void *data)
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if ((qca->intr_req == qca->intr_svc) &&
-		    (qca->txr.skb[qca->txr.head] == NULL) &&
-		    (qca->sync == QCASPI_SYNC_READY))
+		    !qca->txr.skb[qca->txr.head])
 			schedule();
 
 		set_current_state(TASK_RUNNING);
-- 
2.39.2



