Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF31C7E92B2
	for <lists+stable@lfdr.de>; Sun, 12 Nov 2023 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjKLUhW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 12 Nov 2023 15:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKLUhV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 12 Nov 2023 15:37:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C39F
        for <stable@vger.kernel.org>; Sun, 12 Nov 2023 12:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699821393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JsTSvLKKtPDIeM2vbfnmEierpQqaOVW3rPX7mSajhtk=;
        b=I1q3YMaD8xcbDww0yuUGkUdhSISwtJHztjyZ4XQ7zltM77A4DR8h+bgM3xFHE3RoZ4JIMy
        IG29B5RhLXdHw/rtETMGcJKQ7wBaf+gMJfjCWXVVofMyLyD3tPeYOuWqg4cWrccOTXIZHc
        IfynV6ajHCwJjCOfI04uk7/noS/oO1Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-dYXPrEb2PkS5w759ZdYmcQ-1; Sun,
 12 Nov 2023 15:36:30 -0500
X-MC-Unique: dYXPrEb2PkS5w759ZdYmcQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9340E38C6168;
        Sun, 12 Nov 2023 20:36:29 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84F80492BE0;
        Sun, 12 Nov 2023 20:36:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Owen T . Heisler" <writer@owenh.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: [PATCH 0/2] ACPI: video: Use acpi_device_fix_up_power_children()
Date:   Sun, 12 Nov 2023 21:36:25 +0100
Message-ID: <20231112203627.34059-1-hdegoede@redhat.com>
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

Hi Rafael,

This series fixes a regression reported in 6.6:

https://lore.kernel.org/regressions/9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net/
https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
https://bugzilla.kernel.org/show_bug.cgi?id=218124

The reporter has confirmed that this series fixes things and
Kai-Heng has confirmed that backlight control still works on
the HP ZBook Fury 16 G10 for which the original
acpi_device_fix_up_power_extended() call this replaces was added.

Assuming you agree with this series, can you get it on its way
to Linus so that it can be backported to 6.6 please ?

Regards,

Hans


Hans de Goede (2):
  ACPI: PM: Add acpi_device_fix_up_power_children() function
  ACPI: video: Use acpi_device_fix_up_power_children()

 drivers/acpi/acpi_video.c |  2 +-
 drivers/acpi/device_pm.c  | 13 +++++++++++++
 include/acpi/acpi_bus.h   |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.41.0

