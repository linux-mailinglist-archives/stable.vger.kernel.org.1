Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3D37ECB83
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjKOTWp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjKOTWo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A95130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230FBC433CA;
        Wed, 15 Nov 2023 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076161;
        bh=SCVALJvMSIs1siJ6JMN+J0+Er6I6Q6wrXulcKL+Iy6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMWaqv4iTISd2xsrKTiXzISbf3mjgTjVGaF9UExG7LnY75qHN5cOmoX6Pn+Nwsrkl
         YaMl64IBVVT5skGB7RZ46M2wesLMNwL85BGFmkuuSiP+0Lwb5M8ubrpbOIw/wEUxk1
         hwYFnJBWwD7SFfK3c1d8IXuUi/bEp7eIp/1dduow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Howard Hsu <howard-yh.hsu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 087/550] wifi: mt76: mt7996: fix beamform mcu cmd configuration
Date:   Wed, 15 Nov 2023 14:11:11 -0500
Message-ID: <20231115191606.737871317@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Howard Hsu <howard-yh.hsu@mediatek.com>

[ Upstream commit d40fd59b7267d2e7722d3edf3935a9a9f03c0115 ]

The bf_num field represents how many bands can support beamform, so set
the value to 3, and bf_bitmap represents the bitmap of bf_num.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 62a02b03d83ba..8244bb3561028 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3208,8 +3208,8 @@ int mt7996_mcu_set_txbf(struct mt7996_dev *dev, u8 action)
 
 		tlv = mt7996_mcu_add_uni_tlv(skb, action, sizeof(*req_mod_en));
 		req_mod_en = (struct bf_mod_en_ctrl *)tlv;
-		req_mod_en->bf_num = 2;
-		req_mod_en->bf_bitmap = GENMASK(0, 0);
+		req_mod_en->bf_num = 3;
+		req_mod_en->bf_bitmap = GENMASK(2, 0);
 		break;
 	}
 	default:
-- 
2.42.0



