Return-Path: <stable+bounces-79383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB2B98D7F5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114E31F21136
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793081D04AD;
	Wed,  2 Oct 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NbQqGTmm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814C1D0493;
	Wed,  2 Oct 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877283; cv=none; b=HMDvybdEh1CyVGt3tK22HkfwUdyjtFyKJy1M+295KLcn3mArIOubWl1V29Ix8cQE5pYeRR9oqHOPtcRQvJ/ivuzRTpVG24ByCiLW16c1fGijZKFpbzVrWtiulH+F8b35tKRW2Jp5bk8C2oCCv5KcPo1JSCgnvN7tyOJXU3DwXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877283; c=relaxed/simple;
	bh=HKFlpBqNFDfDPWL7XKOYDmKA1kOiAuRhjdhAUtUrgNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpPjoOwUsUpciIs30VPtUmPYlHjmsIVZWh6DXSY+8kVpwXzgy+a0wSqFny08vNQr6FV7u52h7JvnJmpo02QyUAxpzXk/AN0AAGN24xcENnpVq9wq3LJWowhseEaOUyNrbjiRs6/WDo4lZLB4zAwZoxi65a4/qRYN243W9Cm7vM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NbQqGTmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DC3C4AF14;
	Wed,  2 Oct 2024 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877283;
	bh=HKFlpBqNFDfDPWL7XKOYDmKA1kOiAuRhjdhAUtUrgNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbQqGTmm7/fyJRso3SQErlpLGtEwT3dZDoRXec1hqocGN2xxKUYzDve2e8KaVMZms
	 a8ohNle3M77rKoEy2O5DuLpXlMjngS4rRanLZ3maIuyqNGsg89Gi8ZxPhS8km5OBRr
	 ShsZEkvYh9er1++GbGwgI8IJuSshuOhKYKRrKWZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	John David Anglin <dave.anglin@bell.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 004/634] crypto: xor - fix template benchmarking
Date: Wed,  2 Oct 2024 14:51:44 +0200
Message-ID: <20241002125811.256482739@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@kernel.org>

[ Upstream commit ab9a244c396aae4aaa34b2399b82fc15ec2df8c1 ]

Commit c055e3eae0f1 ("crypto: xor - use ktime for template benchmarking")
switched from using jiffies to ktime-based performance benchmarking.

This works nicely on machines which have a fine-grained ktime()
clocksource as e.g. x86 machines with TSC.
But other machines, e.g. my 4-way HP PARISC server, don't have such
fine-grained clocksources, which is why it seems that 800 xor loops
take zero seconds, which then shows up in the logs as:

 xor: measuring software checksum speed
    8regs           : -1018167296 MB/sec
    8regs_prefetch  : -1018167296 MB/sec
    32regs          : -1018167296 MB/sec
    32regs_prefetch : -1018167296 MB/sec

Fix this with some small modifications to the existing code to improve
the algorithm to always produce correct results without introducing
major delays for architectures with a fine-grained ktime()
clocksource:
a) Delay start of the timing until ktime() just advanced. On machines
with a fast ktime() this should be just one additional ktime() call.
b) Count the number of loops. Run at minimum 800 loops and finish
earliest when the ktime() counter has progressed.

With that the throughput can now be calculated more accurately under all
conditions.

Fixes: c055e3eae0f1 ("crypto: xor - use ktime for template benchmarking")
Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: John David Anglin <dave.anglin@bell.net>

v2:
- clean up coding style (noticed & suggested by Herbert Xu)
- rephrased & fixed typo in commit message

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/xor.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/crypto/xor.c b/crypto/xor.c
index 8e72e5d5db0de..56aa3169e8717 100644
--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -83,33 +83,30 @@ static void __init
 do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 {
 	int speed;
-	int i, j;
-	ktime_t min, start, diff;
+	unsigned long reps;
+	ktime_t min, start, t0;
 
 	tmpl->next = template_list;
 	template_list = tmpl;
 
 	preempt_disable();
 
-	min = (ktime_t)S64_MAX;
-	for (i = 0; i < 3; i++) {
-		start = ktime_get();
-		for (j = 0; j < REPS; j++) {
-			mb(); /* prevent loop optimization */
-			tmpl->do_2(BENCH_SIZE, b1, b2);
-			mb();
-		}
-		diff = ktime_sub(ktime_get(), start);
-		if (diff < min)
-			min = diff;
-	}
+	reps = 0;
+	t0 = ktime_get();
+	/* delay start until time has advanced */
+	while ((start = ktime_get()) == t0)
+		cpu_relax();
+	do {
+		mb(); /* prevent loop optimization */
+		tmpl->do_2(BENCH_SIZE, b1, b2);
+		mb();
+	} while (reps++ < REPS || (t0 = ktime_get()) == start);
+	min = ktime_sub(t0, start);
 
 	preempt_enable();
 
 	// bytes/ns == GB/s, multiply by 1000 to get MB/s [not MiB/s]
-	if (!min)
-		min = 1;
-	speed = (1000 * REPS * BENCH_SIZE) / (unsigned int)ktime_to_ns(min);
+	speed = (1000 * reps * BENCH_SIZE) / (unsigned int)ktime_to_ns(min);
 	tmpl->speed = speed;
 
 	pr_info("   %-16s: %5d MB/sec\n", tmpl->name, speed);
-- 
2.43.0




