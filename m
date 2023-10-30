Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073787DC1A0
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 22:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjJ3VMG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 17:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3VMF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 17:12:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21152E1
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 14:12:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso38579195e9.2
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698700321; x=1699305121; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvJoZzGLRT55ve/LNovsbl9iWVtnHIcEs+oyaTJWAbk=;
        b=Ltqgo57tLSjNWBfZyKM8837WhGhGHBX7AvAATKuGkBuUYyYUg/HmpLp7sP24pd1d88
         JLOxVbCrBdWOq/HtHOUoE2JBq7+8TIqYLpQe0q79T+kKI2tvMTsNyAaY4LIiE5y1JDoM
         um1RqLdKxOl/cqOFOW7Koil9yVzJayic9ZTzkAEBBzhPs02/HRZ+d5yw4SF/Cn1tg1iZ
         240biHJzhLUpiyUCAP8OmfP1J6I+gLfgma9ChnvQDty7W30D4H9qEfQj06qOGdVyNX9P
         2pfpXMusFaITp9QMt5JF2BfpX+ICUBAsI8XrZVQqrz3IDLoVxaQWgzUH3tajq9UKqlOH
         WmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698700321; x=1699305121;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvJoZzGLRT55ve/LNovsbl9iWVtnHIcEs+oyaTJWAbk=;
        b=RU6y7Nmb2xDsL67hLuK60ys8q4wZWCD1jqjyg77ii7W5boOABZmEYyn/hFiUsjKlAv
         Gn9mXaY3Cg37QZKhtBcHuEh3J5qRGuDmSMbq/AZqSTP538Os8qGQ1IYrFL656SOQuj5H
         xpKVNCLoL1NPebSnyvZoBUKOCBsab2n6KAwdYSoCWVr4h+wQ+EM0wcdRXfSpHeUkvlMh
         n1eZVbPs1L2jaxkFKRjIsjTC1iEV9vzVffPDBz5Z36Hcfj1m8Vp1HgV/SKhYdPgiVfb3
         W2iNnP2qq1HtYDUQvBqCSIrcoRgWKoz4seGbFK++QfUcFynBT6339sHk+zkALvFGzqPg
         JL7g==
X-Gm-Message-State: AOJu0Yyr0Tsx9l21JSsE7APISMRCKwfL2YsbLVLWihC9QrMhgmJZ3Eil
        NbOqcQ9XjgpQRa7uLDUennY=
X-Google-Smtp-Source: AGHT+IH3P8eW0kky7EWlZ6qROrAbZ4VEdA6tz/czvKVkgMQIOZiePVvZGPeOZ25S1tevI1GfZkT6GQ==
X-Received: by 2002:a05:600c:19cc:b0:406:8494:f684 with SMTP id u12-20020a05600c19cc00b004068494f684mr8242359wmq.23.1698700321034;
        Mon, 30 Oct 2023 14:12:01 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id je9-20020a05600c1f8900b0040588d85b3asm277716wmb.15.2023.10.30.14.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:12:00 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id 87f9a45f;
        Mon, 30 Oct 2023 21:11:59 +0000 (UTC)
Date:   Mon, 30 Oct 2023 22:11:59 +0100
From:   David Lazar <dlazar@gmail.com>
To:     stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] platform/x86: Add s2idle quirk for more Lenovo laptops
Message-ID: <ZUAcHzdwjpXA8VSq@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 3bde7ec13c971445faade32172cb0b4370b841d9 upstream.

When suspending to idle and resuming on some Lenovo laptops using the
Mendocino APU, multiple NVME IOMMU page faults occur, showing up in
dmesg as repeated errors:

nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000b
address=0xb6674000 flags=0x0000]

The system is unstable afterwards.

Applying the s2idle quirk introduced by commit 455cd867b85b ("platform/x86:
thinkpad_acpi: Add a s2idle resume quirk for a number of laptops")
allows these systems to work with the IOMMU enabled and s2idle
resume to work.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218024
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: David Lazar <dlazar@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://lore.kernel.org/r/ZTlsyOaFucF2pWrL@localhost
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 73 ++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e7ece2738de9..3bb60687f2e4 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4513,6 +4513,79 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
 		}
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
+	{
+		.ident = "V14 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82YT"),
+		}
+	},
+	{
+		.ident = "V14 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83GE"),
+		}
+	},
+	{
+		.ident = "V15 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82YU"),
+		}
+	},
+	{
+		.ident = "V15 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83CQ"),
+		}
+	},
+	{
+		.ident = "IdeaPad 1 14AMN7",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82VF"),
+		}
+	},
+	{
+		.ident = "IdeaPad 1 15AMN7",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82VG"),
+		}
+	},
+	{
+		.ident = "IdeaPad 1 15AMN7",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82X5"),
+		}
+	},
+	{
+		.ident = "IdeaPad Slim 3 14AMN8",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82XN"),
+		}
+	},
+	{
+		.ident = "IdeaPad Slim 3 15AMN8",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
+		}
+	},
 	{}
 };
 
-- 
2.39.2

