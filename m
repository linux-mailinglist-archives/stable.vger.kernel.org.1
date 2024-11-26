Return-Path: <stable+bounces-95565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484379D9DE5
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 20:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51948B23A1F
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670C41DE3C5;
	Tue, 26 Nov 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pzCrnJjN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z8DL4VFF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979516F0E8;
	Tue, 26 Nov 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648239; cv=none; b=OXsy0uSO011KYBNNAztxHpl6LoPhcRCmzOx7YEX25MRoQLl5qIWnl6zTR316YO73c8NUDCrfxd2gZJsrIO3yj58jwOkJCJL+PiFX7SF+BnrVIDR2znTdGhwdCom/o6PC2At7UnCFcD/0uWmwV0qnVCLXLSFN3Bfhbd7GKbgHZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648239; c=relaxed/simple;
	bh=JOHJmp5WW4ejGgVC5EV8U4eM4KtgEjJCcdvggW8sJMI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L5NZMY6EXLmm+D40xJsfnEyUPVPptLfYkbA15TnJb/r/Hu7h/OmMHfb0jCgTwEtzu748cZUvrzDiyV+CNO/UFdzQ/57DQCx9W7bV+Zs9JXI+PIipkG5i57ZA6r8BYmrKdba9p44rMvypxdx6k/lSYI4WgzbQbCyaTdetk806x1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pzCrnJjN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z8DL4VFF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Nov 2024 19:10:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732648235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAjiz4z6eaIdVpBbx0+i+piPgSWWWTXgTEOEVv9t9TA=;
	b=pzCrnJjNjWUiWPstzTCJxpul3A4Eb1NkEoEh376Q0LC1Ta+rgz7ALhNs1EbNo96hlzX0Lq
	Hk+lmB4x1zMQ0TQesfP2UeIuuX+ivgcZH6TtTf5F2DVNFredbuBv9eFPr2G8Ke80dd05o/
	7IhPpaliCcMSHokb6U1c913LYtiwFMWyZxnUWdRrQpYrc/56Sx0NQoa9sNv4gcds75qtTD
	8Naqi+kPC+IYdBGh5Rt12GCyHu111hhUsG/pDF/utSixVKlHYDywEX+NxJ4SCa3IYiZBhB
	eMFmNycrW9E243BcuZdcgGD80ptttgM5hjhqz+jlBp72V+zBOvdVU/AagCCa+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732648235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAjiz4z6eaIdVpBbx0+i+piPgSWWWTXgTEOEVv9t9TA=;
	b=Z8DL4VFFfGP7Gb1okUjqjjymIoV3e9MR2s1wzGKp4QrhFy3qqQofv4jG/xhFWzE45nRhm3
	G69YBeFw4PWQn4CA==
From: "tip-bot2 for Russell King (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-mvebu-sei: Move misplaced select()
 callback to SEI CP domain
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <E1tE6bh-004CmX-QU@rmk-PC.armlinux.org.uk>
References: <E1tE6bh-004CmX-QU@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173264823499.412.10177145065774712407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     12aaf67584cf19dc84615b7aba272fe642c35b8b
Gitweb:        https://git.kernel.org/tip/12aaf67584cf19dc84615b7aba272fe642c35b8b
Author:        Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
AuthorDate:    Thu, 21 Nov 2024 12:48:25 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 26 Nov 2024 19:58:27 +01:00

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
Link: https://lore.kernel.org/all/E1tE6bh-004CmX-QU@rmk-PC.armlinux.org.uk
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

