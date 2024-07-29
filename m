Return-Path: <stable+bounces-62464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9081C93F2EC
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B95281D93
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EF2144D1D;
	Mon, 29 Jul 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rFs19L4p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+pyCbmD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8EB14601D;
	Mon, 29 Jul 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249253; cv=none; b=GTLXuauLyn48qssfIougPoqfHeuuEnlb4FWHjzcK3ZYjvt8IjYHm5bUeoZCBUHoxvNypgWH/JUIiesHUwlRveE4sinltOWRE8/xJWwnM7gaCS0j84UyxgoP7Ns4+0wW8v/rIfDfUf1SEqQIQpHLPC0DNx5APK/gqp3UnAdePjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249253; c=relaxed/simple;
	bh=jnPFfqor5Y2fWJUqYSVT/Uv/kXKSMMu2OTN3T3KWWAc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eztfy0bg7niWlYftNco4vVasM6qTOInFPgZmRTJiXGdQWHDGASVPLiSCqBL69mjJZlUaA5VQHV8f4HBw5GH9T+DCQvLUqMfvDKjOF+oW9f6CCGHHqP1MDpPYWOx2GoWxfoC2QzN3mGej9leGbFlbhrdaDjcGe2hCzk8at8CR9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rFs19L4p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+pyCbmD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wI0wVWx/FBXb2r5j/O7uXzL0zD/I9X4AL+HZALiPv4=;
	b=rFs19L4pLAm8gVkj0auJq6HpUhJNQH0CpAlINPK+pDuJMlixdrRjHwM1qrVabjVYbfhqwM
	aRSusLl2p94pzvl4Tndo1N52epqDh6wyzdhkSrqH6FFyciuc8SAXmeLN3CiuhB1enndHqQ
	F0xhvDNSVIicgZMl0EeGuPfRzcaAGoN0rx6WFLcYRB0uBAZ6rjQMs/essXYpdEaQAf5+YI
	dWF340AvVGF9s8yYN0PQ0Nn520mdDBsCUPdSSD14Hucwq1HKWMGGAvMVHyLdvnSPpEzFQQ
	v1Ft1cgDyLZxaPyKsJ5gPkiJY94wAuqjZRsvZZFCJGDnSCOjFuZE6lbtiyWgdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wI0wVWx/FBXb2r5j/O7uXzL0zD/I9X4AL+HZALiPv4=;
	b=U+pyCbmDKwMMEkOIeX32TERnJpeM85BA/FrBl5p6yljaKeq1L45vJZiP2bzkxjO9kadBTD
	jgPBHPcHUyJ7HyDg==
From: "tip-bot2 for Zheng Zucheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cputime: Fix mul_u64_u64_div_u64() precision
 for cputime
Cc: Zheng Zucheng <zhengzucheng@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,  <stable@vger.kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240726023235.217771-1-zhengzucheng@huawei.com>
References: <20240726023235.217771-1-zhengzucheng@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224925041.2215.18209805877269805582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     77baa5bafcbe1b2a15ef9c37232c21279c95481c
Gitweb:        https://git.kernel.org/tip/77baa5bafcbe1b2a15ef9c37232c21279c95481c
Author:        Zheng Zucheng <zhengzucheng@huawei.com>
AuthorDate:    Fri, 26 Jul 2024 02:32:35 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:32 +02:00

sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime

In extreme test scenarios:
the 14th field utime in /proc/xx/stat is greater than sum_exec_runtime,
utime = 18446744073709518790 ns, rtime = 135989749728000 ns

In cputime_adjust() process, stime is greater than rtime due to
mul_u64_u64_div_u64() precision problem.
before call mul_u64_u64_div_u64(),
stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
after call mul_u64_u64_div_u64(),
stime = 135989949653530

unsigned reversion occurs because rtime is less than stime.
utime = rtime - stime = 135989749728000 - 135989949653530
		      = -199925530
		      = (u64)18446744073709518790

Trigger condition:
  1). User task run in kernel mode most of time
  2). ARM64 architecture
  3). TICK_CPU_ACCOUNTING=y
      CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set

Fix mul_u64_u64_div_u64() conversion precision by reset stime to rtime

Fixes: 3dc167ba5729 ("sched/cputime: Improve cputime_adjust()")
Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20240726023235.217771-1-zhengzucheng@huawei.com
---
 kernel/sched/cputime.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index a5e0029..0bed0fa 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -582,6 +582,12 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	}
 
 	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
+	/*
+	 * Because mul_u64_u64_div_u64() can approximate on some
+	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
+	 */
+	if (unlikely(stime > rtime))
+		stime = rtime;
 
 update:
 	/*

