Return-Path: <stable+bounces-210196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A44D393B0
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 10:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AA05300E822
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907972D7DDE;
	Sun, 18 Jan 2026 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jumOWU0A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/GXYnEyf"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0778F39;
	Sun, 18 Jan 2026 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730212; cv=none; b=Jp75NCWEUssqqx/pt6+gwcFlSOnR55Z14+/zc8vEGgoByw/7sWUetU0A1ZtZdTX71ht7RSgr0BvayPyjN9YCOXVxmyw7SFS9FEMfD9AmZGh7tnyXKBxkwBgh3z0numEjrVwfTbW8sZF8Th+rEB9AWBZbMB5IIeNTbRR9s+Dtko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730212; c=relaxed/simple;
	bh=g4pcrIQw8MBL/jx9lliGiCVN8RnKZyJatFGhRm5KP/o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ledFAzvQOGeCeZnu+hge3CYnrMzRA5VL44DV931m7dpx2TqNcrRSjO64Nqo4dU4PD/TlPUzYV0D7uOyKxqKl6VSkic2duwazDNyfDlm4zNiFPvId9iqd4OP/qMFSufE7Cuwa1fppqJb/9NHlVvvc240xYi9AKa1iXANcy6T4vGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jumOWU0A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/GXYnEyf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 09:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MQ50OMX8wQ2R4Q1gph2RgNgtvOMyS9nmfK6ibCKLlg=;
	b=jumOWU0AGy1+PhMvUeY/8OOFenH9uExLXvsNh/NfRjrV08UjVek7w/QsygIxIaQyEfoKpT
	IfXYURvYF0Q0Pq2NfflnFInnywHWADGPHeaYFM1fjDhIANvV98zG+CBnpgMvz/+wrZfSW5
	jMgdBuMGox4tbFjek5lwP1V699HlLvboPWk6hraIVYeYudtMdQbvGLOIDS7JGRbuYP/kXO
	JFWhiDaWLh4l3T9ZVnk+ifbZZZt3RClNx04AegkGGYc4BZzHWsVuyHLxp1xYDT2qsTI0/S
	7yV2IFEF7S8zYQD/uWW8lTdBgeM7Q8ZX44mPF/hO9B90Onazkv10L3zqXUUH5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MQ50OMX8wQ2R4Q1gph2RgNgtvOMyS9nmfK6ibCKLlg=;
	b=/GXYnEyfyH7aJNGUvWVOg/4ayNWXfeVwP495WP6lv+kcZ8iKoQ90D5RU3ffraksvXizJNA
	7vPUkux8e3wINnDQ==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/renesas-rzv2h: Prevent TINT spurious
 interrupt during resume
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20260113125315.359967-2-biju.das.jz@bp.renesas.com>
References: <20260113125315.359967-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873020720.510.6699826719647183208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     cd4a3ced4d1cdb14ffe905657b98a91e9d239dfb
Gitweb:        https://git.kernel.org/tip/cd4a3ced4d1cdb14ffe905657b98a91e9d2=
39dfb
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 13 Jan 2026 12:53:11=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 10:55:34 +01:00

irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume

A glitch in the edge detection circuit can cause a spurious interrupt. The
hardware manual recommends clearing the status flag after setting the
ICU_TSSRk register as a countermeasure.

Currently, a spurious interrupt is generated on the resume path of s2idle
for the PMIC RTC TINT interrupt due to a glitch related to unnecessary
enabling/disabling of the TINT enable bit.

Fix this issue by not setting TSSR(TINT Source) and TITSR(TINT Detection
Method Selection) registers if the values are the same as those set
in these registers.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) dri=
ver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260113125315.359967-2-biju.das.jz@bp.renesas=
.com
---
 drivers/irqchip/irq-renesas-rzv2h.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesa=
s-rzv2h.c
index 899a423..9b48712 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -328,6 +328,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsign=
ed int type)
 	u32 titsr, titsr_k, titsel_n, tien;
 	struct rzv2h_icu_priv *priv;
 	u32 tssr, tssr_k, tssel_n;
+	u32 titsr_cur, tssr_cur;
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
@@ -376,12 +377,18 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsi=
gned int type)
 	guard(raw_spinlock)(&priv->lock);
=20
 	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
+	titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k=
));
+
+	tssr_cur =3D field_get(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width=
), tssr);
+	titsr_cur =3D field_get(ICU_TITSR_TITSEL_MASK(titsel_n), titsr);
+	if (tssr_cur =3D=3D tint && titsr_cur =3D=3D sense)
+		return 0;
+
 	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
 	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
=20
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
=20
-	titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k=
));
 	titsr &=3D ~ICU_TITSR_TITSEL_MASK(titsel_n);
 	titsr |=3D ICU_TITSR_TITSEL_PREP(sense, titsel_n);
=20

