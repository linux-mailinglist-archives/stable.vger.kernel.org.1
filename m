Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB27ECE29
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjKOTlQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjKOTlP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D6B9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFADC433C8;
        Wed, 15 Nov 2023 19:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077272;
        bh=hqeJWnJD67DkyrBJCeTvCo9QeRJPom72fRbP16KD5Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=war1Autb4h8JGxSGLMVMzV4ZrlDGyABgj+0iQD23cgFIdLECHvcnwW9a6nIppH3Lx
         iImfSDn0gQPp7CopHLJSHgWEk5jOiftSsSYomccH4sHq8Ueaq2IDFpbOSsrayIxZu/
         WEenoJI8ogdAXxqFBkojL6n11C5193k8tOI8zwCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 201/603] platform/x86: wmi: Fix opening of char device
Date:   Wed, 15 Nov 2023 14:12:26 -0500
Message-ID: <20231115191627.164107985@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit eba9ac7abab91c8f6d351460239108bef5e7a0b6 ]

Since commit fa1f68db6ca7 ("drivers: misc: pass miscdevice pointer via
file private data"), the miscdevice stores a pointer to itself inside
filp->private_data, which means that private_data will not be NULL when
wmi_char_open() is called. This might cause memory corruption should
wmi_char_open() be unable to find its driver, something which can
happen when the associated WMI device is deleted in wmi_free_devices().

Fix the problem by using the miscdevice pointer to retrieve the WMI
device data associated with a char device using container_of(). This
also avoids wmi_char_open() picking a wrong WMI device bound to a
driver with the same name as the original driver.

Fixes: 44b6b7661132 ("platform/x86: wmi: create userspace interface for drivers")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20231020211005.38216-5-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7d11ff5bc856c..317c907304149 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -911,21 +911,13 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 }
 static int wmi_char_open(struct inode *inode, struct file *filp)
 {
-	const char *driver_name = filp->f_path.dentry->d_iname;
-	struct wmi_block *wblock;
-	struct wmi_block *next;
-
-	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
-		if (!wblock->dev.dev.driver)
-			continue;
-		if (strcmp(driver_name, wblock->dev.dev.driver->name) == 0) {
-			filp->private_data = wblock;
-			break;
-		}
-	}
+	/*
+	 * The miscdevice already stores a pointer to itself
+	 * inside filp->private_data
+	 */
+	struct wmi_block *wblock = container_of(filp->private_data, struct wmi_block, char_dev);
 
-	if (!filp->private_data)
-		return -ENODEV;
+	filp->private_data = wblock;
 
 	return nonseekable_open(inode, filp);
 }
-- 
2.42.0



