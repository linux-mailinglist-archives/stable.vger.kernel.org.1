Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15B96FABA1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjEHLPe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjEHLPe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A2836CDD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9264762BE0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C5FC433D2;
        Mon,  8 May 2023 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544532;
        bh=6QRRbDY2V5DJ+QTrUKV0n+deR5dWL0QP3i1gj4Oqsng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOqEs+HMb47s/mkz6LlxmaUunlYS3Mb6o+kN5ufoR06u/GXEviAwDZyZ4bkrswg7O
         AZC4gGkg0TaRYhzP2ImN1qFfiKjogiEmapxlnggoSSH1ZrgHZ3EbC8ezZMxsH6XfFB
         xnV8h/lxt4uw7ldK0TIQU7ZWKK+Evalr5wNtFsM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 440/694] wifi: mt76: mt7996: fix pointer calculation in ie countdown event
Date:   Mon,  8 May 2023 11:44:35 +0200
Message-Id: <20230508094447.726205163@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit 8b14ce24a0297175bc4ebdf26d45a22b5a33847f ]

Fix the tail and data pointers. The rxd->len in mt7996_mcu_rxd does not
include the length of general rxd. It only includes the length of
firmware event rxd. Use skb->length to get the correct length.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 954e581f863ce..9ad6c889549c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -422,7 +422,8 @@ mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
 	if (hdr->band && dev->mt76.phys[hdr->band])
 		mphy = dev->mt76.phys[hdr->band];
 
-	tail = skb->data + le16_to_cpu(rxd->len);
+	tail = skb->data + skb->len;
+	data += sizeof(struct header);
 	while (data + sizeof(struct tlv) < tail && le16_to_cpu(tlv->len)) {
 		switch (le16_to_cpu(tlv->tag)) {
 		case UNI_EVENT_IE_COUNTDOWN_CSA:
-- 
2.39.2



