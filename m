Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2B70C93C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjEVTqF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjEVTqB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C71F10D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C74762A8D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB70C433EF;
        Mon, 22 May 2023 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784758;
        bh=w4+yCuMJNQr9OLAGviXwLRSRn8mENaqAbjJrsAYOyt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khsJH0xPDDVUZc4jL77/NJzL95ZZLsTLLfjuJc+JsCcay+fJnikT7y92StAkU50pA
         tgaWmcSMsdMbb/VMWvakCxNtUkpItovu5OIhC9fctADLW7EWs5R32rVZScH/YH7iEG
         gD41GOomZT2WEuu8zt1Vdpa3qFTWdj9nzmcWwGb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 154/364] HID: logitech-hidpp: Reconcile USB and Unifying serials
Date:   Mon, 22 May 2023 20:07:39 +0100
Message-Id: <20230522190416.597663701@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit 5b3691d15e04b6d5a32c915577b8dbc5cfb56382 ]

Now that USB HID++ devices can gather a serial number that matches the
one that would be gathered when connected through a Unifying receiver,
remove the last difference by dropping the product ID as devices
usually have different product IDs when connected through USB or
Unifying.

For example, on the serials on a G903 wired/wireless mouse:
- Unifying before patch: 4067-e8-ce-cd-45
- USB before patch: c086-e8-ce-cd-45
- Unifying and USB after patch: e8-ce-cd-45

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Link: https://lore.kernel.org/r/20230302130117.3975-2-hadess@hadess.net
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 66380876937f6..da89e84c9cbeb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -853,8 +853,7 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
-		 hdev->product, &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
 	name = hidpp_unifying_get_name(hidpp);
@@ -989,8 +988,7 @@ static int hidpp_serial_init(struct hidpp_device *hidpp)
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
-		 hdev->product, &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
 	dbg_hid("HID++ DeviceInformation: Got serial: %s\n", hdev->uniq);
 
 	return 0;
-- 
2.39.2



