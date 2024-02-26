Return-Path: <stable+bounces-23624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD258670D7
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153441F282EB
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4775B5A2;
	Mon, 26 Feb 2024 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ERi81JRu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QHrbvUB4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299C5B03B
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942372; cv=none; b=tBaCCYU4XlfwlcaiaFydMu3kOBNKD9RcgwbBDIKne6EaSYv/yi6ET3RKNkhB2pGB2WKsGJSlYbpkjKaWoTj1uMyeaX3EEAOlhxxmCwq9+w4o/KGzVakCoZexaX/31ePHyw1e1q2s3gJGuRGa3WQEwADg3eRGUUapAJOmwr8hqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942372; c=relaxed/simple;
	bh=xCosWiBFDggyjWgwjQ5V9AUrlfqar5IiwEXeEE549Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwPxRFymuIDUSjFv2c3aE2ZJhuXRwwkOm/mPVfH6PDH7iw4UFdmoBjtdZYahtudbulePVkAzRsXL6+3TgVLrSGR/uamY4DjOLdsk96NnySoWYzuTF74M+Zdrh6yL5hrNBwciEYxk1HasC1Jdv8m2nLkT4v0+uihaMZUzXtDt2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ERi81JRu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QHrbvUB4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ACBD1F896;
	Mon, 26 Feb 2024 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708942368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1nQjzfmKaQxfYNuRI7vv16oEI0P1rch2QKyL5eb1p0=;
	b=ERi81JRuBPGzH0yNPDRM/VSpRsrIwU88qwYV0EaBsI+RBamAFB/Un9JSe3t2J7ichrygSC
	paswnnNRyx2hUB+Wa4Th0TkyoT41IVA7zQPsL5vRBP6ZIPUKE0hMtJceKJaEmJz8pvWRGk
	AqLCYM7WA2TpacQuvXWT2+D5790NHZA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708942367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1nQjzfmKaQxfYNuRI7vv16oEI0P1rch2QKyL5eb1p0=;
	b=QHrbvUB4pdXXHsjN44rLm7qxmQQFy7oL32k6vJqpzbuDsslydRgJR2yL/T5tOcMbcvhx4v
	BKBhgpsHgHBmBjZlXKf7w93KSFwAWGi+NpS8zFSJSvTIOYdOoOhByyeFFXT3O/+vZNCQTN
	Gl4Vpk0NaRsQcGWpBB3AoJ/m8mPnSgo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FED813A3A;
	Mon, 26 Feb 2024 10:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IDUwER9k3GX/LAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 26 Feb 2024 10:12:47 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 3/7] x86/entry_64: Add VERW just before userspace transition
Date: Mon, 26 Feb 2024 12:12:35 +0200
Message-Id: <20240226101239.17633-4-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226101239.17633-1-nik.borisov@suse.com>
References: <20240226101239.17633-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Mitigation for MDS is to use VERW instruction to clear any secrets in
CPU Buffers. Any memory accesses after VERW execution can still remain
in CPU buffers. It is safer to execute VERW late in return to user path
to minimize the window in which kernel data can end up in CPU buffers.
There are not many kernel secrets to be had after SWITCH_TO_USER_CR3.

Add support for deploying VERW mitigation after user register state is
restored. This helps minimize the chances of kernel data ending up into
CPU buffers after executing VERW.

Note that the mitigation at the new location is not yet enabled.

  Corner case not handled
  =======================
  Interrupts returning to kernel don't clear CPUs buffers since the
  exit-to-user path is expected to do that anyways. But, there could be
  a case when an NMI is generated in kernel after the exit-to-user path
  has cleared the buffers. This case is not handled and NMI returning to
  kernel don't clear CPU buffers because:

  1. It is rare to get an NMI after VERW, but before returning to userspace.
  2. For an unprivileged user, there is no known way to make that NMI
     less rare or target it.
  3. It would take a large number of these precisely-timed NMIs to mount
     an actual attack.  There's presumably not enough bandwidth.
  4. The NMI in question occurs after a VERW, i.e. when user state is
     restored and most interesting data is already scrubbed. Whats left
     is only the data that NMI touches, and that may or may not be of
     any interest.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-2-a6216d83edb7%40linux.intel.com
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/entry/entry_64.S        | 10 ++++++++++
 arch/x86/entry/entry_64_compat.S |  1 +
 arch/x86/include/asm/irqflags.h  |  1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 640c7d36c26c..1029c6c59d31 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -663,6 +663,7 @@ GLOBAL(swapgs_restore_regs_and_return_to_usermode)
 	/* Restore RDI. */
 	popq	%rdi
 	SWAPGS
+	CLEAR_CPU_BUFFERS
 	INTERRUPT_RETURN
 
 
@@ -786,6 +787,8 @@ ENTRY(native_iret)
 	 */
 	popq	%rax				/* Restore user RAX */
 
+	CLEAR_CPU_BUFFERS
+
 	/*
 	 * RSP now points to an ordinary IRET frame, except that the page
 	 * is read-only and RSP[31:16] are preloaded with the userspace
@@ -1736,6 +1739,12 @@ ENTRY(nmi)
 	std
 	movq	$0, 5*8(%rsp)		/* clear "NMI executing" */
 
+	/*
+	 * Skip CLEAR_CPU_BUFFERS here, since it only helps in rare cases like
+	 * NMI in kernel after user state is restored. For an unprivileged user
+	 * these conditions are hard to meet.
+	 */
+
 	/*
 	 * iretq reads the "iret" frame and exits the NMI stack in a
 	 * single instruction.  We are returning to kernel mode, so this
@@ -1753,6 +1762,7 @@ END(nmi)
 ENTRY(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
+	CLEAR_CPU_BUFFERS
 	sysret
 END(ignore_sysret)
 #endif
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index c3c4ea4a6711..bc37015ca1a4 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -318,6 +318,7 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	xorl	%r9d, %r9d
 	xorl	%r10d, %r10d
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretl
 END(entry_SYSCALL_compat)
 
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8a0e56e1dcc9..5ea4d34f6591 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -146,6 +146,7 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #define INTERRUPT_RETURN	jmp native_iret
 #define USERGS_SYSRET64				\
 	swapgs;					\
+	CLEAR_CPU_BUFFERS;			\
 	sysretq;
 #define USERGS_SYSRET32				\
 	swapgs;					\
-- 
2.34.1


