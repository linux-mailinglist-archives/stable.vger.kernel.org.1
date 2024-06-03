Return-Path: <stable+bounces-47880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180BA8D8745
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA691C20E8F
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 16:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5123513665A;
	Mon,  3 Jun 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rAOAZHJF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HXYf4y0p"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6A13213B;
	Mon,  3 Jun 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432013; cv=none; b=nC3b+mEGjIdSiUbK/SXhyV8oR97HgLbCX8hIvB1UZI8vILfFHvBvils6/ETHITmXRHWTQEK7RkdcT4ItDNyXRJmOw+05AIrwwyebqXl1vbvxjKlE2f4a+vG4YR3Ds2bAWqhhYIZxrOBhuVC2VXnQdNzUCM95tqePJh2f0y0P/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432013; c=relaxed/simple;
	bh=834LTm9qL+T6Ib99HUwKfxZFT/9WNNx2dUFFcuI17jY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SX9Io8J1EOyGu/ywM2ZOHp/eif2sXgscrwaBBywXLIE2/SNF160WVHd1cJdWoZUvtiFC4LeeCGrPksJ7mKZRRXETbQjxV1s64PB+ldW4BSJvNGoBbPQNy1sdfYsRE8CRyqD72Lrv1EiSCmZE8jybBTVl5jnLAmTwbylRHeY4ikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rAOAZHJF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HXYf4y0p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 16:26:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717432009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWL8vUukaZCxzvPlUNuVqTu5L4wQE8fJVp+dX7uMbyk=;
	b=rAOAZHJFvTuVj+gl154Ru5UsndhGBOeV2ZUWr3TG/MvqIj8ZO1g/VFQWyk9poZqIzrLt6j
	ohqoa5gFz+UINR21PG2BtPTpfqTPVRRzNn8eN5spgwhOi27uwOOkzRjkZqcUq045u8yT69
	eApAZZFtzrEo6Sl3AR5eOwYJ9OUAHyvl0ZQX5V1VQ2AolR98KbpETUuZv4/f4SY6a5NA/Y
	NQdvWG/RuzAiqL+bB1CChphp4w66WYadt7Vc/O5rnnKC7fXtAXFTgsQFHZV/NRLvcumFl0
	YAJPtpAtS5+z331A8bJyWV9aTeR+ugbBl4wDbEL1ICNOtfd1vDOohRWSX3jzgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717432009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWL8vUukaZCxzvPlUNuVqTu5L4wQE8fJVp+dX7uMbyk=;
	b=HXYf4y0pbXwbDjTFcik6y7dSfjQ1Zb7CzJ/vWYLRdDQP7RespdFhDVaNgXkO9Z2U9xEUJ3
	CkugWZMMLTMkq7Cg==
From: "tip-bot2 for Hagar Hemdan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Fix potential race condition in
 its_vlpi_prop_update()
Cc: Marc Zyngier <maz@kernel.org>, Hagar Hemdan <hagarhem@amazon.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240531162144.28650-1-hagarhem@amazon.com>
References: <20240531162144.28650-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171743200922.10875.2490040658088179596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     b97e8a2f7130a4b30d1502003095833d16c028b3
Gitweb:        https://git.kernel.org/tip/b97e8a2f7130a4b30d1502003095833d16c028b3
Author:        Hagar Hemdan <hagarhem@amazon.com>
AuthorDate:    Fri, 31 May 2024 16:21:44 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 18:20:00 +02:00

irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()

its_vlpi_prop_update() calls lpi_write_config() which obtains the
mapping information for a VLPI without lock held. So it could race
with its_vlpi_unmap().

Since all calls from its_irq_set_vcpu_affinity() require the same
lock to be held, hoist the locking there instead of sprinkling the
locking all over the place.

This bug was discovered using Coverity Static Analysis Security Testing
(SAST) by Synopsys, Inc.

[ tglx: Use guard() instead of goto ]

Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240531162144.28650-1-hagarhem@amazon.com
---
 drivers/irqchip/irq-gic-v3-its.c | 44 ++++++++-----------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 40ebf17..3c755d5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1846,28 +1846,22 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	int ret = 0;
 
 	if (!info->map)
 		return -EINVAL;
 
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
-
 	if (!its_dev->event_map.vm) {
 		struct its_vlpi_map *maps;
 
 		maps = kcalloc(its_dev->event_map.nr_lpis, sizeof(*maps),
 			       GFP_ATOMIC);
-		if (!maps) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!maps)
+			return -ENOMEM;
 
 		its_dev->event_map.vm = info->map->vm;
 		its_dev->event_map.vlpi_maps = maps;
 	} else if (its_dev->event_map.vm != info->map->vm) {
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* Get our private copy of the mapping information */
@@ -1899,46 +1893,32 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 		its_dev->event_map.nr_vlpis++;
 	}
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_vlpi_map *map;
-	int ret = 0;
-
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
 	map = get_vlpi_map(d);
 
-	if (!its_dev->event_map.vm || !map) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!its_dev->event_map.vm || !map)
+		return -EINVAL;
 
 	/* Copy our mapping information to the incoming request */
 	*info->map = *map;
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_unmap(struct irq_data *d)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	int ret = 0;
-
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
-	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d))
+		return -EINVAL;
 
 	/* Drop the virtual mapping */
 	its_send_discard(its_dev, event);
@@ -1962,9 +1942,7 @@ static int its_vlpi_unmap(struct irq_data *d)
 		kfree(its_dev->event_map.vlpi_maps);
 	}
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_prop_update(struct irq_data *d, struct its_cmd_info *info)
@@ -1992,6 +1970,8 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
+	guard(raw_spinlock_irq)(&its_dev->event_map.vlpi_lock);
+
 	/* Unmap request? */
 	if (!info)
 		return its_vlpi_unmap(d);

