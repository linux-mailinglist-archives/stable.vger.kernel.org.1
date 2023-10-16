Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B377CAC55
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjJPOxI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjJPOxI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:53:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B5EE1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:53:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FEAC433C8;
        Mon, 16 Oct 2023 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467985;
        bh=UKmnK/uNb3fQKfx/iYecWWEfZm8gt1cmAr3equP7GFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1M2ac45Q23uvUqGuTL6JOIoRhFfwwmibZAke0Yl982pThjmJbgM9opZPexJq5YQH
         N8chYbJzaSD2+VJes8GUFPIjQ2RRAU965Tqqri+8uX05P1WM86wYq/qHsnOf7gHkK1
         GHheYoEXO7d6DT5yuLgTme8dypLP519VPfeWFDFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.5 130/191] ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
Date:   Mon, 16 Oct 2023 10:41:55 +0200
Message-ID: <20231016084018.426672368@linuxfoundation.org>
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

commit cd4aece493f99f95d41edcce32927d70a5dde923 upstream.

Added GPE quirk entry for the HP Pavilion Gaming 15-dk1xxx.
There is a quirk entry for 2 15-c..... laptops, this is
for a new version which has 15-dk1xxx as identifier.

This fixes the LID switch and rfkill and brightness hotkeys
not working.

Closes: https://github.com/systemd/systemd/issues/28942
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/ec.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1915,6 +1915,17 @@ static const struct dmi_system_id ec_dmi
 	},
 	{
 		/*
+		 * HP Pavilion Gaming Laptop 15-dk1xxx
+		 * https://github.com/systemd/systemd/issues/28942
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
+		},
+	},
+	{
+		/*
 		 * Samsung hardware
 		 * https://bugzilla.kernel.org/show_bug.cgi?id=44161
 		 */


