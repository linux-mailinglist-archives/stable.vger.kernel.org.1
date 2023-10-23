Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF9C7D33BF
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjJWLdn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjJWLdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:33:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAECE4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:33:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9DDC433C8;
        Mon, 23 Oct 2023 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060819;
        bh=0gerTLoR77TQrbdHlkntlQhLQXPaCvSd6VA+cPGBhZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5o+spj2KHchQ/joZkOUiOhG0Muth/pC0Apss2lmn+RhrRGUkmPQECnM93Zr4Ghdi
         7/vstPH7XCT+kvsmTeKYjMlSpeP7rg5s98u5s5V4C+5ReyoA3rwmgUAOST+q0VZiqT
         xApUc/W1CBPE2PWNwThOxpDsw2Kn8WU+zWhmr2fw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hui Wang <hui.wang@canonical.com>,
        Tamim Khan <tamim@fusetak.com>,
        Sunand <sunandchakradhar@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 076/123] ACPI: resource: Skip IRQ override on Asus Vivobook K3402ZA/K3502ZA
Date:   Mon, 23 Oct 2023 12:57:14 +0200
Message-ID: <20231023104820.246017961@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tamim Khan <tamim@fusetak.com>

[ Upstream commit e12dee3736731e24b1e7367f87d66ac0fcd73ce7 ]

In the ACPI DSDT table for Asus VivoBook K3402ZA/K3502ZA
IRQ 1 is described as ActiveLow; however, the kernel overrides
it to Edge_High. This prevents the internal keyboard from working
on these laptops. In order to fix this add these laptops to the
skip_override_table so that the kernel does not override IRQ 1 to
Edge_High.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216158
Reviewed-by: Hui Wang <hui.wang@canonical.com>
Tested-by: Tamim Khan <tamim@fusetak.com>
Tested-by: Sunand <sunandchakradhar@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: c1ed72171ed5 ("ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 6489dd3ff0741..27b364e23c60b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -392,6 +392,24 @@ static const struct dmi_system_id medion_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id asus_laptop[] = {
+	{
+		.ident = "Asus Vivobook K3402ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "K3402ZA"),
+		},
+	},
+	{
+		.ident = "Asus Vivobook K3502ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -402,6 +420,7 @@ struct irq_override_cmp {
 
 static const struct irq_override_cmp skip_override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
+	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.40.1



