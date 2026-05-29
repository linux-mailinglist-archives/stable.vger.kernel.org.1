Return-Path: <stable+bounces-256498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL5lOHgZGWoMqQgAu9opvQ
	(envelope-from <stable+bounces-256498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:43:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E66D45FD10D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E746A301AD82
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 04:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96AD36CE03;
	Fri, 29 May 2026 04:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nre+ebtF"
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B133BBD0;
	Fri, 29 May 2026 04:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029808; cv=none; b=esoOZzhlRll3ZsfwG7v51ZFShyW2HjdP8J4CAt2Zv2nO4IZK4nEw2kRaRjGoyGMQTyADGcxjPr+EuH4uub0JTvCF7rh8hbyjiuGqMzErcPoASiDrTbHs2cf9rampGWI4UcKJ1rUElNp5LaOWq2eLkbSDF43L+wHKqQPZ38Zul0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029808; c=relaxed/simple;
	bh=9QsG94ozGLcVgTXSGl+5HJtA6MOC8d987DuLlCfjuGQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ClUjZPUsIa+fBVhffVusnsE3Sb/S9C+0MbuTAbS+k0YnhtcK4M376v8y8wjLTPKCKVWcyVnfBIvQF/NHr622X7u2eb8yNFbA3Uw1/hcPI9W3lQOseQdeewZzN/bj85vG5U9TkuYcuV3G9x0byWh+W3qnNhg50JZS7JSzsWEJ05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nre+ebtF; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780029787; x=1780288987;
	bh=NLDGejXulI3vKNIGZvvVuiMBMn/rItJ+RB1Daevmvdo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nre+ebtFoxQBcQ0ow/kK8wcTPpR4hoifJbImdXm1/qwVSZtzxKLNZG62IpS8RHRME
	 2nG9WWSfDo0rzK1QTEOaGHcXwMVlTMMXYi9X4AZqYiuLNHQbhxDO4szl8eScbcGbJB
	 Ikrb0iWsKtA4Qy01Jtvg5MV2cGwettKqH6Ob/TwkBwOmVr333osXw0E/Ip1ziUEbzZ
	 9dO2gDmCUk/oq7wL9uH8zRvSjPS0OLzNg4ktoDmfj/j7QE0LZSAESHI/5tiEd42psy
	 S+hjQB3DiQNMNLHt23StHuVTs/AkwpvjePH+uKGJ/IdDpej8SWILef1ut1ig4Ega0/
	 moIGSRPk7SYgw==
Date: Fri, 29 May 2026 04:43:02 +0000
To: Justin Suess <utilityemal77@gmail.com>
From: hexlabsecurity@proton.me
Cc: "mic@digikod.net" <mic@digikod.net>, "gnoack@google.com" <gnoack@google.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [REPORT] landlock: SCOPE_SIGNAL bypass via F_SETOWN to invoker pgid -> SIGIO/SIGKILL to non-sandboxed targets
Message-ID: <TSwHGN3I-u6p6xv7CqnvDOhR3la_kQWq0rdjBdA0gt30AsYLwddoxjCCFmqXcQMxWHS4ShULEp7sO_8HdFRGPLk30rIQHy3EurwJyrjP3NQ=@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 238a1234b7e8ff5b1822e53dd20a613b6a6d40c1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-256498-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: E66D45FD10D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Justin -- much appreciated for reproducing on mic/next and for the
Tested-by.

v2 below addresses your review:
  - the commit message is trimmed to just the bug and the fix;
  - the reproducer and the A/B verification are moved below the --- so
    they become git notes, not part of the commit;
  - added your Tested-by.

The fix hunk is unchanged. I agree the concise statement of the defect is
"we fail to check the subject on fan-out signal types (PIDTYPE_PGID and
PIDTYPE_SID, i.e. type > PIDTYPE_TGID)". The patch keeps the explicit
PIDTYPE_PGID / PIDTYPE_SID test for readability and to stay robust if the
enum is ever reordered -- happy to switch to "> PIDTYPE_TGID" if you
prefer. I'll follow up separately on the erratum entry and a regression
test, as you suggested.

Independent security researcher. HEXLAB SAS (registration pending) --
Cali, Colombia.

Thanks,
Bryam Vargas

----- v2 patch (inline, plain text) -----

From 75f801309cd64f74d04ef86236bd973314dd7d94 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Thu, 28 May 2026 23:33:13 -0500
Subject: [PATCH v2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN=
 to
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
single task sharing current's cred. It is unsafe for PIDTYPE_PGID and
PIDTYPE_SID: when current is at the head of its pgid hlist -- the
default placement after fork(), hlist_add_head_rcu() in kernel/fork.c --
pid_task(pgid, PIDTYPE_PGID) resolves to current itself,
same_thread_group(current, current) is true, the capture is skipped, and
fown_subject.domain stays NULL. hook_file_send_sigiotask() then
short-circuits at "if (!subject->domain) return 0;", letting the kernel
fan the signal out to every member of the group, including tasks outside
current's Landlock domain that SCOPE_SIGNAL is supposed to protect.

The direct kill() path (hook_task_kill) is unaffected: it evaluates
current's live domain on every call. Only the cached SIGIO path is
broken.

Tighten control_current_fowner() to apply the thread-group exemption
only when the target identifies a single task whose Landlock cred is
necessarily shared with current (PIDTYPE_TGID, PIDTYPE_PID). For
PIDTYPE_PGID and PIDTYPE_SID, always capture the current Landlock
subject so the consumer's scope check runs against every member of the
group at delivery time.

Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Tested-by: Justin Suess <utilityemal77@gmail.com>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: per review, the commit message is trimmed to the bug + the fix; the
    reproducer and the A/B verification are moved below the --- so they
    stay out of the commit. Added Tested-by. The hunk is unchanged from
    v1 (v1 sent to security@kernel.org 2026-05-28, embargoed -- not yet
    in a public archive).

Reproducer (ordinary unprivileged user; sandbox active in the child):

  int pfd[2]; pipe(pfd);
  landlock_create_ruleset(&{.scoped =3D LANDLOCK_SCOPE_SIGNAL},
                          sizeof(attr), 0);
  prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
  landlock_restrict_self(rfd, 0);
  fcntl(pfd[0], F_SETSIG, SIGKILL);
  fcntl(pfd[0], F_SETOWN, -getpgrp());           /* PIDTYPE_PGID */
  fcntl(pfd[0], F_SETFL, O_ASYNC);
  write(pfd[1], "X", 1);                         /* trigger SIGIO */
  /* every pgid member receives SIGKILL, including the non-sandboxed
   * parent / supervisor / sibling workers */

A/B-verified on a 6.12.90 lab kernel (same .config, only this hunk
differs): pre-fix the sandboxed child's SIGKILL reaches the
non-sandboxed parent (SCOPE_SIGNAL bypassed); post-fix it is blocked.
hook_task_kill's direct-kill enforcement and the intra-thread-group
F_SETOWN cases continue to work post-patch.

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

