Return-Path: <stable+bounces-256724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNopHAPjGWpmzggAu9opvQ
	(envelope-from <stable+bounces-256724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:03:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF355607A4F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6CBC300CBC9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353B357739;
	Fri, 29 May 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bUYYfvmY"
X-Original-To: stable@vger.kernel.org
Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0A737C0FB
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081407; cv=none; b=GzpBpBGed7QjDd1pxIpG5x+YXFZ8I6Iv3SzKB11Yex0NmuXJNM7I3MyGthUU6dp6teP36XY5I246p+Ju7suMpPhzMLv3NZ9Xu8XlR5SVf57QYYfUh/fhoc4FVHqH+ZeduKDBC4n06YGXfGE/xnpNGe1kTAU+Mso/8yYJF7rm6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081407; c=relaxed/simple;
	bh=swipAQJGsymOXQRCYCRtnSYJ2ZKD88VZmePVBMviK98=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR1a76n1k5j15vjvY2EmCnF3TaqAHLoWtA9zJeztPHyHZShmM3dYEJaWgVs6bkfC+7IA8Q4vOnZkB1D7ExySgshSylpFC/nAkP98TKrfDT4rRXIkHXLzAh/GelIgl9+9kpJI5QcSHdmFBxl1CS6P3Uit+mOUK50R5D5DlAUcGmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bUYYfvmY; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780081401; x=1780340601;
	bh=dvB/3QyedObdEd0vUZp5FaAP+aJh2ZYKSH7sTm+EfQk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bUYYfvmYMc6S4MxvcfWmvLl/pJakR8e4yjIBGLmXiRr5QWXmSgaWakrhulNPRd+D0
	 Ihpoat7/6JjzlHSwPECXTC49Uuc8pzqUB1Uw7WsJC+IJ/1/JomvxqNd8nVMFJ+wQZj
	 9mtmRQM4TPdnHLr2fDTHE7lLPOvvjepypm99q8l5d9ZcSmAnGBIMM1H431GCun2dev
	 wQ+LfUPGMVjRhQDjCawsAptgPaoRyCSy+5TUN9pe7Jgqg1YtIH8+SHxQtWzPkvnLjb
	 27LBOXXkTjSuJ+ata20j+BZ2ytkyvBdIvFpSGLxtmceSS4EZXb/9ZZCIyC7837eyvg
	 l+D/Y3jp0thhQ==
Date: Fri, 29 May 2026 19:03:18 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
From: hexlabsecurity@proton.me
Cc: Justin Suess <utilityemal77@gmail.com>, "gnoack@google.com" <gnoack@google.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [REPORT] landlock: SCOPE_SIGNAL bypass via F_SETOWN to invoker pgid -> SIGIO/SIGKILL to non-sandboxed targets
Message-ID: <YKesampb9JYT6cYp0iFbzuxr6hCIaFu-9YhkphsUJ1l8ktqIUpjeBictEvT74GFc0RwQ6WVNcKyVWuOskeQJPhWGhOOB6BUJiff_UXfzm_g=@proton.me>
In-Reply-To: <20260529.li6kaiDaim4B@digikod.net>
References: <TSwHGN3I-u6p6xv7CqnvDOhR3la_kQWq0rdjBdA0gt30AsYLwddoxjCCFmqXcQMxWHS4ShULEp7sO_8HdFRGPLk30rIQHy3EurwJyrjP3NQ=@proton.me> <20260529.li6kaiDaim4B@digikod.net>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 15b272239d115edf4f07f7b2aec89dc502a73ad4
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-256724-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: BF355607A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Micka=C3=ABl,

> Could you please replace the reproducer code with a proper kselftest?
> That would need to be a new email patch (v3) [...]

Done -- v3 is a two-patch series:

  [PATCH v3 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to=
 invoker's pgid
  [PATCH v3 2/2] selftests/landlock: test SCOPE_SIGNAL on the SIGIO/fowner =
pgid path

Patch 2 replaces the informal reproducer with a regression test in
scoped_signal_test.c, reusing the existing fown/SIGURG idiom. It adds
TEST(sigio_to_pgid_members): a sandboxed child at the head of its pgid hlis=
t
arms F_SETSIG(SIGURG) / F_SETOWN(-pgrp) / O_ASYNC and triggers the fan-out;=
 the
in-domain child must be signaled (positive control) and the non-sandboxed
parent must not.

I also added the Fixes: tag and Cc: stable that v2 was missing:

  Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of t=
he same process")

That is where the same-thread-group exemption on the fowner path was
introduced (v6.15; backported to 6.12.y/6.13.y/6.14.y -- the original v6.12
signal scoping captured the subject unconditionally and was not affected).
The fix hunk itself is unchanged from v1/v2 and keeps Justin's Tested-by.

A/B on 6.12.90 + CONFIG_SECURITY_LANDLOCK (same .config, only the hunk
differs): without patch 1 the new test fails (the parent is signaled); with=
 it
the test passes and the landlock signal-scoping suite is 20/20. checkpatch =
is
clean except one expected Reported-by/Closes warning -- the original report=
 was
sent to security@kernel.org, so there is no public URL to point Closes: at.

Thanks,
Bryam Vargas

Independent security researcher. HEXLAB SAS (registration pending) -- Cali,=
 Colombia.

This series fixes a LANDLOCK_SCOPE_SIGNAL bypass on the asynchronous SIGIO
(fcntl(F_SETOWN)) delivery path and adds the kselftest requested in review.

Patch 1 narrows the same-thread-group exemption in control_current_fowner()
so that F_SETOWN to a process group (or session) always captures the caller=
's
Landlock subject. Without it, a sandboxed task at the head of its pgid hlis=
t
(the default position after fork()) skips the capture, and the SIGIO fan-ou=
t
reaches non-sandboxed members of the process group, defeating SCOPE_SIGNAL.
The direct kill() path (hook_task_kill) is unaffected.

Patch 2 adds a regression test to scoped_signal_test.c, replacing the infor=
mal
reproducer that previously accompanied the fix.

The defect was introduced by commit 18eb75f3af40 ("landlock: Always allow
signals between threads of the same process") in v6.15, and is present in t=
he
stable branches that backported it (6.12.y, 6.13.y, 6.14.y).
control_current_fowner() is identical across those branches, so patch 1 app=
lies
as-is (stable kernels before the fown_subject conversion store the domain i=
n
landlock_file(file)->fown_domain; the exemption and the fix are the same).

A/B verified on 6.12.90 + CONFIG_SECURITY_LANDLOCK (same .config, only the =
fix
hunk differs):
  - without patch 1: the new test fails -- the non-sandboxed parent receive=
s
    the signal (SCOPE_SIGNAL bypassed);
  - with patch 1: the new test passes, and the whole landlock signal-scopin=
g
    suite passes 20/20 (no regression).

v2 -> v3:
  - patch 1: add Fixes: tag and Cc: stable; the fix hunk is unchanged from =
v1/v2.
  - patch 2 (new): replace the git-notes reproducer with a kselftest.
  - v1/v2 were sent to security@kernel.org (embargoed; not in a public arch=
ive).

Bryam Vargas (2):
  landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to invoker's pgid
  selftests/landlock: test SCOPE_SIGNAL on the SIGIO/fowner pgid path

 security/landlock/fs.c                        | 12 +++
 .../selftests/landlock/scoped_signal_test.c   | 97 +++++++++++++++++++
 2 files changed, 109 insertions(+)

base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87


