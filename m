Return-Path: <stable+bounces-69732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B39958AC6
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 17:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C14B214D4
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D7190052;
	Tue, 20 Aug 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4BOzB7m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="febEKZ63"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D618E37F;
	Tue, 20 Aug 2024 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166738; cv=none; b=GxHIcN68IbllYYzAzfkmDzOOcH80XFgSZzjsOunvyx4o1r1H4WDSCm/5SlqNwwFmUAzfviCmB+ej4JFmQgklu/W6NiZ3GesAceT06BQjKU4bxzDim1yxm+ywfLdPHKxTCprYZw+cr86pttFY38tC0dHynF86n06WxTuq2Rabg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166738; c=relaxed/simple;
	bh=WU4sn7n5evf6t5QHCKTquiAEUr02737lN7Up1e6S6hQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LEv8M/6RfiDXoDdhc69rp6jMbd5hYSSCdsKV5RLQFFTxshkswppbWpxeWvFEzvCeJRJBfKwhzAxgL4uTlz2kLQQVrKb/fMl8FNcnDbxgfCCpQDeLLl1ukMHaKDLw/2vknE4QLuegN3yww3zEapfCDJzR9+S7l9x2HGUo7vJu60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4BOzB7m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=febEKZ63; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Aug 2024 15:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724166734;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iednjl+XWJ1tntTvPRGJxB0VlyMF9f1Yc+xpGnZrYDc=;
	b=f4BOzB7mO+bAgliIDkWJ8rMhChUUnvFBP4aRsGcJ9x1uCk1Po0eaBohuYfKzIqERnK5mX2
	zgrgBOgkgZiOdIfve7oVf/+wUG3rWemz/5UrJFlQGGhmKGfF3bpeVkjOYGa7tadzirG8X2
	7rqHqpqAMpB0VA743wBLMR3F3nGCw66RbI81h5+zTB+DUhoy8k+NbupeoTGfXEfBx8RFc5
	mKnVvqNoz0ucBO+J9DA0aARtdcpAvSqfDAqia64mBb8UH1eXhqGxGjCJUGzb5uvGDArF0k
	9demyCQK8nyqgC0AVtoR7skzeF09bBEruemVvY4zRTSHATab1kT0eUe1rF4s8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724166734;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iednjl+XWJ1tntTvPRGJxB0VlyMF9f1Yc+xpGnZrYDc=;
	b=febEKZ63lcrvUtDxdQyldUV92Qx7uxiKL4Q0qjjCFLyZmuhNIqV84AEH0RF/jjNnTyNRbf
	TCYnZASTUlU+9TDw==
From: "tip-bot2 for Ma Ke" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()
Cc: Ma Ke <make24@iscas.ac.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240820092843.1219933-1-make24@iscas.ac.cn>
References: <20240820092843.1219933-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172416673413.2215.9983587782024044954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     c5af2c90ba5629f0424a8d315f75fb8d91713c3c
Gitweb:        https://git.kernel.org/tip/c5af2c90ba5629f0424a8d315f75fb8d91713c3c
Author:        Ma Ke <make24@iscas.ac.cn>
AuthorDate:    Tue, 20 Aug 2024 17:28:43 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2024 17:05:32 +02:00

irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()

gicv2m_of_init() fails to perform an of_node_put() when
of_address_to_resource() fails, leading to a refcount leak.

Address this by moving the error handling path outside of the loop and
making it common to all failure modes.

Fixes: 4266ab1a8ff5 ("irqchip/gic-v2m: Refactor to prepare for ACPI support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240820092843.1219933-1-make24@iscas.ac.cn
---
 drivers/irqchip/irq-gic-v2m.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 51af63c..be35c53 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -407,12 +407,12 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 
 		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
 				      &res, 0);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}
 
+	if (ret && child)
+		of_node_put(child);
 	if (!ret)
 		ret = gicv2m_allocate_domains(parent);
 	if (ret)

