Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC44713F1D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjE1TmZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjE1TmV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3015B187
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E0D561EEC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D367C433D2;
        Sun, 28 May 2023 19:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302923;
        bh=4knAG3RUm6soJKDwALrqcaCFg+q9W4kn1/iRmmyAGQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sY0kkMPmDB/DWneusJvBtD60GZ+qFOeJd5w1u1sk38NScvE9prclFXVprGVhwrKM/
         foBWGQzcUPHD0/DKXgwKu55uHbyZr/MxnN32GlH7re8YoXKrhWcJKg/tfXT05Cw7oM
         N7Sa68vXnATgy8JNHCo9nxjbtEX3HRNwKr6+ddvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vicki Pfau <vi@endrift.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 081/211] Input: xpad - add constants for GIP interface numbers
Date:   Sun, 28 May 2023 20:10:02 +0100
Message-Id: <20230528190845.635349983@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit f9b2e603c6216824e34dc9a67205d98ccc9a41ca ]

Wired GIP devices present multiple interfaces with the same USB identification
other than the interface number. This adds constants for differentiating two of
them and uses them where appropriate

Signed-off-by: Vicki Pfau <vi@endrift.com>
Link: https://lore.kernel.org/r/20230411031650.960322-2-vi@endrift.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 70dedc0f7827c..0bd55e1fca372 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -489,6 +489,9 @@ struct xboxone_init_packet {
 	}
 
 
+#define GIP_WIRED_INTF_DATA 0
+#define GIP_WIRED_INTF_AUDIO 1
+
 /*
  * This packet is required for all Xbox One pads with 2015
  * or later firmware installed (or present from the factory).
@@ -1813,7 +1816,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	}
 
 	if (xpad->xtype == XTYPE_XBOXONE &&
-	    intf->cur_altsetting->desc.bInterfaceNumber != 0) {
+	    intf->cur_altsetting->desc.bInterfaceNumber != GIP_WIRED_INTF_DATA) {
 		/*
 		 * The Xbox One controller lists three interfaces all with the
 		 * same interface class, subclass and protocol. Differentiate by
-- 
2.39.2



