Return-Path: <stable+bounces-34246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F9893E84
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E151C210A2
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1967D47A55;
	Mon,  1 Apr 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQVPoDOU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D571CA8F;
	Mon,  1 Apr 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987475; cv=none; b=An55ADZ6FyKHEKhY8GFesuaFm4Khhon7VhfoAgveMwAb6hONjAb1/EQE9Hx3mOr9+GtWyODDFuHeujth+uZ9b9opm9kZQFLz8KaK0P6IL1JLNhXZNeZCWvC1aiIWFSKXCBmT7IoeQppU2XXAvShhA6y8j346QC1FGWu7Zb4EW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987475; c=relaxed/simple;
	bh=U+s2uphFi0kJemW4CeNf8ydFofk6mZeDThHiC1hBPys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZiMOLczOuC5O2DvsmA2+focBcEStLx9u2NE7ZDvrczrlgIbwPaNRNsPjjIDLAfRNmqZs8TylQYCRXYbEyF/vrbziaRM1T34veEhBwpsBiHJOCv5Zfe+kojz4iLuolRHtBBo9p8QlREj97tMcsjAjuBPbB2uE3dvSL1ZXvIWSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQVPoDOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE933C433C7;
	Mon,  1 Apr 2024 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987475;
	bh=U+s2uphFi0kJemW4CeNf8ydFofk6mZeDThHiC1hBPys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQVPoDOUQxD7Kak/2a6Ix0t4bFjbk0xh+CxX54AUrERTptKA1uSUrELOJNsePCaU2
	 7PyGkXNOW6rEP3im6PUj8SjwhCzDxhmq/LxWWOgq2KmMo29TXRqsqKs676cVnqekOZ
	 cU8zlSNCJ4h7WUTyETMdbBxefQJtMrJoBB5GVkuY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zev Weiss <zev@bewilderbeest.net>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Florent Revest <revest@chromium.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Kees Cook <keescook@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Sam James <sam@gentoo.org>,
	Stefan Roesch <shr@devkernel.io>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.8 291/399] prctl: generalize PR_SET_MDWE support check to be per-arch
Date: Mon,  1 Apr 2024 17:44:17 +0200
Message-ID: <20240401152557.871502028@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zev Weiss <zev@bewilderbeest.net>

commit d5aad4c2ca057e760a92a9a7d65bd38d72963f27 upstream.

Patch series "ARM: prctl: Reject PR_SET_MDWE where not supported".

I noticed after a recent kernel update that my ARM926 system started
segfaulting on any execve() after calling prctl(PR_SET_MDWE).  After some
investigation it appears that ARMv5 is incapable of providing the
appropriate protections for MDWE, since any readable memory is also
implicitly executable.

The prctl_set_mdwe() function already had some special-case logic added
disabling it on PARISC (commit 793838138c15, "prctl: Disable
prctl(PR_SET_MDWE) on parisc"); this patch series (1) generalizes that
check to use an arch_*() function, and (2) adds a corresponding override
for ARM to disable MDWE on pre-ARMv6 CPUs.

With the series applied, prctl(PR_SET_MDWE) is rejected on ARMv5 and
subsequent execve() calls (as well as mmap(PROT_READ|PROT_WRITE)) can
succeed instead of unconditionally failing; on ARMv6 the prctl works as it
did previously.

[0] https://lore.kernel.org/all/2023112456-linked-nape-bf19@gregkh/


This patch (of 2):

There exist systems other than PARISC where MDWE may not be feasible to
support; rather than cluttering up the generic code with additional
arch-specific logic let's add a generic function for checking MDWE support
and allow each arch to override it as needed.

Link: https://lkml.kernel.org/r/20240227013546.15769-4-zev@bewilderbeest.net
Link: https://lkml.kernel.org/r/20240227013546.15769-5-zev@bewilderbeest.net
Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Acked-by: Helge Deller <deller@gmx.de>	[parisc]
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Florent Revest <revest@chromium.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: Sam James <sam@gentoo.org>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: <stable@vger.kernel.org>	[6.3+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/mman.h |   14 ++++++++++++++
 include/linux/mman.h           |    8 ++++++++
 kernel/sys.c                   |    7 +++++--
 3 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 arch/parisc/include/asm/mman.h

--- /dev/null
+++ b/arch/parisc/include/asm/mman.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <uapi/asm/mman.h>
+
+/* PARISC cannot allow mdwe as it needs writable stacks */
+static inline bool arch_memory_deny_write_exec_supported(void)
+{
+	return false;
+}
+#define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
+
+#endif /* __ASM_MMAN_H__ */
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -162,6 +162,14 @@ calc_vm_flag_bits(unsigned long flags)
 
 unsigned long vm_commit_limit(void);
 
+#ifndef arch_memory_deny_write_exec_supported
+static inline bool arch_memory_deny_write_exec_supported(void)
+{
+	return true;
+}
+#define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
+#endif
+
 /*
  * Denies creating a writable executable mapping or gaining executable permissions.
  *
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2408,8 +2408,11 @@ static inline int prctl_set_mdwe(unsigne
 	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
 		return -EINVAL;
 
-	/* PARISC cannot allow mdwe as it needs writable stacks */
-	if (IS_ENABLED(CONFIG_PARISC))
+	/*
+	 * EOPNOTSUPP might be more appropriate here in principle, but
+	 * existing userspace depends on EINVAL specifically.
+	 */
+	if (!arch_memory_deny_write_exec_supported())
 		return -EINVAL;
 
 	current_bits = get_current_mdwe();



