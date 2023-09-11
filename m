Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98C79BC46
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbjIKVip (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbjIKOf1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:35:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31517F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:35:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDDBC433C7;
        Mon, 11 Sep 2023 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442922;
        bh=yeUeUIwAK325c2mcjAbW+zZ7zeVM2tLPBq+3emH6H7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VG4YagdSH2rAts1M1YHbJoC7A87wXmgF/K0hlmxzoxffHLVKB+4ZMRo0mNh+vcI99
         r8p+bfdybL9j8qwWvwX0K022Q1vWxalEVqUz69845XywdBIkEqpcdC+LzrcdHuD2Pi
         R36HX8JklPojctrtCwR/H9KkW4O5j4xzRp6K47hQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 178/737] wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
Date:   Mon, 11 Sep 2023 15:40:37 +0200
Message-ID: <20230911134655.520654635@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 4f1875c288dfc1ccea81fc17fef1d30c9d8498b2 ]

Correct per-device TLV lengths to avoid invalid operation in firmware.
(  64.040375:28:STATS-E)statsGetSingleHWCounter: MIB counter index = 65472 not supported.
This happens on mt7916/mt7986.

Fixes: b0bfa00595be ("wifi: mt76: mt7915: improve accuracy of time_busy calculation")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index a325066bf57e9..1a8611c6b684d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3000,7 +3000,7 @@ int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch)
 	}
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(GET_MIB_INFO),
-					req, sizeof(req), true, &skb);
+					req, len * sizeof(req[0]), true, &skb);
 	if (ret)
 		return ret;
 
-- 
2.40.1



