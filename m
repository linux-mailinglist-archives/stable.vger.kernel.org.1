Return-Path: <stable+bounces-119656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00207A45C8A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 12:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AD73ABFE3
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68738217F5C;
	Wed, 26 Feb 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCAZLL5N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdAshiKD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B96215182;
	Wed, 26 Feb 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567846; cv=none; b=MXs/4tnYbscIZwsUw9wljUaYVzY7H/qyPq7kVEa6mzyhnmtKxREAwBvf9QCBFgRpUT8lrbWGDHYY2yvdlYBJ2lXtF5kM2jcmoWo5nrVhr+HKTDNai69YuvrbzKRaHDICyBkgSfhgJdjZ2BuRjEH2kRNSHz2Mi6jgiIuedojyARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567846; c=relaxed/simple;
	bh=zuYrg4E4BlhaoX0PKHydxZDiSBMtIJBgx3YqE+XFGUM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E5g+mmgoewoxK4TKWCWwHKSTctsJc/lw1JHtpIlX5i8a5r4VN0uNJrJIWfdVa/YVlmrq5inaFAiug+1pMpiVJguWQFCADYkzNrtlpZbfkIkgw7UBAR8ubWRC4s6S76LUc0GG2b2pOuQsUI1/dNRGJvfG6KPu1cpIavYylctUMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCAZLL5N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RdAshiKD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QElXmYTq2r8LqrMwkRyrZKl2yKkMcZ6a/EqFy31ulQU=;
	b=rCAZLL5NJsVs0aj/lF6bILY+2W62FHk3pAKTM5OcGjLE6ersKOAnfQ55pvfzz9yOw2/ld5
	iN7F8AbpX4FKuCiToSMyU2D4mS7DyHu0IWiCKa9y3VATXnfJfKjthKWV8ItloZMs1SXRe3
	CtvB700bcQFwJ0bz9uK69A036D7MAdH4VX24ursdoJkmlKpvq7YhEkYpmX7FpUWEtInNY9
	w7tRYsLfI9637RLyRb1muYyZFK679ePdVtzHmg3fOGR4O9wgfEShP55u/0dphMEFXc48xk
	CwYYUjaGQ7jV4D/dwnAqtOBuFmsgjwBXrnopgrXmI+t98imIMyQCu+AdGtyUDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QElXmYTq2r8LqrMwkRyrZKl2yKkMcZ6a/EqFy31ulQU=;
	b=RdAshiKDBLmiYqRr/T/jY2uR8eDn5cHgAaqft++pXxDILcECF225WEK6ars1Dnu7+wYVm6
	zqcfkGb9ojB3GPBw==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Fix wrong variable usage in
 rzv2h_tint_set_type()
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Biju Das <biju.das.jz@bp.renesas.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-3-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056784235.10177.6372519878853772273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     72310650788ad3d3afe3810735656dd291fea885
Gitweb:        https://git.kernel.org/tip/72310650788ad3d3afe3810735656dd291fea885
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:18 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:49 +01:00

irqchip/renesas-rzv2h: Fix wrong variable usage in rzv2h_tint_set_type()

The variable tssel_n is used for selecting TINT source and titsel_n for
setting the interrupt type. The variable titsel_n is wrongly used for
enabling the TINT interrupt in rzv2h_tint_set_type(). Fix this issue by
using the correct variable tssel_n.

While at it, move the tien variable assignment near to tssr.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250224131253.134199-3-biju.das.jz@bp.renesas.com
Closes: https://lore.kernel.org/CAMuHMdU3xJpz-jh=j7t4JreBat2of2ksP_OR3+nKAoZBr4pSxg@mail.gmail.com
---
 drivers/irqchip/irq-renesas-rzv2h.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index fe2d29e..f636324 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -301,10 +301,10 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 
 	tssr_k = ICU_TSSR_K(tint_nr);
 	tssel_n = ICU_TSSR_TSSEL_N(tint_nr);
+	tien = ICU_TSSR_TIEN(tssel_n);
 
 	titsr_k = ICU_TITSR_K(tint_nr);
 	titsel_n = ICU_TITSR_TITSEL_N(tint_nr);
-	tien = ICU_TSSR_TIEN(titsel_n);
 
 	guard(raw_spinlock)(&priv->lock);
 

