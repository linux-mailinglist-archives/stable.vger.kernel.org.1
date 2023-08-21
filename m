Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD37832CC
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjHUUBv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjHUUBu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDECF128
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89880647C9
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D26C433C8;
        Mon, 21 Aug 2023 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648108;
        bh=lXG7bg5jonVFfHb3OqZk0up6B5hzTooDG0KaaXq0d/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cIFUKyKkJyqcuRBABJF6iMwEGNDso9Kp/UEcIpe+ztJK0DGIisIEALqpuDr68y56P
         a6MdmioX+IE8ZMd6owTXs7gSAgsv/OXaZTd6fCREVbkVTlPQ0e3xKkC+3IuWJlLdN0
         9QnO1syhIv2f28oYKZY8GyZAQ5eZmOyjzcDIXVwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Jun <jun.li@nxp.com>,
        Xu Yang <xu.yang_2@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 057/234] usb: chipidea: imx: add missing USB PHY DPDM wakeup setting
Date:   Mon, 21 Aug 2023 21:40:20 +0200
Message-ID: <20230821194131.278041700@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 53d061c19dc4cb68409df6dc11c40389c8c42a75 ]

USB PHY DPDM wakeup bit is enabled by default, when USB wakeup
is not required(/sys/.../wakeup is disabled), this bit should be
disabled, otherwise we will have unexpected wakeup if do USB device
connect/disconnect while system sleep.
This bit can be enabled for both host and device mode.

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Message-ID: <20230517081907.3410465-3-xu.yang_2@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/usbmisc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 0938e274ba3a8..681c2ddc83fa5 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -135,7 +135,7 @@
 #define TXVREFTUNE0_MASK		(0xf << 20)
 
 #define MX6_USB_OTG_WAKEUP_BITS (MX6_BM_WAKEUP_ENABLE | MX6_BM_VBUS_WAKEUP | \
-				 MX6_BM_ID_WAKEUP)
+				 MX6_BM_ID_WAKEUP | MX6SX_BM_DPDM_WAKEUP_EN)
 
 struct usbmisc_ops {
 	/* It's called once when probe a usb device */
-- 
2.40.1



