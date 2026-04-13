Return-Path: <stable+bounces-237588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPgdCQIo3WmVaQkAu9opvQ
	(envelope-from <stable+bounces-237588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:29:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEB93F1784
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8898B324F7CD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3336333429;
	Mon, 13 Apr 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q/imnLds"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2231354F;
	Mon, 13 Apr 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099844; cv=none; b=urHfRXA1wSLFBlyG4rEqjyInP7isgn9f5Vc+C8dprVvyC4PZjBmQY76TukqRv2V/5tnUgZGJeliEJpEuys7SO03lpkVx3X05lQLM5/7LoDaruuWBHEMxHMkz5TaBtDoy4VyqJjDOImdezAEjUS2VeOsvDK3IjR2qZL/wChfEYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099844; c=relaxed/simple;
	bh=Q0XAnFHKKu4/vucZh6n/ZaLRVLk/tD0OSJY1quC+XOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8cwYTpRJDD8q5n9gRJ3zofgOzlhV846bIpqtag2tY9h+4iZcI2POhgZ6tzCP18+M+Ldrs168mmtTQfzdwAGfnPusBbfiK/hnaD9fQDnFJTAOG4/ac39nWN4Sp4hYVA53/hcLRMGp29kiR/LrvZ6LMPeBbRc7zGH0XraoKP/BvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q/imnLds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4659AC2BCAF;
	Mon, 13 Apr 2026 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099844;
	bh=Q0XAnFHKKu4/vucZh6n/ZaLRVLk/tD0OSJY1quC+XOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/imnLdsd2gxC/lKdFJV1FoaXQCtpHl3vlUUPrTRN6acu4SqPOvik3C0ox063phaP
	 ZVp0mtynRpKSlkMIcWf3KONUYIbmrVDgfB9Xxkmfkd4iWL5si3xyTRXZpn61Csvem9
	 0tJY8QQS2SqcCvjqar6LEC3SQhcO9MR628GVrQ4g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	stable@kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 5.10 488/491] s390/syscalls: Add spectre boundary for syscall dispatch table
Date: Mon, 13 Apr 2026 18:02:13 +0200
Message-ID: <20260413155837.326301938@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237588-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,arndb.de:email]
X-Rspamd-Queue-Id: 9DEB93F1784
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 48b8814e25d073dd84daf990a879a820bad2bcbd ]

The s390 syscall number is directly controlled by userspace, but does
not have an array_index_nospec() boundary to prevent access past the
syscall function pointer tables.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Fixes: 56e62a737028 ("s390: convert to generic entry")
Cc: stable@kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/2026032404-sterling-swoosh-43e6@gregkh
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
[ gor: 5.10 backport. In 5.10, commit 56e62a737028 ("s390: convert to
  generic entry") has not been applied — syscall dispatch is in
  assembly (entry.S), not in C (syscall.c). The equivalent to
  array_index_nospec() is implemented using the same clgr/slbgr/ngr.

  SVC 0 path: the user-controlled syscall number in r1 is clamped via
  a single unsigned compare (clgr) followed by slbgr/ngr. The original
  cghi/jnl bounds check branch is replaced — the clamp handles both
  cases: in-bounds values pass through, out-of-bounds values are zeroed
  (producing the same r8=0 dispatch to table[0] as the original branch).

  SVC 1-255 path: syscall number from the 8-bit instruction immediate
  is always in bounds. ]
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/entry.S |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -420,12 +420,15 @@ ENTRY(system_call)
 	# svc 0: system call number in %r1
 	llgfr	%r1,%r1				# clear high word in r1
 	sth	%r1,__PT_INT_CODE+2(%r11)
-	cghi	%r1,NR_syscalls
-	jnl	.Lsysc_nr_ok
+	lghi	%r0,NR_syscalls-1
+	clgr	%r1,%r0				# CC0/1 if r1 in bounds
+	slbgr	%r0,%r0				# mask = -1 in bounds, 0 out of bounds
+	ngr	%r1,%r0				# clamp r1
 	slag	%r8,%r1,3
 .Lsysc_nr_ok:
 	stg	%r2,__PT_ORIG_GPR2(%r11)
 	stg	%r7,STACK_FRAME_OVERHEAD(%r15)
+	xgr	%r1,%r1				# scrub r1, unclamped user value for svc 1-255
 	lg	%r9,0(%r8,%r10)			# get system call add.
 	TSTMSK	__TI_flags(%r12),_TIF_TRACE
 	jnz	.Lsysc_tracesys



