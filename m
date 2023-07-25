Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8E761550
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjGYL1a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjGYL13 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:27:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D097F99
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DC926169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AA9C433C8;
        Tue, 25 Jul 2023 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284447;
        bh=G8QdQxvwKIMQqQgvbOih9PD3LfvdNBm/xiC+5MynC6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+PvSP+oRnz3D1jyjbSPdA9U17PJVcaqGoeUH73osoErenj6De/Q75Yacl8TEd8dV
         h2WDViUtrmaG/4gM4Vdozxb0XX2Gexfjlesv+2cyNNVyrHaQ/MVE1oz3OwX3JvqYU1
         cDNVkOeCKgZ9JGIlAfKza7FI/GVHOvUlP3jcYUs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 360/509] platform/x86: wmi: move variables
Date:   Tue, 25 Jul 2023 12:44:59 +0200
Message-ID: <20230725104610.206533879@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Barnabás Pőcze <pobrn@protonmail.com>

[ Upstream commit f5431bf1e6781e876bdc8ae10fb1e7da6f1aa9b5 ]

Move some variables in order to keep them
in the narrowest possible scope.

Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>
Link: https://lore.kernel.org/r/20210904175450.156801-22-pobrn@protonmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 028e6e204ace ("platform/x86: wmi: Break possible infinite loop when parsing GUID")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 18c4080d4a71e..5e4c03f7db7c0 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -134,7 +134,6 @@ static const void *find_guid_context(struct wmi_block *wblock,
 				      struct wmi_driver *wdriver)
 {
 	const struct wmi_device_id *id;
-	guid_t guid_input;
 
 	if (wblock == NULL || wdriver == NULL)
 		return NULL;
@@ -143,6 +142,8 @@ static const void *find_guid_context(struct wmi_block *wblock,
 
 	id = wdriver->id_table;
 	while (*id->guid_string) {
+		guid_t guid_input;
+
 		if (guid_parse(id->guid_string, &guid_input))
 			continue;
 		if (guid_equal(&wblock->gblock.guid, &guid_input))
@@ -615,7 +616,6 @@ acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 {
 	struct acpi_object_list input;
 	union acpi_object params[1];
-	struct guid_block *gblock;
 	struct wmi_block *wblock;
 
 	input.count = 1;
@@ -624,7 +624,7 @@ acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 	params[0].integer.value = event;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
-		gblock = &wblock->gblock;
+		struct guid_block *gblock = &wblock->gblock;
 
 		if ((gblock->flags & ACPI_WMI_EVENT) &&
 			(gblock->notify_id == event))
@@ -1281,12 +1281,11 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
 static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 				    void *context)
 {
-	struct guid_block *block;
 	struct wmi_block *wblock;
 	bool found_it = false;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
-		block = &wblock->gblock;
+		struct guid_block *block = &wblock->gblock;
 
 		if (wblock->acpi_device->handle == handle &&
 		    (block->flags & ACPI_WMI_EVENT) &&
-- 
2.39.2



