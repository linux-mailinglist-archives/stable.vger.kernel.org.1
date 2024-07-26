Return-Path: <stable+bounces-61924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15793D8EB
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 21:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F17F1F21C88
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 19:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228A04779D;
	Fri, 26 Jul 2024 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40whssOM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2URE3Hg"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7AA24205;
	Fri, 26 Jul 2024 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021434; cv=none; b=mXAQpAl04rUF3tyZ4QHe9qFDBdLKja+d0TRnpRlNZnpoxUiAnwmsZqyC0XdND5BuKSoOxML30Y0VV+4rk9PX5h9Qj5dZhOUGySL+xzq5SToeHVAt2VreSyRWwAreUIkh+i8kX3YbKpadhmie2CYjnPxAJOk6WdOP4bxLDiloqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021434; c=relaxed/simple;
	bh=OE8MEKsVTtFrnP50pHVinj/nPKl7CKeQdrUpdUGPmMQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SP8ZihuSaQ7R1orueZyyvyG5IohkpRLRdphXWEu0rmjAW4ofbMK5ib9xTj5EmAeot4TFAH7Ka7qlxLtRJTW0C16BKk+9zXsgmBJ31leFxLOy5CXuUSlImjni/DB7AMcohuZ7YsQUKZhsHUjyxqySpDKkZZ672u2DFWcT6ic2e9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40whssOM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2URE3Hg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jul 2024 19:17:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722021431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhrAtTTu8DHRd5jfPalDcxDj16nhVoMkPMFW+VWrNTc=;
	b=40whssOMY39Ia+uldZhW+5FRgvIg6hwTCsh8hUt8UurWVOAmqRrQcGnXBtFoBcH7266DsD
	W6CFhv+UrXHXuKUB6KCCkgV8945KKT6ZxIXuimi3OeUbxuN20Naq4x+X7MHqDaNBwE5/jD
	AYB+NYNtKj+3gDsj07BhJXLRrie4VQmxN8xpJblw805LaNz0TluO0mYI3TzmQUXM3frYVr
	kaJr0b6BqJKOVm71+oTeV/Io5jVkfFRc3RWcr3t4eP5ffOdzPJ4AVMO7vMxRBLi3BVwHjV
	ns8NwxnPbfdA5NQffz5BTLaaQH/MlHq74PylQqxJH267znlPCJydhlwLx2VkLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722021431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhrAtTTu8DHRd5jfPalDcxDj16nhVoMkPMFW+VWrNTc=;
	b=N2URE3HgObZGW/BjIHSHPbBDl1/diTG+ZMcvlf1yrLdCfI/cXCgwf3tSo/basWgLiAY99q
	FX5zO2L5y3ve1uCQ==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/loongarch-cpu: Fix return value of
 lpic_gsi_to_irq()
Cc: Miao Wang <shankerwangmiao@gmail.com>,
 Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,  <stable@vger.kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240723064508.35560-1-chenhuacai@loongson.cn>
References: <20240723064508.35560-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172202143044.2215.9209897857096931802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     81a91abab1307d7725fa4620952c0767beae7753
Gitweb:        https://git.kernel.org/tip/81a91abab1307d7725fa4620952c0767beae7753
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 23 Jul 2024 14:45:08 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Jul 2024 21:08:42 +02:00

irqchip/loongarch-cpu: Fix return value of lpic_gsi_to_irq()

lpic_gsi_to_irq() should return a valid Linux interrupt number if
acpi_register_gsi() succeeds, and return 0 otherwise. But lpic_gsi_to_irq()
converts a negative return value of acpi_register_gsi() to a positive value
silently.

Convert the return value explicitly.

Fixes: e8bba72b396c ("irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch")
Reported-by: Miao Wang <shankerwangmiao@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240723064508.35560-1-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongarch-cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 9d8f2c4..b35903a 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -18,11 +18,13 @@ struct fwnode_handle *cpuintc_handle;
 
 static u32 lpic_gsi_to_irq(u32 gsi)
 {
+	int irq = 0;
+
 	/* Only pch irqdomain transferring is required for LoongArch. */
 	if (gsi >= GSI_MIN_PCH_IRQ && gsi <= GSI_MAX_PCH_IRQ)
-		return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+		irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
 
-	return 0;
+	return (irq > 0) ? irq : 0;
 }
 
 static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)

