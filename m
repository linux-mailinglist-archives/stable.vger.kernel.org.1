Return-Path: <stable+bounces-56267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679DD91E504
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 18:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2785528220A
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1016D4EE;
	Mon,  1 Jul 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=wendler.lars@web.de header.b="QA/QlUzQ"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407D16B750;
	Mon,  1 Jul 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850448; cv=none; b=gWcWl82v0WrDxBSOCWi/jGr88SXLINQ4xeeBh6m5Q7sA2csEhjjcTpuydqT+OpJlF0oWt36paAepk6JeGvEUvpnPBoI47w7ZrtBpjbPsOP8Nuf59cXLaK/i18JkTCMOlWJKTKGwoEpK8QnexdNDjdYiI4O2b39CUDysUSOvUocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850448; c=relaxed/simple;
	bh=tEp5w7MyAdLH0DTcYwl0fttbcn3WiIXoF3gGuIxKOwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHIbeQpjvtE2mE6JT6b0q2ef7fZAafVcfA88PZMhDm/iMZHycJaT9DTWbJDmZzlFT9W0ZM5KhSyiRe7s3OcVswf/9LPerBehbNvB5kHxmhbZQsrABQOs3gL8gR9NYdIRcCCl7abtHUz8dm7sl0F51ytWFSMnykeQVw1usfL28wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=wendler.lars@web.de header.b=QA/QlUzQ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719850440; x=1720455240; i=wendler.lars@web.de;
	bh=qbmq9OhbELMMVzqVItX0Z0Vr4RvG26IJ/YtlBtAWJ6c=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QA/QlUzQWf6Rf4x64CL98Owis23ARQzDihZb0hI+zTooLgju87ScPMeQr6TpwsO6
	 2xKofxpfNSU5E0PiTUxgB3TDFQTS0E7YZQXkrJghNVw9qnJD5pJLq4+jNm0faeG/K
	 IH5ourjcujHf6BnUrX/wCZ+0eXIVqlJLdjJWYtBhv44JcrpBMRQv91+HnDzBXDKxi
	 A0NumJ0/Ivm/+Fnyi7VBkOOaFVsqQkbOdi8lvIP8jbyAPLConf6QlheEEuzTcLGZa
	 RQq8VxC5g/oceaWmy1GV/BPR9w89EweBEHl6g1GhGnSWNHq9ZIQmE+YzqKajGwscx
	 FOqLW6MhG5qSl4FRpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from chagall.paradoxon.rec ([84.169.215.76]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MG994-1sepwS0uDs-001HFW; Mon, 01 Jul 2024 18:14:00 +0200
Date: Mon, 1 Jul 2024 18:13:49 +0200
From: Lars Wendler <wendler.lars@web.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, "Du, Xiaojian"
 <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: linux-6.6.y: Regression in amd-pstate cpufreq driver since
 6.6.34
Message-ID: <20240701181349.5e8e76b8@chagall.paradoxon.rec>
In-Reply-To: <fd892ad7-7bf9-4135-ba59-6b70e593df4e@amd.com>
References: <20240701112944.14de816f@chagall.paradoxon.rec>
	<SJ2PR12MB8690E3E2477CA9F558849835ECD32@SJ2PR12MB8690.namprd12.prod.outlook.com>
	<7f1aaa11-2c08-4f33-b531-331e50bd578e@amd.com>
	<20240701174539.4d479d56@chagall.paradoxon.rec>
	<fd892ad7-7bf9-4135-ba59-6b70e593df4e@amd.com>
Organization: privat
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MuoKgmndHIbJ/sj81b.B1_6";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ljjpFkjEpOn2wqvibHTDR3t8CsRrxd9LsIpI3+iZlS1XLtZxbnn
 Pz7unZcX5b7oNgagAFugx69Q4LjaLJ3vf1ylcbczPJ7rrdlzK6OtY/q/CBDYZJjQ5Yw94ng
 xnAFJPj/95m9OmCY3CSWRBXYixAvQKhMUIKFMc/f11skx0KG7eZatLuLrirs1jGB7rLi19w
 gmJkV2pP1pKXs3hhCr7/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8jbhY0sSlYE=;q0docJlicDsV9FLILWh4xG82fWy
 zyCyCcZghrQpSrjaiQCkRQM56M2aWGOGUYIFGu2P+ms1BjppJwNSy/+3lq0KMdE2OkkHflC3T
 leES1Frp1SftJtfS5mj88rg3O6GYvezHRA31UI268tZxf2rDbtkx6wpMZGB/l4dpq5/HU9meq
 n04AVsUI+B+Av3hwUD6QWVInFjDO7GSqhkwt93Fu6O80vbmcEzW37zKOot+VOjJ/NIvm6JzhV
 MDKUWnxHtECYiYnIuH1KNsqnEf5Gg60NmhIJpyyqLe0IZ/ActggIwZ6RyPVao2rdTNmtRgMMA
 t8cc6JVFthcpwoqM/5kG/ljbSlP/2z1/aSGEB9AK0F8KCqXaC8CHIH0nnmK5tgXJ78uPaCURm
 3VnZ1l3KRHuwq3bsGGv+94UrqFVzLaM3ymNeU57D2JRMtQqKoit0NC3KxwSfGhj9joXLlDlg+
 E5y7XQ6Pvsrgu+UPcZOEFHf9cDnFjHGVTogEJcr+kqNrtpI1n4fEWF6hrLkBr97DrBAJnbCIJ
 H/+/jOtFNUbAGJKkjzEEFgr8F8aZ1YzZy4WK5FQUEHMupz0FaddXc710dGa3O/IWdloejbwwt
 kiqPHzG3pjvBz7V8ozmyp9WkMdIFUMPeWvFasG9+CW7GD9h3Ggfw+7enGRa6+ueG3aRvDm22M
 8D7/8rBuOWf6O5Rh8+WCj219JmrFZT0HBJHlORpkUuNv2Gm5r9y6qdL1kHfmOzUS/o9cPM9FW
 vcYbxVclOq7+Lz1KKRYujzFc/6rir1aHQlgf5nZar8Jkicn7ZpRpasWBAp717LRyplzGwzjHW
 /MbO3HnOR64XoJoT/WogQ+4qeUh/CWudRDMiFdmh6YGqM=

--Sig_/MuoKgmndHIbJ/sj81b.B1_6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Mario,

Am Mon, 1 Jul 2024 10:58:17 -0500
schrieb Mario Limonciello <mario.limonciello@amd.com>:

> > I've tested both, 6.9.7 and 6.10-rc6 and they both don't have that
> > issue. I can disable CPU boost with both kernel versions.
>=20
> Thanks for checking those.  That's good to hear it's only an issue in=20
> the LTS series.
>=20
> It means we have the option to either drop that patch from LTS kernel=20
> series or identify the other commit(s) that helped it.
>=20
> Can you see if adding this commit to 6.6.y helps you?
>=20
> https://git.kernel.org/superm1/c/8164f743326404fbe00a721a12efd86b2a8d74d2

that commit does not fix the regression.

> >=20
> >> I'd like to understand if we just have a missing commit to backport
> >> or it's a problem in the mainline kernel as well.
> >>
> >>   From the below description it's specifically with boost in
> >> passive mode, right?
> >=20
> > I have only tested the passive mode on all my Ryzen systems and
> > only my Zen4 machine shows this regression.
> >  =20
>=20
> That's an interesting finding.  Do you know if your other system(s)=20
> support preferred cores?
>=20
> Also as a curiosity why don't you use active mode (EPP)?  Most people=20
> find a better balance with perf/efficiency with EPP.
>=20


--Sig_/MuoKgmndHIbJ/sj81b.B1_6
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWCOBmo8i7LhvVmNAVx3S0DQ8YDkFAmaC1b0ACgkQVx3S0DQ8
YDmaHw//YTVPbeOkFlCmnUFPAUFileajbaH7aAyFl/cOmNXE+gYWUZDB8l8alWde
XXEXDcbXz83NTvjfyCABZbmccAzqOciqzOPHgIcnse8ADHH4PsRtvEEUt7rVSM2b
EMX2BVQVs34mtfcOXai4r74ODxOU/YXAX9yqJAKVT+72YhSiUPURP1DkhwJ5oMTR
82G8bpsINzIl8+43q075mmO9EDDvbas6z5/d2RpJhkJWNPKucljZ7mFDVT10SKsB
t6YRHMupI/3ycxim6/QsrJZWYgXjw4GzCERX79vwTlehfYJ5g6rUCA3fhukR2vFS
oB5eKmdMs9ctTM8GcgjJUFVIz2+MxE7EK2J+LFE2uFncEHL+dTNj/EtN0DM8E+T6
VHxJlzaR0XBl7COiKwXozpNTtmcAewOXfNG0KdUsM8umy4H8jZlrGGEp6jxJySKC
50nwbsSCHUVjLXioLj261KZ5Pa13AlI0vn663i33g2FdzZ+7mi0nHQnysMSkH7+X
MOoj7fWnnXO0WUYlgItJCuICCf03Qxf08Unt9gSl+whE/vJ4qqPtORWpFPTdKKRA
05m83qulKQyTujWo938gCAw2sSNzWNvZso4t8xs9+Stc53AZfBKQ/7g0HOs+iLl4
LDcm6Y8iHI4MS5b+g+ax10Ms+/Ur52Cqe0dI3vcMNDo87Z147mM=
=Uul6
-----END PGP SIGNATURE-----

--Sig_/MuoKgmndHIbJ/sj81b.B1_6--

