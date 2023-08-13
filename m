Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4F77ABD3
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjHMV0I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjHMV0I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4406810DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFCFF6297C
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C99C433C7;
        Sun, 13 Aug 2023 21:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961969;
        bh=sFO2V6gfJhuRkE9OKUSZir4ZftAlrru0CHl6t1JXMTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwEXqud2DI7MOEPv4ZGU63vUGOutJ+ZgzcZlmMakRYwwUiVIyJUzfCaFSi+YpjC2K
         lkjnX/mn4Xftk3/5MCth3veQEOefdS6FWvvFsEVpxRHjOaR/XEmb9OipNSRy5ALYgZ
         HlOcL96N9H881akqvW74qIrc4Uz7SkUal0Nt9w08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.4 025/206] ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen
Date:   Sun, 13 Aug 2023 23:16:35 +0200
Message-ID: <20230813211725.712309755@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit c6a1fd910d1bf8a0e3db7aebb229e3c81bc305c4 upstream.

On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
settings over the MADT settings.

This causes the keyboard to malfunction on some laptop models
(see Links), all models from the Links have an INT_SRC_OVR MADT entry
for IRQ 1.

Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217336
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217406
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/acpi.h | 2 ++
 arch/x86/kernel/acpi/boot.c | 4 ++++
 drivers/acpi/resource.c     | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 8eb74cf386db..2888c0ee4df0 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -15,6 +15,7 @@
 #include <asm/mpspec.h>
 #include <asm/x86_init.h>
 #include <asm/cpufeature.h>
+#include <asm/irq_vectors.h>
 
 #ifdef CONFIG_ACPI_APEI
 # include <asm/pgtable_types.h>
@@ -31,6 +32,7 @@ extern int acpi_skip_timer_override;
 extern int acpi_use_timer_override;
 extern int acpi_fix_pin2_polarity;
 extern int acpi_disable_cmcff;
+extern bool acpi_int_src_ovr[NR_IRQS_LEGACY];
 
 extern u8 acpi_sci_flags;
 extern u32 acpi_sci_override_gsi;
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 21b542a6866c..53369c57751e 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -52,6 +52,7 @@ int acpi_lapic;
 int acpi_ioapic;
 int acpi_strict;
 int acpi_disable_cmcff;
+bool acpi_int_src_ovr[NR_IRQS_LEGACY];
 
 /* ACPI SCI override configuration */
 u8 acpi_sci_flags __initdata;
@@ -588,6 +589,9 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
 
 	acpi_table_print_madt_entry(&header->common);
 
+	if (intsrc->source_irq < NR_IRQS_LEGACY)
+		acpi_int_src_ovr[intsrc->source_irq] = true;
+
 	if (intsrc->source_irq == acpi_gbl_FADT.sci_interrupt) {
 		acpi_sci_ioapic_setup(intsrc->source_irq,
 				      intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 380cda1e86f4..8e32dd5776f5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -551,6 +551,10 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 	if (gsi != 1 && gsi != 12)
 		return true;
 
+	/* If the override comes from an INT_SRC_OVR MADT entry, honor it. */
+	if (acpi_int_src_ovr[gsi])
+		return true;
+
 	/*
 	 * IRQ override isn't needed on modern AMD Zen systems and
 	 * this override breaks active low IRQs on AMD Ryzen 6000 and
-- 
2.41.0



