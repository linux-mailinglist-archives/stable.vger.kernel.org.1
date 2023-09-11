Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8409479BD3A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378644AbjIKWgO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbjIKOeZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:34:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE99E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:34:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55D1C433C8;
        Mon, 11 Sep 2023 14:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442860;
        bh=2Bb/GxSXDVplnPhgILAxUaI/krpr6yilIYLH+Erxzh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdW6SCI4Q56IsTAq2KsWl11P8+0hNm+qNYdbw4wamKsdXMBaIhBw7x7w9SiH1fWUr
         xk3VHifb16TtPY94hcZF/+A4gle2tYIc0m1MoRdrNNfd+0COtvYwc1T3yBUZWsxVa7
         nPS5vKtjUgKrrfg7tPa9pTQEx0A5aVzDo7K2bgfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 173/737] wifi: mt76: mt7915: remove VHT160 capability on MT7915
Date:   Mon, 11 Sep 2023 15:40:32 +0200
Message-ID: <20230911134655.362254526@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 3ec5ac12ac8a4e6b1e085374325a5fbd1b650fd5 ]

The IEEE80211_VHT_CAP_EXT_NSS_BW value already indicates support for half-NSS
160 MHz support, so it is wrong to also advertise full 160 MHz support.

Fixes: c2f73eacee3b ("wifi: mt76: mt7915: add back 160MHz channel width support for MT7915")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 927a98a315ae8..9defd2b3c2f8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -414,7 +414,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 			if (!dev->dbdc_support)
 				vht_cap->cap |=
 					IEEE80211_VHT_CAP_SHORT_GI_160 |
-					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
 					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
 		} else {
 			vht_cap->cap |=
-- 
2.40.1



