Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B770C446
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjEVRbg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEVRbe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591CE9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A3E861F10
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E477C433D2;
        Mon, 22 May 2023 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684776692;
        bh=P3cDRXxzKAsfLtMrmjDYTkLYtPP8bkXUJwi0f0TfSYo=;
        h=Subject:To:Cc:From:Date:From;
        b=u8vRrp5vc8TCnj0PtX3lsOrus8QfPYeBURH0IbLyDl+I9TNB5kMKkWHGJqAFzJ1jF
         HfYUAyrOnPG2DfkyTJWQK1S2P+xYuQlhKUfz1A73lOksCe+mBSquqgOgog4+0yO7P0
         S0dYZvFWm9DqnL1Xy9gi2Qj6v1XKIjTJot/62w90=
Subject: FAILED: patch "[PATCH] wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused by" failed to apply to 6.3-stable tree
To:     pkshih@realtek.com, Larry.Finger@lwfinger.net, kvalo@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:31:30 +0100
Message-ID: <2023052229-profanity-sterling-2644@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x c0426c446d92023d344131d01d929bc25db7a24e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052229-profanity-sterling-2644@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

c0426c446d92 ("wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused by access null page")
6863ad915d32 ("wifi: rtw89: support WoWLAN mode for 8852be")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0426c446d92023d344131d01d929bc25db7a24e Mon Sep 17 00:00:00 2001
From: Ping-Ke Shih <pkshih@realtek.com>
Date: Wed, 26 Apr 2023 11:47:37 +0800
Subject: [PATCH] wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused by
 access null page

Though SER can recover this case, traffic can get stuck for a while. Fix it
by adjusting page quota to avoid hardware access null page of CMAC/DMAC.

Fixes: a1cb097168fa ("wifi: rtw89: 8852b: configure DLE mem")
Fixes: 3e870b481733 ("wifi: rtw89: 8852b: add HFC quota arrays")
Cc: stable@vger.kernel.org
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://github.com/lwfinger/rtw89/issues/226#issuecomment-1520776761
Link: https://github.com/lwfinger/rtw89/issues/240
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230426034737.24870-1-pkshih@realtek.com

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b8019cfc11b2..512de491a064 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1425,6 +1425,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size4 = {RTW89_WDE_PG_64, 0, 4096,},
 	/* PCIE 64 */
 	.wde_size6 = {RTW89_WDE_PG_64, 512, 0,},
+	/* 8852B PCIE SCC */
+	.wde_size7 = {RTW89_WDE_PG_64, 510, 2,},
 	/* DLFW */
 	.wde_size9 = {RTW89_WDE_PG_64, 0, 1024,},
 	/* 8852C DLFW */
@@ -1449,6 +1451,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt4 = {0, 0, 0, 0,},
 	/* PCIE 64 */
 	.wde_qt6 = {448, 48, 0, 16,},
+	/* 8852B PCIE SCC */
+	.wde_qt7 = {446, 48, 0, 16,},
 	/* 8852C DLFW */
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a8d9847ef0b4..6ba633ccdd03 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -792,6 +792,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size0;
 	const struct rtw89_dle_size wde_size4;
 	const struct rtw89_dle_size wde_size6;
+	const struct rtw89_dle_size wde_size7;
 	const struct rtw89_dle_size wde_size9;
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
@@ -804,6 +805,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt4;
 	const struct rtw89_wde_quota wde_qt6;
+	const struct rtw89_wde_quota wde_qt7;
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_ple_quota ple_qt4;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index eaa2ea0586bc..6da1b603a9a9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -18,25 +18,25 @@
 	RTW8852B_FW_BASENAME "-" __stringify(RTW8852B_FW_FORMAT_MAX) ".bin"
 
 static const struct rtw89_hfc_ch_cfg rtw8852b_hfc_chcfg_pcie[] = {
-	{5, 343, grp_0}, /* ACH 0 */
-	{5, 343, grp_0}, /* ACH 1 */
-	{5, 343, grp_0}, /* ACH 2 */
-	{5, 343, grp_0}, /* ACH 3 */
+	{5, 341, grp_0}, /* ACH 0 */
+	{5, 341, grp_0}, /* ACH 1 */
+	{4, 342, grp_0}, /* ACH 2 */
+	{4, 342, grp_0}, /* ACH 3 */
 	{0, 0, grp_0}, /* ACH 4 */
 	{0, 0, grp_0}, /* ACH 5 */
 	{0, 0, grp_0}, /* ACH 6 */
 	{0, 0, grp_0}, /* ACH 7 */
-	{4, 344, grp_0}, /* B0MGQ */
-	{4, 344, grp_0}, /* B0HIQ */
+	{4, 342, grp_0}, /* B0MGQ */
+	{4, 342, grp_0}, /* B0HIQ */
 	{0, 0, grp_0}, /* B1MGQ */
 	{0, 0, grp_0}, /* B1HIQ */
 	{40, 0, 0} /* FWCMDQ */
 };
 
 static const struct rtw89_hfc_pub_cfg rtw8852b_hfc_pubcfg_pcie = {
-	448, /* Group 0 */
+	446, /* Group 0 */
 	0, /* Group 1 */
-	448, /* Public Max */
+	446, /* Public Max */
 	0 /* WP threshold */
 };
 
@@ -49,13 +49,13 @@ static const struct rtw89_hfc_param_ini rtw8852b_hfc_param_ini_pcie[] = {
 };
 
 static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
-	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size6,
-			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
-			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size7,
+			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt7,
+			   &rtw89_mac_size.wde_qt7, &rtw89_mac_size.ple_qt18,
 			   &rtw89_mac_size.ple_qt58},
-	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size6,
-			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
-			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
+	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size7,
+			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt7,
+			   &rtw89_mac_size.wde_qt7, &rtw89_mac_size.ple_qt18,
 			   &rtw89_mac_size.ple_qt_52b_wow},
 	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
 			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,

