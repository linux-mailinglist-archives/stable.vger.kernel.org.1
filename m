Return-Path: <stable+bounces-104146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6AE9F137B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 18:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB42188D7F7
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5071E47AD;
	Fri, 13 Dec 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fGcJcmvd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VjTKcKwg"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA91E2843;
	Fri, 13 Dec 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110433; cv=none; b=A1vhbg/ThIGN97leAq+Esa4RuThIroqUs8KIW1H5uTTzgneWfSo9vlUnaiV7wbT+3r/q8BkiZeXiqLJzjxl0WTfwhQHgOo9xfsbCzsS0Y3284cPztrIqLXkp2gubdYUoFw0t60kHaEkhkbE3lq2GzE2xK1NQs3dZdnVWbAIOeU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110433; c=relaxed/simple;
	bh=gvJNY0gLx+6GB7Qr5+JYqBJ5Vl5l6PKUD5js6c+aA/s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d2O7aT5V2vx0wsxnNlvUPTiqbqrH+O8RZ8XxrHYqz5tgpmu52EItp3gNugFOIp2Mwqht9035drie1pqURt3d0gJNbNBHl9+uyhIFM7xMefpxRokKb+Sqy8GUSUMlzJl27xSZq1eCqqYb2hWnGdWY8gkqvMD72dYIZEfCk7VGnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fGcJcmvd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VjTKcKwg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 17:20:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734110430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wo/IeJqxNfLDmdJYwmjsjI80Cp/jXyK3Kb6Wl2X5cyc=;
	b=fGcJcmvdNWEOLl8BINMB0ouzw9yJDbldZe1ZBMzDPFVU76YTivz1gRibrGTP4ZAC1aIfb8
	j6ONraH1AanoPTsxPkBz38yMoi6V6nv9zrAl/yB4WDr3ve+pCZYP4na2KzXJgNc6qjKauB
	dG0/+NLaZ6+3Jxl11OvaTX5lC2LKt4eQ0zgkuf5qyBOhqIxu8q+ha0AJ5OhVv6p4UiK8O9
	1xItsx77+fFl5G0FADXI9ejoIQw8ODZ7R9jhI0ZDlLZEWhcajYh6gefSGy+FqLw99asCjQ
	Btz2RhOGXg9R/mTDQOgKUEcg+VtRtZm/7Lanbd2cNW4vMgMdCCNQaRZwDJkViQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734110430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wo/IeJqxNfLDmdJYwmjsjI80Cp/jXyK3Kb6Wl2X5cyc=;
	b=VjTKcKwgOPRoferFMqhfz02f6t78HxSLGSb3JaH7sQzR49Vi1fwG2J7iQPMErAHTOI9h4a
	JsfeQpJsMlexeLAg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/gic-v3: Work around insecure GIC integrations
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, "Chen-Yu Tsai" <wens@csie.org>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241213141037.3995049-1-maz@kernel.org>
References: <20241213141037.3995049-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173411042830.412.16289684167739919104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     773c05f417fa14e1ac94776619e9c978ec001f0b
Gitweb:        https://git.kernel.org/tip/773c05f417fa14e1ac94776619e9c978ec001f0b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 13 Dec 2024 14:10:37 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Dec 2024 18:15:29 +01:00

irqchip/gic-v3: Work around insecure GIC integrations

It appears that the relatively popular RK3399 SoC has been put together
using a large amount of illicit substances, as experiments reveal that its
integration of GIC500 exposes the *secure* programming interface to
non-secure.

This has some pretty bad effects on the way priorities are handled, and
results in a dead machine if booting with pseudo-NMI enabled
(irqchip.gicv3_pseudo_nmi=1) if the kernel contains 18fdb6348c480 ("arm64:
irqchip/gic-v3: Select priorities at boot time"), which relies on the
priorities being programmed using the NS view.

Let's restore some sanity by going one step further and disable security
altogether in this case. This is not any worse, and puts us in a mode where
priorities actually make some sense.

Huge thanks to Mark Kettenis who initially identified this issue on
OpenBSD, and to Chen-Yu Tsai who reported the problem in Linux.

Fixes: 18fdb6348c480 ("arm64: irqchip/gic-v3: Select priorities at boot time")
Reported-by: Mark Kettenis <mark.kettenis@xs4all.nl>
Reported-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen-Yu Tsai <wens@csie.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241213141037.3995049-1-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 34db379..79d8cc8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -161,7 +161,22 @@ static bool cpus_have_group0 __ro_after_init;
 
 static void __init gic_prio_init(void)
 {
-	cpus_have_security_disabled = gic_dist_security_disabled();
+	bool ds;
+
+	ds = gic_dist_security_disabled();
+	if (!ds) {
+		u32 val;
+
+		val = readl_relaxed(gic_data.dist_base + GICD_CTLR);
+		val |= GICD_CTLR_DS;
+		writel_relaxed(val, gic_data.dist_base + GICD_CTLR);
+
+		ds = gic_dist_security_disabled();
+		if (ds)
+			pr_warn("Broken GIC integration, security disabled");
+	}
+
+	cpus_have_security_disabled = ds;
 	cpus_have_group0 = gic_has_group0();
 
 	/*

