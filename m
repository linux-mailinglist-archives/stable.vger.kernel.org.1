Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2876F169F
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjD1L24 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345600AbjD1L2x (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:28:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5372559E
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593F9642AA
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D7CC433D2;
        Fri, 28 Apr 2023 11:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681329;
        bh=Y+Fo34Td6DhsWkVcBD5Lba6ZMPueE1ag2Q8PkSL9kB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAAvEA35Qa/uIiSjS4NGTIF5rtj4bK2z4TQ0Hq0iK92CmE9X1g/LGYGyKjtyYLtnS
         BBXIujQlm7HR0ksu0PeCiaafz5E2Z8v01KVIZ4LV6+9kBNRJK+Yu5iEfJtL4zuI9se
         tlycRkuct/O1mjHS+HE2QxZuqwErmL+q5q5/TBiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Werner Sembach <wse@tuxedocomputers.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6.2 07/15] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU
Date:   Fri, 28 Apr 2023 13:27:51 +0200
Message-Id: <20230428112040.361262179@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
References: <20230428112040.137898986@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Werner Sembach <wse@tuxedocomputers.com>

commit 782eea0c89f7d071d6b56ecfa1b8b0c81164b9be upstream.

commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
changed the policy such that I2C touchpads may be able to wake up the
system by default if the system is configured as such.

However on Clevo NL5xNU there is a mistake in the ACPI tables that the
TP_ATTN# signal connected to GPIO 9 is configured as ActiveLow and level
triggered but connected to a pull up. As soon as the system suspends the
touchpad loses power and then the system wakes up.

To avoid this problem, introduce a quirk for this model that will prevent
the wakeup capability for being set for GPIO 9.

This patch is analoge to a very similar patch for NL5xRU, just the DMI
string changed.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-acpi.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1634,6 +1634,19 @@ static const struct dmi_system_id gpioli
 		 * https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
 		 */
 		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "ELAN0415:00@9",
+		},
+	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 1.7.8
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
+		 */
+		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
 		},
 		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {


