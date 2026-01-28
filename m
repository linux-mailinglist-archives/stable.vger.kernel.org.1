Return-Path: <stable+bounces-211918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEVUBuqAeWmexQEAu9opvQ
	(envelope-from <stable+bounces-211918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 04:22:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 336999C9D5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 04:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B36173006832
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A0215F5C;
	Wed, 28 Jan 2026 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mF4ghmhX"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381D27B4E8;
	Wed, 28 Jan 2026 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570530; cv=fail; b=QTzv5T+A4tbEuwe4O8KAoIwuzfNvNOFEQSpNFCdJ9jzB5YyA0m3Zdm3lRr5zXmlzXNdFk6vgPXX30hJIwbbZMIBI/ryiNA1O8C8JjWVS6/TiepiqulSnmDWP8tFM8qpU1+56bT2rGwebdR791lwUd6ts1HnR8wwTM7h5wPYCk0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570530; c=relaxed/simple;
	bh=N5s8rESgcCfoiOD0AgteTFqqoV6pMkr7t3OE0Odu2/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S3b2ZyONtOzfV0QjjCj70lQud2H5nKchmId2/NmxKEjbgTTiobcl31a9+mJP6oW4n8gjKHaufye+unevqULpwdV+XlX6ZJ0Z7HRbEwfm2z/Rm2V8c0AYqdbVQuXxjmIhryjxHd707JRRfe5nuWrAWsdA6vwxC5WaFavVETfxSH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mF4ghmhX; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP1s5esDJkLhugI7+E0aaTmR96W2AehgiHgOj23aCVZfyZ3ZYCZUXR5TsznD7livwINFZFzb8vlvOGiEiRN3zvv1OT0yPfcSROm21sMSGyFZxuUiU+euAjpod2NKbmKUjYy4ZpKjVwBp4zZ2dvAhdLAzbaReB5zuGn3FX/3FMiZEsTwqM29JaP/BtO71rS2Rr7PR8VMOi6I2bYqKrw3+sZdaIBRurvDwrl65RgWjUj2YwL/9c5P5ptI7wnYM2XP45RGxdQjR8j5KQpVtMUFJKDOU9Mfh4srpRiUDF7B+8ompbDVrVcpxN/jCUTB+odsunRBYw6r+vypQqek+9UWnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVN5IsKwErEWew3dNfuVCnrqKUi2ZoLjKoBGZokKlac=;
 b=a9BMmC+Pu6kApUmwqoRwLS39uSgj7lQ3ZEvcNAkZSxPuChoiQ78bT2t88WWEpv93n8G9uNQZVW5JyWKOdxnweRls6Uzo3pwxAuaT7/l5J7/uMHHUA1c5JGhd5/a7//3ylxd6xFWMIw5OtGsUrGj5cG2E4DhEh3jL7qnOP4o/5UNFJWWAWHSplrUp3JhNaAkCkcxGgHD8LGyHmsFk2yaNxtPaJqoy215fJyF8LhQAwvZxsUNDF/csgnZvmRKbrAnc1KZGM/5AjXLFHZF2aLeoXTvL0f79cQKfx5JPASY8/sU5ff3fljUaY6YFAdMz+XQjfQ6/yQ10e/qFTZJcq1MVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVN5IsKwErEWew3dNfuVCnrqKUi2ZoLjKoBGZokKlac=;
 b=mF4ghmhXYW26oYt3qRdhuTHDfZIeSz+tpww72IumWg2pegUmyBWwgmGtvvhPvKJj6Zxz+w5YDNiL6/yDOo0vyDLGUZrmJFO+MntgO9qvrfGKb5bvlTB7zuINsf+ILKHnHFR5uJAyefO9gJiA6ZoMi8TQreT3q8K37LKoyJh7QKuJbd8UxDxx24eGc2MNYTdWcilWGhgjEndLYOZAFEBysodU9Ynq/GDosO5M71NIBEnPwQKgvgPk5t8Dz0s95NDICUMm0gYKJ2mZzXu5nTyeQN96fN3QdHW8Mrfd567Ep4sKe8AJjzUYGs3mNKmuRSo0YSBiGfqFvETuH9flzHQAWw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7453.eurprd04.prod.outlook.com (2603:10a6:800:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 03:22:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 03:22:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>, Daniel Baluta
	<daniel.baluta@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>
CC: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Iuliana Prodan
	<iuliana.prodan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Frank Li
	<frank.li@nxp.com>, "linux-remoteproc@vger.kernel.org"
	<linux-remoteproc@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] remoteproc: imx_rproc: Not report loaded resource
 table when none
Thread-Topic: [PATCH v2] remoteproc: imx_rproc: Not report loaded resource
 table when none
Thread-Index: AQHcj1leXm2g+c1E4U2igK6CwDHcbrVmKbqAgADAEOA=
Date: Wed, 28 Jan 2026 03:22:03 +0000
Message-ID:
 <PAXPR04MB845923F8485ABF7DAEA390CB8891A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260127-imx-rproc-fix-v2-1-7288fcf74385@nxp.com>
 <CANLsYkznMVh240wMUZGayJHRzsUV-NNTiU+ezpLt3rjcwSn5Wg@mail.gmail.com>
In-Reply-To:
 <CANLsYkznMVh240wMUZGayJHRzsUV-NNTiU+ezpLt3rjcwSn5Wg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VE1PR04MB7453:EE_
x-ms-office365-filtering-correlation-id: d9c48724-80ad-428e-bc80-08de5e1c683d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ia2av7ajzPTGJXZ9OSWoAXZYROYvV1EFf3C6/owZvg1z8jD3HVPXmsOjXe66?=
 =?us-ascii?Q?fU55UHj3qHrzuNKLJkAKt3sSCnK0voG3iSZ+uYtD14BVFcGiIRNYaqmKN32r?=
 =?us-ascii?Q?ZA2ME87EnuUVgXoHg0BiQRC/+84MDrpPD2Kix0bAwZtWFbpsShGDZS9zmjmt?=
 =?us-ascii?Q?x1jrZHDI6SEnliUgBF1H7djtL5XHFq0MNQibhLrtp2mWqIWleMtKfCGtmwiv?=
 =?us-ascii?Q?Hq27+tbDHsoNiAqlsMoDLi0nwMbIZhXU7fhFyZmY32RlnwmjeVVTN5Zud1or?=
 =?us-ascii?Q?fBL+yB4EtZRQ9kZROjn6qr0P7G8YsY+PaH1r7tyiq15R3BCiBHnNE9NaXeYj?=
 =?us-ascii?Q?yK4OkORB+ZCWwiH0qoe7BT6zc8xUOZOGRfTTOSE48HPS+nrrougPoJqbRqHE?=
 =?us-ascii?Q?RJvkJ662l+hFYj1jbTkEBCtUxyCaF2oB/XwLNUhNOy2kGFniDk1holsRWPnH?=
 =?us-ascii?Q?ClYeK63XIQ+WlPaIfodZg2jOx/JdEz6jaHgJKOlL31shhsstTGtSxX78DwBQ?=
 =?us-ascii?Q?0TFCJQ6+yBfM3UgdvO2D9SSH4MJyvL5HEXw/5C4zcbO//T+QQR68/CL5J/Nu?=
 =?us-ascii?Q?RnKFgzKyiyuKu219jdQdnj95x78NIrPA6XEmD07QiFiJ0c6qS71BHkP2nglN?=
 =?us-ascii?Q?eGaf2ne6dQQhkJZajCt1na0PVtBDXv781EYaaRMOQeyW0dvRuke9g7VxLqK8?=
 =?us-ascii?Q?yxWeJVQjBjNQ+uOg1q5Ib3CQiqac8l7SBOUCk4nS9P6yiuiIzWTwo7+EOUyU?=
 =?us-ascii?Q?UpgEFNU7mbRAX8inYdFoyDAHUeAWHX22iuIrBIgEtFA76C5T09iJX8GBNtK1?=
 =?us-ascii?Q?QT3WzfiEp1OPhZmuJZzDvf/uxHjnB+H6LPUK9Gae2V1utbYOcldycHEIVpZP?=
 =?us-ascii?Q?JBijvdFNWyLFnl5+AU7xMYAsv27Ugi4nrxK2rjZxKhWSXhiaytqnygH6ghK4?=
 =?us-ascii?Q?EoCZ7vS9K+IkCHq9tOiycS+5ilQMZ8zpMW3L4evsMK7D5YzGoFvzkoC9BbR4?=
 =?us-ascii?Q?77DQD4n0I1cxAg4uN2bDS3T5TH03LUhtM/A6pIAhsg3uxPaobCfkaJxG0dkY?=
 =?us-ascii?Q?cyo7UFgoxzl1iOL8fXrUq/BZ6rPmp9q0itWWiiXNQavFKYU+5Y37xVQH7qaS?=
 =?us-ascii?Q?W3Fu7igUUKQqlLnQN0vMbTa114r0F0mYSlkQtZsQgwq7jC1kGPHpoLeDZsJi?=
 =?us-ascii?Q?4v0hPk99y4kbGX9nrsHhq3gVyv9MRCmtwWxTNIk7Y9kOQA+iWIFz/ehNTm8n?=
 =?us-ascii?Q?fUzfR1nleJx3Jzwr/Fr66wckAc8zAszcFFdHWLWyVL8n6c9WJ3QW26ITWVpT?=
 =?us-ascii?Q?e2c4MrftmRBfnTKGdsFnxurmtWuZRecTeMewR2PyTmg6vITsYCnFzcfHLjsH?=
 =?us-ascii?Q?REUIjpWvh7LbEQjNGVd5EiuxoPbkvsoG4hEYzIF61TVir828BqmJwo0BWOuX?=
 =?us-ascii?Q?+S1cAKEN6fP6FQ5hOT3iFFRdiuOTXhEwUi23HwBOoaGPRysM6fJBlxR+Mwy5?=
 =?us-ascii?Q?BVHXcnqbo+G1fDQNuvnbVj6MJDQf+jnHqHpCRlPClbrBN2RIGy6nWrCmIcMt?=
 =?us-ascii?Q?lri7qIGlG2qgY9WkZ/Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9aYv92LtWXgo7UFgWDF/oZkmROyHOGOEm0fOV1kUuxgPI3x3D8w2H3iZOzQa?=
 =?us-ascii?Q?KkYFnR5kG5f/pQWHDhIiUfK1aNAjQeVg0Gz6C6ieLmdCgre1akmLwaoapEdZ?=
 =?us-ascii?Q?xCCl3nuyrfNkhb4R5h01wXXN1xIclOIPr0e3aKa0sLzytblYGufjiruzo2Sb?=
 =?us-ascii?Q?lHV8S/M3ECSWxse6aHJM7xsV5ikurOUfVvfeAeVm6cEfKA17QSa9wDT1eNsP?=
 =?us-ascii?Q?IMl4x/Hg9nIswmf6iYzusoTmsomeh+2weMHErq1ml7PwE6T/Rf8Yl/kSZ3+r?=
 =?us-ascii?Q?SGePVm5rl2kZgSNtASI+1TDsLKRHpinTuZFdsN+xA3S7kchQpfMxObS8DVay?=
 =?us-ascii?Q?7WGYeSKFhtdN/uaPRNMjSMA4K76YWnwbysUtBNNpeli9Me7ddPIM6fAJWJI+?=
 =?us-ascii?Q?2wQ3inbjT3GqTcTryFB0cdKBibN8VTi27SoFjbt/gDSO7J42oJp9hFEs1dTh?=
 =?us-ascii?Q?lw22gW0XyeJzMZli9vq0ac2v8K/LdbPnJ8Y6ynVXZbC2Olb7rKk7AOmkILzy?=
 =?us-ascii?Q?KcDhC5u6/yd633RC4nMXDxO74ftLeGb3phJts9kR8GJrrZ5xQPnv726Zu3dn?=
 =?us-ascii?Q?1AWXB+oFSX/w+THPAxrzY0GDcdIwZBTZdHxJaeCcduNmrR1tX3vyFSTeN2dQ?=
 =?us-ascii?Q?H38BMUhSUXz0K2YKJV3J49DvrzHMBa2WmwtDHMsHsDxjPDyzGEN0nBvCdSfn?=
 =?us-ascii?Q?fCqVrAR1WBIeUtapl2Ven+6CX3XJBe7XsKaNL42OnAzYTbVj96z8Xr6Kzv27?=
 =?us-ascii?Q?+N1FGV9dR4pF6oXvx65na83YTAoRL639stxUK2DI6o3FCpKxn+/O9KYDcoXC?=
 =?us-ascii?Q?6DLNa0YcXxlPgGAJIW3MQpoXAlFHwtA4wIf66qz+BakMVrazWP59prkAJCjc?=
 =?us-ascii?Q?o9gUVBh5h/GKHMh0DuEDjE2+gm/oxZ4kIqHTS83UK9ej7NwfWkBdI8TOqH6K?=
 =?us-ascii?Q?8GUgAaDT/PXHpiQAyMLo4jP2OtdG62XeC5jekPzyTMyluhSOqpYfysA+XCbW?=
 =?us-ascii?Q?1hIoguMFWEQ/uPNHHRpQFq+WryyFdkUlGp0L4aa9IK7bN3/SnYb2ysMl5OSc?=
 =?us-ascii?Q?Bdwtabkmc7QmU2Z9YmR0Sm06hKq0XaEceOyW6UCC17L/vMdr/O5cQzXtjQx8?=
 =?us-ascii?Q?rN2n1JUE4OEqFgMoV/yrGeHCgPWKnlFDmKqJRXrG+XVtAi/ecmF5lsRKCnao?=
 =?us-ascii?Q?Z6zEC92PZ1fFwdzIBCKFS7L1FTKavLgq1cB3pmtEmkjA3AjYFLjOIrb+IIVD?=
 =?us-ascii?Q?auTGPIC+AfSm27NixVFtSKqkYDU4b7mkaGUdXfKCH+eVy1zZW1w9gEKpHu4w?=
 =?us-ascii?Q?ILaMkuLyjNqCNWfweoSVvsi2GlVjHnqj6VZzTMiRuG+hZQBNlIw6Z+WTaRCb?=
 =?us-ascii?Q?2fGicFqXIWu8N0YjpovrwdVslsrd6KUM/e0b1bSsOuOk7BTPl9B0vDDlIhZs?=
 =?us-ascii?Q?MlwpUAux8vcFBMzVcyXiufTdiMOSd7Rcgvy9oZFR1/Y3tw1xPN00VZC7o6Yi?=
 =?us-ascii?Q?o61wDPB86Mz3jVQA/lM2HN7zmxxNMCz6UbmlOYs+0I/cAQpDI0IUureJ1UJK?=
 =?us-ascii?Q?FvmzJBZYI5TlfX4VuLQj6izC63luZwkdbR8UyHObilKtXGhql5BT1mnY76Xo?=
 =?us-ascii?Q?aaiBcF1hVZHlO7QiWmiV+WtObr3M5Zkfqnnfw3V/zCIvpLQIZWMgZHvv0jTL?=
 =?us-ascii?Q?xenL7rRBxjRuqxs2oJKpLgjkO0FbdHbxC5ckeHyCHYUyOyGw?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c48724-80ad-428e-bc80-08de5e1c683d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 03:22:03.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ojwoe9Ph524aDvR9OCdFFvoPSP9jTw7m1vp/I2FsuUm32BOU8Vxhin7LEfk4KaX57SCFaulzLu+yU0oqBy06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-211918-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:url,nxp.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 336999C9D5
X-Rspamd-Action: no action

> Subject: Re: [PATCH v2] remoteproc: imx_rproc: Not report loaded
> resource table when none
>=20
> On Mon, 26 Jan 2026 at 23:51, Peng Fan (OSS)
> <peng.fan@oss.nxp.com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > priv->rsc_table is not NULL if the DT has a "rsc-table" entry,
> > priv->indicating
> > that _if_ there is a resource table in memory, that's where it should
> be.
> > Function imx_rproc_elf_find_loaded_rsc_table() is buggy so the
> > narrative about a previously running FW with a valid resource table
> can be dropped.
> >
>=20
> (sigh)
>=20
> You apparently did not understand my last comment.

Sorry about this. Does this looks good?

Daniel, Iuliana, would you please help review?

remoteproc: imx: Fix invalid loaded resource table detection

imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
resource table even when the current firmware does not provide one.

When the device tree contains a "rsc-table" entry, priv->rsc_table is
non-NULL and denotes where a resource table would be located if one is
present in memory. However, when the current firmware has no resource table=
,
rproc->table_ptr is NULL. The function still returns priv->rsc_table, and t=
he
remoteproc core interprets this as a valid loaded resource table.
.
Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
there is no resource table for the current firmware (i.e. when
rproc->table_ptr is NULL). This aligns the function's semantics with the
remoteproc core: a loaded resource table is only reported when a valid
table_ptr exists.

With this change, starting firmware without a resource table no longer
triggers a crash.

Thanks,
Peng.

>=20
> > In this case rproc->table_ptr is NULL because the current firmware
> > does not contain a resource table, but the remoteproc core still
> > interprets the non-NULL return value as a loaded resource table and
> > attempts to memcpy() from rproc->cached_table, leading to a NULL
> > pointer dereference and kernel panic.
> >
> > Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table()
> > when there is no cached resource table for the current firmware. This
> > ensures that a loaded resource table is only reported when a valid
> > table_ptr exists, which matches the remoteproc core expectations.
> >
> > This issue can be reproduced by:
> >   1) start a firmware with a resource table
> >   2) stop the remote processor
> >   3) start a firmware without a resource table
> >
>=20
> Another sign you did not understand my last comment.
>=20
> I had hopes of merging this patch but the changelog is too garbled to
> be salvageable.  I suggest you ask Daniel or Iuliana for help.
>=20
> > With this change, starting a firmware without a resource table no
> > longer causes kernel dump.
> >
> > Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook
> for
> > find_loaded_rsc_table")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > Changes in v2:
> > - Per Mathieu, Check rproc->table_ptr, update commit log
> > - Include R-b from Frank
> > - Link to v1:
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore
> > .kernel.org%2Fr%2F20260122-imx-rproc-fix-v1-1-
> 36cc64369a40%40nxp.com&d
> >
> ata=3D05%7C02%7Cpeng.fan%40nxp.com%7C781fb4227e024211e71c08
> de5dbb609e%7C
> >
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639051256532
> 530786%7CUnknow
> >
> n%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> MCIsIlAiOiJXaW
> >
> 4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D0
> 3sG8la72ysD
> > ivP9SMmA9Ry2YaiMvCjsHWAWaGFOVQw%3D&reserved=3D0
> > ---
> >  drivers/remoteproc/imx_rproc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index
> >
> 375de79168a1c8d11b87ac1bd63774a3feac106d..f5f916d679051936
> 0f446f063e09
> > d018c5654953 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct
> rproc
> > *rproc, const struct firmware *  {
> >         struct imx_rproc *priv =3D rproc->priv;
> >
> > +       /* No resource table in the firmware */
> > +       if (!rproc->table_ptr)
> > +               return NULL;
> > +
> >         if (priv->rsc_table)
> >                 return (struct resource_table *)priv->rsc_table;
> >
> >
> > ---
> > base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
> > change-id: 20260122-imx-rproc-fix-e206f8e6e477
> >
> > Best regards,
> > --
> > Peng Fan <peng.fan@nxp.com>
> >

