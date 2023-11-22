Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2167F4E4C
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 18:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjKVRY2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 12:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344017AbjKVRY1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 12:24:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3C783
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 09:24:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD7EC433C7;
        Wed, 22 Nov 2023 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700673863;
        bh=fFgsR7Df+wQ4r/dBWcoe29/fb9ZtER9bIY16tz9kn14=;
        h=Subject:To:Cc:From:Date:From;
        b=eb1bPXXTvIQp5J8XIj0mcD4QVkaIbR/y90oxZexzpmBT28O13u4KqPqmnzx6WXgI+
         XDavt/oxLqYTeJIlVxHUfjn5aRV3Wk+FOtTfbHOeSW4ST/MK+ilTwutzxSjEStGscz
         FPGGZHMtu6BEP2poTyx90xAv80FN7/G2/rlUu/H0=
Subject: FAILED: patch "[PATCH] acpi/processor: sanitize _OSC/_PDC capabilities for Xen dom0" failed to apply to 4.19-stable tree
To:     roger.pau@citrix.com, jandryuk@gmail.com, jgross@suse.com,
        michal.wilczynski@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 17:24:14 +0000
Message-ID: <2023112213-control-spent-ad42@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x bfa993b355d33a438a746523e7129391c8664e8a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112213-control-spent-ad42@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

bfa993b355d3 ("acpi/processor: sanitize _OSC/_PDC capabilities for Xen dom0")
a4a7644c1509 ("x86/xen: move paravirt lazy code")
9bd0c413b90c ("Merge branch 'acpi-processor'")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bfa993b355d33a438a746523e7129391c8664e8a Mon Sep 17 00:00:00 2001
From: Roger Pau Monne <roger.pau@citrix.com>
Date: Wed, 8 Nov 2023 16:25:15 -0500
Subject: [PATCH] acpi/processor: sanitize _OSC/_PDC capabilities for Xen dom0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Processor capability bits notify ACPI of the OS capabilities, and
so ACPI can adjust the return of other Processor methods taking the OS
capabilities into account.

When Linux is running as a Xen dom0, the hypervisor is the entity
in charge of processor power management, and hence Xen needs to make
sure the capabilities reported by _OSC/_PDC match the capabilities of
the driver in Xen.

Introduce a small helper to sanitize the buffer when running as Xen
dom0.

When Xen supports HWP, this serves as the equivalent of commit
a21211672c9a ("ACPI / processor: Request native thermal interrupt
handling via _OSC") to avoid SMM crashes.  Xen will set bit
ACPI_PROC_CAP_COLLAB_PROC_PERF (bit 12) in the capability bits and the
_OSC/_PDC call will apply it.

[ jandryuk: Mention Xen HWP's need.  Support _OSC & _PDC ]
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20231108212517.72279-1-jandryuk@gmail.com
Signed-off-by: Juergen Gross <jgross@suse.com>

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index c8a7fc23f63c..f896eed4516c 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -16,6 +16,9 @@
 #include <asm/x86_init.h>
 #include <asm/cpufeature.h>
 #include <asm/irq_vectors.h>
+#include <asm/xen/hypervisor.h>
+
+#include <xen/xen.h>
 
 #ifdef CONFIG_ACPI_APEI
 # include <asm/pgtable_types.h>
@@ -127,6 +130,17 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
 	    boot_option_idle_override == IDLE_NOMWAIT)
 		*cap &= ~(ACPI_PROC_CAP_C_C1_FFH | ACPI_PROC_CAP_C_C2C3_FFH);
+
+	if (xen_initial_domain()) {
+		/*
+		 * When Linux is running as Xen dom0, the hypervisor is the
+		 * entity in charge of the processor power management, and so
+		 * Xen needs to check the OS capabilities reported in the
+		 * processor capabilities buffer matches what the hypervisor
+		 * driver supports.
+		 */
+		xen_sanitize_proc_cap_bits(cap);
+	}
 }
 
 static inline bool acpi_has_cpu_in_madt(void)
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 7048dfacc04b..a9088250770f 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -100,4 +100,13 @@ static inline void leave_lazy(enum xen_lazy_mode mode)
 
 enum xen_lazy_mode xen_get_lazy_mode(void);
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
+void xen_sanitize_proc_cap_bits(uint32_t *buf);
+#else
+static inline void xen_sanitize_proc_cap_bits(uint32_t *buf)
+{
+	BUG();
+}
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index b3e3d1bb37f3..508655273145 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -47,6 +47,9 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
+#ifdef CONFIG_ACPI
+#include <acpi/processor.h>
+#endif
 
 /*
  * @cpu_id: Xen physical cpu logic number
@@ -400,4 +403,23 @@ bool __init xen_processor_present(uint32_t acpi_id)
 
 	return online;
 }
+
+void xen_sanitize_proc_cap_bits(uint32_t *cap)
+{
+	struct xen_platform_op op = {
+		.cmd			= XENPF_set_processor_pminfo,
+		.u.set_pminfo.id	= -1,
+		.u.set_pminfo.type	= XEN_PM_PDC,
+	};
+	u32 buf[3] = { ACPI_PDC_REVISION_ID, 1, *cap };
+	int ret;
+
+	set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
+	ret = HYPERVISOR_platform_op(&op);
+	if (ret)
+		pr_err("sanitize of _PDC buffer bits from Xen failed: %d\n",
+		       ret);
+	else
+		*cap = buf[2];
+}
 #endif

