Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A37E22D7
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjKFNGC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjKFNGB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:06:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F4A9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:05:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2550EC433C8;
        Mon,  6 Nov 2023 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275957;
        bh=Up/2Qhc5kkVkUmLhcyfGxisWshR57CbaCHjt5JrpHPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REKucMbHfSuNklYlQfeddMSiRVpfTLsiRC124m5/ijSJ1y1j3FL6q5RY0hIZuahEq
         sgHM0DuI+MQT0v6yDlVHiokpjT2Eyo4vWM+kWhpaGbCqCikNmsUt8FDgmoXbJmMYfT
         g39JDLls4UUctbcimTTXt7EZ4dYhUbELY/wqyUkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kunwu Chan <chentao@kylinos.cn>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/48] treewide: Spelling fix in comment
Date:   Mon,  6 Nov 2023 14:02:55 +0100
Message-ID: <20231106130258.015956342@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit fb71ba0ed8be9534493c80ba00142a64d9972a72 ]

reques -> request

Fixes: 09dde54c6a69 ("PS3: gelic: Add wireless support for PS3")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index eed18f88bdff7..e70175f40a824 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
@@ -1232,7 +1232,7 @@ static int gelic_wl_set_encodeext(struct net_device *netdev,
 		key_index = wl->current_key;
 
 	if (!enc->length && (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)) {
-		/* reques to change default key index */
+		/* request to change default key index */
 		pr_debug("%s: request to change default key to %d\n",
 			 __func__, key_index);
 		wl->current_key = key_index;
-- 
2.42.0



