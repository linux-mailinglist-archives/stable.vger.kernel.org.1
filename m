Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E075C7CAC54
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjJPOxG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjJPOxF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:53:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6BFEA
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:53:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DBEC433CA;
        Mon, 16 Oct 2023 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467982;
        bh=ntXIrIE9xM7iP5NcwMGnO879NJLJtajHki+Ai30s/o0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahxtx7Th2hpPRBBz7qT65TLJRB4XDpqcAvsKxt5FU+ZamX3L3BPEDxaCnHKFp/2pi
         DC/HAhUIYE4/FI5N14T2Iwy+Esi6tgFEIeeKx2mK4hs0z8YRDoiDB3zFxijut2COtB
         scKoMJFMELh9kr18ZQsjCfHBX7vDG2Ba4yHYVTTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, August Wikerfors <git@augustwikerfors.se>,
        Francesco <f.littarru@outlook.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.5 129/191] ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q to irq1_edge_low_force_override[]
Date:   Mon, 16 Oct 2023 10:41:54 +0200
Message-ID: <20231016084018.403899701@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit f9b3ea02555e67e2e7bf95219953b88d122bd275 upstream.

The TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q are 3 GPU variants of a TongFang
barebone design which is sold under various brand names.

The ACPI IRQ override for the keyboard IRQ must be used on these AMD Zen
laptops in order for the IRQ to work.

Adjust the pcspecialist_laptop[] DMI match table for this:

1. Drop the sys-vendor match from the existing PCSpecialist Elimina Pro 16
   entry for the GM6BGEQ (RTX3050 GPU) model so that it will also match
   the laptop when sold by other vendors such as hyperbook.pl.

2. Add board-name matches for the GM6BG5Q (RTX4050) and GM6B0Q (RTX4060)
   models.

Note the .ident values of the dmi_system_id structs are left unset
since these are not used.

Suggested-by: August Wikerfors <git@augustwikerfors.se>
Reported-by: Francesco <f.littarru@outlook.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://laptopparts4less.frl/index.php?route=product/search&filter_name=GM6BG
Link: https://hyperbook.pl/en/content/14-hyperbook-drivers
Link: https://linux-hardware.org/?probe=bfa70344e3
Link: https://bbs.archlinuxcn.org/viewtopic.php?id=13313
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -507,16 +507,23 @@ static const struct dmi_system_id mainge
 
 static const struct dmi_system_id pcspecialist_laptop[] = {
 	{
-		.ident = "PCSpecialist Elimina Pro 16 M",
-		/*
-		 * Some models have product-name "Elimina Pro 16 M",
-		 * others "GM6BGEQ". Match on board-name to match both.
-		 */
+		/* TongFang GM6BGEQ / PCSpecialist Elimina Pro 16 M, RTX 3050 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
 			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
 		},
 	},
+	{
+		/* TongFang GM6BG5Q, RTX 4050 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG5Q"),
+		},
+	},
+	{
+		/* TongFang GM6BG0Q / PCSpecialist Elimina Pro 16 M, RTX 4060 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
+		},
+	},
 	{ }
 };
 


