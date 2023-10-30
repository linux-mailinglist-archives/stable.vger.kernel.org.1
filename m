Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006CD7DC1A6
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 22:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjJ3VMx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjJ3VMu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 17:12:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E0CFF
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 14:12:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso3417569f8f.1
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698700365; x=1699305165; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/I+X/B63T+oF6UPcAkaMKmrheHjFXxqUYC86bQ684GU=;
        b=BW9x8OYjtmrCgQURYL2y8nAUFQ7w/abLLn8jHSMmsxBCcOSuDZQpBMUKsPtRgD8yIU
         +fcIJJ1wW3RBVdzSnCgWngJl9BSb/iHcZzM300JWM3FtWomE+JEsIU2P+zNXkqmABNkR
         mjujGrp+0nzIJkHJNzMgip6vYM7+pvmcy+LBPOJUiAuYs59GnqO55/42A3dJbC6Zeftt
         G+MOznrVMBQHLsiV+otr/H+TWEDpFZPSQDmip9ijTIQxRh5C7Pf33Yo+YegCDjqsnn3m
         QsjsL+rm1HeSU2aj+njteQy3LLgx0Nau1q+AVlen82lVbIAlb8kzeTM31ZmaM93fPUAP
         WdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698700365; x=1699305165;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/I+X/B63T+oF6UPcAkaMKmrheHjFXxqUYC86bQ684GU=;
        b=CMiZSBpltg4DVcUvkTE2lQ/Qw1kQ2yKE1r312j9UT2GUwwp54ghC8WmfIX/uAv9d2Z
         o6J8ZXRhzjfoAnyY6n+Fm8OTsOFWq1CZSb5ryzfgHcbnJgN5M+t26Dvxiv042fpV9+xY
         ESuzGZ9nFi2NeGj1RpHij5+8JbCX8iFLvG48PZgg58sgtkSirlvTVqY58Qv1EzaoM8vY
         EzbrM3X0SQUlyHcSj05G7upjYhNgyaxYRw+3l195MgUURsRe5t8gw2R91JJw7dAM9n6b
         5SUyJlW6aeJ1BtPBCq4ioDdsG/px3MWBlbXM5ujsZrlMCzLydKHatZcGeOL8+FvR3q0C
         cSSg==
X-Gm-Message-State: AOJu0YwepXX1Y2gdMaY16hwjI+si4aSXBp6PpZzT7uTaVymFHf1IrERm
        UAkqYtURDwzkHmra5MuNIrcy0XWO2X6XuQ==
X-Google-Smtp-Source: AGHT+IG7TCZuOF97Ot781E9/99Ig1jIQBZnlR3+XlTljzyz7IjmZLbgxbYtiISY8OWFwzPxuWGxkdg==
X-Received: by 2002:a5d:4dca:0:b0:32d:8c6d:cda4 with SMTP id f10-20020a5d4dca000000b0032d8c6dcda4mr7951427wru.43.1698700365133;
        Mon, 30 Oct 2023 14:12:45 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d5487000000b0032f7cc56509sm6325320wrv.98.2023.10.30.14.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:12:44 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id 83149b21;
        Mon, 30 Oct 2023 21:12:44 +0000 (UTC)
Date:   Mon, 30 Oct 2023 22:12:44 +0100
From:   David Lazar <dlazar@gmail.com>
To:     stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 6.5.y] platform/x86: Add s2idle quirk for more Lenovo laptops
Message-ID: <ZUAcTIClmzL2admd@localhost>
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
 drivers/platform/x86/amd/pmc-quirks.c | 73 +++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc-quirks.c b/drivers/platform/x86/amd/pmc-quirks.c
index ad702463a65d..6bbffb081053 100644
--- a/drivers/platform/x86/amd/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc-quirks.c
@@ -111,6 +111,79 @@ static const struct dmi_system_id fwbug_list[] = {
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
 	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
 	{
 		.ident = "HP Laptop 15s-eq2xxx",
-- 
2.39.2

