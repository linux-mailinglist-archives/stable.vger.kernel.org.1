Return-Path: <stable+bounces-178911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BA4B48F57
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 15:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573BE3C2D59
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88672F8BF5;
	Mon,  8 Sep 2025 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="Jnp+sLxp"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBD22F757
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337893; cv=fail; b=Nn2+UGQ9zFVB91Zsl+d8Itnb81OUzBMUVeQFyhhddaVTgt7av8Bn7SB+oH49ZZzZ9TVHVywg4udLpXrZ7ni29X9nA6vVhtwGFVckYaUHBuAHrCKH2nj1tRgke2AXaZH9/IvUmlA3xORjkmkhQfinOpQyhNiOuPblVLDxcn1/Lp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337893; c=relaxed/simple;
	bh=006WdgZyy18ZTzaGE4bDPggHqfR65cRXi0uRnQ98f/c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HZGuqhu+ep3iGfrDOtIEM4tWQZK5DKdz3i8TyCrdsE0bwrgaYHH1bHtxJDm230MGQARfzNuKjBXKtcevd7kDCA9ZfCbdC+BC8Ngd+sMbFKDp0ebL49gynk5pilTIWhkhKFPpipu4JdyHowtaq2oVBnf6sBEJ2ZT/mhpQTI6OU6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com; spf=pass smtp.mailfrom=sap.com; dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b=Jnp+sLxp; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tcn/KSxEpuBwCQNtAIyHjjpimKph+ga/j0WBYWtVvFui1CbhBwRTI/3oym6P50EFfOb6NXdNnLgi7wBMyc/ox8O3CiBQwK8SH1v3PZwalFdDAq6bes8Hm/oP3dyQA2k8/vZA3eGp6tusM89FxJtLdYZ2dw44/FgxG5dSZdHiRgbdNY+R6yoVYZcby/st4uxEMPx0voK5Zw53KKPLm7nXsLgmZtoSxBwgaQf0X+q4GfU+9cPFoin+VrB/5zwHyYRyoG0zwprvrZ5ZWmItD3X16p7PvATi1AgSJhR+L8g/dZUrB7Nyi94YLn0mTWbBvhmHps/X4Utf/TpTHilJfxRYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x2rgbaSDf8Bi9qEqmz9t0BWWjMQk/v3l8px9yRL5+s=;
 b=gAfr7SZwR7x+1aF9Zkl8EdAW57AAEZNBJSTTdnxRFfjbj7X1+ArzveawDoITGw5UvZWiaGteDYWfZLFYdnRrYxRPyRzjfdsuCt9qUZsnIEzRWUWkPvshnFmGtvyN9dgcj2oakiOvoPlq0DNEfzqpaylL7BqwZv6KMvcYYFTh5AxMex/QQbTcmN9d5TYPOkT+aJ3/1DkdLC5zAu4ejTA9KeAZ2L5FqguxLX9yW79U6ROsVgqE9DT8RdQ51qonHRCa3KyM6g+fe1/i847a5mZZ2GzrwL1RvJkPs8Ir92TI1GOR1OVbhgy+IqNJdIDtR5R1lYHQEhqxo17YUKwaHFhrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x2rgbaSDf8Bi9qEqmz9t0BWWjMQk/v3l8px9yRL5+s=;
 b=Jnp+sLxpsJW+YGfT9ou1VzLtXQA8A38mh60ifCsMyIqtdKZG5+2NOg9V+99Pi6xk93AUWnVq+fKGqip1Pro0G/5lspwTRbbDejZUESIJfxBgMPG68DmfPUPv+VpNaRJp05EtVgxhNvHy47q/WpyZULgk8XxgrP704/a4IkG7/A41XITmtAsQ0YmB7/bJB+cqYqWxi920rbiw2Msi2Kgx5520dVw8myuI9j/aUK5n7XUHXiZlcAtCzWjfpSRLAbMth1ahPB26KSs2UufE9US34z26G3Dv6c2FCHU7Jx69VAFW1Q4dP5wE7WenTLr8/JEdonm8BUZ5y1dzN9V+siTSfQ==
Received: from GVXPR02MB8399.eurprd02.prod.outlook.com (2603:10a6:150:3::19)
 by AS8PR02MB6904.eurprd02.prod.outlook.com (2603:10a6:20b:2b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 13:24:47 +0000
Received: from GVXPR02MB8399.eurprd02.prod.outlook.com
 ([fe80::e6cc:a47a:35a2:f6d2]) by GVXPR02MB8399.eurprd02.prod.outlook.com
 ([fe80::e6cc:a47a:35a2:f6d2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 13:24:47 +0000
From: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Jan Alexander Preissler <akendo@akendo.eu>
Subject: [PATCH 6.12.y] net/mlx5: HWS, change error flow on matcher disconnect
Thread-Topic: [PATCH 6.12.y] net/mlx5: HWS, change error flow on matcher
 disconnect
Thread-Index: AQHcIMPyWhxWJ+R48ke3Uy485VOFGQ==
Date: Mon, 8 Sep 2025 13:24:47 +0000
Message-ID: <20250908132419.97268-1-sujana.subramaniam@sap.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR02MB8399:EE_|AS8PR02MB6904:EE_
x-ms-office365-filtering-correlation-id: 38b32ec0-c513-456b-591b-08ddeedb1519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Hb3hd5bT2S5WOTeCd0mA0HPBziGWefeOxbARiSEAaOOtd8YQX09id5cnXq?=
 =?iso-8859-1?Q?uCkftlJYfE4giQ3cawcRgEQX2qEH67BlakNW3CEdKtDdhvDPOj+cj5FbS/?=
 =?iso-8859-1?Q?wAdT0Klt31wBi79H+7yeAhmXwmB1pvOVo+gNDqgpt4uG8MLrre/+eWP+t7?=
 =?iso-8859-1?Q?xRWx/6bhW/U5Ct24/G5kHt38w21AHF2A+GLrBqpz8MlhX5uCd7LNT9HnWM?=
 =?iso-8859-1?Q?e1VB+hd8sTk3kyyGYO5oXchvmLvwMcPOuy+d5tcl9vxuz9b34o4olyCJR7?=
 =?iso-8859-1?Q?u7BDnJYwcBGDoRKvfHlbdv9RHti1uWMBejeOyEz+UKkakc7Gvh+JFVoR6S?=
 =?iso-8859-1?Q?jM0RwKrlGfwmvTlt8CKPT/gSQCzrEgazZLroHUmkb3kjvPn2v/s0OIpRHz?=
 =?iso-8859-1?Q?G5CERnZTwdy7PZOEEcKuW4DiOgkTbSe4V1rNhX0KNhU4EOfMIpAl3v1JGu?=
 =?iso-8859-1?Q?0DwV2DbaZEgkMeuGsEP7PUbw38pi69nHIdEAeLHcbcevhvRFeapc73dFsQ?=
 =?iso-8859-1?Q?q0eWQEY/y9LHY9tepfYHUcm/MbNjt/Yq2osBcHGP2MXsZvIhLBKhofacsO?=
 =?iso-8859-1?Q?TlCJyX9xJVsD9b+lJs5bSxdGcNS3RkN9jEFlyIK0U3TqxMUXixulqMZXGn?=
 =?iso-8859-1?Q?PUQpifI5O4DiRnxu42zYGiWYKcsPM1zL44uie/c6fcV43Gp/ppjiPoTX3q?=
 =?iso-8859-1?Q?jrVkQNxNvlEneBykWlczTZW9PhGOGyFkh7BhSiyoWHwDZujPcvIFIo3kzl?=
 =?iso-8859-1?Q?yiCUPn7R3wWCrrZdK/+UGvjccRoSYbf0/Qlf1fZitx4X0NS9HehzwGJJRf?=
 =?iso-8859-1?Q?FoYr2Go5PljmrNFOyygvUKNhyOA4rm1mw0NmjjFeROxcHrJDzjn9HQwNif?=
 =?iso-8859-1?Q?N2pKzmcFMa/+vnf3RlTLdCnokXjabo57JyVRPmuvosPAllX5ogYfbYFBU2?=
 =?iso-8859-1?Q?l7+o+kUJXqNiz701ZvwDxrdWXm2X9KVac8ncw/u7oT16ZKzMa8MH4Hiun/?=
 =?iso-8859-1?Q?uFMXwAzphg2PDAQAp6L+hrzjtxNBgQuRTs1PgFvvBvNa6b+7GB2AOtTtJk?=
 =?iso-8859-1?Q?OHUNw7CeDRB1akxXrPtDVufs+Swn32G/37kYlgnWD1yEmm0oh9+W5nUP1V?=
 =?iso-8859-1?Q?R/3hBBHQLm06O9tL0jj3aXbl60DOGZVfQtQ/4Y2F+IZA4b+We0h75vkdBp?=
 =?iso-8859-1?Q?MBRbiYdUyMyjgvgZSCfWQ3SHIjuYCmijzpqHE06fVBAHPY/vhs0uOufM5e?=
 =?iso-8859-1?Q?Uif8pmy+PJngaXAywJt3dYeYQFjYvkbDB02YTrO1Q+0dQzc2IYWVi3AaBJ?=
 =?iso-8859-1?Q?bD3uQ0a1jPMr7HIYH7JNnpn8DnXdUQYl6lFdukWd2+X6EI/RCR0Rsau21X?=
 =?iso-8859-1?Q?+XILYikTEji/LkZmr9w3BYcjDJPzegcQzwdN465qp9Di6dehMUKU+xGPsK?=
 =?iso-8859-1?Q?YuO+rFwisDCUYlW0RaGzdrmVpkYbutKducjpdFRG6sUVOgJb79zUrY+at8?=
 =?iso-8859-1?Q?I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8399.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5H6w67NI/P57cbtez0uNlxGJlAKhnSy2EYD9K8pIPqPoML2UQmA9SPFwfu?=
 =?iso-8859-1?Q?EZUUJxQBSJw1Y/9yc0Dyzbn6w55/hJgZoKpeGCy1LszEMAlInyVk9yxAud?=
 =?iso-8859-1?Q?dperYVwLu9/0hpgaVjqpeLTwV4f63CLtc4k0wzDT6P8NvaA30RGNKFJql1?=
 =?iso-8859-1?Q?c3PEQZiqnpzkS8CaZpXwRGOu+S0C/q6dgI3QAsbPhxncdzHebS7LiFn2+w?=
 =?iso-8859-1?Q?zOy6hQZ+v+tqiptXRM36Bv3Io++/2AWg8GzYMZFTW0gP38zHBNoaTJYHm7?=
 =?iso-8859-1?Q?bf7AmaXF2cFFAJRYfW9Gpz6nIA2cqGh5fcM0Wx8BERLNbWfSGifA2T/i0x?=
 =?iso-8859-1?Q?yYwh/+a3MfFvYP1lPXf4e15KPgKAlG+2Tpwt5ZStFJWeYgxJLiUSfAcIoc?=
 =?iso-8859-1?Q?iiX+9MIn9/qONsXJDXfu/0qiEU2YsKZTltOqv5PUrYT3R21CQkwRObr68r?=
 =?iso-8859-1?Q?WImr2MbQ77hBLDURCoQk/2RBvYxJAZssrhXFuDiYeDrS7pqPEqrgZDfj2o?=
 =?iso-8859-1?Q?drivMHUbrfG0Z/z9RuidHQLaFcmEAGXhgfqf82CW4nqbqCanmFDKKYEKTP?=
 =?iso-8859-1?Q?+qfkMJ3Myhx3QWqQ4hUea9a8XFvbjOi3Hp42CFtW5hkOo3c25wzcScfbQR?=
 =?iso-8859-1?Q?Du0qwaFZq+qJOB+3079LK9AaXfmUJExmZxLYmvTAm1xjvtzhjcmDwwSnFH?=
 =?iso-8859-1?Q?bNjB9Tb09663voi3kjqXTNlVfpkM24ITHxM5LfXfg0gvTSWub+Xrs7mTzr?=
 =?iso-8859-1?Q?MgPvOAeB0Q0VEqsCx2p5JLfIGkVe/We9m8JKi9rxU+4HSYysFkQ/4URVL3?=
 =?iso-8859-1?Q?57UTswLm/+ks1Rpvwz8X6aINih7Oeeaaaur+Ca0zrW1A455HuuTo5fiOYo?=
 =?iso-8859-1?Q?ryGG3h9o5UjZeFfiR+M0Md8b3BNt/DRKgVeT+rTJGtiGcmYoQczpoDUQ/c?=
 =?iso-8859-1?Q?eAyydeUiyQoeA52EQQOfo+utxvn0Nlp8xLQsiPdWJN3k/GgIXoDr1EzQXz?=
 =?iso-8859-1?Q?o+0rgkud5wLw6/elx6V7M9dTbTlaiET2JEarYX9xCKVy7GmsScEXo9SJe0?=
 =?iso-8859-1?Q?pJC4jCyr1C+78/9r0Nn1FLn6jGlyZdOdhbEKw0PHWnxurO0HKoUzmO4A08?=
 =?iso-8859-1?Q?AzJy2dxxymGTU2jHIzoSZELiidm1WaBW0ebayYDyXBBJTmOguEsVJQYN6a?=
 =?iso-8859-1?Q?fknNHdR0jnVQEoZ7Pq3KgwhLFGWUbQ1HA91dbbayUNUaWQQnigjuwzbd/W?=
 =?iso-8859-1?Q?Zcuf2kdB9IZu4nk6++5EmVrXzrByXQhIzzD5fvdCeA+nUeSAkUn5FoAOw5?=
 =?iso-8859-1?Q?Ju/Z3ju/Pi7mFwwkseMs74m6ASEabqtFa4TfWs/cvUxDY0IBJsFo/00/y3?=
 =?iso-8859-1?Q?oOKG+ZkPr4V3YSTXM0CsgZeQVYtfqz4MQh1beaHrpEDM5WP9ZXNS4t7Y1D?=
 =?iso-8859-1?Q?NUwRhy5nbGEZavfS+Bkn1Ozs+PgMxH/UB8fNXhlqHwC54l9FE+IPQIbkN0?=
 =?iso-8859-1?Q?uHYJsPlkjDRjsYsl/0xB3hB/3UuEUgQE3nledBUULun3Tdss6OmffPmFY8?=
 =?iso-8859-1?Q?DHBUJQHFT2NwveCKPzcOHsxdoCozj8a8DwkgP0N2imJC5LvoQLAqNy8OnX?=
 =?iso-8859-1?Q?aNPE5aTto0i5A8r8ZqMuUqYOSwHeyNCwqo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8399.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b32ec0-c513-456b-591b-08ddeedb1519
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 13:24:47.5237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9XOSjWoFjimyYvMB2xlBCuLrMlnmR8T7PG84w3UUVUqCqfYrT1MvUWNbw9vabtRiwXU1Jsz+v+8uc7E6kXwrG31leV2WP1BGtkbI18f4Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6904

From: Sujana Subramaniam <sujana.subramaniam@sap.com>=0A=
=0A=
[ Upstream commit 1ce840c7a659aa53a31ef49f0271b4fd0dc10296 ]=0A=
=0A=
Currently, when firmware failure occurs during matcher disconnect flow,=0A=
the error flow of the function reconnects the matcher back and returns=0A=
an error, which continues running the calling function and eventually=0A=
frees the matcher that is being disconnected.=0A=
This leads to a case where we have a freed matcher on the matchers list,=0A=
which in turn leads to use-after-free and eventual crash.=0A=
=0A=
This patch fixes that by not trying to reconnect the matcher back when=0A=
some FW command fails during disconnect.=0A=
=0A=
Note that we're dealing here with FW error. We can't overcome this=0A=
problem. This might lead to bad steering state (e.g. wrong connection=0A=
between matchers), and will also lead to resource leakage, as it is=0A=
the case with any other error handling during resource destruction.=0A=
=0A=
However, the goal here is to allow the driver to continue and not crash=0A=
the machine with use-after-free error.=0A=
=0A=
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>=0A=
Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>=0A=
Reviewed-by: Mark Bloch <mbloch@nvidia.com>=0A=
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>=0A=
Link: https://patch.msgid.link/20250102181415.1477316-7-tariqt@nvidia.com=
=0A=
Signed-off-by: Jakub Kicinski <kuba@kernel.org>=0A=
Signed-off-by: Jan Alexander Preissler <akendo@akendo.eu>=0A=
Signed-off-by: Sujana Subramaniam <sujana.subramaniam@sap.com>=0A=
---=0A=
 .../mlx5/core/steering/hws/mlx5hws_matcher.c  | 24 +++++++------------=0A=
 1 file changed, 8 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_m=
atcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_mat=
cher.c=0A=
index 61a1155d4b4f..ce541c60c5b4 100644=0A=
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.=
c=0A=
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.=
c=0A=
@@ -165,14 +165,14 @@ static int hws_matcher_disconnect(struct mlx5hws_matc=
her *matcher)=0A=
 						    next->match_ste.rtc_0_id,=0A=
 						    next->match_ste.rtc_1_id);=0A=
 		if (ret) {=0A=
-			mlx5hws_err(tbl->ctx, "Failed to disconnect matcher\n");=0A=
-			goto matcher_reconnect;=0A=
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect matcher\n");=
=0A=
+			return ret;=0A=
 		}=0A=
 	} else {=0A=
 		ret =3D mlx5hws_table_connect_to_miss_table(tbl, tbl->default_miss.miss_=
tbl);=0A=
 		if (ret) {=0A=
-			mlx5hws_err(tbl->ctx, "Failed to disconnect last matcher\n");=0A=
-			goto matcher_reconnect;=0A=
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect last matcher\n=
");=0A=
+			return ret;=0A=
 		}=0A=
 	}=0A=
 =0A=
@@ -180,27 +180,19 @@ static int hws_matcher_disconnect(struct mlx5hws_matc=
her *matcher)=0A=
 	if (prev_ft_id =3D=3D tbl->ft_id) {=0A=
 		ret =3D mlx5hws_table_update_connected_miss_tables(tbl);=0A=
 		if (ret) {=0A=
-			mlx5hws_err(tbl->ctx, "Fatal error, failed to update connected miss tab=
le\n");=0A=
-			goto matcher_reconnect;=0A=
+			mlx5hws_err(tbl->ctx,=0A=
+				    "Fatal error, failed to update connected miss table\n");=0A=
+			return ret;=0A=
 		}=0A=
 	}=0A=
 =0A=
 	ret =3D mlx5hws_table_ft_set_default_next_ft(tbl, prev_ft_id);=0A=
 	if (ret) {=0A=
 		mlx5hws_err(tbl->ctx, "Fatal error, failed to restore matcher ft default=
 miss\n");=0A=
-		goto matcher_reconnect;=0A=
+		return ret;=0A=
 	}=0A=
 =0A=
 	return 0;=0A=
-=0A=
-matcher_reconnect:=0A=
-	if (list_empty(&tbl->matchers_list) || !prev)=0A=
-		list_add(&matcher->list_node, &tbl->matchers_list);=0A=
-	else=0A=
-		/* insert after prev matcher */=0A=
-		list_add(&matcher->list_node, &prev->list_node);=0A=
-=0A=
-	return ret;=0A=
 }=0A=
 =0A=
 static void hws_matcher_set_rtc_attr_sz(struct mlx5hws_matcher *matcher,=
=0A=
-- =0A=
2.39.5 (Apple Git-154)=0A=
=0A=

