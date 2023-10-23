Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9487D32E7
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjJWLYz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjJWLYy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:24:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940E6102
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:24:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C857DC433C9;
        Mon, 23 Oct 2023 11:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060291;
        bh=VcBkhqdZNm9ObN8M5Rf+QBCIyLNyEuVW7yoxfmrebZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lH5zRKA6vhSSOS6Fz/KihAsbGS8UUiaJhhDOBqiBNYm8KGYAQVMelQ4e6CrgerIiT
         1ulk6Tlcr0wb1VjslR2ON0mk0/sMyvi69qwkxtdZz6L9hQmDasLjiZk5O5tgjWBvA0
         p3oQd7ELmrDeCq+chWXUVurtr+vKjCyKLRbQcfuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rain <rain@sunshowers.io>,
        Rahul Rameshbabu <sergeantsagara@protonmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 123/196] HID: multitouch: Add required quirk for Synaptics 0xcd7e device
Date:   Mon, 23 Oct 2023 12:56:28 +0200
Message-ID: <20231023104831.986234860@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Rameshbabu <sergeantsagara@protonmail.com>

[ Upstream commit 1437e4547edf41689d7135faaca4222ef0081bc1 ]

Register the Synaptics device as a special multitouch device with certain
quirks that may improve usability of the touchpad device.

Reported-by: Rain <rain@sunshowers.io>
Closes: https://lore.kernel.org/linux-input/2bbb8e1d-1793-4df1-810f-cb0137341ff4@app.fastmail.com/
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 521b2ffb42449..8db4ae05febc8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2144,6 +2144,10 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_MTP_STM)},
 
 	/* Synaptics devices */
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
+
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
-- 
2.40.1



