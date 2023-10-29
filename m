Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173767DADA1
	for <lists+stable@lfdr.de>; Sun, 29 Oct 2023 19:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJ2SUp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 29 Oct 2023 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2SUo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 29 Oct 2023 14:20:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E705ABA
        for <stable@vger.kernel.org>; Sun, 29 Oct 2023 11:20:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso27711445e9.3
        for <stable@vger.kernel.org>; Sun, 29 Oct 2023 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698603640; x=1699208440; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfR9Kvf6lEJ0cV0duwdVPHtXF/iMGKpF7rzmdfSzJKg=;
        b=jH0jcWbNaLU7/nuErcbYmTXaRIpygjkyuawiVqnZDX4MIFPOSx1GW7hcRchFeNIHKB
         Zv0vzsE+kdFUrFwZ51ILiAV7DwsHWM7rAlVDisYkECkk0xXHxuZPRLF4TjIdBoSzHUKl
         EhWH3XcLssYVtCltCw2z6bA6g+uH6lVuFmOK0UrfWa1kBJGqZQ1ekZ5s5TeSdXH3RPxF
         CbUAHsGRk40ElovmET4yuQ8qlocT2+dsT8DGNogFG+Obea94YRhWDFe3fq9lBayg88z3
         7fvXiRzO5+EqN58S/5JJu+dqduP3iDQhig0OwS7nm0Rvdg0V5UC749Eh4FXgHw29RFbi
         XqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698603640; x=1699208440;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfR9Kvf6lEJ0cV0duwdVPHtXF/iMGKpF7rzmdfSzJKg=;
        b=wn2xySI90FdJ3Hkz1l16mnkBjPL/yqwqxzjSwNk0UL4yEe+27e51VYogPBuIv/XCK3
         8gO0D5zfYrpFXhhKqrxZ/zRcNnc4DAUlOal/D1QuuwCQMoIfhnQFbSdlk0ttiIHSd/2x
         ITLfY23sz/NcFo/3ApUXbYDIDn/7QZKOuZ+T9xX/cQLhU1S3EiyfuloUTbGgJR/GEf/G
         ePd/WKRVtnuNOQlB9Nt0JpZwlQqGQFk2oVc0KXPYWzwJBl505k0j94HgZgiUZ7ZLMdW+
         Wyi8GsniI0Ncbd7Re3czY+DPD7H4sdjzARY76kOFOKWUzN2OLX0vavISwXau34Sbxedb
         ST7A==
X-Gm-Message-State: AOJu0YwY/E9/xRnncW+XcenK+VK0Quaypiul5mwCazwo+XRpBEoIUv9v
        EeNTHKSf/hCkr9bVBhuWwiUabr/tXfgXdA==
X-Google-Smtp-Source: AGHT+IHf9dGlnsWnrGmj7o0tnZZI+EDU8Utze1IGOFbMaSP6PjxDp0eiAdbBwYfRcamMIwtDygKnRw==
X-Received: by 2002:a05:600c:1f8d:b0:408:fc62:f839 with SMTP id je13-20020a05600c1f8d00b00408fc62f839mr6837608wmb.37.1698603639895;
        Sun, 29 Oct 2023 11:20:39 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b00407460234f9sm7108875wmo.21.2023.10.29.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 11:20:39 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id 14b39f7f;
        Sun, 29 Oct 2023 18:20:38 +0000 (UTC)
Date:   Sun, 29 Oct 2023 19:20:38 +0100
From:   David Lazar <dlazar@gmail.com>
To:     stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [PATCH] platform/x86: Add s2idle quirk for more Lenovo laptops
Message-ID: <ZT6idniuWk88GxOm@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index ad702463a65d3..6bbffb081053e 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
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
cgit 

