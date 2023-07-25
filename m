Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC113761727
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGYLp3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjGYLp2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D95F2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB2A261654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2639C433C7;
        Tue, 25 Jul 2023 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285526;
        bh=m3UyYIcDpY1Ky+z1Rg7NuWXzSbJ/8YqEC4DRu71xIfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmYNvYPmbNgqOYMiWskSWR4URiiRArD8ziK4XCAB3GJOi1ZfKvkMNZpeZh0hZZvni
         KZ6+gul+DmJGKSU+86HGD72snMpRWJ+h+2L53XgKvkm7JhOLnNBU7eDfnvNklHkkz0
         HaZaaR4yxkhdvYSndDBYKYY2DQMYh2DQMiGum6ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 219/313] platform/x86: wmi: use guid_t and guid_equal()
Date:   Tue, 25 Jul 2023 12:46:12 +0200
Message-ID: <20230725104530.532584290@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Barnabás Pőcze <pobrn@protonmail.com>

[ Upstream commit 67f472fdacf4a691b1c3c20c27800b23ce31e2de ]

Instead of hard-coding a 16 long byte array,
use the available `guid_t` type and related methods.

Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>
Link: https://lore.kernel.org/r/20210904175450.156801-15-pobrn@protonmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 028e6e204ace ("platform/x86: wmi: Break possible infinite loop when parsing GUID")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7de866ca30e51..41a680b39f9d1 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -39,7 +39,7 @@ MODULE_LICENSE("GPL");
 static LIST_HEAD(wmi_block_list);
 
 struct guid_block {
-	char guid[16];
+	guid_t guid;
 	union {
 		char object_id[2];
 		struct {
@@ -120,7 +120,7 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	list_for_each_entry(wblock, &wmi_block_list, list) {
 		block = &wblock->gblock;
 
-		if (memcmp(block->guid, &guid_input, 16) == 0) {
+		if (guid_equal(&block->guid, &guid_input)) {
 			if (out)
 				*out = wblock;
 			return true;
@@ -144,7 +144,7 @@ static const void *find_guid_context(struct wmi_block *wblock,
 	while (*id->guid_string) {
 		if (guid_parse(id->guid_string, &guid_input))
 			continue;
-		if (!memcmp(wblock->gblock.guid, &guid_input, 16))
+		if (guid_equal(&wblock->gblock.guid, &guid_input))
 			return id->context;
 		id++;
 	}
@@ -456,7 +456,7 @@ EXPORT_SYMBOL_GPL(wmi_set_block);
 
 static void wmi_dump_wdg(const struct guid_block *g)
 {
-	pr_info("%pUL:\n", g->guid);
+	pr_info("%pUL:\n", &g->guid);
 	if (g->flags & ACPI_WMI_EVENT)
 		pr_info("\tnotify_id: 0x%02X\n", g->notify_id);
 	else
@@ -537,7 +537,7 @@ wmi_notify_handler handler, void *data)
 	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
 
-		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
+		if (guid_equal(&block->gblock.guid, &guid_input)) {
 			if (block->handler &&
 			    block->handler != wmi_notify_debug)
 				return AE_ALREADY_ACQUIRED;
@@ -576,7 +576,7 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
 
-		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
+		if (guid_equal(&block->gblock.guid, &guid_input)) {
 			if (!block->handler ||
 			    block->handler == wmi_notify_debug)
 				return AE_NULL_ENTRY;
@@ -682,7 +682,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	return sprintf(buf, "wmi:%pUL\n", wblock->gblock.guid);
+	return sprintf(buf, "wmi:%pUL\n", &wblock->gblock.guid);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -691,7 +691,7 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	return sprintf(buf, "%pUL\n", wblock->gblock.guid);
+	return sprintf(buf, "%pUL\n", &wblock->gblock.guid);
 }
 static DEVICE_ATTR_RO(guid);
 
@@ -774,10 +774,10 @@ static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	if (add_uevent_var(env, "MODALIAS=wmi:%pUL", wblock->gblock.guid))
+	if (add_uevent_var(env, "MODALIAS=wmi:%pUL", &wblock->gblock.guid))
 		return -ENOMEM;
 
-	if (add_uevent_var(env, "WMI_GUID=%pUL", wblock->gblock.guid))
+	if (add_uevent_var(env, "WMI_GUID=%pUL", &wblock->gblock.guid))
 		return -ENOMEM;
 
 	return 0;
@@ -805,7 +805,7 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 
 		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
 			continue;
-		if (!memcmp(&driver_guid, wblock->gblock.guid, 16))
+		if (guid_equal(&driver_guid, &wblock->gblock.guid))
 			return 1;
 
 		id++;
@@ -1101,7 +1101,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	wblock->dev.dev.bus = &wmi_bus_type;
 	wblock->dev.dev.parent = wmi_bus_dev;
 
-	dev_set_name(&wblock->dev.dev, "%pUL", wblock->gblock.guid);
+	dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
 
 	device_initialize(&wblock->dev.dev);
 
@@ -1121,12 +1121,12 @@ static void wmi_free_devices(struct acpi_device *device)
 	}
 }
 
-static bool guid_already_parsed(struct acpi_device *device, const u8 *guid)
+static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
 {
 	struct wmi_block *wblock;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
-		if (memcmp(wblock->gblock.guid, guid, 16) == 0) {
+		if (guid_equal(&wblock->gblock.guid, guid)) {
 			/*
 			 * Because we historically didn't track the relationship
 			 * between GUIDs and ACPI nodes, we don't know whether
@@ -1181,7 +1181,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		 * case yet, so for now, we'll just ignore the duplicate
 		 * for device creation.
 		 */
-		if (guid_already_parsed(device, gblock[i].guid))
+		if (guid_already_parsed(device, &gblock[i].guid))
 			continue;
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
@@ -1218,7 +1218,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		retval = device_add(&wblock->dev.dev);
 		if (retval) {
 			dev_err(wmi_bus_dev, "failed to register %pUL\n",
-				wblock->gblock.guid);
+				&wblock->gblock.guid);
 			if (debug_event)
 				wmi_method_enable(wblock, 0);
 			list_del(&wblock->list);
@@ -1332,7 +1332,7 @@ static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 	}
 
 	if (debug_event)
-		pr_info("DEBUG Event GUID: %pUL\n", wblock->gblock.guid);
+		pr_info("DEBUG Event GUID: %pUL\n", &wblock->gblock.guid);
 
 	acpi_bus_generate_netlink_event(
 		wblock->acpi_device->pnp.device_class,
-- 
2.39.2



