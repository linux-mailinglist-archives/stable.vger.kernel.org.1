Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A25A7E92B1
	for <lists+stable@lfdr.de>; Sun, 12 Nov 2023 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjKLUhW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 12 Nov 2023 15:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLUhV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 12 Nov 2023 15:37:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9391BEC
        for <stable@vger.kernel.org>; Sun, 12 Nov 2023 12:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699821395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XB27vvNlE5JoGUSZp+feCASAqXEyzXmaur0aYywviWM=;
        b=I48scZWbcdcghHwE7tajRR8z9DXGyeJRCFGgP0kPkIwelu60Kw+VvrzVBvjoA7keZRaUFz
        TgzmFSDp0dSTRRbICtxMcNc+Va+OLfSkVF2oOYPYOFSao0h7CZnpJbdv4aDJVbkaUj4g/3
        VkyoZbdDzbBKA9918cYHLkjYtH31/ak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-sOyc76nsMvOUfrp2PlvT0w-1; Sun, 12 Nov 2023 15:36:31 -0500
X-MC-Unique: sOyc76nsMvOUfrp2PlvT0w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1314811E7E;
        Sun, 12 Nov 2023 20:36:30 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4D95492BE0;
        Sun, 12 Nov 2023 20:36:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Owen T . Heisler" <writer@owenh.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: [PATCH 1/2] ACPI: PM: Add acpi_device_fix_up_power_children() function
Date:   Sun, 12 Nov 2023 21:36:26 +0100
Message-ID: <20231112203627.34059-2-hdegoede@redhat.com>
In-Reply-To: <20231112203627.34059-1-hdegoede@redhat.com>
References: <20231112203627.34059-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In some cases it is necessary to fix-up the power-state of an ACPI
device's children without touching the ACPI device itself add
a new acpi_device_fix_up_power_children() function for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/device_pm.c | 13 +++++++++++++
 include/acpi/acpi_bus.h  |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index f007116a8427..3b4d048c4941 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -397,6 +397,19 @@ void acpi_device_fix_up_power_extended(struct acpi_device *adev)
 }
 EXPORT_SYMBOL_GPL(acpi_device_fix_up_power_extended);
 
+/**
+ * acpi_device_fix_up_power_children - Force a device's children into D0.
+ * @adev: Parent device object whose children's power state is to be fixed up.
+ *
+ * Call acpi_device_fix_up_power() for @adev's children so long as they
+ * are reported as present and enabled.
+ */
+void acpi_device_fix_up_power_children(struct acpi_device *adev)
+{
+	acpi_dev_for_each_child(adev, fix_up_power_if_applicable, NULL);
+}
+EXPORT_SYMBOL_GPL(acpi_device_fix_up_power_children);
+
 int acpi_device_update_power(struct acpi_device *device, int *state_p)
 {
 	int state;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 254685085c82..0b7eab0ef7d7 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -539,6 +539,7 @@ int acpi_device_set_power(struct acpi_device *device, int state);
 int acpi_bus_init_power(struct acpi_device *device);
 int acpi_device_fix_up_power(struct acpi_device *device);
 void acpi_device_fix_up_power_extended(struct acpi_device *adev);
+void acpi_device_fix_up_power_children(struct acpi_device *adev);
 int acpi_bus_update_power(acpi_handle handle, int *state_p);
 int acpi_device_update_power(struct acpi_device *device, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
-- 
2.41.0

