Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1715B6FA53F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjEHKHX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjEHKHX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E33046B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24D7C62368
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389F8C433EF;
        Mon,  8 May 2023 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540440;
        bh=MKXe51T1OrZoDG+R8mq4/k7TA8IJaDTV9+N4G2wt45Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lsHygC7WyKaGTjXc60fiTf+c8k86jjXgHkRmgEkrGPPQjk/8JLcOFYC6lQVgE0qV1
         t66fANW04B/eqaxf8GW4QMtN4rn0dxvJC/bVo1SHrjwZ9hfGQiyB6UDlly4L21fyYE
         qEHswf2pI13mCsFDYhBy/MpSyuY/sVcBbAH/IIcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Greear <greearb@candelatech.com>,
        Isaac Konikoff <konikofi@candelatech.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 365/611] wifi: mt76: fix 6GHz high channel not be scanned
Date:   Mon,  8 May 2023 11:43:27 +0200
Message-Id: <20230508094434.244523172@linuxfoundation.org>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit 23792cedaff02351b57bddd8957fc917fa88f2e0 ]

mt76 scan command only support 64 channels currently. If the
channel count is larger than 64(for 2+5+6GHz), some channels will
not be scanned. Hence change the scan type to full channel scan
in case of the command cannot include proper list for chip.

Fixes: 399090ef9605 ("mt76: mt76_connac: move hw_scan and sched_scan routine in mt76_connac_mcu module")
Reported-by: Ben Greear <greearb@candelatech.com>
Tested-by: Isaac Konikoff <konikofi@candelatech.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c    | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 025a237c1cce8..546cbe21aab31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1561,8 +1561,16 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	req->channel_min_dwell_time = cpu_to_le16(duration);
 	req->channel_dwell_time = cpu_to_le16(duration);
 
-	req->channels_num = min_t(u8, sreq->n_channels, 32);
-	req->ext_channels_num = min_t(u8, ext_channels_num, 32);
+	if (sreq->n_channels == 0 || sreq->n_channels > 64) {
+		req->channel_type = 0;
+		req->channels_num = 0;
+		req->ext_channels_num = 0;
+	} else {
+		req->channel_type = 4;
+		req->channels_num = min_t(u8, sreq->n_channels, 32);
+		req->ext_channels_num = min_t(u8, ext_channels_num, 32);
+	}
+
 	for (i = 0; i < req->channels_num + req->ext_channels_num; i++) {
 		if (i >= 32)
 			chan = &req->ext_channels[i - 32];
@@ -1582,7 +1590,6 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		}
 		chan->channel_num = scan_list[i]->hw_value;
 	}
-	req->channel_type = sreq->n_channels ? 4 : 0;
 
 	if (sreq->ie_len > 0) {
 		memcpy(req->ies, sreq->ie, sreq->ie_len);
-- 
2.39.2



