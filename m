Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E83726D6B
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjFGUlw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjFGUlv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B87810FB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 249DA64622
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9C4C4339C;
        Wed,  7 Jun 2023 20:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170508;
        bh=1dT7wFJkBWARaM4TgchDygUGMMDM7LjG4SIsDJ+dEPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/RxvD8aBLEZ3Un8EOpz8SZwBVTIdeSR5vt+ImhS45D6xav3eh3kPsEE/GD1ypLcD
         D6SaIZjyWlPcRCZ1lOqvGwaW27PsRib50FXR9p6OEai1ssN9CONuw81L3TaSnKv7av
         mzpY5K0obZ4W9BgnHuKOBQ5Dg6jd07NNDyupSKvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rub=C3=A9n=20G=C3=B3mez=20Agudo?= <mrgommer@proton.me>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 111/225] ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P
Date:   Wed,  7 Jun 2023 22:15:04 +0200
Message-ID: <20230607200918.008117183@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

From: Rubén Gómez <mrgommer@proton.me>

[ Upstream commit 71a485624c4cbb144169852d7bb8ca8c0667d7a3 ]

Add an ACPI IRQ override quirk for LG UltraPC 17U70P to address the
internal keyboard problem on it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=213031
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216983
Signed-off-by: Rubén Gómez Agudo <mrgommer@proton.me>
[ rjw: Subject, changelog, white space damage fixes ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d08818baea88f..a7f12bdbc5e25 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -502,6 +502,17 @@ static const struct dmi_system_id maingear_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id lg_laptop[] = {
+	{
+		.ident = "LG Electronics 17U70P",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -518,6 +529,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
+	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.39.2



