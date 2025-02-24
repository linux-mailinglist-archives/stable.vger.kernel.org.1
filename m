Return-Path: <stable+bounces-119394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5970BA4297D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A301887BDE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25047264606;
	Mon, 24 Feb 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I2g8g2Hj"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129D261370;
	Mon, 24 Feb 2025 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417864; cv=fail; b=exzLdRTuaCMQH3nrFMUW8dyyhIVHbhc5qFChPvRDrRAlLp51WfX+9BZ+AXBryTWgBbiFvWN0sb9w6+DwzLb4gTOs5L/mJj07f7G8sEsHpC0DHTqBWSzr9Dr2EWClY/HJUEabSsBeGqfwD4H4gfoBRM8xsS3EjL11IRiFbkajyII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417864; c=relaxed/simple;
	bh=qD45OOt/Jg7yPzXS5s0cB+mli+xNi3XXECi5yd7QQE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fwFdi3sPjld1JfEoNGfIsCrYhMkNc8jvoEW8qCwih48DMTSw7zvJn6aVbf1w1MID4wrT4Rw/lT0B3eMWtMFcBb/CXlJwWFbQ97ZjSNjoNOumkBSzn8BY1rocS6enS7xGr/ra868XYQSfjzy2kVsFX4+cHjnw7CL+HY+bSykb94k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I2g8g2Hj; arc=fail smtp.client-ip=40.107.241.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4bLy3xUOXRPlktj+rG2RLk8XrggpR6akrmYLruGITPyPNeSKwMHGyI7pj+imxVD9ToOs/o7m57z9+8J6UFzL9XgIdOpYTo1tTE1WKI5iL50+GAzRNr7Ul/9/VA0VWxlJF1XSJwLQFkWdPxMkRqDx//cu1SzsjHxqmcg03YlNe1OKojIh5UUmCVtsZkq9r48rfEGMcAy1XmH0q6bMnZHFDPZV/lExhEutnTT7up0LUM6xH+rZJpc1gBEddlA7c/V7ijPk13+ajE8+HiTo6tokqY48ob++dzqnHHcmKm8rEXKgN0Lu7Uvpo8PdV/ZO2tK9hIA95xKhy8LOatPH7IOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD45OOt/Jg7yPzXS5s0cB+mli+xNi3XXECi5yd7QQE8=;
 b=kKLWDDz8JDzEoLx/vLX2CopWq5teOPMukxj7X6WSvc4gWyCLojD4G+VWGHcnzLb+7L238nnhR8JwaAu3mE+3+bI8DTiezQ4OaBJQJ900zMzA9Y+myMH3xHk+VZHM7+4+61VqOg79g1bympXWz76Pj98tAYE+s5HAj0rozJ8WBY3oKXwlMx3boZ9zdrNjm8yZUT71xB1ypBqDvisVuBQhHpvYsqzx6AK0ny6J7IQDFK/9mM5mFV+haqKNDvogeiCLeWfoJGjvdFQ813z7crLJKAYGx9k/f/VZGmYZfMeBzzHkFk/jCRDRT1Mgmnsbbj49BKpe0lZri2aZJrwExOAMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD45OOt/Jg7yPzXS5s0cB+mli+xNi3XXECi5yd7QQE8=;
 b=I2g8g2Hjz0iicPbaHhgQUUJKejTI71Vzbv7qpyk2y/KHX7e1BEVu7htXM3Cdhyle33nMYyhIQ/+wgboB30kbjopP8rSXruko6Xk8h6uNEjSNdZLE46JnJeux0QA/uUJpffcHHYpu4pMXFKfXN5USBDB1ytKg8A/GrNTkqLodksOY9/m2PQsQSDkAdHaIj3oIFC1j5T81Ravfv3CGv0ostr64ebZI4tD/mPOa+pr3XY9pDYbe/8Dx+CVzV9XX2qAP5rYdJ8Y+tu5DEs6QmgrSU7j8MyIbWqHn0SoZI62kGAvPKMnhpqEJy2m0jLGJ3XYiwN75fVf+c5Bz8RBemfXrRA==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AS8PR04MB9512.eurprd04.prod.outlook.com (2603:10a6:20b:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 17:24:18 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Mon, 24 Feb 2025
 17:24:18 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Topic: [PATCH v3 net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Index: AQHbhq9wx4lMgg5hf0+pOQpl/n0mn7NWtBkA
Date: Mon, 24 Feb 2025 17:24:18 +0000
Message-ID:
 <AS8PR04MB88490516A23201E2696E752B96C02@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
 <20250224111251.1061098-2-wei.fang@nxp.com>
In-Reply-To: <20250224111251.1061098-2-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AS8PR04MB9512:EE_
x-ms-office365-filtering-correlation-id: b1f664a0-a1d1-4aa2-ea8b-08dd54f811b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SWagDCpXffybOfg7l1+w9zEqMqCDI3hT2EkYAgVgtWrIlFrxK9IuO4tqVVN0?=
 =?us-ascii?Q?vMnCugU+DAOqab+YRniB6OyVr5FBrFW7lOTbLBuiHaO8mxDXTznBFHh7mjhz?=
 =?us-ascii?Q?GpofJRxmX36jmSEXpxtsTQ62H7797ZP778bElprvjxx2FjRwapw41JOgjeHb?=
 =?us-ascii?Q?8hOcHqRDOTmnzbNYtEBX1ioV3ayZW7nkYDJ2D5DSB5dlf+GXikxbH9qQhmRA?=
 =?us-ascii?Q?7LaQQfMD8wyjc9kn9/taevbfrkdsxNvTM2B/4tIKoFHVylseTkHyjTRAqYC3?=
 =?us-ascii?Q?fZgHkQU/xmosej4OMAhJcx+WOuzja1mISNvCWCydz6tQVOcD3lgDnVxkJRMG?=
 =?us-ascii?Q?vyRxTpaKxEjvajj/G4rovm2vqI532z+XPRop55+jdMNAG4kOhsfgg4xfDbm5?=
 =?us-ascii?Q?b5Tpd9t7Rrqs8lsf3jDUZxeK3z4POe69cEHxru1lxchyWzfKSSHv9C/rvFXN?=
 =?us-ascii?Q?VpA0S+as+cpcWnzSWNKzudUL1NJdaoa1HJT2W1TKh7MiVmzRq7hQBwYvUb+x?=
 =?us-ascii?Q?boLrEApZyTnjRRwJStT79Qi4ZVQNFIjLwUQIt0uM3RrKbkp398f/pv9xnp4J?=
 =?us-ascii?Q?f+Vaawb5rEpWpirwTQzpTXFm7XMR/6zVFwP9WXzdbIXneX4D3Ql5wbGRcw/J?=
 =?us-ascii?Q?5wfukqMoIgr+B7X7WKoZXiMO6LV0O8ltLLk5FVX+0kDMR4JdqUhoC972n8uU?=
 =?us-ascii?Q?9ATldGHqL44Hb37apJrWJbdWfHVg5N3fuhET1EinG8tFmXQrwU4ym3+FFktS?=
 =?us-ascii?Q?9VPzNAcrPobpqwkgZlCMQpJqqTMxq4njKPHTIbFkwjf3AwOz//ZOogjP8iAR?=
 =?us-ascii?Q?wl4xgTaD6bvh28U2I4HS1nO3RAK4r53JiYsUkHW4zyirG+vjNpcQ22C/ljBL?=
 =?us-ascii?Q?wIXxCJajtfv3ydZwRRjUv/9fxAOprmkf+23n2aMkjVACXMUCXyVHtxtpWYLJ?=
 =?us-ascii?Q?8OIsLcGsFq02SrwmXajfYekGV+nApF9YS/Gq15Z7qPLRrPquDeQnYHdNRKDs?=
 =?us-ascii?Q?OCxKMctEkeqxEd9Ui3anSmRBPVpmtsXEGXVre36E5V/eN6T4pLVkqYZI2dBe?=
 =?us-ascii?Q?Rd+mgTXHK/dre1sw+VWMX0QGiUGp5A+q+FMkjnBbESld8HmBBVU5fUwvV8Qk?=
 =?us-ascii?Q?4AiTQOUJmSl7BbKTdShaZ/Sn+3+CkFCVHbsB5mkz3HtftvT67m36jWNsuefw?=
 =?us-ascii?Q?0XKi97Judqy2EkghMKsWwr/cX77L8fo5YpVBy6ZkQnwF9UpNj8P9/iEpqu43?=
 =?us-ascii?Q?IRzOW7WOb1ZGky7IEbTVSc4ztroB0DuMf9OIpbJ13uk38yF+9byGe2V0214A?=
 =?us-ascii?Q?IVrNxniiNUR5iGw1fEjohBk5z14q5FwwqnFygU759yuWXikusaSWNgtMGhfz?=
 =?us-ascii?Q?q0A86B5ePFJKr48lzRel1f+VnjkxXtMvxH6cJ8iA/hEp75x5kKkyke9AyjRf?=
 =?us-ascii?Q?q/aDHSn4ILMoreaaWk5T5DeS8EpAgXoT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?llonv02E4MfvqxqmQgg3Ss6T+SyZYmNt3sjXpOXeV/KgcPeFKnHhl9yyP6uH?=
 =?us-ascii?Q?mp3KI6WWoQYl9o+vyS/DrSSX0Dj1Vh/FvGBpFWXOXqwoFsADHrgF3n37zEh1?=
 =?us-ascii?Q?u4xLxuNaxJcgNSogphBJCGGdaH62nOzI0dzQ8N9egGMrNjZ9h3AVWELfba79?=
 =?us-ascii?Q?ENJYv2cIxsSbx1odSfZtFiWbvu6plXNyMIxDX6zu9dixz32lJOz4/IsXenHC?=
 =?us-ascii?Q?MuPwQ8j2Eh1MiCzMH0rHY/Q4UC14vK1JnkHiEgHIbDULYXchjdgSXBshz71J?=
 =?us-ascii?Q?aydcVZrSxhNnMmtxBW2CoPB0JaoffCbT17qkYt62GVdTcPkpmfUs6b3lmfyD?=
 =?us-ascii?Q?biRizvdMfX5c4pp5gwXoPtDX59w4cegdikT+PmnycvzGkyrGflw64NGypWoW?=
 =?us-ascii?Q?BbJGZlyfRFxR1rgYGf+5IY1fUKpTd0Q5l/YmnAFEISkS9Rrwk//dBUbfbfSN?=
 =?us-ascii?Q?qKWFtshtzTzuoMddQAanq8/AA1g6Lf8wheP+etJGtAGLk5Y0u0YV1EgP/T3z?=
 =?us-ascii?Q?Sk4ih6KWoCH5sTwx+83dveyehP1BcTB7ANrlvHBFeJ0LJzGF+35AxeVVXbSD?=
 =?us-ascii?Q?hFQ+VESpGk1yRiIvNwGpooY9F8zGsnssZjyzCdP1ONtOSElnwTpxy4ToYn+J?=
 =?us-ascii?Q?pPmu3u9nBBOY0BxxhZQ8nB9rJHjsgnLu5Zd142WIEL8ZrbY4FQe4+NfxyJz8?=
 =?us-ascii?Q?1zWQ4EKAhiPSWOAl1KFf9pn/obqk7V4ngqxPm3RSA+tUZUCawfNQ3NPQq3aE?=
 =?us-ascii?Q?0MsnoxZ5q6qWQNkJrhapiObQ36EGpx112WYSM3iyQLMBSe+24686tWsUsvnn?=
 =?us-ascii?Q?sUFYBCB0sV0OzarT8ahNJJUvsDNxfVknTA8+WmYTXmBozYxZxT05jNAj6IYL?=
 =?us-ascii?Q?Eq9ROVob1u3pt/scT/vrHCogbjyiJJCINApjOjhpbf3hqFpvt2ictEFKY+zr?=
 =?us-ascii?Q?w0GGgymfkr1i8RHcjSDnKywGb827KIRVLSNrNDEko9ssiqt3/Y80n3yr6cU7?=
 =?us-ascii?Q?omIub4GobS48gQ2CJrXZA1hTQwrjO12030TCRicam1IwYxw5ju93mY3ZJuf4?=
 =?us-ascii?Q?+Tlf4mwBpYNtZORpkUUeHWaWzIlsFc9us1w1DddRnxJ1IdzaULxn4foJ9Cdy?=
 =?us-ascii?Q?8IFbv5ThX0oSjIRqvcf6r74Iqb/w4SwtRJNdPQC9bMuUxuh0Yb8zX3PyPl66?=
 =?us-ascii?Q?5gOsPvuTY94QBP80Dmv6t2KBqXUHWjVckbiJ5T9EgDIHz4f3w9yFd6rvUzqz?=
 =?us-ascii?Q?4szQi1gNDBQ+LZu28j4zRHzHAoyaZnc4xn04t7Xd61SqcwItE+BAGDjKdTta?=
 =?us-ascii?Q?kgmb9z3HJHd60zkHCa7AnZymdQySHpy1mhCxFZMEESAYm8tLSig8M8Im+hVU?=
 =?us-ascii?Q?4Y5BtnMU7HEctNlML4Uvqj3cZVBPeLGa2cFgWJ2NgyIey+1NXaHJGXooMXXs?=
 =?us-ascii?Q?muQ4lMX2D5BpmN5SFhO4N5Y0by8YdDNv5hurvdVhcTLkMW6v9CEok6KXyjxC?=
 =?us-ascii?Q?c53DTwkTie+h55qp5tvh4bp6MF+lZYaMRGp9s4jmR4zwVxO859dyIVWW/KnU?=
 =?us-ascii?Q?Mzy9iQE8bvCoHpc8Tl5mR6VnUyIFfyz6I0DgUfAI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f664a0-a1d1-4aa2-ea8b-08dd54f811b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 17:24:18.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvFL1zzr5G1mya95oXBwgau6hBxl8gBDXYgKJTo4oFEHhWq85qXw99g6mRepVFrh+3H8RF4r2K9hq0zPiz2wpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9512

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, February 24, 2025 1:13 PM
[...]
> Subject: [PATCH v3 net 1/8] net: enetc: fix the off-by-one issue in
> enetc_map_tx_buffs()
>=20
> When a DMA mapping error occurs while processing skb frags, it will free
> one more tx_swbd than expected, so fix this off-by-one issue.
>=20
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet
> drivers")
> Cc: stable@vger.kernel.org
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

