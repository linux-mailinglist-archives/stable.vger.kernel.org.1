Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C67551BB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGPT7j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjGPT7j (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E807EE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C19FE60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FF5C433CB;
        Sun, 16 Jul 2023 19:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537577;
        bh=+8NbRT5L1KKxuEnQSd+1DyIIY1tjUC9/fc9jkMnayr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfWXXLZjgaO0uDu5bl7U32N5ac67SfUMCDcAG/Lwh58DL7wKng7jR0bd9PxVyLBxY
         DT9HU24J73xWgcHmqX4Lsn1+Dp94fyN69nkvmWRvAbqrnfqj0y7LiqMNhvX4ufkhz+
         o6cI0Gsn6KW2DuWKcaubTunpPMgcmyseebQbZayM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 116/800] wifi: rtw88: unlock on error path in rtw_ops_add_interface()
Date:   Sun, 16 Jul 2023 21:39:29 +0200
Message-ID: <20230716194951.803430706@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e2ff1181b3d48257aab26bfd2165f3c7d271499f ]

Call mutex_unlock(&rtwdev->mutex); before returning on this error path.

Fixes: f0e741e4ddbc ("wifi: rtw88: add bitmap for dynamic port settings")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/ddd10a74-5982-4f65-8c59-c1cca558d239@kili.mountain
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 144618bb94c86..09bcc2345bb05 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -164,8 +164,10 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	mutex_lock(&rtwdev->mutex);
 
 	port = find_first_zero_bit(rtwdev->hw_port, RTW_PORT_NUM);
-	if (port >= RTW_PORT_NUM)
+	if (port >= RTW_PORT_NUM) {
+		mutex_unlock(&rtwdev->mutex);
 		return -EINVAL;
+	}
 	set_bit(port, rtwdev->hw_port);
 
 	rtwvif->port = port;
-- 
2.39.2



