Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780ED70C751
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjEVT23 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjEVT2Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:28:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D82198
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EECAB628D5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCE8C433EF;
        Mon, 22 May 2023 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783693;
        bh=MZJ2JwlXV8zGvhVnxDuxi244EYHKpQcGwxk41dx1clw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mte6sfpRNunctonjGyQObNQTJtPKIS36HNaI5GM75h/oe0zydVuTjV1KQ/bxz/Gnd
         XOS8rbbHZivisEz+V7V/PqVYkE7VN+LrS/kL/noeaLsieVFNTddII3ACDWRxIr4q0Y
         pDfQ7c3LnLGxb3U+78eoBiRf8HKs+bx+tODznqFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Henrie <alexhenrie24@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 131/292] HID: apple: Set the tilde quirk flag on the Geyser 3
Date:   Mon, 22 May 2023 20:08:08 +0100
Message-Id: <20230522190409.243271721@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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
index f21b1c4ca8254..37b2ce9b50fe8 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -854,7 +854,8 @@ static const struct hid_device_id apple_devices[] = {
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



