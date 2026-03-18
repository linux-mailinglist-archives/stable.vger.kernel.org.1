Return-Path: <stable+bounces-226967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDE8JrhGumlTTgIAu9opvQ
	(envelope-from <stable+bounces-226967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:31:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D5D2B665F
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50A653042D5C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6641B3644A2;
	Wed, 18 Mar 2026 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4X87I5d"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88F366DA6
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815473; cv=none; b=YlvL8iCEUH3klD0uHmWwzucOkV2gE9SHNLuMnC1v1uzsw9//kP2sWgxsudtbJsSRLF4CK8XKf7Uh6UmjQOBC6n0RIVy8B08D3/8nKzEjv6hpx7pqM9e79wqSTag8+WR5gmf/xe1SoVL4n+EP9RLak9GsKkbmc2kOCvzE82TTqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815473; c=relaxed/simple;
	bh=F9cHhWJXb3kHOhBeKBznjA0MZ+sKCxw3//7ZAbHZqyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3rwev2Poj4HL+/Alxv3sDANeQiM4b3lkqcjUStRUYj4y2ih9D/xm+hW58c937uUqkBTKoFAMXTtwEUv3iNkhA7FH0+GGIQ0/Lc45krpTTBM1MDHI+7N8sk4ne5qb0VOWWGoj53tZHrbszdLogNk5gMMxrDo0lsyWWwGPQJPiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4X87I5d; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-128d7db88b9so7960666c88.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773815471; x=1774420271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mjfeB+QehGWxy6pvDSqDvx3PHWjcskLwFx02+x66yE=;
        b=d4X87I5d4oZX9BeGt42R5MOijiO2+O8lZMhZJAHzdg+hLb6CAPJLi+x5sSTclaV2rT
         G6tUD/A+kE6oZyDorF6qWelFEdOzFF8/uODylTfharZBioAwalJ+s3GDe58rV6FtTQSC
         edx1mQfuuNyh87f2XaPIK9OapXY0TPFAAW5M0+MKsmrsjKs07SrWiHGgRTx3qrE5qXim
         gCErGPzHH+DGrmOQRZNfMK5wD7VmzFMPmlnyHNVt+tMiq0DLMw9H90W3w/T76uF8Y/pP
         iP4qSSfxuNzMLtXGtH2HerhiMze2cQhS97s0Ax6mETV+Pe7SzZOlqwLEJCqaK+5Ob8jB
         k5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815471; x=1774420271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mjfeB+QehGWxy6pvDSqDvx3PHWjcskLwFx02+x66yE=;
        b=N0QLTDz62CyAv7oxB/KiuG3rJO41brhb8PuPVTj2YjUlRcJKZ59yw/x1/ROgCzcVfY
         8NQSRDcoAiUa8N+K2xFGALP+6tSJbeFoaoQCLtdZRIsrJXKTFfwSUCs7od0HFmROWp4z
         B7M40jVZKm8kLqgH29OoaNIJTnNi62aZFbkCBznkF0T0lzEK1aRiGVlvVwzCWbkBl+na
         Ck/Y7UwCHBdHxnnqmgPjv3HIOfb4MS0B5xixmLumyJCwVR7ANRdEy2Fc/07/XadVKkrL
         nR9HIV4gF8Td0wC4IcJv7vqVAyQIqTKPprf0s9XnJweeG/I/ZX4VQ+unAOj+OlTlvZfZ
         BrDA==
X-Forwarded-Encrypted: i=1; AJvYcCXhDXmn5QqhiC7AC+n8AMPG6nspejoVaqv3lFNkG5wvS8AW1NOx3YEJ3VdrbPdpb6mM0/JpWjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfu2RxOsW6izB3ULpbzFDqFHJLGsOGk5o33kgEpfUvkhOsK2tr
	R4RVH89KxiV6pNmhlWzhaI6giCikmTnQ+7RzLCHrz/LzpqO06BD5VXk6
X-Gm-Gg: ATEYQzz9WKZ4klrj6NAC0b6GoNsF1AET+FNqdP0kiePYSzGtpaS6TRa129PewGb/+nM
	tgby8uTcE7rGKyy+yqvCfcQWpTgvmvlBQ0Eo1AXx7+FIcflkOvon4Oh6g6UJ+ZQqbsi+0BmShtM
	Mlh7NzdfI+fPiyQ4IJ1ygoISz0uXTWdSA4KVN/KTiOpLQZ0nqlW2YFvzpZfukcEuzN6CK3rqM99
	/nSWnVx+S2vulOgjt2eRk+RY/R2WucRis8cKcR7R4TVac7YTXo1epZn+AXuVpzkOjzaA+ClXTIH
	rnq0P5Ze+hNSrjyw6VID2N4/hc4PDz2ABct/4smR1G514G23q63hprE3NpZt7+2EUQx3iAzkobr
	gcBhCBZU1w4IJPA6D+6pzox4MSEuzKuctnoIQTy6Sh8gPXupB5ff23KE/po0KBSt4yY7lx49sGk
	4BQAatHZKJ3Co2HlADVUY=
X-Received: by 2002:a05:7022:51b:b0:128:d4be:7418 with SMTP id a92af1059eb24-129a714bc7bmr1050843c88.35.1773815470580;
        Tue, 17 Mar 2026 23:31:10 -0700 (PDT)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129a723f9d7sm2347316c88.2.2026.03.17.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:31:09 -0700 (PDT)
Date: Wed, 18 Mar 2026 14:31:03 +0800
From: Kevin Hao <haokexin@gmail.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Harini Katakam <harini.katakam@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: macb: Protect access to net_device::in_ptr
 with RCU lock
Message-ID: <abpGpxaFECLpGMzz@pek-khao-d3>
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
 <20260315-macb-irq-v1-2-0154104cbf61@gmail.com>
 <DH4EHTJNY6GL.3EXTP61HNUNDD@bootlin.com>
 <abit7VLwoy2ttEus@pek-khao-d3>
 <DH56GCWA9O1K.1KYOVK5RL00JC@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EH2RervoWIbhLwfW"
Content-Disposition: inline
In-Reply-To: <DH56GCWA9O1K.1KYOVK5RL00JC@bootlin.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226967-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 05D5D2B665F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--EH2RervoWIbhLwfW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 04:54:11PM +0100, Th=E9o Lebrun wrote:
> On Tue Mar 17, 2026 at 2:27 AM CET, Kevin Hao wrote:
> > On Mon, Mar 16, 2026 at 06:59:35PM +0100, Th=E9o Lebrun wrote:
> >> On Sun Mar 15, 2026 at 12:44 PM CET, Kevin Hao wrote:
> >> > @@ -5915,13 +5915,16 @@ static int __maybe_unused macb_suspend(struc=
t device *dev)
> >> > =20
> >> >  	if (bp->wol & MACB_WOL_ENABLED) {
> >> >  		/* Check for IP address in WOL ARP mode */
> >> > +		rcu_read_lock();
> >> >  		idev =3D __in_dev_get_rcu(bp->dev);
> >> >  		if (idev)
> >> >  			ifa =3D rcu_dereference(idev->ifa_list);
> >> >  		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> >> >  			netdev_err(netdev, "IP address not assigned as required by WoL w=
alk ARP\n");
> >> > +			rcu_read_unlock();
> >> >  			return -EOPNOTSUPP;
> >> >  		}
> >> > +
> >> >  		spin_lock_irqsave(&bp->lock, flags);
> >> > =20
> >> >  		/* Disable Tx and Rx engines before  disabling the queues,
> >> > @@ -5963,6 +5966,7 @@ static int __maybe_unused macb_suspend(struct =
device *dev)
> >> >  			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
> >> >  		}
> >> >  		spin_unlock_irqrestore(&bp->lock, flags);
> >> > +		rcu_read_unlock();
> >> > =20
> >> >  		/* Change interrupt handler and
> >> >  		 * Enable WoL IRQ on queue 0
> >>=20
> >> Instead of making the RCU critical section extend so much, you could
> >> dereference ifa->ifa_local into a stack variable. In particular, it
> >> would avoid the RCU critical section covering a spinlock critical
> >> section.
> >
> > I initially considered using a local variable before submitting this, a=
s I also
> > believe that `ifa->ifa_local` is unlikely to be modified or freed in th=
is
> > context. However, I ultimately decided to protect these sections with R=
CU for
> > the following reasons:
> >
> > - It is logically more consistent to protect access to `ifa->ifa_local`=
 with
> >   RCU locking.
> >
> > - For section already under spinlock protection, adding RCU locking int=
roduces
> >   negligible overhead, especially in a scenario like this.
> >
> > That said, I do not have a strong preference for either approach. If yo=
u prefer
> > using a local variable to keep the RCU region shorter, I can prepare a =
v2 with
> > that change.
>=20
> I was not questioning whether this region should be protected, but
> rather how long you made the RCU critical section. The smaller the
> better, especially if you can remove a spinlock from it.
>=20
> On PREEMPT_RT kernels it could even cause trouble because spinlocks
> become sleep-able and that is not allowed inside RCU read-side critical
> section.

I'm a bit confused by this comment. As you know, the ndo_start_xmit() callb=
ack
is executed in a context where the RCU lock is acquired. Many network drive=
rs
use spinlocks in their ndo_start_xmit() callbacks. Am I missing something o=
bvious?

>=20
> So yes, I do insist that a tiny RCU is better; something like:
>=20
> static int macb_suspend(struct device *dev)
> {
> 	u32 ifa_local;
>=20
> 	// ...
>=20
> 	if (bp->wol & MACB_WOL_ENABLED) {
> 		/* Check for IP address in WOL ARP mode */
> 		rcu_read_lock();
> 		idev =3D __in_dev_get_rcu(bp->dev);
> 		if (idev)
> 			ifa =3D rcu_dereference(idev->ifa_list);
> 		if (ifa)
> 			ifa_local =3D be32_to_cpu(ifa->ifa_local);
> 		rcu_read_unlock();
>=20
> 		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> 			netdev_err(netdev, "IP address not assigned as required by WoL walk AR=
P\n");
> 			return -EOPNOTSUPP;
> 		}
>=20
> 		// ...
> 	}
>=20
> 	// ...
> }

Will reduce the scope of RCU lock in v2. Thanks, Lebrun.

Thanks,
Kevin

--EH2RervoWIbhLwfW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmm6RqcACgkQk1jtMN6u
sXHXvAgAlFNTSrFAIlrzgOF5y/xJOsfvyMqnJD9J8eE6UQNtUm8mkF3k0RD3HMW3
DqUXlUnn2RYGZ7gYwG08mbHF25gc+YiBTCDeErkF2vYRpZv/P+2BqlXlhQX6afpy
Qn9wjdPhhvb+ed4lIVd48AR/52Y4u1HwLpH1lxg903MoNRwoWSHFKfi5EMn+0J+W
IdyYkhGCxcqaWZ1qrlpS1altwwvwS5882sOLGvW/zLk7yJLs82uznK181uxlopor
54ijlCgQb75qvVpPojXFIxd60vELMA4MULL9vhOVhEnAlfaZPcWUTtZ+RzXuyrS2
sGjBM6HQphSxTFUFpcjZw5dlrqJ12A==
=AN7D
-----END PGP SIGNATURE-----

--EH2RervoWIbhLwfW--

