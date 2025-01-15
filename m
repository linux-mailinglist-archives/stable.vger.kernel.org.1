Return-Path: <stable+bounces-108690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82524A11D24
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90CC188BCA1
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728CA22FDF1;
	Wed, 15 Jan 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAB2taIx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8mNKREwr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0E1EEA4A;
	Wed, 15 Jan 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932587; cv=none; b=WYvjleQm6qn7IZKULz/+fk/4Yrq5/6w6mRIIKYX3N7XHHARPs7KuL6gUgW+bUVh9ZAKPxvjWp3df3Kz3apzKalg3DTSJyDo9vlp1r72+mCbMyGIHzL3sx5Zf1LbP6AoTZbA90FgLWWstAtSbn2Ti3n3+D52y2ZzpH+JLZ+ZTQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932587; c=relaxed/simple;
	bh=/Uwzk/kbGXSoM9VPBEnp/jHucP7PqTX6N0O6HDTbELI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nkC7VaJTEmW1saukVw4rttoAw+g26mcHIxLlKxaC15N61Teyl18oiescYl1dwRPd5G/XeqSS4IrT0FU0e0sG3vSH+S/5uegqSn9CpTqOTC5CHQTUiucTg3o8eNIpzQf2myPEOMuFjrw8isgpS8QGAbEma2GnkuI+/CrO5NLqg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAB2taIx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8mNKREwr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:16:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11zWApuJBsjtsmiVooP846cr3aekqEpT2RpTqJESLOk=;
	b=nAB2taIxav3iLYZi0vpbeWfL/7B+uCyPslEJvvku3vOs+8QD1AGJIqa9V/hYDkWSeTo7Tu
	6CBX+N6SP4XFmi6hXVHywsmaODnTx+7BOFxgWeS27RtN3zleY9g3ES10YjWrzJkrq6Quis
	cJ6/VVsYhxcZYKJKIDy5+3JYV17nN7S2rKB8K9d+OunPthTljPjXcrsYYuj/mpO2G6cFmb
	/94MeNBiCONSeRaBwNj9vRmOT6R8WL+4S8c2cH38T5p1KgfpSz6fkZUAoswfWw8Z58/XYL
	rIM9puQ00elJTe8wyXXhvxwhdGqV155QnRDF5yzn3zM7ooD8/7zz2M6unE413A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11zWApuJBsjtsmiVooP846cr3aekqEpT2RpTqJESLOk=;
	b=8mNKREwr4ctLfOmLzw9pmkfzMsJPA7nnXwEjW3P5dvzYzI2/av7I+SLJxI1ZKjBfl3pOqY
	vOS/SRPXDgC44tBA==
From: "tip-bot2 for Tomas Krcka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Don't enable interrupts in
 its_irq_set_vcpu_affinity()
Cc: Tomas Krcka <krckatom@amazon.de>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241230150825.62894-1-krckatom@amazon.de>
References: <20241230150825.62894-1-krckatom@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693257835.31546.14290778827570769483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     35cb2c6ce7da545f3b5cb1e6473ad7c3a6f08310
Gitweb:        https://git.kernel.org/tip/35cb2c6ce7da545f3b5cb1e6473ad7c3a6f08310
Author:        Tomas Krcka <krckatom@amazon.de>
AuthorDate:    Mon, 30 Dec 2024 15:08:25 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 09:42:45 +01:00

irqchip/gic-v3-its: Don't enable interrupts in its_irq_set_vcpu_affinity()

The following call-chain leads to enabling interrupts in a nested interrupt
disabled section:

irq_set_vcpu_affinity()
  irq_get_desc_lock()
     raw_spin_lock_irqsave()   <--- Disable interrupts
  its_irq_set_vcpu_affinity()
     guard(raw_spinlock_irq)   <--- Enables interrupts when leaving the guard()
  irq_put_desc_unlock()        <--- Warns because interrupts are enabled

This was broken in commit b97e8a2f7130, which replaced the original
raw_spin_[un]lock() pair with guard(raw_spinlock_irq).

Fix the issue by using guard(raw_spinlock).

[ tglx: Massaged change log ]

Fixes: b97e8a2f7130 ("irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()")
Signed-off-by: Tomas Krcka <krckatom@amazon.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241230150825.62894-1-krckatom@amazon.de

---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 92244cf..8c3ec57 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2045,7 +2045,7 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
-	guard(raw_spinlock_irq)(&its_dev->event_map.vlpi_lock);
+	guard(raw_spinlock)(&its_dev->event_map.vlpi_lock);
 
 	/* Unmap request? */
 	if (!info)

