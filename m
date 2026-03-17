Return-Path: <stable+bounces-226114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP9zHF15uWnQGQIAu9opvQ
	(envelope-from <stable+bounces-226114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:55:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 104082AD5C8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EDF33096EF2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE282D593E;
	Tue, 17 Mar 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FAivhwB7"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7025A357;
	Tue, 17 Mar 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762860; cv=none; b=sTzbYvho1uuhy+0dsjn678y5Ra7mbh94T5QuoRfFRK3RxxLHwQVOM2PFNLZZTHVl7fUswj2gzuSEOyvT6dzTaGLwoOV1wUHgbJG7tKEbTcsBuUBoVLeA31qcX0VN2EqkljRUHbFrF3SNQiEluKtoVbU+j8YIiR2x1WJdtgt66Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762860; c=relaxed/simple;
	bh=vN4NuxCBZEg/bI6gchM7Bz4HW03ulxQ1D/xDEu+0pJI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Jbh08s9f7ey5Uo+GFu1j/GOyvqT/qUUcyJFJfsOnUWTteCaEcLaew5/RC/g77ApDDM5yxSAcMQ3/8PkncICKUjQG1fWKPukEDytwZNnXTvmRmeIAUEo4gbbuqiBKa4kUYf4JUmBKq/MHwTIJvP97xkAnDN5MBKZAdAfu4aBgY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FAivhwB7; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3A98AC5505C;
	Tue, 17 Mar 2026 15:54:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 12F8E5FC9A;
	Tue, 17 Mar 2026 15:54:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4516810450603;
	Tue, 17 Mar 2026 16:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773762855; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wAAFsw9+mOysfWshLYmHn54unYKmwP5cY39tuEvZ5D4=;
	b=FAivhwB79j8oCmzCTE0w2lzaadllX7KjcG/oSVWqAauImbnQQ5zvERXtKIfrYRceHZZ8Jl
	DWe0uv+0qO4ZiKm5GQMPz/nw7k9tpXajes+OoXOhQFXGiBHMw8arx3nV9OBOYPlwsf5uGF
	i3+s2Et7OE2uJFrkKhTT/1pKD2vudMXqgHx6IJxF6DAxLwEy9a+QQI7EL/4LG82rp0TBkH
	AB4/0gpmTkKk3K9FQBifpWo0Xik8KxSGX3DF/VW9n3QwgnDJ8yhMCrpKIe0p8ouWDfa6Vp
	0wA6Z/qjqQGeWishMa1PqSLohGtEnBMrEnDOaoLG54nf85ZIKsdXJGY5vUijHA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 16:54:11 +0100
Message-Id: <DH56GCWA9O1K.1KYOVK5RL00JC@bootlin.com>
Subject: Re: [PATCH net 2/2] net: macb: Protect access to net_device::in_ptr
 with RCU lock
Cc: <netdev@vger.kernel.org>, "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Vineeth Karumanchi"
 <vineeth.karumanchi@amd.com>, "Harini Katakam" <harini.katakam@amd.com>,
 <stable@vger.kernel.org>
To: "Kevin Hao" <haokexin@gmail.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
 <20260315-macb-irq-v1-2-0154104cbf61@gmail.com>
 <DH4EHTJNY6GL.3EXTP61HNUNDD@bootlin.com> <abit7VLwoy2ttEus@pek-khao-d3>
In-Reply-To: <abit7VLwoy2ttEus@pek-khao-d3>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226114-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid,bootlin.com:url]
X-Rspamd-Queue-Id: 104082AD5C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 17, 2026 at 2:27 AM CET, Kevin Hao wrote:
> On Mon, Mar 16, 2026 at 06:59:35PM +0100, Th=C3=A9o Lebrun wrote:
>> On Sun Mar 15, 2026 at 12:44 PM CET, Kevin Hao wrote:
>> > @@ -5915,13 +5915,16 @@ static int __maybe_unused macb_suspend(struct =
device *dev)
>> > =20
>> >  	if (bp->wol & MACB_WOL_ENABLED) {
>> >  		/* Check for IP address in WOL ARP mode */
>> > +		rcu_read_lock();
>> >  		idev =3D __in_dev_get_rcu(bp->dev);
>> >  		if (idev)
>> >  			ifa =3D rcu_dereference(idev->ifa_list);
>> >  		if ((bp->wolopts & WAKE_ARP) && !ifa) {
>> >  			netdev_err(netdev, "IP address not assigned as required by WoL wal=
k ARP\n");
>> > +			rcu_read_unlock();
>> >  			return -EOPNOTSUPP;
>> >  		}
>> > +
>> >  		spin_lock_irqsave(&bp->lock, flags);
>> > =20
>> >  		/* Disable Tx and Rx engines before  disabling the queues,
>> > @@ -5963,6 +5966,7 @@ static int __maybe_unused macb_suspend(struct de=
vice *dev)
>> >  			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
>> >  		}
>> >  		spin_unlock_irqrestore(&bp->lock, flags);
>> > +		rcu_read_unlock();
>> > =20
>> >  		/* Change interrupt handler and
>> >  		 * Enable WoL IRQ on queue 0
>>=20
>> Instead of making the RCU critical section extend so much, you could
>> dereference ifa->ifa_local into a stack variable. In particular, it
>> would avoid the RCU critical section covering a spinlock critical
>> section.
>
> I initially considered using a local variable before submitting this, as =
I also
> believe that `ifa->ifa_local` is unlikely to be modified or freed in this
> context. However, I ultimately decided to protect these sections with RCU=
 for
> the following reasons:
>
> - It is logically more consistent to protect access to `ifa->ifa_local` w=
ith
>   RCU locking.
>
> - For section already under spinlock protection, adding RCU locking intro=
duces
>   negligible overhead, especially in a scenario like this.
>
> That said, I do not have a strong preference for either approach. If you =
prefer
> using a local variable to keep the RCU region shorter, I can prepare a v2=
 with
> that change.

I was not questioning whether this region should be protected, but
rather how long you made the RCU critical section. The smaller the
better, especially if you can remove a spinlock from it.

On PREEMPT_RT kernels it could even cause trouble because spinlocks
become sleep-able and that is not allowed inside RCU read-side critical
section.

So yes, I do insist that a tiny RCU is better; something like:

static int macb_suspend(struct device *dev)
{
	u32 ifa_local;

	// ...

	if (bp->wol & MACB_WOL_ENABLED) {
		/* Check for IP address in WOL ARP mode */
		rcu_read_lock();
		idev =3D __in_dev_get_rcu(bp->dev);
		if (idev)
			ifa =3D rcu_dereference(idev->ifa_list);
		if (ifa)
			ifa_local =3D be32_to_cpu(ifa->ifa_local);
		rcu_read_unlock();

		if ((bp->wolopts & WAKE_ARP) && !ifa) {
			netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\=
n");
			return -EOPNOTSUPP;
		}

		// ...
	}

	// ...
}

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


