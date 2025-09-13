Return-Path: <stable+bounces-179512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 145D4B5626B
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9895487C39
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F021D8E10;
	Sat, 13 Sep 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yr358pY0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RTWG5bvZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4AC11CA9;
	Sat, 13 Sep 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757786288; cv=none; b=lwi3a1lueM4MxNOFaYkjpJUnIhpzFDIKjtnImmn+UTyscT+aYD8Q9lEXI+jT/yFdargepqLilYPo8bTVGyzviATOd8Wau5qWUqUhmyt9djWrdwOIJiX4vJbRsKwMx2ILuLV/uG01tFJ3FRTYPjfZwkwBVMp8GnldRTYRjvApX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757786288; c=relaxed/simple;
	bh=zgdz6n3ryg7t4I0el7j6ZzzfFc6HjcWsuZaIjbt8CRY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YOVcLfu1R2dt2WetoliNIhH62SPrzsfx8qB4hXjTEIPBRBTECuxCR2eCO2/JQsXpAJs9PdROXztVnHaOdB461of1zkqQsGkKVUZV5s1st8PLu9QBvznZKCOMe2r8o4A7dH/HuBcUcCcYnY7lki+71JdPQJp83XMkZ838wmkZRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yr358pY0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RTWG5bvZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 17:57:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757786277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpCHiUfY4iKXOHNIZfc6CvZL6560RzFW0kNpZQ0ilQ0=;
	b=Yr358pY0KZUR4PN1y94g0xXaEY64h7pReTBb7ULpOdYcjcptiYiY02IUtbXeIRi2KkBkZR
	RzvIISZm4UEwxg8enyRYXkidWWC32QBAc+EJtKPfhdLvnPIuXLfSNAJ4qiOnS5DomGa6KQ
	kLWmQK9XxuBQ20RPpPaIdhIXWKBkoN0Erd734BD46C321qgvdedjGLehAoHeKFtBAH76Rh
	MPEWKUpYHmMQ7vxAlJTcmA9J/reZNHZpr9O9fB7HCy3+NQyeWuun2qOwi1D6olB+uhKLCL
	vjfdToZKOgdTvGG13mprZALjZ2yGiJsGda3YbpUrmq0pKtF2Qd/5ZvHRu9CZ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757786277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpCHiUfY4iKXOHNIZfc6CvZL6560RzFW0kNpZQ0ilQ0=;
	b=RTWG5bvZ02DxF/0R78iQFO2Opm+zEDtySYr/PAEa25EGXzxgppIQ/OIeJxHefPvAZAe6Ol
	Ot0e1bxBU71JTQDQ==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq/selftests: Use weak symbol reference, not
 definition, to link with glibc
Cc: Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250819222945.3052711-1-seanjc@google.com>
References: <20250819222945.3052711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175778627632.709179.640101238691946998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     a001cd248ab244633c5fabe4f7c707e13fc1d1cc
Gitweb:        https://git.kernel.org/tip/a001cd248ab244633c5fabe4f7c707e13fc=
1d1cc
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Tue, 19 Aug 2025 15:29:44 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 13 Sep 2025 19:51:59 +02:00

rseq/selftests: Use weak symbol reference, not definition, to link with glibc

Add "extern" to the glibc-defined weak rseq symbols to convert the rseq
selftest's usage from weak symbol definitions to weak symbol _references_.
Effectively re-defining the glibc symbols wreaks havoc when building with
-fno-common, e.g. generates segfaults when running multi-threaded programs,
as dynamically linked applications end up with multiple versions of the
symbols.

Building with -fcommon, which until recently has the been the default for
GCC and clang, papers over the bug by allowing the linker to resolve the
weak/tentative definition to glibc's "real" definition.

Note, the symbol itself (or rather its address), not the value of the
symbol, is set to 0/NULL for unresolved weak symbol references, as the
symbol doesn't exist and thus can't have a value.  Check for a NULL rseq
size pointer to handle the scenario where the test is statically linked
against a libc that doesn't support rseq in any capacity.

Fixes: 3bcbc20942db ("selftests/rseq: Play nice with binaries statically link=
ed against glibc 2.35+")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/87frdoybk4.ffs@tglx
---
 tools/testing/selftests/rseq/rseq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rs=
eq/rseq.c
index 663a9ce..dcac5cb 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -40,9 +40,9 @@
  * Define weak versions to play nice with binaries that are statically linked
  * against a libc that doesn't support registering its own rseq.
  */
-__weak ptrdiff_t __rseq_offset;
-__weak unsigned int __rseq_size;
-__weak unsigned int __rseq_flags;
+extern __weak ptrdiff_t __rseq_offset;
+extern __weak unsigned int __rseq_size;
+extern __weak unsigned int __rseq_flags;
=20
 static const ptrdiff_t *libc_rseq_offset_p =3D &__rseq_offset;
 static const unsigned int *libc_rseq_size_p =3D &__rseq_size;
@@ -209,7 +209,7 @@ void rseq_init(void)
 	 * libc not having registered a restartable sequence.  Try to find the
 	 * symbols if that's the case.
 	 */
-	if (!*libc_rseq_size_p) {
+	if (!libc_rseq_size_p || !*libc_rseq_size_p) {
 		libc_rseq_offset_p =3D dlsym(RTLD_NEXT, "__rseq_offset");
 		libc_rseq_size_p =3D dlsym(RTLD_NEXT, "__rseq_size");
 		libc_rseq_flags_p =3D dlsym(RTLD_NEXT, "__rseq_flags");

