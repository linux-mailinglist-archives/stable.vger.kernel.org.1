Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A595B76AF96
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjHAJtA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjHAJsp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAFA19BE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D2F6614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57381C433C8;
        Tue,  1 Aug 2023 09:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883237;
        bh=QsYuCVHwNhX7htojaEBKLZ0mhsd7dkS5VMUMjDCGC4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tu+tQNgFk8xnbRzrKT9Fda+xv75OfGrF7SlgELYBPp+Q+GoylqlUpNzhZ6sgIkhAs
         DAcKYdHK8h6AsNwCYWokDxvuofZCCFLBxl1g7jxPxR5Om80h6L5h2T/QNH2jLVZcxV
         SDsVxPOXQkK7Wg9HBwFpTObV5s9pOaRXr3zJ6ZP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 6.4 165/239] usb: misc: ehset: fix wrong if condition
Date:   Tue,  1 Aug 2023 11:20:29 +0200
Message-ID: <20230801091931.581270473@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xu Yang <xu.yang_2@nxp.com>

commit 7f2327666a9080e428166964e37548b0168cd5e9 upstream.

A negative number from ret means the host controller had failed to send
usb message and 0 means succeed. Therefore, the if logic is wrong here
and this patch will fix it.

Fixes: f2b42379c576 ("usb: misc: ehset: Rework test mode entry")
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20230705095231.457860-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/ehset.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/misc/ehset.c
+++ b/drivers/usb/misc/ehset.c
@@ -77,7 +77,7 @@ static int ehset_probe(struct usb_interf
 	switch (test_pid) {
 	case TEST_SE0_NAK_PID:
 		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
+		if (ret < 0)
 			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
@@ -86,7 +86,7 @@ static int ehset_probe(struct usb_interf
 		break;
 	case TEST_J_PID:
 		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
+		if (ret < 0)
 			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
@@ -95,7 +95,7 @@ static int ehset_probe(struct usb_interf
 		break;
 	case TEST_K_PID:
 		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
+		if (ret < 0)
 			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
@@ -104,7 +104,7 @@ static int ehset_probe(struct usb_interf
 		break;
 	case TEST_PACKET_PID:
 		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
+		if (ret < 0)
 			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,


