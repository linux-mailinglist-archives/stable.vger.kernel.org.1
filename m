Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619A4761240
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjGYLA3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjGYLAP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D3A421C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E193A6168A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F413FC433C9;
        Tue, 25 Jul 2023 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282650;
        bh=1zwcQE97x2gLZQL1/8vkF6CzptRzoEIUt6w0zFv9bUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBqKSr7LoUVFF77Al87QJkMw636GMifT07vOufs2ZG5WB8WIOmhNZFga0PkuPHZ/V
         duTruSGtqb5gHva3vrgPNq1BS51PS46BY1mTByzhSXvVVcI554yTD6/B56mWrVn8pR
         wqgSIB2ltIruDqzZ9QiyaDJ2b0uhJ8R8NZ28JDxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Holland <johnbholland@icloud.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@nordicsemi.no>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 206/227] Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014
Date:   Tue, 25 Jul 2023 12:46:13 +0200
Message-ID: <20230725104523.287662466@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tomasz Moń <tomasz.mon@nordicsemi.no>

[ Upstream commit 95b7015433053cd5f648ad2a7b8f43b2c99c949a ]

Commit c13380a55522 ("Bluetooth: btusb: Do not require hardcoded
interface numbers") inadvertedly broke bluetooth on Intel Macbook 2014.
The intention was to keep behavior intact when BTUSB_IFNUM_2 is set and
otherwise allow any interface numbers. The problem is that the new logic
condition omits the case where bInterfaceNumber is 0.

Fix BTUSB_IFNUM_2 handling by allowing both interface number 0 and 2
when the flag is set.

Fixes: c13380a55522 ("Bluetooth: btusb: Do not require hardcoded interface numbers")
Reported-by: John Holland <johnbholland@icloud.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217651
Signed-off-by: Tomasz Moń <tomasz.mon@nordicsemi.no>
Tested-by: John Holland<johnbholland@icloud.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a8e2bb038f58..50e23762ec5e9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4099,6 +4099,7 @@ static int btusb_probe(struct usb_interface *intf,
 	BT_DBG("intf %p id %p", intf, id);
 
 	if ((id->driver_info & BTUSB_IFNUM_2) &&
+	    (intf->cur_altsetting->desc.bInterfaceNumber != 0) &&
 	    (intf->cur_altsetting->desc.bInterfaceNumber != 2))
 		return -ENODEV;
 
-- 
2.39.2



