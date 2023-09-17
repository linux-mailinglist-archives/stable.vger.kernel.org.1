Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFF47A3AAD
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbjIQUHb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbjIQUHL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:07:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B3FB5
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:07:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7F7C433C7;
        Sun, 17 Sep 2023 20:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981226;
        bh=I39XvpjE299mtsZwkvxia9TxV5XgVD5IlnKZiLFgHOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F95/C+N6wacpJf6RyVSxAwUED1Ug5qrHz1p7CNatEYZUynEwE9/y3Bla0AMY2RqRz
         AwrSDeXtuLKU64UQZGB1F37kku9e4gy7agLBKfNW/9ZgTg0dGQ9p1b4bRZ0fVYsGib
         kVI7jwEd3X7ZsThPXgI0465AQP71XxNTboFygyHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxim Mikityanskiy <maxtram95@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 025/511] platform/x86/intel/hid: Add HP Dragonfly G2 to VGBS DMI quirks
Date:   Sun, 17 Sep 2023 21:07:32 +0200
Message-ID: <20230917191114.435281549@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxim Mikityanskiy <maxtram95@gmail.com>

[ Upstream commit 7783e97f8558ad7a4d1748922461bc88483fbcdf ]

HP Elite Dragonfly G2 (a convertible laptop/tablet) has a reliable VGBS
method. If VGBS is not called on boot, the firmware sends an initial
0xcd event shortly after calling the BTNL method, but only if the device
is booted in the laptop mode. However, if the device is booted in the
tablet mode and VGBS is not called, there is no initial 0xcc event, and
the input device for SW_TABLET_MODE is not registered up until the user
turns the device into the laptop mode.

Call VGBS on boot on this device to get the initial state of
SW_TABLET_MODE in a reliable way.

Tested with BIOS 1.13.1.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Link: https://lore.kernel.org/r/20230716183213.64173-1-maxtram95@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/hid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 73ecbdfcfb7c0..f59a3cc9767b9 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -138,6 +138,12 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite Dragonfly G2 Notebook PC"),
+		},
+	},
 	{ }
 };
 
-- 
2.40.1



