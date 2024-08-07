Return-Path: <stable+bounces-65587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6755094AA9A
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E03B2968D
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30D680611;
	Wed,  7 Aug 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b="j2kgccle"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0137D3F5;
	Wed,  7 Aug 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041782; cv=fail; b=GkIaQT5XFrceAVHxCT0bLWeL8hfZZkiEcvmrIaWZbjMc1ysLKGhnyC2EG6eSF0960oHhsfmAIJSsgxz4JAU/dtbt0QN8pH4zCc/XBD0ElK/TUwnNQnqkqULOHXgp1ZC6E19QTnVMugmdVBeT9zSUe/0c1VSdtVj/7i4EDe8Jkjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041782; c=relaxed/simple;
	bh=XZxZ0SCocAQN6/jyDhxbLsQd/vlDBQxR9AuP1ZS0JSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XF0jvDSfCHMlS1q6oaeuzi7+Y9fdH7896HPeKBG4Oq9g43Af1P2RaQEq8JKp6u6/GMeG2YCe7aIddQfCATAXJBkh24Om/AzeIa9RZVGasPjbsAK3Qfu31CoF7pZGa9itH5LB/shR65t5AUzwdf0ES9QBmbCyxvRo7kVEkFUsv2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com; spf=pass smtp.mailfrom=cloudbasesolutions.com; dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b=j2kgccle; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudbasesolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHo+QDKpjIYPdEMPbcHhJdOur10TMXayf29jh32RygQ0bcDMxUHMmRwo8rmy/YgerNSVyVXpCdpie3fE96Ueu7cLMafdj6SdjtcQZm9q85sHhc/Kc/2MRfqX7nGyaOkKYpVI1YBIN86KBXIhFFYcpzqkR+JhRusUyRA1am51o6RQ2Xvd/rnU6ZITMvl/0CHXgqINwAomsLGp3b+Qe5YRiigT55t/K0iE+et9z59oaJKdg2trjLmDTtp9LVCI5jIEjZo5h/1ClYYlbMr5mGzvgdZOeclZXzimOZpjbrSnHAejPPbnhxdqQblamDB2tK+rhGLfIgbr1ySUbVx+1hdQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg/sEUM0wdFW0aJTO3nKKBXnxwiy1HvovdgyjpmE9os=;
 b=OunCaoSF7G7lCMl7ZYTtnKHImj+pLRRHLfFkEI/m+ZcZTfDpPDN6BI+8nTioCfvgcbt7PVh46hLg8M8F5R1UwcBge/s9DfV9Lq+Deut1VgZrcer1RtgRPDZw1cLjsJJ5CgrtYU2Gi7Z8IbwPRWqxp8VLqsrQ9w2Zk1GfNcsZfIDTz96cQJBgR6GDHuX4cVoK714mB5eY/QHPnrJvgPiqk3z9qdpFHbLX7KjmkGMaGFZDVGu+vZkN0l8N3nIge+BBHx48pxrA02VyB1TWPqeDPASAmGjCAB6YXVi1Es63DcUooQpACqhksi1ge+VgbXQlj7pPywfXPzo9m17HI6MQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cloudbasesolutions.com; dmarc=pass action=none
 header.from=cloudbasesolutions.com; dkim=pass
 header.d=cloudbasesolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudbasesolutions.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg/sEUM0wdFW0aJTO3nKKBXnxwiy1HvovdgyjpmE9os=;
 b=j2kgccleubObYk+tiN4tg6IUX0EK/MdOgP4g64boERi1++AxIxSH/lkvqTNwe1LuevsCifIpH7dQnyLEbru35hJPejgCvazw5lzUy7PZYd+O6un8GAS2Bj/ZLMh4TiY53Qk7SBv+GjxuiUCCEaVJkQSWYhGDCkoYXRySXdnwDKo=
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com (2603:10a6:102:17e::10)
 by AM0PR09MB4403.eurprd09.prod.outlook.com (2603:10a6:20b:168::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 14:42:56 +0000
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc]) by PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 14:42:56 +0000
From: Adrian Vladu <avladu@cloudbasesolutions.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "arefev@swemel.ru"
	<arefev@swemel.ru>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "willemb@google.com" <willemb@google.com>, Mathieu
 Tortuyaux <mtortuyaux@microsoft.com>, Alessandro Pilotti
	<apilotti@cloudbasesolutions.com>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Thread-Topic: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Thread-Index: AQHa535pYp3Bo+hqVUSg9rCQdbX3j7Ib2KaAgAAAvK8=
Date: Wed, 7 Aug 2024 14:42:56 +0000
Message-ID:
 <PR3PR09MB5411D195381EA9DCA088DD6EB0B82@PR3PR09MB5411.eurprd09.prod.outlook.com>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
In-Reply-To: <2024080703-unafraid-chastise-acf0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cloudbasesolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR09MB5411:EE_|AM0PR09MB4403:EE_
x-ms-office365-filtering-correlation-id: a2fbb908-3e03-40e2-fde9-08dcb6ef39aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ICzCTj1iuq/K+muVSt9UkmeworMt7KNeeqeeZhBZM2siedbTtyEk16+ZNk?=
 =?iso-8859-1?Q?xIChIGBWQi+2z+nsE/MgrxOuAIcVCL+VWHtT137wQN/4hMCHZpk+OQ5yrL?=
 =?iso-8859-1?Q?xBYHymdDrd8iOEEZIBNo1uoDMJjoDvCLnO6gnBCuZBtd1Gjw1yA91RI76u?=
 =?iso-8859-1?Q?YGlP2O72zE5qBYQr9Lcj7t4DJ/zG93I9gHCH6yZduhT1J+tXVVs8bDPkdW?=
 =?iso-8859-1?Q?krWkV33fRlHAwiIY9oIdEgQ78bhq/4D3I3l4pSMv7lqIZV3wSLoM2xEPbT?=
 =?iso-8859-1?Q?MV+5Z+iGeg5zi4h3OeG5+5ITJ2i55rrHtF96kLPcoDUdRMTCeJVr5LGW9v?=
 =?iso-8859-1?Q?aFxeV6OOQLruDeG5HGkmalnqL8Xn2yU1frwnA39qUE8lGaBddFQcaVrV2d?=
 =?iso-8859-1?Q?o7AANrx5S74yYWU5fjCHs647mFPfIwSlPAyP/2eFvpoiBbMbLfQ5e0ue/b?=
 =?iso-8859-1?Q?okg1ZUaJuUSD1ZykrX9huBosjNUx4S5vFTGAS2eLYypZIdbvRoyPgd4yGS?=
 =?iso-8859-1?Q?Jh6ZIP/QydyXLSxAJr5fl3r2pn1IIyUxzco0Ywc9CqTcqDabgVa8RH8mxZ?=
 =?iso-8859-1?Q?KOZAlueH69FF8q8+PVT6EnxvctPFiloNTdxQ/23UJK4a5dobXRGgdZhJEq?=
 =?iso-8859-1?Q?wDxSi782aZMJ0WDoXkFZN3txxsjAq7JSY5n4N6x9EKWKvxRYUX6QHKwpYt?=
 =?iso-8859-1?Q?m8R9S0kvUvvO2LuuLLiO4SVkSKGRGdtSsisVYRL0pnm3TxsdOvHrj5z7/V?=
 =?iso-8859-1?Q?C1daeqccq5PKSWhQylXX1M3u7R2oZFupKtonQr3goi1YDc7ZA/fyuaSrP/?=
 =?iso-8859-1?Q?7S6XVsPtOYrKUmtqh/oqcRb0wm1DTKVQhgE3H9SQdPOVEUpLgf0nibH8AV?=
 =?iso-8859-1?Q?DGsxAWYrkhgZyAnBeLh1jnq/jzfEL09sopKlNEGXEZZbjjcey+EJKVgVUM?=
 =?iso-8859-1?Q?AYkMVLZDBjwRVLDgzm4cr8S/pWqh46HzgQTFuJNccICwz290xBbfQVzXVE?=
 =?iso-8859-1?Q?UEmcaiaFGKSjcMaZalesIE+bWI8SzFCtA+wpjuaWNdEppxJW0/vyFa1ZT6?=
 =?iso-8859-1?Q?Pjd5J+TtzsWdHhwzCCXV+ABsj/fhDuHv+7755bJPRqZ8kmhNIGAKZqWZHj?=
 =?iso-8859-1?Q?Luz69vVWQUzRRr0CvRxqf5HGjF4I8EnpxxaQSEER8LlwfOWQEPdU7b3Eze?=
 =?iso-8859-1?Q?sWmJ4tOpruYimYGaYyc+lRQP8QQpznhDQFxu3y063Tqq8W6EjUkf5jqp3O?=
 =?iso-8859-1?Q?hsHbpmSyaxskablAG2orLUc6KzXIh6b7zms/EQgLa4JjGNmVqPGo+HoAB6?=
 =?iso-8859-1?Q?mrjQBKyYbcMRhG8mZkeM2tZMVyAmO7/TBtfPcQUR72De/3Mpx/bASVmNLh?=
 =?iso-8859-1?Q?slIgEqQv2Wj/mJ+KMuM31+m5E2TxdqfQ1PL4GRy1aSNPsy821DJEM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR09MB5411.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?C4V6662HjikkltgsD1IgugKEi7tw0cvDya40dyWMhWIfZjHUog+2/TYAgI?=
 =?iso-8859-1?Q?i32tvIYgcnm62t71kQG5rHZvHjgxlvHg0zFmBPZHs7mOPhUG+zVfh9zI+j?=
 =?iso-8859-1?Q?bBjsMPFSldVZvM0ayOTcbdwRy08T2Nu21Ck55iwqZfYeHNM14Pq4uR7kfg?=
 =?iso-8859-1?Q?o7HQiKgA+yx/Nhp6BAOxaNsFC8oSWWRd8lOGVAYY37uQzDnTarRcQTW0JF?=
 =?iso-8859-1?Q?vB1PFA2Usc7HppDWmkRot0k5ZKSj3rKB6wk3zVxXq+LbsIY7SGNjnfapBu?=
 =?iso-8859-1?Q?C9QHbK+6uwd0BC23XbiCHEyiOjKLLvpCorR/f0UJkr9AcN0ImrtRxmpUo1?=
 =?iso-8859-1?Q?KQZp9c1KrUusZSmCWXCJEwmn1uRwboNMx7F7/wxlb9kcgRuFJSYd64YGyF?=
 =?iso-8859-1?Q?3eQVShaWPtIe5hzhwLzTAf7cDg7DIQz1+exwfLqTb3hxrnMkdGvQe97+2U?=
 =?iso-8859-1?Q?ilf9PLyU7kkYclO9zrE/XTjonSsq368R0p5a78J3WCBNgasdA3jbu+mcv3?=
 =?iso-8859-1?Q?XH3Z3fA+cngelObrL/PrFB3E++jTMSQz8Lgo+w5ja3X6loN4QKvcfxLu41?=
 =?iso-8859-1?Q?AByIvR4HDciZcV+E7JaNFD/FtSUR9SWot34agMddR4NPO1/vhRHy2IqLhn?=
 =?iso-8859-1?Q?b2ULvJipQ/R7lMUvqjl0aIQBeL78A2pO7ip1bWpCzgDP4DuVh75Pw59nyv?=
 =?iso-8859-1?Q?J32BoIgrxkreu7l90GePHB9iQ6pXoV4ObDUp8Nra2dz8GCIXQboaR1Yjyo?=
 =?iso-8859-1?Q?/8JkVCz6dHyUMGhSZdA4LpTYEMu2HYE7JIWGrCjqCDHqGByZ/gQEKmlhgU?=
 =?iso-8859-1?Q?ZDZNRJfJRNrGDgyG7sqJ5COd407YgGRCSLp7tP56l58036+lEt6kbQMo/F?=
 =?iso-8859-1?Q?sUi1kYe1Ou2RVvgiJBwFhqVMFg9yVx5yq7KbOKRtMZvGvtydgEY3LIjbNY?=
 =?iso-8859-1?Q?3YgNg8FnY6Va/BX02zf6OuYJA/gDG8KlImSpRwbm0jmQNItlCJtrBEYDom?=
 =?iso-8859-1?Q?HlNP8SAzOLhELCwdpMmCuGfkcp5KJBuYb65RWWziq8uIXJMXKkFmTvqwz+?=
 =?iso-8859-1?Q?PkFErRmNa0ua7nmBQFEV/ITTSldCdEWOCXTNcVIhQu/ZBIWwfiwSovDQTH?=
 =?iso-8859-1?Q?VER0yvSDtNaKJ/VAuhR/Jfvq8VSMNzWzgG6Mca5X67Lrz/RTs9R43NOmGH?=
 =?iso-8859-1?Q?yHbJ9X39VY8sOu1cLdErAnvBnphdKqofLZofUKeUI1ZEJsdmOcFpFfoCfv?=
 =?iso-8859-1?Q?vs78c+42AG754qvzV2gq8foxekaM0bRjwY3SKNrYMnaq11ySuj19ZdS8F/?=
 =?iso-8859-1?Q?HnWHI6bicogqPGg9wjWXZrhPEE8MRozJygMt4CVj6Hm2vFVMpCaIHXUHfw?=
 =?iso-8859-1?Q?ausMtk7nDIAWaGSPrv8Xj42fKEZk0litWiCrP8sjF+hobnPN0R69XhjW2u?=
 =?iso-8859-1?Q?1h6TiAWNHeQdyyoizH4JCYO3sC3HDrrhw+6r9rDnOhMC9Ch2PAuJODgxGO?=
 =?iso-8859-1?Q?4q96DPc6HbPOEuZ0u4351qvWEOKsMTuyj5V0nq2d/wwevPVLM3VKCNKbKn?=
 =?iso-8859-1?Q?ng0kQfz6/WQLVJSmZWOhyqxMetWKCXClxb7quIiggVmy50GbnHr/TaXoJ4?=
 =?iso-8859-1?Q?Mzad7rX2Z1A04ZcVvWEl0/vN9FsPb8+IpQ/aY1Ds+q2SfOA4kBmB1DHg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cloudbasesolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR09MB5411.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fbb908-3e03-40e2-fde9-08dcb6ef39aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 14:42:56.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c94c12d7-c30b-4479-8f5a-417318237407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVb/PnqFKb3ipOO8lTioLp7OnyPANh4CnY8ogPEVNi5wtWkOgx3fcpPisA/iovzPSmPRRFLzdA25qJ+AWvYB0ip9+JOcjRXia7/R+jTTG7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4403

Hello,=0A=
=0A=
My colleague Mathieu already submitted the tested patch here https://lore.k=
ernel.org/stable/20240806122236.60183-1-mathieu.tortuyaux@gmail.com/T/#u.=
=0A=
=0A=
Links to Flatcar patch and test run:=0A=
=0A=
  * https://github.com/flatcar/scripts/pull/2194/commits/33259937abe19f612f=
aac255706d5a509666fbc9=0A=
  * https://github.com/flatcar/scripts/actions/runs/10251425081=0A=
=0A=
But this patch has been tested and submitted only for the 6.6.y branch.=0A=
=0A=
It will take some time to properly test the 6.1.y, as Flatcar is going to b=
e fully upgraded on all channels to 6.6.y, but I will come back with the pa=
tch and test results.=0A=
=0A=
Thanks, Adrian.=0A=
=0A=
________________________________________=0A=
From:=A0Greg KH <gregkh@linuxfoundation.org>=0A=
Sent:=A0Wednesday, August 7, 2024 5:12 PM=0A=
To:=A0Adrian Vladu <avladu@cloudbasesolutions.com>=0A=
Cc:=A0willemdebruijn.kernel@gmail.com <willemdebruijn.kernel@gmail.com>; al=
exander.duyck@gmail.com <alexander.duyck@gmail.com>; arefev@swemel.ru <aref=
ev@swemel.ru>; davem@davemloft.net <davem@davemloft.net>; edumazet@google.c=
om <edumazet@google.com>; jasowang@redhat.com <jasowang@redhat.com>; kuba@k=
ernel.org <kuba@kernel.org>; mst@redhat.com <mst@redhat.com>; netdev@vger.k=
ernel.org <netdev@vger.kernel.org>; pabeni@redhat.com <pabeni@redhat.com>; =
stable@vger.kernel.org <stable@vger.kernel.org>; willemb@google.com <willem=
b@google.com>=0A=
Subject:=A0Re: [PATCH net] net: drop bad gso csum_start and offset in virti=
o_net_hdr=0A=
=A0=0A=
On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolutions.com wro=
te:=0A=
> Hello,=0A=
>=0A=
> This patch needs to be backported to the stable 6.1.x and 6.64.x branches=
, as the initial patch https://github.com/torvalds/linux/commit/e269d79c7d3=
5aa3808b1f3c1737d63dab504ddc8=A0was backported a few days ago: https://git.=
kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/v=
irtio_net.h?h=3D3Dv6.1.103&id=3D3D5b1997487a3f3373b0f580c8a20b56c1b64b0775=
=0A=
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/i=
nclude/linux/virtio_net.h?h=3D3Dv6.6.44&id=3D3D90d41ebe0cd4635f6410471efc1d=
d71b33e894cf=0A=
=0A=
Please provide a working backport, the change does not properly=0A=
cherry-pick.=0A=
=0A=
greg k-h=

