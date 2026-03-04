Return-Path: <stable+bounces-222976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xyM8BGmgp2l2iwAAu9opvQ
	(envelope-from <stable+bounces-222976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 04:00:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9C1FA27E
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 04:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 418393016143
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 03:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C49E35BDDC;
	Wed,  4 Mar 2026 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KrlhQFBc"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4AC35BDA7;
	Wed,  4 Mar 2026 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593250; cv=fail; b=D0xbj4P7oeJFKrV5fVvGzlB2llIqTu804Mf55qOqLpeH76tjWKCMfEvlEAW0u2u1LGVgE8Ns0RLU/CDufgZMSgGOM8GKkJ/oqyW+YVzQ10lYOGtyPU/+Lj8o8d2HsXm3LNGQtMeBqcMWZ/OU6mf6VsSUkNRbCCYE0Yjj6I3e1z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593250; c=relaxed/simple;
	bh=CrcziLSLmwygoZkFLoqj/ib3pWN/UUqOS/+uQ+SI+ew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NkyrnKl1SqF/81OyqgZGIS7q/ve01L/oFm0gPosYcUz/dBaYzQwuQSfgXVKSdCEWLQAEnc7aeX/GEYumTsHfY0iu+rxxiwY2f5AzoJFz7FugrXZEPh2lFPwm0OT+ORY19UVWCZWFk3Ev8mJNpqj1je20QfVOT+Fk0SVHa3ckxCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KrlhQFBc; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNY5IrOUy2nUICB/Ck/mXK5G5ltQfcNIlFN7+9WS2whu3Um8HwwLDO4x2h+ETm4It5bcTmCw91dNiAvQs7iEvWoKK7RXGvWS38oLdCfz4TL+8rL5ryDTi88IRym/OarOzTBeplIxKXDclBPHJvuurNEYA07RCjs7I7hHAWqg8nuCiXmn86wSwPTJSWaO8WCoG3rYBCuDb0OKe8pOLzGr17AVKki7uwysmcuNgYuw6s36gjczYX33IJ1XiOQoWAPpPXivAT26NaBway0Hn+TJfCfzmY3k9ifmuh0w6o7qUSmUQfo2XrVAh81tPSiYe6+73XYI6G/+IrAQBKnHetOPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrcziLSLmwygoZkFLoqj/ib3pWN/UUqOS/+uQ+SI+ew=;
 b=gtrIaGsZ/g0Jf6Xn7rJL5ICqmur9cl1uV4Wzdpk/ANrM48l3Ync3BHHuSb8BBTBDLAT0xXPDrsOqYrU5rpTBXmOzZqoJD9gtruFMbe47HF2os9XVkNZq73Tc3ub95oYJM3Mqh/Pz5gvW1jaY4tQmDuegdmmJdbNqnZco/q2dh5/rCrqbq02COmXcNTKDLWqcmPy+L5l09lCaC+SOmGgNx2xM2JPMYvxvFR/Zlnx/j07Yi1eqO0EJahufyxfWfEqdp3ALMiFgr1GiSECm1dH7w8TX1takRT0LmCXXvQ7d2PtRPxs9MbC7SW33A9DzeURso/+gbkl90v5wKcNf3S/CDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrcziLSLmwygoZkFLoqj/ib3pWN/UUqOS/+uQ+SI+ew=;
 b=KrlhQFBcB270jnGe9R5r+MbHQhGZS75fWI8cBqIHOD1Z70iQ/2tqlqosOako9o2nxQczwF8uTcxMDxAMj+tBmXS65kd6BHCSJOJRsEpMTlYptebS3nYjxQDJ+M4MUIEd11BoOixtbzGy99tVKvyXLinwbbF8i1qc3tdVebP6g69Xl4nBsRjj90ptpoRRrjDB5r5J0+mqqnOJqdufAcv61UTwskK+0uJEoef0aPGGvSmzIqjKjv416s84vwVLzPO4e9RLc/rD2qYIky0KARZBwAFGAv+Re+tHEhQNwnltzqu/P8hG93WCe83aICCxvG+q6lzqo0e3RIt11+kaSUVECQ==
Received: from PAWPR04MB9960.eurprd04.prod.outlook.com (2603:10a6:102:38b::5)
 by PA1PR04MB10771.eurprd04.prod.outlook.com (2603:10a6:102:493::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:00:45 +0000
Received: from PAWPR04MB9960.eurprd04.prod.outlook.com
 ([fe80::566f:3659:511:76cf]) by PAWPR04MB9960.eurprd04.prod.outlook.com
 ([fe80::566f:3659:511:76cf%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:00:45 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>, Stefan Eichenberger <eichest@gmail.com>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "andi.shyti@kernel.org"
	<andi.shyti@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "stefan.eichenberger@toradex.com"
	<stefan.eichenberger@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last
 read
Thread-Topic: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last
 read
Thread-Index: AQHcqyXwBHUr+bUJrUuXl+mBxXWLd7WdqYeA
Date: Wed, 4 Mar 2026 03:00:45 +0000
Message-ID:
 <PAWPR04MB9960F0118ACC092BCAAB0142E87CA@PAWPR04MB9960.eurprd04.prod.outlook.com>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-3-eichest@gmail.com>
 <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
 <aZXq4gn4xhInQQlq@eichest-laptop> <aaamYByn9dZEIBWb@eichest-laptop>
 <aacECsJ6O8QjHsUa@lizhi-Precision-Tower-5810>
In-Reply-To: <aacECsJ6O8QjHsUa@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9960:EE_|PA1PR04MB10771:EE_
x-ms-office365-filtering-correlation-id: 2f51942b-dec3-4257-6fae-08de799a3ae5
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 F9DqFjjIk3b86XZd9WzNStBQCdOR/xxy+8kjAvfTx+AWcq7ewZpvNVBwfWO5F1HIU+DrTA2GFkkyekEkY65djn0Mc+FiNV6jQZbyPCns1DDOGxvrMe+OVgQDE1GgYqCH0RrQiDdAkaipmJnqm8ydECH7pSmrv+5DPjUBu+Ip7kS7pypBPTjQs/3jWuWOwFPLezRjUcDLIjUZyBRXmhlxiK4oXr5A1fSdTf0IxqzHy2T2CobChQrWv44kPaFOjA5w26g/5IHDOreHX4uiAGXYR4WlxuxVwTIQOaxsFNRTfdWyWeJLMXrbkqC1RNxXVpcUY2iuw+VR3sFByETp2DN017kgW4j6oCVSA62svt5chwSGQ2yD3gb8PwnrWQt3hflMMkefqAc8R8Y4DASi3Uqssc0nP2KaBKGBu5+VbxJVy6+U3CCljriSMdOROfkqCHS5YuzAZFrTWwFt//bdk1WpM6Og4dLLoFf/s6hbrkdnxAgos2TSf2AD728shO8CNRt5ch+mbD+B5ToYKTN/EdEIYabErN8wok6FIf+SHYHxKmljVTdg20CQ+VKDqnp9RFAFzsWSdpL07PNYZU8IQ/5o9IX+7GQ+gGZMWJjslU6XtQRASFr97plp5taL9OqtAo5qe77q+sz1V8hUTVKWW06ggTAt3wA8Gy398Gu+Ust9Z/X+atMmJn/9MizF0Q1TyMEyohuGTX+O2D5rV5UeUYKDcSw9zbWMutrKRyvvsThWhR5GbEDI6FA6l6zfhTWkHoPI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HOCDvXVUmpECuoUedQVMPEjJfFhkf1XMSmiE6N/xz/2WKSaIJr4dqmSd1Wj0?=
 =?us-ascii?Q?6RFrscNdPoZwN2RwIRC7J9B/zeNvM1mH3S8u3jA9cEm/F9fQNuKcBL6o1nWV?=
 =?us-ascii?Q?Dkur5Kd7wXVa1V4tVP2d/N9n7iUxinqInMQlurcEgK4115uqz7VgMEoSBs+K?=
 =?us-ascii?Q?YAaNevVY9gcpHRD0Q1LPoZqLZ+acBzLOQ53ZbQyLQbeWi7qaFcCEgD2Z368S?=
 =?us-ascii?Q?niUZHOYvW8xiqJ/7B3l2EGfbrRMXIy63DzXL397ruAcMZvAqagy0GSdItVbH?=
 =?us-ascii?Q?FbV9acHYrs4GPbKPttP5nZ455uc0XUX1dOZsMRvZgMMTJwU0JaPmjl4ByYIa?=
 =?us-ascii?Q?tjrm5blqXDsMF8FdjpdMb2cnDfc3S/CYrYJ/lmcMlNbXg1vgfnM4pJn8agl3?=
 =?us-ascii?Q?bnNJeOAXatpAhU0YU23HUrCdtqcZCafB73FJXDVd4V288jrkhDN3+WYVAtdo?=
 =?us-ascii?Q?vCeu20eClXol9+lEPo7BjX3/NpT3NTlCGBtsEtPFojOug6s9WvSn5JwyT534?=
 =?us-ascii?Q?+jCKXsj7xyC4VHmps5i+Dp6d87Pz6e6t+6PXi3NnEGkQR0f5CjQxrK2uuEt/?=
 =?us-ascii?Q?bW3VoNW8TxFvZmRfjvbU8S0kOKxGY1T1cVqpaafQkF0BS+GyuJXegh4N/NQ2?=
 =?us-ascii?Q?Pql6EHVJ+O4VS2zADAAXUlbAdRJrwiTNgsAUZbvKrCKtV1aUK93Wszu727jz?=
 =?us-ascii?Q?IZV7tWoT1t6Lk1rYjj/PwEcblMR2dW2k2M+ePCpxqzAuyXPK3LqHybrE22i8?=
 =?us-ascii?Q?s7QP80zmRWxMM4nk59hK+lcUwog/jO3xPmlqqETpz2H5AAF3AkRLy/+SRqIQ?=
 =?us-ascii?Q?YpdtzoHf/llwqatEu5FYfL9nt8fHdjkRNfz9IszMkwXSCOBZnBSZX6Yl1BA7?=
 =?us-ascii?Q?g/hE4lWoQ3XMDCb2XJOt3gxRmbwoNabm5hHClmpdzVNU8howsBWZPuCL0WlL?=
 =?us-ascii?Q?eT6dbSVh434KbZ5YYjQdyWGswgx5DZE3ZBwNC/eM55GZUTYo4H8Co1+Qs+1S?=
 =?us-ascii?Q?Aee4bOAEqrDT0uZ0SIfaWetGVcMCyHt3wjtWve1TTnUi95qHphXYBMeW5Nc+?=
 =?us-ascii?Q?4eToK7+Nq3vzaEQkLKaYr6xvwDdB/UGaKXqeL1iMzz5SjBvhspZ8jsGw4dc2?=
 =?us-ascii?Q?q3QmyaBhD1K8m4haP1IUEpV9eDKttEsTl11aCjd7kOp6S2s+6ORPWNvfckSa?=
 =?us-ascii?Q?QE/rMVcZX6VnhS9AjjCcIaUaT6XyV6ypNZfnUVqAXZKTesOZrB5wMenw8fuh?=
 =?us-ascii?Q?1ZXz60FGEBZTdSn4reTE5O6Aft4B5OqIZ+eOdLQXx61L2mcqSwQPVXKEzZID?=
 =?us-ascii?Q?cm2IeKWghgzbhUKwVzGNKo06fk2TOl3jymAE6flGDNkc+C3XHx6EkJR/OW8L?=
 =?us-ascii?Q?E4S4xCnKPgYBN7tcqHLqMYkeaX884fChDclcjHZJTnAj2j0eeJzETL+6MHmM?=
 =?us-ascii?Q?kRgvz+U+xd7ljH7pBKbA04eIHj4GZ9Cu5ab24VP70fLTv+bBRRuLc3keJtin?=
 =?us-ascii?Q?HmN0TvZaca7y1oQiC/eM4RE8Ls/2VBjcLuclf8adPR2imrOr7me4fvnavbgd?=
 =?us-ascii?Q?yWfHnwhaSwaFzRFL0eKY6OXk/QXtpkBwepKGNI3piQhFGmaTUv4erJTeuVE6?=
 =?us-ascii?Q?l2+eW1xiPAZREM4paBPv6oxzVabELis66yT5t0rOnUmSMwXBDdV5Y8n30Wbr?=
 =?us-ascii?Q?+co3yBVCikjETYbkGh4dEraPDJ2xPwYMEzI+LUe2veY6+NvX?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f51942b-dec3-4257-6fae-08de799a3ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 03:00:45.2616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FQK+FZ2vi3MPsVt4atTMP6cVMgoyBxbyYxUeUTKoyrbPe+xZJ148hRleEXJe9QFNtgyZg+/WOT/9zXXr/tmxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10771
X-Rspamd-Queue-Id: 4DA9C1FA27E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222976-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,gmail.com];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,gmail.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PAWPR04MB9960.eurprd04.prod.outlook.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cycle.so:url]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Tuesday, March 3, 2026 11:54 PM
> To: Stefan Eichenberger <eichest@gmail.com>; Carlos Song
> <carlos.song@nxp.com>
> Cc: o.rempel@pengutronix.de; kernel@pengutronix.de; andi.shyti@kernel.org=
;
> s.hauer@pengutronix.de; festevam@gmail.com;
> stefan.eichenberger@toradex.com; Francesco Dolcini
> <francesco.dolcini@toradex.com>; linux-i2c@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after =
last
> read
>=20
> On Tue, Mar 03, 2026 at 10:14:08AM +0100, Stefan Eichenberger wrote:
> > Hi Frank,
> >
> > On Wed, Feb 18, 2026 at 05:37:54PM +0100, Stefan Eichenberger wrote:
> > > Hi Frank,
> > >
> > > On Wed, Feb 18, 2026 at 11:26:52AM -0500, Frank Li wrote:
> > > > On Wed, Feb 18, 2026 at 04:08:50PM +0100, Stefan Eichenberger wrote=
:
> > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > >
> > > > > When reading from the I2DR register, right after releasing the
> > > > > bus by clearing MSTA and MTX, the I2C controller might still
> > > > > generate an additional clock cycle which can cause devices to
> > > > > misbehave. Ensure to
> > > >
> > > > Do you means SCL have additional toggle? You capture waveform?
> > > >
> > >
> > > Yes exactly. We were able to capture the waveform when the issue
> > > happens. It doesn't always happen though, it depends on how much
> > > time passes between clearing MSTA and MTX and reading from I2DR.
> > >
> > > If you want to see the waveform, I uploaded it to our server:
> > > https://share.toradex.com/dwnhcrl6b9toib6
> > > You can see the additional clock at the right end, after "0x17 + NAK"=
.
> >
> > Have you had a chance to look at the waveform? Do you have any
> > concerns about the proposed solution?
>=20
> I am fine. Add carlos, who did many work about I2C.
>=20
> Frank

Hi,=20

Just review this series, looks this series patch make this fix for the limi=
tation[1] safer:
"It must generate STOP before read I2DR to prevent controller from generati=
ng another clock cycle".

Previous patch[2] has done this to avoid the limitation. However according =
to the waveform, I2C controller still generated an additional clock cycle s=
ometime.

The key of patch is ensure to read the last bytes after the bus is not busy=
 anymore to avoid this another clock cycle.So these patches are fine to me =
also.

[1] 054b62d9f25c ("i2c: imx: fix the i2c bus hang issue when do repeat rest=
art")
[2] 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
> >
> > Best regards,
> > Stefan

