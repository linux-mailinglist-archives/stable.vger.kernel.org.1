Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5F5726D6E
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjFGUlz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjFGUly (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C010FC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B23C164619
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81AFC433EF;
        Wed,  7 Jun 2023 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170511;
        bh=SXQRpUtWaCZ8tdochUCOdSyqtIgxYhXwTpkO7BzSWW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMIzFvwJ6gwbz2HWsVDlTDqFzkgPayqxKnKZvI4uV1s+jtHp0MrEoTROqpm4IOScG
         d1S2QfAAe86Hir+56XfnCWX7PILOtPBGCK7RZCqMKvJ2G3oYQXs4n8qCFWXvWKNZ9s
         ChXkHYfl2szHLQa5OMf3fswAFCeChITZ0yJGm5ZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yun Lu <luyun@kylinos.cn>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/225] wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value
Date:   Wed,  7 Jun 2023 22:15:05 +0200
Message-ID: <20230607200918.039234620@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

From: Yun Lu <luyun@kylinos.cn>

[ Upstream commit 20429444e653ee8242dfbf815c0c37866beb371b ]

When using rtl8192cu with rtl8xxxu driver to connect wifi, there is a
probability of failure, which shows "authentication with ... timed out".
Through debugging, it was found that the RCR register has been inexplicably
modified to an incorrect value, resulting in the nic not being able to
receive authenticated frames.

To fix this problem, add regrcr in rtl8xxxu_priv struct, and store
the RCR value every time the register is written, and use it the next
time the register need to be modified.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
Link: https://lore.kernel.org/all/20230427020512.1221062-1-luyun_611@163.com
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230512012055.2990472-1-luyun_611@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 1ba66b8f70c95..cda3b802e89dd 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1346,6 +1346,7 @@ struct rtl8xxxu_priv {
 	u32 rege9c;
 	u32 regeb4;
 	u32 regebc;
+	u32 regrcr;
 	int next_mbox;
 	int nr_out_eps;
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 95c0150f23569..3a9fa3ff37acc 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4049,6 +4049,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		RCR_ACCEPT_MGMT_FRAME | RCR_HTC_LOC_CTRL |
 		RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
 	rtl8xxxu_write32(priv, REG_RCR, val32);
+	priv->regrcr = val32;
 
 	/*
 	 * Accept all multicast
@@ -6058,7 +6059,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 				      unsigned int *total_flags, u64 multicast)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
-	u32 rcr = rtl8xxxu_read32(priv, REG_RCR);
+	u32 rcr = priv->regrcr;
 
 	dev_dbg(&priv->udev->dev, "%s: changed_flags %08x, total_flags %08x\n",
 		__func__, changed_flags, *total_flags);
@@ -6104,6 +6105,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 	rtl8xxxu_write32(priv, REG_RCR, rcr);
+	priv->regrcr = rcr;
 
 	*total_flags &= (FIF_ALLMULTI | FIF_FCSFAIL | FIF_BCN_PRBRESP_PROMISC |
 			 FIF_CONTROL | FIF_OTHER_BSS | FIF_PSPOLL |
-- 
2.39.2



