Return-Path: <stable+bounces-10606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F082C7E8
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 00:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877E5286898
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 23:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4AD199C5;
	Fri, 12 Jan 2024 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dDzyK2yo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4E18EA9;
	Fri, 12 Jan 2024 23:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64448C433C7;
	Fri, 12 Jan 2024 23:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705101699;
	bh=r0oKpMMxCQVWlxoNfe8xYNc9eVXRcGeB1JGlfD3uUkI=;
	h=Date:To:From:Subject:From;
	b=dDzyK2yoJRIaXmevaVe1mnH8AB2WFtib/aOw0AccLFHJ2fvH3TD6UUofas9NkLFGb
	 PCkHG5gO6unsRWJEt1CsQXRTfrOnKe0uU/ZfAAI8ZmvQcVjFbB2ez/fKYAyEsiQVUK
	 cPxdBB9u7BRJ4slyswU9VewMFVtDAAvcTeF6aHdk=
Date: Fri, 12 Jan 2024 15:21:38 -0800
To: mm-commits@vger.kernel.org,wens@csie.org,tony.luck@intel.com,tglx@linutronix.de,stable@vger.kernel.org,sre@kernel.org,seanjc@google.com,samuel@sholland.org,pbonzini@redhat.com,pavel@ucw.cz,orsonzhai@gmail.com,mingo@redhat.com,maz@kernel.org,jschoenh@amazon.de,jernej.skrabec@gmail.com,graf@amazon.de,ebiederm@xmission.com,bp@alien8.de,bhe@redhat.com,arnd@arndb.de,jgowans@amazon.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] kexec-do-syscore_shutdown-in-kernel_kexec.patch removed from -mm tree
Message-Id: <20240112232139.64448C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: kexec: do syscore_shutdown() in kernel_kexec
has been removed from the -mm tree.  Its filename was
     kexec-do-syscore_shutdown-in-kernel_kexec.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: James Gowans <jgowans@amazon.com>
Subject: kexec: do syscore_shutdown() in kernel_kexec
Date: Wed, 13 Dec 2023 08:40:04 +0200

syscore_shutdown() runs driver and module callbacks to get the system into
a state where it can be correctly shut down.  In commit 6f389a8f1dd2 ("PM
/ reboot: call syscore_shutdown() after disable_nonboot_cpus()")
syscore_shutdown() was removed from kernel_restart_prepare() and hence got
(incorrectly?) removed from the kexec flow.  This was innocuous until
commit 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to
hook restart/shutdown") changed the way that KVM registered its shutdown
callbacks, switching from reboot notifiers to syscore_ops.shutdown.  As
syscore_shutdown() is missing from kexec, KVM's shutdown hook is not run
and virtualisation is left enabled on the boot CPU which results in triple
faults when switching to the new kernel on Intel x86 VT-x with VMXE
enabled.

Fix this by adding syscore_shutdown() to the kexec sequence.  In terms of
where to add it, it is being added after migrating the kexec task to the
boot CPU, but before APs are shut down.  It is not totally clear if this
is the best place: in commit 6f389a8f1dd2 ("PM / reboot: call
syscore_shutdown() after disable_nonboot_cpus()") it is stated that
"syscore_ops operations should be carried with one CPU on-line and
interrupts disabled." APs are only offlined later in machine_shutdown(),
so this syscore_shutdown() is being run while APs are still online.  This
seems to be the correct place as it matches where syscore_shutdown() is
run in the reboot and halt flows - they also run it before APs are shut
down.  The assumption is that the commit message in commit 6f389a8f1dd2
("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()") is
no longer valid.

KVM has been discussed here as it is what broke loudly by not having
syscore_shutdown() in kexec, but this change impacts more than just KVM;
all drivers/modules which register a syscore_ops.shutdown callback will
now be invoked in the kexec flow.  Looking at some of them like x86 MCE it
is probably more correct to also shut these down during kexec. 
Maintainers of all drivers which use syscore_ops.shutdown are added on CC
for visibility.  They are:

arch/powerpc/platforms/cell/spu_base.c  .shutdown = spu_shutdown,
arch/x86/kernel/cpu/mce/core.c	        .shutdown = mce_syscore_shutdown,
arch/x86/kernel/i8259.c                 .shutdown = i8259A_shutdown,
drivers/irqchip/irq-i8259.c	        .shutdown = i8259A_shutdown,
drivers/irqchip/irq-sun6i-r.c	        .shutdown = sun6i_r_intc_shutdown,
drivers/leds/trigger/ledtrig-cpu.c	.shutdown = ledtrig_cpu_syscore_shutdown,
drivers/power/reset/sc27xx-poweroff.c	.shutdown = sc27xx_poweroff_shutdown,
kernel/irq/generic-chip.c	        .shutdown = irq_gc_shutdown,
virt/kvm/kvm_main.c	                .shutdown = kvm_shutdown,

This has been tested by doing a kexec on x86_64 and aarch64.

Link: https://lkml.kernel.org/r/20231213064004.2419447-1-jgowans@amazon.com
Fixes: 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Alexander Graf <graf@amazon.de>
Cc: Jan H. Schoenherr <jschoenh@amazon.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/kexec_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/kexec_core.c~kexec-do-syscore_shutdown-in-kernel_kexec
+++ a/kernel/kexec_core.c
@@ -1257,6 +1257,7 @@ int kernel_kexec(void)
 		kexec_in_progress = true;
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
+		syscore_shutdown();
 
 		/*
 		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
_

Patches currently in -mm which might be from jgowans@amazon.com are



