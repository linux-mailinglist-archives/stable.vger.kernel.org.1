Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE89B7ECA2A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjKOSCc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 13:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKOSCb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 13:02:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BE2196
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 10:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700071347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=muc3l+/+AYAwkqlKLyDW1zeJpdAEkfUOAaBIp9fTr5c=;
        b=bmHfXLjRqxCkfzJY46XRLtnFdxzijDbAPZXFh0d0E3s9pqBMOL8M9jDIMXAuLUw41JixX0
        S4UIwMkyrc9LtEe56c1KXd6HaLdcqsvIBMNs3Bo2e0UikiUNX/o2n65ZwodP0AZflYZNXN
        ppSIGG26Yqrbhb6bpdU0DK/My+TQlSE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-RKqgvyMWMyWo7zpt5ol2_A-1; Wed,
 15 Nov 2023 13:02:24 -0500
X-MC-Unique: RKqgvyMWMyWo7zpt5ol2_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED7912808FC6;
        Wed, 15 Nov 2023 18:02:23 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 497F3492BE0;
        Wed, 15 Nov 2023 18:02:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA
Date:   Wed, 15 Nov 2023 19:02:22 +0100
Message-ID: <20231115180222.10436-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Like various other ASUS ExpertBook-s, the ASUS ExpertBook B1402CVA
has an ACPI DSDT table that describes IRQ 1 as ActiveLow while
the kernel overrides it to EdgeHigh.

This prevents the keyboard from working. To fix this issue, add this laptop
to the skip_override_table so that the kernel does not override IRQ 1.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218114
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 15a3bdbd0755..9bd9f79cd409 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -447,6 +447,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1402CVA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
+		},
+	},
 	{
 		/* Asus ExpertBook B1502CBA */
 		.matches = {
-- 
2.41.0

