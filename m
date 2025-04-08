Return-Path: <stable+bounces-130466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B4DA804DD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90EC4A3F21
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA39269AE4;
	Tue,  8 Apr 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GJTRNN4J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FB2698A0;
	Tue,  8 Apr 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113785; cv=none; b=N3nmhMO8Qc3YQnq4Fs8cHFkSdZOVjjDdKXCsB4LhzF+nrAW9LdVd+5XhYqzpxblqWKHFG03CtliQ1jpicmkhbw5xvfbthshnGsfwhbY3g4BBWEjCKiDFwMhdv++60Y1bN9/j697r6rrc5o/MkqxF84zqmIkWzVydI5iHpkD8wmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113785; c=relaxed/simple;
	bh=pIFA8qeLvjeIUZJACk4uFvVVKDzULxTbv4eVAqXOwIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJt9MNeknVHa7gsOLiJNGwqNFBBjhQ7syOZkaVCc3D7fdf6TCaC5zfUtbuI++jtH5CE5DrGQITAgmGxqkFb5GDCmNrUU5X+fEQVtyzj3C+YK/+43YEYGjM9GMV3M3FCbZ8o9ShpJNdySDBmFhonclsjMrHHsWrtYxTALFJ2NPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GJTRNN4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50181C4CEE5;
	Tue,  8 Apr 2025 12:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113785;
	bh=pIFA8qeLvjeIUZJACk4uFvVVKDzULxTbv4eVAqXOwIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJTRNN4JVKWMAsiWDH/TQ0zIBhjEROaA8ebjSSzt89sTROcit4RF/foEum3OhZHrz
	 hMDPJfemt2BUWk2ODn9ybv6qVcucu1kZweJS9WqhM7gKMjKC5HfwMeVVx4NJdI3ZVi
	 pAJHoMfor7nbN2yQTT1xFLZB8wCy+rBAl42oE9RA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Li RongQing <lirongqing@baidu.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Kelley <mhkelley@outlook.com>
Subject: [PATCH 5.4 002/154] clockevents/drivers/i8253: Fix stop sequence for timer 0
Date: Tue,  8 Apr 2025 12:49:03 +0200
Message-ID: <20250408104815.374879543@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104815.295196624@linuxfoundation.org>
References: <20250408104815.295196624@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 531b2ca0a940ac9db03f246c8b77c4201de72b00 upstream.

According to the data sheet, writing the MODE register should stop the
counter (and thus the interrupts). This appears to work on real hardware,
at least modern Intel and AMD systems. It should also work on Hyper-V.

However, on some buggy virtual machines the mode change doesn't have any
effect until the counter is subsequently loaded (or perhaps when the IRQ
next fires).

So, set MODE 0 and then load the counter, to ensure that those buggy VMs
do the right thing and the interrupts stop. And then write MODE 0 *again*
to stop the counter on compliant implementations too.

Apparently, Hyper-V keeps firing the IRQ *repeatedly* even in mode zero
when it should only happen once, but the second MODE write stops that too.

Userspace test program (mostly written by tglx):
=====
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdint.h>
 #include <sys/io.h>

static __always_inline void __out##bwl(type value, uint16_t port)	\
{									\
	asm volatile("out" #bwl " %" #bw "0, %w1"			\
		     : : "a"(value), "Nd"(port));			\
}									\
									\
static __always_inline type __in##bwl(uint16_t port)			\
{									\
	type value;							\
	asm volatile("in" #bwl " %w1, %" #bw "0"			\
		     : "=a"(value) : "Nd"(port));			\
	return value;							\
}

BUILDIO(b, b, uint8_t)

 #define inb __inb
 #define outb __outb

 #define PIT_MODE	0x43
 #define PIT_CH0	0x40
 #define PIT_CH2	0x42

static int is8254;

static void dump_pit(void)
{
	if (is8254) {
		// Latch and output counter and status
		outb(0xC2, PIT_MODE);
		printf("%02x %02x %02x\n", inb(PIT_CH0), inb(PIT_CH0), inb(PIT_CH0));
	} else {
		// Latch and output counter
		outb(0x0, PIT_MODE);
		printf("%02x %02x\n", inb(PIT_CH0), inb(PIT_CH0));
	}
}

int main(int argc, char* argv[])
{
	int nr_counts = 2;

	if (argc > 1)
		nr_counts = atoi(argv[1]);

	if (argc > 2)
		is8254 = 1;

	if (ioperm(0x40, 4, 1) != 0)
		return 1;

	dump_pit();

	printf("Set oneshot\n");
	outb(0x38, PIT_MODE);
	outb(0x00, PIT_CH0);
	outb(0x0F, PIT_CH0);

	dump_pit();
	usleep(1000);
	dump_pit();

	printf("Set periodic\n");
	outb(0x34, PIT_MODE);
	outb(0x00, PIT_CH0);
	outb(0x0F, PIT_CH0);

	dump_pit();
	usleep(1000);
	dump_pit();
	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	printf("Set stop (%d counter writes)\n", nr_counts);
	outb(0x30, PIT_MODE);
	while (nr_counts--)
		outb(0xFF, PIT_CH0);

	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	printf("Set MODE 0\n");
	outb(0x30, PIT_MODE);

	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	return 0;
}
=====

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhkelley@outlook.com>
Link: https://lore.kernel.org/all/20240802135555.564941-2-dwmw2@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mshyperv.c |   11 -----------
 drivers/clocksource/i8253.c    |   36 +++++++++++++++++++++++++-----------
 include/linux/i8253.h          |    1 -
 3 files changed, 25 insertions(+), 23 deletions(-)

--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
-#include <linux/i8253.h>
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
@@ -310,16 +309,6 @@ static void __init ms_hyperv_init_platfo
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason = hv_get_nmi_reason;
 
-	/*
-	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
-	 * counter register during PIT shutdown restarts the PIT. So it
-	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
-	 * to false tells pit_shutdown() not to zero the counter so that
-	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
-	 * and setting this value has no effect.
-	 */
-	i8253_clear_counter_on_shutdown = false;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
 	 * Setup the hook to get control post apic initialization.
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,13 +20,6 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-/*
- * Handle PIT quirk in pit_shutdown() where zeroing the counter register
- * restarts the PIT, negating the shutdown. On platforms with the quirk,
- * platform specific code can set this to false.
- */
-bool i8253_clear_counter_on_shutdown __ro_after_init = true;
-
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -112,12 +105,33 @@ void clockevent_i8253_disable(void)
 {
 	raw_spin_lock(&i8253_lock);
 
+	/*
+	 * Writing the MODE register should stop the counter, according to
+	 * the datasheet. This appears to work on real hardware (well, on
+	 * modern Intel and AMD boxes; I didn't dig the Pegasos out of the
+	 * shed).
+	 *
+	 * However, some virtual implementations differ, and the MODE change
+	 * doesn't have any effect until either the counter is written (KVM
+	 * in-kernel PIT) or the next interrupt (QEMU). And in those cases,
+	 * it may not stop the *count*, only the interrupts. Although in
+	 * the virt case, that probably doesn't matter, as the value of the
+	 * counter will only be calculated on demand if the guest reads it;
+	 * it's the interrupts which cause steal time.
+	 *
+	 * Hyper-V apparently has a bug where even in mode 0, the IRQ keeps
+	 * firing repeatedly if the counter is running. But it *does* do the
+	 * right thing when the MODE register is written.
+	 *
+	 * So: write the MODE and then load the counter, which ensures that
+	 * the IRQ is stopped on those buggy virt implementations. And then
+	 * write the MODE again, which is the right way to stop it.
+	 */
 	outb_p(0x30, PIT_MODE);
+	outb_p(0, PIT_CH0);
+	outb_p(0, PIT_CH0);
 
-	if (i8253_clear_counter_on_shutdown) {
-		outb_p(0, PIT_CH0);
-		outb_p(0, PIT_CH0);
-	}
+	outb_p(0x30, PIT_MODE);
 
 	raw_spin_unlock(&i8253_lock);
 }
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,7 +21,6 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
-extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 extern void clockevent_i8253_disable(void);



