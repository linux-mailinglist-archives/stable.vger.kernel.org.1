Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAD87E24B6
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjKFNY3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjKFNY0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:24:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C2BD8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:24:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F43C433C8;
        Mon,  6 Nov 2023 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277063;
        bh=AlzcfrXAvi3vBH3aRbil/mErkdkOFw38EHUJusIGioU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deiT9zBsXz0XdF2VNM3MDURTFhHfbRKOIf9ZEMAl9Ev+8Oy2HW9awCyU5h+X8/err
         iOWxeaGdZJAVSoRpOn8FBDG384nhS3gHwv7s6zDrBr2h0BHGNXsEv4SLDom13mbTMJ
         ygmO5Q8e4Ffdi5uqDnEZjudG78ucpxM8erXeI8hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kunwu Chan <chentao@kylinos.cn>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 025/128] treewide: Spelling fix in comment
Date:   Mon,  6 Nov 2023 14:03:05 +0100
Message-ID: <20231106130310.263465389@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index dc14a66583ff3..44488c153ea25 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
@@ -1217,7 +1217,7 @@ static int gelic_wl_set_encodeext(struct net_device *netdev,
 		key_index = wl->current_key;
 
 	if (!enc->length && (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)) {
-		/* reques to change default key index */
+		/* request to change default key index */
 		pr_debug("%s: request to change default key to %d\n",
 			 __func__, key_index);
 		wl->current_key = key_index;
-- 
2.42.0



