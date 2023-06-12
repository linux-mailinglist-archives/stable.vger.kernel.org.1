Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D278472C07D
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjFLKxB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbjFLKwq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED13C28
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98FAA60C2D
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B208EC433EF;
        Mon, 12 Jun 2023 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566226;
        bh=oXResC91VdN7eCvf90K4ovTtAdv43tdV262UchwJIrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iN1U30OH9Eulgph+zyCvwtyQAtgXIgDgzEYjrtUS/BZUyj0sEX5n/wQZADnZdWb2+
         etdxAgvArYxSxOqTffTkpT2GeACDajF4AhTLbtEZXuQZ89q26YOmbApL5iBgpzVHnE
         3pt2tZcVDIc6AzHWusOW37AIPySMU/E8o7Du5Ho8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 14/91] wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll
Date:   Mon, 12 Jun 2023 12:26:03 +0200
Message-ID: <20230612101702.686974767@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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
index 37bc307c19719..2f0ba8a75d71b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -869,7 +869,10 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 
 		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
 					poll_list);
+
+		spin_lock_bh(&dev->sta_poll_lock);
 		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
-- 
2.39.2



