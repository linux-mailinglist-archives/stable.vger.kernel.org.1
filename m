Return-Path: <stable+bounces-270092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I9XCKeKFRGr0wAoAu9opvQ
	(envelope-from <stable+bounces-270092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 05:13:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DAA6E9630
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 05:13:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VnYtJGCK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270092-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270092-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1292303B670
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1136728F;
	Wed,  1 Jul 2026 03:13:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAF35DA49;
	Wed,  1 Jul 2026 03:13:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875614; cv=none; b=Fsp5diSDkrd5/86oFqyTXeD2j5qXDu7+vvPM4LeN9wxJV6LFzWM0AQD24IylWGlKdFgN+3/NFC4qIAfDBE7CWACwhj/tCRQO6d7XDgVHXIzr7dcikKrsKrl1jFkRqi4s32bb5vSGzqyYJJ24aFAO3vINBbHJ+rQO2YO1J9ddGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875614; c=relaxed/simple;
	bh=jFjDJOsaqTS1GGjKmWLrL72ZYmGHEJ8dd5cp+T9y8ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNmWxdDWEeHr9Dg61Mm2Guag3AByvf+kVkb+K+iSPKTlC6K9dLW8jpH2/S7AIMIeSrPqNIm5HJGvOEQJCE0g3CQXqUKKmnXGFJ90wFMMtrd+LARwMZ/NZmzvIbGQQmbg5n7/wMdfvEzrVDVNb2E3Y3OUMluI/IgQjih6ZKTyvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnYtJGCK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03391F000E9;
	Wed,  1 Jul 2026 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782875613;
	bh=0IYbLhaDKGrOgLQH0RlnBWUYYp7rsPIN/uj5DCWF0ps=;
	h=From:To:Cc:Subject:Date;
	b=VnYtJGCKC+VQnhRJnOTOxij39OLFLEWlpkIoEfLQ9khAwTGR35l/fkSaOPhdtNpoR
	 IuDRUirEh2Z9yiCKRHN13iomRgs+YXio48uRBugDOtiaSRKd9IzKWhFx4VwLBs2LxB
	 /04OANhDNep741QhQSpZ9tUt3k8nKyO6e1ea250K9qpMmwYecoD/NA5sroUjeWII5p
	 YQ3F4MQa6VD50cQbXRL3+8C1YU/0OJfwE+6NkztWF8K0RAQ979l85n4U7nRa76fu2J
	 W0tOv4hSsHJN8Tsszxh22PUwcnlnPox0bZdqMKTFK0CC+R+GkDWKKNnrJdWiLphDdN
	 4sj50SrU33V1g==
From: Guo Ren <guoren@kernel.org>
To: guoren@kernel.org
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	chenhuacai@loongson.cn,
	jelonek.jonas@gmail.com,
	jiayuan.chen@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	rostedt@goodmis.org,
	samuel.holland@sifive.com,
	stable@vger.kernel.org,
	tglx@kernel.org,
	tsbogend@alpha.franken.de
Subject: [PATCH] riscv: smp: Invoke cpu_ops->cpu_stop() in ipi_stop() for hotplug
Date: Wed,  1 Jul 2026 03:13:22 +0000
Message-ID: <20260701031322.1018667-1-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270092-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[ghiti.fr,eecs.berkeley.edu,linutronix.de,loongson.cn,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org,dabbelt.com,kernel.org,goodmis.org,sifive.com,alpha.franken.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:guoren@kernel.org,m:alex@ghiti.fr,m:aou@eecs.berkeley.edu,m:bigeasy@linutronix.de,m:chenhuacai@loongson.cn,m:jelonek.jonas@gmail.com,m:jiayuan.chen@linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:rostedt@goodmis.org,m:samuel.holland@sifive.com,m:stable@vger.kernel.org,m:tglx@kernel.org,m:tsbogend@alpha.franken.de,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guoren@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoren@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59DAA6E9630

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

When a CPU receives an IPI stop during hotplug teardown, the
platform-specific cpu_stop() callback should be called before
spinning in wait_for_interrupt(), so that firmware (e.g. SBI HSM)
is notified that the hart has stopped.

This aligns ipi_stop() with the existing behavior of
ipi_cpu_crash_stop(), which already calls cpu_ops[cpu]->cpu_stop()
under CONFIG_HOTPLUG_CPU.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/kernel/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index fa66f9c97d74..95aa11a0e590 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -82,6 +82,12 @@ int riscv_hartid_to_cpuid(unsigned long hartid)
 static void ipi_stop(void)
 {
 	set_cpu_online(smp_processor_id(), false);
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (cpu_has_hotplug(cpu))
+		cpu_ops->cpu_stop();
+#endif
+
 	while (1)
 		wait_for_interrupt();
 }
-- 
2.43.0


