Return-Path: <stable+bounces-265367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V+tGKoyHMWoQlwUAu9opvQ
	(envelope-from <stable+bounces-265367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:27:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB369324D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:27:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=wW0RUixm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265367-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265367-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3CDB3035B90
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838A47CC6F;
	Tue, 16 Jun 2026 17:27:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420B47CC62;
	Tue, 16 Jun 2026 17:27:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630843; cv=none; b=j/hyWMq4qsB6QcSZvRHPEnaS+DvFoeFBrnezO+lvzNh4duLae+VST+dVqDqQrxAredPX1suWbqmtpje1ojjiVq+G3No0les70cilC9or+RWuMsgHQFcHFLKtV+cI5oaqQPDP93BGrPqcrfN1vqR9xcWeAn8dHJ4mCctS5/ZEupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630843; c=relaxed/simple;
	bh=Z8Vt91zj72vO6dYVtCCqt6hnUMwJA5V7w5c0JyCTuuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIbIhihU8MFRBlDk5PpSavJMbcMjUIuR3beVd6xyq6BrNOFCymhB+92T5RW5jcjzhfSBLqtW3FcZbKILol/dWh0sqW9ai3kWNJQl54xoLRKLiWoliTJDOMs+6WshHh9jOgVraCML0MEsshdtNyyZqnH8BaGUfeVdBU6NElaFg+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wW0RUixm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456A01F00A3A;
	Tue, 16 Jun 2026 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630839;
	bh=cJabSVuF17c0bnkwZ9MBiAhR+2ZcCExejqN7GUhmybM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wW0RUixmcPLcBwvzqMy2WXAHrq0YXhRApxSK9iI3zxbZrgMwHqJIkqbLX+kZvmL8E
	 uAGxUZRwzWM3pP+/RudRJdEHPv4w5h4wjxPTKMFtGdqNBV1aj1aIaR3xlPkOKeZYQv
	 itmQ4W0pWzzfBKywsHBAIGvvDGGc89CYe5ZlKfZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 063/522] selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test
Date: Tue, 16 Jun 2026 20:23:30 +0530
Message-ID: <20260616145128.744011374@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,iogearbox.net,kernel.org,gmail.com,suse.com];
	TAGGED_FROM(0.00)[bounces-265367-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:daniel@iogearbox.net,m:andrii@kernel.org,m:ast@kernel.org,m:paul.chaignon@gmail.com,m:shung-hsi.yu@suse.com,m:sashal@kernel.org,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,suse.com:email,iogearbox.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39FB369324D

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit b8e188f023e07a733b47d5865311ade51878fe40 ]

The assumption of 'in privileged mode reads from uninitialized stack locations
are permitted' is not quite correct since the verifier was probing for read
access rather than write access. Both tests need to be annotated as __success
for privileged and unprivileged.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240913191754.13290-6-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Note: The format of logs completely changed since 6.1 so this change
  had to be reapplied to the old test file. This commit needs to be
  backported because it fixes a test broken by commit 32556ce93bc4
  ("bpf: Fix helper writes to read-only maps") from the same patchset. ]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/verifier/int_ptr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/int_ptr.c b/tools/testing/selftests/bpf/verifier/int_ptr.c
index 02d9e004260b33..8c74cff2090364 100644
--- a/tools/testing/selftests/bpf/verifier/int_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/int_ptr.c
@@ -25,9 +25,8 @@
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 	},
-	.result = REJECT,
+	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid indirect read from stack R4 off -16+0 size 8",
 },
 {
 	"ARG_PTR_TO_LONG half-uninitialized",
@@ -57,9 +56,6 @@
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	},
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "invalid indirect read from stack R4 off -16+4 size 8",
-	/* in privileged mode reads from uninitialized stack locations are permitted */
 	.result = ACCEPT,
 },
 {
-- 
2.53.0




