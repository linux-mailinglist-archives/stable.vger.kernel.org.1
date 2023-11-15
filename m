Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB07ECDB4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjKOThz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjKOThy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF812C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC68C433C9;
        Wed, 15 Nov 2023 19:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077070;
        bh=6tmdtS2kvnclbPPU0gFc1PlnWlQ64oOsKudEKAoskBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnYq0gruG0T5bGmUNs0rvO0pAUjaH3o4yFp7QiqO7+/YutzmbAjZfVkcKkA2Oc/qt
         T7QpDlvzo2IdwvYo5Ze6qwOmBTtvdDOoiE1p11uxih2cLO+sJPx/f0YYDQ5uVk13SO
         chws/Gz+j4pjEtmwTb7HM5JnjlM1uzsvzO7f+ixk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Olivier Souloumiac <olivier.souloumiac@silabs.com>,
        Alexandr Suslenko <suslenko.o@ajax.systems>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 115/603] wifi: wfx: fix case where rates are out of order
Date:   Wed, 15 Nov 2023 14:11:00 -0500
Message-ID: <20231115191621.202778231@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>

[ Upstream commit ea2274ab0b18549dbf0e755e41d8c5e8b5232dc3 ]

When frames are sent over the air, the device always applies the data
rates in descending order. The driver assumed Minstrel also provided
rate in descending order.

However, in some cases, Minstrel can a choose a fallback rate greater
than the primary rate. In this case, the two rates was inverted, the
device try highest rate first and we get many retries.

Since the device always applies rates in descending order, the
workaround is to drop the rate when it higher than its predecessor in
the rate list. Thus [ 4, 5, 3 ] becomes [ 4, 3 ].

This patch has been tested in isolated room with a series of
attenuators. Here are the Minstrel statistics with 80dBm of attenuation:

  Without the fix:

                  best    ____________rate__________    ____statistics___    _____last____    ______sum-of________
    mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)]  [retry|suc|att]  [#success | #attempts]
    HT20  LGI  1       S  MCS0     0    1477     5.6       5.2      82.7       3     0 0             3   4
    HT20  LGI  1          MCS1     1     738    10.6       0.0       0.0       0     0 0             0   1
    HT20  LGI  1     D    MCS2     2     492    14.9      13.5      81.5       5     0 0             5   9
    HT20  LGI  1    C     MCS3     3     369    18.8      17.6      84.3       5     0 0            76   96
    HT20  LGI  1  A   P   MCS4     4     246    25.4      22.4      79.5       5     0 0         11268   14026
    HT20  LGI  1   B   S  MCS5     5     185    30.7      19.7      57.7       5     8 9          3918   9793
    HT20  LGI  1          MCS6     6     164    33.0       0.0       0.0       5     0 0             6   102
    HT20  LGI  1          MCS7     7     148    35.1       0.0       0.0       0     0 0             0   44

  With the fix:

                  best    ____________rate__________    ____statistics___    _____last____    ______sum-of________
    mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)]  [retry|suc|att]  [#success | #attempts]
    HT20  LGI  1       S  MCS0     0    1477     5.6       1.8      28.6       1     0 0             1   5
    HT20  LGI  1     DP   MCS1     1     738    10.6       9.7      82.6       4     0 0            14   34
    HT20  LGI  1          MCS2     2     492    14.9       9.2      55.4       5     0 0            52   77
    HT20  LGI  1   B   S  MCS3     3     369    18.8      15.6      74.9       5     1 1           417   554
    HT20  LGI  1  A       MCS4     4     246    25.4      16.7      59.2       5     1 1         13812   17951
    HT20  LGI  1    C  S  MCS5     5     185    30.7      14.0      41.0       5     1 5            57   640
    HT20  LGI  1          MCS6     6     164    33.0       0.0       0.0       0     0 1             0   48
    HT20  LGI  1       S  MCS7     7     148    35.1       0.0       0.0       0     0 0             0   36

We can notice the device try now to send with lower rates (and high
success rates). At the end, we measured 20-25% better throughput with
this patch.

Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
Tested-by: Olivier Souloumiac <olivier.souloumiac@silabs.com>
Tested-by: Alexandr Suslenko <suslenko.o@ajax.systems>
Reported-by: Alexandr Suslenko <suslenko.o@ajax.systems>
Co-developed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231004123039.157112-1-jerome.pouiller@silabs.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/silabs/wfx/data_tx.c | 71 +++++++++--------------
 1 file changed, 29 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/data_tx.c b/drivers/net/wireless/silabs/wfx/data_tx.c
index 6a5e52a96d183..caa22226b01bc 100644
--- a/drivers/net/wireless/silabs/wfx/data_tx.c
+++ b/drivers/net/wireless/silabs/wfx/data_tx.c
@@ -226,53 +226,40 @@ static u8 wfx_tx_get_link_id(struct wfx_vif *wvif, struct ieee80211_sta *sta,
 
 static void wfx_tx_fixup_rates(struct ieee80211_tx_rate *rates)
 {
-	int i;
-	bool finished;
+	bool has_rate0 = false;
+	int i, j;
 
-	/* Firmware is not able to mix rates with different flags */
-	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
-		if (rates[0].flags & IEEE80211_TX_RC_SHORT_GI)
-			rates[i].flags |= IEEE80211_TX_RC_SHORT_GI;
-		if (!(rates[0].flags & IEEE80211_TX_RC_SHORT_GI))
+	for (i = 1, j = 1; j < IEEE80211_TX_MAX_RATES; j++) {
+		if (rates[j].idx == -1)
+			break;
+		/* The device use the rates in descending order, whatever the request from minstrel.
+		 * We have to trade off here. Most important is to respect the primary rate
+		 * requested by minstrel. So, we drops the entries with rate higher than the
+		 * previous.
+		 */
+		if (rates[j].idx >= rates[i - 1].idx) {
+			rates[i - 1].count += rates[j].count;
+			rates[i - 1].count = min_t(u16, 15, rates[i - 1].count);
+		} else {
+			memcpy(rates + i, rates + j, sizeof(rates[i]));
+			if (rates[i].idx == 0)
+				has_rate0 = true;
+			/* The device apply Short GI only on the first rate */
 			rates[i].flags &= ~IEEE80211_TX_RC_SHORT_GI;
-		if (!(rates[0].flags & IEEE80211_TX_RC_USE_RTS_CTS))
-			rates[i].flags &= ~IEEE80211_TX_RC_USE_RTS_CTS;
-	}
-
-	/* Sort rates and remove duplicates */
-	do {
-		finished = true;
-		for (i = 0; i < IEEE80211_TX_MAX_RATES - 1; i++) {
-			if (rates[i + 1].idx == rates[i].idx &&
-			    rates[i].idx != -1) {
-				rates[i].count += rates[i + 1].count;
-				if (rates[i].count > 15)
-					rates[i].count = 15;
-				rates[i + 1].idx = -1;
-				rates[i + 1].count = 0;
-
-				finished = false;
-			}
-			if (rates[i + 1].idx > rates[i].idx) {
-				swap(rates[i + 1], rates[i]);
-				finished = false;
-			}
+			i++;
 		}
-	} while (!finished);
+	}
 	/* Ensure that MCS0 or 1Mbps is present at the end of the retry list */
-	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
-		if (rates[i].idx == 0)
-			break;
-		if (rates[i].idx == -1) {
-			rates[i].idx = 0;
-			rates[i].count = 8; /* == hw->max_rate_tries */
-			rates[i].flags = rates[i - 1].flags & IEEE80211_TX_RC_MCS;
-			break;
-		}
+	if (!has_rate0 && i < IEEE80211_TX_MAX_RATES) {
+		rates[i].idx = 0;
+		rates[i].count = 8; /* == hw->max_rate_tries */
+		rates[i].flags = rates[0].flags & IEEE80211_TX_RC_MCS;
+		i++;
+	}
+	for (; i < IEEE80211_TX_MAX_RATES; i++) {
+		memset(rates + i, 0, sizeof(rates[i]));
+		rates[i].idx = -1;
 	}
-	/* All retries use long GI */
-	for (i = 1; i < IEEE80211_TX_MAX_RATES; i++)
-		rates[i].flags &= ~IEEE80211_TX_RC_SHORT_GI;
 }
 
 static u8 wfx_tx_get_retry_policy_id(struct wfx_vif *wvif, struct ieee80211_tx_info *tx_info)
-- 
2.42.0



