Return-Path: <stable+bounces-236078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOdMBUnp3GmUYAkAu9opvQ
	(envelope-from <stable+bounces-236078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:02:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F63EC4FB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D6D0304DCBC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F483CA490;
	Mon, 13 Apr 2026 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JBg8Qy6y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bRK3igYk"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AAD3A168F;
	Mon, 13 Apr 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085071; cv=none; b=QcNqp+6lDON5kTZnSARRfSk72bfi2yV/P7AkU+9o3Z9L0VE17SHW25A7jPird+ZP2dtRNWlDO5QyTg/HneuMNgdqP98MIk3rylaNYWml5xeXg1AFJZZs91pUQF83jwo2M1LH+SSxmaYA80NGgQoij+y/EK1dBQ27fL74+gSuMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085071; c=relaxed/simple;
	bh=D0uC3RC5O6zNthbjcHpQNe+gRBU+aQxNET16X2ew49U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwMBmPXE/HQ4UEDzvkSWIHFV5bCDVZL+4T+5fMIw6Cqn4PtOptrz4Qoa52hDJ/5IcTnzNhxMxbCcM8NSnQy9FJHhU0khmhrpJgG7LvSf9qrgIgxBz/nhYgIq0QltCO2mV2h+CEVE3Y4o+QZLbJJibl5py8MkMhCNqQJV5gxM23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JBg8Qy6y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bRK3igYk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Apr 2026 14:57:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776085066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUTB7MWkI9XWZ7FUtzXqjzpIN4EwcG3IV7eTCDJB410=;
	b=JBg8Qy6yrF6Hk/uj3ZFJC4iNEDKwE+5sPIVYvxq4xYHtV4PwqmWLPSnP1vF5yZByRJ7H8G
	XWWd8+aa1MNhllB4zjEPJegEF32SIY3JgKIRCYw8ls4CM8fHIC+lDdA/rIRoVAfWBK3KEZ
	SwNOAzrOmnTqhuM/96pwIZ014UB7KL9Znc0K8fL1uO4HjoZOKHPgjU5MRwHkVeE8w0cVrt
	FL7ByitX8MbyLMex8taFh+6/hwOHe9ukntAk5QqUljAD/MmyjFurbhiERJPQ53FW8o3WWd
	46y1ffrdPW6dioeN1BeyFzf7PyKtfQrQ/jqwWOc2LOfgP1h401+VNaNnYmdlBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776085066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUTB7MWkI9XWZ7FUtzXqjzpIN4EwcG3IV7eTCDJB410=;
	b=bRK3igYkjtb1pneyNhfBQJFjrkJvjFXnIz2MeDpI0IFJSpQbbsHu8IAWzOZ2rEWbZR5IN2
	vLYoaVUZwin7JGCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>, Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
Message-ID: <20260413125744.TVKkZcEK@linutronix.de>
References: <20260408162535.98108-1-marex@nabladev.com>
 <20260412090141.21bf1534@kernel.org>
 <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
 <20260412105125.48f0c58f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260412105125.48f0c58f@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236078-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 676F63EC4FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-12 10:51:25 [-0700], Jakub Kicinski wrote:
> > Does the backtrace make the problem clearer, with the annotation above ?
>=20
> Sebastian, do you have any recommendation here? tl;dr is that the driver =
does
=E2=80=A6

What about this:

--- a/drivers/net/ethernet/micrel/ks8851_par.c
+++ b/drivers/net/ethernet/micrel/ks8851_par.c
@@ -63,7 +63,7 @@ static void ks8851_lock_par(struct ks8851_net *ks, unsign=
ed long *flags)
 {
 	struct ks8851_net_par *ksp =3D to_ks8851_par(ks);
=20
-	spin_lock_irqsave(&ksp->lock, *flags);
+	spin_lock_bh(&ksp->lock);
 }
=20
 /**
@@ -77,7 +77,7 @@ static void ks8851_unlock_par(struct ks8851_net *ks, unsi=
gned long *flags)
 {
 	struct ks8851_net_par *ksp =3D to_ks8851_par(ks);
=20
-	spin_unlock_irqrestore(&ksp->lock, *flags);
+	spin_unlock_bh(&ksp->lock);
 }
=20
 /**


I don't see why it needs to disable interrupts. This seems to be used by
the _par driver and the _common part. The comments refer to DMA but I
see only FIFO access.

And while at it, I would recommend to

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethe=
rnet/micrel/ks8851_common.c
index 8048770958d60..f1c662887646c 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -378,9 +378,12 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
=20
-	if (status & IRQ_RXI)
+	if (status & IRQ_RXI) {
+		local_bh_disable();
 		while ((skb =3D __skb_dequeue(&rxq)))
 			netif_rx(skb);
+		local_bh_enable();
+	}
=20
 	return IRQ_HANDLED;
 }

Because otherwise it will kick-off backlog NAPI after every packet if
multiple packets are available.

Sebastian

