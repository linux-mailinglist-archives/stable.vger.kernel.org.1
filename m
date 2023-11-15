Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C37ED2FB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjKOUp1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjKOUp0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:45:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECD81BC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:45:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C467C433C8;
        Wed, 15 Nov 2023 20:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081119;
        bh=lCa/QPgr0ywpGFisVpuR07WcasRqQ4EEKeo7nBuvvTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2apBBhsiRXYjU8oTIVHVzeGmYh/OYIug8E4L8pikd+FudZMzHWExBEJ/eekP3wy+r
         4drtiQJhX0MvxHwS2/gxnezsjq5EiWT6HfTGKeuaB96ZEdnzhzknSzUJedH8eof6a5
         87WJD6kjM9cV7HY69hdtsWxkMhFkwjtBn5w61dPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/88] platform/x86: wmi: Fix probe failure when failing to register WMI devices
Date:   Wed, 15 Nov 2023 15:35:37 -0500
Message-ID: <20231115191427.676248519@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 387358af685c5..b9d01a652ede2 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1131,8 +1131,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 	struct wmi_block *wblock, *next;
 	union acpi_object *obj;
 	acpi_status status;
-	int retval = 0;
 	u32 i, total;
+	int retval;
 
 	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
@@ -1143,8 +1143,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		return -ENXIO;
 
 	if (obj->type != ACPI_TYPE_BUFFER) {
-		retval = -ENXIO;
-		goto out_free_pointer;
+		kfree(obj);
+		return -ENXIO;
 	}
 
 	gblock = (const struct guid_block *)obj->buffer.pointer;
@@ -1165,8 +1165,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
 		if (!wblock) {
-			retval = -ENOMEM;
-			break;
+			dev_err(wmi_bus_dev, "Failed to allocate %pUL\n", &gblock[i].guid);
+			continue;
 		}
 
 		wblock->acpi_device = device;
@@ -1205,9 +1205,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
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



