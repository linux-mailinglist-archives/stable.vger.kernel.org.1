Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC907551EE
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjGPUBt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjGPUBs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275FF1B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AABCE60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8994C433C7;
        Sun, 16 Jul 2023 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537706;
        bh=i0VCj0JBDD7guuucNIYX3frg34Yi1S8G1cgOp3IwSj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZeBaCFHjeF/tWUHhI1OMpONZbhjAr2AdLJqnOfKolCNb+WLhQtYt7mz+33u36f9O
         dA3xbNCcwkZTxPO3BtOUqcBhDkjpdTEZubhQZ1gJI+38wUP1guAqMcPeKatWaNwrWm
         mO8amIDb5dFSfEFmfBR2rQRephjwKisoGYyQTzLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmitry Antipov <dmantipov@yandex.ru>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 192/800] wifi: ath9k: convert msecs to jiffies where needed
Date:   Sun, 16 Jul 2023 21:40:45 +0200
Message-ID: <20230716194953.563132426@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 2aa083acea9f61be3280184384551178f510ff51 ]

Since 'ieee80211_queue_delayed_work()' expects timeout in
jiffies and not milliseconds, 'msecs_to_jiffies()' should
be used in 'ath_restart_work()' and '__ath9k_flush()'.

Fixes: d63ffc45c5d3 ("ath9k: rename tx_complete_work to hw_check_work")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230613134655.248728-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 7f9f06ea8a05f..6360d3356e256 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -203,7 +203,7 @@ void ath_cancel_work(struct ath_softc *sc)
 void ath_restart_work(struct ath_softc *sc)
 {
 	ieee80211_queue_delayed_work(sc->hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 
 	if (AR_SREV_9340(sc->sc_ah) || AR_SREV_9330(sc->sc_ah))
 		ieee80211_queue_delayed_work(sc->hw, &sc->hw_pll_work,
@@ -2240,7 +2240,7 @@ void __ath9k_flush(struct ieee80211_hw *hw, u32 queues, bool drop,
 	}
 
 	ieee80211_queue_delayed_work(hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 }
 
 static bool ath9k_tx_frames_pending(struct ieee80211_hw *hw)
-- 
2.39.2



