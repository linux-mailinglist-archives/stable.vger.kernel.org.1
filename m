Return-Path: <stable+bounces-80574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BA598DF7C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453FF1F25456
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8402B1D0E12;
	Wed,  2 Oct 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="no/O8AVb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ikPAbI7q"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C41D0B9B;
	Wed,  2 Oct 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883823; cv=none; b=QNFoob0PAnSNcR14RIgYNEIj3jalyK1ldnVVmfqkpsPTXjuMxTlQdHNINllE6TauOkkc2QEgxNcgTC8DsdqCmTlLdMZPJsixe/5Nc+eTlEaWTgVSFfTmRuN5ekIoqwrurZqvO8+cm5gEYwiZSDjmFddUw9eI7v1moGTzBE3qr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883823; c=relaxed/simple;
	bh=eupZP83d8Rmmq6bvh6rWw7nX5eY6CPD82pltJdGDeBo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p54fQgFcJ6p20lysOZ5TqR0brInsYFnlEg6mq6VqMyXkEDKxpL8EbfrxBZRyH4/ckp/CBPxth3qfnAz/w/SVtA14+245NHA1zth4xnqfN2vXRZ0XN8OWBLbrLGEZsKIdcKILN+6jyZVhj85Q288vtxyt9UtkANi/+Z+B6gt2JxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=no/O8AVb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ikPAbI7q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:43:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB7D0Yxk4vEL7tQjeogv+MpND1wlqBrOliwrobX+fbM=;
	b=no/O8AVbFCsgQhU9oq8Rk0xf0Ygo+GeJ7Yz1qL+O5wUPzWjMch0aTjo/yrcwv30Z2nh99B
	/Ys/ls4sOt4R3jeuWU3I8iQv3He7f0+SZV8WQqXX1VQJcsyx2ncjt0CRi6p4zZsBKMPRXe
	WUsaT7Y9oaHNbYwQb3xH6O7Ffxzv3AQq/7DpcQkkvgdTLfbVo4X+zeZno5ULYE2Pw1Zn/k
	wZ+USsEhKTyR7C0YaReLGe5e+ue7YEAW0PFUpER6LamDx/VfV2aaxNPYvW2NXVAaS+h9Hj
	U0pO4/3sukHwkpZOTiIdsD8SexR/JhZBFVDj4/XJ73J9sQsftwhG8iWEMcGyow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB7D0Yxk4vEL7tQjeogv+MpND1wlqBrOliwrobX+fbM=;
	b=ikPAbI7qnTPctzFsnhSY9g4253M7ozKUyjTt9y+vIell59o2o/6UXY/sMCIAVr/ebK1F6O
	qzljChUGJ8wsQZBQ==
From: "tip-bot2 for Charlie Jenkins" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/sifive-plic: Return error code on failure
Cc: kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Charlie Jenkins <charlie@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Anup Patel <anup@brainfault.org>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To:
 <20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com>
References:
 <20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788381949.1442.6238243346847777696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     6eabf656048d904d961584de2e1d45bc0854f9fb
Gitweb:        https://git.kernel.org/tip/6eabf656048d904d961584de2e1d45bc0854f9fb
Author:        Charlie Jenkins <charlie@rivosinc.com>
AuthorDate:    Tue, 03 Sep 2024 16:36:19 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 15:15:33 +02:00

irqchip/sifive-plic: Return error code on failure

Set error to -ENOMEM if kcalloc() fails or if irq_domain_add_linear()
fails inside of plic_probe() instead of returning 0.

Fixes: 4d936f10ff80 ("irqchip/sifive-plic: Probe plic driver early for Allwinner D1 platform")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com
Closes: https://lore.kernel.org/r/202409031122.yBh8HrxA-lkp@intel.com/
---
 drivers/irqchip/irq-sifive-plic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 2f6ef5c..0b730e3 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -626,8 +626,10 @@ static int plic_probe(struct fwnode_handle *fwnode)
 
 		handler->enable_save = kcalloc(DIV_ROUND_UP(nr_irqs, 32),
 					       sizeof(*handler->enable_save), GFP_KERNEL);
-		if (!handler->enable_save)
+		if (!handler->enable_save) {
+			error = -ENOMEM;
 			goto fail_cleanup_contexts;
+		}
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -639,8 +641,10 @@ done:
 
 	priv->irqdomain = irq_domain_create_linear(fwnode, nr_irqs + 1,
 						   &plic_irqdomain_ops, priv);
-	if (WARN_ON(!priv->irqdomain))
+	if (WARN_ON(!priv->irqdomain)) {
+		error = -ENOMEM;
 		goto fail_cleanup_contexts;
+	}
 
 	/*
 	 * We can have multiple PLIC instances so setup global state

