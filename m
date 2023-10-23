Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239F97D3349
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjJWL2r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjJWL2q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:28:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7396AA4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:28:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA15C433C8;
        Mon, 23 Oct 2023 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060523;
        bh=s8uOf2P0sSgCtR+UaOdVxNeR/YOakIZ25/q5DLTSIKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEdtGyndOeETg8NA6g88bmvTqg+12BsgQkCM/JP/jSNyP4dDvOQAC5AsOe6hOW4LY
         VIbFY8uULkjV393MzxBOlOMFXNniH4bcm3dYvqivBRxjsSxHjOErg8VILRplCvYf7E
         wHEPcVJuoDrblSpdHa6tpFvSi0AjLI5dUupFMy1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, James John <me@donjajo.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.1 174/196] platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e
Date:   Mon, 23 Oct 2023 12:57:19 +0200
Message-ID: <20231023104833.333810234@linuxfoundation.org>
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

commit f37cc2fc277b371fc491890afb7d8a26e36bb3a1 upstream.

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

Before this commit all the NOTIFY_BRNDOWN_MIN - NOTIFY_BRNDOWN_MAX
aka 0x20 - 0x2e events were mapped to 0x20.

This mapping is causing issues on new laptop models which actually
send 0x2b events for printscreen presses and 0x2c events for
capslock presses, which get translated into spurious brightness-down
presses.

The plan is disable the 0x11-0x2e special mapping on laptops
where asus-wmi does not register a backlight-device to avoid
the spurious brightness-down keypresses. New laptops always send
0x2e for brightness-down presses, change the special internal
ASUS_WMI_BRN_DOWN value from 0x20 to 0x2e to match this in
preparation for fixing the spurious brightness-down presses.

This change does not have any functional impact since all
of 0x20 - 0x2e is mapped to ASUS_WMI_BRN_DOWN first and only
then checked against the keymap code and the new 0x2e
value is still in the 0x20 - 0x2e range.

Reported-by: James John <me@donjajo.com>
Closes: https://lore.kernel.org/platform-driver-x86/a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com/
Closes: https://bbs.archlinux.org/viewtopic.php?pid=2123716
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231017090725.38163-2-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-wmi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -18,7 +18,7 @@
 #include <linux/i8042.h>
 
 #define ASUS_WMI_KEY_IGNORE (-1)
-#define ASUS_WMI_BRN_DOWN	0x20
+#define ASUS_WMI_BRN_DOWN	0x2e
 #define ASUS_WMI_BRN_UP		0x2f
 
 struct module;


