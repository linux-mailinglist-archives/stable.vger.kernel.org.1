Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58CB75D2E3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjGUTEu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjGUTEt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA230CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D6A761D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4000AC433C8;
        Fri, 21 Jul 2023 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966287;
        bh=Jz5Alhiv4qmFyNu5GmlaTP+nsdGPkRJoOTwi9Jf2ens=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hh+0K4KWZ9yYawdqpFnWwmjmQRSSGidTMpYrGAJwNale5Nz4Hih9Jn0YxNjGm4dnt
         lFi2oM3Mw+IZH93zC7PYXkEEru3AMqz4GaYGijIH9x4BQuOjoQSRkZwMk428Xq0i8q
         wqp4afpn1UNfN4Ak72I7Ht+ZhgA1NWuUVv2l3Ew0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, EJ Hsu <ejh@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15 252/532] phy: tegra: xusb: Clear the driver reference in usb-phy dev
Date:   Fri, 21 Jul 2023 18:02:36 +0200
Message-ID: <20230721160628.023499125@linuxfoundation.org>
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

From: EJ Hsu <ejh@nvidia.com>

commit c0c2fcb1325d0d4f3b322b5ee49385f8eca2560d upstream.

For the dual-role port, it will assign the phy dev to usb-phy dev and
use the port dev driver as the dev driver of usb-phy.

When we try to destroy the port dev, it will destroy its dev driver
as well. But we did not remove the reference from usb-phy dev. This
might cause the use-after-free issue in KASAN.

Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
Cc: stable@vger.kernel.org

Signed-off-by: EJ Hsu <ejh@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20230609062932.3276509-1-haotienh@nvidia.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/tegra/xusb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -562,6 +562,7 @@ static void tegra_xusb_port_unregister(s
 		usb_role_switch_unregister(port->usb_role_sw);
 		cancel_work_sync(&port->usb_phy_work);
 		usb_remove_phy(&port->usb_phy);
+		port->usb_phy.dev->driver = NULL;
 	}
 
 	if (port->ops->remove)


