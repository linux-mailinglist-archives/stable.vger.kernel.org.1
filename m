Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664FB726F39
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjFGU4f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFGU4c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01091FEE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2EC64843
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3A2C433EF;
        Wed,  7 Jun 2023 20:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171387;
        bh=JV23PZ/gtcMCbhCQGxTQkdUxehKQ8XbLKvqQ4OT+cdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vz8ehFgMXHGxLswdFG1s7oVQMaxybIGfyiBuK35eaJoB2FHAnN5yNb1whIBt6j4iW
         3Tv6BRvELmlHcZq/v3X60+znpZ/uonyzBN72pMey/jycL65nJOP0HBFjF8YZCNOtUq
         GoMAkDfxxC4AILDgrKlPlDznv5iPeX7Hv8PVWr2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 5.4 98/99] wifi: rtlwifi: 8192de: correct checking of IQK reload
Date:   Wed,  7 Jun 2023 22:17:30 +0200
Message-ID: <20230607200903.318245895@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

commit 93fbc1ebd978cf408ef5765e9c1630fce9a8621b upstream.

Since IQK could spend time, we make a cache of IQK result matrix that looks
like iqk_matrix[channel_idx].val[x][y], and we can reload the matrix if we
have made a cache. To determine a cache is made, we check
iqk_matrix[channel_idx].val[0][0].

The initial commit 7274a8c22980 ("rtlwifi: rtl8192de: Merge phy routines")
make a mistake that checks incorrect iqk_matrix[channel_idx].val[0] that
is always true, and this mistake is found by commit ee3db469dd31
("wifi: rtlwifi: remove always-true condition pointed out by GCC 12"), so
I recall the vendor driver to find fix and apply the correctness.

Fixes: 7274a8c22980 ("rtlwifi: rtl8192de: Merge phy routines")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220801113345.42016-1-pkshih@realtek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -2392,11 +2392,10 @@ void rtl92d_phy_reload_iqk_setting(struc
 			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
 				 "Just Read IQK Matrix reg for channel:%d....\n",
 				 channel);
-			_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
-					rtlphy->iqk_matrix[
-					indexforchannel].value,	0,
-					(rtlphy->iqk_matrix[
-					indexforchannel].value[0][2] == 0));
+			if (rtlphy->iqk_matrix[indexforchannel].value[0][0] != 0)
+				_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
+					rtlphy->iqk_matrix[indexforchannel].value, 0,
+					rtlphy->iqk_matrix[indexforchannel].value[0][2] == 0);
 			if (IS_92D_SINGLEPHY(rtlhal->version)) {
 				if ((rtlphy->iqk_matrix[
 					indexforchannel].value[0][4] != 0)


