Return-Path: <stable+bounces-70285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6348295FE6D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 03:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880FD1C2154B
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 01:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CC8F40;
	Tue, 27 Aug 2024 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kE6fHyqr"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6961749A
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722983; cv=none; b=ZXlif28Jr8ga2NtblC4JUtkOw+Fsg3+CCrVGgrJ0Ru9jADr70ayHdo0iYPU1PcJZjKqeVo7NvpB1NO0vweCCqwrMmOaccV3ejTZBG3LxQeavpFSfWLJUIStJZtYUP0FGbT1N+b4V4HKOO2vxvmopJshpUqHGR0yGznmyzVwjSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722983; c=relaxed/simple;
	bh=FX3f2Qv2jDQ3tc/K83Ikx7MleTT7aFx2ZpWIZhl1WLI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=saAMXRlz+KpmjGr4WtS7948Ke0bd6gskGdMeZ9+kz6lWfFdIPwGkOxfuDqyvm6hKuWiPi+CB8GdbgkxmmnnFPwFB69vCPr8nnGPMJBRicRu8lrl+CA/ulPyDkoYDkSSKStNHMcG96NuW8gjJF9mBGBHHjEa4ukwRsmgDa5McTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kE6fHyqr; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240827014257epoutp0458537e2cca6b49fbe7eca8efa7092265~vcmkOQapT0663406634epoutp04b
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 01:42:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240827014257epoutp0458537e2cca6b49fbe7eca8efa7092265~vcmkOQapT0663406634epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724722977;
	bh=FX3f2Qv2jDQ3tc/K83Ikx7MleTT7aFx2ZpWIZhl1WLI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=kE6fHyqrWOP2OzlaTWyspvDSJAYiOOdmSoDXqqwrz0Jjdnqc2HxDPCdkE7pXaYKL8
	 mZhCeLUivaXt51iij1uMLuYmPlsYlGxo16/bQplLqMKZ3Kb3RJ05jNw7PLsiBRUQbf
	 Nufc/v6lGmj1aRQzqM9+vA90sLTlMguLCBdxfA24=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240827014257epcas1p14de210a06fcbc8963513301b910d4b47~vcmjy-9oa0785007850epcas1p1m;
	Tue, 27 Aug 2024 01:42:57 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.222]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wt9KX74KYz4x9Q4; Tue, 27 Aug
	2024 01:42:56 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DD.03.19509.02F2DC66; Tue, 27 Aug 2024 10:42:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240827014256epcas1p233930a9e49baf908a8226cdfbd777091~vcmi5h6Ja2060720607epcas1p2x;
	Tue, 27 Aug 2024 01:42:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240827014256epsmtrp10ec1fd07e50997950f57d931a3be4126~vcmi4gw6S2843928439epsmtrp1H;
	Tue, 27 Aug 2024 01:42:56 +0000 (GMT)
X-AuditID: b6c32a4c-10bff70000004c35-12-66cd2f203262
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.C2.08456.02F2DC66; Tue, 27 Aug 2024 10:42:56 +0900 (KST)
Received: from sh8267baek02 (unknown [10.253.99.49]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240827014256epsmtip2dba87e612c33813aa97e044b8b43e5be~vcmijgz1N1297412974epsmtip2C;
	Tue, 27 Aug 2024 01:42:56 +0000 (GMT)
From: "Seunghwan Baek" <sh8267.baek@samsung.com>
To: "'Adrian Hunter'" <adrian.hunter@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>, <ritesh.list@gmail.com>,
	<quic_asutoshd@quicinc.com>
Cc: <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<junwoo80.lee@samsung.com>, <dh0421.hwang@samsung.com>,
	<jangsub.yi@samsung.com>, <sh043.lee@samsung.com>, <cw9316.lee@samsung.com>,
	<wkon.kim@samsung.com>, <stable@vger.kernel.org>
In-Reply-To: <7164bfde-3c43-495f-8e1f-83b998ff17e2@intel.com>
Subject: RE: [PATCH 2/2] mmc : fix for check cqe halt.
Date: Tue, 27 Aug 2024 10:42:55 +0900
Message-ID: <000001daf822$70840e10$518c2a30$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJuvxDFnMLAOlvZlfnWGnWQ3NmNqwJctd59Asipdhaw6ZsZ4A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmvq6C/tk0g5aZBhYnn6xhs5hxqo3V
	Yt+1k+wWv/6uZ7fo2DqZyWLH8zPsFrv+NjNZXN41h83iyP9+RouFHXNZLA6e6mC3aPqzj8Vi
	wcZHjBbH14ZbbL70jcWB32PnrLvsHov3vGTyuHNtD5vHxD11Hn1bVjF6fN4kF8AWlW2TkZqY
	klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SxkkJZYk4pUCgg
	sbhYSd/Opii/tCRVISO/uMRWKbUgJafArECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y8LKuywF
	Mxwq9qw9wtzA+Mm2i5GTQ0LAROJt0yO2LkYuDiGBPYwSEzY9YodwPjFKvHh0Acr5xijRcmUW
	M0zLlYZlUC17GSWWb7/LCOG8BOr/+p0dpIpNwECi+cdBsHYRgUOMEvPab7CCOMwgg7f8OcbS
	xcjBwSlgK3HrWQJIg7CAmcSl721MIDaLgKrEno4uNhCbV8BS4sTlr8wQtqDEyZlPWEBsZgFt
	iWULX0OdpCDx8+kyVhBbRMBJYuOsB8wQNSISszvbmEH2Sgjc4ZDYtGEbI0SDi8STjzfZIGxh
	iVfHt7BD2FISL/vboOxiiYUbJ7FANLcwSlxf/geq2V6iubWZDeQBZgFNifW79CGW8Um8+9rD
	ChKWEOCV6GgTgqhWlTi1YStUp7TE9eYGVgjbQ+LmtB6mCYyKs5C8NgvJa7OQvDALYdkCRpZV
	jFKpBcW56anJhgWGunmp5fA4T87P3cQITtNaPjsYv6//q3eIkYmDERgBHMxKIrxyl0+mCfGm
	JFZWpRblxxeV5qQWH2I0BQb4RGYp0eR8YKbIK4k3NLE0MDEzMrEwtjQ2UxLnPXOlLFVIID2x
	JDU7NbUgtQimj4mDU6qBServ2X8yu99bP/8eWn7j83OLAvNnIiwVVvfsRMQbw5cy/wvO5i58
	ffPdraqsjdcbhSwUnN/HBZ8/76905z9b0q7fpersfe++MGtPae42/sDr9pDf4rjLuvSw4N53
	L/c/4jcqn9CwYOfZ+PkfPh47LZ3h1aN0e/Witgu7N8jY/36au0pIftvmV9wbcuTOnkvotGD5
	G9WUduS67YtFS2cE9C/PCdP+I3r1+7MPTbwzC2c0fCyY8MNbauGCQndZxTYX7q6DOj+mfDWr
	/uNxvLfBZfeG178Sb038GX/oyG+tNVvX/65OshELOnrt7dXtGSWJNnU7lSddVkrOq7i51/Tu
	8vxrWgndq8x/VHaxfjS3UlZiKc5INNRiLipOBACzAP8fXAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvK6C/tk0g4/XeCxOPlnDZjHjVBur
	xb5rJ9ktfv1dz27RsXUyk8WO52fYLXb9bWayuLxrDpvFkf/9jBYLO+ayWBw81cFu0fRnH4vF
	go2PGC2Orw232HzpG4sDv8fOWXfZPRbvecnkcefaHjaPiXvqPPq2rGL0+LxJLoAtissmJTUn
	syy1SN8ugStjT/9T1oLFOhVPOhtYGhj3KncxcnJICJhIXGlYxtbFyMUhJLCbUWLhtRnsEAlp
	iccHXjJ2MXIA2cIShw8XQ9Q8Z5SY9rmXGaSGTcBAovnHQXaQhIjAMUaJWUdXM4M4zAJ/GCXm
	nJsMNXY/o8SH7rVgozgFbCVuPUsA6RYWMJO49L2NCcRmEVCV2NPRxQZi8wpYSpy4/JUZwhaU
	ODnzCQuIzSygLfH05lM4e9nC18wQlypI/Hy6jBXEFhFwktg46wEzRI2IxOzONuYJjMKzkIya
	hWTULCSjZiFpWcDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhOtbR2MO5Z9UHv
	ECMTB+MhRgkOZiURXrnLJ9OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpa
	kFoEk2Xi4JRqYKr0sl+8UevNj4htK+vrN+5m+5D+r3il/IX7e95f8lhi/jiF3cLo7ZmeatMa
	OZf5U0wq7sm/3//9P7NSdVX5hJKQena7qRd0xKNSuORe6M5RcvdL3Cq3WG0ry+OS//+Zy88U
	3WDT2mfeFLvmVu1Tu7eBd7NlmmNY278L/Fr4s2OnfTDrnfognp9hG7kD+NZG7ri7wGpF9Qp+
	r81vPssdy557aIbF6ap9Tp/n8IWYCe1o7nr9Mmcal6vTWxn27J0zL//fvukLe0/d58WsbMr1
	EqEP/6gdlY67UqJYwvvh8wvFHZOfMNRcYl2xSin5ovT+4DsyRU+vre9Svb9wv/Z29112cVxH
	uh9O6y1/wNKwZKUSS3FGoqEWc1FxIgBt0xGgQgMAAA==
X-CMS-MailID: 20240827014256epcas1p233930a9e49baf908a8226cdfbd777091
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826091726epcas1p19797d2dd890feef6f9c4b83e9156341a
References: <CGME20240826091726epcas1p19797d2dd890feef6f9c4b83e9156341a@epcas1p1.samsung.com>
	<20240826091703.14631-1-sh8267.baek@samsung.com>
	<7164bfde-3c43-495f-8e1f-83b998ff17e2@intel.com>

> The subject starts with =22=5BPatch 2/2=5D=22 but is there another patch?
> Did you mean =22=5BPatch v2=5D ...=22?
>=20
> > To check if mmc cqe is in halt state, need to check set/clear of
> > CQHCI_HALT bit. At this time, we need to check with &, not &&.
> > Therefore, code to> check whether cqe is in halt state is modified to
> cqhci_halted, which has already been implemented.
>=20
> Doesn't compile:
>=20
> drivers/mmc/host/cqhci-core.c: In function =E2=80=98__cqhci_enable=E2=80=
=99:=0D=0A>=20drivers/mmc/host/cqhci-core.c:285:13:=20error:=20implicit=20d=
eclaration=20of=0D=0A>=20function=20=E2=80=98cqhci_halted=E2=80=99;=20did=
=20you=20mean=20=E2=80=98cqhci_writel=E2=80=99?=20=5B-Werror=3Dimplicit-=0D=
=0A>=20function-declaration=5D=0D=0A>=20=20=20285=20=7C=20=20=20=20=20=20=
=20=20=20if=20(cqhci_halted(cq_host))=0D=0A>=20=20=20=20=20=20=20=7C=20=20=
=20=20=20=20=20=20=20=20=20=20=20=5E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=0D=0A=
>=20=20=20=20=20=20=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20cqhci_write=
l=0D=0A>=20drivers/mmc/host/cqhci-core.c:=20At=20top=20level:=0D=0A>=20driv=
ers/mmc/host/cqhci-core.c:956:13:=20error:=20conflicting=20types=20for=0D=
=0A>=20=E2=80=98cqhci_halted=E2=80=99;=20have=20=E2=80=98bool(struct=20cqhc=
i_host=20*)=E2=80=99=20=7Baka=20=E2=80=98_Bool(struct=0D=0A>=20cqhci_host=
=20*)=E2=80=99=7D=0D=0A>=20=20=20956=20=7C=20static=20bool=20cqhci_halted(s=
truct=20cqhci_host=20*cq_host)=0D=0A>=20=20=20=20=20=20=20=7C=20=20=20=20=
=20=20=20=20=20=20=20=20=20=5E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=0D=0A>=20dr=
ivers/mmc/host/cqhci-core.c:285:13:=20note:=20previous=20implicit=20declara=
tion=0D=0A>=20of=20=E2=80=98cqhci_halted=E2=80=99=20with=20type=20=E2=80=98=
int()=E2=80=99=0D=0A>=20=20=20285=20=7C=20=20=20=20=20=20=20=20=20if=20(cqh=
ci_halted(cq_host))=0D=0A>=20=20=20=20=20=20=20=7C=20=20=20=20=20=20=20=20=
=20=20=20=20=20=5E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=0D=0A>=20cc1:=20all=20w=
arnings=20being=20treated=20as=20errors=0D=0A>=20=0D=0A>=20Not=20only=20sho=
uld=20it=20compile,=20but=20you=20must=20test=20it=21=0D=0A>=20=0D=0A>=20Pr=
obably=20better=20to=20make=202=20patches:=0D=0A>=201.=20Just=20the=20fix,=
=20cc=20stable=20i.e.=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/mmc/host/=
cqhci-core.c=20b/drivers/mmc/host/cqhci-core.c=0D=0A>=20index=20c14d7251d0b=
b..a02da26a1efd=20100644=0D=0A>=20---=20a/drivers/mmc/host/cqhci-core.c=0D=
=0A>=20+++=20b/drivers/mmc/host/cqhci-core.c=0D=0A>=20=40=40=20-617,7=20+61=
7,7=20=40=40=20static=20int=20cqhci_request(struct=20mmc_host=20*mmc,=20str=
uct=0D=0A>=20mmc_request=20*mrq)=0D=0A>=20=20=09=09cqhci_writel(cq_host,=20=
0,=20CQHCI_CTL);=0D=0A>=20=20=09=09mmc->cqe_on=20=3D=20true;=0D=0A>=20=20=
=09=09pr_debug(=22%s:=20cqhci:=20CQE=20on=5Cn=22,=20mmc_hostname(mmc));=0D=
=0A>=20-=09=09if=20(cqhci_readl(cq_host,=20CQHCI_CTL)=20&&=20CQHCI_HALT)=20=
=7B=0D=0A>=20+=09=09if=20(cqhci_readl(cq_host,=20CQHCI_CTL)=20&=20CQHCI_HAL=
T)=20=7B=0D=0A>=20=20=09=09=09pr_err(=22%s:=20cqhci:=20CQE=20failed=20to=20=
exit=20halt=20state=5Cn=22,=0D=0A>=20=20=09=09=09=20=20=20=20=20=20=20mmc_h=
ostname(mmc));=0D=0A>=20=20=09=09=7D=0D=0A>=20=0D=0A>=202.=20Tidy=20up,=20n=
o=20cc=20stable=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/mmc/host/cqhci-=
core.c=20b/drivers/mmc/host/cqhci-core.c=0D=0A>=20index=20a02da26a1efd..178=
277d90c31=20100644=0D=0A>=20---=20a/drivers/mmc/host/cqhci-core.c=0D=0A>=20=
+++=20b/drivers/mmc/host/cqhci-core.c=0D=0A>=20=40=40=20-33,6=20+33,11=20=
=40=40=20struct=20cqhci_slot=20=7B=0D=0A>=20=20=23define=20CQHCI_HOST_OTHER=
=09BIT(4)=0D=0A>=20=20=7D;=0D=0A>=20=0D=0A>=20+static=20bool=20cqhci_halted=
(struct=20cqhci_host=20*cq_host)=20=7B=0D=0A>=20+=09return=20cqhci_readl(cq=
_host,=20CQHCI_CTL)=20&=20CQHCI_HALT;=20=7D=0D=0A>=20+=0D=0A>=20=20static=
=20inline=20u8=20*get_desc(struct=20cqhci_host=20*cq_host,=20u8=20tag)=20=
=20=7B=0D=0A>=20=20=09return=20cq_host->desc_base=20+=20(tag=20*=20cq_host-=
>slot_sz);=20=40=40=20-282,7=0D=0A>=20+287,7=20=40=40=20static=20void=20__c=
qhci_enable(struct=20cqhci_host=20*cq_host)=0D=0A>=20=0D=0A>=20=20=09cqhci_=
writel(cq_host,=20cqcfg,=20CQHCI_CFG);=0D=0A>=20=0D=0A>=20-=09if=20(cqhci_r=
eadl(cq_host,=20CQHCI_CTL)=20&=20CQHCI_HALT)=0D=0A>=20+=09if=20(cqhci_halte=
d(cq_host))=0D=0A>=20=20=09=09cqhci_writel(cq_host,=200,=20CQHCI_CTL);=0D=
=0A>=20=0D=0A>=20=20=09mmc->cqe_on=20=3D=20true;=0D=0A>=20=40=40=20-617,7=
=20+622,7=20=40=40=20static=20int=20cqhci_request(struct=20mmc_host=20*mmc,=
=20struct=0D=0A>=20mmc_request=20*mrq)=0D=0A>=20=20=09=09cqhci_writel(cq_ho=
st,=200,=20CQHCI_CTL);=0D=0A>=20=20=09=09mmc->cqe_on=20=3D=20true;=0D=0A>=
=20=20=09=09pr_debug(=22%s:=20cqhci:=20CQE=20on=5Cn=22,=20mmc_hostname(mmc)=
);=0D=0A>=20-=09=09if=20(cqhci_readl(cq_host,=20CQHCI_CTL)=20&=20CQHCI_HALT=
)=20=7B=0D=0A>=20+=09=09if=20(cqhci_halted(cq_host))=20=7B=0D=0A>=20=20=09=
=09=09pr_err(=22%s:=20cqhci:=20CQE=20failed=20to=20exit=20halt=20state=5Cn=
=22,=0D=0A>=20=20=09=09=09=20=20=20=20=20=20=20mmc_hostname(mmc));=0D=0A>=
=20=20=09=09=7D=0D=0A>=20=40=40=20-953,11=20+958,6=20=40=40=20static=20bool=
=20cqhci_clear_all_tasks(struct=20mmc_host=0D=0A>=20*mmc,=20unsigned=20int=
=20timeout)=0D=0A>=20=20=09return=20ret;=0D=0A>=20=20=7D=0D=0A>=20=0D=0A>=
=20-static=20bool=20cqhci_halted(struct=20cqhci_host=20*cq_host)=20-=7B=0D=
=0A>=20-=09return=20cqhci_readl(cq_host,=20CQHCI_CTL)=20&=20CQHCI_HALT;=0D=
=0A>=20-=7D=0D=0A>=20-=0D=0A>=20=20static=20bool=20cqhci_halt(struct=20mmc_=
host=20*mmc,=20unsigned=20int=20timeout)=20=20=7B=0D=0A>=20=20=09struct=20c=
qhci_host=20*cq_host=20=3D=20mmc->cqe_private;=0D=0A>=20=0D=0A>=20=0D=0A>=
=20=0D=0A>=20>=0D=0A>=20>=20Fixes:=200653300224a6=20(=22mmc:=20cqhci:=20ren=
ame=20cqhci.c=20to=20cqhci-core.c=22)=0D=0A>=20=0D=0A>=20Fixes=20tag=20shou=
ld=20be=20the=20commit=20that=20introduced=20the=20code,=20not=20one=20that=
=0D=0A>=20moved=20it.=20=20In=20this=20case,=20it=20has=20been=20there=20si=
nce=20the=20beginning:=0D=0A>=20=0D=0A>=20Fixes:=20a4080225f51d=20(=22mmc:=
=20cqhci:=20support=20for=20command=20queue=20enabled=20host=22)=0D=0A>=20=
=0D=0A>=20Looks=20like=20the=20offending=20code=20kinda=20worked=20which=20=
explains=20why=20it=20wasn't=0D=0A>=20noticed=20sooner.=0D=0A>=20=0D=0ASorr=
y=20for=20my=20mistake.=0D=0A=0D=0AI=20will=20make=20the=20patch=20again=20=
as=20you=20advised.=0D=0A=0D=0AThank=20you=20for=20your=20help.=0D=0A=0D=0A=
>=20>=20Cc:=20stable=40vger.kernel.org=0D=0A>=20>=20Signed-off-by:=20Seungh=
wan=20Baek=20<sh8267.baek=40samsung.com>=0D=0A>=20>=20---=0D=0A>=20>=20=20d=
rivers/mmc/host/cqhci-core.c=20=7C=204=20++--=0D=0A>=20>=20=201=20file=20ch=
anged,=202=20insertions(+),=202=20deletions(-)=0D=0A>=20>=0D=0A>=20>=20diff=
=20--git=20a/drivers/mmc/host/cqhci-core.c=0D=0A>=20>=20b/drivers/mmc/host/=
cqhci-core.c=20index=20c14d7251d0bb..3d5bcb92c78e=0D=0A>=20>=20100644=0D=0A=
>=20>=20---=20a/drivers/mmc/host/cqhci-core.c=0D=0A>=20>=20+++=20b/drivers/=
mmc/host/cqhci-core.c=0D=0A>=20>=20=40=40=20-282,7=20+282,7=20=40=40=20stat=
ic=20void=20__cqhci_enable(struct=20cqhci_host=0D=0A>=20>=20*cq_host)=0D=0A=
>=20>=0D=0A>=20>=20=20=09cqhci_writel(cq_host,=20cqcfg,=20CQHCI_CFG);=0D=0A=
>=20>=0D=0A>=20>=20-=09if=20(cqhci_readl(cq_host,=20CQHCI_CTL)=20&=20CQHCI_=
HALT)=0D=0A>=20>=20+=09if=20(cqhci_halted(cq_host))=0D=0A>=20>=20=20=09=09c=
qhci_writel(cq_host,=200,=20CQHCI_CTL);=0D=0A>=20>=0D=0A>=20>=20=20=09mmc->=
cqe_on=20=3D=20true;=0D=0A>=20>=20=40=40=20-617,7=20+617,7=20=40=40=20stati=
c=20int=20cqhci_request(struct=20mmc_host=20*mmc,=0D=0A>=20struct=20mmc_req=
uest=20*mrq)=0D=0A>=20>=20=20=09=09cqhci_writel(cq_host,=200,=20CQHCI_CTL);=
=0D=0A>=20>=20=20=09=09mmc->cqe_on=20=3D=20true;=0D=0A>=20>=20=20=09=09pr_d=
ebug(=22%s:=20cqhci:=20CQE=20on=5Cn=22,=20mmc_hostname(mmc));=0D=0A>=20>=20=
-=09=09if=20(cqhci_readl(cq_host,=20CQHCI_CTL)=20&&=20CQHCI_HALT)=20=7B=0D=
=0A>=20>=20+=09=09if=20(cqhci_halted(cq_host))=20=7B=0D=0A>=20>=20=20=09=09=
=09pr_err(=22%s:=20cqhci:=20CQE=20failed=20to=20exit=20halt=20state=5Cn=22,=
=0D=0A>=20>=20=20=09=09=09=20=20=20=20=20=20=20mmc_hostname(mmc));=0D=0A>=
=20>=20=20=09=09=7D=0D=0A=0D=0A=0D=0A

