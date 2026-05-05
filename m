Return-Path: <stable+bounces-244267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEUIDsZa+mknNQMAu9opvQ
	(envelope-from <stable+bounces-244267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 23:01:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A664D3CC0
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 23:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91425300BCA2
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7978532ED4E;
	Tue,  5 May 2026 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="iGcndbV/"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814AF26159E
	for <stable@vger.kernel.org>; Tue,  5 May 2026 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014912; cv=none; b=kYLQMahyBWk9fTOjxhngtDHZAzFVq92GitGKGedu5KbImGNc/3yfqIiQ5d38kF6OolUYGsIb77734ZKWH0FXWquAmYpFmI83lwPsrk866JwwxHQrVHvno0BdwF60hjcdHkEayKYCD99aSJ83CeDSxyFNVbkZFhX32RDX420f1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014912; c=relaxed/simple;
	bh=B4RKkcbCsEB4fBeE0z0mKR0MPKdtvTS9+YM5UH/zdnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejGBzxS3ZCRGWPsqppmvr5gSq3+96dL9XXTNtRxRo1TParaMyG7jNOtlcpXA6zxxdmqFK73oEiYIp7WLMP5qpMllYiFxl7sl/AhHFE0htMzEDkz3FMAkctwxwUPIbg/KCJl6xd2c3Hl2loxutfonaTA14I49hafDLSaVBawIhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=iGcndbV/; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2892111529F;
	Tue,  5 May 2026 23:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778014908;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IaNVHnzozKkkkNMYuqFYKKJpRBnqgyfinIsogmC/S1A=;
	b=iGcndbV/sSrkZz7MiWGoUQjFxGKh+cSzncOfLhcoqW1XnzY8zKpnRacnpc3FdlCjOLC85b
	vSvJkeH/R9Z1aroqkgVUE20IOyJcCloTGP2TzwQllF2z5oYWJ2ZEMHutsUvHM4RUfAcSvx
	FzHZn0xG5JmGrvKh7eh8mncClo7KokT9g9JsFDOukFgTUVAAuVh37WPOubpcThBXztFK3l
	P1hWgoyAK5lhCBsJq/aMmU5QWt4f4Qx56eYxkG1oIN69dhRmYmBZnhoauBKP9Z0F3bpvgp
	xwqGkKBbesAlwAruf+Aj3OaShGxAXturQ2QKGa6MqwGwfOaILff7cDJjl0sT7A==
Date: Tue, 5 May 2026 23:01:43 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, pavel@nabladev.com,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, stable@vger.kernel.org,
	cip-dev@lists.cip-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
Message-ID: <afpat8GZyp-AiD5W@duo.ucw.cz>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
 <afhkX2Ys2BG1gnqy@duo.ucw.cz>
 <31002e6e-3983-4e30-aef6-bd2cd51aec40@tuxon.dev>
 <f81033c2-3432-4275-b5a7-78c61c31502a@tuxon.dev>
 <2026050519-stencil-sequester-187b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eIb4rNa8ZjposuqF"
Content-Disposition: inline
In-Reply-To: <2026050519-stencil-sequester-187b@gregkh>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 26A664D3CC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244267-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,178.251.229.89:server fail,2600:3c15:e001:75::12fc:5321:server fail];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nigauri.org:email,duo.ucw.cz:mid]


--eIb4rNa8ZjposuqF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > > > >=20
> > > > > This fixes an issue caused by the use of msleep during spinlock.
> > > > > In the original commit, msleep was changed to mdelay, but this fi=
x was not
> > > > > carried over during the backport to 5.10.y tree.
> > > >=20
> > > > Doing this as a quick fix is probably okay, but this should not be
> > > > final version.
> > > >=20
> > > > You are right that msleep inside spinlock will blow up immediately:
> > > >=20
> > > > > ```
> > > > > [=A0=A0 62.677594] BUG: scheduling while atomic: kworker/1:2/126/=
0x00000002
> > > > > [=A0=A0 62.683957] Modules linked in:
> > > >=20
> > > > But mdelay for 20 msec inside irqsave spinlock is borderline
> > > > unacceptable, too.
=2E..
> > > I'm going to investigate and come with a better approach for this.
> >=20
> > On a second thought, the proper fix would have to go to upstream first.=
 To
> > fix the problem currently seen, could we integrate this patch as is?
>=20
> No, please work upstream first.

Upstream has the mdelay:

drivers/phy/renesas/phy-rcar-gen3-usb2.c in rcar_gen3_init_otg() --
mdelay(20) and has the spinlock,

static int rcar_gen3_phy_usb2_init(struct phy *p)
{
	...
        guard(spinlock_irqsave)(&channel->lock);
	...
        /* Initialize otg part (only if we initialize a PHY with IRQs). */
        if (rphy->int_enable_bits)
                rcar_gen3_init_otg(channel);


So what Iwamatsu-san's patch matches upstream, and is good solution
for -stable for now. I have just pointed out, that, well, mdelay(20)
inside a spinlock is not great.

7.1-rc2: mdelay inside spinlock -- not great

5.10.250: msleep but no spinlock -- missing locking, bad!

5.10.254: msleep inside spinlock -- fails to boot, bad, bad, BAD! (and
also regression from 5.10.250).

Please allow Iwamatsu-san / Renesas to get this to 7.1 level of "not
great" situation; Claudiu will work with upstream to get 7.1 to "good"
situation, and then we can thing about backports.

Thanks and best regards,
								Pavel

--eIb4rNa8ZjposuqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafpatwAKCRAw5/Bqldv6
8jz8AKCSKiGPIsl8fY0EjwCocAs8f7Wi7ACgvr8PL6sfKxuitU1Ya834v1a5w6o=
=H3kf
-----END PGP SIGNATURE-----

--eIb4rNa8ZjposuqF--

