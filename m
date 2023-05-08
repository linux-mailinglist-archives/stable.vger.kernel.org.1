Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906EF6FAA26
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjEHLAM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjEHK7V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B8F29C84
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7038C62006
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BE2C433D2;
        Mon,  8 May 2023 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543476;
        bh=xGAMcCnHDbRWVOogbJQae0UOmzlwX5hiD4oh9pluxW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcZfPx0JZ+/yBuzHjvr4hiU9svdWSngMveLdU4ssrGCWr3n9VMGAHFDVJgSyM2jLd
         EUzklcJw7fQi8CqKwEeTmodf4gw/iYr02yXR1FTsydwUVAQ0iC+awCbASpF1XdQAj8
         xV3Dcxej0wP13unARSjJJFuJoAAdmKfoo1ojl/tc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geraldo Nascimento <geraldogabriel@gmail.com>,
        =?UTF-8?q?Gr=C3=A9gory=20Desor?= <gregory.desor@free.fr>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.3 102/694] ALSA: usb-audio: Add quirk for Pioneer DDJ-800
Date:   Mon,  8 May 2023 11:38:57 +0200
Message-Id: <20230508094435.802960930@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Geraldo Nascimento <geraldogabriel@gmail.com>

commit 7501f472977df233d039d86c6981e0641708e1ca upstream.

One more Pioneer quirk, this time for DDJ-800, which is quite similar like
other DJ DDJ models but with slightly different EPs or channels.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Tested-by: Grégory Desor <gregory.desor@free.fr>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/ZFLLzgEcsSF5aIHG@geday
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks-table.h |   58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3884,6 +3884,64 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+{
+	/*
+	 * PIONEER DJ DDJ-800
+	 * PCM is 6 channels out, 6 channels in @ 44.1 fixed
+	 * The Feedback for the output is the input
+	 */
+	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0029),
+		.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 6,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_44100,
+					.rate_min = 44100,
+					.rate_max = 44100,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 44100 }
+				}
+			},
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 6,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x82,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC|
+					USB_ENDPOINT_USAGE_IMPLICIT_FB,
+					.rates = SNDRV_PCM_RATE_44100,
+					.rate_min = 44100,
+					.rate_max = 44100,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 44100 }
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+
 /*
  * MacroSilicon MS2100/MS2106 based AV capture cards
  *


