Return-Path: <stable+bounces-219967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A8INq2koWlxvQQAu9opvQ
	(envelope-from <stable+bounces-219967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:05:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610AD1B859E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01BA0316F08F
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D41040FD83;
	Fri, 27 Feb 2026 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="9gMdKvww";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="OSr3bfDx"
X-Original-To: stable@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48323D3D18;
	Fri, 27 Feb 2026 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200770; cv=fail; b=IA/cOSLG1RCg8hQGgZc0mIUlMFEFtOVA/CN1dWkhJz/j1qmD7A0W3dhwF8NXmtOT0fefAhX/PwR3iSOgj9JCN9fP2LpV2qqv67pgCmdowq+VZQJqS+iZpQv/FqyXJpqxs9TkkMKeClwAimflWMVlkTrf2vsh0XOQ42OM8yg7Ylw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200770; c=relaxed/simple;
	bh=TkLUUlNjE70jYhs8K6Rt/B73/FpLBzXo8QMPI20jn40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IKr1VP1zUXKZH1877dOeFnObUeox5jrb/D2t3yAu4o25Z2VC2k3oTuRzeF18fJfiPSohrOrUYYhTiuKvbmUDM8HRWAVWfYaNL1Fn4wHBQ+y58Mbfpn7LZMXK6qijz4v3Tfx3zxGg9J5U8OlN/WjBURxlqMx7CaoKwwOsYFJoVKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=9gMdKvww; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=OSr3bfDx; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from smtp.sapience.com (srv8.prv.sapience.com [10.164.28.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id EAF61480AE8;
	Fri, 27 Feb 2026 08:59:28 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1772200768;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=Pwe4xQSy8uoPvKiy/yN905TC7sewEferheavj/nbl9E=;
 b=9gMdKvwwa7A2UfVkWbH+q8jjVj8VZZSy8a7MfY9mwoFX7s4oM+LFa2PItZxhxlPhPsQRD
 CgMi89mnvrLZPfhDw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1772200768;
	cv=none; b=ZcWmX8FnAUxV/uZq1afp2JOG291mdUppDuDf7BYrIqT/LnVW6K75Ctj5pr5FZ4zMSghsz3DE9WlLrowx3XquUkT8IZoTELtZTOuK04Z+GoTI0WJ4uWUbYOgoxlW2IgP+54HPb0lxjBVIQpFMAvENHdg7uAI3IqtvKBBRKME3ttC/6t1qF+k7vgY7a3HiLI8Ii3yKt3yLeP9KPzvH1c0/WaLVCmZs3wo2VEtv6hyx3ftsKNmF6HHMQUzbZnbdbTS/J88vCDcOioxPSMaEqqpvRdlIfm5q1npnTTOs/KYn6+JvkKMyCYVxncNBO7N3V9zCggoyPpLmfIWJZJLg88lXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1772200768; c=relaxed/simple;
	bh=TkLUUlNjE70jYhs8K6Rt/B73/FpLBzXo8QMPI20jn40=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=lVZbEhpggd34G3ZRvAOg4VwTKlm59A3mHhbZeYeTlzsNhx3U0njO3bmOKpEVzsgvAY60vR9LW5vP+AkuIVXN9nqWCeJxwRCHFINJCsC9jnmGVfXR2D86qwRhLLpKJHD1KTEC6+zYBqPtsUKWYAFZoUTfq5TYgS+HKlOoyoxD14aerJyFJAP4vtioTGpaFPkmeNVYjfEdlT74ysaN5hulDUs2h5nyj0qcjT2JfH6gqKEOyck6bwD2z/Ile1lkhWZa2oM3+YG53ixyQ47iJACaBPrPAZvQ9DsHlJe0NlvWg/glfko6F9PtscMWMXzozPkSCe/WcVBgTzCdSWNBK8AEsg==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1772200768;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=Pwe4xQSy8uoPvKiy/yN905TC7sewEferheavj/nbl9E=;
 b=OSr3bfDxX7CzxX7NChYJxxIhdB+5Ssx2Hw9AOJr3mFhoTjcKAsasusswlAs1b0RaYWYbZ
 cBMJP+Q/+qjCe8yfMq/TX+llUaeT6VNPDNgM0XV6XA0V4GNrRs7Vae6ahPXFyZqU5jiHS8r
 cXjnkSaXFjNS51KI9tKu6liYmzwWV8lpWpNmWzE6x6dR/oNF1W1d0s/N9wohMV2adZiy0xx
 JOKZkGWXCq40P2PmtWHXJ6Dd7NvtPqF1FpjEjQEYrTfpqQ/BdvU1sA1YrVDrqyem6l/mo3P
 9Hfl6VXEZExZvBna1MPjKOkiZ7u7VJiiWOunh5DaO27vYSky0fpar/qIBZKg==
Received: by smtp.sapience.com (Postfix) id B9306280010;
	Fri, 27 Feb 2026 08:59:28 -0500 (EST)
Message-ID: <95fea1bd0ded180bb79285ec8416053c614150f8.camel@sapience.com>
Subject: Re: Linux 6.19.4 - Oops, regression
From: Genes Lists <lists@sapience.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>, 
	akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, 
	lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
Date: Fri, 27 Feb 2026 08:59:28 -0500
In-Reply-To: <2026022750-everyone-huff-8fd0@gregkh>
References: <2026022657-clambake-mountable-8175@gregkh>
	 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
	 <2026022612-buckskin-surfacing-d854@gregkh>
	 <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
	 <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
	 <0a77c13e74493b786c5fe4e1ebdf55b14e5ff496.camel@sapience.com>
	 <2026022750-everyone-huff-8fd0@gregkh>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-tekoYUGGf0I8LLXeH7Nc"
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[sapience.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[sapience.com:s=dk-ed25519-220413,sapience.com:s=dk-rsa-220413];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219967-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[sapience.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lists@sapience.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sapience.com:mid,sapience.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 610AD1B859E
X-Rspamd-Action: no action


--=-tekoYUGGf0I8LLXeH7Nc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-02-27 at 08:32 -0500, Greg KH wrote:
> On Fri, Feb 27, 2026 at 08:18:52AM -0500, Genes Lists wrote:
> > On Fri, 2026-02-27 at 07:09 -0500, Genes Lists wrote:
> > > On Fri, 2026-02-27 at 01:26 -0500, Kris Karas (Bug Reporting)
> > > wrote:
> > > > Greg KH wrote:
> > > > >=20
> > >=20
> > > =C2=A0 Linux version 7.0.0-rc1-custom-1-00124-g3f4a08e64442 ...
> > > =C2=A0 ...
> > > =C2=A0 In file included from /etc/nftables.conf:134:2-44:
> > > =C2=A0 ./etc/nftables.d/set_filter.conf:1746:7-21: Error:
> > > =C2=A0 Could not process rule: File exists
> >=20
> > Sorry for noise, not kernel related.
> > Resolved by updated userspace.
> >=20
> > Resolved by rebuilding userspace nftables on 6.19.4.=C2=A0
> > I used git head for all.
> >=20
> > =C2=A0nft rules now load without error using:
> >=20
> > =C2=A0- nftables commit de904e22faa2e450d0d4802e1d9bc22013044f93
> > =C2=A0- libmnl=C2=A0=C2=A0 commit 54dea548d796653534645c6e3c8577eaf7d77=
411
> > =C2=A0- libnftnl commit 5c5a8385dc974ea7887119963022ae988e2a16cc
>=20
> Yet 7.0-rc1 worked just fine?=C2=A0 That feels wrong...

Sorry if was not clear. =C2=A0Only 6.19.4 has kernel crash.=C2=A0
The summary is:

=C2=A0- 7.0-rc1 - no kernel issues
=C2=A0 =C2=A0 boots fine and does not crash when nftables is invoked. =C2=
=A0
=C2=A0 =C2=A0 But, It has an nft error and fails to load rules with
    older nftables userspace.
=C2=A0 =C2=A0 Same rules load fine using updated nftables.

- 6.19.4 - crashes whenever nftables is invoked.
=C2=A0 Does not matter which userspace nftables is used, older or newer

- 6.19.3 - works fine.

I will report back soon as have finished testing 6.19.4 with commit
f175b46d9134

gene

--=-tekoYUGGf0I8LLXeH7Nc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaaGjQAAKCRA5BdB0L6Ze
24UaAQDbPXEelXLbkvRWyKgoR0AYWf/ndrCSqX9i6GoxdpMgGgEAtls3HDvuRRX8
pw/zKud5eE0bLP/KXF6p85VESPHWNww=
=DbbN
-----END PGP SIGNATURE-----

--=-tekoYUGGf0I8LLXeH7Nc--

