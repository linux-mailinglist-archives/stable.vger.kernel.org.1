Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1140775D68
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjHILhR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjHILhL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BD1173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2B8E63547
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14B8C433C7;
        Wed,  9 Aug 2023 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581030;
        bh=QhMdq6GsBUCYsRgx77tTtwmBPNjhq1VtDPdyxlTqKHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ovic7cm/I6Chq/SaR/uOPpNQulfRPBvCgzBT6lLQO7rQL3daoh9vJH7M8BMOTCaw
         Xy4z7f94N25iWl2OQ65rzGM17kJac4MtyNkAB8vN7WUorqbalNlpvTKy+uarbOXQZL
         qv9kgHokHze0klO1P0aYFViqAlzP2AYh5RiboSak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>,
        stable <stable@kernel.org>
Subject: [PATCH 5.10 079/201] USB: quirks: add quirk for Focusrite Scarlett
Date:   Wed,  9 Aug 2023 12:41:21 +0200
Message-ID: <20230809103646.451791558@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Łukasz Bartosik <lb@semihalf.com>

commit 9dc162e22387080e2d06de708b89920c0e158c9a upstream.

The Focusrite Scarlett audio device does not behave correctly during
resumes. Below is what happens during every resume (captured with
Beagle 5000):

<Suspend>
<Resume>
<Reset>/<Chirp J>/<Tiny J>
<Reset/Target disconnected>
<High Speed>

The Scarlett disconnects and is enumerated again.

However from time to time it drops completely off the USB bus during
resume. Below is captured occurrence of such an event:

<Suspend>
<Resume>
<Reset>/<Chirp J>/<Tiny J>
<Reset>/<Chirp K>/<Tiny K>
<High Speed>
<Corrupted packet>
<Reset/Target disconnected>

To fix the condition a user has to unplug and plug the device again.

With USB_QUIRK_RESET_RESUME applied ("usbcore.quirks=1235:8211:b")
for the Scarlett audio device the issue still reproduces.

Applying USB_QUIRK_DISCONNECT_SUSPEND ("usbcore.quirks=1235:8211:m")
fixed the issue and the Scarlett audio device didn't drop off the USB
bus for ~5000 suspend/resume cycles where originally issue reproduced in
~100 or less suspend/resume cycles.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20230724112911.1802577-1-lb@semihalf.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -437,6 +437,10 @@ static const struct usb_device_id usb_qu
 	/* novation SoundControl XL */
 	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Focusrite Scarlett Solo USB */
+	{ USB_DEVICE(0x1235, 0x8211), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },


