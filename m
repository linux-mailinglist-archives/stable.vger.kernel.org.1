Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E307ED6FC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjKOWEq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjKOWEq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:04:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A97612C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:04:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989E5C433CA;
        Wed, 15 Nov 2023 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085882;
        bh=HmH/8/SwGcp5MeX02sy5ftLnaJcqYPgkW3mIqRpNCoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5OJiHhVBRSLvjqDvW9PUimPef3X/nK9z20LGGAb16iV7rMgxGXL6DmAN1NqapW/5
         jf9FA08S9wao1MRE0jDQnhaRvC0UCjfaDdhVLDEu59UIzaRFqNN1wz9UbI5ZQMfLx6
         SC6UbeuwwVWcnoFu4NLkCGrESl1wi0QK2G7FSkZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Blixt <jonas.blixt@actia.se>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 079/119] USB: usbip: fix stub_dev hub disconnect
Date:   Wed, 15 Nov 2023 17:01:09 -0500
Message-ID: <20231115220135.094959384@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 3c6d452e3bf40..4104eea03e806 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -462,8 +462,13 @@ static void stub_disconnect(struct usb_device *udev)
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



