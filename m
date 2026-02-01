Return-Path: <stable+bounces-212976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABFGITCpfmkFcgIAu9opvQ
	(envelope-from <stable+bounces-212976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 02:15:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAACC4900
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 02:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCA463019B8C
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 01:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB17261D;
	Sun,  1 Feb 2026 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD3REvSD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B698C1F
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769908521; cv=none; b=NUQQEL6UYLGeuUtf24g7+LiOP2GIqB9Iw9RKZ/7k5BgICKlJKlo/DAzxolATj/YAtemgxMepv3wBO6rGhn+21T0NuJgEXX882LYziFzWJNeKCrWABxkahC1K/sUWm1UJ01ex4MPa2I/Tk/Fol4jUnqhvvZV8B7y7o98LqErQ15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769908521; c=relaxed/simple;
	bh=95ouaZ23Vhl2t+iYu6rYXs9qTxKPHcqylEIKC50PuIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGdbqKb4tztP7jSV9f4Z7OElOPaszYMxVT9EzrhqDSqD7+lnvZNZqxvH1Yz2doRIDzewxIktiV8GZhZKAeox3ylG5975DSXZpLZrw8Wwqx5sNaume7Jm2JZwwmfek/7N9nGRwZBrDlkJVzGcvTbUVPxZ33tzXdZCNTXQ+ALiCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD3REvSD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c532d8be8cso337998385a.2
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 17:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769908519; x=1770513319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJm1H3CZ3seZ1f2WLe4nYJDs1xC8Xdq/DSJguIofri0=;
        b=BD3REvSDHeQoHZqlgssSQaDryNcl5lwnZJHG7bKAOrwqNb3f/t2zD+Ln/nd/eyP72q
         FHXMAZ2FIvAFvlp5vILlot30wy/uSDrMS4VZrz1jlscxG4DxjFw0YVTZ2EP3kDYk04kp
         S6t7JFyCgZ/3PB1aU1XRG5elY+pW3HdFHDL2mbfTpULbK+8KE5qpAsgK0cyJEu+AHGbr
         Y2IQPH1eedhndtjfablHYGjJDq6rIY5+B68F02m8QisSJirE2KujnGNdBmOm8uFJa34P
         dYdLfrxO4lsMpUyNhfjXYGNegGA+NUBIjSbOl7fV0fzmM/gRVSMkCmygf+qjzaVfsOqU
         JvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769908519; x=1770513319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJm1H3CZ3seZ1f2WLe4nYJDs1xC8Xdq/DSJguIofri0=;
        b=Yp60YphvmdRouLkCS8LWuwGEhSuLOM9lqchCxOOy66nS5bJcDfJqkZ8OwAtFfq9aJc
         mD2f5iz4Aw961jKv4yvlVbtztGcc9deN+/2od0f920eXFkjkU8MN0c7GF/atcd9inASg
         pgUl9T3vUXKBd37PAB9/sPrdBjb18wy7kodPFEA38VLcFVA/LU0ztYkZuZppeY9M+XgS
         fU9XuahkqTyVsiHawd+YpgZXRz9BeqtmzIUor/Ho29GYkN1A0YxTARRglntdCuGPmwv3
         IcYAbSfIq6EOiv8h09If3JxYRgXER8okJhdO8GSk+D3wjR4eoo9cR/Aspu1m2EvKdJZY
         Fcuw==
X-Forwarded-Encrypted: i=1; AJvYcCUDsLr/R84rEHFGF0Gu/HN+iPPU1AiCA5SshiSgkwrZPULZ6VBO7XsIhLjfBN7FkshY2U3OFjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIZnZSpxyPlG5/0+hPqObD1UfVDQtLOxenztlH2x+RAMHuIgB
	rwKIBDq4IjcdQg12HB87uq2mBvoRs8qY1wZut2WxiZBgGnWrOddHCGP0
X-Gm-Gg: AZuq6aLjNxS7BBHaceV0MVmmaYvyv0LSF1GjF37Wg3qXhIjw8YPDXrqq66KEtNxEtz+
	L7YXn4lM/dha0PezsA5NczM+ppaXTLZG8lk0a8xwHmU10TL4dShKTmBUV7DFTRGQDBVKYATVNkv
	sQeQudVftzs0M1Bm0x0rQiwPqACf3DySBrTBRgV6gOCxBZjfm1PGRhPYJXH/2j+02XwqmeZCVz9
	se+3RqP1qlbfrCxiHAm8aM5ERfOzt2JrwAUJ0g3zZxcq6hvu5QTEf8bf2TioFrsZwOiay3NS2/Y
	Q8nsEJUheS+SBZz/8MrpPTMamhpqPQqVN6LyBy7/7X7KAh2F3MnOv6FKUSVBzVrzQpJR1fRnQVE
	osiJo9gfHsuUxjf6BzjRmMI7MCasGexJZh/BVdMmyf1bdkP9rl/Zs5WUSvZS2H9LvG0OPICmAFj
	NV+J4WCZo=
X-Received: by 2002:a05:620a:3704:b0:8c3:87eb:f with SMTP id af79cd13be357-8c9eb2f95b4mr1018046085a.53.1769908519059;
        Sat, 31 Jan 2026 17:15:19 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7c670sm903220085a.6.2026.01.31.17.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 17:15:18 -0800 (PST)
Date: Sun, 1 Feb 2026 09:15:10 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH net v4] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <aX6pHiB0tk6xvrCX@pek-khao-d3>
References: <20260130-bbb-v4-1-2bd000a15c34@gmail.com>
 <20260131124120.744bd931@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/7d4g+wwdxZxeLY6"
Content-Disposition: inline
In-Reply-To: <20260131124120.744bd931@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212976-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFAACC4900
X-Rspamd-Action: no action


--/7d4g+wwdxZxeLY6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 12:41:20PM -0800, Jakub Kicinski wrote:
> On Fri, 30 Jan 2026 13:34:07 +0800 Kevin Hao wrote:
> > --- a/drivers/net/ethernet/ti/cpsw_new.c
> > +++ b/drivers/net/ethernet/ti/cpsw_new.c
>=20
> What's your plan for fixing drivers/net/ethernet/ti/cpsw.c ?
> My preference would be to post both of the fixes at once,

Sure, I will include the fix for cpsw.c in the next version.

> I think this version is quite close, just a couple of nit picks
> below..
>=20
> > @@ -248,15 +248,25 @@ static int cpsw_purge_all_mc(struct net_device *n=
dev, const u8 *addr, int num)
> >  	return 0;
> >  }
> > =20
> > -static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
> > +static void cpsw_ndo_set_rx_mode_work(struct work_struct *work)
> >  {
> > -	struct cpsw_priv *priv =3D netdev_priv(ndev);
> > +	struct cpsw_priv *priv =3D container_of(work, struct cpsw_priv, rx_mo=
de_work);
> >  	struct cpsw_common *cpsw =3D priv->cpsw;
> > +	struct net_device *ndev =3D priv->ndev;
> > =20
> > +	rtnl_lock();
> > +	if (!netif_running(ndev)) {
> > +		rtnl_unlock();
> > +		return;
>=20
> since the "undo" logic is getting complex you should use a goto.
> Replace the unlock and the return; here with:
>=20
> 		goto unlock_rtnl;
>=20
> > +	}
> > +
> > +	netif_addr_lock_bh(ndev);
> >  	if (ndev->flags & IFF_PROMISC) {
> >  		/* Enable promiscuous mode */
> >  		cpsw_set_promiscious(ndev, true);
> >  		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, priv->emac_port);
> > +		netif_addr_unlock_bh(ndev);
> > +		rtnl_unlock();
>=20
>=20
> 		goto unlock_addr;
>=20
> >  		return;
> >  	}
> > =20
> > @@ -270,6 +280,15 @@ static void cpsw_ndo_set_rx_mode(struct net_device=
 *ndev)
> >  	/* add/remove mcast address either for real netdev or for vlan */
> >  	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
> >  			       cpsw_del_mc_addr);
>=20
> And place a labels here:
>=20
> unlock_addr:
>=20
> > +	netif_addr_unlock_bh(ndev);
>=20
> unlock_rtnl:

Will do. Thanks.

>=20
> > +	rtnl_unlock();
> > +}
>=20
> >  	for (i =3D 0; i < cpsw->data.slaves; i++) {
> > -		if (!cpsw->slaves[i].ndev)
> > +		ndev =3D cpsw->slaves[i].ndev;
> > +		if (!ndev)
> >  			continue;
> > =20
> > -		unregister_netdev(cpsw->slaves[i].ndev);
> > +		priv =3D netdev_priv(ndev);
> > +		disable_work_sync(&priv->rx_mode_work);
> > +		unregister_netdev(ndev);
>=20
> I understand that this is safe but I think that more logical ordering
> would be to shut things down _after_ object is unregistered.

I'm a bit confused=E2=80=94are you suggesting that we move disable_work_syn=
c() after
unregister_netdev()? If that's the case, the scheduled cpsw_ndo_set_rx_mode=
_work()
could potentially run after the network device has been unregistered, leadi=
ng to
a use-after-free issue. Or am I misunderstanding something here?

Thanks,
Kevin

--/7d4g+wwdxZxeLY6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAml+qR0ACgkQk1jtMN6u
sXFiMQgAgXhM+XjfpOGaw/OgbkrwPRvaJ2E9diBBKdfT5GneZ2xQLqoX5yrDbn69
x9ywnY0WcVrrZPBnlDb6+gylB3kexPm1bkKoXVCLZgMfmjTgMUn5ZgW2AJFeF0Jo
6e749TYfvlP+sK1fT8vK3ljM853Sgne9GoyWjnSwM4UMX86DGXiOaoA9/t4S2Ik5
BeiuMisqwUHhk5wmGUWdKNWrCcrCuWXEHfVVE6yeHwiRv1VBPqrBQr0w/ct+VSay
+Afvrd3fiQsVSG2NL9hOg3ri/QChk0HEjPlUTA6/5k7Qyy8CWzKxM1R3V6I5I3oB
8ohHti4FG6auchSaoIGJp+RStRu+cg==
=ackL
-----END PGP SIGNATURE-----

--/7d4g+wwdxZxeLY6--

