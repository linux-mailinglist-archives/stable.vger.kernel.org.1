Return-Path: <stable+bounces-267966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VJe0E8KnOmpFCwgAu9opvQ
	(envelope-from <stable+bounces-267966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:35:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 399066B8552
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:35:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=qtcIcsOE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267966-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267966-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C471301D513
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596A269CE7;
	Tue, 23 Jun 2026 15:35:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530122D739C;
	Tue, 23 Jun 2026 15:35:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228911; cv=none; b=NMQnbd9ds8lEyexT30UadB7zB7KPizpKxeoiHMh7rKZYRtOiSZrcjL9D6rj4Axb/1Ul/of3FZFmJeZG3Nyxf3OBIWT9PSQ9c7/KGiKjH3pcP9lF2I86afmOhrRtOiRCDM3BguJhZ+tRQX34cXc8+fakcsGSnXOxGo8+82LPI4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228911; c=relaxed/simple;
	bh=yChqbXLLBO752DTztl9giRu0HdyXplFNuHMpOC0iNIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1jtZYJ6iuxR+LSAfa5S6EOc9qi/qbTBc1r53FuR3djTSVBN67oMKIbVIuubB9KWZjudcP/o+yxtBwat3VjStjq81NP6giOUayKXUrjgQzOgd3GXI3Ipflt+V2P1YGNxlDUk9fZI9F8rwnYhOguklG0JrCFYAzhwN4e3GmsdRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=qtcIcsOE; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782228908;
	bh=Os9oifXwMlAiBtFnDxy99rfvPjtg+YzWauHeJ0k/L1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtcIcsOEEiDAgh+PJN0zVmzj0UsLYuBJ5xk+ituAH0ITICphsZY0QZ+x0LyNK7DMg
	 cQSOBI62dT3JxK47xQ9IMopUiDLMEKSAiXocYtTcYjmhTJql5mIVet16uOFb8Ai2rd
	 3bCAr6T+ka/2Vl1g+LyzRJc8PyIdNoxnv8+pPR1M=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl8Jr6d4yz10xm;
	Tue, 23 Jun 2026 15:35:08 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl8Jq4x34z10xZ;
	Tue, 23 Jun 2026 15:35:07 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 2/4] watchdog: avoid sys_info fallback for all_bt
Date: Tue, 23 Jun 2026 15:34:59 +0000
Message-ID: <af891d9ca90fa98eabe48e8647d0c80dfce62d42.1782228656.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267966-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linux.intel.com,mobileye.com,suse.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org,grrlz.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:akpm@linux-foundation.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:andriy.shevchenko@linux.intel.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:include@grrlz.net,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 399066B8552

The watchdog prints all CPU backtraces itself. When the watchdog mask
contains only SYS_INFO_ALL_BT, stripping that bit leaves zero and
sys_info(0) falls back to kernel_sys_info.

Use sys_info_without_all_bt() so an explicit all_bt mask does not request
the global default.

Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- Use the shared sys_info_without_all_bt() helper.
- Keep the generic watchdog change separate from powerpc.

 kernel/watchdog.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 87dd5e0f6968..5bf24231a5d8 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -208,6 +208,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 {
 	int hardlockup_all_cpu_backtrace;
 	unsigned int this_cpu;
+	unsigned long si_mask;
 	unsigned long flags;
 
 	if (per_cpu(watchdog_hardlockup_touched, cpu)) {
@@ -216,7 +217,8 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		return;
 	}
 
-	hardlockup_all_cpu_backtrace = (hardlockup_si_mask & SYS_INFO_ALL_BT) ?
+	si_mask = READ_ONCE(hardlockup_si_mask);
+	hardlockup_all_cpu_backtrace = (si_mask & SYS_INFO_ALL_BT) ?
 					1 : sysctl_hardlockup_all_cpu_backtrace;
 	/*
 	 * Check for a hardlockup by making sure the CPU's timer
@@ -286,7 +288,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 			clear_bit_unlock(0, &hard_lockup_nmi_warn);
 	}
 
-	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+	sys_info_without_all_bt(si_mask);
 	if (hardlockup_panic)
 		nmi_panic(regs, "Hard LOCKUP");
 
@@ -798,6 +800,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	struct pt_regs *regs = get_irq_regs();
 	int softlockup_all_cpu_backtrace;
 	int duration, thresh_count;
+	unsigned long si_mask;
 	unsigned long flags;
 
 	if (!watchdog_enabled)
@@ -809,7 +812,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	if (panic_in_progress())
 		return HRTIMER_NORESTART;
 
-	softlockup_all_cpu_backtrace = (softlockup_si_mask & SYS_INFO_ALL_BT) ?
+	si_mask = READ_ONCE(softlockup_si_mask);
+	softlockup_all_cpu_backtrace = (si_mask & SYS_INFO_ALL_BT) ?
 					1 : sysctl_softlockup_all_cpu_backtrace;
 
 	watchdog_hardlockup_kick();
@@ -900,7 +904,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		}
 
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
-		sys_info(softlockup_si_mask & ~SYS_INFO_ALL_BT);
+		sys_info_without_all_bt(si_mask);
 		thresh_count = duration / get_softlockup_thresh();
 
 		if (softlockup_panic && thresh_count >= softlockup_panic)
-- 
2.53.0

