Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3675D483
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGUTV4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjGUTVy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68982737
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A65161D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAB5C433C8;
        Fri, 21 Jul 2023 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967312;
        bh=7AnW+SNhO19fMj5FQQ7Vyg1th5qgAErJxuk1MGOTc8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2jkDAscMZfAvQS5d/zP34q3dbx5E/MhS3TOgclTg48u76GMkbdYKQQngb6mMH9im9
         Gpxm2XkqYcrKOAfjwumTN4pr9FwSIQq7hufAYNSae1v6IZfd5CmaT7DOD55tlHwQxS
         yDYjiVglHX5vpiwR2JaN8N383pPvgsxHAytziaiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Zary <linux@zary.sk>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.1 119/223] PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold
Date:   Fri, 21 Jul 2023 18:06:12 +0200
Message-ID: <20230721160525.950346158@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ondrej Zary <linux@zary.sk>

commit 9e30fd26f43b89cb6b4e850a86caa2e50dedb454 upstream.

The quirk for Elo i2 introduced in commit 92597f97a40b ("PCI/PM: Avoid
putting Elo i2 PCIe Ports in D3cold") is also needed by EloPOS E2/S2/H2
which uses the same Continental Z2 board.

Change the quirk to match the board instead of system.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215715
Link: https://lore.kernel.org/r/20230614074253.22318-1-linux@zary.sk
Signed-off-by: Ondrej Zary <linux@zary.sk>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2942,13 +2942,13 @@ static const struct dmi_system_id bridge
 	{
 		/*
 		 * Downstream device is not accessible after putting a root port
-		 * into D3cold and back into D0 on Elo i2.
+		 * into D3cold and back into D0 on Elo Continental Z2 board
 		 */
-		.ident = "Elo i2",
+		.ident = "Elo Continental Z2",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Elo Touch Solutions"),
+			DMI_MATCH(DMI_BOARD_NAME, "Geminilake"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
 		},
 	},
 #endif


