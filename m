Return-Path: <stable+bounces-108693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009AEA11D52
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527CB160E17
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA191EEA45;
	Wed, 15 Jan 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iLaCtAc9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MwMfS11J"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB31EEA37;
	Wed, 15 Jan 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932670; cv=none; b=Ixlkn0OHQKyN3hrfqROP6iRr6kAXEB+HjTGaui+7nzUJgzShZkRH4hNeCx6o+aq62Hzwt1i629Lf24MmqfWgOvvJop+2yvDHtaTxZ5CDi86z0KeqWgJQoAQGJgm4o5xGnqXC90Y6YunGp5Ks104r8oWnPCM/w2ym7OwwhUTGEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932670; c=relaxed/simple;
	bh=b8ep7yzXNQ2WWN57kJpvalioLlKF1PoQtKnj+tbuBBc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=nTKPE0yPglaUO21UbQqVuXwXXpP62+BxbjthtpdKoZUY/+WNVuf635uIM6YCP0QfGeOsMQe7hFcJFa3EmWD1Ladfq62FkpSe/1TeMhfWHPFlUNo2b54kBv33k/ndyPRx7YpYVNU4MkyUZzeg+FRJkMsx4mDpdnYD3XWD/Ojgfms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iLaCtAc9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MwMfS11J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=t6xJfgv7LGixGdzefMck9d8TezAcjPhpCPoF+6s9Kp4=;
	b=iLaCtAc9MMWtblYY6FD4u6YSNy+ZYwIE5hWzc30m1Exg/JccKrkv7inTqvhLqBszIQxeXp
	CBd8bIQh0AeWz6npo3noUDnB5SOI43LjgnufbFQiLK98YBh0Ba65IW1oBIpa/+UD/6CIWF
	UVqvRfxJt2VKZU2EUiePzMgeyJJ5FV+w3z+ycYwg0/GPvA7ixknEnPdQGa7SRibTUOSRfK
	PuAD7p02tSfa0llW5BCq89VXWOsjP4xQQSd19UZHFk+sVBWNurW6AiIm5hj5dtU4i2TBou
	jMPhTPM9infI7ip3ao1UD8ywRtc8e+G1hn5lLYZJzuxKk2eKJ4OQXD6gCR+yyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=t6xJfgv7LGixGdzefMck9d8TezAcjPhpCPoF+6s9Kp4=;
	b=MwMfS11J0xw7TYuhXY+NupAeg5IfbFFuzkKTiAbZOMfBpQXcK/KdUoxoinPMbJWa35fo0r
	yQT5AzkEnWOlLODw==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fred: Fix the FRED RSP0 MSR out of sync with
 its per-CPU cache
Cc: "Xin Li (Intel)" <xin@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693266685.31546.12884479664258205675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     de31b3cd706347044e1a57d68c3a683d58e8cca4
Gitweb:        https://git.kernel.org/tip/de31b3cd706347044e1a57d68c3a683d58e8cca4
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Fri, 10 Jan 2025 09:46:39 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 14 Jan 2025 14:16:36 -08:00

x86/fred: Fix the FRED RSP0 MSR out of sync with its per-CPU cache

The FRED RSP0 MSR is only used for delivering events when running
userspace.  Linux leverages this property to reduce expensive MSR
writes and optimize context switches.  The kernel only writes the
MSR when about to run userspace *and* when the MSR has actually
changed since the last time userspace ran.

This optimization is implemented by maintaining a per-CPU cache of
FRED RSP0 and then checking that against the value for the top of
current task stack before running userspace.

However cpu_init_fred_exceptions() writes the MSR without updating
the per-CPU cache.  This means that the kernel might return to
userspace with MSR_IA32_FRED_RSP0==0 when it needed to point to the
top of current task stack.  This would induce a double fault (#DF),
which is bad.

A context switch after cpu_init_fred_exceptions() can paper over
the issue since it updates the cached value.  That evidently
happens most of the time explaining how this bug got through.

Fix the bug through resynchronizing the FRED RSP0 MSR with its
per-CPU cache in cpu_init_fred_exceptions().

Fixes: fe85ee391966 ("x86/entry: Set FRED RSP0 on return to userspace instead of context switch")
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250110174639.1250829-1-xin%40zytor.com
---
 arch/x86/kernel/fred.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 8d32c3f..5e2cd10 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -50,7 +50,13 @@ void cpu_init_fred_exceptions(void)
 	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
 
 	wrmsrl(MSR_IA32_FRED_STKLVLS, 0);
-	wrmsrl(MSR_IA32_FRED_RSP0, 0);
+
+	/*
+	 * Ater a CPU offline/online cycle, the FRED RSP0 MSR should be
+	 * resynchronized with its per-CPU cache.
+	 */
+	wrmsrl(MSR_IA32_FRED_RSP0, __this_cpu_read(fred_rsp0));
+
 	wrmsrl(MSR_IA32_FRED_RSP1, 0);
 	wrmsrl(MSR_IA32_FRED_RSP2, 0);
 	wrmsrl(MSR_IA32_FRED_RSP3, 0);

