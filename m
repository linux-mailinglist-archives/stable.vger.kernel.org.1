Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96375D43C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjGUTTZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGUTTM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F113C19
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C930661D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D884EC433C7;
        Fri, 21 Jul 2023 19:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967147;
        bh=5fkggPlNbQ0k0vvbXEFpuwiTvt59q3T69+l6vifkhNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwIF9d1ICd4NRtbeiHGuMaePmgWSjpr6bDD1zfznpgy9AOdhyXuGkENRiZKqtvC5O
         jwRdIV9haEmj2xgDpcSmvj816VvwZcVeEux6XW2ILT5N8YFTvj++rsywFUI15XwujO
         icFFJVqxPvkO0Up7jSTXBqyawzoEDYfYIVLAl0S8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/223] wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()
Date:   Fri, 21 Jul 2023 18:05:14 +0200
Message-ID: <20230721160523.460771702@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 4f4626cd049576af1276c7568d5b44eb3f7bb1b1 ]

If there is a failure during rtw89_fw_h2c_raw() rtw89_debug_priv_send_h2c
should return negative error code instead of a positive value count.
Fix this bug by returning correct error code.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://lore.kernel.org/r/tencent_AD09A61BC4DA92AD1EB0790F5C850E544D07@qq.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 50701c55ed602..ec0af903961f0 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2130,17 +2130,18 @@ static ssize_t rtw89_debug_priv_send_h2c_set(struct file *filp,
 	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	u8 *h2c;
+	int ret;
 	u16 h2c_len = count / 2;
 
 	h2c = rtw89_hex2bin_user(rtwdev, user_buf, count);
 	if (IS_ERR(h2c))
 		return -EFAULT;
 
-	rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
+	ret = rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
 
 	kfree(h2c);
 
-	return count;
+	return ret ? ret : count;
 }
 
 static int
-- 
2.39.2



