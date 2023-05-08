Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFF26FA404
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjEHJyN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjEHJyM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9E22570A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1BAE62205
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC5AC433D2;
        Mon,  8 May 2023 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539650;
        bh=NUsg0qTTG17tYwUPffK1+qmPCrAKq7y61c41EGvwBEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnzUjIzB+mesdnH1dVoP7XYVNap/r82xUBIM2puNLC+odiO97+tQxF/0IjKQ9ir3K
         etyNOCC5oQgwJTb0ZaULcdS6mrJm6oiewo99nAZNSsl/N0eKA3JHMw4zM7C+omVGrx
         CadKsg4oK7JOpu2mwU20WQ/gpGuAwhkbtoIMNvK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=B5=D0=B2=20=D0=9F=D1=83=D1=82=D0=B8=D0=BD?= 
        <rockeraliexpress@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.1 093/611] ACPI: video: Remove acpi_backlight=video quirk for Lenovo ThinkPad W530
Date:   Mon,  8 May 2023 11:38:55 +0200
Message-Id: <20230508094425.217150065@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
@@ -298,20 +298,6 @@ static const struct dmi_system_id video_
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


