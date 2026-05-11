Return-Path: <stable+bounces-245218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNDOGPHZAWoDlgEAu9opvQ
	(envelope-from <stable+bounces-245218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:30:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB9050EF27
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18E4E307B013
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FE23EF678;
	Mon, 11 May 2026 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IgDcbviD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yGS1uLQH"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67B3E8C45;
	Mon, 11 May 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506035; cv=none; b=RrnFGpmQxXPCGan9FYfTBa4OrOEiM6Rqj0ya/W346TSIlIUSOFiXayVNPdGFkiABm8NBik9tTqPEjS5F+2pQMz8iYJC4aAyTzoIzrpmDl6iDOfeWf654giJMC2vzM6D6cjO3w0sOU//gU6W6Cf0XKuaq+jfIlY7PBvm5u9Z8Ulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506035; c=relaxed/simple;
	bh=3Cwum0lBoz14z3P7midJvSsblR08STN29yC/YMHadh0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j9uLk+VOJ8y3NA67ygz/IPwS50nPJ2w+luZyJzegialKT7MmeyGfo1tZIEufO/BHYbi49DyJC41FvR0bekHAgXbv1x9BB+OcMv7XUIu7oNXXAQ1F4BPNA9SMs+HJ/tmMVNgsGQ5qXRD3PteyL5qdR+MOskH6byv2JA8wapSBt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IgDcbviD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yGS1uLQH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 May 2026 13:27:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778506032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe2BxXPqRRwQl5/B1vo91KQ2whmxe2NsnpqxnQ//tYE=;
	b=IgDcbviDhz9zju+muGgTtD9/xiBSmFfjo4UNdleSMu+a8SfiRhOY9uz58CSnOWlJChgX9q
	X7RAUKUJ5ALhGK7OY69+sl5Ayo2WdNBru17e3pj98YBkI5eaKRbtQSjODeF4utHbmeAppL
	MJj6WdcNEptPt8Bb/ri4jERIh3vxFrEEHnTw72pXt88N0zvOfp0qSibIxL297of6iZfzF5
	/e/piG1wAhv5C9WQT0D+yXQSGbfrSPmef9t2u5Una/mFO9HgHmxfV8MwlStOGn/HBRlrFw
	uiQt9Cc9MGC2s6BSjiilHKUj9WvRqlrdmuUbC2ZEL6jII1+AZAoAXXLg/8KvFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778506032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe2BxXPqRRwQl5/B1vo91KQ2whmxe2NsnpqxnQ//tYE=;
	b=yGS1uLQHGXN7/BNIR7GpugTpswSrZ9md2RhLeu71FAoUXrXKI/RQaz1dCEWG13T76nRPvI
	mnTWvnOoR3g3S4Cg==
From: "tip-bot2 for Xianwei Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/meson-gpio: Use the correct register in
 meson_s4_gpio_irq_set_type()
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20260508-a9-gpio-irqchip-v1-1-9dc5f3e022e0@amlogic.com>
References: <20260508-a9-gpio-irqchip-v1-1-9dc5f3e022e0@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177850603085.188840.16766121443597222599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CCB9050EF27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245218-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amlogic.com:email]
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     5363b67ac8ebcc3e227dbf59fc8061949109841d
Gitweb:        https://git.kernel.org/tip/5363b67ac8ebcc3e227dbf59fc806194910=
9841d
Author:        Xianwei Zhao <xianwei.zhao@amlogic.com>
AuthorDate:    Fri, 08 May 2026 07:36:54=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 11 May 2026 15:22:48 +02:00

irqchip/meson-gpio: Use the correct register in meson_s4_gpio_irq_set_type()

meson_s4_gpio_irq_set_type() uses the both-edge trigger register for
configuring level type and single edge mode interrupts, which is not
correct.

Use REG_EDGE_POL instead.

Fixes: bbd6fcc76b39 ("irqchip: Add support for Amlogic A4 and A5 SoCs")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260508-a9-gpio-irqchip-v1-1-9dc5f3e022e0@aml=
ogic.com
---
 drivers/irqchip/irq-meson-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index f722e9c..74a376e 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -415,8 +415,7 @@ static int meson_s4_gpio_irq_set_type(struct meson_gpio_i=
rq_controller *ctl,
 	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
 		val |=3D BIT(ctl->params->edge_single_offset + idx);
=20
-	meson_gpio_irq_update_bits(ctl, params->edge_pol_reg,
-				   BIT(idx) | BIT(12 + idx), val);
+	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL, BIT(idx) | BIT(12 + idx), val=
);
 	return 0;
 };
=20

