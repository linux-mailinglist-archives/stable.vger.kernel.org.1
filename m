Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8822791CE1
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244313AbjIDSch (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbjIDSch (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:32:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B183CD7
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B59B1B80EF6
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1799AC433C9;
        Mon,  4 Sep 2023 18:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852351;
        bh=ecZbuySjneIeKT5xo/xr0xRYFgYc75eFEmjBP4SfmvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyv6ftlAxr5hOVUFagXtcvWroG+mot2t+m6W4JFYlj3nGdGX5rgeVDyJ6BuM0mSVd
         A9yG3lxPnWMjxO4/465PA41qeALUXCDR9R9lQpE7hzQ7heSA+Vq6/7ztd319tCy/Vo
         XlmMfouPD+eOGvNz77eOhtYu5tzZkgv+mEMxG4LQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shayne Chen <shayne.chen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Simon Horman <simon.horman@corigine.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.5 20/34] wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU
Date:   Mon,  4 Sep 2023 19:30:07 +0100
Message-ID: <20230904182949.541342088@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deren Wu <deren.wu@mediatek.com>

commit b642f4c5f3de0a8f47808d32b1ebd9c427a42a66 upstream.

txs may be dropped if the frame is aggregated in AMSDU. When the problem
shows up, some SKBs would be hold in driver to cause network stopped
temporarily. Even if the problem can be recovered by txs timeout handling,
mt7921 still need to disable txs in AMSDU to avoid this issue.

Cc: stable@vger.kernel.org
Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -495,6 +495,7 @@ void mt76_connac2_mac_write_txwi(struct
 				    BSS_CHANGED_BEACON_ENABLED));
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
 					 BSS_CHANGED_FILS_DISCOVERY));
+	bool amsdu_en = wcid->amsdu;
 
 	if (vif) {
 		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
@@ -554,12 +555,14 @@ void mt76_connac2_mac_write_txwi(struct
 	txwi[4] = 0;
 
 	val = FIELD_PREP(MT_TXD5_PID, pid);
-	if (pid >= MT_PACKET_ID_FIRST)
+	if (pid >= MT_PACKET_ID_FIRST) {
 		val |= MT_TXD5_TX_STATUS_HOST;
+		amsdu_en = amsdu_en && !is_mt7921(dev);
+	}
 
 	txwi[5] = cpu_to_le32(val);
 	txwi[6] = 0;
-	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
+	txwi[7] = amsdu_en ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
 
 	if (is_8023)
 		mt76_connac2_mac_write_txwi_8023(txwi, skb, wcid);


