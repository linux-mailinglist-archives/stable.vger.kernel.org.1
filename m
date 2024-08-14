Return-Path: <stable+bounces-67697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A630495220B
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509EC1F2394F
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549131BD038;
	Wed, 14 Aug 2024 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="X4Jn+vAC"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891621BD513
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660141; cv=none; b=tHKEjqzmHVMnqlsbDmLeMzJJEAyc9GVBmD8iGzBOwtAnWwyWNtzbrbmWXnvjIXIHNY+kTsDbaxTibLNDebseBMt/D+wwaBvYjR5EvMVpP8DqWqXs33NyrVMlSWSp5TwVuIN2lyvcfuH4s91KPqiKvMuVOO9Ui4jpqLNni0WFZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660141; c=relaxed/simple;
	bh=AdyyjzcenuYw1BNec9UHxSybz8vocMaIOwHji8eiV7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEboBv9u+tOBKHsNi9BevNZ/It00mAXJJKgIvxLEVaaBwYI/3+FARFihrzIb3l5I3HhuofBwqh01Te+CvjOuTsi8/tS45t64csNj+jqBUo4HFLPXJ/I7EQZxASqYyGq3xWhbsvDptCOPJ0UFnH1zgksNtDoJhGkx9cNjBZkRPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=X4Jn+vAC; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WkcGL5lwYz6CmLxT;
	Wed, 14 Aug 2024 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1723660134; x=1726252135; bh=BehAI
	MNVAsO10rb5ulA9jv6IiHXjD+x6gGAo0JfGAXc=; b=X4Jn+vACJ+Qw2Iqx3/SeJ
	h7qnN1mdtAG7tdOe94xktV/gHHfKt5ZqvSv4KL8or35mmBneTUB9h3Pbk67X1OQo
	kia61VZEVeJpYa4ydQTwvEbOj+s2h5AISzHKlYDjj9yvi/7KOf7FWxDDcECeaweo
	LIUu5Gy5I+a/AxKZbRctSumHhQAF+XL6+tGv2I9fBevWlUPEJ+B2beuiUZRzr6sW
	+MvWDxMYNIuepcTQp/o7XLa8S+TTfXZyVx+q2ZojUNAa0Sh4RTBmK2AE8TDZYwqv
	OBLF9iLLA2KNHu4y/lvDwfyxGhOBHi67ciWJo04X4tKo6SLeFiyxpVd6L9zii2En
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PE_raSWh6API; Wed, 14 Aug 2024 18:28:54 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WkcGF52wVz6CmLxd;
	Wed, 14 Aug 2024 18:28:53 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Stevens <stevensd@chromium.org>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 6.6 1/2] genirq/cpuhotplug: Skip suspended interrupts when restoring affinity
Date: Wed, 14 Aug 2024 11:28:25 -0700
Message-ID: <20240814182826.1731442-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240814182826.1731442-1-bvanassche@acm.org>
References: <20240814182826.1731442-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: David Stevens <stevensd@chromium.org>

commit a60dd06af674d3bb76b40da5d722e4a0ecefe650 upstream.

irq_restore_affinity_of_irq() restarts managed interrupts unconditionally
when the first CPU in the affinity mask comes online. That's correct duri=
ng
normal hotplug operations, but not when resuming from S3 because the
drivers are not resumed yet and interrupt delivery is not expected by the=
m.

Skip the startup of suspended interrupts and let resume_device_irqs() dea=
l
with restoring them. This ensures that irqs are not delivered to drivers
during the noirq phase of resuming from S3, after non-boot CPUs are broug=
ht
back online.

Signed-off-by: David Stevens <stevensd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240424090341.72236-1-stevensd@chromium.=
org
---
 kernel/irq/cpuhotplug.c | 11 ++++++++---
 kernel/irq/manage.c     | 12 ++++++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 5ecd072a34fe..367e15a2f570 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -195,10 +195,15 @@ static void irq_restore_affinity_of_irq(struct irq_=
desc *desc, unsigned int cpu)
 	    !irq_data_get_irq_chip(data) || !cpumask_test_cpu(cpu, affinity))
 		return;
=20
-	if (irqd_is_managed_and_shutdown(data)) {
-		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
+	/*
+	 * Don't restore suspended interrupts here when a system comes back
+	 * from S3. They are reenabled via resume_device_irqs().
+	 */
+	if (desc->istate & IRQS_SUSPENDED)
 		return;
-	}
+
+	if (irqd_is_managed_and_shutdown(data))
+		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
=20
 	/*
 	 * If the interrupt can only be directed to a single target
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a054cd5ec08b..8a936c1ffad3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -796,10 +796,14 @@ void __enable_irq(struct irq_desc *desc)
 		irq_settings_set_noprobe(desc);
 		/*
 		 * Call irq_startup() not irq_enable() here because the
-		 * interrupt might be marked NOAUTOEN. So irq_startup()
-		 * needs to be invoked when it gets enabled the first
-		 * time. If it was already started up, then irq_startup()
-		 * will invoke irq_enable() under the hood.
+		 * interrupt might be marked NOAUTOEN so irq_startup()
+		 * needs to be invoked when it gets enabled the first time.
+		 * This is also required when __enable_irq() is invoked for
+		 * a managed and shutdown interrupt from the S3 resume
+		 * path.
+		 *
+		 * If it was already started up, then irq_startup() will
+		 * invoke irq_enable() under the hood.
 		 */
 		irq_startup(desc, IRQ_RESEND, IRQ_START_FORCE);
 		break;

