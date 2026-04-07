Return-Path: <stable+bounces-233636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA3jLosc1Wli0wcAu9opvQ
	(envelope-from <stable+bounces-233636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:02:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA53F3B091F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5C1230468BB
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB8E33DEFC;
	Tue,  7 Apr 2026 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnOZ1v7u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22EF33D6D2
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573938; cv=none; b=TWuWvebcm9ZNdtMASSCcISf3OnwfTuLWggsgtM3lEJazLhVfWtXw6nO/3DE24Kc/2nZV2WHY5oY7WdAD6GS4D/Bvy8XcKuzIb4Fy/X8o8j4xTCGrbEsU5LNTj3S3J9NLMxSWsW3jx/XtBJSVNMQLQV7f1yMDfo6J/o1ml+z1Hvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573938; c=relaxed/simple;
	bh=+NGTSJGsKMBfAldJoE7UCvc80p8IK+/Fzbgv54DQ/2A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FcGRuIOtz5j3MLNXJhHhqHa6SWfllDFcMlzzDn22+pfF7QMlCOcm5CFcGOwHpjuz9hxm2mSIqyb3Rj28xeGdUIoDqL5/AlhfqoQcGGQYD/ElkRTX3RJb69HPwilEi1EkRjpqXa7cJF4ZmbEmOS07u0EoKvK2RoyCxnVwwcnaoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnOZ1v7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BBEC116C6;
	Tue,  7 Apr 2026 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775573938;
	bh=+NGTSJGsKMBfAldJoE7UCvc80p8IK+/Fzbgv54DQ/2A=;
	h=Subject:To:Cc:From:Date:From;
	b=KnOZ1v7udEya4YZHxJpkiduBmKV5IegE4RuDSU2QmvQaxvZhruOFOcnTdsbrJP/8y
	 EOwijNUHsQar6Lz2PwMxtNuc3iAyt6PTCOjQvTjWMiB9LASwEKxLUUfBPqlbxKdRrg
	 bGeJKaXBFLE/1HJyZIPMBjtGeXRzG7imT+puNoLc=
Subject: FAILED: patch "[PATCH] x86/kexec: Disable KCOV instrumentation after load_segments()" failed to apply to 6.12-stable tree
To: nogikh@google.com,bp@alien8.de,dvyukov@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 16:58:56 +0200
Message-ID: <2026040756-canopener-handiness-4da7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233636-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alien8.de:email,gregkh:email]
X-Rspamd-Queue-Id: EA53F3B091F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 917e3ad3321e75ca0223d5ccf26ceda116aa51e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040756-canopener-handiness-4da7@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 917e3ad3321e75ca0223d5ccf26ceda116aa51e1 Mon Sep 17 00:00:00 2001
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 25 Mar 2026 16:48:24 +0100
Subject: [PATCH] x86/kexec: Disable KCOV instrumentation after load_segments()

The load_segments() function changes segment registers, invalidating GS base
(which KCOV relies on for per-cpu data). When CONFIG_KCOV is enabled, any
subsequent instrumented C code call (e.g. native_gdt_invalidate()) begins
crashing the kernel in an endless loop.

To reproduce the problem, it's sufficient to do kexec on a KCOV-instrumented
kernel:

  $ kexec -l /boot/otherKernel
  $ kexec -e

The real-world context for this problem is enabling crash dump collection in
syzkaller. For this, the tool loads a panic kernel before fuzzing and then
calls makedumpfile after the panic. This workflow requires both CONFIG_KEXEC
and CONFIG_KCOV to be enabled simultaneously.

Adding safeguards directly to the KCOV fast-path (__sanitizer_cov_trace_pc())
is also undesirable as it would introduce an extra performance overhead.

Disabling instrumentation for the individual functions would be too fragile,
so disable KCOV instrumentation for the entire machine_kexec_64.c and
physaddr.c. If coverage-guided fuzzing ever needs these components in the
future, other approaches should be considered.

The problem is not relevant for 32 bit kernels as CONFIG_KCOV is not supported
there.

  [ bp: Space out comment for better readability. ]

Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260325154825.551191-1-nogikh@google.com

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e9aeeeafad17..47a32f583930 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -44,6 +44,20 @@ KCOV_INSTRUMENT_unwind_orc.o				:= n
 KCOV_INSTRUMENT_unwind_frame.o				:= n
 KCOV_INSTRUMENT_unwind_guess.o				:= n
 
+# Disable KCOV to prevent crashes during kexec: load_segments() invalidates
+# the GS base, which KCOV relies on for per-CPU data.
+#
+# As KCOV and KEXEC compatibility should be preserved (e.g. syzkaller is
+# using it to collect crash dumps during kernel fuzzing), disabling
+# KCOV for KEXEC kernels is not an option. Selectively disabling KCOV
+# instrumentation for individual affected functions can be fragile, while
+# adding more checks to KCOV would slow it down.
+#
+# As a compromise solution, disable KCOV instrumentation for the whole
+# source code file. If its coverage is ever needed, other approaches
+# should be considered.
+KCOV_INSTRUMENT_machine_kexec_64.o			:= n
+
 CFLAGS_head32.o := -fno-stack-protector
 CFLAGS_head64.o := -fno-stack-protector
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5b9908f13dcf..3a5364853eab 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -4,6 +4,8 @@ KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
 KCOV_INSTRUMENT_pgprot.o		:= n
+# See the "Disable KCOV" comment in arch/x86/kernel/Makefile.
+KCOV_INSTRUMENT_physaddr.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n


