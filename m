Return-Path: <stable+bounces-158820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E02AEC6B5
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 13:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308B8189E9C8
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4155C24A041;
	Sat, 28 Jun 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jVMIzboJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RHFvY1R+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D524886E;
	Sat, 28 Jun 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751110419; cv=none; b=kbotLbdOCpTCj/HxIXrIZOvcC23hN2K4GVeVhkhV6UP4q/CzHu09XaLqISDJdcNEvsnN6FLevCLfjQscH9afVzjayttX9WJSvYfkmcsnooDSJjUuUyWNPMfanygMGkWvzA9YzazTmSGAbQjmbY/u3ny3GksF7AnIlvNTqOMU5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751110419; c=relaxed/simple;
	bh=n8f1meyC1x2IA7HRbtjNHFhlgg/poQrB3y+HLZS3qq8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HqCKZ2Qrk+n2na8j5wHtji0HoU5uRV/6PY4FSyB5qgVpKXqLK+Z932vhm/z/+Rg/5ojD2ce2d/uMUIuZBbsRPjnMzQAIYMnjtPqWWYKE53mRrSkiEPGeSp6kU9OBKPOXPcbz7nsPDZ1jKzmjRqOODJXvLEb+mmRi3+XClsxohBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jVMIzboJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RHFvY1R+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Jun 2025 11:33:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751110407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7M/Sszoop9a+orpc/GfW/zHJ0j6f9de5MqPRmC8f6i8=;
	b=jVMIzboJkty5LnrPAzWtPzBEq2OHqiAiBt4zB30MlLtGi80qjyrmMGW7AxJi5mAI85lxjy
	8T+d2rDpZQ1b0ucCC/qDSjeGHuyXckHFqsXCh8/yolLy3HQCF9IrEBtYLyXMs4fnxTUBae
	fMVOOtcrrxWZ1//+UpBVrGkuWuAEUJxwOtzQa+ONTUW0IYTnDpDpZtiLo8clKICGTkipcX
	2ZrH97D5FTo6lmhIGNf26CImZUJg/rh6Oqxm1iE+OMgk8FMb7P2m/qzhM1171GgQiDl/Qt
	9ypZ77Wr1RoI5oaODA2EOEQodobDqK86IhwRWQEt5qBNkwr9SecXFM99MaEjoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751110407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7M/Sszoop9a+orpc/GfW/zHJ0j6f9de5MqPRmC8f6i8=;
	b=RHFvY1R+5BI4PDtVHrYKjBtTWIOQS8b9VNCNpjXfpT0gJDrPDe5fhqavMuH3gvToGKxFJS
	izJ3e0N8P8RZE/BA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/urgent] x86/mce: Ensure user polling settings are honored
 when restarting timer
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250624-wip-mca-updates-v4-2-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-2-236dd74f645f@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175111040683.406.12960335626922770660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/urgent branch of tip:

Commit-ID:     00c092de6f28ebd32208aef83b02d61af2229b60
Gitweb:        https://git.kernel.org/tip/00c092de6f28ebd32208aef83b02d61af2229b60
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 24 Jun 2025 14:15:57 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 27 Jun 2025 12:41:44 +02:00

x86/mce: Ensure user polling settings are honored when restarting timer

Users can disable MCA polling by setting the "ignore_ce" parameter or by
setting "check_interval=0". This tells the kernel to *not* start the MCE
timer on a CPU.

If the user did not disable CMCI, then storms can occur. When these
happen, the MCE timer will be started with a fixed interval. After the
storm subsides, the timer's next interval is set to check_interval.

This disregards the user's input through "ignore_ce" and
"check_interval". Furthermore, if "check_interval=0", then the new timer
will run faster than expected.

Create a new helper to check these conditions and use it when a CMCI
storm ends.

  [ bp: Massage. ]

Fixes: 7eae17c4add5 ("x86/mce: Add per-bank CMCI storm mitigation")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250624-wip-mca-updates-v4-2-236dd74f645f@amd.com
---
 arch/x86/kernel/cpu/mce/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 07d6193..4da4eab 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1740,6 +1740,11 @@ static void mc_poll_banks_default(void)
 
 void (*mc_poll_banks)(void) = mc_poll_banks_default;
 
+static bool should_enable_timer(unsigned long iv)
+{
+	return !mca_cfg.ignore_ce && iv;
+}
+
 static void mce_timer_fn(struct timer_list *t)
 {
 	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
@@ -1763,7 +1768,7 @@ static void mce_timer_fn(struct timer_list *t)
 
 	if (mce_get_storm_mode()) {
 		__start_timer(t, HZ);
-	} else {
+	} else if (should_enable_timer(iv)) {
 		__this_cpu_write(mce_next_interval, iv);
 		__start_timer(t, iv);
 	}
@@ -2156,11 +2161,10 @@ static void mce_start_timer(struct timer_list *t)
 {
 	unsigned long iv = check_interval * HZ;
 
-	if (mca_cfg.ignore_ce || !iv)
-		return;
-
-	this_cpu_write(mce_next_interval, iv);
-	__start_timer(t, iv);
+	if (should_enable_timer(iv)) {
+		this_cpu_write(mce_next_interval, iv);
+		__start_timer(t, iv);
+	}
 }
 
 static void __mcheck_cpu_setup_timer(void)

