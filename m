Return-Path: <stable+bounces-116639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9DDA390C0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 03:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48346172905
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 02:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0B1487F6;
	Tue, 18 Feb 2025 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kNfIfPfS"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D6482EB;
	Tue, 18 Feb 2025 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844705; cv=fail; b=iUpQ8Zvhz3cLPjSHSlZ1+14r7VriPin+X9v0Mviv6TvYkLhAvt4AqkrYbbHhIztXnTHJ3Oho+h2SoP9Hq+mHi1okJgfCQJ5LikziYAPzFO70GGhxrA0DWROjX9OrDOjrocd1wn6sp88LcxqUE3KvhNk30L6NRM221o5lmOsJaJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844705; c=relaxed/simple;
	bh=rWMtbX5J1TDjDrIB9vFIxMQmqu6MdJcw9ogIeE6Wv+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUT6gWXWur6vE3YiFXbL9ILx9LowrEcpHjHOLLvzKgd+naui0au/VlLe9LlQMtakK/RBk/fFsifnI1ond6W0xo6h8TzOC9QyWOmeSVnedIOHiiwwGAsM8QJ0HSSC/Aoy8E98BBgZDYf3Ff07LPGJYG9wYuodvdXE1WZwK8KtL5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kNfIfPfS; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNtcjW0GN55KfHJdtvROqblRnX7IriOoOq1zQQDGWhz9LRIQzUHqTKhkPQ6CiO9rv/11u1EGjjh3vPe+mt2m+WTgkGO7uFkdZmgVqv9GUVI4Z91EDTJ1gejV0yxR88wWbsY/PLsdWdEhehBZvL3nEHm/8gAewIMpc1wIotE+MxxcpjlESvF+xm1aGJN2gNbBIrebkTm3M78NfZTupczKAGHRrQfacQXXO4bXIuQTf30vrHADCIxSKPF4aUpwgwKCR8b5Sp5TXSz6i5b2n+CU+QHOYsJNJ//GHztnIARbZj1C3imR64vDGSH4isYm688JjTV9PYwW0lCiRvt9+h1H8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TySJbB4cKm4my6hPh7xuoxZkhqJjrRNrsi2ByyLjUC8=;
 b=chrT2Y0jNjxgwqJECiIYnAWK9w2Dt7GvM5YtgabeENciP8+Y1jUziFUVai97j6LXgVHEUZ8ICgeF8c6wjggeIgQ9SaQB7xi38Ad963jp4CnVaWAIaaqAGM6XAbBnuuR5Z7xIYq6ZgnulvHctYv77PD8qZkVC4n0k4M1yD1O3uOM4EJ5t4LxhIOEblsFr6JIFS9RPeOsTNR3c863lWjwXqoBByJZrgjtLVR4eEwU5LoKo9wQZdW5MF+PR/R/dgcJHIJHIIKUowlzCu7zwmYHz6zN7IiXQbTHak5tfjanjJ4Yt4P77m355nbB48KVFH2bnwLYHt+g04d9HujHPMeT1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TySJbB4cKm4my6hPh7xuoxZkhqJjrRNrsi2ByyLjUC8=;
 b=kNfIfPfS0j0Oo9LyyYc5whSPpIDN4oXoOEAdLJQ6Q7slIjmvCQ9pDV4OfYOy/1x4kGOkbXr0UigYnNb1/bGLoDofXrOdbBlYbOWR6zevQYSd/M1eCitMbqdKAb6WwJ5vgJR+cP4gYLoUwQN7Bj2luSZzTqd/3xfeqsHzkZD6uYonEUUIq1XYx9W008zyw11j9wCjCj+olC44r9rPwwu8Bz49A9yvLi+SSHqu1R4dla85QNZCUQ6Nb+M4E+u/3Hxdsi9mz2NU/I3cKB6Al/IAm6yqt2LGytf0iJDOxjW1Sc7mnU229cbs689PMOIj7T+VD0YA79Gu7PGqAAj0aqn3FQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10495.eurprd04.prod.outlook.com (2603:10a6:800:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 02:11:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Tue, 18 Feb 2025
 02:11:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Topic: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Index: AQHbgSIxXCrhXQUTvUaf5YMAXyCn+7NLu12AgACXMOA=
Date: Tue, 18 Feb 2025 02:11:40 +0000
Message-ID:
 <PAXPR04MB85100A93AD7B2D3CB69BE7C788FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
	<20250217093906.506214-2-wei.fang@nxp.com>
 <20250217091017.3779eaf5@kernel.org>
In-Reply-To: <20250217091017.3779eaf5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10495:EE_
x-ms-office365-filtering-correlation-id: 65eab027-1156-4d3a-d606-08dd4fc1952d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UiERpR27WkoA7rD3CJKhzI1osJEpTlfTiFTsQvMW3sm+ZM3Lq0a98OtzjIR2?=
 =?us-ascii?Q?9Y6ECJ6Fq5XdSWuFth+Z0GGNwl2SKkS9jMNBOdrHN1ziCMh0oKkshQvgWmnb?=
 =?us-ascii?Q?LOPofYtxnl2GQG5QP5mHNYHIerQBvbe9JDfpDaTt2xu9gExnFkUxSJPhbxKS?=
 =?us-ascii?Q?H7u5BA1FtttcE1QNcdIjCHWDg+mhNe7Fo78VCqg7XLMVMZWzmXXDnqorYTwR?=
 =?us-ascii?Q?NA9EsmLOrd2dWf6v51Eeh859JjCJ3qPqxAD9lW+alnI2+8XAsctx59ahRnKh?=
 =?us-ascii?Q?RK1x9vFUWs68wbT4I/COeQOOhprX9IixpGZJTBQ0h+jNqNsa5hqAo8Xt6TMm?=
 =?us-ascii?Q?NmUTuFAyJTVMuXk9iYFWMu6zE22DPFdstHs52Mn3iFiBM03FdEl/90hSl27A?=
 =?us-ascii?Q?5jx8t+qHhsp5W4dLX2WJXrys2P9Uu1Jp7/iQxO3KTIjD65a16EULa8cFRDzf?=
 =?us-ascii?Q?SldBTvmlj2qAcxHnXFXXeEwGYwxtIOZ7xFkt/CIqZUD4nk1XAOSdACPF7ZGC?=
 =?us-ascii?Q?4uXkpuTjhKF9XAR9eKUlLj3o7Xex9y7RkXDzAO2tePzF3D+fgQRmfF/Fknjl?=
 =?us-ascii?Q?bRdUNU4n2V6+7WMhEVmpnz7Nn00lMVJpdsB4G/8kZ0RZT9LQCNtuUc+wxtDM?=
 =?us-ascii?Q?1lLvTm1OS6HJGdVLnyMq0KJi+vJfeo32QziZc3jzllkdIfxUMTyFJ2uR44Li?=
 =?us-ascii?Q?y0YwAgERXJpa6s3HquwN0AJvVG6BxEASMNtfdcmkPae/3xMGauQ5xuox2UoS?=
 =?us-ascii?Q?//wqVEwaB8ROPSSEVduGySm9NjPtH5jX04EcATlDU7isGcoNGTxoQ27Ec7Q+?=
 =?us-ascii?Q?81z70Q8RR5tqN02jQYjUOIKkD9Jb8tJxZ7Uq85p5HJUIWnaGTN/kOI6XvZ0a?=
 =?us-ascii?Q?JEsfjyRbthY7OKoAQwwyal2rKI4yrTL+F/+L7AUreVHYEBq+46GAaF4xAite?=
 =?us-ascii?Q?siIaB8p42WEZu2DsGhvEgv3hVExwr3g9CQ5RatVwwCGQEs2gXmivdPat3osp?=
 =?us-ascii?Q?PtSO8EPF1zmNqZBDT8pYvi8Qu17lcLxwOSz7Sngn6syhE8EA5oTjOCIcd1Te?=
 =?us-ascii?Q?HSrkCNBiFrhacLUY4TeC5YyJZvalJPM73U9ZcHXd+3h8nLwaUFK3+Z3nXiRI?=
 =?us-ascii?Q?MIsiZIoc6fpLKdb6XmlEhrilP8xwS91HMGb5lL99bgCNZB9ENeWzRmWOEkN5?=
 =?us-ascii?Q?nZrycUQaLpxhhIs4gfn7lNEZM5+H0tFmZ7MneIhF0v0vgbitd9oYPbyiJtWK?=
 =?us-ascii?Q?2oYTRWBkQ4ripXa2CkqI/ZWuOGS+byr4wHVBQuNcPFSvxBB3eXYf8EO4NaBY?=
 =?us-ascii?Q?jg/yiTul7SeARgSPQU3rEh1Qag53xQhlYyZbk60ObNfuZ5Ujxj+N0ohZWeSl?=
 =?us-ascii?Q?k7hzrg6WF+yVM1BboRuI1a+r4Jia1vr0wVi9Mnf4g1FiJyWQBweL8gM5b7lN?=
 =?us-ascii?Q?vrqXP61Ru8bxAMLPDSkp9G6a9EiFzryZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HdDe6Ei2N4FD/s9H19DeA+rOcbzsFAAFLNeLI/yfqkPQIShjhCGKRJJnlmOJ?=
 =?us-ascii?Q?QnNQbjtxpbuc3LZI32278JDS4JgRI6wK2Z1ur95bQ+pbwTCAc7zbV2Jy+a+v?=
 =?us-ascii?Q?BprEObmn8Ub2dD4JTgTkGn1R2ijCZOEEOlhy7MEU7W8Pqbc4S3S6qIyXVVhf?=
 =?us-ascii?Q?r+ExZSI6RTH3AvYCHQ+bf8MNpIFJRg9WESxoCJbXnHPegoMUECbDADg6Ai/6?=
 =?us-ascii?Q?XPOvbaRRbKworv7uI+d4YUp86lejt0oMgskyWIKU8aLCrXJer3da9leWzSRv?=
 =?us-ascii?Q?FhZMkH8lH5nT4C/Bz0KiDmXvrkQau7RbFaXj7WuBlmTsdNVtZBUxdDR6u0AS?=
 =?us-ascii?Q?RZwzrS9sr27MIDqkdwP14XvOzr6W9hhdCn9Vv71V51IJQ0FU6xiP9ZMyR722?=
 =?us-ascii?Q?AqyjhguAAyR0MGnOO8S68W/LfczToQkY19x/6ZlEnKnUBUc3gJt6hrw39Cjb?=
 =?us-ascii?Q?fC70+L6ik2hl6Yfoc5d6IOAPJfnweimwwDR+alf8+/sNwNuYim2IH6JaxHnR?=
 =?us-ascii?Q?r60BivgIvpQBRy8TidfDdlz744Lz++u84N1YDUCpnwdoyg8O75LqYe352eud?=
 =?us-ascii?Q?9Hm1a4gFJ2RF1ADA6Y3uFS8ifr/NGi+mz1K2HbGf7UHxkz0c/zVeVCrUpdqb?=
 =?us-ascii?Q?Cc+H2P0+Y8m8hiSicNEgp1qrVDLJFRL46xW2QFklZniahQ4jdi/Y+oZa5DKE?=
 =?us-ascii?Q?2Fo6DBmgXqQb1vDtrrIlQ9ioR6IRkwjW6dQc4Eq+whIzMkz621qw2+Z+oT06?=
 =?us-ascii?Q?ZPXzyRYLDbwk7/qyrZfklq/GT30M259kVW+JQcCWzxI5K+gUxmCks2HWuHb+?=
 =?us-ascii?Q?yyTxcNfvbm/TOPQacXoXYX6/TV1VUpyQ7lqjNOMSfq2gjZtKXPtCa5jIqyVo?=
 =?us-ascii?Q?8agG2lzkfFwDMX4qfnV3M5jYG/Gi/1t4t8cRuUbDql0ZrXIUHhRp3nANG1zq?=
 =?us-ascii?Q?hj8tV2XNGIwvP9atIt3N3goQB9VyOgIX6cPQ9PjymOTtATtdyoA5/6yMK5LM?=
 =?us-ascii?Q?Iu0L0UbRtceGER8fpPmj0oGIKq71QTcmr2cZ/cwjp2Urd7tf5kMJDFP7yZ/O?=
 =?us-ascii?Q?pGBWyplNSwRDGleCE3iGWq/KTR++PSP4ZFaParGlS/5KUardTMVYNNAGKv14?=
 =?us-ascii?Q?P9l3AfhulOjqFMck0L5ku9zcQZ0Vas7l2jNw6DsIHH6QYCsWhzLM3+SoM04r?=
 =?us-ascii?Q?0AGeqlgj/OOBHm0YKhpIHQENfXO4V0xruy/Ak6dGf7Hb1puXQQOtJOV28R1z?=
 =?us-ascii?Q?0W5TjpgYfVA1MGWeWk9cVwef70o/0ph8UiFLNRzs43WTGWf9Wla0HHwCm30D?=
 =?us-ascii?Q?Pzgla7tIuxfOfTQC8hHTOlqX5unAALriYTU8iFL8b/hdGJcQQ33fheVXtCYF?=
 =?us-ascii?Q?ocbGFUSo6pe82CRfp7oCC7nv/ZpM/aI6hVoQ/lF07CyGzy8BCSIPOlIea8eK?=
 =?us-ascii?Q?teTFy6HNs4xqf+v0R8C3bBHyrs5B8kq7x10yMoI0RQ/+A1ATB7Nj+xajQ/i+?=
 =?us-ascii?Q?8fOauQKul4re5GmXgQi2sDrjhoB9MYsbNu4Iz4GNMRFwHkSX9CCh1rN7wfPv?=
 =?us-ascii?Q?s0OwCFq6/HedKx5Ico4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65eab027-1156-4d3a-d606-08dd4fc1952d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 02:11:40.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pAUt7d1UizDDenzmi9jP1dyYuTpYhb0LU/sbKGoFijTrVo358n21GwzjBRlKIBoM0baA7I1Jr9kPJ1q3HcMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10495

> On Mon, 17 Feb 2025 17:38:59 +0800 Wei Fang wrote:
> > +	while (count--) {
> >  		tx_swbd =3D &tx_ring->tx_swbd[i];
> >  		enetc_free_tx_frame(tx_ring, tx_swbd);
> >  		if (i =3D=3D 0)
> >  			i =3D tx_ring->bd_count;
> >  		i--;
> > -	} while (count--);
> > +	};
>=20
> I think this gives us:
>=20
> drivers/net/ethernet/freescale/enetc/enetc.c:408:2-3: Unneeded semicolon

Thanks, will fix it.

> --
> pw-bot: cr

