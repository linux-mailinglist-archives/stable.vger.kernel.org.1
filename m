Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D3872C1A5
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjFLK7N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjFLK5y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A31F7C7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6EE662462
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A080AC4339B;
        Mon, 12 Jun 2023 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566756;
        bh=FjuTuS+Rr+a1rFRLlTFEjYB1nRvxFTxMBUNEWI3Tai4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhcgp9mSGHm/O4qdlac41C0LIYWR2H+UvDP9eHhADAKrFBPfwKb6TqOVmPfzj0dL9
         8NE+cQ5P/ty1naVH586CQ8/yozUgQJNkZ+7G3pYs2GoaCydKOJV1QBU+68qU55PhjR
         3jVEMPJPXdBGHb3KtzQDhrMch+/b968TwhM+HCeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 006/160] wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll
Date:   Mon, 12 Jun 2023 12:25:38 +0200
Message-ID: <20230612101715.426339641@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 30bc32c7c1f975cc3c14e1c7dc437266311282cf ]

Grab sta_poll_lock spinlock in mt7615_mac_sta_poll routine in order to
avoid possible races with mt7615_mac_add_txs() or mt7615_mac_fill_rx()
removing msta pointer from sta_poll_list.

Fixes: a621372a04ac ("mt76: mt7615: rework mt7615_mac_sta_poll for usb code")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/48b23404b759de4f1db2ef85975c72a4aeb1097c.1684938695.git.lorenzo@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index eafa0f204c1f8..12f7bcec53ae1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -919,7 +919,10 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 
 		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
 					poll_list);
+
+		spin_lock_bh(&dev->sta_poll_lock);
 		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
-- 
2.39.2



