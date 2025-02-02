Return-Path: <stable+bounces-111958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77814A24D48
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F81B3A2802
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3FA1C3BEA;
	Sun,  2 Feb 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="g62jND9n"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC18528E
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738488426; cv=none; b=KdnrSzxe2diyhLBD20aks4Mh/g10yhsl2Mca5Ryv9a4GDP5hYQIIsopeS4RM6y7wi5PvgOitBiRB2nk+55ZWwORhVcqGF8Dc5ZFYOwJgjIJwmvbn/2o4EPz5pZa8HXj/OD1iGSHLsnOvPkTLdB+/2XcPETtaru5xZGxF4gjICCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738488426; c=relaxed/simple;
	bh=inNoeeya3Z3kNOhz2JZ01m6Wk60ZO4TuWq8wITeqdT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVejv8wqyPXG9m03yR/oli2TqCDwI7ZDtTzX7KsgJKrK6DlHy2pjxhTfofW4irEXMV0Cl8JZxIH9s7JBzOquJHYZf5kowdfCfKySLEES8MXXGegvcDAqSrHqlud6u7ljs6CZ/bk0VXpM0JUnLhzy3eKzN3u+QNHFsLRrIIN+YFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=g62jND9n; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1738488411; x=1739093211; i=christian@heusel.eu;
	bh=inNoeeya3Z3kNOhz2JZ01m6Wk60ZO4TuWq8wITeqdT4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g62jND9nC7Yu8hLy9FDAGWU3UpNPNJEWys/HgEtlujwsB6+g2QsBGFXXtkKm3xZC
	 iYu4QW239XythK0Ee+SLYH2joK0xjyYmCxKyiNwjznP1/7WrqmEVpZmUfY3icFmYN
	 eoez00M18JBUsfsPhn+Xl3a6saYc0wv5i+tMyeCqmgopSankkWmG6psY2Dp+iu4V/
	 zOmL9pYrjMrczFjo0VY+yClbiOit9OXp8DCWiN7DqAc9qYnMk0izvkLoZh4bZVbJW
	 8hS1+TlBS9eAhJL3YXuj2fCGmYm0n45d1i0Im9aagB9mWkVwTC28XfREP2qpNv/xc
	 /gFDl4UP7DvN//g7JQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([85.201.80.150]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MTiDV-1u1NEV3Dx7-00OzKw; Sun, 02 Feb 2025 10:26:50 +0100
Date: Sun, 2 Feb 2025 10:26:49 +0100
From: Christian Heusel <christian@heusel.eu>
To: "Ahmed, Shehab Sarar" <shehaba2@illinois.edu>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: TCP Fast Retransmission Issue
Message-ID: <fa131e75-7398-4add-8665-333b92bb500b@heusel.eu>
References: <DS0PR11MB77682EBD149E7965F1D8E8F1FDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
 <DS0PR11MB7768A5B80C9BF2366CFEC89BFDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
 <f86dd0f6-6a2e-40f3-b0be-d9816ccb20cc@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pdou3xkbdw3rclph"
Content-Disposition: inline
In-Reply-To: <f86dd0f6-6a2e-40f3-b0be-d9816ccb20cc@heusel.eu>
X-Provags-ID: V03:K1:YD1GHiD6TWjPs+5ut6u4eYdRLry6OGktT764oaLQwhVFihoNKMT
 Y+odj/wmWIxR0wC2l6Rb/efJHyAKX2NhKxP2C+J3I/GDu6YE5sfeLp3uP85THBz/2aebrKm
 EAnqJZsToqUjT4Tno6IK0hOIoa4IUzZU/toBo9glmJIF5SDmexgwWnUC6P4azXkOVIIX4Ia
 0b0IvPGl41Abrq5hSG1pQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FlJoDDHhkiU=;1cOjWEAYL48s22JEW51Pa4+m6Oi
 DYj5lvLs6r1aRK/zllA4lE+69IbKsorQCU3Sh9B7b0gW2SSXrYFSTFZzxkHylt4Tkl6CNNwcN
 XN+dC0abi/I/r/ZcpsquCrtptY5eWhKvRKS9QkjnyE82immBTSibBQKjarDOx85ZCIiyBZcH8
 rmVmA9Zt9nklKDg/uo/klvZjRK9tzlwu5EUjB9E8xq1KTXupHIuEH9JzIOPCp0kepJB/Hnk0o
 uFO+info/vpdLqZ7AHoCjfvJ/RhuMxipOgUcS3Jk0ePql7FnafVtZQ5mkB70sR3oEWJCzKvva
 LEOzvu3jA6S+i8vdfsBDAJLcJInj/N+PjIY5EFyRhAWFyRC9D+CCKGAwS27OqQCP6F8+KDT0y
 h7sbmrtPpQGwfWk2of4uvaqPLQZcVW1UrTYiM37LflCq3bhJqxzO/KElx8O7MthjcXOieSBgU
 RxHjE0d/76Bsf8p/F4Hd+5C7ERkiNwkdsZJrIEN7plm2lmzMbbOOxTFM6+M4Q3gUtQpaMdgNy
 3WYyE2bDTS08zhavaoOgjDtZj+PurpsVU83CSkvmi/EKJOkbyv0qVIUdKt0vi0lfCKRUq/q+5
 m6p+spWz3Dsp2z26Hoedm9HH5qfcM3o3Jyz+vIJK+CZCEBh9ghImN7r7ezGJ8uLxEgy+afzA1
 JOFya9UMyH+28BGXenZIzBzycNdEhCvTEcjeRcfV80f8TSnDYxpbMuxRURqErUHMAOF1q1fVh
 L3X/h+QXyhjSwIkFJivy5p1Jm5fZCnSX9GD1KchZ/u/m6wTQFw3sfASbyW79GNRL6AvmdWeuv
 gHmsbjKo2r8R1fwoNojgebk18A8sdx8LZDMGh+Rw70NCXfdGVsLR6HarwnC8uSRU3FRAxlRb9
 au+eU5jXkq+3doUDoy8V8dS+SwpvYkHCTreT8+lkMViLAzHW3E7tg6J/9Tm7QAfSXVSQFcAQH
 bSYWEaFTwKQswHpZwRIxbZIaO9Z6IWT7ZqzvErZLJiHJuTHBUpA6qPB/IvPN/rFMsFOAPWamk
 cOYtR3bFW4t9KqXhFAD2TPdZK6kVSIcO02qtXvC9zP1N2pjMxSw9Q2Qd9oHx+6RutMi8nHW9U
 QlHmFXirKBxjSW4CgKM825ZGiDqR+rOTs12XmENbwsUzG2Z0HrMsGPqGt75gM5xaFQjuxkdRx
 YR5NM/kOFBRyqUl3+NaaBB8gKucUfW3XyK0dE/FqxeO/eyw4qY7lKz5RYrCLTVw9EboGYiC07
 570ufMN8lxHfAQKIxvHj/iSaUPRzZUeR2w==


--pdou3xkbdw3rclph
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: TCP Fast Retransmission Issue
MIME-Version: 1.0

On 25/02/02 10:26AM, Christian Heusel wrote:
> On 25/02/01 07:09PM, Ahmed, Shehab Sarar wrote:
> > Hello,
>=20
> Hello,
>=20
> > While experimenting with bbr protocol, I manipulated the network condit=
ions by maintaining a high RTT for about one second before abruptly reducin=
g it. Some packets sent during the high RTT phase experienced long delays i=
n reaching the destination, while later packets, benefiting from the lower =
RTT, arrived earlier. This out-of-order arrival triggered the receiver to g=
enerate duplicate acknowledgments (dup ACKs). Due to the low RTT, these dup=
 ACKs quickly reached the sender. Upon receiving three dup ACKs, the sender=
 initiated a fast retransmission for an earlier packet that was not lost bu=
t was simply taking longer to arrive. Interestingly, despite the fast-retra=
nsmitted packet experienced a lower RTT, the original delayed packet still =
arrived first. When the receiver received this packet, it sent an ACK for t=
he next packet in sequence. However, upon later receiving the fast-retransm=
itted packet, an issue arose in its logic for updating the acknowledgment n=
umber. As a result, even after the next expected packet was received, the a=
cknowledgment number was not updated correctly. The receiver continued send=
ing dup ACKs, ultimately forcing bbr into the retransmission timeout (RTO) =
phase.
> >=20
> > I generated this issue in linux kernel version 5.15.0-117-generic with =
Ubuntu 20.04. I attempted to confirm whether the issue persists with the la=
test Linux kernel. However, I discovered that the behavior of bbr has chang=
ed in the most recent kernel version, where it now sends chunks of packets =
instead of sending them one by one over time. As a result, I was unable to =
reproduce the specific sequence of events that triggered the bug we identif=
ied. Consequently, I could not confirm whether the bug still exists in the =
latest kernel.
> >=20
> > I believe that the issue (if still exists) will have to be resolved in =
the location net/ipv4/tcp_input.c or something like that. There are so many=
 authors here that I do not know who to CC here. So, sending this email to =
you. Sorry if this is not the best way to report this issue.
>=20
> does this cause problems for real applications? To me it sounds a bit
> like a constructed issue, but I'm also not really proficient about the
> stack mentioned about :p
>=20
> I'm asking because this is important for how we treat this report, see
> the "Reporting Regression"[0] document for more details on what we
> consider to be an regression.
>=20
> > Thanks
> > Shehab
>=20
> Cheers,
> Christian

(forgot the link)

[0]: https://docs.kernel.org/admin-guide/reporting-regressions.html#what-is=
-a-regression-and-what-is-the-no-regressions-rule

--pdou3xkbdw3rclph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmefOlkACgkQwEfU8yi1
JYWsWQ//enVk+r09f42STqtlW1PW3P73k7s5d84+MBgIpzGQElQW2b6ZIcla3AhZ
0DVunS34Eereg+NbEbrQupzv2qOGMeukaAst6VSs+grnXguUYWBTwTKg5oPXlrp9
gQ3Cw4Bs75FC66qg/8PxQG08PKwrbGW0foPMxECO2Mw5GkM0jvaoidCHVgVnly6+
wl6+ms5cgeB5l8dpEtCid29V01OlZsYHdOOsatb2t++l8alYECXe3oplgaexARmW
TgIOGcMJAMFhzXMNNfqGsDSZ8USPV4Nal4anCsIhlI5peoXs+MmfJWblj4CCj8P6
aAs3hvFTWhaaEGNDpe6TLRwK7XMfnTUHCvTiiLbwxP2DhNp1bql35UBcPyqNc6pM
onJrTxB3+yjo4vUhgX0Kn/0k2hjhKXa9gxqLt1q8oroN47UbyDOhXC5hy0P1kTXz
aPTzFg4uKw/e1ZFL6GK4Rb1NCmJ41lQOLrNSyIIV3QTzOMTYNK9xHM8EY19ZP7ZF
kFfHhzsm8MNk9sAFLgGbaibpnXWOEW3JVV5QIGIL3JA1gFIq8ZZqHlyHTbELW7vs
BRGRriat0s6Ti1verOY4CDcKuA+VYlyWsrXqWjshh2fbNeePKwM4ApJ1OyDHWR79
zGA9D1stv7mbkzmY+FiTI/utme1VrHRkUR6cp3bLzA8Ze/2Wn/A=
=ZYSx
-----END PGP SIGNATURE-----

--pdou3xkbdw3rclph--

