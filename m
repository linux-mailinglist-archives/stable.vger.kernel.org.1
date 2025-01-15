Return-Path: <stable+bounces-108691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A2A11D29
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179BB188C180
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC3823F26D;
	Wed, 15 Jan 2025 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIJFdT+o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDrBP+3H"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738C1FCCE0;
	Wed, 15 Jan 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932588; cv=none; b=PPRocsS9fZHIwuYSK5tY8bqr6I92lIOi7sy1S8CYAyAjzcLi+7H8EEAw2nFu3jQfBGdJCvXpfOIOXqi/aJfqjuOYiGo1jx1/blLlbJKPfBxCTBOxy8DrwduAHpfxIJveDNOuSk2bXqMIBpfMJVtZRLe6DXdC8h+EH4jKUDYVOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932588; c=relaxed/simple;
	bh=cpb8Q+9FDuRfaYpNldYAJE2FTtQXtzZWYDH3a0t3EuE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U2edaLlok5AnSG8pkp1IS8qajizZztvUfNCfRFfrduyVtCy25Hfx5ftM5Brvo7KG7ykPOSI3iiWFQDAWEW6ch1TwG0VMIsIiscL8UPHmqot2oxRxgVZAVN+8uP5pvQuf593MTsM1pZvfYSou3k5CsOBRDAQL1AWdXdSDXdnu8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIJFdT+o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDrBP+3H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:16:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5EG27BLphm/zoXKNMqCC00itB9qxkRKFZ4Q/COgmqg=;
	b=TIJFdT+oEXyg5ILhRBThYaWxnB5ZJ9uEkZHgoudfFGg/O8vAF60Fq2nIOXpblj8B/MZyxr
	ObnemLpz2B82zLtrOdD/DLGJeUAPMi3RW0ITWrPDnkGvLC0Muq1CXP5hMGfbLEULBuNlo7
	CwLIX8Yt5U0i/+kkLjkbkXSTJCA8KTPbcyUmMbWFgInhHsMQm1fLPfWbERkAW7chH2mdz8
	1LOsN4MIilbPHbUDNJTMLzX2RCtvr3b1p7kqBG9BpyRo+Mw+Ag18ObR5P92+tnfGqleOMj
	6lpfC2MV+rvWgudRxCpXNNK3EvHiS7iHtapVSlEHbB69qDwHuZ4onNRIgn8tzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5EG27BLphm/zoXKNMqCC00itB9qxkRKFZ4Q/COgmqg=;
	b=iDrBP+3HOImvgltoQjcGHWBCPBZIynNCPxOyNmSZLsWcKIryEOwoEP5Tay/fte8L2RZKkr
	02cB99hH+drVfyDA==
From: "tip-bot2 for Yogesh Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly
Cc: Yogesh Lal <quic_ylal@quicinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241220093907.2747601-1-quic_ylal@quicinc.com>
References: <20241220093907.2747601-1-quic_ylal@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693257878.31546.14975360395151700075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     0d62a49ab55c99e8deb4593b8d9f923de1ab5c18
Gitweb:        https://git.kernel.org/tip/0d62a49ab55c99e8deb4593b8d9f923de1ab5c18
Author:        Yogesh Lal <quic_ylal@quicinc.com>
AuthorDate:    Fri, 20 Dec 2024 15:09:07 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 09:42:44 +01:00

irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly

When a CPU attempts to enter low power mode, it disables the redistributor
and Group 1 interrupts and reinitializes the system registers upon wakeup.

If the transition into low power mode fails, then the CPU_PM framework
invokes the PM notifier callback with CPU_PM_ENTER_FAILED to allow the
drivers to undo the state changes.

The GIC V3 driver ignores CPU_PM_ENTER_FAILED, which leaves the GIC in
disabled state.

Handle CPU_PM_ENTER_FAILED in the same way as CPU_PM_EXIT to restore normal
operation.

[ tglx: Massage change log, add Fixes tag ]

Fixes: 3708d52fc6bb ("irqchip: gic-v3: Implement CPU PM notifier")
Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241220093907.2747601-1-quic_ylal@quicinc.com
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 79d8cc8..76dce0a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1522,7 +1522,7 @@ static int gic_retrigger(struct irq_data *data)
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
-	if (cmd == CPU_PM_EXIT) {
+	if (cmd == CPU_PM_EXIT || cmd == CPU_PM_ENTER_FAILED) {
 		if (gic_dist_security_disabled())
 			gic_enable_redist(true);
 		gic_cpu_sys_reg_enable();

