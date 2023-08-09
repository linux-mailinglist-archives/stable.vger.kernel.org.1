Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B303A775C9B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjHIL3H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjHIL3G (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954A10D4
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FC7F63308
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD70C433C7;
        Wed,  9 Aug 2023 11:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580544;
        bh=I1ZA1uOv1I3PlwNgBWA82bgA6l6BnFZ/xC4d1IHHxtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDFDArCwuKboLwH1hdqJakltVabWejJcJWrD1a8zKBwzGXIh2d4QjsLdM48dK9560
         JMjtzxkMzgKzx17KXW9sgVh+c+r3HHG3+fHGhKZMH9Cmz4PLIqmWbnxNsUe3XCawUD
         tfhlM5vkxQCMT+Ps3bzLkol32eFikCrrrEZnjWI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5.4 063/154] usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy
Date:   Wed,  9 Aug 2023 12:41:34 +0200
Message-ID: <20230809103639.082448802@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gratian Crisan <gratian.crisan@ni.com>

commit b32b8f2b9542d8039f5468303a6ca78c1b5611a5 upstream.

Hardware based on the Bay Trail / BYT SoCs require an external ULPI phy for
USB device-mode. The phy chip usually has its 'reset' and 'chip select'
lines connected to GPIOs described by ACPI fwnodes in the DSDT table.

Because of hardware with missing ACPI resources for the 'reset' and 'chip
select' GPIOs commit 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table
on platforms without ACPI GPIO resources") introduced a fallback
gpiod_lookup_table with hard-coded mappings for Bay Trail devices.

However there are existing Bay Trail based devices, like the National
Instruments cRIO-903x series, where the phy chip has its 'reset' and
'chip-select' lines always asserted in hardware via resistor pull-ups. On
this hardware the phy chip is always enabled and the ACPI dsdt table is
missing information not only for the 'chip-select' and 'reset' lines but
also for the BYT GPIO controller itself "INT33FC".

With the introduction of the gpiod_lookup_table initializing the USB
device-mode on these hardware now errors out. The error comes from the
gpiod_get_optional() calls in dwc3_pci_quirks() which will now return an
-ENOENT error due to the missing ACPI entry for the INT33FC gpio controller
used in the aforementioned table.

This hardware used to work before because gpiod_get_optional() will return
NULL instead of -ENOENT if no GPIO has been assigned to the requested
function. The dwc3_pci_quirks() code for setting the 'cs' and 'reset' GPIOs
was then skipped (due to the NULL return). This is the correct behavior in
cases where the phy chip is hardwired and there are no GPIOs to control.

Since the gpiod_lookup_table relies on the presence of INT33FC fwnode
in ACPI tables only add the table if we know the entry for the INT33FC
gpio controller is present. This allows Bay Trail based devices with
hardwired dwc3 ULPI phys to continue working.

Fixes: 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table on platforms without ACPI GPIO resources")
Cc: stable <stable@kernel.org>
Signed-off-by: Gratian Crisan <gratian.crisan@ni.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230726184555.218091-2-gratian.crisan@ni.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-pci.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -171,10 +171,12 @@ static int dwc3_pci_quirks(struct dwc3_p
 
 			/*
 			 * A lot of BYT devices lack ACPI resource entries for
-			 * the GPIOs, add a fallback mapping to the reference
+			 * the GPIOs. If the ACPI entry for the GPIO controller
+			 * is present add a fallback mapping to the reference
 			 * design GPIOs which all boards seem to use.
 			 */
-			gpiod_add_lookup_table(&platform_bytcr_gpios);
+			if (acpi_dev_present("INT33FC", NULL, -1))
+				gpiod_add_lookup_table(&platform_bytcr_gpios);
 
 			/*
 			 * These GPIOs will turn on the USB2 PHY. Note that we have to


