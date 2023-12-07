Return-Path: <stable+bounces-4883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36058807CD0
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58721F21164
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 00:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C353E367;
	Thu,  7 Dec 2023 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="t4e71x2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1E7E
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C687C433CC;
	Thu,  7 Dec 2023 00:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701908019;
	bh=5FhykYyDD2nCFOFg8BQ8NwemdatsLnWM+1ucVFLFwhs=;
	h=Date:To:From:Subject:From;
	b=t4e71x2cJH4pIXrq0lQXiZvzm1mDeJqUgoJpoZ5xPNRG7MbLBRrXhX5PG2gsFLlsx
	 O7xVl7/0kY12NrRt5v8w2Wgz+BHlX/uCxbLlcI0s790wLltOxOVHNa/SQkh95U5KI0
	 GKB4iXD+ik0XUAAUY017f3fXeIjLoIPrEHJAZKms=
Date: Wed, 06 Dec 2023 16:13:38 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ignat@cloudflare.com,eric_devolder@yahoo.com,agordeev@linux.ibm.com,bhe@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] drivers-base-cpu-crash-data-showing-should-depends-on-kexec_core.patch removed from -mm tree
Message-Id: <20231207001339.4C687C433CC@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: drivers/base/cpu: crash data showing should depends on KEXEC_CORE
has been removed from the -mm tree.  Its filename was
     drivers-base-cpu-crash-data-showing-should-depends-on-kexec_core.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Baoquan He <bhe@redhat.com>
Subject: drivers/base/cpu: crash data showing should depends on KEXEC_CORE
Date: Tue, 28 Nov 2023 13:52:48 +0800

After commit 88a6f8994421 ("crash: memory and CPU hotplug sysfs
attributes"), on x86_64, if only below kernel configs related to kdump are
set, compiling error are triggered.

----
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
CONFIG_CRASH_HOTPLUG=y
------

------------------------------------------------------
drivers/base/cpu.c: In function `crash_hotplug_show':
drivers/base/cpu.c:309:40: error: implicit declaration of function `crash_hotplug_cpu_support'; did you mean `crash_hotplug_show'? [-Werror=implicit-function-declaration]
  309 |         return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
      |                                        crash_hotplug_show
cc1: some warnings being treated as errors
------------------------------------------------------

CONFIG_KEXEC is used to enable kexec_load interface, the
crash_notes/crash_notes_size/crash_hotplug showing depends on
CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.

Fix it now.

Link: https://lkml.kernel.org/r/20231128055248.659808-1-bhe@redhat.com
Fixes: 88a6f8994421 ("crash: memory and CPU hotplug sysfs attributes")
Signed-off-by: Baoquan He <bhe@redhat.com>
Tested-by: Ignat Korchagin <ignat@cloudflare.com>	[compile-time only]
Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Eric DeVolder <eric_devolder@yahoo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/base/cpu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/base/cpu.c~drivers-base-cpu-crash-data-showing-should-depends-on-kexec_core
+++ a/drivers/base/cpu.c
@@ -144,7 +144,7 @@ static DEVICE_ATTR(release, S_IWUSR, NUL
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 #endif /* CONFIG_HOTPLUG_CPU */
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 #include <linux/kexec.h>
 
 static ssize_t crash_notes_show(struct device *dev,
@@ -189,14 +189,14 @@ static const struct attribute_group cras
 #endif
 
 static const struct attribute_group *common_cpu_attr_groups[] = {
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	&crash_note_cpu_attr_group,
 #endif
 	NULL
 };
 
 static const struct attribute_group *hotplugable_cpu_attr_groups[] = {
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	&crash_note_cpu_attr_group,
 #endif
 	NULL
_

Patches currently in -mm which might be from bhe@redhat.com are

kexec_core-change-dependency-of-object-files.patch
kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump-fix-1.patch
kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump-fix-2.patch
riscv-fix-vmallc_start-definition.patch
resource-add-walk_system_ram_res_rev.patch
kexec_file-load-kernel-at-top-of-system-ram-if-required.patch
kexec_file-add-kexec_file-flag-to-control-debug-printing.patch
kexec_file-print-out-debugging-message-if-required.patch
kexec_file-x86-print-out-debugging-message-if-required.patch
kexec_file-arm64-print-out-debugging-message-if-required.patch
kexec_file-ricv-print-out-debugging-message-if-required.patch
kexec_file-power-print-out-debugging-message-if-required.patch
kexec_file-parisc-print-out-debugging-message-if-required.patch
riscv-kexec-fix-the-ifdeffery-for-aflags_kexec_relocateo.patch


