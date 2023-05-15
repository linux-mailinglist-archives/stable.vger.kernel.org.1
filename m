Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF0703A12
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbjEORsW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244754AbjEORsH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD21B094
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAA1762EE5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC5DC4339E;
        Mon, 15 May 2023 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172790;
        bh=GR7Ela1j7RtgcTsF+IMcnglXnmG+P+VslChq5U2/h+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tn2h0ATXgQj+stBsDdJP8lu+mCnJNMy5K5Fdig2dNV0eDZIK/U9RQEjJNrtBV8L4/
         Ud+iJb2CYu9sdPiFptXsZPggdX62o5zzw+76vEbrvcG4l4UU6TNBPVeyCn6NS0L6ZI
         KdPD5rPbKUSjEHeJSNMczHVO8eJupWB8WBks0Jl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaosheng Cui <cuigaosheng1@huawei.com>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 268/381] phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port
Date:   Mon, 15 May 2023 18:28:39 +0200
Message-Id: <20230515161748.869022456@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Gaosheng Cui <cuigaosheng1@huawei.com>

[ Upstream commit e024854048e733391b31fe5a398704b31b9af803 ]

The tegra_xusb_port_unregister should be called when usb2_port
and ulpi_port map fails in tegra_xusb_add_usb2_port() or in
tegra_xusb_add_ulpi_port(), fix it.

Fixes: 53d2a715c240 ("phy: Add Tegra XUSB pad controller support")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20221129111634.1547747-1-cuigaosheng1@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/tegra/xusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 181a1be5f4917..d07f33ec79397 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -775,6 +775,7 @@ static int tegra_xusb_add_usb2_port(struct tegra_xusb_padctl *padctl,
 	usb2->base.lane = usb2->base.ops->map(&usb2->base);
 	if (IS_ERR(usb2->base.lane)) {
 		err = PTR_ERR(usb2->base.lane);
+		tegra_xusb_port_unregister(&usb2->base);
 		goto out;
 	}
 
@@ -841,6 +842,7 @@ static int tegra_xusb_add_ulpi_port(struct tegra_xusb_padctl *padctl,
 	ulpi->base.lane = ulpi->base.ops->map(&ulpi->base);
 	if (IS_ERR(ulpi->base.lane)) {
 		err = PTR_ERR(ulpi->base.lane);
+		tegra_xusb_port_unregister(&ulpi->base);
 		goto out;
 	}
 
-- 
2.39.2



