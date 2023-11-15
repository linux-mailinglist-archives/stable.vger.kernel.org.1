Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9E87ED196
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbjKOUDy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbjKOUDx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:03:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E4292
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:03:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B5FC433C7;
        Wed, 15 Nov 2023 20:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078630;
        bh=Y3PITBqgqo1wVdPOzTJGdu2gDomzvaK71emuU0YCYaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jN47F0g6rBDeYck555defh6bDtx/51pZYPL/cJiwuKPyjBJnAtAo4cZQ9LBFCjke7
         CeHwJkmgwFBJBUPN6+IObrj5IvRe6BLzwOIro0Xu+G3LJSlsZAL5/luvKzf823ckKm
         SqsUSxoAenCgh5vH8+9HUvjD5czEuA4SwxPj9plo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/45] platform/x86: wmi: Fix probe failure when failing to register WMI devices
Date:   Wed, 15 Nov 2023 14:32:49 -0500
Message-ID: <20231115191420.389808908@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191419.641552204@linuxfoundation.org>
References: <20231115191419.641552204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit ed85891a276edaf7a867de0e9acd0837bc3008f2 ]

When a WMI device besides the first one somehow fails to register,
retval is returned while still containing a negative error code. This
causes the ACPI device fail to probe, leaving behind zombie WMI devices
leading to various errors later.

Handle the single error path separately and return 0 unconditionally
after trying to register all WMI devices to solve the issue. Also
continue to register WMI devices even if some fail to allocate memory.

Fixes: 6ee50aaa9a20 ("platform/x86: wmi: Instantiate all devices before adding them")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20231020211005.38216-4-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 07c1e0829b19a..f7ff07514eb65 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -953,8 +953,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 	struct wmi_block *wblock, *next;
 	union acpi_object *obj;
 	acpi_status status;
-	int retval = 0;
 	u32 i, total;
+	int retval;
 
 	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
@@ -965,8 +965,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		return -ENXIO;
 
 	if (obj->type != ACPI_TYPE_BUFFER) {
-		retval = -ENXIO;
-		goto out_free_pointer;
+		kfree(obj);
+		return -ENXIO;
 	}
 
 	gblock = (const struct guid_block *)obj->buffer.pointer;
@@ -987,8 +987,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
 		if (!wblock) {
-			retval = -ENOMEM;
-			break;
+			dev_err(wmi_bus_dev, "Failed to allocate %pUL\n", &gblock[i].guid);
+			continue;
 		}
 
 		wblock->acpi_device = device;
@@ -1027,9 +1027,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		}
 	}
 
-out_free_pointer:
-	kfree(out.pointer);
-	return retval;
+	kfree(obj);
+
+	return 0;
 }
 
 /*
-- 
2.42.0



