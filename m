Return-Path: <stable+bounces-270869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hG20EX6hRmpOagsAu9opvQ
	(envelope-from <stable+bounces-270869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:35:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 429336FB788
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:35:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=v7wsk6Lt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270869-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270869-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34C5C315D686
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3C35F61A;
	Thu,  2 Jul 2026 16:34:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97235E1CE;
	Thu,  2 Jul 2026 16:34:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010062; cv=none; b=YA+Y9bMQz2tqajqocUzlNzhHlN/WmLdlLSu0ViAlXbAQpP7gyGqhRsQYbgDc+E0StGl0X7K2cw8E0G+9u+lyVjkFvl4CEcQuEKzMNRYSA6dk7iQVfSriMfCHCCDOM0R2L2lPXtbYnx73aOP9r7R8Zv1e2r29RkXtBoS9OL8DKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010062; c=relaxed/simple;
	bh=VNLarYh63fABAKKoJd1jlu5QDy2WT70ZV5vqx1AUoUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QndThImscJ0gLfl0JUMn/kjDwY+pgPw8kG+22usaQKifdZWzIAniIPJ2B+rKUQsSEGtuWQOwdA1QvVdrebbsWtGOyVt/aqnqyWwFYCSYsA1b1mfAocz7ppEZQHmCTtD1KiyE5awpBRNyISSeaTPhrfbAqexqpkBsDWpsjG8W+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v7wsk6Lt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D94E1F000E9;
	Thu,  2 Jul 2026 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010061;
	bh=Z72m2jjlrNy+27WcCmalgBDYk/jMxwWkg7IWAfxIyAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v7wsk6Ltw26gDjNWZb5MHo2ytUbBwBSd/tnpW7sbz48MpHmUSmwKQT7fUoxtE1VVV
	 hNrLmsNYr2x3rBdOFwb5jszZHpObNuc7ruzXmJjZyHOkpBRxpff+c8VbyDlmwOj0uh
	 +pcDWukypBdAxey+ZHd9g4qGK0x9o1mWEVKA69QE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1 095/129] LoongArch: Report dying CPU to RCU in stop_this_cpu()
Date: Thu,  2 Jul 2026 18:20:14 +0200
Message-ID: <20260702155114.109325852@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270869-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:guoren@kernel.org,m:chenhuacai@loongson.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,loongson.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 429336FB788

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit f2539c56c74691e7a88af6372ba2b48c06ed2fe4 upstream.

This is a port of MIPS commit 9f3f3bdc6d9dac1 ("MIPS: smp: report dying
CPU to RCU in stop_this_cpu()"). smp_send_stop() parks all secondary
CPUs in stop_this_cpu(). And the function marks the CPU offline for the
scheduler via set_cpu_online(false) but never informs RCU, so RCU keeps
expecting a quiescent state from CPUs that are now spinning forever with
interrupts disabled.

As long as nothing waits for an RCU grace period after smp_send_stop()
this is harmless, which is why it went unnoticed. However, since commit
91840be8f710370 ("irq_work: Fix use-after-free in irq_work_single() on
PREEMPT_RT"), irq_work_sync() calls synchronize_rcu() on architectures
without an irq_work self-IPI, i.e. where arch_irq_work_has_interrupt()
returns false. Any irq_work_sync() issued in the reboot/shutdown/halt
path after smp_send_stop() then blocks on a grace period that can never
complete, hanging the reboot:

  WARNING: CPU: 0 PID: 15 at kernel/irq_work.c:144 irq_work_queue_on
  ...
  rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
  rcu: Offline CPU 1 blocking current GP.
  rcu: Offline CPU 2 blocking current GP.
  rcu: Offline CPU 3 blocking current GP.

This issue needs some hacks to reproduce, and it was not noticed on
LoongArch because arch_irq_work_has_interrupt() usually returns true.

Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring
the generic CPU-hotplug offline path, so RCU stops waiting on the parked
CPUs and grace periods can still complete. LoongArch shuts down all CPUs
here without going through the CPU-hotplug mechanism, so this report is
not otherwise issued.

Cc: <stable@vger.kernel.org>
Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/smp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -517,6 +517,7 @@ static void stop_this_cpu(void *dummy)
 	set_cpu_online(smp_processor_id(), false);
 	calculate_cpu_foreign_map();
 	local_irq_disable();
+	rcutree_report_cpu_dead();
 	while (true);
 }
 



