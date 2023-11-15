Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17E87ECB77
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjKOTWc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjKOTWb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0C1AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF54C433CB;
        Wed, 15 Nov 2023 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076143;
        bh=HUGc8l5wDoZ8m/ebC8DXLn2CdCTlrekjPAYo1e9WuXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmR2dAIp+qaE5Vdhn2qxGClZF37JOGwVGXQZyudSxAedk+55HF6fHmsFRGszxEc45
         MYQKnu6NpApH8vmZkkniq/MkIB7vRSFukSxGHjKp/YwszRNCjznD8ibDjsQlbqmG1f
         GRIop4V6N96MAMKNu0BWHf8y2E5z7qQVir3wgKds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 101/550] wifi: rtlwifi: fix EDCA limit set by BT coexistence
Date:   Wed, 15 Nov 2023 14:11:25 -0500
Message-ID: <20231115191607.716374694@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 6f61d6a106272..5a34894a533be 100644
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
index 0b6a15c2e5ccd..d92aad60edfe9 100644
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



