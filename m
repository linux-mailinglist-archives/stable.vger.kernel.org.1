Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337A7ED037
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjKOTxd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjKOTxc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:53:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E9319F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:53:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948FEC433CA;
        Wed, 15 Nov 2023 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078008;
        bh=U8HTSEXjXDCh7Jfv0X9lv3V+Rr4dWASk6FBI0790zLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOMWVbirV5XP4YmENAw+10/zhMKQEznRFX5Fb0yv/JWKItPaQ4lebv6FNaHl+IMvR
         ohUf1crp+zGi//nLi5FcUH4MzKYIvKmN5VHvcIXuVg9Apg+pdiW2uJo0D6fmOeJ5gN
         /u4epKQ1XriAylDnlPl+aQM0KpJovUl3huGr6wbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 053/379] wifi: ath11k: fix Tx power value during active CAC
Date:   Wed, 15 Nov 2023 14:22:08 -0500
Message-ID: <20231115192648.297682796@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

[ Upstream commit 77f1ee6fd8b6e470f721d05a2e269039d5cafcb7 ]

Tx power is fetched from firmware's pdev stats. However, during active
CAC, firmware does not fill the current Tx power and sends the max
initialised value filled during firmware init. If host sends this power
to user space, this is wrong since in certain situations, the Tx power
could be greater than the max allowed by the regulatory. Hence, host
should not be fetching the Tx power during an active CAC.

Fix this issue by returning -EAGAIN error so that user space knows that there's
no valid value available.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Fixes: 9a2aa68afe3d ("wifi: ath11k: add get_txpower mac ops")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230912051857.2284-4-quic_adisi@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cb77dd6ce9665..21c6b36dc6ebb 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8549,6 +8549,14 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	if (ar->state != ATH11K_STATE_ON)
 		goto err_fallback;
 
+	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
+	 * the stats.
+	 */
+	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
+		mutex_unlock(&ar->conf_mutex);
+		return -EAGAIN;
+	}
+
 	req_param.pdev_id = ar->pdev->pdev_id;
 	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
 
-- 
2.42.0



