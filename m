Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2A26FA53B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjEHKHO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjEHKHM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBA19AA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:07:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3BB962368
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA19CC433D2;
        Mon,  8 May 2023 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540430;
        bh=NKI7URWHclErG7JWSAy4HRVV1fTqy1bNBgqwEaAaLlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8x7K0NWh1cFuSYPbOxehEYwCBPnuWNr2SgOOZe53rm6MUmd4vUEv9R9692pWa+Hc
         1qSPnNnvvy1E34N6zS4JsGPIl9vitK0eqsTHKCg5LlIw42QVa10vh6Z2zMcjI4avAX
         3O0fi4ATPu9KOOjqtFC1VAJyAisP48VvjpHxzF6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kang Chen <void0red@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 362/611] wifi: mt76: handle failure of vzalloc in mt7615_coredump_work
Date:   Mon,  8 May 2023 11:43:24 +0200
Message-Id: <20230508094434.157676401@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Kang Chen <void0red@gmail.com>

[ Upstream commit 9e47dd9f64a47ae00ca0123017584c37209ee900 ]

vzalloc may fails, dump might be null and will cause
illegal address access later.

Link: https://lore.kernel.org/all/Y%2Fy5Asxw3T3m4jCw@lore-desk
Fixes: d2bf7959d9c0 ("mt76: mt7663: introduce coredump support")
Signed-off-by: Kang Chen <void0red@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d7a76c00d775f..faed43b11ec93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2343,7 +2343,7 @@ void mt7615_coredump_work(struct work_struct *work)
 			break;
 
 		skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
-		if (data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
+		if (!dump || data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
 			dev_kfree_skb(skb);
 			continue;
 		}
@@ -2353,6 +2353,8 @@ void mt7615_coredump_work(struct work_struct *work)
 
 		dev_kfree_skb(skb);
 	}
-	dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
-		      GFP_KERNEL);
+
+	if (dump)
+		dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
+			      GFP_KERNEL);
 }
-- 
2.39.2



