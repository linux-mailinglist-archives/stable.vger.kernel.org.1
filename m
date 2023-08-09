Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886D1775C84
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjHIL2O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjHIL2N (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936372111
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75F81632CD
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F1EC433C9;
        Wed,  9 Aug 2023 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580482;
        bh=NNSGxKrDbuhcyX5wdq1hV2DeSjsnKp+QjZ20Z33GBJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcgVqT2Y6CTEtuGuJtLAG4DsfGS9hzGsjnYrtiLTFHDjx0g5VpMkkmSi3W6nYlZc+
         AAc5rdxdnSIHfJigPD8wxTKw4qPk/NPAsxPXjH4ZHVEdZUQVZdQ+GSzKX/5D/wRt3C
         SpfiWkCqz2J54BgIkjvZSFNfczcWOrvZOy902Fgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxim Mikityanskiy <maxtram95@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 040/154] platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100
Date:   Wed,  9 Aug 2023 12:41:11 +0200
Message-ID: <20230809103638.348101576@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Maxim Mikityanskiy <maxtram95@gmail.com>

[ Upstream commit ad084a6d99bc182bf109c190c808e2ea073ec57b ]

Only the HW rfkill state is toggled on laptops with quirks->ec_read_only
(so far only MSI Wind U90/U100). There are, however, a few issues with
the implementation:

1. The initial HW state is always unblocked, regardless of the actual
   state on boot, because msi_init_rfkill only sets the SW state,
   regardless of ec_read_only.

2. The initial SW state corresponds to the actual state on boot, but it
   can't be changed afterwards, because set_device_state returns
   -EOPNOTSUPP. It confuses the userspace, making Wi-Fi and/or Bluetooth
   unusable if it was blocked on boot, and breaking the airplane mode if
   the rfkill was unblocked on boot.

Address the above issues by properly initializing the HW state on
ec_read_only laptops and by allowing the userspace to toggle the SW
state. Don't set the SW state ourselves and let the userspace fully
control it. Toggling the SW state is a no-op, however, it allows the
userspace to properly toggle the airplane mode. The actual SW radio
disablement is handled by the corresponding rtl818x_pci and btusb
drivers that have their own rfkills.

Tested on MSI Wind U100 Plus, BIOS ver 1.0G, EC ver 130.

Fixes: 0816392b97d4 ("msi-laptop: merge quirk tables to one")
Fixes: 0de6575ad0a8 ("msi-laptop: Add MSI Wind U90/U100 support")
Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Link: https://lore.kernel.org/r/20230721145423.161057-1-maxtram95@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/msi-laptop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index 0e804b6c2d242..dfb4af759aa75 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -210,7 +210,7 @@ static ssize_t set_device_state(const char *buf, size_t count, u8 mask)
 		return -EINVAL;
 
 	if (quirks->ec_read_only)
-		return -EOPNOTSUPP;
+		return 0;
 
 	/* read current device state */
 	result = ec_read(MSI_STANDARD_EC_COMMAND_ADDRESS, &rdata);
@@ -841,15 +841,15 @@ static bool msi_laptop_i8042_filter(unsigned char data, unsigned char str,
 static void msi_init_rfkill(struct work_struct *ignored)
 {
 	if (rfk_wlan) {
-		rfkill_set_sw_state(rfk_wlan, !wlan_s);
+		msi_rfkill_set_state(rfk_wlan, !wlan_s);
 		rfkill_wlan_set(NULL, !wlan_s);
 	}
 	if (rfk_bluetooth) {
-		rfkill_set_sw_state(rfk_bluetooth, !bluetooth_s);
+		msi_rfkill_set_state(rfk_bluetooth, !bluetooth_s);
 		rfkill_bluetooth_set(NULL, !bluetooth_s);
 	}
 	if (rfk_threeg) {
-		rfkill_set_sw_state(rfk_threeg, !threeg_s);
+		msi_rfkill_set_state(rfk_threeg, !threeg_s);
 		rfkill_threeg_set(NULL, !threeg_s);
 	}
 }
-- 
2.39.2



