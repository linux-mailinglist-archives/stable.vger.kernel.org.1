Return-Path: <stable+bounces-273389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S5WaEQIaUmr+LwMAu9opvQ
	(envelope-from <stable+bounces-273389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 12:25:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB5F741384
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 12:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=iDK+zq7v;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=vx3H2cMZ;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273389-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273389-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BFD83008601
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246B03AA9CA;
	Sat, 11 Jul 2026 10:25:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083C37A83C;
	Sat, 11 Jul 2026 10:24:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765500; cv=none; b=fJ94QF8nXyslpu+y8xOguW7gJ9dFOFd5Y2VT6GyWe56Ws7KwBMj026Xw6I3Z2UF4meLgbq8sNYB3iPmrGKmEFhC2dPBQEFiHJGUk4PGoEUp+sN/xvFK87EJ6Tn/qSGKzdkv0hk9nBlcPufEubNvUL017iQG8CRhFSK6g3zy+74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765500; c=relaxed/simple;
	bh=9M8IJHpa2aHSVckwfpDweVSSDAcv3Tp0HTrdc5zXNNA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MpTvMbyaNYUGe/A8A8RlU8Z3lC1T/j+XC4vfN4nZjciXh56FBhlv8sn5wI/REjYVgRxOeXPWxeCQVvXh3zABw6n8o0ycrqU/XnqoxBnavBa2DWnwm3kEm3SxJrbhEzVH2mAFUNv9ZzTYMQlK1IuTqO26Pm9oUsjaWuO8WTPjbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDK+zq7v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vx3H2cMZ; arc=none smtp.client-ip=193.142.43.55
Date: Sat, 11 Jul 2026 10:24:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783765492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWJRncW3mnoRmno31NiF6dw37z5A4a6g603L8sKS4Po=;
	b=iDK+zq7vZoxDKnlyKAfmm8P8/BlOyuGFmQzEnnXslQzsqM8p1PlGp4RZvoN7rT6VvMu6EK
	4fATOGrpFSxe0BHof5wulCqHT+iLvvNQzkXpZ7FJOKNH3u6Uj4vi2W6K9NN+Bxx+62zOjX
	GWLy47olm1WCFl96O3qmjxG5q7L7lIyQQZbiY7FO/UIKT/YGh2m567xz+c8sQjHGODWMXS
	gHqADyhCEBRKt8xJ09RV9cFeS546xQ2vTAe2UkIKNj4UyV6+XL/vSllKoVMoDur6LFRQmR
	XIScTdq/E+zWRFoLsaJCXuLMM6JnIOZFuAb1hRv9u+rvUPdZceXUP6rec9bGzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783765492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWJRncW3mnoRmno31NiF6dw37z5A4a6g603L8sKS4Po=;
	b=vx3H2cMZNAnbVExszNpBxc2lOMGlGwODfdP/p5d50aPHumq8ewX2e1IQ/hUu2sBrd4uKBn
	H4I08vKMcMZLmxBg==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/brs: Fix kernel address leakage
Cc: Sashiko <sashiko-bot@kernel.org>, Sandipan Das <sandipan.das@amd.com>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf05931c4f89a146c364bd5dc6b8170b1ac611c65=2E1783701?=
 =?utf-8?q?239=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cf05931c4f89a146c364bd5dc6b8170b1ac611c65=2E17837012?=
 =?utf-8?q?39=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178376549047.1844600.703834809296930525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-tip-commits@vger.kernel.org,m:sashiko-bot@kernel.org,m:sandipan.das@amd.com,m:mingo@kernel.org,m:stable@vger.kernel.org,m:peterz@infradead.org,m:eranian@google.com,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273389-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,vger.kernel.org:from_smtp,vger.kernel.org:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:from_mime,linutronix.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BB5F741384

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     47915e855fb38b42133e31ba917d99565f862154
Gitweb:        https://git.kernel.org/tip/47915e855fb38b42133e31ba917d99565f8=
62154
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 10 Jul 2026 22:04:49 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 11 Jul 2026 12:19:28 +02:00

perf/x86/amd/brs: Fix kernel address leakage

A user-only branch stack can contain branches that originate from
the kernel. As a result, kernel addresses are exposed to user space
even when PERF_SAMPLE_BRANCH_USER is requested. On AMD processors
supporting X86_FEATURE_BRS (Zen 3 only), perf can still report entries
such as SYSRET/interrupt returns for which the branch-from addresses
are in the kernel.

E.g.

  $ perf record -j any,u -c 4000 -e branch-brs -o - -- \
        perf bench syscall basic --loop 1000 | \
        perf script -i - -F brstack|tr ' ' '\n'| \
        grep -E '0x[89a-f][0-9a-f]{15}'

  ...
  0xffffffff810001c4/0x72e2e32955eb/-/-/-/0//-
  0xffffffff810001c4/0x72e2d94a9821/-/-/-/0//-
  0xffffffff810001c4/0x72e2d94ffa1b/-/-/-/0//-
  ...

BRS provides no hardware branch filtering, so privilege level
filtering is performed entirely in software. However, amd_brs_match_plm()
only validates the branch-to address against the requested privilege
levels. For branches from the kernel to user space, the branch-from
address is left unchecked and is leaked. Extend the software filter to
also validate the branch-from address, so that any branch record whose
branch-from address is in the kernel is dropped when
PERF_SAMPLE_BRANCH_USER is requested.

Fixes: 8910075d61a3 ("perf/x86/amd: Enable branch sampling priv level filteri=
ng")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://patch.msgid.link/f05931c4f89a146c364bd5dc6b8170b1ac611c65.17837=
01239.git.sandipan.das@amd.com
Closes: https://lore.kernel.org/all/20260710110235.F3FD81F000E9@smtp.kernel.o=
rg/
---
 arch/x86/events/amd/brs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 06f35a6..dc56468 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -259,13 +259,13 @@ void amd_brs_disable_all(void)
 		amd_brs_disable();
 }
=20
-static bool amd_brs_match_plm(struct perf_event *event, u64 to)
+static bool amd_brs_match_plm(struct perf_event *event, u64 from, u64 to)
 {
 	int type =3D event->attr.branch_sample_type;
 	int plm_k =3D PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_HV;
 	int plm_u =3D PERF_SAMPLE_BRANCH_USER;
=20
-	if (!(type & plm_k) && kernel_ip(to))
+	if (!(type & plm_k) && (kernel_ip(to) || kernel_ip(from)))
 		return 0;
=20
 	if (!(type & plm_u) && !kernel_ip(to))
@@ -338,11 +338,11 @@ void amd_brs_drain(void)
 		 */
 		to =3D (u64)(((s64)to << shift) >> shift);
=20
-		if (!amd_brs_match_plm(event, to))
-			continue;
-
 		rdmsrq(brs_from(brs_idx), from);
=20
+		if (!amd_brs_match_plm(event, from, to))
+			continue;
+
 		perf_clear_branch_entry_bitfields(br+nr);
=20
 		br[nr].from =3D from;

