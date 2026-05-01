Return-Path: <stable+bounces-242286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHs/IyuI9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A74ABD10
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6406C3001457
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29437DEBB;
	Fri,  1 May 2026 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WY/GQMlI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CE35A38C
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633320; cv=none; b=Vt1wwTgMDWQi0F2VU0tvBF68xgifVJizYye1Bp4kw/hV2MoI/BqadJR/KsH9EnP5R14q7HMJBFFFI/Qi3Q3vk2p+5fUrIShKi9EmOQgK+jk4ro9cS/RAA4M25dyMdLHOsfiKljq8mg5mpwzcPk5nPZVGFUuldqqEgWUhhiGfZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633320; c=relaxed/simple;
	bh=Sk0Z8HYmBNsL5aRU2kbK49ZI8sXck5J4D6GuWpkBBug=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OyyN4te7P+tqcb5ogn0jFdg2+xonKHDCD1ELvLavPLwj4r1+2Wvwt87g48we+YU2ClTi88qYot6lDviD5kf4rSKx1lg7bxRq1ED4UQmF3J5UxOmRWusGRCijnW68Q0FSfDJLdNrTyDNN9d9zslCuH1pZSN0ZabYV9NUPThs/Kpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WY/GQMlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D993C2BCB4;
	Fri,  1 May 2026 11:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633320;
	bh=Sk0Z8HYmBNsL5aRU2kbK49ZI8sXck5J4D6GuWpkBBug=;
	h=Subject:To:Cc:From:Date:From;
	b=WY/GQMlIusScy+UZ0iGqpwfatiVy0YEVQMWxl3cac439AWik9PTKy4BhCl8hmA8qx
	 LFPp1I4jTS8vmhrSyc7m9dYXCVVjQTx7PWbYQk/JceceH+ZLbUii4O/wHDxDAn8h7w
	 I/y1hcDeQE0PN9J8VkckincGRINKuaJ8qllchxiI=
Subject: FAILED: patch "[PATCH] module.lds.S: Fix modules on 32-bit parisc architecture" failed to apply to 7.0-stable tree
To: deller@gmx.de,jpoimboe@kernel.org,petr.pavlu@suse.com,samitolvanen@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:01:57 +0200
Message-ID: <2026050157-rewrite-overfeed-ad3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B7A74ABD10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242286-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,suse.com,google.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,gmx.de:email,suse.com:email]


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 1221365f55281349da4f4ba41c05b57cd15f5c28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050157-rewrite-overfeed-ad3b@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1221365f55281349da4f4ba41c05b57cd15f5c28 Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Tue, 7 Apr 2026 22:07:22 +0200
Subject: [PATCH] module.lds.S: Fix modules on 32-bit parisc architecture

On the 32-bit parisc architecture, we always used the
-ffunction-sections compiler option to tell the compiler to put the
functions into seperate text sections. This is necessary, otherwise
"big" kernel modules like ext4 or ipv6 fail to load because some
branches won't be able to reach their stubs.

Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related
macros") broke this for parisc because all text sections will get
unconditionally merged now.

Introduce the ARCH_WANTS_MODULES_TEXT_SECTIONS config option which
avoids the text section merge for modules, and fix this issue by
enabling this option by default for 32-bit parisc.

Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: stable@vger.kernel.org # v6.19+
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/arch/Kconfig b/arch/Kconfig
index 334b69505381..4eb2e51e28f1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1127,6 +1127,13 @@ config ARCH_WANTS_MODULES_DATA_IN_VMALLOC
 	  For architectures like powerpc/32 which have constraints on module
 	  allocation and need to allocate module data outside of module area.
 
+config ARCH_WANTS_MODULES_TEXT_SECTIONS
+	bool
+	help
+	  For architectures like 32-bit parisc which require that functions in
+	  modules have to keep code in own text sections (-ffunction-sections)
+	  and to avoid merging all text into one big text section,
+
 config ARCH_WANTS_EXECMEM_LATE
 	bool
 	help
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 3e929eb5a7fe..d3afac2f0d9b 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -8,6 +8,7 @@ config PARISC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_SYSCALL_TRACEPOINTS
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANTS_MODULES_TEXT_SECTIONS if !64BIT
 	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_DMA_ALLOC if PA11
 	select ARCH_HAS_DMA_OPS
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 2dc4c8c3e667..b62683061d79 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -40,9 +40,11 @@ SECTIONS {
 	__kcfi_traps		0 : { KEEP(*(.kcfi_traps)) }
 #endif
 
+#ifndef CONFIG_ARCH_WANTS_MODULES_TEXT_SECTIONS
 	.text			0 : {
 		*(.text .text.[0-9a-zA-Z_]*)
 	}
+#endif
 
 	.bss			0 : {
 		*(.bss .bss.[0-9a-zA-Z_]*)


