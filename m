Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1732A77ABEC
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjHMV1P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjHMV1P (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED510D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA607629DF
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B720C433C7;
        Sun, 13 Aug 2023 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962036;
        bh=cnmWMrRr6lUCBR/pIbwAV2ET9T95iL1Fg41LRw2lKCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYRKRwvt8cRvTXBkwYg9F7s/fsthuWLPw6+KhpMLH5D0onVbAS5lTrEiwzTPhT3zh
         uP36Rcz9PR2GYalxfHZTqvjfxsDuJyZcwuByjIwMYybeT791X4K9zrlAJoJ2YRs0wQ
         /cKwCobmsfO9qtrw8bSVysm3mYvXjQ76cbz2be2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.4 088/206] Revert "PCI: mvebu: Mark driver as BROKEN"
Date:   Sun, 13 Aug 2023 23:17:38 +0200
Message-ID: <20230813211727.596879822@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

commit 3bfc37d92687b4b19056998cebc02f94fbc81427 upstream.

b3574f579ece ("PCI: mvebu: Mark driver as BROKEN") made it impossible to
enable the pci-mvebu driver.  The driver does have known problems, but as
Russell and Uwe reported, it does work in some configurations, so removing
it broke some working setups.

Revert b3574f579ece so pci-mvebu is available.

Reported-by: Russell King (Oracle) <linux@armlinux.org.uk>
Link: https://lore.kernel.org/r/ZMzicVQEyHyZzBOc@shell.armlinux.org.uk
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230804134622.pmbymxtzxj2yfhri@pengutronix.de
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -179,7 +179,6 @@ config PCI_MVEBU
 	depends on MVEBU_MBUS
 	depends on ARM
 	depends on OF
-	depends on BROKEN
 	select PCI_BRIDGE_EMUL
 	help
 	 Add support for Marvell EBU PCIe controller. This PCIe controller


