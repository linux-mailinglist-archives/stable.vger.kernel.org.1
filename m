Return-Path: <stable+bounces-86400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21699FC4B
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 01:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEEB82870AB
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 23:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACCF1F80BD;
	Tue, 15 Oct 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OgCYCei1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TlUIewWr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98761D63EA;
	Tue, 15 Oct 2024 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034262; cv=none; b=srwK77+lMcE6IgluBKa9LaI4zxHZ1ZzU2glHSbxghBels23aaz0Nt2XT07STAd6CPKXGHMhXW8NV0cjo24rVLvjHUfJOfFwR78d4XWw6l12amyJp8meGpAUmu6QEREwYGhBL5QMhwgu2IdG4nfxwl2+0XAUHq9HheNkQshibHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034262; c=relaxed/simple;
	bh=93Qu79RPdzYWuS8VluUwYI+mQdW76BAI+YjRY05mE/s=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=T/mTDLisaypXhpT+ChCKAkZCDzgvxJsFj5Zsb6VnroFOo67iT7AZs6BSA1y9nR+AJD8x7DjhZObKa8USnWnWab1sybcUB1fT6Xcwm1q6pdOOJQJm6W3cWSrz0hw1N3csVBx6+5tQ17AYXsFgGFCnoW2p+ntHO0/yj/3jAk33ZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OgCYCei1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TlUIewWr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 23:17:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729034258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=eNy1vrS5muq8I9suz0muKX9xgO9wzg64nRRAc9865gY=;
	b=OgCYCei1jCfw1xTKQT40QiX48LtJuBRjfFCCnVaugSrl3+t3Uabv/Vj9zqIoQF3cx2Gm6U
	sMmK5G9HCqtXQyenUAc0yZoXSFp2Sah6pUm3RdyoKAIxa1b5Sa8xnaRY9znih57h4kwiV4
	CNZkuzEmPMQ9wucwkFGn+7Kne08M7b944oV14NVl7GjGgbOYH1mQMhgCvyWyJ2j/7e/mdM
	0uPTxD3FyXoXMlaeXLsTZKxUELBnx5+8Fm8rxXm89orud28lMAL/Catg58cA8eB6LzJlm8
	L7aL2cm+fCmJRXvQhPGOb3QFcg+wXa2UKzih6wiVxSzE5lqzQdl5NY5qJ7t//g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729034258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=eNy1vrS5muq8I9suz0muKX9xgO9wzg64nRRAc9865gY=;
	b=TlUIewWr1B1CW7imp63X8bIGentD8gndlb1ywct3KyoQLZ2tIKLWChyDjXZ8FLfQwDy+bS
	lSoDk/cdSM0ohwBQ==
From: "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/apic: Always explicitly disarm TSC-deadline timer
Cc: Dave Hansen <dave.hansen@intel.com>, Zhang Rui <rui.zhang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Todd Brandt <todd.e.brandt@intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903425753.1442.3391146920591310820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ffd95846c6ec6cf1f93da411ea10d504036cab42
Gitweb:        https://git.kernel.org/tip/ffd95846c6ec6cf1f93da411ea10d504036cab42
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Tue, 15 Oct 2024 14:15:22 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 15 Oct 2024 05:45:18 -07:00

x86/apic: Always explicitly disarm TSC-deadline timer

New processors have become pickier about the local APIC timer state
before entering low power modes. These low power modes are used (for
example) when you close your laptop lid and suspend. If you put your
laptop in a bag and it is not in this low power mode, it is likely
to get quite toasty while it quickly sucks the battery dry.

The problem boils down to some CPUs' inability to power down until the
CPU recognizes that the local APIC timer is shut down. The current
kernel code works in one-shot and periodic modes but does not work for
deadline mode. Deadline mode has been the supported and preferred mode
on Intel CPUs for over a decade and uses an MSR to drive the timer
instead of an APIC register.

Disable the TSC Deadline timer in lapic_timer_shutdown() by writing to
MSR_IA32_TSC_DEADLINE when in TSC-deadline mode. Also avoid writing
to the initial-count register (APIC_TMICT) which is ignored in
TSC-deadline mode.

Note: The APIC_LVTT|=APIC_LVT_MASKED operation should theoretically be
enough to tell the hardware that the timer will not fire in any of the
timer modes. But mitigating AMD erratum 411[1] also requires clearing
out APIC_TMICT. Solely setting APIC_LVT_MASKED is also ineffective in
practice on Intel Lunar Lake systems, which is the motivation for this
change.

1. 411 Processor May Exit Message-Triggered C1E State Without an Interrupt if Local APIC Timer Reaches Zero - https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/revision-guides/41322_10h_Rev_Gd.pdf

Fixes: 279f1461432c ("x86: apic: Use tsc deadline for oneshot when available")
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Todd Brandt <todd.e.brandt@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241015061522.25288-1-rui.zhang%40intel.com
---
 arch/x86/kernel/apic/apic.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6513c53..c5fb28e 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -440,7 +440,19 @@ static int lapic_timer_shutdown(struct clock_event_device *evt)
 	v = apic_read(APIC_LVTT);
 	v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
 	apic_write(APIC_LVTT, v);
-	apic_write(APIC_TMICT, 0);
+
+	/*
+	 * Setting APIC_LVT_MASKED (above) should be enough to tell
+	 * the hardware that this timer will never fire. But AMD
+	 * erratum 411 and some Intel CPU behavior circa 2024 say
+	 * otherwise.  Time for belt and suspenders programming: mask
+	 * the timer _and_ zero the counter registers:
+	 */
+	if (v & APIC_LVT_TIMER_TSCDEADLINE)
+		wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
+	else
+		apic_write(APIC_TMICT, 0);
+
 	return 0;
 }
 

