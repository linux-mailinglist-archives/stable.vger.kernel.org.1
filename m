Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704BC7ED3C1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjKOUyd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjKOUy1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:54:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68DFD49
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:54:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B4EC4E779;
        Wed, 15 Nov 2023 20:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081663;
        bh=LoIbWKpSuGqNXjkaIv46kx789jdNiqSVzRQv6E/wWUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUUkopq4kxBtJdboyryvVy4+33N3wdFGqTxMgIfzRbnFQcf28LxBeDAs/bRFy6KHf
         r6prROkjOTTHXI589r61iGNPLFEF05DqHrQ3t8kNDdTXRi5HjDOgP8A0Cy7wWCSW1r
         UMkS3v1mYG8+lrLH2NqZTQMk5RX2rfHblLGhA1Tw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 023/191] wifi: rtlwifi: fix EDCA limit set by BT coexistence
Date:   Wed, 15 Nov 2023 15:44:58 -0500
Message-ID: <20231115204645.932511909@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 3391ee7f9ea508c375d443cd712c2e699be235b4 ]

In 'rtl92c_dm_check_edca_turbo()', 'rtl88e_dm_check_edca_turbo()',
and 'rtl8723e_dm_check_edca_turbo()', the DL limit should be set
from the corresponding field of 'rtlpriv->btcoexist' rather than
UL. Compile tested only.

Fixes: 0529c6b81761 ("rtlwifi: rtl8723ae: Update driver to match 06/28/14 Realtek version")
Fixes: c151aed6aa14 ("rtlwifi: rtl8188ee: Update driver to match Realtek release of 06282014")
Fixes: beb5bc402043 ("rtlwifi: rtl8192c-common: Convert common dynamic management routines for addition of rtl8192se and rtl8192de")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230928052327.120178-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c       | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
index d10c14c694da8..a1b920843b869 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
@@ -799,7 +799,7 @@ static void rtl88e_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
index 265a1a336304e..c493e50b7bc58 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
@@ -640,7 +640,7 @@ static void rtl92c_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
index 8ada31380efa4..0ff8e355c23a4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
@@ -466,7 +466,7 @@ static void rtl8723e_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
-- 
2.42.0



