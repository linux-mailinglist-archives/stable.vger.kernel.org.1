Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD26FA944
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjEHKtm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjEHKtW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015882FCFE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B72E56290A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B697CC433EF;
        Mon,  8 May 2023 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542921;
        bh=yluh8WoHo4/9TZ2nMCnPXVVgPq9p8venBoq7bsxa3gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFAu7L3G62Ckn/HsmeEdv8WqT2dk29w9OUrqL0DXvdHeeH+1yRFhPcfD5aziXzvLy
         LgMNQ32tCyyw099/pwVjLiZEMMhcih2jg3Gfw7+MiJGxxz6akqTo+RafhNgTbB/M8J
         mqo8q+hqHDNzcdSRP1SVLZOJFh6zdN5/ZKYFMMZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaosheng Cui <cuigaosheng1@huawei.com>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 590/663] phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port
Date:   Mon,  8 May 2023 11:46:56 +0200
Message-Id: <20230508094448.572635304@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index ff4b930879f3c..58eeda573b677 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -782,6 +782,7 @@ static int tegra_xusb_add_usb2_port(struct tegra_xusb_padctl *padctl,
 	usb2->base.lane = usb2->base.ops->map(&usb2->base);
 	if (IS_ERR(usb2->base.lane)) {
 		err = PTR_ERR(usb2->base.lane);
+		tegra_xusb_port_unregister(&usb2->base);
 		goto out;
 	}
 
@@ -848,6 +849,7 @@ static int tegra_xusb_add_ulpi_port(struct tegra_xusb_padctl *padctl,
 	ulpi->base.lane = ulpi->base.ops->map(&ulpi->base);
 	if (IS_ERR(ulpi->base.lane)) {
 		err = PTR_ERR(ulpi->base.lane);
+		tegra_xusb_port_unregister(&ulpi->base);
 		goto out;
 	}
 
-- 
2.39.2



