Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8075568C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjGPUvk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjGPUvj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:51:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72201E41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F366560EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C067C433C7;
        Sun, 16 Jul 2023 20:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540697;
        bh=Gd6l5MMjY2xJq3zFKQbLITh/6CNVLhiVIuhuclbDH5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjQEdaqQ3OQG47Tfaw2O7JlUt5aw/cbGQEwMlmiVwIupjQ853JvHaP/1/6lMnLmB2
         APj42COj1/5wjm6U4kWwitApIEYGmWa98csVT6eLLaY3MmsZTHwo+V9QVDvot2Istv
         QcyA47adfoXrE8TbQPcr8ngdFud8gbme9YtfE3JI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 455/591] phy: tegra: xusb: check return value of devm_kzalloc()
Date:   Sun, 16 Jul 2023 21:49:54 +0200
Message-ID: <20230716194935.677992889@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index c3fa22ee2d8d4..4d5b4071d47d5 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -670,6 +670,9 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
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



