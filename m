Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C69719E14
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjFAN3A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjFAN2b (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99F910D7
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:28:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99A2A64473
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C9FC433EF;
        Thu,  1 Jun 2023 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626091;
        bh=b6MfFNY3Iz/RWUvsvgWRjbIqcdP3Ru+hFWkpfYvaEfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knJzib3I0uB0WdsMNjRqVva+ownwOec1zlsgS4TbvIVqACy+YoRGy2ZIHUyk8Wj1k
         XH4d0dEaxUmGgWa5sJbcuSWGAQ7osuRUzwNEWUXVkoXztMwYcU+pR63o2itj7l2X8e
         dRnaDZl2v0suyQ6Enz2wP+OKJ/l+gTIvPP8P1vpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Huang <echuang@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 27/42] wifi: rtw89: correct 5 MHz mask setting
Date:   Thu,  1 Jun 2023 14:21:36 +0100
Message-Id: <20230601131940.228186343@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Huang <echuang@realtek.com>

[ Upstream commit d33fc8d0368c180fe2338bfae4f5367a66a719f4 ]

Use primary channel index to determine which 5 MHz mask should be enable.
This mask is used to prevent noise from channel edge to effect CCA
threshold in wide bandwidth (>= 40 MHZ).

Fixes: 1b00e9236a71 ("rtw89: 8852c: add set channel of BB part")
Fixes: 6b0698984eb0 ("wifi: rtw89: 8852b: add chip_ops::set_channel")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230406072841.8308-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 67653b3e1a356..3109114cec6ff 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1484,18 +1484,19 @@ static void rtw8852c_5m_mask(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx)
 {
-	u8 pri_ch = chan->primary_channel;
+	u8 pri_ch = chan->pri_ch_idx;
 	bool mask_5m_low;
 	bool mask_5m_en;
 
 	switch (chan->band_width) {
 	case RTW89_CHANNEL_WIDTH_40:
 		mask_5m_en = true;
-		mask_5m_low = pri_ch == 2;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWER;
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
-		mask_5m_en = ((pri_ch == 3) || (pri_ch == 4));
-		mask_5m_low = pri_ch == 4;
+		mask_5m_en = pri_ch == RTW89_SC_20_UPMOST ||
+			     pri_ch == RTW89_SC_20_LOWEST;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWEST;
 		break;
 	default:
 		mask_5m_en = false;
-- 
2.39.2



