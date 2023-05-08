Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA016FAB97
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjEHLPJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjEHLPI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E036579
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6FA62BBD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F536C433EF;
        Mon,  8 May 2023 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544506;
        bh=yE6IFjsGMYHgcSpc8xfivyrxkf3CDK9NmHDrdTi5PUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVAJuOSIU5oFugDelX6KxfldlSM0n1etGGhSsZLVSPUbEtdfQ8D4ePZSJCP98N5dz
         onG/QG0R0LJiRmoAjhHG8O7Q/WoUAdpjx01ajSovftsn8J3g/dUn4tMaVrW1fjaYJU
         W4kwoqIhbKrkjkpH2XAO+lRUMhk8wB3Nn/sCueC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Deren Wu <deren.wu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 432/694] wifi: mt76: mt7921: fix wrong command to set STA channel
Date:   Mon,  8 May 2023 11:44:27 +0200
Message-Id: <20230508094447.391175675@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Deren Wu <deren.wu@mediatek.com>

[ Upstream commit fcc51acfebb85dbc3ab1bea3ce4997d7c0a3a38d ]

Should not use AND operator to check vif type NL80211_IFTYPE_MONITOR, and
that will cause we go into sniffer command for both STA and MONITOR
mode. However, the sniffer command would set channel properly (with some
extra options), the STA mode still works even if using the wrong
command.

Fix vif type check to make sure we using the right command to update
channel.

Fixes: 914189af23b8 ("wifi: mt76: mt7921: fix channel switch fail in monitor mode")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 42933a6b7334b..058aa581ff4f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1694,7 +1694,7 @@ static void mt7921_ctx_iter(void *priv, u8 *mac,
 	if (ctx != mvif->ctx)
 		return;
 
-	if (vif->type & NL80211_IFTYPE_MONITOR)
+	if (vif->type == NL80211_IFTYPE_MONITOR)
 		mt7921_mcu_config_sniffer(mvif, ctx);
 	else
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx);
-- 
2.39.2



