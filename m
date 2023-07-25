Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2476172C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGYLpm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjGYLpl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BACA0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C9661698
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1951C433C8;
        Tue, 25 Jul 2023 11:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285540;
        bh=vWHef46qcdlYOvGvS13EIIo48y9FXxw+UjZebpaZVbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ymgi0x6wjOOEn+Ys4E+z7F+mE90CfQ+G+DDV5Q5xksrhGA2JsGhrayhclFGSY2mAH
         gs1L5hMxbon7KYiqaFLM9t8tCeBciiukRNvBsKzWvwkbbiOuDf3hM9liDJNvHPp66u
         8OyOBodoL6srSITcVuS/+zOr1QOAafqmIcyD1Tzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Zary <linux@zary.sk>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.4 241/313] PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold
Date:   Tue, 25 Jul 2023 12:46:34 +0200
Message-ID: <20230725104531.497788256@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
@@ -2617,13 +2617,13 @@ static const struct dmi_system_id bridge
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


