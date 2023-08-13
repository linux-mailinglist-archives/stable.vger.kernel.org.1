Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130FB77AC64
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjHMVce (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjHMVce (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418F610D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB37B62BD7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F4CC433C8;
        Sun, 13 Aug 2023 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962355;
        bh=AD++ORNyjz2bKUq+L4GuxWMFiwpvHOr0hv8jMvm8/r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lb3PpaNWg0r9r0Xa/UktamT2ZDXm/Bt9x91vFSN0ipD4tvfY83zYcmAnTCZCTMHH1
         MvHzYfY9S2fLTjS4rvPj02dIu15Pa+Ly38ooB7A0n2P3ES++Etn47sGlHzDuhdiNQx
         sQQsfzxLYUI+L9lxmVsgt3F524i08zE/1kx03d8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.4 205/206] ACPI: scan: Create platform device for CS35L56
Date:   Sun, 13 Aug 2023 23:19:35 +0200
Message-ID: <20230813211730.866562740@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

commit 1cd0302be5645420f73090aee26fa787287e1096 upstream.

The ACPI device CSC3556 is a Cirrus Logic CS35L56 mono amplifier which
is used in multiples, and can be connected either to I2C or SPI.

There will be multiple instances under the same Device() node. Add it
to ignore_serial_bus_ids and handle it in the serial-multi-instantiate
driver.

There can be a 5th I2cSerialBusV2, but this is an alias address and doesn't
represent a real device. Ignore this by having a dummy 5th entry in the
serial-multi-instantiate instance list with the name of a non-existent
driver, on the same pattern as done for bsg2150.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20230728111345.7224-1-rf@opensource.cirrus.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/scan.c                             |    1 +
 drivers/platform/x86/serial-multi-instantiate.c |   14 ++++++++++++++
 2 files changed, 15 insertions(+)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1712,6 +1712,7 @@ static bool acpi_device_enumeration_by_p
 		{"BSG1160", },
 		{"BSG2150", },
 		{"CSC3551", },
+		{"CSC3556", },
 		{"INT33FE", },
 		{"INT3515", },
 		/* Non-conforming _HID for Cirrus Logic already released */
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -329,6 +329,19 @@ static const struct smi_node cs35l41_hda
 	.bus_type = SMI_AUTO_DETECT,
 };
 
+static const struct smi_node cs35l56_hda = {
+	.instances = {
+		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
+		/* a 5th entry is an alias address, not a real device */
+		{ "cs35l56-hda_dummy_dev" },
+		{}
+	},
+	.bus_type = SMI_AUTO_DETECT,
+};
+
 /*
  * Note new device-ids must also be added to ignore_serial_bus_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
@@ -337,6 +350,7 @@ static const struct acpi_device_id smi_a
 	{ "BSG1160", (unsigned long)&bsg1160_data },
 	{ "BSG2150", (unsigned long)&bsg2150_data },
 	{ "CSC3551", (unsigned long)&cs35l41_hda },
+	{ "CSC3556", (unsigned long)&cs35l56_hda },
 	{ "INT3515", (unsigned long)&int3515_data },
 	/* Non-conforming _HID for Cirrus Logic already released */
 	{ "CLSA0100", (unsigned long)&cs35l41_hda },


