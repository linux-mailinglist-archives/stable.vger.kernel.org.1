Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA687E92B3
	for <lists+stable@lfdr.de>; Sun, 12 Nov 2023 21:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjKLUh0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 12 Nov 2023 15:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKLUh0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 12 Nov 2023 15:37:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DF71BF1
        for <stable@vger.kernel.org>; Sun, 12 Nov 2023 12:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699821395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x703n5m/huxGQpSwMQTbXn4dKDCTn+ltBPMf6K5zZZ4=;
        b=ZznN0lzhoPsEUzU0mX8rriQXb5kCE/ny7bNbAum3JXZT9v8/16LLGU8hZsYeaRvLIqSJJT
        4tiXCd4hd6lt47og7OQgmPVittZ1d4v1cYXW5Z0CQxIi2ZsrXXTecMDQtGd7la1po6OFJ7
        8SfNZpse6nlETXdnk7YUM2Dvqz6l3g8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-oHpp85fFNkKWbJGuS28fnA-1; Sun, 12 Nov 2023 15:36:32 -0500
X-MC-Unique: oHpp85fFNkKWbJGuS28fnA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0DF085A58A;
        Sun, 12 Nov 2023 20:36:31 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3917492BE0;
        Sun, 12 Nov 2023 20:36:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Owen T . Heisler" <writer@owenh.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: [PATCH 2/2] ACPI: video: Use acpi_device_fix_up_power_children()
Date:   Sun, 12 Nov 2023 21:36:27 +0100
Message-ID: <20231112203627.34059-3-hdegoede@redhat.com>
In-Reply-To: <20231112203627.34059-1-hdegoede@redhat.com>
References: <20231112203627.34059-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Commit 89c290ea7589 ("ACPI: video: Put ACPI video and its child devices
into D0 on boot") introduced calling acpi_device_fix_up_power_extended()
on the video card for which the ACPI video bus is the companion device.

This unnecessarily touches the power-state of the GPU itself, while
the issue it tries to address only requires calling _PS0 on the child
devices.

Touching the power-state of the GPU itself is causing suspend / resume
issues on e.g. a Lenovo ThinkPad W530.

Instead use acpi_device_fix_up_power_children(), which only touches
the child devices, to fix this.

Fixes: 89c290ea7589 ("ACPI: video: Put ACPI video and its child devices into D0 on boot")
Reported-by: Owen T. Heisler <writer@owenh.net>
Closes: https://lore.kernel.org/regressions/9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net/
Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218124
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Owen T. Heisler <writer@owenh.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index b411948594ff..4e868454b38d 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2031,7 +2031,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	 * HP ZBook Fury 16 G10 requires ACPI video's child devices have _PS0
 	 * evaluated to have functional panel brightness control.
 	 */
-	acpi_device_fix_up_power_extended(device);
+	acpi_device_fix_up_power_children(device);
 
 	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
-- 
2.41.0

