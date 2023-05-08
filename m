Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255E26FABD0
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjEHLRo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjEHLRn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:17:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD32B37622
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6539262C07
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBFFC433D2;
        Mon,  8 May 2023 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544657;
        bh=Q1E2/2VQovVltMEOu43cAYLNQ9T/TLXeZWQogOPKK+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1J6F5CeoEsRHS1+xMSMqkbp1NnnW5u0/dcOdRrJ9jSFQhRBgBUL6lPBjt//9bDdF
         cRJpCPgweaO+Tg6CQsxK7109J9LrQKVTo8bhsaVylpE/WPvNGRUVR4F8EAv3ovkFVy
         FQ2TbN0kAaomVeSXud5as5O9+hBc/lt4ms67mNQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 452/694] wifi: mt76: mt7996: fill txd by host driver
Date:   Mon,  8 May 2023 11:44:47 +0200
Message-Id: <20230508094448.248255717@linuxfoundation.org>
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

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 3b522cadedfe6e9e0e8193d7d4ab5aa8d0c73209 ]

The hardware SDO has issue to fill txd for the moment, so fallback to
driver filling method.

Fixes: 98686cd21624 (wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices)
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 6a635b03a602b..1a715d01b0a3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1120,11 +1120,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
-	memset(txwi_ptr, 0, MT_TXD_SIZE);
-	/* Transmit non qos data by 802.11 header and need to fill txd by host*/
-	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
-		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
-				      pid, qid, 0);
+	mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
+			      pid, qid, 0);
 
 	txp = (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
@@ -1133,10 +1130,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	}
 	txp->fw.nbuf = nbuf;
 
-	txp->fw.flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
-
-	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
-		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
+	txp->fw.flags =
+		cpu_to_le16(MT_CT_INFO_FROM_HOST | MT_CT_INFO_APPLY_TXD);
 
 	if (!key)
 		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
-- 
2.39.2



