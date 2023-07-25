Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E21761624
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjGYLgy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjGYLgn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB41FF3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B03B8616B4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD03C433C7;
        Tue, 25 Jul 2023 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284994;
        bh=T/J1WAEOqzayksZ9saLnJHZw+g65Ve8XALJc3hruitg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3KcRa4QPkbEuRwgoq0IxiJHaCCtWb8W/6vI7TMl3AIquIm34oXU3u6Q/7tDxwOnA
         cIpKzSwZcOl1qGdoLAqyQ4qOOV4WCoWQ76+/+84ED1TSoE8mDAFgWM8F+9dbOzx4+4
         VLg/ILlVyGWv75Ly7YbdVZT7zRMFCJyBVdbSoNlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Gregg Wonderly <greggwonderly@seqtechllc.com>,
        Peter Seiderer <ps.report@gmx.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 028/313] wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation
Date:   Tue, 25 Jul 2023 12:43:01 +0200
Message-ID: <20230725104522.340510491@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit 3e56c80931c7615250fe4bf83f93b57881969266 ]

Fix ath9k_hw_verify_hang()/ar9003_hw_detect_mac_hang() register offset
calculation (do not overflow the shift for the second register/queues
above five, use the register layout described in the comments above
ath9k_hw_verify_hang() instead).

Fixes: 222e04830ff0 ("ath9k: Fix MAC HW hang check for AR9003")

Reported-by: Gregg Wonderly <greggwonderly@seqtechllc.com>
Link: https://lore.kernel.org/linux-wireless/E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com/
Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230422212423.26065-1-ps.report@gmx.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/ar9003_hw.c | 27 ++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
index 2fe12b0de5b4f..dea8a998fb622 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
@@ -1099,17 +1099,22 @@ static bool ath9k_hw_verify_hang(struct ath_hw *ah, unsigned int queue)
 {
 	u32 dma_dbg_chain, dma_dbg_complete;
 	u8 dcu_chain_state, dcu_complete_state;
+	unsigned int dbg_reg, reg_offset;
 	int i;
 
-	for (i = 0; i < NUM_STATUS_READS; i++) {
-		if (queue < 6)
-			dma_dbg_chain = REG_READ(ah, AR_DMADBG_4);
-		else
-			dma_dbg_chain = REG_READ(ah, AR_DMADBG_5);
+	if (queue < 6) {
+		dbg_reg = AR_DMADBG_4;
+		reg_offset = queue * 5;
+	} else {
+		dbg_reg = AR_DMADBG_5;
+		reg_offset = (queue - 6) * 5;
+	}
 
+	for (i = 0; i < NUM_STATUS_READS; i++) {
+		dma_dbg_chain = REG_READ(ah, dbg_reg);
 		dma_dbg_complete = REG_READ(ah, AR_DMADBG_6);
 
-		dcu_chain_state = (dma_dbg_chain >> (5 * queue)) & 0x1f;
+		dcu_chain_state = (dma_dbg_chain >> reg_offset) & 0x1f;
 		dcu_complete_state = dma_dbg_complete & 0x3;
 
 		if ((dcu_chain_state != 0x6) || (dcu_complete_state != 0x1))
@@ -1128,6 +1133,7 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
 	u8 dcu_chain_state, dcu_complete_state;
 	bool dcu_wait_frdone = false;
 	unsigned long chk_dcu = 0;
+	unsigned int reg_offset;
 	unsigned int i = 0;
 
 	dma_dbg_4 = REG_READ(ah, AR_DMADBG_4);
@@ -1139,12 +1145,15 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
 		goto exit;
 
 	for (i = 0; i < ATH9K_NUM_TX_QUEUES; i++) {
-		if (i < 6)
+		if (i < 6) {
 			chk_dbg = dma_dbg_4;
-		else
+			reg_offset = i * 5;
+		} else {
 			chk_dbg = dma_dbg_5;
+			reg_offset = (i - 6) * 5;
+		}
 
-		dcu_chain_state = (chk_dbg >> (5 * i)) & 0x1f;
+		dcu_chain_state = (chk_dbg >> reg_offset) & 0x1f;
 		if (dcu_chain_state == 0x6) {
 			dcu_wait_frdone = true;
 			chk_dcu |= BIT(i);
-- 
2.39.2



