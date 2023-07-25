Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426AC7613F8
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGYLPV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjGYLPH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94331FF7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48DAB61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5871FC433C7;
        Tue, 25 Jul 2023 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283662;
        bh=C69WBDQNg9YK13XsXzC/OrB96nKTB/0fUrIqb1OFFoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf6KdXQPtx6OneTzbPGrxHV8VcIns6jRYMu2bL79iWt1RHy+9Zf3bYEPLmhbulKOs
         7kaxAbBbo7+KtCnLQD2PBDjn0FDpBUD3GzHsJtIzYLjdHLVZpDBpZIJZHSP7JGtdGG
         YBaLQk3Z29ge6mFQVfGE7tnkBzdCeoxHqi61SDB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmitry Antipov <dmantipov@yandex.ru>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 077/509] wifi: ath9k: convert msecs to jiffies where needed
Date:   Tue, 25 Jul 2023 12:40:16 +0200
Message-ID: <20230725104557.219093108@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index 2bd4d295c9bdf..b2cfc483515c0 100644
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
@@ -2244,7 +2244,7 @@ void __ath9k_flush(struct ieee80211_hw *hw, u32 queues, bool drop,
 	}
 
 	ieee80211_queue_delayed_work(hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 }
 
 static bool ath9k_tx_frames_pending(struct ieee80211_hw *hw)
-- 
2.39.2



