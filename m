Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6016FAB9B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjEHLPU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjEHLPT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67A236568
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A60C62BB7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E9FC433D2;
        Mon,  8 May 2023 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544516;
        bh=nKwz5+aWAFZC2ksA+lHFMjIh9RYoI71TG9qvUfMWdrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvpeAXGfh3x4nPSlVAE8FlkKGrXmRyCVbCgAV9UC2LUccp3uRb9BXxOBdmji35yhp
         kGb9mDgfIlwZ8ajHVb3X773ltahpCGUWqORUrdhxJVsd+g2ZSh2TX0cJ4rrfKbZkdf
         0O87PQo+Pj6Pve4qMOewe0Y0kOtM2et5ZYy6HDDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 435/694] wifi: mt76: mt7996: fix radiotap bitfield
Date:   Mon,  8 May 2023 11:44:30 +0200
Message-Id: <20230508094447.523781930@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 63a3724632464559d1e98d90d2c63d43ec6ef6f5 ]

The 11be generation's radiotap bitfields were wrongly copy-and-pasted
from 11ax driver, so fix them accordingly.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 54 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7996/mac.h   | 41 +++++++-------
 2 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c9a9f0e317716..3c3506c7c87af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -260,12 +260,9 @@ mt7996_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
 				 struct ieee80211_radiotap_he *he,
 				 __le32 *rxv)
 {
-	u32 ru_h, ru_l;
-	u8 ru, offs = 0;
+	u32 ru, offs = 0;
 
-	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
-	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
-	ru = (u8)(ru_l | ru_h << 4);
+	ru = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC);
 
 	status->bw = RATE_INFO_BW_HE_RU;
 
@@ -330,18 +327,23 @@ mt7996_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
 
 	he_mu->flags2 |= MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status->bw) |
 			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
-				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
+				 le32_get_bits(rxv[4], MT_CRXV_HE_NUM_USER));
 
-	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
+	he_mu->ru_ch1[0] = le32_get_bits(rxv[16], MT_CRXV_HE_RU0) & 0xff;
 
 	if (status->bw >= RATE_INFO_BW_40) {
 		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
-		he_mu->ru_ch2[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
+		he_mu->ru_ch2[0] = le32_get_bits(rxv[16], MT_CRXV_HE_RU1) & 0xff;
 	}
 
 	if (status->bw >= RATE_INFO_BW_80) {
-		he_mu->ru_ch1[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
-		he_mu->ru_ch2[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
+		u32 ru_h, ru_l;
+
+		he_mu->ru_ch1[1] = le32_get_bits(rxv[16], MT_CRXV_HE_RU2) & 0xff;
+
+		ru_l = le32_get_bits(rxv[16], MT_CRXV_HE_RU3_L);
+		ru_h = le32_get_bits(rxv[17], MT_CRXV_HE_RU3_H) & 0x7;
+		he_mu->ru_ch2[1] = (u8)(ru_l | ru_h << 4);
 	}
 }
 
@@ -364,23 +366,23 @@ mt7996_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
 			 HE_BITS(DATA2_TXOP_KNOWN),
 	};
 	struct ieee80211_radiotap_he *he = NULL;
-	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
+	u32 ltf_size = le32_get_bits(rxv[4], MT_CRXV_HE_LTF_SIZE) + 1;
 
 	status->flag |= RX_FLAG_RADIOTAP_HE;
 
 	he = skb_push(skb, sizeof(known));
 	memcpy(he, &known, sizeof(known));
 
-	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
-		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
-	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
-	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
+	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[9]) |
+		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[4]);
+	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[13]);
+	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[5]) |
 		    le16_encode_bits(ltf_size,
 				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
 	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
 		he->data5 |= HE_BITS(DATA5_TXBF);
-	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
-		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
+	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[9]) |
+		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[9]);
 
 	switch (mode) {
 	case MT_PHY_TYPE_HE_SU:
@@ -389,22 +391,22 @@ mt7996_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
 			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
 			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
 
-		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
-			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[8]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
 		break;
 	case MT_PHY_TYPE_HE_EXT_SU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
 			     HE_BITS(DATA1_UL_DL_KNOWN) |
 			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
 
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
 		break;
 	case MT_PHY_TYPE_HE_MU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
 			     HE_BITS(DATA1_UL_DL_KNOWN);
 
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
+		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[8]);
 
 		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
 		mt7996_mac_decode_he_mu_radiotap(skb, rxv);
@@ -415,10 +417,10 @@ mt7996_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
 			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
 			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
 
-		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[13]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[13]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[13]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[13]);
 
 		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index 27184cbac619b..2cc218f735d88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -102,8 +102,7 @@ enum rx_pkt_type {
 #define MT_PRXV_NSTS			GENMASK(10, 7)
 #define MT_PRXV_TXBF			BIT(11)
 #define MT_PRXV_HT_AD_CODE		BIT(12)
-#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
-#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
+#define MT_PRXV_HE_RU_ALLOC		GENMASK(30, 22)
 #define MT_PRXV_RCPI3			GENMASK(31, 24)
 #define MT_PRXV_RCPI2			GENMASK(23, 16)
 #define MT_PRXV_RCPI1			GENMASK(15, 8)
@@ -113,34 +112,32 @@ enum rx_pkt_type {
 #define MT_PRXV_TX_MODE			GENMASK(14, 11)
 #define MT_PRXV_FRAME_MODE		GENMASK(2, 0)
 #define MT_PRXV_DCM			BIT(5)
-#define MT_PRXV_NUM_RX			BIT(8, 6)
 
 /* C-RXV */
-#define MT_CRXV_HT_STBC			GENMASK(1, 0)
-#define MT_CRXV_TX_MODE			GENMASK(7, 4)
-#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
-#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
-#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
-#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
-#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
-#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
-#define MT_CRXV_HE_UPLINK		BIT(31)
-#define MT_CRXV_HE_RU0			GENMASK(7, 0)
-#define MT_CRXV_HE_RU1			GENMASK(15, 8)
-#define MT_CRXV_HE_RU2			GENMASK(23, 16)
-#define MT_CRXV_HE_RU3			GENMASK(31, 24)
-
-#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
+#define MT_CRXV_HE_NUM_USER		GENMASK(26, 20)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(28, 27)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(30)
+
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(1)
+#define MT_CRXV_HE_UPLINK		BIT(2)
+
+#define MT_CRXV_HE_MU_AID		GENMASK(27, 17)
+#define MT_CRXV_HE_BEAM_CHNG		BIT(29)
+
+#define MT_CRXV_HE_DOPPLER		BIT(0)
+#define MT_CRXV_HE_BSS_COLOR		GENMASK(15, 10)
+#define MT_CRXV_HE_TXOP_DUR		GENMASK(19, 17)
 
 #define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
 #define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
 #define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
 #define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
 
-#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
-#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
-#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
-#define MT_CRXV_HE_DOPPLER		BIT(16)
+#define MT_CRXV_HE_RU0			GENMASK(8, 0)
+#define MT_CRXV_HE_RU1			GENMASK(17, 9)
+#define MT_CRXV_HE_RU2			GENMASK(26, 18)
+#define MT_CRXV_HE_RU3_L		GENMASK(31, 27)
+#define MT_CRXV_HE_RU3_H		GENMASK(3, 0)
 
 enum tx_header_format {
 	MT_HDR_FORMAT_802_3,
-- 
2.39.2



