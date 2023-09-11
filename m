Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43279AE4B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbjIKUzF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbjIKOgK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:36:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70683F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:36:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F5FC433C8;
        Mon, 11 Sep 2023 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442966;
        bh=g6J4utbLk7qFmNiHXaJHwwUZ8L+gtW7MuavgOOqZVHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjOrg6pi17k6tAVXYE0WhNertuuiJZ/YXdbXtlGB4GfkLyVaCBMKFjl79XkU3WS+W
         x7wUk3FARJNhZh9bR0N2D/eGqvR6WonwlaYkLXy9W+X4nPF9uzLUdmMYzKo9krltOZ
         FkQiNOdw0favMDqHf0Y2A3AZjMAEdH3yudD3IpyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 183/737] wifi: ath11k: fix band selection for ppdu received in channel 177 of 5 GHz
Date:   Mon, 11 Sep 2023 15:40:42 +0200
Message-ID: <20230911134655.677399841@linuxfoundation.org>
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

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

[ Upstream commit 72c8caf904aed2caed5d6e75233294b6159ddb5d ]

5 GHz band channel 177 support was added with the commit e5e94d10c856 ("wifi:
ath11k: add channel 177 into 5 GHz channel list"). However, during processing
for the received ppdu in ath11k_dp_rx_h_ppdu(), channel number is checked only
till 173. This leads to driver code checking for channel and then fetching the
band from it which is extra effort since firmware has already given the channel
number in the metadata.

Fix this issue by checking the channel number till 177 since we support
it now.

Found via code review. Compile tested only.

Fixes: e5e94d10c856 ("wifi: ath11k: add channel 177 into 5 GHz channel list")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230726044624.20507-1-quic_adisi@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index f67ce62b2b48d..c5ff1bc02999e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2408,7 +2408,7 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 		rx_status->freq = center_freq;
 	} else if (channel_num >= 1 && channel_num <= 14) {
 		rx_status->band = NL80211_BAND_2GHZ;
-	} else if (channel_num >= 36 && channel_num <= 173) {
+	} else if (channel_num >= 36 && channel_num <= 177) {
 		rx_status->band = NL80211_BAND_5GHZ;
 	} else {
 		spin_lock_bh(&ar->data_lock);
-- 
2.40.1



