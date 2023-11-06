Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F134D7E24E3
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjKFN0U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjKFN0S (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:26:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C7136
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:26:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248C4C433C7;
        Mon,  6 Nov 2023 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277174;
        bh=oneisGARuRI+kcrrOLZZg6sLGpK+LivVPrV+BJDdcHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJJV4x64A2kbyagJxLUWVY59HbfxmLwBU+g8tEFE27SnyWh+Hg+5Zj2ikmvNXT9CK
         VPo/BNfw4ttrMbgx9MgwXqyPa9Tx7u2/QJOxHdi1Tw4eerNAbFg3EA6EC7ZvPfCgRt
         Isv0WbTEyY2tatfaXFHeCbYN8un96Z972KtQT+4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 034/128] r8152: Release firmware if we have an error in probe
Date:   Mon,  6 Nov 2023 14:03:14 +0100
Message-ID: <20231106130310.670026583@linuxfoundation.org>
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit b8d35024d4059ca550cba11ac9ab23a6c238d929 ]

The error handling in rtl8152_probe() is missing a call to release
firmware. Add it in to match what's in the cleanup code in
rtl8152_disconnect().

Fixes: 9370f2d05a2a ("r8152: support request_firmware for RTL8153")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index baa3c57d16427..f6d5fbb9dee07 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9802,6 +9802,7 @@ static int rtl8152_probe(struct usb_interface *intf,
 	cancel_delayed_work_sync(&tp->hw_phy_work);
 	if (tp->rtl_ops.unload)
 		tp->rtl_ops.unload(tp);
+	rtl8152_release_firmware(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
-- 
2.42.0



