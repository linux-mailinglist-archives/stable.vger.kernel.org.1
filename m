Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3CB7ED058
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbjKOTy0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343489AbjKOTyZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:54:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6716392
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:54:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF790C433C7;
        Wed, 15 Nov 2023 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078062;
        bh=8zUgCPlV4FSd3DzaUwHBVzf/Y7HZT6B6gFtvky/d1Eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ypRsJlNFUhjDprk+znqM+83NIsHsDu3TVCVKsn2Y4mWGygSbSWXCspGIhWCjbn1sW
         p8Ud4Wcy22I1GMDvOm9qDhgxY3DbIP+khvjWytY1/bA88baZ+bKOOvLCTYi33lEHDc
         Mo7FE5B9HCFlSZ6UsfHekVQu8KlQxiCnyG04SiYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Martin=20Kj=C3=A6r=20J=C3=B8rgensen?= <me@lagy.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/379] r8169: fix rare issue with broken rx after link-down on RTL8125
Date:   Wed, 15 Nov 2023 14:22:17 -0500
Message-ID: <20231115192648.816305247@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 621735f590643e3048ca2060c285b80551660601 ]

In very rare cases (I've seen two reports so far about different
RTL8125 chip versions) it seems the MAC locks up when link goes down
and requires a software reset to get revived.
Realtek doesn't publish hw errata information, therefore the root cause
is unknown. Realtek vendor drivers do a full hw re-initialization on
each link-up event, the slimmed-down variant here was reported to fix
the issue for the reporting user.
It's not fully clear which parts of the NIC are reset as part of the
software reset, therefore I can't rule out side effects.

Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
Reported-by: Martin Kjær Jørgensen <me@lagy.org>
Link: https://lore.kernel.org/netdev/97ec2232-3257-316c-c3e7-a08192ce16a6@gmail.com/T/
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/9edde757-9c3b-4730-be3b-0ef3a374ff71@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index dd8cb52b0a17e..94f902d8e975f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4561,7 +4561,11 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	if (netif_carrier_ok(ndev)) {
 		rtl_link_chg_patch(tp);
 		pm_request_resume(d);
+		netif_wake_queue(tp->dev);
 	} else {
+		/* In few cases rx is broken after link-down otherwise */
+		if (rtl_is_8125(tp))
+			rtl_reset_work(tp);
 		pm_runtime_idle(d);
 	}
 
-- 
2.42.0



