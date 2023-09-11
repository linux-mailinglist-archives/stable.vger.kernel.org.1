Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B679AD29
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355179AbjIKV5W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbjIKO1s (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:27:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A9EF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:27:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB531C433C7;
        Mon, 11 Sep 2023 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442462;
        bh=5gnewnyw4jnlnRBMqMSpB2sVF/jo454EytG+XIs5mWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLgkol3UokhRxcULVKhs04bx1GUPia4nAxkos5OcGS3wpjn89q4k5LfT/BfqHkkxv
         xAExKVexil6eZiAVCasnHX3K895yQ6aQ4dM5CCp9HwVbFFGW0PLQazOXTMNdgVni29
         kk3xxjPA8LSr4RFXSxLJA7unEfhS1NIw6l232APs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxim Mikityanskiy <maxtram95@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 034/737] platform/x86/intel/hid: Add HP Dragonfly G2 to VGBS DMI quirks
Date:   Mon, 11 Sep 2023 15:38:13 +0200
Message-ID: <20230911134651.362801535@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index 641f2797406e1..7457ca2b27a60 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -150,6 +150,12 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
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



