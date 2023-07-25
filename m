Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF38D761715
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjGYLoy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGYLof (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D201A1BE6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F6136167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BC6C433C7;
        Tue, 25 Jul 2023 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285473;
        bh=2J7AXJYg4EDM+Bp3BokIiMqI77ap95H/W4X6i7q9U8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pz1qNSmArr5e5SP3zrKFpg2o9zZ/8PeLG6P/NIH1fdGOGae9Pjjp1k9fPT5JIqYdv
         rNxDKPmX6HOn3fW/yBSZpfzMnBV5Mm7imWvNPTDv+s+qqWsfbU0Hn5ePE8PZuWOaVq
         GM5JCvTN9QKX9NiMeWEYz+T7j1cHj6khF1lQuYDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 216/313] platform/x86: wmi: Replace UUID redefinitions by their originals
Date:   Tue, 25 Jul 2023 12:46:09 +0200
Message-ID: <20230725104530.384377040@linuxfoundation.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit f9dffc1417130a2d465e2edaf6663d99738792a3 ]

There are types and helpers that are redefined with old names.
Convert the WMI library to use those types and helpers directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Stable-dep-of: 028e6e204ace ("platform/x86: wmi: Break possible infinite loop when parsing GUID")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index cb029126a68c6..62b146af35679 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -110,11 +110,11 @@ static struct platform_driver acpi_wmi_driver = {
 
 static bool find_guid(const char *guid_string, struct wmi_block **out)
 {
-	uuid_le guid_input;
+	guid_t guid_input;
 	struct wmi_block *wblock;
 	struct guid_block *block;
 
-	if (uuid_le_to_bin(guid_string, &guid_input))
+	if (guid_parse(guid_string, &guid_input))
 		return false;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
@@ -133,7 +133,7 @@ static const void *find_guid_context(struct wmi_block *wblock,
 				      struct wmi_driver *wdriver)
 {
 	const struct wmi_device_id *id;
-	uuid_le guid_input;
+	guid_t guid_input;
 
 	if (wblock == NULL || wdriver == NULL)
 		return NULL;
@@ -142,7 +142,7 @@ static const void *find_guid_context(struct wmi_block *wblock,
 
 	id = wdriver->id_table;
 	while (*id->guid_string) {
-		if (uuid_le_to_bin(id->guid_string, &guid_input))
+		if (guid_parse(id->guid_string, &guid_input))
 			continue;
 		if (!memcmp(wblock->gblock.guid, &guid_input, 16))
 			return id->context;
@@ -526,12 +526,12 @@ wmi_notify_handler handler, void *data)
 {
 	struct wmi_block *block;
 	acpi_status status = AE_NOT_EXIST;
-	uuid_le guid_input;
+	guid_t guid_input;
 
 	if (!guid || !handler)
 		return AE_BAD_PARAMETER;
 
-	if (uuid_le_to_bin(guid, &guid_input))
+	if (guid_parse(guid, &guid_input))
 		return AE_BAD_PARAMETER;
 
 	list_for_each_entry(block, &wmi_block_list, list) {
@@ -565,12 +565,12 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 {
 	struct wmi_block *block;
 	acpi_status status = AE_NOT_EXIST;
-	uuid_le guid_input;
+	guid_t guid_input;
 
 	if (!guid)
 		return AE_BAD_PARAMETER;
 
-	if (uuid_le_to_bin(guid, &guid_input))
+	if (guid_parse(guid, &guid_input))
 		return AE_BAD_PARAMETER;
 
 	list_for_each_entry(block, &wmi_block_list, list) {
@@ -801,9 +801,9 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 		return 0;
 
 	while (*id->guid_string) {
-		uuid_le driver_guid;
+		guid_t driver_guid;
 
-		if (WARN_ON(uuid_le_to_bin(id->guid_string, &driver_guid)))
+		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
 			continue;
 		if (!memcmp(&driver_guid, wblock->gblock.guid, 16))
 			return 1;
-- 
2.39.2



