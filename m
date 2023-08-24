Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F579787252
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbjHXOwb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbjHXOwX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:52:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE33A1
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E95506574E
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031BFC433C8;
        Thu, 24 Aug 2023 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888741;
        bh=5612J5t2h9QIHiXc1izaY/Cq5xWKezMWcpkqLJ38ixU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqbBOCMx5oqE1gVC+mO919rBU9M7G7tViK22iniOIVQqBW4zu1rBZoNOrJa498xzC
         l9Ps7TVJIA4mzn3vhUoqdyVsX3ii7MtR/JECSvFDSLJbL5ntk2SDCQCLjf+dfuRCn0
         zgCsL67Fyao3FabXQDr1jrJ0JqDyHxXm4PRab0L4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Jun <jun.li@nxp.com>,
        Xu Yang <xu.yang_2@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 025/139] usb: chipidea: imx: add missing USB PHY DPDM wakeup setting
Date:   Thu, 24 Aug 2023 16:49:08 +0200
Message-ID: <20230824145024.680145361@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index bac0f5458cab9..2318c7906acdb 100644
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



