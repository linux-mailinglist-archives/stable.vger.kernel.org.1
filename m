Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F79070C709
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjEVTZL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjEVTZK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:25:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE94FDC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:25:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4251162887
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7C9C433EF;
        Mon, 22 May 2023 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783506;
        bh=D+wuOHg6R7CJWY3bYojxWdGcJZwwjiNX5wonRIceHJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JD1H7canhkXTC2r0mF6K0ILwIA7j+rBw9/jwX2bSamLsavBbG9qtYnworyx9sq7/a
         htQY9IDnQ0iYQNzRaIOYC9wHHOv3OgrQ0GBAqnoXn+Mp5YdcByeoQPSJop922LDAAN
         shFpvFSZ6y2O3Wofd/2BxZpXy2UxZza1iQTJvzvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/292] ACPI: video: Remove desktops without backlight DMI quirks
Date:   Mon, 22 May 2023 20:07:04 +0100
Message-Id: <20230522190407.634819135@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit abe4f5ae5efa6a63c7d5abfa07eb02bb56b4654e ]

After the recent backlight changes acpi_video# backlight devices are only
registered when explicitly requested from the cmdline, by DMI quirk or by
the GPU driver.

This means that we no longer get false-positive backlight control support
advertised on desktop boards.

Remove the 3 DMI quirks for desktop boards where the false-positive issue
was fixed through quirks before. Note many more desktop boards were
affected but we never build a full quirk list for this.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0556c4720d3fa..b6d429a2bcb62 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -130,12 +130,6 @@ static int video_detect_force_native(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int video_detect_force_none(const struct dmi_system_id *d)
-{
-	acpi_backlight_dmi = acpi_backlight_none;
-	return 0;
-}
-
 static const struct dmi_system_id video_detect_dmi_table[] = {
 	/*
 	 * Models which should use the vendor backlight interface,
@@ -752,35 +746,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
 		},
 	},
-
-	/*
-	 * Desktops which falsely report a backlight and which our heuristics
-	 * for this do not catch.
-	 */
-	{
-	 .callback = video_detect_force_none,
-	 /* Dell OptiPlex 9020M */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M"),
-		},
-	},
-	{
-	 .callback = video_detect_force_none,
-	 /* GIGABYTE GB-BXBT-2807 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
-		},
-	},
-	{
-	 .callback = video_detect_force_none,
-	 /* MSI MS-7721 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "MSI"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "MS-7721"),
-		},
-	},
 	{ },
 };
 
-- 
2.39.2



