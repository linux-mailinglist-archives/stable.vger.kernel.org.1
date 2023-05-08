Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5C6FA4CC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjEHKDU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjEHKDS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2A2EB05
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EAAF62026
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD6BC433D2;
        Mon,  8 May 2023 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540194;
        bh=KcdjGCERVhAYAgknl9UnSIXHyS5sM3UaahESDZw1D40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2orZNDPdEGzUtzpCnzfB1/vPA9Aq3cs9+E7NFQ76VyEdTnSSETuZVaUi/ksvZEhc
         05PSsTRPKhqnwgpc39dbtzBMY4A12FVT5I9L+5hHaUVzI2B1tZDxVYOA60attUoZaV
         Z6aD2d+aHgaRCRDs3gd2ke6lpkaR0Ps1nl2Ag380=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 271/611] wifi: ath11k: fix SAC bug on peer addition with sta band migration
Date:   Mon,  8 May 2023 11:41:53 +0200
Message-Id: <20230508094431.190692335@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit 60b7d62ba8cdbd073997bff0f1cdae8d844002c0 ]

Fix sleep in atomic context warning detected by Smatch static checker
analyzer.

Following the locking pattern for peer_rhash_add lock tbl_mtx_lock mutex
always even if sta is not transitioning to another band.
This is peer_add function and a more secure locking should not cause
performance regression.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1

Fixes: d673cb6fe6c0 ("wifi: ath11k: fix peer addition/deletion error on sta band migration")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230209222622.1751-1-ansuelsmth@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/peer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 1ae7af02c364e..1380811827a84 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -382,22 +382,23 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		return -ENOBUFS;
 	}
 
+	mutex_lock(&ar->ab->tbl_mtx_lock);
 	spin_lock_bh(&ar->ab->base_lock);
 	peer = ath11k_peer_find_by_addr(ar->ab, param->peer_addr);
 	if (peer) {
 		if (peer->vdev_id == param->vdev_id) {
 			spin_unlock_bh(&ar->ab->base_lock);
+			mutex_unlock(&ar->ab->tbl_mtx_lock);
 			return -EINVAL;
 		}
 
 		/* Assume sta is transitioning to another band.
 		 * Remove here the peer from rhash.
 		 */
-		mutex_lock(&ar->ab->tbl_mtx_lock);
 		ath11k_peer_rhash_delete(ar->ab, peer);
-		mutex_unlock(&ar->ab->tbl_mtx_lock);
 	}
 	spin_unlock_bh(&ar->ab->base_lock);
+	mutex_unlock(&ar->ab->tbl_mtx_lock);
 
 	ret = ath11k_wmi_send_peer_create_cmd(ar, param);
 	if (ret) {
-- 
2.39.2



