Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC25C7E2339
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjKFNKE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjKFNKD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:10:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B2BD
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:10:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171DDC433C7;
        Mon,  6 Nov 2023 13:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276200;
        bh=2N0/zHTyXVuUHWNg84iIp7An3iSyePKOPmgY6outoGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbtHGQ8qjxUr5Iu0FlTANd5KsS1209eiLBvWiMvjAuIPI+JoLJDuqdBJpC5ZPii02
         GE/3zA0cB9VKwqchlkHCMr0yUh2dK4j+JYNMFhwDCbRSOEoINnrgR/JfIUpu5OrNV7
         iJTjY5tJd5F0VtL3DJqE/RlqPNlDaY077WgxGllA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Lazar <dlazar@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4.19 23/61] x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility
Date:   Mon,  6 Nov 2023 14:03:19 +0100
Message-ID: <20231106130300.404006374@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 128b0c9781c9f2651bea163cb85e52a6c7be0f9e upstream.

David and a few others reported that on certain newer systems some legacy
interrupts fail to work correctly.

Debugging revealed that the BIOS of these systems leaves the legacy PIC in
uninitialized state which makes the PIC detection fail and the kernel
switches to a dummy implementation.

Unfortunately this fallback causes quite some code to fail as it depends on
checks for the number of legacy PIC interrupts or the availability of the
real PIC.

In theory there is no reason to use the PIC on any modern system when
IO/APIC is available, but the dependencies on the related checks cannot be
resolved trivially and on short notice. This needs lots of analysis and
rework.

The PIC detection has been added to avoid quirky checks and force selection
of the dummy implementation all over the place, especially in VM guest
scenarios. So it's not an option to revert the relevant commit as that
would break a lot of other scenarios.

One solution would be to try to initialize the PIC on detection fail and
retry the detection, but that puts the burden on everything which does not
have a PIC.

Fortunately the ACPI/MADT table header has a flag field, which advertises
in bit 0 that the system is PCAT compatible, which means it has a legacy
8259 PIC.

Evaluate that bit and if set avoid the detection routine and keep the real
PIC installed, which then gets initialized (for nothing) and makes the rest
of the code with all the dependencies work again.

Fixes: e179f6914152 ("x86, irq, pic: Probe for legacy PIC and set legacy_pic appropriately")
Reported-by: David Lazar <dlazar@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: David Lazar <dlazar@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218003
Link: https://lore.kernel.org/r/875y2u5s8g.ffs@tglx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/i8259.h |    2 ++
 arch/x86/kernel/acpi/boot.c  |    3 +++
 arch/x86/kernel/i8259.c      |   38 ++++++++++++++++++++++++++++++--------
 3 files changed, 35 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -67,6 +67,8 @@ struct legacy_pic {
 	void (*make_irq)(unsigned int irq);
 };
 
+void legacy_pic_pcat_compat(void);
+
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -156,6 +156,9 @@ static int __init acpi_parse_madt(struct
 		       madt->address);
 	}
 
+	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
+		legacy_pic_pcat_compat();
+
 	default_acpi_madt_oem_check(madt->header.oem_id,
 				    madt->header.oem_table_id);
 
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -32,6 +32,7 @@
  */
 static void init_8259A(int auto_eoi);
 
+static bool pcat_compat __ro_after_init;
 static int i8259A_auto_eoi;
 DEFINE_RAW_SPINLOCK(i8259A_lock);
 
@@ -301,15 +302,32 @@ static void unmask_8259A(void)
 
 static int probe_8259A(void)
 {
+	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
 	unsigned long flags;
-	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
-	unsigned char new_val;
+
+	/*
+	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
+	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
+	 * fails.
+	 *
+	 * Right now this causes problems as quite some code depends on
+	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
+	 * when the system has an IO/APIC because then PIC is not required
+	 * at all, except for really old machines where the timer interrupt
+	 * must be routed through the PIC. So just pretend that the PIC is
+	 * there and let legacy_pic->init() initialize it for nothing.
+	 *
+	 * Alternatively this could just try to initialize the PIC and
+	 * repeat the probe, but for cases where there is no PIC that's
+	 * just pointless.
+	 */
+	if (pcat_compat)
+		return nr_legacy_irqs();
+
 	/*
-	 * Check to see if we have a PIC.
-	 * Mask all except the cascade and read
-	 * back the value we just wrote. If we don't
-	 * have a PIC, we will read 0xff as opposed to the
-	 * value we wrote.
+	 * Check to see if we have a PIC.  Mask all except the cascade and
+	 * read back the value we just wrote. If we don't have a PIC, we
+	 * will read 0xff as opposed to the value we wrote.
 	 */
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 
@@ -431,5 +449,9 @@ static int __init i8259A_init_ops(void)
 
 	return 0;
 }
-
 device_initcall(i8259A_init_ops);
+
+void __init legacy_pic_pcat_compat(void)
+{
+	pcat_compat = true;
+}


