Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9E87611CA
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjGYK4Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjGYKzs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EAB49EF
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED33C6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09177C433C7;
        Tue, 25 Jul 2023 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282418;
        bh=hCkuT5beDrZIJ2wWaJoikeQdkijfyUCkg38TlOIYmcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oT8RSzKdwGl3HN+tu+BxeuV8GYnL0MxFHQOCooklrcGTs+UgTERuZdOZRV0BFBGaf
         MuQ70CJVhlJPsKkxGYBvECVn2McORWhDhZb4MzOw9Y8U9DLRZDqcI893h83IFz4VzH
         NcM1dZWou74QX1zHj0YekGMFEhDZ47SF3ABZn6Es=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Balamurugan S <quic_bselvara@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 122/227] wifi: ath12k: Avoid NULL pointer access during management transmit cleanup
Date:   Tue, 25 Jul 2023 12:44:49 +0200
Message-ID: <20230725104519.866938007@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Balamurugan S <quic_bselvara@quicinc.com>

[ Upstream commit 054b5580a36e435692c203c19abdcb9f7734320e ]

Currently 'ar' reference is not added in skb_cb.
Though this is generally not used during transmit completion
callbacks, on interface removal the remaining idr cleanup callback
uses the ar pointer from skb_cb from management txmgmt_idr. Hence fill them
during transmit call for proper usage to avoid NULL pointer dereference.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230518071046.14337-1-quic_bselvara@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ee792822b4113..58acfe8fdf8c0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4425,6 +4425,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_vif *arvif,
 	int buf_id;
 	int ret;
 
+	ATH12K_SKB_CB(skb)->ar = ar;
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
 			   ATH12K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);
-- 
2.39.2



