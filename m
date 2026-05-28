Return-Path: <stable+bounces-256421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF/7HAmyGGr9mAgAu9opvQ
	(envelope-from <stable+bounces-256421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:22:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE96E5FA5B7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 837C8303C665
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B5835203C;
	Thu, 28 May 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="frzfSGVF"
X-Original-To: stable@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B034347C6
	for <stable@vger.kernel.org>; Thu, 28 May 2026 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003333; cv=none; b=tFZXqg1tuovMiNTXaYdp6C4eyOVNccmPkaGmVCwQJjGKrvghP+PWtJT8Q0WYFs8VF/U8Gb7xrt2eikk89/jMGz1hdjQH78kuaUBXCdxz0FxRUFKoFdefAv3vkz54Y4O1k9kkW+m++gkHcWfwuqzfAQrDbe5H2PpKFukFPzRZOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003333; c=relaxed/simple;
	bh=8anQ8x+9w88e/HCIFKHmvRQZ82fYS9BPTNKdMKd1o80=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PARUfJxiJ/f7ScgXacHx6qlWB320IPB/dsngUahPjq44aXz0lXGRshotolN1X5tmbxZCMJyN6YQ1CdMe1MRkj7lyoyUgR3BMeXUq4biwfdbkjpaTP3P+roczvR8bMkfbwZpCxTTPI5ZzFIm5tlW53ONHjZoRwK2jFKaARJ6+pRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=frzfSGVF; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780003314; x=1780262514;
	bh=Ocdwdp818KRICNMyNvofIyBu1lbIAUpLoNWLdxSoG9A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=frzfSGVFpxmfP2Yl9o3tW3+t+5upmWxviQP7kamMuTKSEUyt0XeHp21lE1v0FdviI
	 SYzKI66MZTXMb3UvwG7a5HQvY3jbQ69u+Op86GwKP+412kRiqWNwoEIERC+5+X/sGt
	 xsTmK/7M3ckh5XArqs7BsjBmhz8jiYCFslWnISKJ6dx/pdgColYzB8rfK4aTQHxpwI
	 YYdm6TrkaZXkswFuVYD4uP3QgWUrHgTaq3dBsybFqLbMtOOGMXL2uS1R7AsNhZLg8Z
	 /S2Kg4uo8V1dbQ01sk8/IyBFklnslK2N5ahb5et01K6f4PlWZAube1QPpaGyfB5d/R
	 1TtEeRVRVAvQQ==
Date: Thu, 28 May 2026 21:21:50 +0000
To: "mic@digikod.net" <mic@digikod.net>
From: hexlabsecurity@proton.me
Cc: "gnoack@google.com" <gnoack@google.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to invoker's pgid
Message-ID: <cFjmBkbTY-D5pYl66NixBeqbhWBzS7kBEUHCWbhTQwkiuvKg8xNkSEf9rYqDQiD76er1gK8Q6t1YOJ4nIPuvILuwG42d8_rfMZpQ5VmJru0=@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 0a30a4b1ef55abd0ca2fc1993287d9fade02e02c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-256421-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[proton.me:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: DE96E5FA5B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 22a0086b44beaaef01883e047dd4a8b8bc3153e9 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Thu, 28 May 2026 01:30:00 -0500
Subject: [PATCH] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to
 invoker's pgid

A Landlock-restricted process can bypass LANDLOCK_SCOPE_SIGNAL on the
SIGIO delivery path and deliver arbitrary signals (including SIGKILL via
F_SETSIG) to non-Landlocked targets that share its pgid, by exploiting a
producer-side cache-vs-live evaluation gap.

The SIGIO path in hook_file_send_sigiotask() consults a cached subject
stored in landlock_file(file)->fown_subject at fcntl(F_SETOWN) time
(via hook_file_set_fowner()), instead of evaluating the live Landlock
domain of the invoking task at signal-send time. The capture is gated
by control_current_fowner(), which returns false (skipping capture)
when pid_task(fown->pid, fown->pid_type) is in current's thread group.

This is correct for PIDTYPE_TGID / PIDTYPE_PID, where the target is a
single thread or thread-group leader sharing current's cred. It is
unsafe for PIDTYPE_PGID and PIDTYPE_SID: when current is at the head
of its pgid hlist -- the default placement after fork(),
hlist_add_head_rcu() in kernel/fork.c -- pid_task(pgid, PIDTYPE_PGID)
resolves to current itself, same_thread_group(current, current) is
true, the capture is skipped, and fown_subject.domain stays NULL.

hook_file_send_sigiotask() then short-circuits at
"if (!subject->domain) return 0;", allowing the kernel to fan the
signal out to every member of the group, including tasks outside
current's Landlock domain that the SCOPE_SIGNAL contract is supposed
to protect.

The direct kill() path (hook_task_kill) is unaffected: it evaluates
current's live domain on every call. Only the cached SIGIO path is
broken.

Repro (ordinary unprivileged user; sandbox active in the child):

  int pfd[2]; pipe(pfd);
  landlock_create_ruleset(&{.scoped =3D LANDLOCK_SCOPE_SIGNAL},
                          sizeof(attr), 0);
  prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
  landlock_restrict_self(rfd, 0);
  fcntl(pfd[0], F_SETSIG, SIGKILL);
  fcntl(pfd[0], F_SETOWN, -getpgrp());           /* PIDTYPE_PGID */
  fcntl(pfd[0], F_SETFL, O_ASYNC);
  write(pfd[1], "X", 1);                         /* trigger SIGIO  */
  /* every pgid member receives SIGKILL, including non-sandboxed
   * parent / supervisor / sibling workers */

Tighten control_current_fowner() to apply the thread-group exemption
only when the target identifies a SINGLE task whose Landlock cred is
necessarily shared with current (PIDTYPE_TGID, PIDTYPE_PID). For
PIDTYPE_PGID and PIDTYPE_SID, always capture the current Landlock
subject so the consumer's scope check runs against every member of
the group at delivery time.

Empirically A/B-verified on a 6.12.90 lab kernel (same .config, only
the patch hunk differs): pre-fix build exits with "BUG PRESENT --
SCOPE_SIGNAL BYPASSED", post-fix build exits with "SANDBOX HELD".
hook_task_kill's direct-kill enforcement and the intra-thread-group
F_SETOWN cases continue to work post-patch.

Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 security/landlock/fs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..edaa52572cbd 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1909,6 +1909,18 @@ static bool control_current_fowner(struct fown_struc=
t *const fown)
 =09if (!p)
 =09=09return true;

+=09/*
+=09 * For PIDTYPE_PGID and PIDTYPE_SID, signal delivery fans out to
+=09 * every member of the group at SIGIO time. Even when pid_task()
+=09 * resolves to current itself (e.g., current is the pgid hlist
+=09 * head post-fork), non-current members of the group are still
+=09 * valid targets that must be checked by hook_file_send_sigiotask().
+=09 * Always capture the current subject for those types so the
+=09 * consumer scope check runs against the live fown_subject.
+=09 */
+=09if (fown->pid_type =3D=3D PIDTYPE_PGID || fown->pid_type =3D=3D PIDTYPE=
_SID)
+=09=09return true;
+
 =09return !same_thread_group(p, current);
 }

--
2.43.0

