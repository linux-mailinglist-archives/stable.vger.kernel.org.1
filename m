Return-Path: <stable+bounces-216067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEB5I5oUj2mqHwEAu9opvQ
	(envelope-from <stable+bounces-216067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:10:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E93135F45
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 652F53036044
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51FB35770A;
	Fri, 13 Feb 2026 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="wFS/oEiw"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2B340286;
	Fri, 13 Feb 2026 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984550; cv=fail; b=nciphT8CYMK+kJmH7SQTuVllVwzrxZAwg7Ae7HZoZNR1BjnwV9uVElwteK1li0btQZbft6TruT5/xtd8tiGGMjEHsfFe9vxolBXLPSVr8Eg+Jk0a8oBZ2jGvK4m0lX3bHFusVFAzXTaeFRmyzWQjPwyd1s6pOFvw4m/WzbkgWlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984550; c=relaxed/simple;
	bh=f6EETJtNI/eDRECp8JzjFkKRl/rPrFhexSXbCF7OMtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P3eQXGd+zpzAuhwAxIvmD9TXkcckQc+shmexjkzmJQU1cX91uCsURmvBz7V5cCQrdBr4sf0OsJ3Kdm10oTXhPZNh0qHbbssFsl1KwzBtmelUTgKwsIucTRIMoYAAaHvUI0mjleC2FsMoq4uWdZv8aa11boFRueDfCn3Q3SMy1yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=wFS/oEiw; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEdtuLM9mBTISTXRtAP+FbZt/GAq8fdeXHjve/g8upp6qEcWc+CaauZg6CNqImsH9a6XMPdxYKcA21ZS15kI/eG34PRVrpmp8plZPjdxGjwGXPGPPY9Jf8JcOZ6RLelCdeDK+6A0IYBVN41Gq1WD0cVg/w+QOab9hOCkz84imacixr+qWn60hCZM1Yq4TesCf0TueN+G0yc2PVIsBA0IKT0Cm07654V0SyTLI1UbM4HvKLmcfzJCfTF+FnE25lIbYJ7xL/YLMfITfUyLQ2kuorKSoxXGh9Z0gl01G9GQl9OkrxYTIIauD6gZTlpFmjbY3yaxYUsHlELWQO2WcPVXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fj0iWFVe3tYkZDd36n1rhjZPJQQhMbh5YxMbpiA4P4A=;
 b=HSiex6M2+ElxjhMYCBILr0qlN0CxCuJjhP0syjntqdi3ELNDKAYkSZcm9xYx4i4qTzw3feBEBp883IziGqL2M1mjDwx/xd65Btnn6xFJHAqf1NPVmFbAXE4ZMMqUWVAtH/6t8P5Hf5MHX3B2orFPKJ9+Mqyfxtn2VjM38Dm8Cbi5Xb1IV8a7/rMMtyhjP6YYWzrKy5/l+CuGYDsl9ekgMpbp9omCYEC4c5QDhQ7JCAVbPYvk8r7MR/sBbs26Nr3Ez+ee+FOOr72V29peeDOimAGD93fwlsmKdf2kwBf01in7DDIDCPdOgMksinZpP7lIR93npGSHShPgHOGtsrbtNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj0iWFVe3tYkZDd36n1rhjZPJQQhMbh5YxMbpiA4P4A=;
 b=wFS/oEiwTWR8oszlgMBq2na8g5glj/0811JO4wdEdjRggVlII29DNzU7RuR2KF4cAZdSgBwMnO2WdHGZlgSlxlSnTAiQIpF3IX0DCDVuhfT8a9XFcSMgQUMamg79u8UppEESItPfc2m0zYCpz0XHUIyYhs7Nj73wDc/oqlC8kQZBMUPOlMC37AYKl4ehXRr0qJLKajjGIlZjs0FaCPElZqqNHXjbnqC/ezW21//xFNDoQ/dtDTomH193jvcmrv9jJyOh/5orMRM4qtd2Oh7GDGmii1ujbnsyhdEsNtj19WuHesm/ursWSxKCwV3jYZYFNp7lDugDCWgeB6KDqoVpMg==
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com (2603:10a6:20b:2cb::15)
 by AS1PR07MB8760.eurprd07.prod.outlook.com (2603:10a6:20b:47c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 12:09:04 +0000
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef]) by AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 12:09:04 +0000
From: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Philippe Belet (Nokia)"
	<philippe.belet@nokia.com>
Subject: RE: [PATCH] uio: fix uio_unregister_device
Thread-Topic: [PATCH] uio: fix uio_unregister_device
Thread-Index: AdyczTOwZ9hpJI5oTQOYiXyEW2r4HAAEcouAAAAKB/A=
Date: Fri, 13 Feb 2026 12:09:04 +0000
Message-ID:
 <AM9PR07MB720414361A0BA3BA2CF107208D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
References:
 <AM9PR07MB720434A2B0CC99BC0BDCD74E8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
 <2026021306-shabby-overhead-0626@gregkh>
In-Reply-To: <2026021306-shabby-overhead-0626@gregkh>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7204:EE_|AS1PR07MB8760:EE_
x-ms-office365-filtering-correlation-id: be8c7ec3-d7ca-428e-52ab-08de6af8ae8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5S+xTsKz0bus/kJ3lJgyorYqK01loP7tosvRsWeCV/ilvvDev0faR0BDOppn?=
 =?us-ascii?Q?X1UiCCSlp3wSdK6+C7DbvqP1ntecdIda3/1t51r92PA+GrbkqUBCovcul0la?=
 =?us-ascii?Q?WNRo/ezbj+eJj7XzS5tuwuHy4C+ovjHwFg4JFcA+C6AaV9426LN7Qr5LL2nd?=
 =?us-ascii?Q?3TeirpsMNigoOROqZSMQtvS4tfRCNaKTzxt0sTUOSFaLPBpoA91AzXs7GlUj?=
 =?us-ascii?Q?qJeRYS21Qen3uqxYh7Oxf+6ZJOu+DzExJHv5tpf3qRx2k1wYl1UPegFFQK/7?=
 =?us-ascii?Q?9Qz8MQBpq4c06fHHnUiJj5m7ycb77sUB7RMDIXE/HR5vxE7puGk0HTVI0V+R?=
 =?us-ascii?Q?fwaFfZOM3t+xG/0GGUop/NWTo1VqP7QtJeyFJFdRQYd5TxlZE51OLYvDZUH+?=
 =?us-ascii?Q?l3QRPWdsVHMvk2hviZ8c3caZJwwygBLujIzQNCdUIFG1iNwEJ1mErVzsRaPj?=
 =?us-ascii?Q?3POfe8HAmqhvFeG8LE0JEzvEh5SJhY8XPYJtLBzI4NkG227zdPlfEqZqv42v?=
 =?us-ascii?Q?RRzdvPmGQ6uEzjlMjVs8ZXNWHITvzZ6MH5CIDk0QhtLIKHCaX8JD5PEQfM+M?=
 =?us-ascii?Q?OYg8SeQNJXCEr2W5Gi+uhC8gNokB/ncAmd2PaVtDsMYKepEymUnkCSvR3M3K?=
 =?us-ascii?Q?f/M1Ipm9v/NfKSzlEvZ9DDEOwerYWXD7oZb482E8zMbc3gBUqZWoy9JTeFDk?=
 =?us-ascii?Q?qo7V5EgtVvkTcl+Q1OTWr7XnNysJOOFYTai7NjO2faYmJSpcGLC8ElsW9RoC?=
 =?us-ascii?Q?FRJ8FrpRLYGf+fe/RvbkdoBErX/g5Ob2bhes7F1Zi3mCnnDCNsqoaGkk9wAx?=
 =?us-ascii?Q?gwKhgRQGGNbCvuyS1L1AP/Gb1s58JJeyMHWSLkzIkkFg/oA8JLc778us5zag?=
 =?us-ascii?Q?p13YqHhA06adwWp+qGCxKB1yowlwIoRRXUHGLRTdtVa1X8U4ysTx7t5XGZbY?=
 =?us-ascii?Q?AXdtJJoVKU+9WUd6GhITT6cpYPt5OqeD8DJEP4GDh6EHB5WgSlKGmdGYm2Tm?=
 =?us-ascii?Q?QNhrnP0pgTwb82k6bKK2wTNMgI5MH6DpaCjj9mo0pXC8Ts8DOwL85FfsmdvK?=
 =?us-ascii?Q?l8RzfBnsr7bWCWIdWU/BlzZT++rTwb7Wi1ghmUS9PBVCHW71FK+mDzwS/oDW?=
 =?us-ascii?Q?SSpRI3+XSnMiIH2Nf5Eg0ljZIJ+2JXNWFpvgSEHuSY4rwudpvWj0rVAgkb50?=
 =?us-ascii?Q?bym2zYrOXhYa8cb7kHszBdvIKxaKhnI24j3eF44yzGq40+QaLtyZEncAiLKr?=
 =?us-ascii?Q?Ihh1uViP5QSIEYluFY2KvrCjajdNkq5bKgvcynAikLWctbAfBElmETQs2I3x?=
 =?us-ascii?Q?nuAJrwMe9XNr3fvClUwpjZ06uucP5YR1Xnr1GswyuuVgl2ORl4L/aa5qQuzM?=
 =?us-ascii?Q?z8u1kQKKPfbXKB4++pUSQllGtHb3xuOAJiPiuIWNojxst8T6xUrUXSvXg2lb?=
 =?us-ascii?Q?1jHproPIR7QsENK+qLw99QlP0147BBOfb16b0Bd/8bJ8FUdfzsodDDIB9D3I?=
 =?us-ascii?Q?MkqUSPbCOIucRCQMnFuqyyNRvWBzlutcoGZTDHm8NMcnSEo/iaYJhg19mpHV?=
 =?us-ascii?Q?AJVjRHm3uPeOBpnGDOHLicrK+SXKJ4prPkxXiUV/900qve5mCVaFjUysJ3E3?=
 =?us-ascii?Q?syCVFeTppeERglLdAvAMlg0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7204.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ptboPx04Ql66X8ryCol/7KopbFvf8V5Qkb4s8SJw7eiwMUVz/qKMnWR4jB8P?=
 =?us-ascii?Q?fvU3S50KLmP2K9W/+lnGdb/hK2hQGSK9hSV5NF7+VV5K8q09/si1uvck04cQ?=
 =?us-ascii?Q?Il8IEKnNsyvnLGILODuUsKTF7qvXBeaGA9V5WrWLEf9TuwwE9dIRBXFh5fCy?=
 =?us-ascii?Q?+7AVxsxmXQfirSyynM+gv0ySDjN/gmPh/ISkcmh2AVxxtOZGrNefQrJYIqva?=
 =?us-ascii?Q?NujW4K1teMXNxb700nzhRbLgVhKXSdvnHAsSqdtkJVF3TeTW6n16nVbE8nLs?=
 =?us-ascii?Q?QbOO/voeOwGwsfvtgbBrgLX+qwE9L/vWxiHBCZ6xlRQv2bR6ZKfHgS9uvdnr?=
 =?us-ascii?Q?M9EkGaKLnHO3y/PjMn5gZNrW3Pi1kb8Be2yBvva/nwZPA6yAkFS7b0Izv8+H?=
 =?us-ascii?Q?yxzQoU3O66KO1sUtPctyJnBstkIQxXa1iH0K8fEGu2FgKFoG6FuynlLppxjK?=
 =?us-ascii?Q?QzYKnQlPtiW3To7ZChdUuzejpOaaE1mHf4iLUafZpmpz/5VQaEbXaK6zKbuM?=
 =?us-ascii?Q?qqbacMz4rfe0itCTq80tcerIKlv0D0xmofGTFCZpy+Pba0sXmaPA4DD8OW+k?=
 =?us-ascii?Q?2MoFbgGBnVHIVXvDyrX0Oj/SnHtXpb0bSSra/g5HvxKM7lU/KClzXK4WSrOb?=
 =?us-ascii?Q?YRIpPJxx+WD2eoMzSGe734AlCRm5XqmqOwLl2Pse9pJVtda8uPlHuzFcMO0D?=
 =?us-ascii?Q?OWQOV/qX22VLFI1doMQeZ+uATI15BdB0dT0zYSblziMU1QSC0t5fX+ROEEwW?=
 =?us-ascii?Q?tylBLs0vzyPSXYc7zITQhFZKtZOyHgpnUlLW3vE1BSEVk0EahmX3vBmU4hdv?=
 =?us-ascii?Q?nN9WmJM2AT9DtFMrVmFO9vxh4Fzy2ypYHOAC1p4TKGiVQo3e0v79eOIgHO17?=
 =?us-ascii?Q?37BrKcywEujv9aGJoSJpYbsTETStLqeYXBC8Imnc/CZB8eVUWtzOQNjUhj3N?=
 =?us-ascii?Q?A9Qno/pQgQ9NocMaVRYQpyx1gYnBisicBNBbcb2KKSxZQbsochunFSwOgrJ0?=
 =?us-ascii?Q?PLxGDjRWBiFyF+3lVGY0snHrLBrYeqIf0TOJcYuBHwRMuNFVD1gLQLYcGs7m?=
 =?us-ascii?Q?rxjUyYgIwx07tpP+rna03SV9lsAOprlpRqJOYVWq0xOHxmJrjOTGEfZmb1rz?=
 =?us-ascii?Q?cmOgAeamP2fQ2lRySLMPu8bIJ2SahywS+yo+q57NRr/ffcKosbKhzejH5qCm?=
 =?us-ascii?Q?YubSt3t7JnEkGIBH26WeHrsa3TGaa5Kizo6LllEiIeLeC4lyXrQ+ol4hRjK6?=
 =?us-ascii?Q?eF29lMzKj3CmFol1cDhq85jNI9OoM+s222PF6vQAx2vwzKNzErh/YcggIsAi?=
 =?us-ascii?Q?KV7qmiFbwHrMS2KkUoMZ7UrMX+szw3hCRUIMPxeV9cl41kf9Kg1yuuagFG/X?=
 =?us-ascii?Q?IUmSO4AUqFC5NDzGuE7pLb+b2ll4Nb5HP//Gm44F8Tp5giE0RH6QmAoFAC3p?=
 =?us-ascii?Q?mCwNZ6pBBaaUhH9DmMpkqqX5Y5UkXB3/AGqk/HK2e55gWi6FiNUpdUViAckj?=
 =?us-ascii?Q?pR4o3nq0JsFCQ7CjO3dcqbQw4oG3Jx59dmJ9PCh8OidSW//5vEdmZ65p7PuY?=
 =?us-ascii?Q?poyt0tJvg1AEiSgBoSGYFuoO37Sl9tXtRVOOFef9PolXXn9/s6LvGY6e9a/j?=
 =?us-ascii?Q?gIKcNE9VxPRYEJ5jxUd1ZyMFTVEP5GmQc+RWxeaDEYPOiT2WM8dEX4mZryrP?=
 =?us-ascii?Q?PXUQXxqpanOnQDqNZD4Pzmw9u1FCt0vaqdblCMfA7SzLTL/lczMnFYBVhM+o?=
 =?us-ascii?Q?ehkWjs3Stw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7204.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8c7ec3-d7ca-428e-52ab-08de6af8ae8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 12:09:04.5558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4UgrkRTbr/JwwqagLEpEZxMfaEbmK9Crf+Na/KcpHRTyuYrqxdAh1i3Y6MADyu9n8lsECaOvhw8N81mazm1MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8760
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nokia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216067-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nokia.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igor.klochko@nokia.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,nok.it:url,nokia.com:email,nokia.com:dkim]
X-Rspamd-Queue-Id: E1E93135F45
X-Rspamd-Action: no action

Hi Greg,

> Nice fix, but what is causing these devices to be created and removed in =
parallel? =20
It's an outcome of a stress test.

> Nit, line wrapping at the same column width :)
> Please use more digits, as the documentation mentions.
Acknowledged, will resend the patch.

> So no locking is needed here?  It's only the minor that is getting messed=
 up?

Only minor. If I look at the history, 0c9ae0b8605078eafc3bea053cc78791e97ba=
2e2 moved the minor before device unregister.

However, this breaks a fix done in=20
8fd0e2a6df262539eaa28b0a2364cca10d1dc662
uio: free uio id after uio file node is freed

> And should this be cc: stable?

0c9ae0b8605078eafc3bea053cc78791e97ba2e2 is a CVE, so it was applied on LTS=
 kernels, we discovered this on 6.1.
I thought stable is the right place for these kinds of patches.

Igor

-----Original Message-----
From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>=20
Sent: Friday, February 13, 2026 12:51
To: Igor Klochko (Nokia) <igor.klochko@nokia.com>
Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Philippe Belet (N=
okia) <philippe.belet@nokia.com>
Subject: Re: [PATCH] uio: fix uio_unregister_device


CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Fri, Feb 13, 2026 at 09:47:35AM +0000, Igor Klochko (Nokia) wrote:
> When uio devices are created end removed in parallel, then we=20
> sometimes encounter kernel traces along the following lines:
>
>   sysfs: cannot create duplicate filename '/class/uio/uio899'

Nice fix, but what is causing these devices to be created and removed in pa=
rallel?  Shouldn't the initialization sequence be serialized?  And the same=
 with removal?

>
> which stem from:
>
>   sysfs_create_link+0x24/0x50
>   device_add+0x2f0/0x780
>   __uio_register_device+0x18c/0x550
>
> The sysfs directory creation is performed synchronously as part of the=20
> device_add call. The high level sequence for uio registration is:
>
>   1. uio_get_minor (idr call, in critical section)
>   2. device_add (leads to sysfs directory)
>   3. manage attributes (popuplates part of the sysfs directory)
>
> For unregistration we have by default the following flow:
>
>   1. clean-up attributes
>   2. uio_free_minor (idr call, in critical section)
>   3. device_unregister (cleans up sysfs directory)
>
> This creates a racing problem when we are in parallel creating and=20
> removing uio devices. The uio-minor that is freed when calling=20
> uio_free_minor can be claimed by a subsequent uio_get_minor call. The=20
> problem is that the device_add flow can end up triggered, leading to a=20
> sysfs directory creation; while the device_unregister flow has not yet cl=
eaned up the sysfs directory.

Nit, line wrapping at the same column width :)

>
> This patch cleans up this problem by mirroring the registration and=20
> unregistration flow correctly. After this patch, the unregistration=20
> flow becomes:
>
>   1. clean-up attributes
>   2. device_unregister
>   3. uio_free_minor
>
> Fixes: 0c9ae0b86 ("uio: Fix use-after-free in uio_open")

Please use more digits, as the documentation mentions.


> Signed-off-by: Philippe Belet <philippe.belet@nokia.com>
> Reviewed-by: Igor Klochko <igor.klochko@nokia.com>
>
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c index=20
> fa0d4e6aee16..5dd137a85576 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -1125,8 +1125,8 @@ void uio_unregister_device(struct uio_info *info)
>         wake_up_interruptible(&idev->wait);
>         kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
>
> -       uio_free_minor(minor);
>         device_unregister(&idev->dev);
> +       uio_free_minor(minor);

So no locking is needed here?  It's only the minor that is getting messed u=
p?

And should this be cc: stable?

thanks,

greg k-h

