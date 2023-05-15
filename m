Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5CC7035F2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbjEORFO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243458AbjEOREi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CCA93CD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E54462AA6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39D3C433D2;
        Mon, 15 May 2023 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170158;
        bh=tOnyekj1aKopciqdhp3jRbS4cPAj8yVwI5kDn725xpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iixPQlGmu33xasbfWmcB2ZCkzHxlX5IZRyC4wHkU3sYXo7fBj/r0FyVVvHGs1E/i8
         Ss34l0rY09FJNgbH5W87HmohaxA2RkPdEelC5s6XJ14MexWjEr6wQRSnpsInjSfnWS
         BYPqGGD2YbHFodrzEj2uyGxPddI2mvKm4rOBRcLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Subbaraya Sundeep <sbhatta@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 042/239] octeontx2-pf: mcs: Fix shared counters logic
Date:   Mon, 15 May 2023 18:25:05 +0200
Message-Id: <20230515161722.973649928@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit 9bdfe61054fb2b989eb58df20bf99c0cf67e3038 ]

Macsec stats like InPktsLate and InPktsDelayed share
same counter in hardware. If SecY replay_protect is true
then counter represents InPktsLate otherwise InPktsDelayed.
This mode change was tracked based on protect_frames
instead of replay_protect mistakenly. Similarly InPktsUnchecked
and InPktsOk share same counter and mode change was tracked
based on validate_check instead of validate_disabled.
This patch fixes those problems.

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  | 14 +++++++-------
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 13faca9add9f4..3ad8d7ef20be6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -1014,7 +1014,7 @@ static void cn10k_mcs_sync_stats(struct otx2_nic *pfvf, struct macsec_secy *secy
 
 	/* Check if sync is really needed */
 	if (secy->validate_frames == txsc->last_validate_frames &&
-	    secy->protect_frames == txsc->last_protect_frames)
+	    secy->replay_protect == txsc->last_replay_protect)
 		return;
 
 	cn10k_mcs_secy_stats(pfvf, txsc->hw_secy_id_rx, &rx_rsp, MCS_RX, true);
@@ -1036,19 +1036,19 @@ static void cn10k_mcs_sync_stats(struct otx2_nic *pfvf, struct macsec_secy *secy
 		rxsc->stats.InPktsInvalid += sc_rsp.pkt_invalid_cnt;
 		rxsc->stats.InPktsNotValid += sc_rsp.pkt_notvalid_cnt;
 
-		if (txsc->last_protect_frames)
+		if (txsc->last_replay_protect)
 			rxsc->stats.InPktsLate += sc_rsp.pkt_late_cnt;
 		else
 			rxsc->stats.InPktsDelayed += sc_rsp.pkt_late_cnt;
 
-		if (txsc->last_validate_frames == MACSEC_VALIDATE_CHECK)
+		if (txsc->last_validate_frames == MACSEC_VALIDATE_DISABLED)
 			rxsc->stats.InPktsUnchecked += sc_rsp.pkt_unchecked_cnt;
 		else
 			rxsc->stats.InPktsOK += sc_rsp.pkt_unchecked_cnt;
 	}
 
 	txsc->last_validate_frames = secy->validate_frames;
-	txsc->last_protect_frames = secy->protect_frames;
+	txsc->last_replay_protect = secy->replay_protect;
 }
 
 static int cn10k_mdo_open(struct macsec_context *ctx)
@@ -1117,7 +1117,7 @@ static int cn10k_mdo_add_secy(struct macsec_context *ctx)
 	txsc->sw_secy = secy;
 	txsc->encoding_sa = secy->tx_sc.encoding_sa;
 	txsc->last_validate_frames = secy->validate_frames;
-	txsc->last_protect_frames = secy->protect_frames;
+	txsc->last_replay_protect = secy->replay_protect;
 
 	list_add(&txsc->entry, &cfg->txsc_list);
 
@@ -1538,12 +1538,12 @@ static int cn10k_mdo_get_rx_sc_stats(struct macsec_context *ctx)
 	rxsc->stats.InPktsInvalid += rsp.pkt_invalid_cnt;
 	rxsc->stats.InPktsNotValid += rsp.pkt_notvalid_cnt;
 
-	if (secy->protect_frames)
+	if (secy->replay_protect)
 		rxsc->stats.InPktsLate += rsp.pkt_late_cnt;
 	else
 		rxsc->stats.InPktsDelayed += rsp.pkt_late_cnt;
 
-	if (secy->validate_frames == MACSEC_VALIDATE_CHECK)
+	if (secy->validate_frames == MACSEC_VALIDATE_DISABLED)
 		rxsc->stats.InPktsUnchecked += rsp.pkt_unchecked_cnt;
 	else
 		rxsc->stats.InPktsOK += rsp.pkt_unchecked_cnt;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 712715a49d201..634ca4140346b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -386,7 +386,7 @@ struct cn10k_mcs_txsc {
 	struct cn10k_txsc_stats stats;
 	struct list_head entry;
 	enum macsec_validation_type last_validate_frames;
-	bool last_protect_frames;
+	bool last_replay_protect;
 	u16 hw_secy_id_tx;
 	u16 hw_secy_id_rx;
 	u16 hw_flow_id;
-- 
2.39.2



