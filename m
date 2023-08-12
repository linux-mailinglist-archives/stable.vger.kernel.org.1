Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BDB77A090
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjHLOtD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjHLOtD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 10:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829DE5C
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691851705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0IMICko4vpPXMALZSiPlQBtZlh1R3KvvhQyqt0ZWgw8=;
        b=DeUEluCDHO40mFDdouQpH3FrjzSOEfqMXDb7LWIFc0pykxiNFXkPfFS29gsaHNveH6baOc
        Af7MXHerHENTfFjsAydnsVlIXl9q33BJgo5DUogz9DVdMwVkGvYFaEfnl7QGczw6Aj/Q+e
        2LkWD8Cq5TS3R4uqeqR7UbvbSe9T4b4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-XheCZIocN56g1KMa4tjP1Q-1; Sat, 12 Aug 2023 10:48:21 -0400
X-MC-Unique: XheCZIocN56g1KMa4tjP1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AAA01C05155;
        Sat, 12 Aug 2023 14:48:21 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 430A72026D4B;
        Sat, 12 Aug 2023 14:48:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, Gergo Koteles <soyer@irl.hu>,
        Andrew Kallmeyer <kallmeyeras@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
        stable@vger.kernel.org
Subject: [PATCH] platform/x86: lenovo-ymc: Only bind on machines with a convertible DMI chassis-type
Date:   Sat, 12 Aug 2023 16:48:18 +0200
Message-ID: <20230812144818.383230-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The lenovo-ymc driver is causing the keyboard + touchpad to stop working
on some regular laptop models such as the Lenovo ThinkBook 13s G2 ITL 20V9.

The problem is that there are YMC WMI GUID methods in the ACPI tables
of these laptops, despite them not being Yogas and lenovo-ymc loading
causes libinput to see a SW_TABLET_MODE switch with state 1.

This in turn causes libinput to ignore events from the builtin keyboard
and touchpad, since it filters those out for a Yoga in tablet mode.

Similar issues with false-positive SW_TABLET_MODE=1 reporting have
been seen with the intel-hid driver.

Copy the intel-hid driver approach to fix this and only bind to the WMI
device on machines where the DMI chassis-type indicates the machine
is a convertible.

Add a 'force' module parameter to allow overriding the chassis-type check
so that users can easily test if the YMC interface works on models which
report an unexpected chassis-type.

Fixes: e82882cdd241 ("platform/x86: Add driver for Yoga Tablet Mode switch")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229373
Cc: Gergo Koteles <soyer@irl.hu>
Cc: Andrew Kallmeyer <kallmeyeras@gmail.com>
Cc: André Apitzsch <git@apitzsch.eu>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note: The chassis-type can be checked by doing:
cat /sys/class/dmi/id/chassis_type
if this reports 31 or 32 then this patch should not have any impact
on your machine.
---
 drivers/platform/x86/lenovo-ymc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index 41676188b373..f360370d5002 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -24,6 +24,10 @@ static bool ec_trigger __read_mostly;
 module_param(ec_trigger, bool, 0444);
 MODULE_PARM_DESC(ec_trigger, "Enable EC triggering work-around to force emitting tablet mode events");
 
+static bool force;
+module_param(force, bool, 0444);
+MODULE_PARM_DESC(force, "Force loading on boards without a convertible DMI chassis-type");
+
 static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
 	{
 		/* Lenovo Yoga 7 14ARB7 */
@@ -35,6 +39,20 @@ static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
 	{ }
 };
 
+static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "31" /* Convertible */),
+		},
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "32" /* Detachable */),
+		},
+	},
+	{ }
+};
+
 struct lenovo_ymc_private {
 	struct input_dev *input_dev;
 	struct acpi_device *ec_acpi_dev;
@@ -111,6 +129,13 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 	struct input_dev *input_dev;
 	int err;
 
+	if (!dmi_check_system(allowed_chasis_types_dmi_table)) {
+		if (force)
+			dev_info(&wdev->dev, "Force loading Lenovo YMC support\n");
+		else
+			return -ENODEV;
+	}
+
 	ec_trigger |= dmi_check_system(ec_trigger_quirk_dmi_table);
 
 	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
-- 
2.41.0

