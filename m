Return-Path: <stable+bounces-45993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DEF8CDB2C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 22:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A94281D50
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC61983CC9;
	Thu, 23 May 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FoAqVp2+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3yMA4g8"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66AA1401F;
	Thu, 23 May 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494444; cv=none; b=X0LLCTtf88THuFq6S3QAoiagcX8jvV8sj4lpJBqn6zxsLCEu62GOO2Kqz2130EENfIImAwKvtUbuakVLblrZaH2xTcbOOqPiu5oEMnPsA0OjlNhrXgqfh8X650nMmRAjhN1MoQOUEO/mpAzk6K/GRpSKUUwVbWeVsHcDbTvLJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494444; c=relaxed/simple;
	bh=+Z1PrWAQ1YLk2vhE3D7FPwh2PjswTOFCF+DMoa6zbP0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cc9wzjh4Tn2Ompn+Wsbq9JBJfCrVBqZ1Dkzm885XcQ4WmdxrPGz9YBjllDESy+36Fv1XF+GGPZETBurdH4O/Igba5pv7ayW2tSa3mmYNu16W2K1G7Sr6adSo2Y165Oys/IjmOPHTdvuVs9fqh8q8UJrPOb0w9oeBZw5wFtPNbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FoAqVp2+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3yMA4g8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 May 2024 20:00:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716494440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbLnR8ME4559FQGhr71GY5tCTnnXpVQVuydqewO8W6I=;
	b=FoAqVp2+PrRle09PACAGn0Z2kdU6Pga2oGmsjbVliIssgU04j55OF2dTetZJ2VZmM6CwXv
	qgNYF/gwP6gxrM1m0OAdW0J8NCgZqMMuUToAFExUD0v4Ob4PD3nuz6ZFio0IeeFkeCrUMt
	ezexQEuE7CACXmbcZYPHZ85yRKI1P9+jOdc2UaNW9UneRMYRhkdQ5Rs16qml4/iruPnJmK
	j7x5lkxnMIE9e1dEM7UiKXrZyKRevn88hJ84LM7QBc97Agw21Bl+iS3qbw0zfVy97C99Fm
	PzED6FJkIkwtODrzBMeKnel2MkOjpxdg6dGmBpWeRlu0nHDHmva8/wlKwNAfMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716494440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbLnR8ME4559FQGhr71GY5tCTnnXpVQVuydqewO8W6I=;
	b=L3yMA4g8DFL66jYcufwZenWDHJmUOcIZtuY+O/F2Rht30ihMCQcNPHZyGc181sV5L/D0DX
	hIFsgAKEcys0WxCw==
From: "tip-bot2 for Dongli Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/cpuhotplug, x86/vector: Prevent vector leak
 during CPU offline
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240522220218.162423-1-dongli.zhang@oracle.com>
References: <20240522220218.162423-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171649444020.10875.8762231749396322984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a6c11c0a5235fb144a65e0cb2ffd360ddc1f6c32
Gitweb:        https://git.kernel.org/tip/a6c11c0a5235fb144a65e0cb2ffd360ddc1f6c32
Author:        Dongli Zhang <dongli.zhang@oracle.com>
AuthorDate:    Wed, 22 May 2024 15:02:18 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 May 2024 21:51:50 +02:00

genirq/cpuhotplug, x86/vector: Prevent vector leak during CPU offline

The absence of IRQD_MOVE_PCNTXT prevents immediate effectiveness of
interrupt affinity reconfiguration via procfs. Instead, the change is
deferred until the next instance of the interrupt being triggered on the
original CPU.

When the interrupt next triggers on the original CPU, the new affinity is
enforced within __irq_move_irq(). A vector is allocated from the new CPU,
but the old vector on the original CPU remains and is not immediately
reclaimed. Instead, apicd->move_in_progress is flagged, and the reclaiming
process is delayed until the next trigger of the interrupt on the new CPU.

Upon the subsequent triggering of the interrupt on the new CPU,
irq_complete_move() adds a task to the old CPU's vector_cleanup list if it
remains online. Subsequently, the timer on the old CPU iterates over its
vector_cleanup list, reclaiming old vectors.

However, a rare scenario arises if the old CPU is outgoing before the
interrupt triggers again on the new CPU.

In that case irq_force_complete_move() is not invoked on the outgoing CPU
to reclaim the old apicd->prev_vector because the interrupt isn't currently
affine to the outgoing CPU, and irq_needs_fixup() returns false. Even
though __vector_schedule_cleanup() is later called on the new CPU, it
doesn't reclaim apicd->prev_vector; instead, it simply resets both
apicd->move_in_progress and apicd->prev_vector to 0.

As a result, the vector remains unreclaimed in vector_matrix, leading to a
CPU vector leak.

To address this issue, move the invocation of irq_force_complete_move()
before the irq_needs_fixup() call to reclaim apicd->prev_vector, if the
interrupt is currently or used to be affine to the outgoing CPU.

Additionally, reclaim the vector in __vector_schedule_cleanup() as well,
following a warning message, although theoretically it should never see
apicd->move_in_progress with apicd->prev_cpu pointing to an offline CPU.

Fixes: f0383c24b485 ("genirq/cpuhotplug: Add support for cleaning up move in progress")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240522220218.162423-1-dongli.zhang@oracle.com
---
 arch/x86/kernel/apic/vector.c |  9 ++++++---
 kernel/irq/cpuhotplug.c       | 16 ++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 9eec529..5573181 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1035,7 +1035,8 @@ static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
 			add_timer_on(&cl->timer, cpu);
 		}
 	} else {
-		apicd->prev_vector = 0;
+		pr_warn("IRQ %u schedule cleanup for offline CPU %u\n", apicd->irq, cpu);
+		free_moved_vector(apicd);
 	}
 	raw_spin_unlock(&vector_lock);
 }
@@ -1072,6 +1073,7 @@ void irq_complete_move(struct irq_cfg *cfg)
  */
 void irq_force_complete_move(struct irq_desc *desc)
 {
+	unsigned int cpu = smp_processor_id();
 	struct apic_chip_data *apicd;
 	struct irq_data *irqd;
 	unsigned int vector;
@@ -1096,10 +1098,11 @@ void irq_force_complete_move(struct irq_desc *desc)
 		goto unlock;
 
 	/*
-	 * If prev_vector is empty, no action required.
+	 * If prev_vector is empty or the descriptor is neither currently
+	 * nor previously on the outgoing CPU no action required.
 	 */
 	vector = apicd->prev_vector;
-	if (!vector)
+	if (!vector || (apicd->cpu != cpu && apicd->prev_cpu != cpu))
 		goto unlock;
 
 	/*
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 75cadbc..eb86283 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -70,6 +70,14 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	}
 
 	/*
+	 * Complete an eventually pending irq move cleanup. If this
+	 * interrupt was moved in hard irq context, then the vectors need
+	 * to be cleaned up. It can't wait until this interrupt actually
+	 * happens and this CPU was involved.
+	 */
+	irq_force_complete_move(desc);
+
+	/*
 	 * No move required, if:
 	 * - Interrupt is per cpu
 	 * - Interrupt is not started
@@ -88,14 +96,6 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	}
 
 	/*
-	 * Complete an eventually pending irq move cleanup. If this
-	 * interrupt was moved in hard irq context, then the vectors need
-	 * to be cleaned up. It can't wait until this interrupt actually
-	 * happens and this CPU was involved.
-	 */
-	irq_force_complete_move(desc);
-
-	/*
 	 * If there is a setaffinity pending, then try to reuse the pending
 	 * mask, so the last change of the affinity does not get lost. If
 	 * there is no move pending or the pending mask does not contain

