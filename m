Return-Path: <stable+bounces-232778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ai4EzIbzWnOaAYAu9opvQ
	(envelope-from <stable+bounces-232778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:18:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842537B167
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80386303F1E5
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1D33A3822;
	Wed,  1 Apr 2026 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XVGeYd97"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE02348883;
	Wed,  1 Apr 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049013; cv=none; b=I7UmVojTU6620FYbNRsGkTA1TEB/6QYgSMMt1C2h8gyTMpyPQuA/Wo+i1TiMdGYyZEy2nVR5i2xxACA/TrQ5BVZuV/N9BdAgMfsjqvvbKL9Xro3u1NrO5tN28oFBdDoH6NlYyQ/f9LLh76Eackfv464RHB77Xh4VDvEGlIl1mNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049013; c=relaxed/simple;
	bh=8AqE06BtIHM26cpry7sh/8rDMddZ5jdzj7W8UqW7xLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnR2h+5ZOH3plfZX3q5/lmMo+Wez+RHBJ57c25sGejpONKd3gw9V8/RXTibH0i3BDDNulzftWSWnbtNjAs+9QF9G2LOLYId6LU9rWCMmxlDoPtPrUzCNL4p0cUBJW6bweG07RwP7N8goeFXFnbwtt+axgy5pTyvKNJG8xc0yjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XVGeYd97; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=8AqE06BtIHM26cpry7sh/8rDMddZ5jdzj7W8UqW7xLo=; b=XVGeYd97QFkzva2ukg+FXypfMD
	lwMyjsG325Y4xPuX3f+KBx2G7GayjOwifam+pg6lZ+DsrZEc9RJV6pfzChiDVLOKPr5g1miZmvIqe
	32ce40wV0MNPYgN9c5DEKoO0KIr8GkUXZnwLByWttw53P+g3z6HJpOrgpdyC43JApLU4aULHucua1
	PlR5jmT3/Dt+VhJzrVs0wEquI/sYCcgX1hL9QZzL48ACzr7JYiP8EDqofNmuSjpRITPJYY6ib9yc+
	DAlpNYus3C6fpmLYfw3lJIdY6tErTHaJK0Nx/iJ6YjJI7cgj/wyJtDe4lL2yJAlGFsOFAtHTB6goG
	jUQCG/Qw==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1w7vKd-007UG2-0w;
	Wed, 01 Apr 2026 13:10:03 +0000
Date: Wed, 1 Apr 2026 15:10:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Bernd Schumacher <bernd@bschu.de>, 1131025@bugs.debian.org
Cc: Lukas Wunner <lukas@wunner.de>, 
	Salvatore Bonaccorso <carnil@debian.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	regressions@lists.linux.dev, stable@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Bug#1131025: [6.12.y regression] Regression with 58130e7ce6cb
 ("PCI/ERR: Ensure error recoverability at all times"): echo vfio-pci
 >driver_override does not work for DVB Adapter
Message-ID: <ac0Y85OShbK6mHEV@monoceros>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <acfZrlP0Ua_5D3U4@eldamar.lan>
 <acfhf-odtr0yw_py@wunner.de>
 <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
 <acgohjvBpVcR7HcK@wunner.de>
 <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>
 <aclRwznwq6KpA2qA@wunner.de>
 <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovruitqvpmpuucsl"
Content-Disposition: inline
In-Reply-To: <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.master];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-232778-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5842537B167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ovruitqvpmpuucsl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1131025: [6.12.y regression] Regression with 58130e7ce6cb
 ("PCI/ERR: Ensure error recoverability at all times"): echo vfio-pci
 >driver_override does not work for DVB Adapter
MIME-Version: 1.0

On Mon, Mar 30, 2026 at 08:14:53AM +0200, Bernd Schumacher wrote:
> Am Sonntag, dem 29.03.2026 um 18:22 +0200 schrieb Lukas Wunner:
> > Could you repeat this and add log_buf_len=3D16M to the kernel command
> > line
> > so that the dmesg output isn't truncated?
>=20
> I have now added=A0to /etc/default/grub:
> GRUB_CMDLINE_LINUX=3D"\"dyndbg=3Dfile log_buf_len=3D16M drivers/pci/* +p\=
""
> attached is the dmesg result for 6.12.73

This looks wrong. Please make this:

GRUB_CMDLINE_LINUX=3D"\"dyndbg=3Dfile drivers/pci/* +p\" log_buf_len=3D16M"=
=20

Best regards
Uwe


--ovruitqvpmpuucsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnNGScACgkQj4D7WH0S
/k6bwQf/Qz+FCTFFiiHGjzCnjbZfBVStR6oAqUY9T2dYtGtjGbPTGAVl1qe8tE+t
jQ3rJZMZtlZu2hqD05Ghk3sGwMooKyq+6y15VCsOg4/nhBNcMx1bakfhBbVX44tU
qY1CqvgB7ePfHNG/z+ER64j1J6/17ahEhqVQtrobwEl0e6eIU/DS6n8urgdhoEoA
SMqyiUeM+JsWMw123MbU2gbYNfPFGl4QD60FJYMrpiulz27gaXEpyb0VemT9fe8q
7f1Jy//IzEaNQ/uT+9gLXsXY8mXfyCZShhrBNruD8l9p5f9QTW9ZeV4zLDV+lN+z
tcIVjKnNwkmkv5E+pvAk9PtckgoWiQ==
=jR9w
-----END PGP SIGNATURE-----

--ovruitqvpmpuucsl--

