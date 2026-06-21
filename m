Return-Path: <stable+bounces-267538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2yI6MAPhN2p2VAcAu9opvQ
	(envelope-from <stable+bounces-267538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:02:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5784E6AACD1
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:02:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=UxuYcqd5;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=vzwKj+Q5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267538-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267538-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD6B3019838
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82A366DA3;
	Sun, 21 Jun 2026 13:02:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3667364EB8;
	Sun, 21 Jun 2026 13:02:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046949; cv=none; b=sNesccGaMjhTtKGVhl0Jr7XxJBX9FBWeI8JgCImNuROhUineX1LyyX6+VKZicAo0Yc1AWs7l+jdzWYOlyTXRkF9R3A5wBY6VOz8Dc1QjzVaGrN59HXrdE7vAxlHRVH8lBcgsVJBJ2e7fFaRfqBh7IpdPUEfqrUHmRXBaJ72HaB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046949; c=relaxed/simple;
	bh=VePZLxrmJ7ngnEKO77FKMoaSqYDBpwC4nOAQd/C+Z4A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mh9sNJ24hDyMnwAeDjIZlDsfRRt3sI9lQvEgAzl83CLqlXXBoJyX5ZmUjaYBaetU1kxGvqtF0WMd1AgUuZLqb5p/yD8P0z2g/+y1sxaO6e+oMNXK35ss3i2Qp7r3zlB7CbrMw4OY2DDe3k50sJ+PixXiUJh46lM4cAQIy6C5BPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UxuYcqd5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzwKj+Q5; arc=none smtp.client-ip=193.142.43.55
Date: Sun, 21 Jun 2026 13:02:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782046946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYib6aacoTMLOl8UdQTaiTphv58BSgPMFBcYQDrPD2s=;
	b=UxuYcqd5+gGJkbsvRrfEVXqd3K7ZM2/6hltA1vAcYoIXW18vxQr30JMNrt+2gIi+/rDzYd
	tkeNZbg32T4qOBOdukf668n+cvyY/N0riPC1FwK2mErxB5c72cirJJkZx2jHwYEdAsnIcb
	WtlWbfJrBSzYgGzhW53a2Mkres6JFwleJtQSjaFtgDvbC97JhsnPP4w8HVHvWJUD81L8MY
	9JWOnW4koKc+F3yZDSUid2C3tYfi94K4lDmG03edPsjfwyjiKwktPd9Z/PZBlPpw6zhQZj
	cFcB/DihZrtDAwvgu0Pmr+hQ3EDQQYjUuOwOWAiH0mgNvQ75fvzR72+eLzq43A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782046946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYib6aacoTMLOl8UdQTaiTphv58BSgPMFBcYQDrPD2s=;
	b=vzwKj+Q5UBvZcufUijl2fzFFxxVYTtzIpH/pnVxlBwSwllF+Trl9BHv86l8HmLMiHJ7G9W
	EsbbU4ELJYAKs9BA==
From: "tip-bot2 for Bhargav Joshi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/crossbar: Use correct index in
 crossbar_domain_free()
Cc: Bhargav Joshi <j.bhargav.u@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20260620-irq-crossbar-fix-v2-1-b8e8499f468a@gmail.com>
References: <20260620-irq-crossbar-fix-v2-1-b8e8499f468a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178204694487.2745857.1186942294359401850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-tip-commits@vger.kernel.org,m:j.bhargav.u@gmail.com,m:tglx@kernel.org,m:stable@vger.kernel.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:maz@kernel.org,m:jbhargavu@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267538-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linutronix.de:dkim,linutronix.de:from_mime,tip-bot2:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5784E6AACD1

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     043db005a8d6932dc7d217c86307e9af0bc10ddc
Gitweb:        https://git.kernel.org/tip/043db005a8d6932dc7d217c86307e9af0bc=
10ddc
Author:        Bhargav Joshi <j.bhargav.u@gmail.com>
AuthorDate:    Sat, 20 Jun 2026 17:39:16 +05:30
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 21 Jun 2026 14:59:20 +02:00

irqchip/crossbar: Use correct index in crossbar_domain_free()

crossbar_domain_free() resets the domain data and then uses the nulled
out irq_data->hwirq member as index to reset the irq_map[] entry and to
write the relevant crossbar register with a safe entry. That means it
never frees the correct index and keeps the crossbar register connection
to the source interrupt active.

If it would not reset the domain data, then this would be even worse as
irq_data->hwirq holds the source interrupt number, but both the map and
register index need the corresponding GIC SPI number and not the source
interrupt number. This might even result in an out of bounds access as
the source interrupt number can be higher than the maximal index space.

Fix this by using the GIC SPI index from the parent domain's irq_data.

Fixes: 783d31863fb82 ("irqchip: crossbar: Convert dra7 crossbar to stacked do=
mains")
Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260620-irq-crossbar-fix-v2-1-b8e8499f468a@gm=
ail.com
---
 drivers/irqchip/irq-crossbar.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index cd11341..4e19e9d 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -158,9 +158,14 @@ static void crossbar_domain_free(struct irq_domain *doma=
in, unsigned int virq,
 	for (i =3D 0; i < nr_irqs; i++) {
 		struct irq_data *d =3D irq_domain_get_irq_data(domain, virq + i);
=20
+		/*
+		 * irq_map[] is indexed by GIC SPI number. The parent domain's
+		 * hwirq contains the GIC interrupt number (GIC SPI +
+		 * GIC_IRQ_START).
+		 */
+		cb->irq_map[d->parent_data->hwirq - GIC_IRQ_START] =3D IRQ_FREE;
+		cb->write(d->parent_data->hwirq - GIC_IRQ_START, cb->safe_map);
 		irq_domain_reset_irq_data(d);
-		cb->irq_map[d->hwirq] =3D IRQ_FREE;
-		cb->write(d->hwirq, cb->safe_map);
 	}
 	raw_spin_unlock(&cb->lock);
 }

