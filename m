Return-Path: <stable+bounces-274483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ukq5CXRyVmrp5gAAu9opvQ
	(envelope-from <stable+bounces-274483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:31:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A1757753
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=JCuautg8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274483-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274483-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76B723049ADE
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874848BD35;
	Tue, 14 Jul 2026 17:31:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CED261388;
	Tue, 14 Jul 2026 17:31:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050279; cv=none; b=CbTUiidZskFKsm5gjLd8ikcl4qHXSmnolS2Q/oDknsHAAFgofPk0IBMNVOt+E/aeeG/pmP6AOfIlRqyqPJefD4orpfvC+eBVpGhZivTlrUV0A3m8TDtAuchSAokHXEBX3oYZYBhZHtKSa8MRGv4/QTC96FvK5ZP3ek8X8vr1/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050279; c=relaxed/simple;
	bh=8SRN96h3qsVItWUutJFKOI64e3eK1Au6hyeH09dAdfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF/CYwIpzPu8XbY84YcNPmf0x2j8Ys29uR1RxmojXCriCjHQCVP/4e5KKO9pepfcRnoyaMhV//7Kri+C9YYK4D+sFpsbtHpn9/YWVfRgkCi2ViyrbA/dWJf5edH7Vse8naO/FITaRN9p8r9Xi0a1v9YWs90drlNfW9s0Kq+QcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=JCuautg8; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784050274;
	bh=b36zf3rs7zvqc4fJ5AgCG9tOAbyeS22TKu09skdKryQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCuautg8Zekw12m3HwplN/l5RadmCDM3dUq8m36h/q/ObUNeyXVrifVqT16IoNpgU
	 j7I/DU3cGKc68FAtIOLgGI8/+2ZfrjpHdSZoAkA4oaLZTG54DXDRZEzhSt2Q8mseE0
	 hJrDR381KAfqTsIK6uX2Qth9CGWC7PJthlJ9z/Lg=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h05v65NVFz112r;
	Tue, 14 Jul 2026 17:31:14 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h05v56JyXz112c;
	Tue, 14 Jul 2026 17:31:13 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Cc: pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	include@grrlz.net
Subject: [PATCH v4 3/3] panic: allow force_cpu redirect from an NMI
Date: Tue, 14 Jul 2026 17:31:02 +0000
Message-ID: <20260714173103.11585-4-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714173103.11585-1-include@grrlz.net>
References: <20260714173103.11585-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-274483-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:include@grrlz.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,grrlz.net:from_mime,grrlz.net:mid,grrlz.net:email,grrlz.net:dkim,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F9A1757753

nmi_panic() calls panic_try_start() before panic(), so it claims
panic_cpu first. When the panic then reaches panic_try_force_cpu(),
the panic_in_progress() check sees panic_cpu set and returns false,
so the redirect to the requested CPU never happens. The crash kernel
runs on the CPU that took the NMI instead.

The buggy call order, on a CPU X that is not the target (target is C):

  nmi_panic()
    panic_try_start()              wins, panic_cpu = X
    panic("%s", msg)
      vpanic()
        panic_try_force_cpu()
          panic_in_progress()      true, panic_cpu is X
          return false             redirect bypassed
        panic_try_start()          already won
        __crash_kexec()            on X, not C

The fix is to try the redirect before claiming panic_cpu. nmi_panic()
now calls panic_try_force_cpu_fmt() first, and only calls
panic_try_start() when no redirect happens. The requested CPU then
claims panic_cpu itself when it runs panic(), so panic_cpu does not need
to be handed off.

nmi_panic() holds an already formatted string, not a va_list. Add a
variadic wrapper, panic_try_force_cpu_fmt(), so it can reach the
existing formatting guarded by the cmpxchg in panic_try_force_cpu() without
a signature change. The wrapper builds the va_list and the real
function still copies and formats under the redirect cmpxchg, so no
shared buffer is written before ownership.

The redirect sends the IPI via smp_call_function_single_async().
This is safe from NMI context: the doc on the _async variant
states it can be called with interrupts disabled, and kgdb_roundup_cpus()
already calls it from NMI/debug context (kernel/debug/debug_core.c).

The nmi_panic() body is reshaped to a goto self_stop, since panic()
is noreturn and the stop path is shared.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708164312.19044-1-include@grrlz.net
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index c58c72d9f5a0..c81a5c9646e3 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -450,12 +450,32 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 	/* IPI/NMI sent, this CPU should stop */
 	return true;
 }
+
+/* For callers without a va_list, such as nmi_panic(). */
+static __printf(1, 2)
+bool panic_try_force_cpu_fmt(const char *fmt, ...)
+{
+	va_list args;
+	bool ret;
+
+	va_start(args, fmt);
+	ret = panic_try_force_cpu(fmt, args);
+	va_end(args);
+
+	return ret;
+}
 #else
 __printf(1, 0)
 static inline bool panic_try_force_cpu(const char *fmt, va_list args)
 {
 	return false;
 }
+
+static __printf(1, 2)
+bool panic_try_force_cpu_fmt(const char *fmt, ...)
+{
+	return false;
+}
 #endif /* CONFIG_SMP && CONFIG_CRASH_DUMP */
 
 bool panic_try_start(void)
@@ -519,11 +539,20 @@ EXPORT_SYMBOL(panic_on_other_cpu);
  */
 void nmi_panic(struct pt_regs *regs, const char *msg)
 {
+	/* Try to redirect to the requested CPU when one is set. */
+	if (panic_try_force_cpu_fmt("%s", msg))
+		goto self_stop;
+
+	/* Try to acquire the right to proceed with the noreturn panic(). */
 	if (panic_try_start())
 		panic("%s", msg);
 
-	if (panic_on_other_cpu())
-		nmi_panic_self_stop(regs);
+	/*
+	 * panic_try_start() only fails when a panic is already in progress
+	 * on another CPU, in which case this CPU must stop.
+	 */
+self_stop:
+	nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
 
-- 
2.53.0


