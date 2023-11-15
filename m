Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670767ED1BD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbjKOUEz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344321AbjKOUEw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:04:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB931BD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:04:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A734C433C7;
        Wed, 15 Nov 2023 20:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078688;
        bh=ZZSeUUl7EYRvWusZ1xTJqcUdx5yjnn+VT0JLs2zFo7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwGfrbMCkMmeXDF9vMUZGI4qW9VoWao9U1mof6Tbwg9jVLHVyWQNzBUHugpxfUFNq
         5Jg6U9IuM/ZG/oCHXz6hp0CRN4k7uABPDoHwDwfQYb36XG5dRXVWLMKb90KjCaUYO4
         B72dvHPFGA5GTC0KXLJqRKepic1ieFRnMKunj3dI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Blixt <jonas.blixt@actia.se>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 29/45] USB: usbip: fix stub_dev hub disconnect
Date:   Wed, 15 Nov 2023 14:33:06 -0500
Message-ID: <20231115191421.335117590@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191419.641552204@linuxfoundation.org>
References: <20231115191419.641552204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Blixt <jonas.blixt@actia.se>

[ Upstream commit 97475763484245916735a1aa9a3310a01d46b008 ]

If a hub is disconnected that has device(s) that's attached to the usbip layer
the disconnect function might fail because it tries to release the port
on an already disconnected hub.

Fixes: 6080cd0e9239 ("staging: usbip: claim ports used by shared devices")
Signed-off-by: Jonas Blixt <jonas.blixt@actia.se>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20230615092810.1215490-1-jonas.blixt@actia.se
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/usbip/stub_dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 16bb3197d6580..d179b281b9521 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -511,8 +511,13 @@ static void stub_disconnect(struct usb_device *udev)
 	/* release port */
 	rc = usb_hub_release_port(udev->parent, udev->portnum,
 				  (struct usb_dev_state *) udev);
-	if (rc) {
-		dev_dbg(&udev->dev, "unable to release port\n");
+	/*
+	 * NOTE: If a HUB disconnect triggered disconnect of the down stream
+	 * device usb_hub_release_port will return -ENODEV so we can safely ignore
+	 * that error here.
+	 */
+	if (rc && (rc != -ENODEV)) {
+		dev_dbg(&udev->dev, "unable to release port (%i)\n", rc);
 		return;
 	}
 
-- 
2.42.0



