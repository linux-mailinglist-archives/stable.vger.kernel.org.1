Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0147ECDCC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjKOTib (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjKOTia (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0EBCE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A7C433CB;
        Wed, 15 Nov 2023 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077107;
        bh=XElSZcJaA53ahEABR4h4wN+iL7mq9RWvP7AstdPo51Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5r/YI7LAZk+m5BHn7OedQ3LDoG+NnS6GP3kAD0/OBuMmZlKrJHuu7FhTcIYcA8/o
         82vLfzKRqGgOHfj/kFUtF4BklC5aZVFx3oO9F15Afz38YoarJYvzAPJ41J/NuUQvXS
         pGVD1OADBTsPeteNM22L12gBGOaTJ2l1FPebjFQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 110/603] wifi: ath11k: fix Tx power value during active CAC
Date:   Wed, 15 Nov 2023 14:10:55 -0500
Message-ID: <20231115191620.827291673@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index c071bf5841af6..b328a0599818b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9042,6 +9042,14 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
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



