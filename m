Return-Path: <stable+bounces-47858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B2F8D802A
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 12:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717AD28B038
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D500C82C7E;
	Mon,  3 Jun 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pu+BK2j9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MoijTguv"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C782487;
	Mon,  3 Jun 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410989; cv=none; b=ocqJowsogMiU70suN3gSaEYTW4EcsKxNKNu75IEJmvCssF74fyTfqwS/M0A1IdzFZhAow+8lUW2bvztuOHO+fORhYLv2u/8+RnbYdHAQej8wi5wl0k50gEaJge9xZyYqpPEdpUO2ZgJ0ytuYXq/arPMyJN3UFUGWMuo85cQXwg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410989; c=relaxed/simple;
	bh=7Bk8a5XKoqld68DuYkGTzx/fVfXv5gS4p9UqRcye2pc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kMuwCsvlz8AKgORaIq6mGBM4YkF/eswhjqPXC5njyxStRWYJptP4HiPUQgrgAW72QqZO0yc3AfrbqVvR1SoWItntYz1VtA9Kr+Kj8UWuNNzD9u4Vu9NYrZDoaddxOewxw5sAsk/M17adBBAzK+7EWXeDhktHd0PvYtlVbe3Nsbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pu+BK2j9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MoijTguv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 10:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717410986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjtlOTPaOIgUVbAWMc4atfx/AHmzxrJPiglFci9YRlg=;
	b=Pu+BK2j97JI06LClrainV9UU3mgnc5NJUWnZTyh4dYOi/Ye8exKjK9GeLFkfxZ4+EwkAe7
	w33+sBnjyNhy8mNVNDzf0qx3oRbjDhIzMbzfkD+bH0EwERIm9IIhaxe6hmKonJ4RxGBCty
	2/isL1YbdRYD6HzPHsgSCxJLOQwxT9efzykowZJdnGq7WN9lmDPArG4lj8Goc/XVfYZHoX
	INv+jIzYlBRGCHDEci318CdXH66VzhgsIxqXBN1bFu7zk+hPlRnD3a6yoFTZpJYKvjwn71
	3RT54wRm08JHV2tMTDvJGlLyWclX8s9fa3RgkOjh9nMCON2TE8gEZgpvXScewg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717410986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjtlOTPaOIgUVbAWMc4atfx/AHmzxrJPiglFci9YRlg=;
	b=MoijTguveVGfqVYLkT7vu2XDn8FfhghN9Uui0d7oxxJlViSboxPI2Jng9nGVMVj6O3zpaT
	zL0AgnoDv9v+VeAw==
From: "tip-bot2 for Sunil V L" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-intc: Prevent memory leak when
 riscv_intc_init_common() fails
Cc: Sunil V L <sunilvl@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 Anup Patel <anup@brainfault.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240527081113.616189-1-sunilvl@ventanamicro.com>
References: <20240527081113.616189-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171741098562.10875.13157753436022438155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     0110c4b110477bb1f19b0d02361846be7ab08300
Gitweb:        https://git.kernel.org/tip/0110c4b110477bb1f19b0d02361846be7ab08300
Author:        Sunil V L <sunilvl@ventanamicro.com>
AuthorDate:    Mon, 27 May 2024 13:41:13 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 12:29:35 +02:00

irqchip/riscv-intc: Prevent memory leak when riscv_intc_init_common() fails

When riscv_intc_init_common() fails, the firmware node allocated is not
freed. Add the missing free().

Fixes: 7023b9d83f03 ("irqchip/riscv-intc: Add ACPI support")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240527081113.616189-1-sunilvl@ventanamicro.com

---
 drivers/irqchip/irq-riscv-intc.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 9e71c44..4f3a123 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -253,8 +253,9 @@ IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
-	struct fwnode_handle *fn;
 	struct acpi_madt_rintc *rintc;
+	struct fwnode_handle *fn;
+	int rc;
 
 	rintc = (struct acpi_madt_rintc *)header;
 
@@ -273,7 +274,11 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	}
 
-	return riscv_intc_init_common(fn, &riscv_intc_chip);
+	rc = riscv_intc_init_common(fn, &riscv_intc_chip);
+	if (rc)
+		irq_domain_free_fwnode(fn);
+
+	return rc;
 }
 
 IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,

