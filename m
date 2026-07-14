Return-Path: <stable+bounces-274482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CwpsOzlzVmo75wAAu9opvQ
	(envelope-from <stable+bounces-274482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:34:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA4C7577EF
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:34:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=N18O4HZp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274482-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274482-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 308ED318D3A6
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D38308F23;
	Tue, 14 Jul 2026 17:31:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AA2F3614;
	Tue, 14 Jul 2026 17:31:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050278; cv=none; b=ElKcILDVU7wdXHOZfpevvADHJIEpjwUbyIqBa2YAj3631h7aCrmst2UHj6OFWZOvuF4CWD4wkomT6xg3NxwpYIjestnEey1i9JvjmhqpM3lgALqtPvYhWVixhsMjNzck34NxXpNxMLMy/N0Q394f9UJLq8AIBjWVBV/XjfQHxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050278; c=relaxed/simple;
	bh=UZiOGp0/vJhhgaQv/VWyxJYZyMtPN+vHXY20iH3H9as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyMDOeGkxd9KasmaXJDygIeSSIVBl2naoNN7ajlrx4jX6BUnAgfr2q2+brQ3YJIMW2zRSYwR0D5ekk0DtEQThhwSZVqKzfaFrFC52ku7ECqISX0xSYtKcf/iBj5OgeLXbxVAGzh003JJ5bkQSB7ygkgmil1Wx622UE9K0mDs9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=N18O4HZp; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784050270;
	bh=UGpWzI1bp68mcgLlSW3gVZ5ZO/RISIWT7S496u0RQFw=;
	h=From:To:Cc:Subject:Date:From;
	b=N18O4HZpwv0wyGbQp+T6i90d7rzKACBjKlaVUJAgll++PUISPckwRG24MS/TNAIpb
	 GJeabSbOs7vQkZF6DS9izJsEnQ+Oj4QH234sRbM7Gv/5GUn8eZ5kEh4XSSWsAFUoxq
	 NOa9mplgi0HYEFp9s2ngPZis8fREr+BQCeNtSBhk=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h05v2597hz112f;
	Tue, 14 Jul 2026 17:31:10 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h05v16L7yz112c;
	Tue, 14 Jul 2026 17:31:09 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Cc: pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	include@grrlz.net
Subject: [PATCH v4 0/3] panic: fix the panic_force_cpu redirect races
Date: Tue, 14 Jul 2026 17:30:59 +0000
Message-ID: <20260714173103.11585-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,grrlz.net:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-274482-lists,stable=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:include@grrlz.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,grrlz.net:from_mime,grrlz.net:dkim,grrlz.net:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FA4C7577EF

Sorry for sending this before the earlier threads fully settled. I am
posting the series now because everything is in one place, a single
thread of three patches, instead of replies spread across the old
threads, which is easier to follow than a few separate discussions.

The panic_force_cpu= parameter redirects a panic to a specific CPU so
the crash kernel runs there. The redirect code in
panic_try_force_cpu() had two races and one ordering bug, all found by
Sashiko. This series closes them.

Patch 1: fix the redirect CPU race.

The redirect is gated by an atomic cmpxchg on panic_redirect_cpu, so
only one CPU sends the redirect IPI. The cmpxchg loser used to return
false and fall through into vpanic(), where it could win panic_try_start()
and run crash_kexec on the wrong CPU before the target ever received the
IPI. The loser has to stop. It cannot just return true, though, because
panic_try_force_cpu() can be called twice on the same CPU (nested NMI
during the message formatting, before the IPI is sent), and a blind
stop on that second call would abandon the panic with no IPI sent. The
loser now returns true to stop, unless it is reentering on the same CPU
(old_cpu == this_cpu), in which case it returns false and falls through.

Patch 1 also fixes the panic_in_progress() guard. We must never redirect
when panic_cpu is already taken, so the guard stays. But it now returns
true (stop) when the panic is on another CPU and false (proceed) when it
is on this CPU, instead of returning false either way.

The two races side by side, two non target CPUs A and B (target is C),
then a reentry on the redirect winner:

             cpu A                          cpu B
          ----------                     ----------
    panic_try_force_cpu()                panic_try_force_cpu()
        cmpxchg wins                         cmpxchg fails
        IPI -> C                             return false  <- old BUG
        return true                      panic_try_start() wins
    panic_smp_self_stop()                 __crash_kexec() on B
    (A stops)                             (target C bypassed)

             cpu A (1st)                  cpu A (nested NMI)
          ----------                     ----------
    panic_try_force_cpu()
        cmpxchg wins (redirect = A)
        vsnprintf(msg) ...
            <-- NMI -->
                                     panic_try_force_cpu()
                                         cmpxchg fails
                                         old_cpu == A == this_cpu
                                         return true  <- would abandon
                                     self_stop (IPI never sent)

Patch 2: flatten nmi_panic control flow.

A behavior preserving cleanup. panic() is noreturn, so the else after it
is dropped and the body flattened, ready for patch 3 to add the redirect
step without piling more onto the if else chain. Split out on its own so
patch 3 only adds new behavior and does not also reshape the function.

Patch 3: allow force_cpu redirect from an NMI.

A panic from an NMI used to bypass the redirect entirely. nmi_panic()
called panic_try_start() first, which claims panic_cpu, so by the time
panic() reached panic_try_force_cpu() the panic_in_progress() check saw
panic_cpu set, returned false, and never sent the redirect IPI. The
crash kernel ran on the CPU that took the NMI instead of the requested
one.

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

The fix tries the redirect before claiming panic_cpu. nmi_panic() calls
panic_try_force_cpu_fmt() first and only calls panic_try_start() when no
redirect happens. The requested CPU then claims panic_cpu itself when
its panic() runs, so panic_cpu is never handed off.

nmi_panic() holds an already formatted string, not a va_list. A variadic
wrapper, panic_try_force_cpu_fmt(), builds the va_list and calls the
existing panic_try_force_cpu(), which still copies and formats under the
redirect cmpxchg. This keeps the static panic_force_buf safe, it is only
written by the cmpxchg winner, never before ownership.

The redirect IPI goes out via smp_call_function_single_async(). This is
safe from NMI: the _async variant is documented as callable with
interrupts disabled, and kgdb_roundup_cpus() already uses it from NMI
context (kernel/debug/debug_core.c).

Changes since v3:
  - Patch 1 now also fixes the panic_in_progress() guard to return
    true or false depending on which CPU owns panic_cpu, and drops the
    recursion framing in the comment per Petr's review.
  - Patch 3 no longer changes the panic_try_force_cpu() signature or
    formats the message before the redirect cmpxchg. Petr pointed out
    the static buf is only safe under panic_cpu ownership, so the
    formatting stays inside the cmpxchg guarded path. nmi_panic() now
    reaches it via a variadic wrapper.
  - Patch 3 adds the NMI safety justification for
    smp_call_function_single_async(), answering Petr's v1 question.
  - The nmi_panic() control flow cleanup is split into its own patch
    (patch 2), per Petr's request to split changes.

Bradley Morgan (3):
  panic: fix redirect CPU race in panic_try_force_cpu()
  panic: flatten nmi_panic control flow
  panic: allow force_cpu redirect from an NMI

 kernel/panic.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

-- 
2.53.0


