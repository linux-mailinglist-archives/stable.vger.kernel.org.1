Return-Path: <stable+bounces-244817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACtPA0Q7/mkroAAAu9opvQ
	(envelope-from <stable+bounces-244817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:36:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 712FF4FB302
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 064D1305B2EB
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D8D317174;
	Fri,  8 May 2026 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vXDeW6mP"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74310284662;
	Fri,  8 May 2026 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268831; cv=none; b=No6PTv7Ab1OogvF2yCEz/jiGB7MYOWLrIgim2IHy/8EwujuzEBV/us0jr/8hKGWsdQXk5ofJPbaWgZNzqcYrEj5AwGf4jEq2K9YxNV33Ib3uCdlFKgKdbiP52BLuas+JQHvr8/SNR/8BKScxlODkJ/13FCcj9zQJmwavHUZiWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268831; c=relaxed/simple;
	bh=po0Z68QQ1/ZSUyD7Gvev6tIJONNapo/tSMTXkxJrSFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JQXY31lnqcmutez+Dxnpz3gS1+eKAjQ/TvBBvFc+9aBV/tDxL7tUQpy2kf6m1WqHO9O4As/UpSzndD/8Qdy0xxKc04yQNO8CeDd8lvszD8QftorI4krWS4iAqgOKg2j/tw2gkxos5r948PAQSEB3sOd6m9v1P2ByvPsQzd1B+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vXDeW6mP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LAuyjdlap5zeX0vYlag/wLlOsjtVBFqwwZbBLzW3UpM=; b=vXDeW6mPEhICdE++TSfL9svNBD
	0cTPKQsWFbHP5uheKuWHKDDJ4BkNaY8L71++bTB85YDO7LNf91y/bhgTjG4o95BtOzROpUwLzp1Hn
	P+w6eY+zlXwHhTyPtxRwTWi3o0qiH3v5icjPAxSa+m645qf9CFn6SoHNYRPMzk6qj1LXvsv3eWQbu
	iz4jXc/UsK1l4JJkKYUGCtVSMVdtrns8Ca68LiZUahMQIaahng6FF5HUMNPY+fuiE34ypPw9iJhWD
	l+bTEJinzrjF7mpUfTE2EZwAg2q15DYbTn+t+e/eGAiXZn7I457InQV6sIdx/vQb9NoCxlpI0yKQx
	7BIKFMgQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wLQx8-005NU8-2V;
	Fri, 08 May 2026 19:33:38 +0000
Message-ID: <19cc282f2e3b821e2dc3930cf5207bc251010307.camel@debian.org>
Subject: Re: Linux 5.15.205
From: Ben Hutchings <benh@debian.org>
To: Ron Economos <re@w6rz.net>, "gregkh@linuxfoundation.org"
	 <gregkh@linuxfoundation.org>
Cc: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>, Dominik Grzegorzek
	 <dominik.grzegorzek@oracle.com>, "torvalds@linux-foundation.org"
	 <torvalds@linux-foundation.org>, "lwn@lwn.net" <lwn@lwn.net>, 
 "stable@vger.kernel.org"
	 <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	 <akpm@linux-foundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>
Date: Fri, 08 May 2026 21:33:32 +0200
In-Reply-To: <f922379b-e8a6-4d38-9589-029a8d52126d@w6rz.net>
References: <2026050835-appealing-stallion-a207@gregkh>
	 <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
	 <2026050829-gladiator-displease-57af@gregkh>
	 <CALUEkOdFEFJ_U1va62B=tWspd2YfLJ-qk72r380wrLRGYfYKPg@mail.gmail.com>
	 <2026050855-valley-slashed-c382@gregkh>
	 <CALUEkOfBS7qsN-7ERMS+2wcPEixXAGmquREu7uv8ecXn6d7haw@mail.gmail.com>
	 <2026050815-length-yummy-f8b6@gregkh>
	 <036ef29e143799f9117792463d640916490fa61a.camel@debian.org>
	 <2026050840-washcloth-showdown-b66f@gregkh>
	 <f922379b-e8a6-4d38-9589-029a8d52126d@w6rz.net>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-P2U3+C5qPrPnskpPunAj"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh
X-Rspamd-Queue-Id: 712FF4FB302
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,lwn.net,vger.kernel.org,suse.cz];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244817-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--=-P2U3+C5qPrPnskpPunAj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-08 at 12:06 -0700, Ron Economos wrote:
> On 5/8/26 07:50, gregkh@linuxfoundation.org wrote:
> > On Fri, May 08, 2026 at 04:38:45PM +0200, Ben Hutchings wrote:
> > > On Fri, 2026-05-08 at 16:30 +0200, gregkh@linuxfoundation.org wrote:
> > > > On Fri, May 08, 2026 at 04:07:31PM +0200, Massimiliano Pellizzer wr=
ote:
> > > > > On Fri, May 8, 2026 at 3:50=E2=80=AFPM gregkh@linuxfoundation.org
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > On Fri, May 08, 2026 at 03:13:51PM +0200, Massimiliano Pellizze=
r wrote:
> > > > > > > On Fri, May 8, 2026 at 2:44=E2=80=AFPM gregkh@linuxfoundation=
.org
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > On Fri, May 08, 2026 at 12:05:02PM +0000, Dominik Grzegorze=
k wrote:
> > > > > > > > > Hi,
> > > > > > > > >=20
> > > > > > > > > I may be mistaken, but I think there might be a small typ=
o in this hunk in net/ipv4/ip_output.c:
> > > > > > > > >=20
> > > > > > > > > skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
> > > > > > > > >=20
> > > > > > > > > Would this need to be:
> > > > > > > > >=20
> > > > > > > > > skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG;
> > > > > > > > >=20
> > > > > > > > > My understanding is that SKBFL_SHARED_FRAG is a bit in sk=
b_shared_info->flags, and skb_has_shared_frag() checks skb_shinfo(skb)->fla=
gs.
> > > > > > > > Adding Ben who did the 5.10 backport so he can comment on t=
his.
> > > > > > > >=20
> > > > > > > > thanks,
> > > > > > > >=20
> > > > > > > > greg k-h
> > > > > > > >=20
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > The new released kernel 5.15.205 is still vulnerable to CVE-2=
026-43284.
> > > > > > >=20
> > > > > > > ```
> > > > > > > $ ./run.sh
> > > > > > > =3D=3D=3D Stage 1 =E2=80=94 overwrite 'systemd-timesync' line=
 (89 bytes) with
> > > > > > > 'sick::0:0:<pad>:/:/bin/bash'
> > > > > > > =3D=3D=3D Stage 2 =E2=80=94 verify
> > > > > > > sick::0:0:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXXXXXXXX:/:/bin/bash
> > > > > > > =3D=3D=3D Stage 3 =E2=80=94 su - sick (empty password via PAM=
 nullok)
> > > > > > > [i] state saved to /var/tmp/.cf2.state =E2=80=94 run './run.s=
h --clean' to revert
> > > > > > > # uname -r
> > > > > > > 5.15.205
> > > > > > > ```
> > > > > > >=20
> > > > > > Does the patch below fix this up?
> > > > > >=20
> > > > > > thanks,
> > > > > >=20
> > > > > > greg k-h
> > > > > >=20
> > > > > > ------------------
> > > > > >=20
> > > > > >=20
> > > > > > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > > > > > index 68509e1f89b5..5d8f8a5901bc 100644
> > > > > > --- a/net/ipv4/ip_output.c
> > > > > > +++ b/net/ipv4/ip_output.c
> > > > > > @@ -1443,7 +1443,7 @@ ssize_t   ip_append_page(struct sock *sk,=
 struct flowi4 *fl4, struct page *page,
> > > > > >                          goto error;
> > > > > >                  }
> > > > > >=20
> > > > > > -               skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRA=
G;
> > > > > > +               skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG;
> > > > > >=20
> > > > > >                  if (skb->ip_summed =3D=3D CHECKSUM_NONE) {
> > > > > >                          __wsum csum;
> > > > > Yes, this works.
> > > > Wait, is this also needed in the 6.1.y backport as well?
> > > >=20
> > > > Ben, I'm guessing you tested the 6.1.y backport, right?
> > > Yes, but on 6.1 the PoC never succeeded for me even without the patch=
.
> > > (On 5.10 and 6.12 it does.)  So unfortunately that testing could not
> > > show whether my attempted fix was correct.
> > >=20
> > > Sorry for screwing this one up.
> > Not a problem, thanks for doing the backport at all!  I'll go do a new
> > 6.1.y release now.
> >=20
> > Releases for everyone!!!
> >=20
> > thanks,
> >=20
> > greg k-h
> >=20
> Doesn't 5.10.255 need the flag fixup too?

In 5.10 it was correct to set this flag in skb_shared_info::tx_flags:

static inline bool skb_has_shared_frag(const struct sk_buff *skb)
{
	return skb_is_nonlinear(skb) &&
	       skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
}

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-P2U3+C5qPrPnskpPunAj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmn+Oo0ACgkQ57/I7JWG
EQm+cRAAzaxMjmhJwEPpcBJq35BzbBlEZNGk5OdcidvieOaPA/h/Z1P0RHOGp1VV
DEiaHd7ktNN0UHe+lEWStmiX/Pf+tHdpjTnHfds7EBcrBHrWKs1wNjpkICYzvzon
+gWlAPZWDpOT05YTyN3OiaVvSgjfyQ00jjX/vGteSxWbnd0GgPkrLPMQXaLs9QEB
HCEZ0CNxI+2eL67Qus2EwNWLIiobS0ejSWwyj1pf4M9Z2PkzSxKCMbZfQctsZkCh
EXGMcw4lStvwjZ1DKRZ3L5HZwohmPe1qNtoakJvGJrKa0DL7yRr3dM5c61QH2i2u
IK3gJh4MeL7fH2mz2CoiGWONkAqbFmipbvuSZ03wfTJPb85KEKqG8zcdynFaMgZ/
usuj42k5ynsImReiLMFDmzCblVh7N9Ac43gapSAwwDtZP5zkyhs9vP30ojcXAdqP
cTUc2IbekLZTP+ip/f0jPb82wQUpdPNRGhHN39ns+dBLQMlFm9Cuyk5//MzEqOFF
F05bAmjnspP21uc4Rxm3c9X1oGjY/7cb/N6/LjXWL/MDejbajmNcgHmvRgHlqQL3
Xs2zXdf9eGLRHsK7EDjNW36YvP4jxuBLR2BDFT4DDoGZN+2k7CCAstYPVCAUglJ+
FQ3luMNU5Z1Ox/s3kMzdgbBP+odxgeph1pbY6Qqm6jE9ybN5odc=
=MPhD
-----END PGP SIGNATURE-----

--=-P2U3+C5qPrPnskpPunAj--

