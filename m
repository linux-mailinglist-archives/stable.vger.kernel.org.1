Return-Path: <stable+bounces-124649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2CA65698
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0F93BA32B
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB6323D;
	Mon, 17 Mar 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ndq0FrC0"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A0199FAF;
	Mon, 17 Mar 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226419; cv=fail; b=YFyaDCkejpSt4+BD5UTpt8HRkZ68jc3goNelzf/ZQp/GO5GeacodDlnyLl/9b8m8iwVK1FnE9V5R9LnyevColY6vivGpe6Xj5cqeYBU+gyUL5iv25SS/ejwkjeGsBtaVDWzsg9+PTVGeJQJK8c3t27LUmURcnEqXKxrsvHFTT8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226419; c=relaxed/simple;
	bh=6559Z58h8FFFwJBsONFRsRhlOSQI6vBI5baE5Ogu1d8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j7cTV2E6sKvliGYwCY2NaASWhrtQtnGa0dTPiHJAOJiAmWuQa20lMAxp6UdVKG2hliLA7XIIDKdPbopap/uyV0BpF1HzVW0swltIy/PugywRA6PAJs62zPnqp/CmjziVnR6+PNZkzMUSS+t6TkLuNk00fRb5CAM6UzOafLxZBKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ndq0FrC0; arc=fail smtp.client-ip=40.107.247.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTUarFJf4eqTq1mZZv/EP0z5pppc7wLQtHfWLzTPjUG4Ac/tWq+3OryXYEMz+imGIInpF1FVppN80i6C+ocuUMYXNwP3q0Ft+NVW7NbGvmI+tYs7ozvp676AWxiPyw/njDZv1jKPN+o9d+NWBF0Q96FGjKzvrZdDEM6+lCQDj0irdd/IABf+Yhg25oCdOAG22DuvovdGPllibU1LIdrpRjd1sjbaBlMy4CTMfK/rMAzSYmA4LIONJDzplf3vHVuYUkslcPwJz/EypOg3XXv55Q5ADKIOx/l61LKHw7pIDyS8ecRhKlQ01PYjzAzwJf3GB04KJfodrF1iuUN1F1ZNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWZF58oawnn3EaR4IhzFjrU9hv16HEeNnCZIKR7Rmy0=;
 b=yWVG8gk3QMdhiWPtL/w8ly5nH30wbxUiJy+pjO/R8Yhhjz/dnm3Nuwb8YRHSkIZ/B4D+cFlR9EXkW+7ZeY4vTpsqu2qI7BSlnU/dhOOPpxnl1sXAJ6Ow79vuviiUfG1LcZq/P5SguVQBAEyoq0yY2j1SwBq0PBDfddPLJeqHxiXJiMAa7/hF6qR4XrOtXkTRjdshLyzaUg0IdMY/mZbdNAVkCFV//tlyv5R9mPCAJKHAxq+GTPHygnc3L7p5Oor9RkQ+JvzDqRk3ZvDy4zxsOOyh7aaAopEQOmmp0T7JK65kenzIsdrD9FghOWmNaHv7vJ82dcIlCyz7/AGPTYP4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWZF58oawnn3EaR4IhzFjrU9hv16HEeNnCZIKR7Rmy0=;
 b=ndq0FrC0yaAJGSwF8pGojN2soMI0M2bxbLSq9LJ4V0nSrm9I6ew7sA5gPJ4YA019VbCEi6dnpk4ZYP1JTud+zAIZ3WJEVJ8IrxZ0K4fsxEhMOQpi3cLabDKKZtzC172UnosFdzEC6tMMnlYeATCsUj28tjnTmsMebv3gJbxws5tpKmmYHw32wApYk6xp6HQp5/lINHUQy1JQL4n6kvDgwILNP3jZK2b43TDDuSigxK/V7Hm8AZGfOg1iBl/M7mtFdldQoW6aKyvoqXf8HirVi6ALkoIEZYYBY5MsNwnzQTyduFNLhWH4tvOeY85WhEm6xtXSXMQWOjdhOE6X/5Bojw==
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 (2603:10a6:800:1db::17) by PA2PR04MB10411.eurprd04.prod.outlook.com
 (2603:10a6:102:424::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 15:46:52 +0000
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee]) by VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:46:52 +0000
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "rvmanjumce@gmail.com"
	<rvmanjumce@gmail.com>
Subject: RE: [PATCH v4] svc-i3c-master: Fix read from unreadable memory at
 svc_i3c_master_ibi_work()
Thread-Topic: [PATCH v4] svc-i3c-master: Fix read from unreadable memory at
 svc_i3c_master_ibi_work()
Thread-Index: AQHbk1Y4SkbCrYt+yki4ZS7j1qEGurNv0p4AgACyIrCABtUNgIAAJa+g
Date: Mon, 17 Mar 2025 15:46:52 +0000
Message-ID:
 <VI1PR04MB1004979B7D38486FD1E1CC8508FDF2@VI1PR04MB10049.eurprd04.prod.outlook.com>
References: <20250312135356.2318667-1-manjunatha.venkatesh@nxp.com>
 <Z9HSdtD1CkdCpGu9@lizhi-Precision-Tower-5810>
 <VI1PR04MB10049644F3287C378E9CC75EF8FD32@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810>
In-Reply-To: <Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB10049:EE_|PA2PR04MB10411:EE_
x-ms-office365-filtering-correlation-id: 31c3f478-3d64-47f5-f9a1-08dd656af00e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6uXuchfkRQ751M6rnmjyvxgt8ITa7f8sJOhwFbPLVwDd47yandTxpoXiMuMW?=
 =?us-ascii?Q?0/tQXO0PhbMqOau4CaJQYfPDFn7iKBZ7QOyDAvYZQkJFS47fw3Pm+OaO/nw7?=
 =?us-ascii?Q?5NT/k6h9IzP/EP7ORqjbeA8po2eKHFjeO49X4u93vARdKfwKxZyUIdnEgeVW?=
 =?us-ascii?Q?ao3qy8JO6ff51KvnglaTJkojseKnHSz8TR3eXMr2lIfSw11/QRyVdb0Et8u9?=
 =?us-ascii?Q?Yfu7TIFH5dzW9Mz3V2pA+GWkaH5nzu3o5Cum7/sBtFXmzFTQAYeSQVPw/58C?=
 =?us-ascii?Q?QfR6n4EUmr+I1OESXNmD/0lzuTRiPQwLRAh1iRBZj4FeMMifCgcyPlHx6tvO?=
 =?us-ascii?Q?42zXQmDtd5dJ1ZLbW2/9dDicZXTmJrtj/cZPL74Vx76GAG5nMbReCWYRWT57?=
 =?us-ascii?Q?Ll0TF54JhMJlXWzrfYYI2Oa1jyJkdjIbDiqC4iPpOZENUdGBVRcJagugNW/a?=
 =?us-ascii?Q?Gkp7cpK/JoSVlvKz+f6YPh0l5dSO2VdF2FJHxGFZE9IjV45657vG58U6V2k/?=
 =?us-ascii?Q?w1ujMwAmEniVM040uT61pR3KFmjrP35DLK9sD1ep+gf8/mRtm1JrSu22OXia?=
 =?us-ascii?Q?9L8SLXE/Lyw5KPopAlD1yKXpjqicBX07hOFVMUIFKhs6da80cLyz1bqRz8hW?=
 =?us-ascii?Q?zxaOQBDXwbVq7S0OZQs0ZNfx/p9le2WSaFsP4hMdP96ZIk4dSPhXHfBy7rYI?=
 =?us-ascii?Q?jYCkPrBneG3K1lhDa1JaqbKJ3VMsbqTj4UjhUtXYI7zqlCry/qGy7nC7NgQM?=
 =?us-ascii?Q?bip/l0PbQvRjEOk1ue2fgR94x3zU8PU0pMjt8YHXbye4CP6xUOyAvZdemcX6?=
 =?us-ascii?Q?NfFNDX1siOBwlQ5hSh+mgAhW+dkMV9R/GZlMgi2XIr0sak2t/QlOFacD8QlU?=
 =?us-ascii?Q?gsrcuDC1rldYT758lCYsQx16DW/flfdeJvnOF0LfVHnfPHmiIbA/o7L89zIk?=
 =?us-ascii?Q?Kand3VkRofKm4YlUGFlZpGJvv1BpeFflzNZs51SXIuMNs26r0ldo2JTfP8Yw?=
 =?us-ascii?Q?8sqZBMB1NxZGmq1gcL63/aBKIxLz5DbPRLHMDUBa21NO4NUH9VZLlwA835Hi?=
 =?us-ascii?Q?xO6kctHer3UEpMRVGSxdFsSIJaMUrNWzVGE8tUoBN1Q0/yXu2AIl/pb0NZe+?=
 =?us-ascii?Q?pPwxSJJGJTkDlimachLvByXcygIUDYxqVVp+vE/bm85Id/R2WhdXniq0XpbI?=
 =?us-ascii?Q?iBKvUjbmzmQj1dJPDmqPHRQY79VrBMZuLb19J4MCnWEo5qqz11Isk+152c/J?=
 =?us-ascii?Q?nRPV6yVOpRzevpfu2h5QSCowuh1KyDBzFVz7UatmSHvc/AtAVkmIzRZf8QxQ?=
 =?us-ascii?Q?adJCno9G4sq7QUwTRlR2b5r7Z4OVqgWx0yNX+8chcgxX/zIcY3fMKdJU0mTq?=
 =?us-ascii?Q?lY8l/rHK1YhpJ2MLQajNdspNiwCgT38FsnH+eVgsao3ujBq0DO+TG9BotAUL?=
 =?us-ascii?Q?zYQt8ld4jZ5ZhWP/W/1tN7paG98w8sILJTrTSDNvkqBkXwcSMfTz/Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10049.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x+uwBseHRgnZdyP5qmf5ItNGASlWR/5X01hSbQCudekaDisPquokxW02CSZX?=
 =?us-ascii?Q?Sj0eSFW2Dz7u06a9QUoctDgHQfPaHEOAid7S/uM8Y83/up5UWksdDANws7UF?=
 =?us-ascii?Q?6Nn4lmPmMfQdjmcbzKlX+S2WdnUyIiwUk1hvpbUJ4FGgBorrGj8SBndXRlwv?=
 =?us-ascii?Q?3/3nPAB9NBPgSKzvU7evLCEay9VFZVLAw0VCXRzji1tvczN+6YNGtPDQj0L/?=
 =?us-ascii?Q?WppbnSPV2tIRVucU847sGDTLhdnA5QnKzAeZzdzPxfMUFwUIqQLveqEEHxN5?=
 =?us-ascii?Q?0zb879idb98y6x5oo+A26axFo9OBoFC1evgHLFTIFmWp5sGKSpHKVE0HBOl5?=
 =?us-ascii?Q?omQPOg0VQrnOjWsoDeE1YzVHDB8jNdiDmwQZ5zIcRHhmxulZqTKN/3iaoo9U?=
 =?us-ascii?Q?WnpBoIlNtC9dkziu7cquHyo4TRkXFfblJMBoVXJEpiuTZVQ8Afgb1DkIbZLs?=
 =?us-ascii?Q?BAfmAcjJHtA91wXUAUX1VRc1rCiI9ZptMJcPZXb+bGRul9SuQqEwh6VX7Yjr?=
 =?us-ascii?Q?cQE4TGufVlr91R9QLbiuUmv8tuv+Or8P2YEPh945Ypjc15wC5LeWb9W/pWiy?=
 =?us-ascii?Q?6tCeNidTSjjTd3u3DZ1A+XFAx8Ykm23W3dTmsrVx+knRRyq/OwPpGYSZLIp0?=
 =?us-ascii?Q?1wwoX23C8HUAOF0X6BBnfHcMKJTJFhQjRfRsakIVmEPpMfjnzPoqUluCzfms?=
 =?us-ascii?Q?86koEAbWKXH1KXFClcLWoeVYUtCdzsA5SEt9lPfIgik8vhzjoQ989j8Jo7NY?=
 =?us-ascii?Q?odxe1OnaWm/EGV0dK7jK98gRAqYHtZOEB7bKq7O0e2LhXqQ0t+WyrXkK3Eev?=
 =?us-ascii?Q?gMjCJ8QRT+pSCbwBi9U11JBBvG2zfxO8QSWV1qbQ7wkrzqPFDt2DWQ3f43UH?=
 =?us-ascii?Q?Iw6+8URY39vYG3sse8TRNIbF9Wp2FCqTBKQhAy0aDvY23tpkLDOSaQQi1WEk?=
 =?us-ascii?Q?oeqgsyeEiOIsIWt+l0fLZBgYIsThHgQ7B/eAyx8zo6x9gSoVwADr/rGMLglA?=
 =?us-ascii?Q?hwJaGfUuvB2M3fmfSpDAE4JShe73gaIcnWYJ7OI2IZaR6NMftJUC1ksE/Tuo?=
 =?us-ascii?Q?zIaBXhb0o2DO2KFtcvJRVklp4tIeMP1rkWp5Sy8rdJE3q2mphQScUCpcJWCg?=
 =?us-ascii?Q?i1KN7/JXE9ljVuTiTEbw3XQx2egJBDMwZxu7NfBMZCUHzYSJ4WTm85GVOKnH?=
 =?us-ascii?Q?h0i871E4EykywiUG//scIdKeFVW6xZqP70V9qpQjEZ4alGhDEtAvqcStFtHu?=
 =?us-ascii?Q?3P8rtx5wTi9qORFOAMkSoJHir+OMPpjuW2I2Zwwk+pqtjI3cJfrHLixAElLd?=
 =?us-ascii?Q?bHe82dAQk1SUxyH7mr8pRvJbQrIzdkSt/1kxlPl5Rm8a5Poiqp8OteCFQAUG?=
 =?us-ascii?Q?M+kVnB+OJq+7OU//kmcWNLt0CF3k6/PqfQ+9z+JbBULnityCsBI35BPPrWOI?=
 =?us-ascii?Q?wNglxVDgvqWHi41T0xev+KOsfUiPCVgfGwYXN8bzdP9loo3WKYIysVvjYmbX?=
 =?us-ascii?Q?dmmmZSkmU/oJxoTi+OrXwh2JYUAsbIleJy0ht+LW5s150LrYIF33d7+akrkV?=
 =?us-ascii?Q?ftyKO8WEMJrEg1/dQkJafsLSbuUkcWO9zFXQa74pgoDlcjQU8FueCZxliYI7?=
 =?us-ascii?Q?jg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c3f478-3d64-47f5-f9a1-08dd656af00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 15:46:52.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7w+S0BsOjsAHcCNfse+rez/rWw0XLM18qTOv1kY1TiwsCU0PoIBQt3PBqQvk4qjwsm0dPSY5zWp8NTX4/zgNOCjucwWeQ5GG715uDEpoJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10411



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Monday, March 17, 2025 6:57 PM
> To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; rvmanjumce@gmail.com
> Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable memory a=
t
> svc_i3c_master_ibi_work()
>=20
> On Thu, Mar 13, 2025 at 05:15:42AM +0000, Manjunatha Venkatesh wrote:
> >
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: Wednesday, March 12, 2025 11:59 PM
> > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > > kernel@vger.kernel.org; stable@vger.kernel.org; rvmanjumce@gmail.com
> > > Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable
> > > memory at
> > > svc_i3c_master_ibi_work()
> > >
> > > On Wed, Mar 12, 2025 at 07:23:56PM +0530, Manjunatha Venkatesh
> wrote:
> > > > As part of I3C driver probing sequence for particular device
> > > > instance, While adding to queue it is trying to access ibi
> > > > variable of dev which is not yet initialized causing "Unable to
> > > > handle kernel read from unreadable memory" resulting in kernel pani=
c.
> > > >
> > > > Below is the sequence where this issue happened.
> > > > 1. During boot up sequence IBI is received at host  from the slave =
device
> > > >    before requesting for IBI, Usually will request IBI by calling
> > > >    i3c_device_request_ibi() during probe of slave driver.
> > > > 2. Since master code trying to access IBI Variable for the particul=
ar
> > > >    device instance before actually it initialized by slave driver,
> > > >    due to this randomly accessing the address and causing kernel pa=
nic.
> > > > 3. i3c_device_request_ibi() function invoked by the slave driver wh=
ere
> > > >    dev->ibi =3D ibi; assigned as part of function call
> > > >    i3c_dev_request_ibi_locked().
> > > > 4. But when IBI request sent by slave device, master code  trying t=
o
> access
> > > >    this variable before its initialized due to this race condition
> > > >    situation kernel panic happened.
> > > >
> > > > Fixes: dd3c52846d595 ("i3c: master: svc: Add Silvaco I3C master
> > > > driver")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Manjunatha Venkatesh
> <manjunatha.venkatesh@nxp.com>
> > > > ---
> > > > Changes since v3:
> > > >   - Description  updated typo "Fixes:"
> > > >
> > > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > @@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct
> > > work_struct *work)
> > > >  	switch (ibitype) {
> > > >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > > >  		if (dev) {
> > > > -			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> > > > -			master->ibi.tbq_slot =3D NULL;
> > > > +			data =3D i3c_dev_get_master_data(dev);
> > > > +			if (master->ibi.slots[data->ibi]) {
> > > > +				i3c_master_queue_ibi(dev, master-
> > > >ibi.tbq_slot);
> > > > +				master->ibi.tbq_slot =3D NULL;
> > > > +			}
> > >
> > > You still not reply previous discussion:
> > >
> > > https://lore.kernel.org/linux-i3c/Z8sOKZSjHeeP2mY5@lizhi-Precision-T
> > > ower-
> > > 5810/T/#mfd02d6ddca0a4b57bc823dcbfa7571c564800417
> > >
> > [Manjunatha Venkatesh] : In the last mail answered to this question.
> >
> > > This is not issue only at svc driver, which should be common problem
> > > for other master controller drivers
> > >
> > [Manjunatha Venkatesh] :Yes, you are right.
> > One of my project I3C interface is required, where we have used IMX boa=
rd
> as reference platform.
> > As part of boot sequence we come across this issue and tried to fix tha=
t
> particular controller driver.
> >
> > What is your conclusion on this? Is it not ok to take patch for SVC alo=
ne?
>=20
> I perfer fix at common framwork to avoid every driver copy the similar lo=
gic
> code.
>=20
[Manjunatha Venkatesh] : As per your suggestion tried the below patch at co=
mmon framework api i3c_master_queue_ibi()
 and looks working fine, didn't see any crash issue.
if (!dev->ibi || !slot) {
             dev_warning("...");
             return;
}
Will commit this change in next patch submission.

> Frank
>=20
> >
> > > Frank
> > >
> > > >  		}
> > > >  		svc_i3c_master_emit_stop(master);
> > > >  		break;
> > > > --
> > > > 2.46.1
> > > >
> >
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-i3c

