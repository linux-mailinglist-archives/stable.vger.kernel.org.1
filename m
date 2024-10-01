Return-Path: <stable+bounces-78535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F498BFA7
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA03A2858CB
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C761C7B88;
	Tue,  1 Oct 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fGLpMqly"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F691C245C
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792162; cv=none; b=HOKSMSTvrONCWhGHS5tnq8f8AP5x5c0U+RNMahcCvAfz8gchtDml7WOihQjzCd7YzYKiC5GyDFqecYcQDLw9QBdgKZ4xjihNurX0BvtzPkm0I2CuEi7DzATpNaUHBjEAp3Ngmhi+f2BVwHrPN0dSOg6NYs0j30UmejmonB/iN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792162; c=relaxed/simple;
	bh=coLwseDCM6znTuSriRNR7Ug5LwHb1xNJUeaXyoJAILA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Vc4T9xfacuFfdZcYSNXveYLJZlmzUM+DHbGuNRbuMFzse34eqXF1hzD8uvWP9Vu2mfQWZJLHpuErt0usXO6lfIGJ3pAtztncFzIRdkw9lCEb1Sct9Eiaiw1mT+rkhjpPTlyIrYibGi69PYqUzKAKW9VQuI4v0zbb4NKACnv9Umo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fGLpMqly; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241001141553epoutp045d5bbb076a74563c2831cb9ab1fb89ac~6Wc8lYtJz0314903149epoutp04m
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:15:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241001141553epoutp045d5bbb076a74563c2831cb9ab1fb89ac~6Wc8lYtJz0314903149epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727792153;
	bh=coLwseDCM6znTuSriRNR7Ug5LwHb1xNJUeaXyoJAILA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=fGLpMqlymKhU22lS/S4BEBkCjC9Ieb1N/TQ+8927r9tEw+x3PMJQAFDK4uoZTYiPV
	 9bpPgVnBNeF0mM3yjE0OZea+yfSR+qtNHGqnmVOzT1IygL29Ijuq6/wiVmQnhKfbC6
	 fKZGfrL4myzb7kx4FVRoJIjTw8xKRNPtQFzh/zgM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241001141552epcas5p36d4744c337c6b572f50097609a080e8c~6Wc79W1S70168401684epcas5p3J;
	Tue,  1 Oct 2024 14:15:52 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XJ0N72nG2z4x9Pt; Tue,  1 Oct
	2024 14:15:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	74.AC.09800.7140CF66; Tue,  1 Oct 2024 23:15:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241001133437epcas5p2ca35fbd3f31aec3997b3907e9c25330a~6V47DI5li0314703147epcas5p2i;
	Tue,  1 Oct 2024 13:34:37 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241001133437epsmtrp24b5c78c1b9ba399ceec0f9c7eac1c02c~6V47Cc8PY2026620266epsmtrp2i;
	Tue,  1 Oct 2024 13:34:37 +0000 (GMT)
X-AuditID: b6c32a4b-23fff70000002648-e4-66fc04173135
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BC.E1.18937.D6AFBF66; Tue,  1 Oct 2024 22:34:37 +0900 (KST)
Received: from FDSFTE353 (unknown [107.122.81.138]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241001133435epsmtip2fb48c75c78d7a04f435c7bea4fa83472~6V45IQYES0214202142epsmtip2H;
	Tue,  1 Oct 2024 13:34:35 +0000 (GMT)
From: "Varada Pavani" <v.pavani@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <s.nawrocki@samsung.com>,
	<cw00.choi@samsung.com>, <alim.akhtar@samsung.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Cc: <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
	<gost.dev@samsung.com>, <stable@vger.kernel.org>
In-Reply-To: <f8b36300-cf7e-4cdc-b1d4-ed4a64453d4e@kernel.org>
Subject: RE: [PATCH 2/2] clk: samsung: Fixes PLL locktime for PLL142XX used
 on FSD platfom
Date: Tue, 1 Oct 2024 19:04:34 +0530
Message-ID: <009601db1406$a8f5ec50$fae1c4f0$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHgPYoJbOScyTLaZbJAwfQ0Jvmx2AF7r+vcAuu0B8cCMRhRVbIyzYtw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmlq44y580g9l9fBYP5m1jszi0eSu7
	xfUvz1ktbh7YyWRx/vwGdotNj6+xWnzsucdqcXnXHDaLGef3MVlcPOVqsWjrF3aLw2/aWS3+
	XdvIYrFg4yNGBz6P9zda2T02repk89i8pN6jb8sqRo/Pm+QCWKOybTJSE1NSixRS85LzUzLz
	0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
	pCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfc37iFreAXT8XxTY/ZGxjv
	c3UxcnJICJhIrPg+l72LkYtDSGA3o0Tn8j3MEM4nRondz18hOHPePGaFaVm65jhUy05Gicur
	V0JVvWCUeH24gRGkik1AR2L3y+WsIAkRgT1MEmeXXwNrZxbIk2i6vZMNxOYUsJO4OGkpM4gt
	LBAjsXXndjCbRUBF4ub/BhYQm1fAUuJ9wwJ2CFtQ4uTMJywQc7Qlli18zQxxkoLEz6fLwOaL
	CLhJXN62iR2iRlzi6M8esOskBPZwSDReXgz1g4vE+zfrmSBsYYlXx7ewQ9hSEp/f7QU6jgPI
	TpZo/8QNEc6RuLR7FVS5vcSBK3NYQEqYBTQl1u/ShwjLSkw9tY4JYi2fRO/vJ1DlvBI75sHY
	ShI7d0yAsiUknq5ewzaBUWkWks9mIflsFpIPZiFsW8DIsopRMrWgODc9tdi0wDgvtRwe48n5
	uZsYwelYy3sH46MHH/QOMTJxMB5ilOBgVhLhvXfoZ5oQb0piZVVqUX58UWlOavEhRlNgcE9k
	lhJNzgdmhLySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGphW1WQ6
	yj/n0H0R5XKE7/syzdbo+fMDfj1h0PS1C+/ObCrzYFoQ8PHNerEQxUfbjCfFpMaF62kzvEm5
	ctGy7779xjgBlRer/315/CRiver3WRH7I1Xc9Rr7l5v3TZnM4ta/d4JTz4cVJ49Xppl1TnGJ
	ubV8Oe+y1rfnfZh/nLXxeT1/UlHQ3Nf/S5YuPriyMK7cl8P0QcQh145b8aU6k1kLUwKDag8m
	Tz/08Nti4cS4wN/cVazsXwwT+LpEZJnt3Jfc+Sl1Nj+EV33G7Eu9JqJLp1ipBO/knhvj9+VB
	JE+VnnfGP0GuH0+0ouwWhG2/xio774Q1m5VlR9iNXywrwieaHf/5srIhdMX0Occ3syuxFGck
	GmoxFxUnAgChRDaDUAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSvG7ur99pBh/vqVk8mLeNzeLQ5q3s
	Fte/PGe1uHlgJ5PF+fMb2C02Pb7GavGx5x6rxeVdc9gsZpzfx2Rx8ZSrxaKtX9gtDr9pZ7X4
	d20ji8WCjY8YHfg83t9oZffYtKqTzWPzknqPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyri6
	aQpTwXWeigOrJ7M2MO7i6mLk5JAQMJFYuuY4excjF4eQwHZGiXMb2pghEhISO7+1QtnCEiv/
	PYcqesYocXFiLytIgk1AR2L3y+WsIAkRgWNMEt8nngJLMAsUSdxt+M4CYgsJvGaUeHbBE8Tm
	FLCTuDhpKdhUYYEoia+zXoHVsAioSNz83wBm8wpYSrxvWMAOYQtKnJz5hAViprZE78NWRhh7
	2cLXUNcpSPx8ugxsr4iAm8TlbZvYIWrEJY7+7GGewCg8C8moWUhGzUIyahaSlgWMLKsYRVML
	inPTc5MLDPWKE3OLS/PS9ZLzczcxgmNRK2gH47L1f/UOMTJxMB5ilOBgVhLhvXfoZ5oQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QD09wlVvd4fZmEHnkV
	fBJgOC3aWaCXMsvvAuvD2Hl9xiY/nnvHau2esDdF4WrQrOXz5de6hOVPYy7XEr9etUXr/jI1
	Xaa16TxafmZXFz5qCT5yrWNna9lHr73X17B1mZpwrVibnq74rji6JVPzTKi62L/I3j3Rv0TO
	CQbpfH9fN1u0YrYYT4Y1g9SeTRfuBjxiO/uXN0D9WEDg1C+fe12zZ31f2jel/vCCx01Rf2LM
	vq57sWtvxK0vfy++r9rS98vm1of895mFkokd08qObGz6fUVlTdOztbsnTg2XEA5ffGRbco1O
	+D79BF+HyuVPbaru8RsJJVbPMXLRd03bNH8NQ4Lcv1bW6ZuP9wSxfzrMrMRSnJFoqMVcVJwI
	AMgGTCI0AwAA
X-CMS-MailID: 20241001133437epcas5p2ca35fbd3f31aec3997b3907e9c25330a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240930112135epcas5p2175ec81bb609da5b166d47341ece2f67
References: <20240930111859.22264-1-v.pavani@samsung.com>
	<CGME20240930112135epcas5p2175ec81bb609da5b166d47341ece2f67@epcas5p2.samsung.com>
	<20240930111859.22264-3-v.pavani@samsung.com>
	<f8b36300-cf7e-4cdc-b1d4-ed4a64453d4e@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzk=40kernel.org=5D
> Sent: 30 September 2024 18:05
> To: Varada Pavani <v.pavani=40samsung.com>; s.nawrocki=40samsung.com;
> cw00.choi=40samsung.com; alim.akhtar=40samsung.com;
> mturquette=40baylibre.com; sboyd=40kernel.org; linux-samsung-
> soc=40vger.kernel.org; linux-clk=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
> Cc: aswani.reddy=40samsung.com; pankaj.dubey=40samsung.com;
> gost.dev=40samsung.com; stable=40vger.kernel.org
> Subject: Re: =5BPATCH 2/2=5D clk: samsung: Fixes PLL locktime for PLL142X=
X used
> on FSD platfom
>=20
> On 30/09/2024 13:18, Varada Pavani wrote:
> > Add PLL locktime for PLL142XX controller.
> >
>=20
> So you send the same? Or something new? Please provide proper changelog
> and mark patches as v2/v3 or RESEND.
>=20
> But anyway this cannot be RESEND as I explicitly asked for fixing.
>=20
> <form letter>
> This is a friendly reminder during the review process.
>=20
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and ei=
ther
> implement all requested changes or keep discussing them.
>=20
> Thank you.
> </form letter>
>=20
> Best regards,
> Krzysztof

Sorry, have sent the same patch again. As I need to post one patch alone wh=
ich got
missed due to internal technical issue. Next time onwards will make sure to=
 mark the
patches as V2/V3 or RESEND accordingly.

Regards,
Varada Pavani


