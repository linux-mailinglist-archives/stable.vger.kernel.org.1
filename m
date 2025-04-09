Return-Path: <stable+bounces-131947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94568A82631
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 15:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C328C7340
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E325DD13;
	Wed,  9 Apr 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="l8o4HGu6"
X-Original-To: stable@vger.kernel.org
Received: from sonic314-20.consmr.mail.ne1.yahoo.com (sonic314-20.consmr.mail.ne1.yahoo.com [66.163.189.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74226218EA2
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204864; cv=none; b=Md6n7nlipy7DCdOiTDAt2RWTBFyPf5sx1a+XW/W71H33uerKHMpl7Cwm67G2WJHARSvEJa/b2Ioj+/9L5ZTssuzAlFAnwBi+3SqE7kDiIDyVhactArimZbjCWcL2Jsu+/QNxm3t17ExjR4xKwezOTqTrfS8/OoqmUb/p0ZTa/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204864; c=relaxed/simple;
	bh=DmhUiTxWM15kAj6iKf+nRYCNQwtSNUVvoxOL3+hEcAo=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=UyLIxUbhkDOeVl9Wk+TuhVGyD+yo282gcnJ2a4ATFuKWls1iDpUIr2BrRrMyEz7H69GW72WGBA1W5cWNZ4deRbyA/K+i8y0GnM12LRN+IEbu3ouIgjfKlPTdmUi6Yh6vcySoHvaXzQNv+7OWlflh/oWWbzmeTrR3g4dIQLMonbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=l8o4HGu6; arc=none smtp.client-ip=66.163.189.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744204861; bh=DmhUiTxWM15kAj6iKf+nRYCNQwtSNUVvoxOL3+hEcAo=; h=Date:From:Reply-To:To:Subject:References:From:Subject:Reply-To; b=l8o4HGu6KEbGhgrEPhWMb69pouHre0MFUqBVR2L7M4JPpy2fpwe3ev1xz3/Ps8c1houEYeX4W/y75TNxEQZuXzT+G/TGoXXFHKwpOZSuk+Lu3QF+gSUssR76GAi6TeOFrjAA31TRoAELDKLb0FIA2tz5tbbNZI/eZHV0F6ztlVYzsoJtVyI42GtEaEaPYEtCLLCTrPgQnN84TrHhGbseBfaP+vQhyr5KP7RXD+7eKjE2Wyz/hdnoFt3wgIqAJYkEJY9BsT2AStvGIeN2TLgiorJdlYYEYP0b+n2AcEbOdi8EQc+1JInmf9Uq7mGlnjr8+9/E821je3oGqGm52VyEsQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744204861; bh=5Jy9qyGsA5JhPvCOQ+D2CAMlfvoIOEG3+E5a0de9a14=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=PAAU4NR93lCaxJDpXYWnNrKmw4JB7XWjDxQtA+hf0noIelkcV9hJ0yy951bkeRArSGxEvbfjhQ8XuLvqnIkWK74jvr04bG3BpGkWb0gOhXpAlKIdFqkJ2T2xt2zjBtmXxjKHWKzJrgk4yACQIGheOMLNqrTf6iyAp8f68nMb1kwAO193HkzrtbSWjJmTrQPqqMiKGrnOwLyxpd0nx8ZunOZmyN2tg867QFyUJhRvzwQ5Bqpc9GICcpZ6kJiYOJKxo8Lb6+sVSNhsmE05pkREGhqUxGhIMyjlN8H09a9fCUUAPaR2irMfeGKXDIyx5xyt0Rz465K5jWgqVfQj8iP+2A==
X-YMail-OSG: rJmavj4VM1makiQBj9N0GJ5UzFVc.326NK7ft7kIPPk4zEj60wbpCDdFyQ0b5lA
 ZErI6GfbfKNaWIXScipQqNhRejA1h_6MdHfq2qo8kGjUJikGosklk73AhXFD1mNXtf6I4Gff61M8
 T5EOsdnliy.ZpGWaPMQgfKJg5BLN2aGtmcYll_fkINWLnA_ztEr.7HNZyBdvmz8RddH7JhUQCnnt
 frzTH7xn1zPVShi4olf.h1mHyaczCQX2_e7m0ilIkkjp6tbotUN30GwgzY5NKbGkTJ_h5i1TNNvN
 XkSUT9xz35qFciw61AmU8fCX7ACjwoSyVFwBJkcI5Z55UAgsn2OliYvoThLvdTzzode.sgNJG9ms
 UQIDahqNZumhIYpHTiYv18vcmQUiELxu_G4oBQ_JaAOYfQ7i91znss8Pj8.uhjoqYU1VwBMXWnHe
 U_48cFza9myg8wjpnXavqyo5jCUsCMtUisGZP7OnW2PVtEWkD.ITjdh1Al26W.XiCJBpis__XKJ4
 csfQ4Lhfb6p.WpTqyLNrGBXkkF9sSBKJ6xD0qksh1jyQdNaOnveCuxLSR5MVC0gvI_0EhQoYq2Md
 R7wh4by6d9MmClU3Zy0fq6kj4RoumkkR7qR.eqf1C7jz4Zh3Quia1pNraiKgP_yf2fw0u6J5.ybT
 c1RA8ekN8OYic8s9zsOerz0CN3OYeE0JKvnc0ZLcYKVp1UNwZybiPTS4SU31LOYkMUG4iMy.c7vC
 QNmLKArzrFWiSKmiAVizqcMCvHI0WTyleCtIq.RYhjOQ8.WThhF2CT.oFSaCdZovrq8VsWEk7vWG
 kEVMur9rhwop.TdMg5.oxg_RQFsRsr1o2eYeJbfGqZgGdGvM8xGGKNUAlKeEV9p5YvLXZJeTRZfW
 2posyavcfGlEg4aDbnP6wbQClb7eP.m4C_D9n102HLlGbBINkh3NTAaCN.JelOGeXXFmx6QA_dWN
 JF.Tv2LshIAFJrrZzXRQDszzGp7DxR9n5s7JNLiTSMiUSrqvmKDzHARNWc7ngAa6FMD5azOfQfYx
 k4cMRaRmvEOwiWfv2YiRmPnLixxNvbiupFNKl8seoTKMtqhKawPrv4XW1NvzlD44lyYhGClXjpou
 4sU9KjxRvlJKCApxRf7U4wpYfHbLwA5wnnBotJHdR_73LhEqrd5AcCzuZpn90yGZP7y87G2OXDrL
 6aLRGr1NW_MyBkcSaBT6P1q3p4a9c6DLykp3U80ajxrQeL3uKscxtY6YFPbxjjut7rV407NvSnv.
 sFj9yQjCtkoVktIaKzZRhKR_E4XmBKqESOUeKBUtU6kLtcEoBKWupGFUF10v3PKfBe2bjeGIDcjJ
 CPc66IwV5GHUVCCSp0zIixfyUEv9LmdsCTlkIVXdf3_S1U2S6ytBhMGxSHG0ohcdMcC3zS1KTOyy
 HhxFDgfqc06.216nVT5BfIKQ3hy8byU9ZI7Feb3brCjADUnXYPn4O9GZ8s9OyhCZmQSD11a1uhFx
 nw15jv4txjB.uJAZe7b9mIyNGiayiR4C9n41UBokEsqz2ThSCP0rPuzXzI.hEBJ4tiOAXzmuClZB
 okaWISj3fUkHjL.T8v_6gDGFSjqX62zRDWFlcFNEbwksh9G_TG8N1P5lBnT6LSr1G7wvuU6lCTQX
 cR_WDQ1PvqvQqvERPQTPEAEgznzAjYvkzDH2FCFK5kP3dIaiA7JVMoJuu6bvMzk1aqsFE7TXUsCq
 Bkf3A1PpSxzVlXRVk92NWginVu2FuEcm7_y3U4HC2VER76hukLm6.R4dwOYNuHYnP9L.kd369aGN
 xysgB_5CdvVfl6UbL4C71aPLwWSYOg3yl5.ZzyamuEsIBIl_442TfQL8OcesxJY_RGvFGwr.1Xo.
 tGeHUxipxKkWIIAFDg7IR3tKzoYFxzyJ4zWiAwW6hIOXksUr9kYo5gR8PQsgnTIDI5KuHld0DGzO
 YcigoSZfpH0TZ.Pn.SshylZCMEkgSenCx34k8yAsQU2Lnw7FxFoPQU60jKKghLKqMmq1ikvE1q0y
 pWzw3llB81e7rbUEllP.EMO9tT3ADfEPRzw7lRyKl.BszUEUtc3OsvyesFMi3Or6IYXOVQJMYd8v
 B.rp3QM_tSSgvGtyVSAHFZWrxkVxtYDOWUyk4ss0mrRSmGsvNrdWGxIZo2oPwKsLN8iwO.dE0YaQ
 iD7aAYY6V0WS2hOxWbEEBPWxZYkzb1sTesAUzMxDWJQ41UtMCEdRep.UR5p9C.ALvOEg-
X-Sonic-MF: <emoriel17@yahoo.com>
X-Sonic-ID: 356f85df-4828-4801-be26-5b98567ab52e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Apr 2025 13:21:01 +0000
Date: Wed, 9 Apr 2025 12:30:23 +0000 (UTC)
From: moriel5 <emoriel17@yahoo.com>
Reply-To: moriel5 <emoriel17@yahoo.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <1110488197.3499072.1744201823968@mail.yahoo.com>
Subject: Broken S3 on Asus Z97 Pro Gamer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1110488197.3499072.1744201823968.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.23590 YMailNorrin

Good day/night to everyone.
I have had S3 sleep broken for well over half a year at this point where th=
e kernel simply crashes upon entering sleep, and the PC turns off (literall=
y stops pulling power from the power supply), and turning it on, at first, =
causes to to run through 1 on/off cycle, with I believe is a diagnostic ste=
p on this board, as it happens whenever something causes the PC to unexpect=
edly turn off (unless the source is external, like a blackout, in which cas=
e once power is restored and I turn on the PC, it turns on normally).

At first I thought that it might be an AMDGPU issue, however removing my dG=
PU, and also, the rest of my hardware, changed nothing.
However I have had at one point had asus-wmi try to put the system into S0i=
x, despite the firmware lacking support for S0ix, and now FastFetch no long=
er prints out my motherboards model number on the Host line, instead just s=
howing ASUS MB, so I have reason to suspect that asus-wmi may be the culpri=
t for this regression.

Unfortunately, I am unable to procure logs, since the kernel crashes before=
 anything meaningful is logged.

I know that this is not a hardware issue, since on Windows and older live-i=
mages (Solus is my distribution of choice) these issues do not exist.

I am unsure as to which kernel update broke S3 for me, however I believe it=
 was either late in the 6.10.x cycle or the 6.11.x cycle, since the Solus 4=
.6 live-image has no such issues on 6.10.13, which was also our last 6.10.x=
 kernel update, and I only started experienced it when we updated to 6.11.5=
, our first update to 6.11.x, and updating to 6.12.x did not fix anything. =
The current Solus 4.7 live-image has 6.12.9, and my installed system is cur=
rently on 6.12.21.

Hardware:
Motherboard: Asus Z97 Pro Gamer
CPU: i5-4570
dGPU: Sapphire Radeon 540 4GB
RAM: 2x Crucial 8GB DDR3L@1600MT/s, 1x Crucial 4GB DDR3L@1600MT/s
Storage: 500GB Western Digital WD5000AAKX SATA3 7200RPM HDD
DVD Drive: Lite-On DH16ABSH
Add-in cards: Intel 3168 PCIe+USB (by means of a simple adapter) VIA VT6315=
 Firewire 400 PCIe, MosChip MCS9865 Parallel PCI (over integrated ASMedia A=
SM1083/1085 PCIe to PCI bridge)
PSU: Seasonix SS-860XP=C2=B2 860W

