Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76E7832F8
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjHUT5M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjHUT5M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A654D3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A327C6464D
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F15C433C8;
        Mon, 21 Aug 2023 19:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647828;
        bh=w20upPI+GRTnehckrJ+6LEogiLyn7qQz5dnJ9dmFY0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9VE5q4IiN5E+Pj9oaLefyQa++MydGFB59heZ3Xar0szUeHjw5NAE6l/yx69tEEPg
         dFQepyBjlsUY41DhXX+jH3d0hdLHYOgvZjKsOljMSplT55eNyGbi0Z2fPk5f5R6TwX
         o8NTfKp3y0op4qrq5f22fkmA3v9qEMgm6apUklSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, dengxiang <dengxiang@nfschina.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 152/194] ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.
Date:   Mon, 21 Aug 2023 21:42:11 +0200
Message-ID: <20230821194129.402000843@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: dengxiang <dengxiang@nfschina.com>

commit 788449ae57f4273111b779bbcaad552b67f517d5 upstream.

This patch adds a USB quirk for Mythware XA001AU USB interface.

Signed-off-by: dengxiang <dengxiang@nfschina.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230803024437.370069-1-dengxiang@nfschina.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks-table.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -4507,6 +4507,35 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/* Advanced modes of the Mythware XA001AU.
+	 * For the standard mode, Mythware XA001AU has ID ffad:a001
+	 */
+	USB_DEVICE_VENDOR_SPEC(0xffad, 0xa001),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Mythware",
+		.product_name = "XA001AU",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE


