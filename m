Return-Path: <stable+bounces-3184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A4E7FE315
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 23:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF599B20FC3
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 22:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9465E3B1A4;
	Wed, 29 Nov 2023 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pPYaSL0s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C74CB58
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 22:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49B0C433C9;
	Wed, 29 Nov 2023 22:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701296686;
	bh=6l0LFh+tT1gTERFfDeTg2oTmx1lgFX0zvl2oIwSj5Ow=;
	h=Date:To:From:Subject:From;
	b=pPYaSL0s0V+MTMKdZ0QMT0l1On6svHWqE9lmRn2s15I9kTK6YDz397U+7XIzZLqaD
	 sJ3x2ZELkJf3YvIn+pRKYar7ZJc+tb1Jq+yVGBKbXM3FkuKLTIstxfiMnDUg2hk8Qb
	 /5X70TmNtqj1++DK3uLW52aADaAa6wNX5uyf2ir0=
Date: Wed, 29 Nov 2023 14:24:46 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,bhe@redhat.com,agordeev@linux.ibm.com,ignat@cloudflare.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump.patch added to mm-hotfixes-unstable branch
Message-Id: <20231129222446.C49B0C433C9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump.patch

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
From: Ignat Korchagin <ignat@cloudflare.com>
Subject: kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
Date: Wed, 29 Nov 2023 22:04:09 +0000

In commit f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for
CRASH_DUMP") we tried to fix a config regression, where CONFIG_CRASH_DUMP
required CONFIG_KEXEC.

However, it was not enough at least for arm64 platforms.  While further
testing the patch with our arm64 config I noticed that CONFIG_CRASH_DUMP
is unavailable in menuconfig.  This is because CONFIG_CRASH_DUMP still
depends on the new CONFIG_ARCH_SUPPORTS_KEXEC introduced in commit
91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec") and on
arm64 CONFIG_ARCH_SUPPORTS_KEXEC requires CONFIG_PM_SLEEP_SMP=y, which in
turn requires either CONFIG_SUSPEND=y or CONFIG_HIBERNATION=y neither of
which are set in our config.

Given that we already established that CONFIG_KEXEC (which is a switch for
kexec system call itself) is not required for CONFIG_CRASH_DUMP drop
CONFIG_ARCH_SUPPORTS_KEXEC dependency as well.  The arm64 kernel builds
just fine with CONFIG_CRASH_DUMP=y and with both CONFIG_KEXEC=n and
CONFIG_KEXEC_FILE=n after f8ff23429c62 ("kernel/Kconfig.kexec: drop select
of KEXEC for CRASH_DUMP") and this patch are applied given that the
necessary shared bits are included via CONFIG_KEXEC_CORE dependency.

Link: https://lkml.kernel.org/r/20231129220409.55006-1-ignat@cloudflare.com
Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Cc: <stable@vger.kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/Kconfig.kexec |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/Kconfig.kexec~kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump
+++ a/kernel/Kconfig.kexec
@@ -94,7 +94,6 @@ config KEXEC_JUMP
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on ARCH_SUPPORTS_CRASH_DUMP
-	depends on ARCH_SUPPORTS_KEXEC
 	select CRASH_CORE
 	select KEXEC_CORE
 	help
_

Patches currently in -mm which might be from ignat@cloudflare.com are

kexec-drop-dependency-on-arch_supports_kexec-from-crash_dump.patch


