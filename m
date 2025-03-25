Return-Path: <stable+bounces-125996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D608A6EB96
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 09:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391131894C07
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F35C33EC;
	Tue, 25 Mar 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b65/VFia"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD472199EAF;
	Tue, 25 Mar 2025 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891435; cv=fail; b=LRtKorychf+SbxqaIXeRy5uSfwJrfY7oFMvYtm20jh8ruHgt0nDJBNQtBN6Ich44y+FjIi7F5AlbfP1nJABCWftQBkNBhICRt5jKQYcs8AE5HuFmKUHxaEochHW0RJmnYVCF5pi5pocExeRhVmlCVD/jaWoSmAG4c/bO7jaaPRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891435; c=relaxed/simple;
	bh=uEjzJz2UGx3T3MPkWUExt8NQKY31d3X5i5Y+2QYNpPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sP8Hmsbxcu9eyyWh+dH6sZYknlay5YtaVJJz2eheKp0zu2Cj3Bs3B95ma60B0nKSNzaTCDtAnmo/24kZY2L7izo89oW8hEOUqQzux6zsZDFXu1js04ySI5mvFuTbeLlvwdf/BweSjploEg1LDjmTealIx54GXflgEVutq+HEqJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b65/VFia; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDk3ubGaHyZmVWjE0Egp34/IlpaDwlEJ4W7TARdfhudttKdUc6Qmr/ddYMblm/pIuvm0XMsVqfZUIzCbEQXb3NHOVr/oa2VnVt5eTjF2SzBEApk2gNDooVOjSjLEImnCTGkXkdw4ev8I70za/AMaxWsSco3VUfetytoyuuiCdie1nI7aH1T627EtreO2sE0ZbBJy58o2TN3tWESCvbB66N72Y2RwYm7h2x+/sIqDdkqspryQndae/mRDpjAe723XRLhMs9Cmv6Cp4JboBnVbmjV99AVOc8ByqlXLaKPkQyo8sRoRdNHkpA2mIbTxvELjeicoXJrMs2PRChWk3DbWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3alq0m74Fzclm64uZ/UB4hQp9MEBNphDQ7GE+EKyAR4=;
 b=NyqXc8ReE7zcX58ylPcYHKyCYNavo7caIvTX/IH1KnkGMNcerx/YIAbZa0obO9kPu0zkNgAYlm+y/lSv7j6keZ7yD7Qd5cAnUAWeg9jkG1t0nMF5YNXPK4NHaCT33BPELRXDDx09lPCPTD/+rDRm3ohM38g0tUHRXJ5m2eOlj++unClGkGCriTLH31qiC0BVL5O7rwFpR/vwCHP/8Qhd+mKYL1CtywZeVpaQgD9180cioXBgXfhv+JxwRiXJT1eWy4VZuZUDKQIF09j/gFLTUIV6cER76Y5D8uGscm2GKDwB0UTTTUUwOMkE8Pe9dbXMV7Z7DCxaDFtF0aR2RytBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3alq0m74Fzclm64uZ/UB4hQp9MEBNphDQ7GE+EKyAR4=;
 b=b65/VFiakGbMQ3BFlJUlLO1ucf+BEfQ1dAu6OpaphQkpEskVaRd9OspRUGO8iE8qFMnn9+globoBWTCEioICrLTeOx1a5z5xTZSspthkAEPGlycrjMhztnO6dYl0PG5LvQRTetuVUs+dExS9jBuu85/oXBucUJs3LGgIjHMevFr8WTRfJCgkXjphTWdGydvOWx9+2vgjHHyzGA4rqWXLFr8d9uAJa4h3PzPkhZWYhdokzW930w6ei5iVpRIOOtLmKYjk/3aJpqF91hX2xCUpv4SQEkFKWpBbRJBqSJijzJOO+6rBrwJDucykUoHbhalniZbV7GtnVZ2iuvM2fCOupg==
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 (2603:10a6:800:1db::17) by PR3PR04MB7355.eurprd04.prod.outlook.com
 (2603:10a6:102:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 25 Mar
 2025 08:30:29 +0000
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee]) by VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:30:29 +0000
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Frank Li <frank.li@nxp.com>, "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>, "conor.culhane@silvaco.com"
	<conor.culhane@silvaco.com>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: RE: [EXT] Re: [PATCH v4] svc-i3c-master: Fix read from unreadable
 memory at svc_i3c_master_ibi_work()
Thread-Topic: [EXT] Re: [PATCH v4] svc-i3c-master: Fix read from unreadable
 memory at svc_i3c_master_ibi_work()
Thread-Index:
 AQHbk1Y4SkbCrYt+yki4ZS7j1qEGurNv0p4AgACyIrCABtUNgIAAJa+ggAAg4ACAC/jpMA==
Date: Tue, 25 Mar 2025 08:30:28 +0000
Message-ID:
 <VI1PR04MB1004925DA8849F00F722EC8288FA72@VI1PR04MB10049.eurprd04.prod.outlook.com>
References: <20250312135356.2318667-1-manjunatha.venkatesh@nxp.com>
 <Z9HSdtD1CkdCpGu9@lizhi-Precision-Tower-5810>
 <VI1PR04MB10049644F3287C378E9CC75EF8FD32@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810>
 <VI1PR04MB1004979B7D38486FD1E1CC8508FDF2@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <2025031717392264f19f1a@mail.local>
In-Reply-To: <2025031717392264f19f1a@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB10049:EE_|PR3PR04MB7355:EE_
x-ms-office365-filtering-correlation-id: 22fe2c37-2ecf-4f95-13c7-08dd6b774cc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9APkNxjpqRIgNwnZKsdSNRhojp6krB7lT1tjUZhSLMJu+SEz9ZRc4XaZRuul?=
 =?us-ascii?Q?JRvyiH4kaR7iaX+M0IG+STvd9KZjrscJwrdENOGY+EDOjQBB052g6Z2j5JdI?=
 =?us-ascii?Q?pgtyQ65HSY7He6PZQ6Fx2Hkkm997zhIt/MR6O9w93jyvY53dEBxpTxAQz1Hl?=
 =?us-ascii?Q?sIXJNqPi6Rkmc7gbh7EBw27qVPMokvxo90hgqaHmZsjNLsKNyBNBAjHzJRbE?=
 =?us-ascii?Q?mYUlgF66RwTdIkph6bgkSpvxEseu/HB1Ai3SL/JNLKZTIF7lgniQ6ZsDCdAz?=
 =?us-ascii?Q?Sh04rA6qIyNHo857ecbeYB2lIkXseYlmWSZE2cYZtC2rTjTkbh6r0fwnHPNj?=
 =?us-ascii?Q?h/gKzzRM/RGG8Vobl4xCw5DU27Z066SNi663s2bd+me8YduZEhPajqu+gX11?=
 =?us-ascii?Q?BodhGYN627plxTptL43/PR9dh1caqlpA6tzN0gFpNBtf4DJaGl0DQYQERDfS?=
 =?us-ascii?Q?fN/jRuouJ7t7oO/2w6Rv2MYlvV7tTCO491AFOxifhQa3turdUc8sGluzwgd6?=
 =?us-ascii?Q?g8RTB4fEDAu3nylgKCG3UDNm8jeINnWF+pRVP8tXOaWeZm1ywaBJuyrudm8b?=
 =?us-ascii?Q?ZtjX816FrwXaTIzUqbLnlA/mRDO2eJm9CTrMkX5OVW2xJithriE77FUi4qkt?=
 =?us-ascii?Q?HyrrPivCh4TkbBW1pTdEBWckeeePf4F1c7VCghx6aW6FVkXT12oL0dqXWPfs?=
 =?us-ascii?Q?6oQjz/XFnFGIStpNnj87oAsyB9UXBygf9/1IU7bl2YalsmnCX3M4jVEFGDGc?=
 =?us-ascii?Q?7LHU1w3hWLYR0PVhiXyV/Ilv++wCHEV/ZFQCXKMhMZr9CER/y3valHmyxt7n?=
 =?us-ascii?Q?2ccD6DIndxftJyTnzVLeLyLADMXEMr7S1bQPzLWPPaakoU2g5sg5Q248L2ij?=
 =?us-ascii?Q?f9liRrcG7vtiPXDFRXCbAdR02jUfX5GxQ3ZtWVsgrK0AkoBqYNQeHcNRX7So?=
 =?us-ascii?Q?n/Hs1sTooR1LG+RCklz2iJD+cY13yj1n/I9QngQRRJ2Lfr0aLc2RxXphZ0xA?=
 =?us-ascii?Q?QilUjktplH5N3UZFUed8FUFltysj5BsvJ2WfRRIgkTdTb4VHwwSeN/VmAQPj?=
 =?us-ascii?Q?GsqaqpVZdzDcoCtfDI4QaRt0C+wf+suUhbGQhX1ylwk5oXJnVK3246YvOTFq?=
 =?us-ascii?Q?Hz1O4Ggd/r5NxVtDL4iseTidzrgGOxQ4/Zy18JRJ2Qekt7fkpXyIEvbO4FN8?=
 =?us-ascii?Q?4IiXJNljY2CPgJiZgN+LwHs6TYgia79c15yhDL31tKJ9PKBsC8vJ4wcCQyPV?=
 =?us-ascii?Q?k3jBgERshEvP5jOyp0zN/jB0CRjHeygZ02aZmCQUkBndKkn4fnEinKt8w7BU?=
 =?us-ascii?Q?v30LshniN+x4bqkkBh0Os4Y/VrQnzq9h3rc1j049xvqHpQ0odh6j2zOtOfqi?=
 =?us-ascii?Q?NDDZop2+kqiSNHJuOlXsa6HGScfli4axyrNORFb6CrT94gtAyJD82N7WeNeJ?=
 =?us-ascii?Q?C3DfDp73CGY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10049.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nHDd2vs7Pd7YDqieMj5CLmZ7CEL4d/B779hXl9rmP3rlaoJTEMxjzeGzWBpb?=
 =?us-ascii?Q?3ZqFCYnsWj8sSYefhGb8M6oZX/jeh6ESL5IiCQL6E2Dm4FF6PNp3xrS6SYHf?=
 =?us-ascii?Q?88YLH5MgmTRXxAlLDhZ0w+9jwbNO2TAf1Dx9qXeUA5qEcVh5/JjpUyZ7Y5qA?=
 =?us-ascii?Q?KBm/B5HS5o2zLdOI2FuqEvIx61ugTYo/edvbK7+ik66v8pOerzRwuWmO85ZZ?=
 =?us-ascii?Q?2gEHaLX86+5jdmGTLUcK97gWhtpVz/nipp7TsU6ChcL92OSOEDJ7uO/kg9WR?=
 =?us-ascii?Q?TGS6vXBDLfaGovWvOTY3nUhMT1KUThnKZSEa3/zSu6yrXYhODQjaFLL3n2VU?=
 =?us-ascii?Q?BhZaVCvf+Lmk/yqSK87Ggo9DMWTwsol5bxqYhdAOwwbNZJ9IpEPzcX1VE27S?=
 =?us-ascii?Q?5RtvMkFq7Oh2QaYpMLufRMnSMiC/3nBCfZh0/AbapGLTJ3nM12UlDhcgXaxk?=
 =?us-ascii?Q?ACooisdXlAhSMrGP5F9ieEeAdt6316FxAtTo+98Xn9hzUyLVr57RaXIy7F41?=
 =?us-ascii?Q?pLO8a4mgVLX4GYjjeWOnC6wCi8DBBLSKloIh4ABbWbX2LtqXWQ/MjAH4CTQw?=
 =?us-ascii?Q?JxAldX7D8cxIlcMQXzdDPnNOXEza9G8LUy62xiakVra1DEiFxOVbIpEO4vBz?=
 =?us-ascii?Q?bqn1EUhKB2aqg/yH55arydVcZ/Gc2q1LB8O0XOfC2wBY+mK1WKwI6XFZF831?=
 =?us-ascii?Q?aEDvicZqm/8AUlk8+m9RzkDvUBKocXMHMWTEiMtxrx9g4VUWQvlrEqzdzobK?=
 =?us-ascii?Q?Iim+68l+1CLYPu8hkG0lkqE6yQZsciqq2hrjS63nvwsu94jJmwqFlIZ35Tyj?=
 =?us-ascii?Q?3RheOtZiE370M4SugzFG0VPzCd0vykBDP7C5H422OqeeoZb48qpGChCvv16A?=
 =?us-ascii?Q?K+n3lOz3L/xerryAcM1K236vPjYYgjyEegBftInggocuvghkKqIoFQ+KI4Jb?=
 =?us-ascii?Q?6AxKWbbhz3YqB0T/XVYu/kk76ThK+rkHH1LGgj9NcoGGWVvvPMCuTRZxipun?=
 =?us-ascii?Q?YFS4PvaWPEbhRgrhFyAgy7p6tuqSQSjYa5rFn24NjfwQH+tONaLmN6XHe9mj?=
 =?us-ascii?Q?VMcRUNNScgSgorArV8NSkVKO/PNmWgcZCDgBGI5QezXMAE8vgMjYjIkKR5Jf?=
 =?us-ascii?Q?Zxt57EW6f6P5YcNO868WA97kjer/7jAb2Mqsq12oiVNDXBk774nHFnyruaL+?=
 =?us-ascii?Q?0YVjCfzG2Qn3AA4IEpWchI0r6mLGZoCxHq+UYQMGhKqOyY1nRBO34Ns6maSW?=
 =?us-ascii?Q?fSMwUMmUGTgLOGwrcD7rh+wPFVoIa3djfr1SLrIxGsLIbpUzaKv728MlXFtF?=
 =?us-ascii?Q?7umOSCH+qqN+6lkoYIZnCI+7zGKxNoG/o2HAnfVgsryVlhlaFFR91boaOk9J?=
 =?us-ascii?Q?HnRuctdRpq6xstHGsxd9IdClynLdg827nUhtoYehIVOVXsDoEXx/aaEd+Vc8?=
 =?us-ascii?Q?t5t6pN/7w6nTZhJZvxpJjlXSt8fBE7DA4iZyLE+ZyPD5ajBGxWDrHxTQtyU9?=
 =?us-ascii?Q?Rd0VPjDIVYh2sp4pMQBM/cG10ynI4wU+TC0M7fI4mSSvwE5qTa96rVX/Ljza?=
 =?us-ascii?Q?8H8hxb8guOa4R7+s+nOuIh+1sUOSy67qUSKTdsNG1UAGS5Z2F9haPYhUWB+l?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fe2c37-2ecf-4f95-13c7-08dd6b774cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 08:30:28.9280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YL0rp+H3GkUAaq3GeHNMN72eC/rwjZEXdX4aygrFFrH89W5aJhVlyf4ZP1P3IWAriSSq5+L8qOwRHwAJfMkj1OnGamId1kFGQrf7AqjJlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355



> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: Monday, March 17, 2025 11:09 PM
> To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; miquel.raynal@bootlin.com;
> conor.culhane@silvaco.com; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; rvmanjumce@gmail.com
> Subject: [EXT] Re: [PATCH v4] svc-i3c-master: Fix read from unreadable
> memory at svc_i3c_master_ibi_work()
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 17/03/2025 15:46:52+0000, Manjunatha Venkatesh wrote:
> >
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: Monday, March 17, 2025 6:57 PM
> > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > > kernel@vger.kernel.org; stable@vger.kernel.org; rvmanjumce@gmail.com
> > > Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable
> > > memory at
> > > svc_i3c_master_ibi_work()
> > >
> > > On Thu, Mar 13, 2025 at 05:15:42AM +0000, Manjunatha Venkatesh
> wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Frank Li <frank.li@nxp.com>
> > > > > Sent: Wednesday, March 12, 2025 11:59 PM
> > > > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > > > > linux- kernel@vger.kernel.org; stable@vger.kernel.org;
> > > > > rvmanjumce@gmail.com
> > > > > Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable
> > > > > memory at
> > > > > svc_i3c_master_ibi_work()
> > > > >
> > > > > On Wed, Mar 12, 2025 at 07:23:56PM +0530, Manjunatha Venkatesh
> > > wrote:
> > > > > > As part of I3C driver probing sequence for particular device
> > > > > > instance, While adding to queue it is trying to access ibi
> > > > > > variable of dev which is not yet initialized causing "Unable
> > > > > > to handle kernel read from unreadable memory" resulting in kern=
el
> panic.
> > > > > >
> > > > > > Below is the sequence where this issue happened.
> > > > > > 1. During boot up sequence IBI is received at host  from the sl=
ave
> device
> > > > > >    before requesting for IBI, Usually will request IBI by calli=
ng
> > > > > >    i3c_device_request_ibi() during probe of slave driver.
> > > > > > 2. Since master code trying to access IBI Variable for the part=
icular
> > > > > >    device instance before actually it initialized by slave driv=
er,
> > > > > >    due to this randomly accessing the address and causing kerne=
l
> panic.
> > > > > > 3. i3c_device_request_ibi() function invoked by the slave drive=
r
> where
> > > > > >    dev->ibi =3D ibi; assigned as part of function call
> > > > > >    i3c_dev_request_ibi_locked().
> > > > > > 4. But when IBI request sent by slave device, master code
> > > > > > trying to
> > > access
> > > > > >    this variable before its initialized due to this race condit=
ion
> > > > > >    situation kernel panic happened.
> > > > > >
> > > > > > Fixes: dd3c52846d595 ("i3c: master: svc: Add Silvaco I3C
> > > > > > master
> > > > > > driver")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Manjunatha Venkatesh
> > > <manjunatha.venkatesh@nxp.com>
> > > > > > ---
> > > > > > Changes since v3:
> > > > > >   - Description  updated typo "Fixes:"
> > > > > >
> > > > > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > > > @@ -534,8 +534,11 @@ static void
> > > > > > svc_i3c_master_ibi_work(struct
> > > > > work_struct *work)
> > > > > >       switch (ibitype) {
> > > > > >       case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > > > > >               if (dev) {
> > > > > > -                     i3c_master_queue_ibi(dev, master->ibi.tbq=
_slot);
> > > > > > -                     master->ibi.tbq_slot =3D NULL;
> > > > > > +                     data =3D i3c_dev_get_master_data(dev);
> > > > > > +                     if (master->ibi.slots[data->ibi]) {
> > > > > > +                             i3c_master_queue_ibi(dev,
> > > > > > + master-
> > > > > >ibi.tbq_slot);
> > > > > > +                             master->ibi.tbq_slot =3D NULL;
> > > > > > +                     }
> > > > >
> > > > > You still not reply previous discussion:
> > > > >
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > > 2Flore.kernel.org%2Flinux-i3c%2FZ8sOKZSjHeeP2mY5%40lizhi-Precisi
> > > > > on-
> T&data=3D05%7C02%7Cmanjunatha.venkatesh%40nxp.com%7Cf0ae17cf296
> > > > >
> 949cdd6c308dd657aa7e7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0
> > > > > %7C638778299668550575%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0
> eU1hcGkiOn
> > > > >
> RydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIj
> > > > >
> oyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D3da5keE%2FKv9NbsltjDxywErXAjU1Al
> nR
> > > > > DXi5GQlMDJw%3D&reserved=3D0
> > > > > ower-
> > > > > 5810/T/#mfd02d6ddca0a4b57bc823dcbfa7571c564800417
> > > > >
> > > > [Manjunatha Venkatesh] : In the last mail answered to this question=
.
> > > >
> > > > > This is not issue only at svc driver, which should be common
> > > > > problem for other master controller drivers
> > > > >
> > > > [Manjunatha Venkatesh] :Yes, you are right.
> > > > One of my project I3C interface is required, where we have used
> > > > IMX board
> > > as reference platform.
> > > > As part of boot sequence we come across this issue and tried to
> > > > fix that
> > > particular controller driver.
> > > >
> > > > What is your conclusion on this? Is it not ok to take patch for SVC=
 alone?
> > >
> > > I perfer fix at common framwork to avoid every driver copy the
> > > similar logic code.
> > >
> > [Manjunatha Venkatesh] : As per your suggestion tried the below patch
> > at common framework api i3c_master_queue_ibi()  and looks working fine,
> didn't see any crash issue.
> > if (!dev->ibi || !slot) {
> >              dev_warning("...");
>=20
> Do we really need a warning, what would be the user action after seeing i=
t?
[Manjunatha Venkatesh] : Warning message may not required here, we can just=
 return it.
> >              return;
> > }
> > Will commit this change in next patch submission.
> >
> > > Frank
> > >
> > > >
> > > > > Frank
> > > > >
> > > > > >               }
> > > > > >               svc_i3c_master_emit_stop(master);
> > > > > >               break;
> > > > > > --
> > > > > > 2.46.1
> > > > > >
> > > >
> > > > --
> > > > linux-i3c mailing list
> > > > linux-i3c@lists.infradead.org
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F=
l
> > > > ists.infradead.org%2Fmailman%2Flistinfo%2Flinux-
> i3c&data=3D05%7C02%7
> > > >
> Cmanjunatha.venkatesh%40nxp.com%7Cf0ae17cf296949cdd6c308dd657aa7e
> 7
> > > > %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638778299668
> 572303%7
> > > >
> CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMD
> AwMCI
> > > >
> sIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd
> a
> > > >
> ta=3DNupPno%2BfuqIUr8LiV5rrrO%2FJt%2B3AHol0nokRJjauWc8%3D&reserved
> =3D0
>=20
> --
> Alexandre Belloni, co-owner and COO, Bootlin Embedded Linux and Kernel
> engineering
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbootl=
in
> .com%2F&data=3D05%7C02%7Cmanjunatha.venkatesh%40nxp.com%7Cf0ae17c
> f296949cdd6c308dd657aa7e7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638778299668585840%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e
> U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI
> sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DlqapWA3WfBkuFZvpdF%2BJjVc
> ncKNjG%2FR7u1n6dK88TcY%3D&reserved=3D0

