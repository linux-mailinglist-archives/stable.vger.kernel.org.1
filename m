Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D575D2F7
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjGUTFi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGUTFh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:05:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A7E30CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:05:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF1FA61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9DFC433C7;
        Fri, 21 Jul 2023 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966335;
        bh=ANLGkdDpxDlbTviO8xZqnyAGWvPOF9lsmS7nMSxlCrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzdU4tTFQkFsi9xs0tMgXPQNcVoV3i/K3DYSFgrVEkzAXCSpS9WQi7aB6GYRm+Oeo
         5eW5tP+4PnVnvVr//jdhnlFUpUXrS3S78ri9t7M1txzDxtR46qBwGG9H43qqpYdYXh
         f6nBW1ny4RTdHeUhbgRxL5nBHGZMfS12qA07yUi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 307/532] phy: tegra: xusb: check return value of devm_kzalloc()
Date:   Fri, 21 Jul 2023 18:03:31 +0200
Message-ID: <20230721160631.063346191@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 44faada0f38fc333d392af04c343b0e23f8f5d81 ]

devm_kzalloc() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: f67213cee2b3 ("phy: tegra: xusb: Add usb-role-switch support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20230531073950.145339-1-claudiu.beznea@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/tegra/xusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index bdcf217bf3f88..119e2c039225f 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -669,6 +669,9 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 	port->dev.driver = devm_kzalloc(&port->dev,
 					sizeof(struct device_driver),
 					GFP_KERNEL);
+	if (!port->dev.driver)
+		return -ENOMEM;
+
 	port->dev.driver->owner	 = THIS_MODULE;
 
 	port->usb_role_sw = usb_role_switch_register(&port->dev,
-- 
2.39.2



