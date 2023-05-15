Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F81703616
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbjEORGS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243569AbjEORF4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95747DAF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BB4D62AAB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C9C433EF;
        Mon, 15 May 2023 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170161;
        bh=qTsrLSqGAkEBd9UiyRLMI7cQ0VBHbsj8urXUfkpEl78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bjo9SRR15nqSfO3cXVih4VJyDJ1HgSEio+RFaNijjsQaITXoYN0cbCwJOStbUObPg
         pmczngVbv9F/XjZnKIwifza+tseiv3QwGenzX7JR5CqEIjGWTCpCJ0+9zWuQc6M9P3
         OJvcSgSzR1k7KRfUdxECty7tataq2i5OFNghK5/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Subbaraya Sundeep <sbhatta@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/239] octeontx2-pf: mcs: Do not reset PN while updating secy
Date:   Mon, 15 May 2023 18:25:06 +0200
Message-Id: <20230515161723.002673573@linuxfoundation.org>
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

[ Upstream commit 3c99bace4ad08ad0264285ba8ad73117560992c2 ]

After creating SecYs, SCs and SAs a SecY can be modified
to change attributes like validation mode, protect frames
mode etc. During this SecY update, packet number is reset to
initial user given value by mistake. Hence do not reset
PN when updating SecY parameters.

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 3ad8d7ef20be6..a487a98eac88c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -1134,6 +1134,7 @@ static int cn10k_mdo_upd_secy(struct macsec_context *ctx)
 	struct macsec_secy *secy = ctx->secy;
 	struct macsec_tx_sa *sw_tx_sa;
 	struct cn10k_mcs_txsc *txsc;
+	bool active;
 	u8 sa_num;
 	int err;
 
@@ -1141,15 +1142,19 @@ static int cn10k_mdo_upd_secy(struct macsec_context *ctx)
 	if (!txsc)
 		return -ENOENT;
 
-	txsc->encoding_sa = secy->tx_sc.encoding_sa;
-
-	sa_num = txsc->encoding_sa;
-	sw_tx_sa = rcu_dereference_bh(secy->tx_sc.sa[sa_num]);
+	/* Encoding SA got changed */
+	if (txsc->encoding_sa != secy->tx_sc.encoding_sa) {
+		txsc->encoding_sa = secy->tx_sc.encoding_sa;
+		sa_num = txsc->encoding_sa;
+		sw_tx_sa = rcu_dereference_bh(secy->tx_sc.sa[sa_num]);
+		active = sw_tx_sa ? sw_tx_sa->active : false;
+		cn10k_mcs_link_tx_sa2sc(pfvf, secy, txsc, sa_num, active);
+	}
 
 	if (netif_running(secy->netdev)) {
 		cn10k_mcs_sync_stats(pfvf, secy, txsc);
 
-		err = cn10k_mcs_secy_tx_cfg(pfvf, secy, txsc, sw_tx_sa, sa_num);
+		err = cn10k_mcs_secy_tx_cfg(pfvf, secy, txsc, NULL, 0);
 		if (err)
 			return err;
 	}
-- 
2.39.2



