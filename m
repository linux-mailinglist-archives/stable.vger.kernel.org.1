Return-Path: <stable+bounces-274293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kxNCEVtLVmr42wAAu9opvQ
	(envelope-from <stable+bounces-274293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:44:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FD756027
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:44:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=nBLpY+OC;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=ITTGSpdv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274293-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274293-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 460753116F81
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2B448096D;
	Tue, 14 Jul 2026 14:40:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAA47F2C6;
	Tue, 14 Jul 2026 14:40:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040010; cv=none; b=qaNI2J2x06FgDuy3D4AeTCpz/1GwSZQc4ZCXPs/WqMbSW9mRXU8t5ePVQrfqKxRXbqKePyW2VAzRqszobCVKr3bHbCwj1T6/Ny48jXiwAboAkW93e8S5EvoKDz1NANr6UpZUCIV19GjGHCq6qKIgWUrErZnbwmiEQQIUt52pN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040010; c=relaxed/simple;
	bh=FgBSTJ25FOGYR7WjgfmA+0FXjYPwvjP3stYWAm01FCU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IJ31SCf54csKWQoWTcUeTxS1BgSswg5GG/kRqDtoZq897mvQraZHDQSdvuUZLz2vxOBSWfGvcYHrZh2N6LyScdhnXRYeaDcfnn8ZrpOowKVQeTNMYU5WMl26vx3d7XVjf5JLYHsC4w88b/kkEFrXvKx9Gpg8yubJYEwJ4TCSXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nBLpY+OC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ITTGSpdv; arc=none smtp.client-ip=193.142.43.55
Date: Tue, 14 Jul 2026 14:40:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784040005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qN7hVsISAtetzHjuuaubRfQl85g/foyNn+9J8TyIfQ=;
	b=nBLpY+OCh05lI3M73ypzyPrHXXaM9LKa69f18/Yy5aQ6XdQNwqYdPyHub0YDxxTuiPGOgC
	modK+n4cOSx+J5k6Idih1gxqQj0/+T20PG0jWZR2Vux00VWJcBc3lmKDTCmu35LHOwr2Ua
	6+EbF7GHwE7ICeaHIsB+6VdTfCjXnbU1k05PLSzmwyufGlhORINmhWbzf6rYlYkoWzXhex
	PlTHY1cixHBFAIzLb8IDIVKfRRBPDrtIeX3PpNLW+mjTyjDpfvYrOpmE66Iv+FmkRixveL
	6V0w2mdr7GhKSel03UEuykxkgpkjm4yZOA8BgUsviHJaYHifG1LfC2bR/+1u+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784040005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qN7hVsISAtetzHjuuaubRfQl85g/foyNn+9J8TyIfQ=;
	b=ITTGSpdvodpcYChKKFfet/2XsSpOWxbWsNCsbZm7G9JKa8+OxkgfMG+gpUfCP4uzg8KZhz
	LhWxf+KylXIGlVDg==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Fix seccomp bypass after ptrace with TSYNC
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260713025712.416366-1-ruanjinjie@huawei.com>
References: <20260713025712.416366-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178404000356.1844600.11749576274766421368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vger.kernel.org:from_smtp,vger.kernel.org:replyto,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:from_mime,linutronix.de:dkim];
	FORGED_RECIPIENTS(0.00)[m:linux-tip-commits@vger.kernel.org,m:ruanjinjie@huawei.com,m:tglx@kernel.org,m:stable@vger.kernel.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274293-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 886FD756027

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     4a3591287fb7f808e209b4974ed337f609a2006b
Gitweb:        https://git.kernel.org/tip/4a3591287fb7f808e209b4974ed337f609a=
2006b
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Mon, 13 Jul 2026 10:57:12 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 14 Jul 2026 16:34:07 +02:00

entry: Fix seccomp bypass after ptrace with TSYNC

Sashiko review pointed out the following issue.

If a thread is stopped in syscall_trace_enter() for ptrace, another
thread can install a seccomp filter with SECCOMP_FILTER_FLAG_TSYNC
(e.g., via seccomp_attach_filter()). This will successfully set
SYSCALL_WORK_SECCOMP on the stopped thread, but syscall_trace_enter()
evaluates a cached 'work' variable sampled on entry. Consequently,
the subsequent check for SYSCALL_WORK_SECCOMP misses the newly
assigned flag, and the filter is silently bypassed.

This race condition could allow an unprivileged process to execute
a prohibited system call (e.g., execve) that the newly installed filter
was intended to block, especially since the tracer might have modified
the system call number during the ptrace stop.

Fix this by re-reading the syscall_work flags after ptrace handling,
so that any new SYSCALL_WORK_SECCOMP flag set by another thread via
TSYNC during the ptrace stop is observed before the subsequent
seccomp check.

Fixes: 142781e108b1 ("entry: Provide generic syscall entry functionality")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260629132914.1135C1F000E9@smtp.kernel.org/
Link: https://patch.msgid.link/20260713025712.416366-1-ruanjinjie@huawei.com
---
 include/linux/entry-common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 07d97de..299f13c 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -97,6 +97,9 @@ static __always_inline long syscall_trace_enter(struct pt_r=
egs *regs, unsigned l
 		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
 		    (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
+
+		/* ptrace might have changed work flags */
+		work =3D READ_ONCE(current_thread_info()->syscall_work);
 	}
=20
 	/* Do seccomp after ptrace, to catch any tracer changes. */

