Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB617613B3
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjGYLNI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjGYLMx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1188726AD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98D1861655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52CFC433C7;
        Tue, 25 Jul 2023 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283528;
        bh=mw6xt0zcNipWiKOhO2N4Z7vLAefAlaEqUe2/vNCnung=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfKcYmC5QxypzRgsZHowMd4sACYxGAX7vaveinOrW3zufdlwM+gxKC303vWa3URfV
         xUOe7/uYfE58wMsVZdp1m87ioQC9DO7uK7fouGcVrOu57biINpAd5mEYhzOAtV+ZEc
         V9O839a/32LLjB2GGaVWAo6BJGb2AJ2G69C606ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Hommey <mh@glandium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5.10 007/509] HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.
Date:   Tue, 25 Jul 2023 12:39:06 +0200
Message-ID: <20230725104553.962176657@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mike Hommey <mh@glandium.org>

commit 5fe251112646d8626818ea90f7af325bab243efa upstream.

commit 498ba2069035 ("HID: logitech-hidpp: Don't restart communication if
not necessary") put restarting communication behind that flag, and this
was apparently necessary on the T651, but the flag was not set for it.

Fixes: 498ba2069035 ("HID: logitech-hidpp: Don't restart communication if not necessary")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Hommey <mh@glandium.org>
Link: https://lore.kernel.org/r/20230617230957.6mx73th4blv7owqk@glandium.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-logitech-hidpp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4009,7 +4009,7 @@ static const struct hid_device_id hidpp_
 	{ /* wireless touchpad T651 */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
-	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
+	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT },
 	{ /* Mouse Logitech Anywhere MX */
 	  LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Mouse Logitech Cube */


