Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62C7ED49C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbjKOU6f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344689AbjKOU5n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC491990
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045AAC32790;
        Wed, 15 Nov 2023 20:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081360;
        bh=3Gkl9d8SBacJrsmLoDMSMR/TGCMR3qsI9hTrE7bKXoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T395j8kbK19rMA3TYazlH/lo4qgNNugkR/OjcUc2Z/IEAIMazEw5vw/alcQHSgq0e
         Xoj4h4A8c4apUQuaxvNsmSFwU9G22r5IVhdrQQngGkE17wro4pLBdZ21YOQUEKMi/X
         BqbG/1KKMpaipMZzprWLBSLs9QDqQvTPa2cbQWNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 079/244] platform/x86: wmi: remove unnecessary initializations
Date:   Wed, 15 Nov 2023 15:34:31 -0500
Message-ID: <20231115203553.102537319@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Barnabás Pőcze <pobrn@protonmail.com>

[ Upstream commit 43aacf838ef7384d985ef5385ecb0124f8c70007 ]

Some pointers are initialized when they are defined,
but they are almost immediately reassigned in the
following lines. Remove these superfluous assignments.

Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>
Link: https://lore.kernel.org/r/20210904175450.156801-6-pobrn@protonmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: eba9ac7abab9 ("platform/x86: wmi: Fix opening of char device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e87ed10fd6269..530778dbdd093 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -188,7 +188,7 @@ static int get_subobj_info(acpi_handle handle, const char *pathname,
 
 static acpi_status wmi_method_enable(struct wmi_block *wblock, int enable)
 {
-	struct guid_block *block = NULL;
+	struct guid_block *block;
 	char method[5];
 	acpi_status status;
 	acpi_handle handle;
@@ -262,8 +262,8 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
 acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance,
 	u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
 {
-	struct guid_block *block = NULL;
-	struct wmi_block *wblock = NULL;
+	struct guid_block *block;
+	struct wmi_block *wblock;
 	acpi_handle handle;
 	acpi_status status;
 	struct acpi_object_list input;
@@ -310,7 +310,7 @@ EXPORT_SYMBOL_GPL(wmidev_evaluate_method);
 static acpi_status __query_block(struct wmi_block *wblock, u8 instance,
 				 struct acpi_buffer *out)
 {
-	struct guid_block *block = NULL;
+	struct guid_block *block;
 	acpi_handle handle;
 	acpi_status status, wc_status = AE_ERROR;
 	struct acpi_object_list input;
@@ -423,8 +423,8 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
 acpi_status wmi_set_block(const char *guid_string, u8 instance,
 			  const struct acpi_buffer *in)
 {
-	struct guid_block *block = NULL;
 	struct wmi_block *wblock = NULL;
+	struct guid_block *block;
 	acpi_handle handle;
 	struct acpi_object_list input;
 	union acpi_object params[2];
@@ -828,8 +828,8 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 static int wmi_char_open(struct inode *inode, struct file *filp)
 {
 	const char *driver_name = filp->f_path.dentry->d_iname;
-	struct wmi_block *wblock = NULL;
-	struct wmi_block *next = NULL;
+	struct wmi_block *wblock;
+	struct wmi_block *next;
 
 	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
 		if (!wblock->dev.dev.driver)
@@ -861,8 +861,8 @@ static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct wmi_ioctl_buffer __user *input =
 		(struct wmi_ioctl_buffer __user *) arg;
 	struct wmi_block *wblock = filp->private_data;
-	struct wmi_ioctl_buffer *buf = NULL;
-	struct wmi_driver *wdriver = NULL;
+	struct wmi_ioctl_buffer *buf;
+	struct wmi_driver *wdriver;
 	int ret;
 
 	if (_IOC_TYPE(cmd) != WMI_IOC)
-- 
2.42.0



