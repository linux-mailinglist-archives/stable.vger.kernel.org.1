Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD270342F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbjEOQpj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbjEOQpf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:45:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E94EFF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD8E628E9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D121C4339C;
        Mon, 15 May 2023 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169132;
        bh=6N4cQGmi8nsui6Vau8mLECAFYiMVLhVBvZmyY3UuVRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v84jZzmbQbIGyo/hRmWvOjRsLEF3fKSfo/ZUcsjDX7bVVlsFW6yjlAOvGYh04VJRX
         95Xy+oEdMSMmreC49NPFj80Nk6h30B9ygyIpi5MvYniWhObKnfzyCe3MXP6t07Nx5U
         EqEQSxzFRQr6egaF7IgqW2mAQmcKxwFhZdpFfbpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaosheng Cui <cuigaosheng1@huawei.com>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 123/191] phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port
Date:   Mon, 15 May 2023 18:26:00 +0200
Message-Id: <20230515161711.767682380@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 39c01ef57d83c..17211b31e1ed4 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -583,6 +583,7 @@ static int tegra_xusb_add_usb2_port(struct tegra_xusb_padctl *padctl,
 	usb2->base.lane = usb2->base.ops->map(&usb2->base);
 	if (IS_ERR(usb2->base.lane)) {
 		err = PTR_ERR(usb2->base.lane);
+		tegra_xusb_port_unregister(&usb2->base);
 		goto out;
 	}
 
@@ -635,6 +636,7 @@ static int tegra_xusb_add_ulpi_port(struct tegra_xusb_padctl *padctl,
 	ulpi->base.lane = ulpi->base.ops->map(&ulpi->base);
 	if (IS_ERR(ulpi->base.lane)) {
 		err = PTR_ERR(ulpi->base.lane);
+		tegra_xusb_port_unregister(&ulpi->base);
 		goto out;
 	}
 
-- 
2.39.2



