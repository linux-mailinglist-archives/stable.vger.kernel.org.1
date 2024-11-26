Return-Path: <stable+bounces-95564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E259D9DD0
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 20:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56495B262C4
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FBF1DB365;
	Tue, 26 Nov 2024 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2KbM9rxf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YYMZ6pqS"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63206183CCA;
	Tue, 26 Nov 2024 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647679; cv=none; b=TpI8bywm88aYNay2V8F7/NVyRBRHs0ZxpOXxJVtfhpjpgzJAyghHfVOycuuXauslc4PnWCR5p9klP2dS4Fi+M7jpboJjqx9zpHnAGObwv7S4cN8GrIsIGBNX6Q9dksyiHTFR6wrIRgQvZhgGM8Fkf5A+JjBhcqXL6fN3iA/d+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647679; c=relaxed/simple;
	bh=P8M1UPsrLzB3p2nJRXqoXqJWjwr0xU5AQFz5jVN9jco=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=p3UxyUZ1FGUrig9hmMvTEGBV4W/W9SMiItFzQwe//kgkyKEyXP7eKrlYjcC38FAQOdMdKuEkT5N4Rz4ScwuzqnPtXKiZ+9DGFsYyYm7W8IaBoZOPFI4fgOjPEPlGGwYJMJ+PTY3Q8pppKO/52pTHEwQnXbSH7AMr2y8JTIrIus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2KbM9rxf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YYMZ6pqS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Nov 2024 19:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732647675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=d4SOQFtTEkYY3L8+IOQayZlPryk9ozcbJ2aGM6OAA8U=;
	b=2KbM9rxf270+yTBtSWBV6eghZkOHojiEmd8zNkYQbD9pyg3AlDefVBH+yZTNLkI8ToytmH
	888My3AwvOp41iddKbeYtsZMEuElg2e5lcg+h4Jb8yYJeIIHgBFBXdSKVrUT35uPIH/eIn
	diuvvXaWIzCJDWfPrgnIuR77aauG3la5L5vfhUZf/nsDvxafb+qLHnUvvvMyCcNC53772c
	W7rnw17kKTMglefbiAAao26vA0ghZ0zDfci7fqEgzrSAAiOEua3BeKNg4emDlFHF0ZSTHH
	GfHPy7SgoLd1hzu6f2ux5LE/hDQMYOmn3oYwPcOMcTD4/Y23CKe3sb+22PX+KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732647675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=d4SOQFtTEkYY3L8+IOQayZlPryk9ozcbJ2aGM6OAA8U=;
	b=YYMZ6pqS6+tLn4nS7GtNQT6K0/tQSanTmCuHKOoPIit/NSd99o1/b88gapj0MoJALS9T+3
	Hu9g1oRD2I0iU9Dw==
From: "tip-bot2 for Russell King (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-mvebu-sei: Move misplaced select()
 callback to SEI CP domain
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173264767413.412.14263736309702033127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     81b9e4c6910fd779b679d7674ec7d3730c7f0e2c
Gitweb:        https://git.kernel.org/tip/81b9e4c6910fd779b679d7674ec7d3730c7f0e2c
Author:        Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
AuthorDate:    Thu, 21 Nov 2024 12:48:25 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 26 Nov 2024 19:50:42 +01:00

irqchip/irq-mvebu-sei: Move misplaced select() callback to SEI CP domain

Commit fbdf14e90ce4 ("irqchip/irq-mvebu-sei: Switch to MSI parent")
introduced in v6.11-rc1 broke Mavell Armada platforms (and possibly others)
by incorrectly switching irq-mvebu-sei to MSI parent.

In the above commit, msi_parent_ops is set for the sei->cp_domain, but
rather than adding a .select method to mvebu_sei_cp_domain_ops (which is
associated with sei->cp_domain), it was added to mvebu_sei_domain_ops which
is associated with sei->sei_domain, which doesn't have any
msi_parent_ops. This makes the call to msi_lib_irq_domain_select() always
fail.

This bug manifests itself with the following kernel messages on Armada 8040
based systems:

 platform f21e0000.interrupt-controller:interrupt-controller@50: deferred probe pending: (reason unknown)
 platform f41e0000.interrupt-controller:interrupt-controller@50: deferred probe pending: (reason unknown)

Move the select callback to mvebu_sei_cp_domain_ops to cure it.

Fixes: fbdf14e90ce4 ("irqchip/irq-mvebu-sei: Switch to MSI parent")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-mvebu-sei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index f8c70f2..065166a 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -192,7 +192,6 @@ static void mvebu_sei_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops mvebu_sei_domain_ops = {
-	.select	= msi_lib_irq_domain_select,
 	.alloc	= mvebu_sei_domain_alloc,
 	.free	= mvebu_sei_domain_free,
 };
@@ -306,6 +305,7 @@ static void mvebu_sei_cp_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops mvebu_sei_cp_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= mvebu_sei_cp_domain_alloc,
 	.free	= mvebu_sei_cp_domain_free,
 };

