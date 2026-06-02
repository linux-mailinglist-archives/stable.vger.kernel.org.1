Return-Path: <stable+bounces-259937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQq8HCuHH2pvmwAAu9opvQ
	(envelope-from <stable+bounces-259937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 03:45:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13868633820
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 03:45:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=lWWRoizP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259937-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259937-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEEE9310275B
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2853769F1;
	Wed,  3 Jun 2026 01:38:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277C37BE88;
	Wed,  3 Jun 2026 01:38:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450706; cv=none; b=VHpjUwPVRtQH1m2kSnu4xpDTRIhHWW19b8HncFMkhGyBcGGit7xKYToTQQnFUieoa+2GDTuf+6aVLSGX0MSeGBIadrxkpuwhHKk2KcWjfo8YU1lwywPLdMMBTL3G7ifyBShGtH7b6xi/W/XhrqjwbtgPei+pswjsZl/PMPShke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450706; c=relaxed/simple;
	bh=7dpTDpxwEOIzk22YgLvrqs67Vg7Je/wtKwL+vcE03QM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFbt3YGsZZoOlANLP7dw7V12aID8t1Vm6fQC/eAnKXoKJn06wsAnztNQJeKsn83nYIbDA2PsKKVCDC5G0UlPZF1W163A8Wk6USJrvucOsTkIxKJfTvAS0zjDikotNnRQt1S4A89DOox6DWGsVcRXZngzzUG/EMY8VQQYSPvDqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lWWRoizP; arc=none smtp.client-ip=109.224.244.121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780450698; x=1780709898;
	bh=Xoqh0gHhlYUbvmyM3ulY5nL3TPXotPEdpVBETVb6EVA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lWWRoizPdrttMmBQQyvx1vXFKvBunBnRxLjSwoT47KOhwpUjbmJNA1dNaXqsG5Vch
	 yxhuFZJ8TAQab/8iPeu0EuOZLh4dAz/Pvj4agljjz/4MwmibNrbQGqhbWr+oraHJ93
	 bEFtWfnQ6AdUvajuwiLkGNaaCZ3NMmGhg3uAtsyki6TZKuxACZkBdqUzJ6hYyxJnQa
	 qqN5E+tfzdrdsnZa+UEXpa2B5aD64qzuOyrS8a9iD6izZgJitJf90xC4vcj8loe7tZ
	 5sWqS3ILNWDFG97ynzcgV2GbNKzbYxsAYJdemGxlGMPV4Y/5gH/he8kUK/J/Ui9sad
	 M8oWm2Bw1lcyg==
Date: Tue, 02 Jun 2026 17:27:56 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Justin Suess <utilityemal77@gmail.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
Message-ID: <20260602172741.18760-2-hexlabsecurity@proton.me>
In-Reply-To: <20260602172741.18760-1-hexlabsecurity@proton.me>
References: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me> <20260531.irah0eiM3Chi@digikod.net> <20260602172741.18760-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 942fde585501fdf26f189db2f771231337837627
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259937-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mic@digikod.net,m:gnoack@google.com,m:utilityemal77@gmail.com,m:brauner@kernel.org,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-security-module@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13868633820

LANDLOCK_SCOPE_SIGNAL must prevent a sandboxed process from signaling
processes outside its Landlock domain.  It can be bypassed through the
asynchronous SIGIO delivery path.

A sandboxed process that owns any file or socket can arm it with
fcntl(F_SETOWN, fd, -pgid), fcntl(F_SETSIG, fd, SIGKILL) and O_ASYNC, so
that an I/O event makes the kernel deliver the chosen signal to the whole
process group.  As the head of its own process group -- the default right
after fork() -- that group also holds the non-sandboxed process that
launched it, e.g. a supervisor or a security monitor.  The sandbox can
thus kill or repeatedly signal exactly the processes SCOPE_SIGNAL is meant
to protect from it.

The scope is enforced in hook_file_send_sigiotask() against the Landlock
domain recorded at F_SETOWN time, not the live domain of the sender.
control_current_fowner() decides whether to record that domain and skips
recording it when the fowner target is in the caller's thread group --
safe only when the target is a single process sharing the caller's
credentials (PIDTYPE_PID, PIDTYPE_TGID).  For a process group
(PIDTYPE_PGID) the target resolves to the caller itself when it is the
group head, recording is skipped, and hook_file_send_sigiotask() then lets
the signal fan out to the whole group unchecked.

Skip the recording only for the single-process target types, so the scope
is enforced against every group member at delivery time.  The direct
kill() path (hook_task_kill) already evaluates the live domain and is
unaffected.

Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of the=
 same process")
Cc: stable@vger.kernel.org
Tested-by: Justin Suess <utilityemal77@gmail.com>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 security/landlock/fs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..2ebad70a956d 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1909,6 +1909,15 @@ static bool control_current_fowner(struct fown_struc=
t *const fown)
 =09if (!p)
 =09=09return true;
=20
+=09/*
+=09 * A process-group fowner fans the signal out to every member at
+=09 * delivery time, so record the domain for any non single-process
+=09 * target -- even when it resolves to current as the group head --
+=09 * and let hook_file_send_sigiotask() check the live scope.
+=09 */
+=09if (fown->pid_type !=3D PIDTYPE_PID && fown->pid_type !=3D PIDTYPE_TGID=
)
+=09=09return true;
+
 =09return !same_thread_group(p, current);
 }
=20
--=20
2.43.0



