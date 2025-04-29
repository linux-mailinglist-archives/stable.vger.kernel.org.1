Return-Path: <stable+bounces-137349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282E6AA130E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73013AF31A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4F2522AE;
	Tue, 29 Apr 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lZTPdpwi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BF253B77;
	Tue, 29 Apr 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945803; cv=none; b=NIrNFSpGJ0fxhUj+dcmp+fTwJEgJpFZKb2NgP0KWersErep8CT+U7dfd+XHBzbwTjft5LtfJNJ+QmoeX0PyAZ97ZQnLB/TSCLz6XUjcEYqG63WHmJK5m/bML9DuxIkr5uHDuKPJA58hUZSb2SXfm1afvtCKDn+W+g8BuN5O2Y3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945803; c=relaxed/simple;
	bh=JLHDmFKaKbTB4ARx2vInE2idpyoPWR8wTC4I8hHnTzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alzkY5cFIIgHgg6sHbA7n7/io+Yd8awXGFIWiYsbJjU0A34F6/q4N/rlp9dmNUR5nhPLvodMSmZDhwdEHbeCfOy9BXHtmsL90hSkZxoZJqtthS8sRg7hxhMedSVhTDZXYYup680k5q022pnB6mkILCwWUr1o/0I0FRHBucDkeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lZTPdpwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC7AC4CEE3;
	Tue, 29 Apr 2025 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945803;
	bh=JLHDmFKaKbTB4ARx2vInE2idpyoPWR8wTC4I8hHnTzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZTPdpwiJ6bGsbBRbpqU2GEhwDNRqS64SjlesR8LjMMECwlUCG6VU+1qFdJ+aIonT
	 GGzU4AirLn1eZVY8V8LoUJAskttz3yYrFUCEBrFTSn/QJXudgFsEPErL+I1/F68j/H
	 YAuGM5IPbTXUiNsBq+LkFV46KY7c8sA2bxkZv7fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 025/311] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
Date: Tue, 29 Apr 2025 18:37:42 +0200
Message-ID: <20250429161122.059704320@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 28e89cdac6482f3c980df3e2e245db7366269124 ]

A spurious TINT interrupt is seen during boot on RZ/G3E SMARC EVK.

A glitch in the edge detection circuit can cause a spurious interrupt.

Clear the status flag after setting the ICU_TSSRk registers, which is
recommended in the hardware manual as a countermeasure.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 5fcc6ed4086cd..21d01ce2da5cf 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -155,6 +155,14 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
 	else
 		tssr &= ~ICU_TSSR_TIEN(tssel_n);
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
-- 
2.39.5




