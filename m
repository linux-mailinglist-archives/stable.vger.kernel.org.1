Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38506FA6CD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjEHKYU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjEHKXc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240A2739B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F30586258C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC524C433EF;
        Mon,  8 May 2023 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541402;
        bh=EBEywgEIhoeOxvsNWvtzN+uz/IExK8Z6aQeleH6WRII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZvk65EntRDL4gSfw9jdemp220ZFCpXF3SXbjDqpMJ5hYUft4Tjfxs+0K8qJ1+JJc
         m7P5ZHN4YNqN4fA1mQJaB8iNGPpHGeb70wcXM+3zK0lImMvTaysS81001pBPI41NaN
         Hxw2/uQ5HiLcJjLz/6UpBY0aChN062dyswhM98rU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=B5=D0=B2=20=D0=9F=D1=83=D1=82=D0=B8=D0=BD?= 
        <rockeraliexpress@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.2 096/663] ACPI: video: Remove acpi_backlight=video quirk for Lenovo ThinkPad W530
Date:   Mon,  8 May 2023 11:38:42 +0200
Message-Id: <20230508094431.571656454@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 3db66620ea90b0fd4134b31eabfec16d7b07d7e3 upstream.

Remove the acpi_backlight=video quirk for Lenovo ThinkPad W530.

This was intended to help users of the (unsupported) Nvidia binary driver,
but this has been reported to cause backlight control issues for users
who have the gfx configured in hybrid (dual-GPU) mode, so drop this.

The Nvidia binary driver should call acpi_video_register_backlight()
when necessary and this has been reported to Nvidia.

Until this is fixed Nvidia binary driver users can work around this by
passing "acpi_backlight=video" on the kernel commandline (with the latest
6.1.y or newer stable series, kernels < 6.1.y don't need this).

Fixes: a5b2781dcab2 ("ACPI: video: Add acpi_backlight=video quirk for Lenovo ThinkPad W530")
Reported-by: Русев Путин <rockeraliexpress@gmail.com>
Link: https://lore.kernel.org/linux-acpi/CAK4BXn0ngZRmzx1bodAF8nmYj0PWdUXzPGHofRrsyZj8MBpcVA@mail.gmail.com/
Cc: 6.1+ <stable@vger.kernel.org> # 6.1+
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/video_detect.c |   14 --------------
 1 file changed, 14 deletions(-)

--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -300,20 +300,6 @@ static const struct dmi_system_id video_
 	},
 
 	/*
-	 * Older models with nvidia GPU which need acpi_video backlight
-	 * control and where the old nvidia binary driver series does not
-	 * call acpi_video_register_backlight().
-	 */
-	{
-	 .callback = video_detect_force_video,
-	 /* ThinkPad W530 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W530"),
-		},
-	},
-
-	/*
 	 * These models have a working acpi_video backlight control, and using
 	 * native backlight causes a regression where backlight does not work
 	 * when userspace is not handling brightness key events. Disable


