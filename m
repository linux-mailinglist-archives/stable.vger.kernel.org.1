Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF576FA7B5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjEHKeI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjEHKdo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4940CD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03897626F1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11490C433EF;
        Mon,  8 May 2023 10:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541974;
        bh=ucVO4eYOtCgAXsZcK7amHoN6+16DS8x9veLfBhib2vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mOyt/DOFhNgVSVpoSR/ud9fSl5AGLNjTFYZHy42HMDmF5wAn0UM/0wYWVNlVL7ryM
         FZQ/FgjTRDjRi9ANQ65ihQpmpxvG6LuwG7nNcKl29pnf6RL/dIiFbsIy+0qoyUWjWv
         DQ7l8vXH3iEzbsw7s0W03/AEbAjzA7KW2fmswdKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 286/663] wifi: rtl8xxxu: Remove always true condition in rtl8xxxu_print_chipinfo
Date:   Mon,  8 May 2023 11:41:52 +0200
Message-Id: <20230508094437.489386176@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit b9b1e4fe2957f361c86e288ecf373dc7895cf7c7 ]

Fix a new smatch warning:
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:1580 rtl8xxxu_print_chipinfo() warn: always true condition '(priv->chip_cut <= 15) => (0-15 <= 15)'

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302140753.71IgU77A-lkp@intel.com/
Fixes: 7b0ac469e331 ("wifi: rtl8xxxu: Recognise all possible chip cuts")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/68eff98b-a022-5a00-f330-adf623a35772@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index d22990464dad6..846bd268ffd94 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1574,11 +1574,7 @@ rtl8xxxu_set_spec_sifs(struct rtl8xxxu_priv *priv, u16 cck, u16 ofdm)
 static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
 {
 	struct device *dev = &priv->udev->dev;
-	char cut = '?';
-
-	/* Currently always true: chip_cut is 4 bits. */
-	if (priv->chip_cut <= 15)
-		cut = 'A' + priv->chip_cut;
+	char cut = 'A' + priv->chip_cut;
 
 	dev_info(dev,
 		 "RTL%s rev %c (%s) %iT%iR, TX queues %i, WiFi=%i, BT=%i, GPS=%i, HI PA=%i\n",
-- 
2.39.2



