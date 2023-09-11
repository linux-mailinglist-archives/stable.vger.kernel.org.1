Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED00279AD41
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357974AbjIKWHH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbjIKN5w (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:57:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F2CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:57:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC9EC433C8;
        Mon, 11 Sep 2023 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440667;
        bh=Ia9n5HC5jxwgTRbW0C+1fpl5tYFoJmKpkWzvMJm20wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esnzm7rmCWqEmK8dqzzwtiDs4A2eJKQgVtKKMTuTIw/eVUQI3EO7Hp7ftfAmadR2P
         1E3iHmEA3td5z5W6pOKaSW/Dn+5EVAqAsBllQoTMgM4fqE61/D4SIpe49zInC7n4fl
         xyYlFUhLQvkM7CIfxO9lPqj/iFIHPzt1zWWl+ZJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 105/739] wifi: ath11k: fix band selection for ppdu received in channel 177 of 5 GHz
Date:   Mon, 11 Sep 2023 15:38:24 +0200
Message-ID: <20230911134654.032019422@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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
index 5c76664ba0dd9..1e488eed282b5 100644
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



