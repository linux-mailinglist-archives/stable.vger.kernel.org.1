Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351687611BA
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGYKzb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjGYKys (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A746B5
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB6A615FE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351E5C433C7;
        Tue, 25 Jul 2023 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282368;
        bh=1Y5JUZC0hk2+VhStkGcp8Komml8YDXrr6ysKpN0AVgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpEkmo2+b3ZPp5xBwZJWz77kgHKw2fgtucgS+oCwCzDGYrgSO5pcVApifR7G21nVy
         xB8qA3in5OEPxsZsEeA/cZtXpINjipOe9BQsHnnNOMMJXC7wH/HTaZWKY2OnXftDdL
         SH5Wc7j+IgZtHWVLW2Jg5IMQslvjrffNfLAe8CJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, raycekarneal <raycekarneal@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 105/227] ACPI: video: Add backlight=native DMI quirk for Dell Studio 1569
Date:   Tue, 25 Jul 2023 12:44:32 +0200
Message-ID: <20230725104519.113149291@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 23d28cc0444be3f694eb986cd653b6888b78431d ]

The Dell Studio 1569 predates Windows 8, so it defaults to using
acpi_video# for backlight control, but this is non functional on
this model.

Add a DMI quirk to use the native intel_backlight interface which
does work properly.

Reported-by: raycekarneal <raycekarneal@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b87783c5872dd..e7d04ab864a16 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -528,6 +528,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell Studio 1569 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Studio 1569"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Acer Aspire 3830TG */
-- 
2.39.2



