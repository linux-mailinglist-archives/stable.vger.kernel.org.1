Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF77ED373
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjKOUwo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjKOUwo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:52:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4FDB0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:52:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F406BC4E779;
        Wed, 15 Nov 2023 20:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081561;
        bh=fUmzaVanyzr/sZ1DmCzX3Ku2BHrFftingK5sci9NCtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sca12VQDsxg3V5IOmsZZwVChfHSIPPawhI8jgm46sAVemBOMyyfOyp9ifWgabxTxX
         iZ2F7/jVeifpI88mj2k4H4I3OVaae5PzXfO2xz1pv7+4l5XDi8dgN+L3EipV7++IkY
         +mus0VV4gigtcWJ9KGXZ93gOo/G9vOUqtKRcl+88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Patrick Thompson <ptf@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 221/244] net: r8169: Disable multicast filter for RTL8168H and RTL8107E
Date:   Wed, 15 Nov 2023 15:36:53 -0500
Message-ID: <20231115203601.602664637@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Thompson <ptf@google.com>

[ Upstream commit efa5f1311c4998e9e6317c52bc5ee93b3a0f36df ]

RTL8168H and RTL8107E ethernet adapters erroneously filter unicast
eapol packets unless allmulti is enabled. These devices correspond to
RTL_GIGA_MAC_VER_46 and VER_48. Add an exception for VER_46 and VER_48
in the same way that VER_35 has an exception.

Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
Signed-off-by: Patrick Thompson <ptf@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/20231030205031.177855-1-ptf@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ab84c623a7c62..2e555eda19a85 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2551,7 +2551,9 @@ static void rtl_set_rx_mode(struct net_device *dev)
 		rx_mode |= AcceptAllPhys;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
+		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_46 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_48) {
 		/* accept all multicasts */
 	} else if (netdev_mc_empty(dev)) {
 		rx_mode &= ~AcceptMulticast;
-- 
2.42.0



