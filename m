Return-Path: <stable+bounces-236321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBOcNe4X3WnNZwkAu9opvQ
	(envelope-from <stable+bounces-236321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:21:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 691E13EEAE4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355DA3032045
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FBD280CFB;
	Mon, 13 Apr 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sJb8YmCG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJJ0qtp0"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF026ED41;
	Mon, 13 Apr 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096605; cv=none; b=p4Tmzl6UQzpG9K26X/eYIbMDJGnlu0yCjvzFAe8XLRLvdty32QET7ZBu4Xj5Y9GqyZTGIWxKJ9W5kEVovvm/W3UEbjTnXMCPsGXlygtjb2/jYI7xlyD9YAS2uqJn8Gz45YcTqzZcYauZfph00NiPr/09MTrtSelM9tVF/cdUz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096605; c=relaxed/simple;
	bh=MpNuHHmEW8u9lXAAmJWPvw1Qu4qAV+xdm0XIAO2nDqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzVef2GFQ6wT2CjQxnX91UrJjmlC71NHZ+Jyey1MNZHK1dJy/bun5ApQ6hOG91nKI69uSAs/EtEsvnYvcqWPaiRr9lOFa0yEF8/+xg8IQFrs+4FazYz9m8JLm6LvvhtA/iYiAXElg9e1iFkJLMcxTPGdBqFPuXnkYHt2vF+dZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sJb8YmCG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vJJ0qtp0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Apr 2026 18:10:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776096602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpNuHHmEW8u9lXAAmJWPvw1Qu4qAV+xdm0XIAO2nDqc=;
	b=sJb8YmCGjpKzxzpPekzJP5qcI2ZWQ8/6bp5VAjNawZyK1AZFznaApWoFkOnF9uZegme8og
	6KuNTsEYdDcW41mYX2WVKeVKY/SHGe2laYJt6PXwVZHXFELyj+zWYldOYqBwBwvJ2QYi/t
	nE6c8kkAeMrrS1SQr3X2+X67b/e2b1KyXTu6UNPYB2p/EePPs8tTUYYkyo78uQXiQc1SXr
	hH11Nentj5/9dyx2eiuxM4YpRmOm2Q1JO6IX6HQhS4yS59MSTDntVp6KQ0FQP1/x6OXmHo
	pp7+UWSpd4JNNglqecHXvRkOZq8PBCNQ2yJwPvRHFc6mD1awIcpCxAjgskhVcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776096602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpNuHHmEW8u9lXAAmJWPvw1Qu4qAV+xdm0XIAO2nDqc=;
	b=vJJ0qtp0NdmsJTRjjT94hsq4mm06ij1NFxdxOqJAUNhVq6QJbfsksC64qc1EaNM5sXPMCy
	bjkcYczR0RJjjGAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
Message-ID: <20260413161000.P_SLxmZl@linutronix.de>
References: <20260408162535.98108-1-marex@nabladev.com>
 <20260412090141.21bf1534@kernel.org>
 <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
 <20260412105125.48f0c58f@kernel.org>
 <20260413125744.TVKkZcEK@linutronix.de>
 <20260413084445.59fe28d6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260413084445.59fe28d6@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-236321-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nabladev.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 691E13EEAE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-13 08:44:45 [-0700], Jakub Kicinski wrote:
> On Mon, 13 Apr 2026 14:57:44 +0200 Sebastian Andrzej Siewior wrote:
> > On 2026-04-12 10:51:25 [-0700], Jakub Kicinski wrote:
> > > > Does the backtrace make the problem clearer, with the annotation ab=
ove ? =20
> > >=20
> > > Sebastian, do you have any recommendation here? tl;dr is that the dri=
ver does =20
> > =E2=80=A6
> >=20
> > What about this:
>=20
> Thanks for taking a look (according to you auto-reply immediately after
> a vacation ;))

;)

> TBH changing the driver feels like a workaround / invitation for a
> whack-a-mole game. I'd prefer to fix the skb allocation.

The problem is that _irq() implicitly disables bh processing but this
does not happen. Forcing this is possible but expensive.
However, I did remove lock from bh_disable() on RT.

Marek: from which kernel version was this backtrace?

> Is there any way we can check if any locks which were _irq() on non-RT
> are held?

lockdep has a list of locks which are acquired but it does not see if it
is _irq() or not. It only records it was acquired.

Sebastian

