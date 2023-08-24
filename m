Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE59878736D
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjHXPDl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242025AbjHXPDN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B7E1FD3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56F8867162
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661E3C433C8;
        Thu, 24 Aug 2023 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889366;
        bh=OP+k3GD1ECM36DTfpa1JvS0OeH5dtXw4bNBf9dQdwlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzpTq0Qqa9gZRNlM+8S6c3sTWDztBftJPbKuSeAvpi5D2tiCZdXQf4yxKz77TcgS6
         4Gpy4ojMXOEPCRT192NS9ACsId5vwIYuyOnUYuHR6R0FbJR4bcoL1JiWzyKnAfp2uU
         dA8QeTq8wv8PP3zwSIsSj0sGrN7Etl0Er2YJVmwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, dengxiang <dengxiang@nfschina.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 110/135] ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.
Date:   Thu, 24 Aug 2023 16:50:53 +0200
Message-ID: <20230824145031.709243823@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
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
@@ -3797,6 +3797,35 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
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


