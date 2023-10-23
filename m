Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A007D31D2
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjJWLNi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjJWLNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:13:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E2A2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:13:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1814C433C9;
        Mon, 23 Oct 2023 11:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059616;
        bh=i9nYo0Cd04okGJltlTlA6W01bVJlnQ5WxU3c/K3qh/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ls/mDQ81sQR/Xu+LxWS4X8RAEmaEPCQCn+wN9Bc7C/ByXzimPVK6Tyn62Jh6YwtIG
         AGmLhQEXP8WAkhMFrN2rHhBMLFAB0KYjxeQVfBkd/gxu4tIiANs7aV4KmWHUcuZ9+6
         9tttVCH0MEBQzmBnwepsVEWrLW33PUHcVg19rORo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, James John <me@donjajo.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.5 210/241] platform/x86: asus-wmi: Map 0x2a code, Ignore 0x2b and 0x2c events
Date:   Mon, 23 Oct 2023 12:56:36 +0200
Message-ID: <20231023104838.969666248@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 235985d1763f7aba92c1c64e5f5aaec26c2c9b18 upstream.

Newer Asus laptops send the following new WMI event codes when some
of the F1 - F12 "media" hotkeys are pressed:

0x2a Screen Capture
0x2b PrintScreen
0x2c CapsLock

Map 0x2a to KEY_SELECTIVE_SCREENSHOT mirroring how similar hotkeys
are mapped on other laptops.

PrintScreem and CapsLock are also reported as normal PS/2 keyboard events,
map these event codes to KE_IGNORE to avoid "Unknown key code 0x%x\n" log
messages.

Reported-by: James John <me@donjajo.com>
Closes: https://lore.kernel.org/platform-driver-x86/a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com/
Closes: https://bbs.archlinux.org/viewtopic.php?pid=2123716
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231017090725.38163-4-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-nb-wmi.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -531,6 +531,9 @@ static void asus_nb_wmi_quirks(struct as
 static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, ASUS_WMI_BRN_DOWN, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY, ASUS_WMI_BRN_UP, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x2a, { KEY_SELECTIVE_SCREENSHOT } },
+	{ KE_IGNORE, 0x2b, }, /* PrintScreen (also send via PS/2) on newer models */
+	{ KE_IGNORE, 0x2c, }, /* CapsLock (also send via PS/2) on newer models */
 	{ KE_KEY, 0x30, { KEY_VOLUMEUP } },
 	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
 	{ KE_KEY, 0x32, { KEY_MUTE } },


