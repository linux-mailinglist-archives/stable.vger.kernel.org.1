Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFFC7D3162
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjJWLIj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjJWLIi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:08:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5F99
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:08:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B30C433C8;
        Mon, 23 Oct 2023 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059316;
        bh=vTEFKl+x+uFukC2otFWMhzuSCcOEyP42CzJSp+CxhL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKFnPZt12Orzuhy2bscUP6iDUCqwXP93BTBYZ/wRqmNjHR01ulspDaGoQwc9T6kOd
         iSiMQrPfTETfNi8iGJaEr/dpdxANrMXSuzQ+tR0Ww0N8RzQaaHnw0P9jQkn6+WWJcZ
         02agFPAkQJqfyzR4DnDXx4ECRiDmfbxU29vvBLNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tomasz Swiatek <swiatektomasz99@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 136/241] platform/x86: touchscreen_dmi: Add info for the BUSH Bush Windows tablet
Date:   Mon, 23 Oct 2023 12:55:22 +0200
Message-ID: <20231023104837.184050808@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Swiatek <swiatektomasz99@gmail.com>

[ Upstream commit 34c271e778c1d8589ee9c833eee5ecb6fbb03149 ]

Add touchscreen info for the BUSH Bush Windows tablet.

It was tested using gslx680_ts_acpi module and on patched kernel
installed on device.

Link: https://github.com/onitake/gsl-firmware/pull/215
Link: https://github.com/systemd/systemd/pull/29268
Signed-off-by: Tomasz Swiatek <swiatektomasz99@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/touchscreen_dmi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index f9301a9382e74..363a9848e2b88 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -42,6 +42,21 @@ static const struct ts_dmi_data archos_101_cesium_educ_data = {
 	.properties     = archos_101_cesium_educ_props,
 };
 
+static const struct property_entry bush_bush_windows_tablet_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1850),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-bush-bush-windows-tablet.fw"),
+	{ }
+};
+
+static const struct ts_dmi_data bush_bush_windows_tablet_data = {
+	.acpi_name      = "MSSL1680:00",
+	.properties     = bush_bush_windows_tablet_props,
+};
+
 static const struct property_entry chuwi_hi8_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1665),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
@@ -1070,6 +1085,13 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ARCHOS 101 Cesium Educ"),
 		},
 	},
+	{
+		/* Bush Windows tablet */
+		.driver_data = (void *)&bush_bush_windows_tablet_data,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bush Windows tablet"),
+		},
+	},
 	{
 		/* Chuwi Hi8 */
 		.driver_data = (void *)&chuwi_hi8_data,
-- 
2.40.1



