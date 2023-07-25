Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0F76154E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjGYL1Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjGYL1Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4505A18F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE576169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1B7C433C8;
        Tue, 25 Jul 2023 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284442;
        bh=ZqsC1+zmRzwFQtVqxyoTFx2fKjSGFSBnKano4MzMBqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBUJPwPeVTQUWNKJKAsU4hznVOVezuDO4stTssvhte/OM1+qrTybUWylqAv2JQ6Nv
         CR6JnudohxWJTER+9qqSlSf/Is9PdoPpisL2wbWzcIisnpSOnY/MWvSUJrI6R4lQXZ
         EllujJvaYi6HeYGIR8o0/77/tINk/i9cgtpQIRMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 358/509] platform/x86: wmi: remove unnecessary argument
Date:   Tue, 25 Jul 2023 12:44:57 +0200
Message-ID: <20230725104610.125119270@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

[ Upstream commit 84eacf7e6413d5e2d2f4f9dddf9216c18a3631cf ]

The GUID block is available for `wmi_create_device()`
through `wblock->gblock`. Use that consistently in
the function instead of using a mix of `gblock` and
`wblock->gblock`.

Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>
Link: https://lore.kernel.org/r/20210904175450.156801-8-pobrn@protonmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 028e6e204ace ("platform/x86: wmi: Break possible infinite loop when parsing GUID")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 1f80b26281628..9a6dc2717e1d4 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1042,7 +1042,6 @@ static const struct device_type wmi_type_data = {
 };
 
 static int wmi_create_device(struct device *wmi_bus_dev,
-			     const struct guid_block *gblock,
 			     struct wmi_block *wblock,
 			     struct acpi_device *device)
 {
@@ -1050,12 +1049,12 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	char method[5];
 	int result;
 
-	if (gblock->flags & ACPI_WMI_EVENT) {
+	if (wblock->gblock.flags & ACPI_WMI_EVENT) {
 		wblock->dev.dev.type = &wmi_type_event;
 		goto out_init;
 	}
 
-	if (gblock->flags & ACPI_WMI_METHOD) {
+	if (wblock->gblock.flags & ACPI_WMI_METHOD) {
 		wblock->dev.dev.type = &wmi_type_method;
 		mutex_init(&wblock->char_mutex);
 		goto out_init;
@@ -1105,7 +1104,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	wblock->dev.dev.bus = &wmi_bus_type;
 	wblock->dev.dev.parent = wmi_bus_dev;
 
-	dev_set_name(&wblock->dev.dev, "%pUL", gblock->guid);
+	dev_set_name(&wblock->dev.dev, "%pUL", wblock->gblock.guid);
 
 	device_initialize(&wblock->dev.dev);
 
@@ -1197,7 +1196,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		wblock->acpi_device = device;
 		wblock->gblock = gblock[i];
 
-		retval = wmi_create_device(wmi_bus_dev, &gblock[i], wblock, device);
+		retval = wmi_create_device(wmi_bus_dev, wblock, device);
 		if (retval) {
 			kfree(wblock);
 			continue;
-- 
2.39.2



