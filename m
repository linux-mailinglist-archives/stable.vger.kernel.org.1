Return-Path: <stable+bounces-116619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB03A38DBB
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 21:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAAD188D620
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 20:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B45239095;
	Mon, 17 Feb 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HRROt6ZH"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974D238D3B;
	Mon, 17 Feb 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825795; cv=fail; b=ugyOYXa/L08d1gVXSWqWgg5U/ZQohDYc0qyirbV/BsEy+PyhbAgCwlCw9ARo94tD/laS4ZQpk/QF2htLNDC6rHKaRBdWLpG3MXLeFWK3dwYiKf/hYF2SoAp0f+mWS13j9xuDjFwYQjTJxxsFJ+0PK+TtqA2sw+L6UC6UqGZ6w4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825795; c=relaxed/simple;
	bh=7i6H4cFUCGC8ZgG6RZG0mTYb3sHUu7JaD0eHRW+oTeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Moc0+G69Mpe46gDctjlFkwoKMZGz3SpdtVmNecL+I53cHWjeSgFuIlZX/RqeENgSYGE9i5IvyLWdd19cbfhCfRvmmNeAaBi32JcZsGTKOXmJcD4S9FCghyPNT40IaIH54DpA6Ws04AxHYrNltZWxwkyL532uqszmHDcCLWp4fRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HRROt6ZH; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKMeRsKX3FX9DPFKETDweLSZHVUsCngPy7yOADEZkDSwTCFrnwdNQxtfN5mIs/Y8IH5x3N0ZWSWTEttUId2oQ/sFuzp47HyOiqqYe6Ezs2KTVBym7pU084nTSHXn0LWADHdu02GiKPYxQVXUnSX6PmIKWjXqZAA8qPAEgSyZbqsnNd7tBQjGE7UtwvjGDun5jL7ciBSJVkaJE8grTv0joxscj6IEEffDVXi6SWU9ZbQXvu1RMamYqRu0l2h8a6EYAtJ5gQXOPPznBTsoCpInhZqVsXWE5sSoxfv74zXJkzk2rCkvH/MUgGbFOcQ7yJZnXTyl0m5+mI7LSTh9riOP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRzjau2EL1jp7CX/fNPtjwp4Crm5sBiFOOfP8RXCmX0=;
 b=KHCDuy6rtFfrgjgq4Nzm24Odcue49mpKPs3bPYlM17sUtq7+9zzULvi7UJGAsNdsz1LFNhkUKx5D9Uvf3N//PVhkPWOkG8KVZSY2y0G/gmOf3tuE9P4BkY52+PVhx4KjJRf3tYywtEIVg7n3nXAIYTo/FnAlIYY5YWMZSPBwSkwkGd0MfeYqzs8xfM7CArOHTs2Bc0+QQrgC1jQ7iLG7zq3cS0BQYmW2860GyJj7/zsm+C4EGj+yPmVH6XuxB+HKyL2XcViXgL210fZiLi18QIjFaPC7YyitS3bzauHgjOWQf8sCAtA9NfzJBLAXbv9Dj7FFu46wrYaUSNRE0zrXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRzjau2EL1jp7CX/fNPtjwp4Crm5sBiFOOfP8RXCmX0=;
 b=HRROt6ZHmcnloVAvKD5LA7gnDqfbNWrVS/nWsH/W6LTk637Vxg2ID1drs/sssbEWp15iwDu0Hgw+wr3fGqAodJIVcndVxmYNoR8GFEKaaCC6ywRqadRJkiE9FhgwLDvMNAB8+vX9nsPmoClOgHMYOLou7mmatUhQeLtLwmQPsJt1O1GYglECsOhD7B/ACbLtmuE2Og0GTOYPLP1LrnuNm0HR5V04pe6wAf9th68GXwi6RWIgMqB5h1ZiqLzqJ0cn2RXlY6OQbV8Y0Rucp1jcvRUg8JLqp6B97lFyFSWEh+Sc1UJPozx3/zKSozOUc4ELi7YTwyXSmlN1jSVVa0Qyqw==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by PA4PR04MB9711.eurprd04.prod.outlook.com (2603:10a6:102:267::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 20:56:30 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 20:56:29 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Topic: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Index: AQHbgSIyYzp3wPB+I0SIp7LSGpxlULNL+Ehw
Date: Mon, 17 Feb 2025 20:56:29 +0000
Message-ID:
 <AS8PR04MB8849FB282339EB6D5DC2637396FB2@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-2-wei.fang@nxp.com>
In-Reply-To: <20250217093906.506214-2-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|PA4PR04MB9711:EE_
x-ms-office365-filtering-correlation-id: 93e6663c-8b87-4fe1-4e3b-08dd4f958d83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3GAIqjX9DNbkXu+RpbfoZ0M8aEJZQsoaV75ZtgviEOK6fwAXSg0q90wOhjrS?=
 =?us-ascii?Q?5cNJW0kgA+zWinqOfrccF1M/LydNWjD3RxSGFyR6Kpj8PO1g7RC6ZTHhk5WO?=
 =?us-ascii?Q?gOoow9y23w3Mh5qiudXT36EsiJDkuhKE5hTKx2KBrd92jToi3QQ3OuGD/YEz?=
 =?us-ascii?Q?DVALIQWPBlEcVWD5HDXWYcyEDV8gjSOsZVVCYrVKvNuLa9X4dJjr7Ys7ybNz?=
 =?us-ascii?Q?xnpTJy4hvo+SNzUvJjLaTSv9O9dDGPnjRXhesq758zj3gDOXTHj9FhcJog+R?=
 =?us-ascii?Q?ZWQcBayQTu6BCGrsA0B9gHsNhD9b5ezglLW+araWihQCEr1AcpmfjUM2mZZr?=
 =?us-ascii?Q?BP5Jt20vsEYYO9JR4FnlCSfpGTiua99Mv2sCvAuA6f2ncuogGFDo51BZ6S+6?=
 =?us-ascii?Q?NQV7jJEbe+xLMQfkYr6Bl/UXMADrSVFb9tIaJxI8TQgVSXuqqKzdnjK3vQey?=
 =?us-ascii?Q?jVYf/0MceeS3hhU6pyhAtBKFAZUHmyTu4ZB9pzqGyekWYtkX4jmzxXqa47gp?=
 =?us-ascii?Q?pjtDIr6Z6TcRj6x7rpVd1/K60865eCKeCdORT3MWjZoE7127hxW496KU/Fee?=
 =?us-ascii?Q?iSZnKZc0QuqtEVeKBD8RWwTnGKmRoofIFuchtKAUoLVs0KoIoTTTFvtJjXI9?=
 =?us-ascii?Q?9lcwhhaKMIDaicaqxvrqEILM95GvXJxl0VZOybS6Ml4dX4sG9IcR/3ma+jLa?=
 =?us-ascii?Q?2DqIRAiEzbxHPec6o2MN2/47MyMuvks5GSOvhUlerFd+VCiTRc7KmtCzstqt?=
 =?us-ascii?Q?DLZqV7EhZU0uP/rhkgybc8B+FhxzioNnk+JEIJI4RQ8QB6BPHQNbyKHqSY3V?=
 =?us-ascii?Q?zp5z/yIXwnFxWTOl1kJ5oavOOW1vEq3XeLz1nVEnE2LQ6QwXNeh2BNPxnry7?=
 =?us-ascii?Q?DeHd4aiUX//mUrwN8Imer9SQr7/9/9emqpBOo3aiJiryaAHGDOGArvzauh8t?=
 =?us-ascii?Q?zqfe/HKc5pWvGkYxGg+5+GdRJlZ12cIw7t6sRaRMx7OW44feLHB8iql+uNLV?=
 =?us-ascii?Q?SS2sQH9grDNv5R8SHmkvJXC2z+g+7Pdo4AFQ86W7ztloyOBkeoJRdyfAfs/4?=
 =?us-ascii?Q?p0AmLAqv3jOYwiN2IUpPGLvW5i8+TYbYHqVpl0ogkhFb3e7/YtgmEXOn3x7P?=
 =?us-ascii?Q?D2Xo+p8+PyLXUL79oZxh43vucSj7oiLpMvmhqbgxi7HubTHcYpE4fnngdFNh?=
 =?us-ascii?Q?Bc9qFDYfjOvpSliJ9Jdxkd4d1cTx6G/j1onNTHuev1Bq88ZkN+tq9fvdD49p?=
 =?us-ascii?Q?CnxDKa6B+hJdQYec/QXVdP41IYimfKSb66p+Nm97mRxr0Tzyf8ZPFCxtQaS+?=
 =?us-ascii?Q?XWXn1+sp9NL3ni7kibxoqHkRhWH0FVgMXtv8mZdGltREjYYGXpZtDSTt5E/6?=
 =?us-ascii?Q?1+t0pEvFJYrA4HhgtJ1oingMdXy+UCAtFRyW9esHfarDiQEjLYZtJxw6Zrw3?=
 =?us-ascii?Q?VZDaqNWpCWC9UObdZLwIhUtoMiZzFkAV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?keSt1Guedv5izm8gyJ8QWQXwMlNoeiuaffAllCOFehFjrOF30sa1kkv/k+Ss?=
 =?us-ascii?Q?C1c9sWwIFlotypAJKgNjw5e1c7HGyzH3zFWavdefe/jauCj/nlBE93NMPnNK?=
 =?us-ascii?Q?MtZk5U38CipP9nfRt9p2sMbSrMvG/X+cpWu5Eh7PP5d+1GgyAFfH+aNzox6A?=
 =?us-ascii?Q?RmShX/TJMCNutKPxZ152JUD7l66FEaoyMYdOxPPSjLox8JmfTWV43adSEGmG?=
 =?us-ascii?Q?S4cnJfCvgl82/FzCdR7BYW6jB/82Z2XQcX2SruwdLESys4V5skKrJqxOuiyg?=
 =?us-ascii?Q?hALq8oib11CWjlqEBKdrtXZTw6PxtMw5QIt/wpoeDw9BsrmLR7eHts9OCqCn?=
 =?us-ascii?Q?3DW+h2Ml+1C+EVXZS4iBZjZOOvLMTlsh2ahGDI63fWSbWWq48tiM33RFqosM?=
 =?us-ascii?Q?0XU8B7XXM/6k0R90zfHwLTsOWPibMAzSwbAPrdIus4qKxCV9APXyUZVTu2Jz?=
 =?us-ascii?Q?WGN/dfZCTK8asWWrl6F0A3CtdEUufeVB1B14TVN+1KfAc4JTUU+/STKsmP2Y?=
 =?us-ascii?Q?pISUzoosezlTWz9JkrazVprGXCpBZfVa+F0awyzpFbjzul55CoP4b29u4jQU?=
 =?us-ascii?Q?OEwyoRCciRbG2QSjLYUPk+Nq3VWOsZX7gJcfpY0t9Xc/SN/Lc5I97j1Tvy/Q?=
 =?us-ascii?Q?blwfqIKjTZ/Rlr5K/ZpIQzweDSxDrRdO9t86i85S6xSq50NzlcUbd+16PhQv?=
 =?us-ascii?Q?t3DtFwVs7SFXTPNUwJrr9gVEnxxRqt+cPQ3trZhO8h5zou6jWMg+htlWeDHc?=
 =?us-ascii?Q?+SB9Hd8U7RwT+dsw9tmJK01vDLE+Ikwb0m/E0USOvwa0g6DH4nKQIAbHETGF?=
 =?us-ascii?Q?7/dmfxC/7Npxz8E6pKveQPMkcCGOG09ZwD2R+3noLVV3j9TneYVs63ByVKRk?=
 =?us-ascii?Q?LmUETFd8VJNWkrYyB4oxrhZMMrezxytdi9XtEXlmILkL0D9gnB77UzRDr2iO?=
 =?us-ascii?Q?gih2UqDlleRSzFY7ibhNDE2H5dNRX+NN2qA5J+khM6R6IKNLEPn8K5l57q55?=
 =?us-ascii?Q?BjGqCLj2PbEha/l/d4zdJNCGu8nGAoosjj0xM0ms3yN8WxDQUsVtxM1S1MP+?=
 =?us-ascii?Q?aVFJoqsuYk+SR8OPgStLxGPf7RqKT6p4u/8RyTHXa91JNmse2FR5wDPSfc24?=
 =?us-ascii?Q?sIsBOAB8S+3DqE3oqjd+Tp/5dVEEwMDYeH/8U4QiESWMqzpC4a6N6Ah3DwdG?=
 =?us-ascii?Q?ierUAIDflbhM4r2gWcAO++NQV4OaaIQh6Lht2dbhvdhPSCgjNwW0sfXESDMk?=
 =?us-ascii?Q?4E3Olsq1NYadL/YEGc6T9K0fDakPTvuoRChbCP45SUKnC+aO1kYD+L6IPoLN?=
 =?us-ascii?Q?HZSUGnI1Xxn1zU0RH7q4Wt07dsHTz0lI+ajgME/BQuwdyi+VRCp0A+mKxYN7?=
 =?us-ascii?Q?fJPW/a0+i9CQOGEIXOuDiBgY1f9bLO47qm1TCLd0zDoxm8ykCUsnBhZ0DT/C?=
 =?us-ascii?Q?rcHd2AMz/iOXzNxsARadOMw/AawpN/ezvqCsdHQuVLYyQs1OfUnAHSm2WEGZ?=
 =?us-ascii?Q?2lKfiNHRF/MFux7y3F+vggNyXeQ+83lTrPdW65TU1NPvWkcC8eulKS6Cwgp+?=
 =?us-ascii?Q?fbpQiW+aCcv2dx+x/sR4eC5G3ZgO4WRQjmR/tH0i?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e6663c-8b87-4fe1-4e3b-08dd4f958d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 20:56:29.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuWTmvDzBMRzmdPyjPKlEJjeUoqWoUU2OmNt6oJE0O1SX0Rva7MoIPDIZ04nCFEPehWdQz01ct7cmezsH2XDBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9711

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, February 17, 2025 11:39 AM
[...]
> Subject: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
> enetc_map_tx_buffs()
>=20
> When the DMA mapping error occurs, it will attempt to free 'count + 1'

Hi Wei,
Are you sure?

dma_err occurs before count is incremented, at least that's the design.

First step already contradicts your claim:
```
static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *sk=
b)
{
[...]
	int i, count =3D 0;
[...]
	dma =3D dma_map_single(tx_ring->dev, skb->data, len, DMA_TO_DEVICE);
	if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
		goto dma_err;

=3D=3D=3D> count is 0 on goto path!
[...]
	count++;
```

Regards,
Claudiu

