Return-Path: <stable+bounces-134820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A9BA95232
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7845A7A583E
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E440F266588;
	Mon, 21 Apr 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IZ1qblIo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4226560B
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243866; cv=none; b=AZLmETrM9EGPK2wFYIQJ7IzyA3QRIb796mZHaTXvF9fkbC4vzKimFhbLNFdebhasbD4GJ/QALR3/W5VkKjyIF499gSnYXYUU31fjbyJClhECcdAy9dl0uM8UWo9QTYLN6yDJig/D4s4j7bFIl0KCaYEvIVsmkh1VYdbHY54UdZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243866; c=relaxed/simple;
	bh=T0Zl2axCSxy6w/iEDUolZns6Szc5X0bUN8+3Uzcv79A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R9Rgonh4Hb0YIGKxhdL7w5YyJzVUKgEbyI05Nw5fjxgKrzRmUTh2uobqND1VKlcNYV7ByZJcuXpQSWUE9Ipfq/TQ+qOaajruz+RG06BYkAZvYtiwFmYWCSgMXFiJ2D4JWTse4KPGiuWp1FmE3Tow2I/3bBR5hso4YRKA+VjFvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IZ1qblIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFBFC4CEE4;
	Mon, 21 Apr 2025 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243866;
	bh=T0Zl2axCSxy6w/iEDUolZns6Szc5X0bUN8+3Uzcv79A=;
	h=Subject:To:Cc:From:Date:From;
	b=IZ1qblIoFWPXsonBDKGUjcFliFSt53UZVuJsokBUYOLG64kIa8P4AtMCjA+mMyBgo
	 aqfw+NSsxJv+U6cRk221vQVPltqKu6G4MU+AO0md1rn9kU99Jvo2xLzKmU1n/Pt9R+
	 +zB/xmTacM4GQJCvquebZubv0OX0f6JSX/Ai5E/c=
Subject: FAILED: patch "[PATCH] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt" failed to apply to 6.14-stable tree
To: biju.das.jz@bp.renesas.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:57:43 +0200
Message-ID: <2025042143-clash-grumbly-11dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 28e89cdac6482f3c980df3e2e245db7366269124
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042143-clash-grumbly-11dd@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 28e89cdac6482f3c980df3e2e245db7366269124 Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Tue, 15 Apr 2025 11:33:41 +0100
Subject: [PATCH] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt

A spurious TINT interrupt is seen during boot on RZ/G3E SMARC EVK.

A glitch in the edge detection circuit can cause a spurious interrupt.

Clear the status flag after setting the ICU_TSSRk registers, which is
recommended in the hardware manual as a countermeasure.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 3d5b5fdf9bde..0f0fd7d4dfdf 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -170,6 +170,14 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
 	else
 		tssr &= ~ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
+
+	/*
+	 * A glitch in the edge detection circuit can cause a spurious
+	 * interrupt. Clear the status flag after setting the ICU_TSSRk
+	 * registers, which is recommended by the hardware manual as a
+	 * countermeasure.
+	 */
+	writel_relaxed(BIT(tint_nr), priv->base + priv->info->t_offs + ICU_TSCLR);
 }
 
 static void rzv2h_icu_irq_disable(struct irq_data *d)


