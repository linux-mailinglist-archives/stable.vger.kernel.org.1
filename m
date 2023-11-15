Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F3A7ECCFC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjKOTdm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjKOTdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6257130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DC8C433C9;
        Wed, 15 Nov 2023 19:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076818;
        bh=BOvi9b8izPDDwNitOFSBEKqEzqfmdrQ2PKk8qS4pcEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wiufaBnU9y92xPrE0OL0U4mpum6WClqBrehXWiJFHk1P3N3zacX/iLRUuNVHjWhyH
         BOdVRTne8besR89BKhdC+w/6M9MR9SOpZm++iAmQCfkq9r+WaUcCOGip1QsW89atCr
         dZUrZ6S3aWY0su0ysF4Irn/ktrbaGzNRtYxI/wmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 036/603] wifi: ath12k: fix undefined behavior with __fls in dp
Date:   Wed, 15 Nov 2023 14:09:41 -0500
Message-ID: <20231115191615.684425181@linuxfoundation.org>
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

From: Harshitha Prem <quic_hprem@quicinc.com>

[ Upstream commit d48f55e773dcce8fcf9e587073452a4944011b11 ]

When max virtual ap interfaces are configured in all the bands
with ACS and hostapd restart is done every 60s,
a crash is observed at random times because of handling the
uninitialized peer fragments with fragment id of packet as 0.

"__fls" would have an undefined behavior if the argument is passed
as "0". Hence, added changes to handle the same.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230821130343.29495-3-quic_hprem@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index e6e64d437c47a..17da39bd3ab4d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3229,7 +3229,7 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 		goto out_unlock;
 	}
 
-	if (frag_no > __fls(rx_tid->rx_frag_bitmap))
+	if ((!rx_tid->rx_frag_bitmap || frag_no > __fls(rx_tid->rx_frag_bitmap)))
 		__skb_queue_tail(&rx_tid->rx_frags, msdu);
 	else
 		ath12k_dp_rx_h_sort_frags(ab, &rx_tid->rx_frags, msdu);
-- 
2.42.0



