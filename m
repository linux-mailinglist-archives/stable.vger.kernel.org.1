Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A9F7D334B
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjJWL3C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjJWL2u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:28:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA19FD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:28:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EF2C433C7;
        Mon, 23 Oct 2023 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060526;
        bh=dpP/IQm3plsrRAUyocUXqePt+Q3nLaKaSeFnRfI1mOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2smEE/6rc9emHkI3bFZhj2xTsvqk6KyzmcGusVC2fqpcMl+VR6SMaYD1TN8u/uCf
         t/YCc4QohKuaRmI0VbYeHXz08Sc2Dg3W37Cqex2Rx6vJcWAYf5rzPDlS0GRCMXgAJA
         UY9/bYC4szF0Oa83tf4xFU0fruL8u3puDYK0vkO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, James John <me@donjajo.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.1 175/196] platform/x86: asus-wmi: Only map brightness codes when using asus-wmi backlight control
Date:   Mon, 23 Oct 2023 12:57:20 +0200
Message-ID: <20231023104833.358933166@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit a5b92be2482e5f9ef30be4e4cda12ed484381493 upstream.

Older Asus laptops change the backlight level themselves and then send
WMI events with different codes for different backlight levels.

The asus-wmi.c code maps the entire range of codes reported on
brightness down keypresses to an internal ASUS_WMI_BRN_DOWN code:

define NOTIFY_BRNUP_MIN                0x11
define NOTIFY_BRNUP_MAX                0x1f
define NOTIFY_BRNDOWN_MIN              0x20
define NOTIFY_BRNDOWN_MAX              0x2e

        if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
                code = ASUS_WMI_BRN_UP;
        else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
                code = ASUS_WMI_BRN_DOWN;

This mapping is causing issues on new laptop models which actually
send 0x2b events for printscreen presses and 0x2c events for
capslock presses, which get translated into spurious brightness-down
presses.

This mapping is really only necessary when asus-wmi has registered
a backlight-device for backlight control. In this case the mapping
was used to decide to filter out the keypresss since in this case
the firmware has already modified the brightness itself and instead
of reporting a keypress asus-wmi will just report the new brightness
value to userspace.

OTOH when the firmware does not adjust the brightness itself then
it seems to always report 0x2e for brightness-down presses and
0x2f for brightness up presses independent of the actual brightness
level. So in this case the mapping of the code is not necessary
and this translation actually leads to spurious brightness-down
presses being send to userspace when pressing printscreen or capslock.

Modify asus_wmi_handle_event_code() to only do the mapping
when using asus-wmi backlight control to fix the spurious
brightness-down presses.

Reported-by: James John <me@donjajo.com>
Closes: https://lore.kernel.org/platform-driver-x86/a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com/
Closes: https://bbs.archlinux.org/viewtopic.php?pid=2123716
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231017090725.38163-3-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-wmi.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3268,7 +3268,6 @@ static void asus_wmi_handle_event_code(i
 {
 	unsigned int key_value = 1;
 	bool autorelease = 1;
-	int orig_code = code;
 
 	if (asus->driver->key_filter) {
 		asus->driver->key_filter(asus->driver, &code, &key_value,
@@ -3277,16 +3276,10 @@ static void asus_wmi_handle_event_code(i
 			return;
 	}
 
-	if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
-		code = ASUS_WMI_BRN_UP;
-	else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
-		code = ASUS_WMI_BRN_DOWN;
-
-	if (code == ASUS_WMI_BRN_DOWN || code == ASUS_WMI_BRN_UP) {
-		if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
-			asus_wmi_backlight_notify(asus, orig_code);
-			return;
-		}
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor &&
+	    code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNDOWN_MAX) {
+		asus_wmi_backlight_notify(asus, code);
+		return;
 	}
 
 	if (code == NOTIFY_KBD_BRTUP) {


