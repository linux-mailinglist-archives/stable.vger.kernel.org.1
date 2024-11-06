Return-Path: <stable+bounces-91733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00D59BFA34
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 00:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D5A1C21CC9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 23:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610620F5AD;
	Wed,  6 Nov 2024 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gwkM79MK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5/6VAXcf"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EA20EA31;
	Wed,  6 Nov 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935960; cv=none; b=amcrqzXFZ298eRFplSM6YPOlcqLz1sODdx8RkrmBgL87ChAMl2mkxV8zFnrit4TW6CV+xGcIACxaHY5HMMlaM2hkhLePGzRfye9A95/BzF1b/C7o0ZPYhVepfWZoQA7rA6N2HZueDXQwv8yvaJB3E3Ty/paNvywjS7HmWcFiabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935960; c=relaxed/simple;
	bh=+0hMoP1d8drFu4O0+wfQAWCu49MAdfS5kBK+nDBnbsc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GpgTRjwpRXJECxQYzPFZUs2VYHhSQKroswG2F7tuSfa9fLlNhm35/Q5OgtgBkxO8hgFfycVHeeOFRe/rm/4+YMH5Q4+0HAJInzp1h3fg/h6DGlaCn3PMXk2fXMrn/nMZ1IIFwwFP4478Hao4zdITmUMBDEF9ewfycrMsKUkGBvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gwkM79MK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5/6VAXcf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 23:32:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730935956;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj3SAikcWcuQ63vnkIoJT043v/MwegATbAZ7Yz6/vOQ=;
	b=gwkM79MKdDZldeJnNidxzgyS6fuEjzjyQAy1c4QxGEw4Z6TIkc18m6tMLwbIhr2Cb6CpaZ
	mCg93ZR1ZXFm2qeKtpKZ2eCVoEosDIiCgxZhghVLrnp6Al9fLoeFi9Lqq1TPHac1Al6RQb
	fYVnX+fJN96shg7SDY01ooQOtcMsyCKrlsHQ376NeCAxQ9GRY0J7U7NX2Zw21EXUkUmOdL
	QDMaMExpvuSS1Y661g/8ntZDbXSdCJn/aG1CEmeHPgOnrwT79sKkOnyXXw16cQz3X3iakv
	SRdKgMOArVhzu5FSpygZnmnbACgDPigxVtqW6wFhnhUGlbhb4lDqarHIqESlaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730935956;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj3SAikcWcuQ63vnkIoJT043v/MwegATbAZ7Yz6/vOQ=;
	b=5/6VAXcfrEAfXtlI79nVWvnF7i9Opo7V9wTxayfc6vtdctPLH4BX12nNW1nLtSSWqLzU71
	wOMRj7IIrQbKF4DQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3: Force propagation of the active
 state with a read-back
Cc: Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241106084418.3794612-1-maz@kernel.org>
References: <20241106084418.3794612-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173093595604.32228.1931318188286510625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     464cb98f1c07298c4c10e714ae0c36338d18d316
Gitweb:        https://git.kernel.org/tip/464cb98f1c07298c4c10e714ae0c36338d18d316
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 06 Nov 2024 08:44:18 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 00:22:44 +01:00

irqchip/gic-v3: Force propagation of the active state with a read-back

Christoffer reports that on some implementations, writing to
GICR_ISACTIVER0 (and similar GICD registers) can race badly with a guest
issuing a deactivation of that interrupt via the system register interface.

There are multiple reasons to this:

 - this uses an early write-acknoledgement memory type (nGnRE), meaning
   that the write may only have made it as far as some interconnect
   by the time the store is considered "done"

 - the GIC itself is allowed to buffer the write until it decides to
   take it into account (as long as it is in finite time)

The effects are that the activation may not have taken effect by the time
the kernel enters the guest, forcing an immediate exit, or that a guest
deactivation occurs before the interrupt is active, doing nothing.

In order to guarantee that the write to the ISACTIVER register has taken
effect, read back from it, forcing the interconnect to propagate the write,
and the GIC to process the write before returning the read.

Reported-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241106084418.3794612-1-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ce87205..8b6159f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -524,6 +524,13 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 	}
 
 	gic_poke_irq(d, reg);
+
+	/*
+	 * Force read-back to guarantee that the active state has taken
+	 * effect, and won't race with a guest-driven deactivation.
+	 */
+	if (reg == GICD_ISACTIVER)
+		gic_peek_irq(d, reg);
 	return 0;
 }
 

