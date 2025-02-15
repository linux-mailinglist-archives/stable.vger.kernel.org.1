Return-Path: <stable+bounces-116507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55577A370BA
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 22:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA513ACD0C
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 21:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E3D1E5B7C;
	Sat, 15 Feb 2025 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="j6ZlM+nk"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDFD193086;
	Sat, 15 Feb 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739653424; cv=none; b=A3JTex5HNjNK3Idwk5ia2qoRqI3QpcpJEVtRpljNIim3JFhvJT/JlbR54sXB16FKnbItbAYoYfQwjKTrlumAcjzwgnth9P/tSuTqvfj9JP0MhzQ14+RE1PAIFgx/fjRYK0+xk5xSVDOdPo7JZASb9hlNByIVYZlR7QtxebHIw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739653424; c=relaxed/simple;
	bh=IXB/OA0/HJEcsIwYx8E7/hlc3FONZBJ+SuINx/OY1Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQn8XoJPLR0abZKgjpPq2VHH695c3gNuRU8S5yRJXgbdUJ0AHPtOYUJlXDlaDsvfANG6wOSb7/rQAFKOaVTOglCh3FDzqVQuybMOVQA16GpedewMP0jFe4i/cpTN4+5I2FkzZUKLK/rDXdDNOWW7viF3aaNR/fMItnMwWi6m6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=j6ZlM+nk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8SGIblqnPcnG43bpX86thHVrqLMXC+Z5CiJGbNB0aOA=; b=j6ZlM+nk37YpPhhR4WQbqyeu1E
	ucV/nYoy0Yqn2O1PbFrjKpTr4/ndEZ16FcChl9f4/eKsmZDEE1BCeG1xcdPvWiA4DHX0fQfJOvCDj
	Ni+EtzOPi/g3caHa2rMpUU0XCwTmutcg8JXLOpwsQ+hso4xE6Qc2i8Mxk91PBOiGNAmyQJJdb9SXk
	dsh5JJCS/Yhaqqaound2KpDxpmQ+0ZGAwd+tPirBa8AnM25NCHOS7I6tEGlN3zVDczHaPwZG+Zn7b
	N3eKP8dlB8nFCrdwNAemai60DV3pYc9Tbfgwrc7j9UMhgPdiZigEAbtE7q3V/6A01CrMpm54A6aGO
	pIjyfq9w==;
Received: from [187.90.171.141] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tjPJt-004POc-M5; Sat, 15 Feb 2025 22:03:32 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	rostedt@goodmis.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH] x86/tsc: Always save/restore TSC sched_clock on suspend/resume
Date: Sat, 15 Feb 2025 17:58:16 -0300
Message-ID: <20250215210314.351480-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TSC could be reset in deep ACPI sleep states, even with invariant TSC.
That's the reason we have sched_clock() save/restore functions, to deal
with this situation. But happens that such functions are guarded with a
check for the stability of sched_clock - if not considered stable, the
save/restore routines aren't executed.

On top of that, we have a clear comment on native_sched_clock() saying
that *even* with TSC unstable, we continue using TSC for sched_clock due
to its speed. In other words, if we have a situation of TSC getting
detected as unstable, it marks the sched_clock as unstable as well,
so subsequent S3 sleep cycles could bring bogus sched_clock values due
to the lack of the save/restore mechanism, causing warnings like this:

[22.954918] ------------[ cut here ]------------
[22.954923] Delta way too big! 18446743750843854390 ts=18446744072977390405 before=322133536015 after=322133536015 write stamp=18446744072977390405
[22.954923] If you just came from a suspend/resume,
[22.954923] please switch to the trace global clock:
[22.954923]   echo global > /sys/kernel/tracing/trace_clock
[22.954923] or add trace_clock=global to the kernel command line
[22.954937] WARNING: CPU: 2 PID: 5728 at kernel/trace/ring_buffer.c:2890 rb_add_timestamp+0x193/0x1c0

Notice that the above was reproduced even with "trace_clock=global".

The fix for that is to _always_ save/restore the sched_clock on suspend
cycle _if TSC is used_ as sched_clock - only if we fallback to jiffies
the sched_clock_stable() check becomes relevant to save/restore the
sched_clock.

Cc: stable@vger.kernel.org
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/x86/kernel/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 34dec0b72ea8..88e5a4ed9db3 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -959,7 +959,7 @@ static unsigned long long cyc2ns_suspend;
 
 void tsc_save_sched_clock_state(void)
 {
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -979,7 +979,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	local_irq_save(flags);
-- 
2.47.1


