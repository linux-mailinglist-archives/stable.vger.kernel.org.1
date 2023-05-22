Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3F70C936
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjEVTp7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjEVTpz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:45:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB872139
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58CF462A8B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688DBC4339B;
        Mon, 22 May 2023 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784749;
        bh=rHX3+4HNWpaIyjXC4vG2Ai1ck+Uw7+0j3VesE1SKAFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVZU0m/yTaiZdI5cR2TIbSbl5XqgvXZrqUMlyG2IUCfFiE/bfItuY/yUsjtjBywQZ
         XU1MFXUu64mmIXXN6V6qrLQZQutxBJNRY1cKqE8dl935zGh8g4DxN2iOlBgBOlzShg
         lmOHIezBMss6JQ04kGBM59sjUyCQ+H2tFrsb/58w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Henrie <alexhenrie24@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 161/364] HID: apple: Set the tilde quirk flag on the Geyser 3
Date:   Mon, 22 May 2023 20:07:46 +0100
Message-Id: <20230522190416.764238317@linuxfoundation.org>
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

From: Alex Henrie <alexhenrie24@gmail.com>

[ Upstream commit 29e1ecc197d410ee59c8877098d54cf417075f7d ]

I was finally able to obtain a MacBook1,1 to test and I've now confirmed
that it has the tilde key quirk as well:

Product    Model  Year  System      CPU    Shape  Labels     Country  Quirky
============================================================================
05ac:0218  A1181  2006  MacBook1,1  T2500  ISO    British    13       Yes

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
Link: https://lore.kernel.org/r/20230404024829.13982-1-alexhenrie24@gmail.com
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 5c145775482bc..e2c73a78b5972 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -875,7 +875,8 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO),
-		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
+			APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
 			APPLE_RDESC_JIS },
-- 
2.39.2



