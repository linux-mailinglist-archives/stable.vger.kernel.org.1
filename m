Return-Path: <stable+bounces-3113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B9D7FCC78
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 03:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E41281281
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 02:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EC01FB4;
	Wed, 29 Nov 2023 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hPaI+3aG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5451854
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 02:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60268C433C8;
	Wed, 29 Nov 2023 02:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701223218;
	bh=zG7Xedy3ggCmyAzWx5WglNsvZP7dBTLD5kYjdzMCc18=;
	h=Date:To:From:Subject:From;
	b=hPaI+3aGd8Y3lF9o6CrJiw5GwLbJK94ltY5MqORUzk2KerosD8iWcBkVkrvrNBf7n
	 Xe0+moBXtCSn4+ZFiD7+bclgdX2cQBHOFpFEPDkxilv2vzI0349AomkaBMt94dBjpO
	 QpNLO3/qOkl4vEs4MFatS8oUniuKlGFeHRsMvgI4=
Date: Tue, 28 Nov 2023 18:00:16 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ignat@cloudflare.com,eric_devolder@yahoo.com,agordeev@linux.ibm.com,bhe@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + drivers-base-cpu-crash-data-showing-should-depends-on-kexec_core.patch added to mm-hotfixes-unstable branch
Message-Id: <20231129020018.60268C433C8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: drivers/base/cpu: crash data showing should depends on KEXEC_CORE
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     drivers-base-cpu-crash-data-showing-should-depends-on-kexec_core.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/drivers-base-cpu-crash-data-showing-should-depends-on-kexec_core.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

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
Fixes: commit 88a6f8994421 ("crash: memory and CPU hotplug sysfs attributes")
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

drivers-base-cpu-crash-data-showing-should-depends-on-kexec_core.patch
resource-add-walk_system_ram_res_rev.patch
kexec_file-load-kernel-at-top-of-system-ram-if-required.patch


