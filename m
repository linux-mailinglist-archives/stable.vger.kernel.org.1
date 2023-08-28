Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2229978AA44
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjH1KUk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjH1KUV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB660C6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9919A6371C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A837CC433C9;
        Mon, 28 Aug 2023 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217997;
        bh=ywdPzCE0ZNRyUCFX8q80cS0BMHCWtj9qrg4wmO3hR7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pIfsEdFeLi+EW73dx0xIVUT4RnTNAVitbgzDzjLWZxEx3NWOt20iYRx7eEOBtpAqG
         wFgue8+EKdSlzTjjePRKrzhGYOdDOxCKygqva5AveR5vDtGGxixFfgnm2oX0vxJQ6j
         ffHvZQkoGQdZ04bZUDHQbcirmWAI0gUqYrrwKTj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.4 057/129] platform/x86: ideapad-laptop: Add support for new hotkeys found on ThinkBook 14s Yoga ITL
Date:   Mon, 28 Aug 2023 12:12:16 +0200
Message-ID: <20230828101159.262251768@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: André Apitzsch <git@apitzsch.eu>

commit a260f7d726fde52c0278bd3fa085a758639bcee2 upstream.

The Lenovo Thinkbook 14s Yoga ITL has 4 new symbols/shortcuts on their
F9-F11 and PrtSc keys:

F9:    Has a symbol of a head with a headset, the manual says "Service key"
F10:   Has a symbol of a telephone horn which has been picked up from the
       receiver, the manual says: "Answer incoming calls"
F11:   Has a symbol of a telephone horn which is resting on the receiver,
       the manual says: "Reject incoming calls"
PrtSc: Has a symbol of a siccor and a dashed ellipse, the manual says:
       "Open the Windows 'Snipping' Tool app"

This commit adds support for these 4 new hkey events.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
Link: https://lore.kernel.org/r/20230819-lenovo_keys-v1-1-9d34eac88e0a@apitzsch.eu
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/ideapad-laptop.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1049,6 +1049,11 @@ static const struct key_entry ideapad_ke
 	{ KE_IGNORE,	0x03 | IDEAPAD_WMI_KEY },
 	/* Customizable Lenovo Hotkey ("star" with 'S' inside) */
 	{ KE_KEY,	0x01 | IDEAPAD_WMI_KEY, { KEY_FAVORITES } },
+	{ KE_KEY,	0x04 | IDEAPAD_WMI_KEY, { KEY_SELECTIVE_SCREENSHOT } },
+	/* Lenovo Support */
+	{ KE_KEY,	0x07 | IDEAPAD_WMI_KEY, { KEY_HELP } },
+	{ KE_KEY,	0x0e | IDEAPAD_WMI_KEY, { KEY_PICKUP_PHONE } },
+	{ KE_KEY,	0x0f | IDEAPAD_WMI_KEY, { KEY_HANGUP_PHONE } },
 	/* Dark mode toggle */
 	{ KE_KEY,	0x13 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
 	/* Sound profile switch */


