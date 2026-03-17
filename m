Return-Path: <stable+bounces-225729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAcTEg6uuGmHhgEAu9opvQ
	(envelope-from <stable+bounces-225729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:27:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5C32A288F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7346C300A626
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3675B433AD;
	Tue, 17 Mar 2026 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8LkH68c"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92034964F
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710840; cv=none; b=Z0my0u9jEmBB+mYs1bH6ES3s7e4AUCmcmFTGZJJNwB3ltunSnfPVq4Cozefn7GSVTukTmD6DWhnZmn/VGYlOdiTGGu3YCP2Kuu/5MvubZanTnZ8K9Zb+AHFvxtgngCbiL53dzE9+XEHgCgbs95JGKMXveOPuxDQNuXoFtLTf6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710840; c=relaxed/simple;
	bh=yoiduCnUKRO0yz9jxVnQDHNSVI3+B0dPKMstdEd2/fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5X1R/ECjmHtTWXuEi1b2o5snBfmmjY247EPv/QcpfJGHoTl9AZ6pT23Sb3JDNSpZ8QHcJj1U+QXqI6rghdMWFF+YpH6d4aKoqEm9eQgJZ3eHYDQPjMdqKPS27kEGHG98eRrw03d+C1izfXyz/TSOvYLD3NIMysJwTw8SsbpHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8LkH68c; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bea8a1c040so3167190eec.0
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 18:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773710837; x=1774315637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OlKamCL8WXsAiYfYsDwpaxwBpBEiFOPeO6WpPGnkXU=;
        b=X8LkH68cYa/ZzsiLMsXdzTLVQYfcqGT2gYWLLBgIsTsHLwalnr1S3k8IDmtf5glmZn
         glXwG1UFUI9SIrS3NrAPkX9QYwc7XI4WzPWzDHIRKHFN1r+DbwsjXuHOFPtH8S/C+SdK
         D5WBlU5n64oE2TILKxy4g+l3jQln3jlempl545Idngji/gDDTVMue0V3+H1iwaifVpsD
         Pag+Xi1EtxftkNu+tSbq0UGavCtyFY17pt1lhHgJ/CM8oMTAXopeZvUgyK40iXZNgeuJ
         w+AaCbTuko1scioZbrFpcUXq3445dLkUb3kxypoQCz1003Q3wIsyuh4gYrPduypqSlaG
         YY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773710837; x=1774315637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OlKamCL8WXsAiYfYsDwpaxwBpBEiFOPeO6WpPGnkXU=;
        b=GdNwjS61ZkgyjX5NqDvPxz3n9z9YJ6MKKLlDfOUvFPqajh6EuTrVN8hZPG+7LebtCb
         PwN+CUBQLZG3MMWDnSglK5eagE8dmld4BoE/rqwHMUGsOwv01RKNesyyAMrzndghaNkg
         lADbHMOopeUR8rHYAXliaI6yt/eMwEYnkYJAU0RdUkwCf8aJutnrGgnBkNGZmKHlkGGp
         eOjezRz5q0kWqMhRc0CUbs7kLPsZKt5Ow+v25ktzIHXv/5DRubSCr0YNNxPLKgsuVKH8
         YE6tkaoeBsaA9nMRZi5wXUqKOcZSYjwOTfEzeEiUXbb7MDIZ/yrQq6WPUdHBfzf04CVX
         m/aA==
X-Forwarded-Encrypted: i=1; AJvYcCXay/RsAkz5z2PqHvG2jVD6fVLsa/a3S7Q8gH+e5CVZncDo9RdSIPdDSeh6GjBGOMJqVGi/lk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysdMwUgyKljKfRHUwY9cDiHiJMQDHhENk6E3WuHc28OvaSs3Vs
	l8Z1uLvPHpc4xmsnOJKiGi5yJmlYp9NHfowUFyJWsmi/s8QSCCHv6Ukt
X-Gm-Gg: ATEYQzxeZIT1bKfCkgo1C1FzR+wH9izbhRGByyTmqMbo+pBL1LTeVMKI2Bj/vGzF2S7
	tEzNnHK02GXdAS8PRwKTmBFJ1cdMz31/1KuC3HyP++fWTUMoX+2mjekdbMaRV7NTmNxz4jtBACU
	uBUFSSXI3xaeVrF2nC8HxEz6fI2UVQAaoEt3/pK0yA53Nm5tYVSJbrATRbEeuoPUvEAQf7b/Tbc
	us42DiUBUYhhy92VcpqUtbdHWpf+zkhmMelj3uZ0E1IUMnvGMWyMkoDlRXf67T2KpIBVFLbhhRY
	O0YAonITe1q6enJC380amkB6KhTgbSZCdZHrVYbi6qaUjIxZtCcniu/+qlTq7NV4TG10v0JpZ7A
	znd6L7/IFUKvYVVB/jWwdGvs4RxDggJX3MwcmMP723bphTjjwAOychzzJL4EitQMdG3z2aTYbye
	N7lHCSCHeaXATExVEGZjNGm+rt/2c75w==
X-Received: by 2002:a05:693c:60d0:b0:2c0:c27c:338d with SMTP id 5a478bee46e88-2c0c27c36b1mr2060815eec.35.1773710836513;
        Mon, 16 Mar 2026 18:27:16 -0700 (PDT)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a12e2sm17874042eec.2.2026.03.16.18.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 18:27:16 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:27:09 +0800
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
Message-ID: <abit7VLwoy2ttEus@pek-khao-d3>
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
 <20260315-macb-irq-v1-2-0154104cbf61@gmail.com>
 <DH4EHTJNY6GL.3EXTP61HNUNDD@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fXQ1Gh8sSRril/+g"
Content-Disposition: inline
In-Reply-To: <DH4EHTJNY6GL.3EXTP61HNUNDD@bootlin.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225729-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D5C32A288F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--fXQ1Gh8sSRril/+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 06:59:35PM +0100, Th=E9o Lebrun wrote:
> Hello Kevin,
>=20
> On Sun Mar 15, 2026 at 12:44 PM CET, Kevin Hao wrote:
> > @@ -5915,13 +5915,16 @@ static int __maybe_unused macb_suspend(struct d=
evice *dev)
> > =20
> >  	if (bp->wol & MACB_WOL_ENABLED) {
> >  		/* Check for IP address in WOL ARP mode */
> > +		rcu_read_lock();
> >  		idev =3D __in_dev_get_rcu(bp->dev);
> >  		if (idev)
> >  			ifa =3D rcu_dereference(idev->ifa_list);
> >  		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> >  			netdev_err(netdev, "IP address not assigned as required by WoL walk=
 ARP\n");
> > +			rcu_read_unlock();
> >  			return -EOPNOTSUPP;
> >  		}
> > +
> >  		spin_lock_irqsave(&bp->lock, flags);
> > =20
> >  		/* Disable Tx and Rx engines before  disabling the queues,
> > @@ -5963,6 +5966,7 @@ static int __maybe_unused macb_suspend(struct dev=
ice *dev)
> >  			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
> >  		}
> >  		spin_unlock_irqrestore(&bp->lock, flags);
> > +		rcu_read_unlock();
> > =20
> >  		/* Change interrupt handler and
> >  		 * Enable WoL IRQ on queue 0
>=20
> Instead of making the RCU critical section extend so much, you could
> dereference ifa->ifa_local into a stack variable. In particular, it
> would avoid the RCU critical section covering a spinlock critical
> section.

I initially considered using a local variable before submitting this, as I =
also
believe that `ifa->ifa_local` is unlikely to be modified or freed in this
context. However, I ultimately decided to protect these sections with RCU f=
or
the following reasons:

- It is logically more consistent to protect access to `ifa->ifa_local` with
  RCU locking.

- For section already under spinlock protection, adding RCU locking introdu=
ces
  negligible overhead, especially in a scenario like this.

That said, I do not have a strong preference for either approach. If you pr=
efer
using a local variable to keep the RCU region shorter, I can prepare a v2 w=
ith
that change.

Thanks,
Kevin

--fXQ1Gh8sSRril/+g
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmm4re0ACgkQk1jtMN6u
sXEwswf/dI7nafCf1tPMTrWTo1FxqPw7W3YsFa/D/oc9aPiv9xIlslAjlwcXm5ij
YjwNC8TZsAqnLG2WjLUgRPWo3YKMT9JSUodiS52D8RGjy81sewed//NObhTywLLS
zn0BD8z9AA287jagIe1hrargXOdU5niK3kjNrpRJh4V5SyoZwofWSN8D4QFtuhXG
iUUZB1UYOYEq8pR+GYLT3mtrkUhASTaJ1PJq7P/tO5Y47fgrCtmn0Asi4+2tar3M
PG8CvfTQ4sEVXOaGObs3TBHLICS5HzuYC+LroL9ttThlM7ltu5yRxU+B6MGmbLAG
XjIIsbQiMsChwmBvqqDJWIZY3/2+kg==
=zP9L
-----END PGP SIGNATURE-----

--fXQ1Gh8sSRril/+g--

