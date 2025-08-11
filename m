Return-Path: <stable+bounces-167068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BFAB216A2
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 22:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319E42A0D40
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 20:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709982D949F;
	Mon, 11 Aug 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a72cdbaK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h2Ar8NoK"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13F4EB38;
	Mon, 11 Aug 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944825; cv=none; b=bRtAXVSZ3Y/oSUx2pTN8Ab3YeCaPXnNA+8WX8P+w/0LaBpYJQqUg/dQO96puFVVPCTAH1Y5HdHmvmyxhKSELM+DtoBbs8dL8AtZT7gq0G3y3qg7l8R6s5G5LtfIyj+kabI4O+LNJGg/p4ngRHiSKa0Hfh+mO56yM78ClAtXowTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944825; c=relaxed/simple;
	bh=4yIQRxdr5LK+GyTABnsJhF50za0tC4FBDtqXTzYbio4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=NJIHo+IUZpQR5hJbKh77NSMuS4g5uB9RbokmRkGMYZhDgjjJhL8TTKTHapMjTZkaEuBY6K87LBV1vr2y+uZxf0SBqwMg/eMyPjL9HvFJ4PiTWynKRzE++lXSdkdv0Y1klei6dorLBsuzvaiht59rAcWUBkZFKkGatUlP6xajhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a72cdbaK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h2Ar8NoK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Aug 2025 20:40:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754944820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YSaeji+ngrHjZZCopR4Eapy73qXsXyF5LS4tG0kO0Ac=;
	b=a72cdbaKS0TgTdc9/r9Cs9e/38ABXAt/cqqyrXgO1sRN0IEfKo+x6PntTqNemXydsY8PSZ
	FJvAlRN0svYMjyjJ3N5kuErzh2pnspHwa0hAbSswT0xd+0owKGi5qHOWY/lZJrSisYnNbz
	O96Sa5FEYN1rmA4oL4XuHJr6X+IaTA+CDlVnkiNo83Dbf6YxFKB+VT3qYmyu4ntG8u4Z7y
	K25aeovcn4FHwnXGzOO9iMFbqT4ju8plJY4Nd062H0o4xzsg5i0NojFA4KXhXf6cJPRefu
	K6xOvg8hkc3gZQoA1HBSsWoqww5dY/BKddwWY3NGTaVHoIXpc4QOIVtI87ozvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754944820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YSaeji+ngrHjZZCopR4Eapy73qXsXyF5LS4tG0kO0Ac=;
	b=h2Ar8NoK+/JA2TVox3ySIZLJfm5NYYcLBgyktvLHL0A5LAvuLa2x8A58ngkKZmbKcxK8xg
	hJV8UEK/oZ/LeECw==
From: "tip-bot2 for Fushuai Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Fix NULL dereference in avx512_status()
Cc: Sohil Mehta <sohil.mehta@intel.com>, Fushuai Wang <wangfushuai@baidu.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175494481915.1420.11907322564960386974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     31cd31c9e17ece125aad27259501a2af69ccb020
Gitweb:        https://git.kernel.org/tip/31cd31c9e17ece125aad27259501a2af69c=
cb020
Author:        Fushuai Wang <wangfushuai@baidu.com>
AuthorDate:    Mon, 11 Aug 2025 11:50:44 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Aug 2025 13:28:07 -07:00

x86/fpu: Fix NULL dereference in avx512_status()

Problem
-------
With CONFIG_X86_DEBUG_FPU enabled, reading /proc/[kthread]/arch_status
causes a warning and a NULL pointer dereference.

This is because the AVX-512 timestamp code uses x86_task_fpu() but
doesn't check it for NULL. CONFIG_X86_DEBUG_FPU addles that function
for kernel threads (PF_KTHREAD specifically), making it return NULL.

The point of the warning was to ensure that kernel threads only access
task->fpu after going through kernel_fpu_begin()/_end(). Note: all
kernel tasks exposed in /proc have a valid task->fpu.

Solution
--------
One option is to silence the warning and check for NULL from
x86_task_fpu(). However, that warning is fairly fresh and seems like a
defense against misuse of the FPU state in kernel threads.

Instead, stop outputting AVX-512_elapsed_ms for kernel threads
altogether. The data was garbage anyway because avx512_timestamp is
only updated for user threads, not kernel threads.

If anyone ever wants to track kernel thread AVX-512 use, they can come
back later and do it properly, separate from this bug fix.

[ dhansen: mostly rewrite changelog ]

Fixes: 22aafe3bcb67 ("x86/fpu: Remove init_task FPU state dependencies, add d=
ebugging warning for PF_KTHREAD tasks")
Co-developed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250811185044.2227268-1-sohil.mehta%40inte=
l.com
---
 arch/x86/kernel/fpu/xstate.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 12ed75c..28e4fd6 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1881,19 +1881,20 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
- * use in the task.
+ * use in the task. Report -1 if no AVX-512 usage.
  */
 static void avx512_status(struct seq_file *m, struct task_struct *task)
 {
-	unsigned long timestamp =3D READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
-	long delta;
+	unsigned long timestamp;
+	long delta =3D -1;
=20
-	if (!timestamp) {
-		/*
-		 * Report -1 if no AVX512 usage
-		 */
-		delta =3D -1;
-	} else {
+	/* AVX-512 usage is not tracked for kernel threads. Don't report anything. =
*/
+	if (task->flags & (PF_KTHREAD | PF_USER_WORKER))
+		return;
+
+	timestamp =3D READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
+
+	if (timestamp) {
 		delta =3D (long)(jiffies - timestamp);
 		/*
 		 * Cap to LONG_MAX if time difference > LONG_MAX

