Return-Path: <stable+bounces-133186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE8AA91F08
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5355A683B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690901A08A8;
	Thu, 17 Apr 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="o4u+0lVL"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED415A8;
	Thu, 17 Apr 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898436; cv=fail; b=aWGvAs9EFAYSXeXTh7AXAVFRJ1hNgYOzAA9PvN1U5379h8glje5k3ny3/DW8uJn07WEt6RBh9gfdfcPtWrxxny/4lvXna9zN7oSBOlbHBy2BYfok6Yby0+EPpj3Jgdlpm92hKCsVHPMt1+lfx/FjfuMG0yHo2o1Xnw0fNTb5yQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898436; c=relaxed/simple;
	bh=MTadlREVAtDlTXlQEavUPnMW+7Dw3YGbE4B1InqhbzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hiEaCK3QWzemnT4HDELRSFbvVmig12r0k0zyjkhFPzMy9Rp2ab6Rd8S90kqOi90X4sGuSZ9G4hKSni/ogg0gNwcTEqcLBEaspaIbjWq2p7uf2Iu3aIGKQjmg87HTUC3K++r8hFq+Ll2/Sjzxz5jXZDeCFzTl25miN6TFddwpIxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=o4u+0lVL; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AizU2uS88PDE32jX5LslpFJDcTquSQ8+XdDVOXloXg51SN1spzPXdNC6mUnAlRron+fO15wLtJryq92+/UrRIShhSyW+DFOHd9+/c78Qjbkfy07JiX4oMuCZxwRzwWNvPqOJgECfr7i5E5w24Dk5P3BTN6sLabWH+LGnISw/7yR/ojfa4jmDQo+BNhgiaUOKgsGUojiYewz62OrzNaeOBqsLVauEXpGnaM/V9IsyZCohY+lsB3d75qyVB4Ot+uVKzigw+MjfvR8bakl8KNgBDCzh8OltuBfF/zpvzsARFY9adnC7ffWBZDrtXLzF64R1RzTMLwyh4JLdFOzesGLfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTadlREVAtDlTXlQEavUPnMW+7Dw3YGbE4B1InqhbzY=;
 b=SGeOwCsH9PcHlThBnUbNBxvFKpmHT0fiXgBuDu64u/nKvl6yHTu1gX+s3KZg8DTN29R4Keo7OpzdSwk56tQfmf5CmK980mFz7yHkyHyEJehcElu76TYtJL79Ha/9HZp7Yh1VSc4yKcqD0R7YzgMnmGEz+QSGt70VTKtpUUzSID0E5wIE2It5nOM/134J1ww9lwV0MXF+28xePvEgZapj4Rg3jVTd0YPztx08nu727FizYSkPawB7xInkbH7WNGT0HIXANJAz13bF66Qrd7/C7A/V1a6KpeLbNmXVgBv7yNLItf0c2wO/0CaciHSpyVI59t3YdqZnw0cbFTD2D2NEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTadlREVAtDlTXlQEavUPnMW+7Dw3YGbE4B1InqhbzY=;
 b=o4u+0lVL0DFRgzLXdtxM+5TNy/m2SNUVaIjgAAIjTHbFMyNLELyvkArDr8FaXdaml05MGL0POsXos7oH8BkFQ5EhVYXg8RUwOKR4N/5721cvuypEbBHqWOtkiCGI2jro+bdyL4fj1KNsw6ByzfKCHxgT3STlm43zDjkBbK8cNZjwBbvblyNq0gNv0Mk/IHy2CrExLp7/oy3dQJXN06mpWAw/+I2sgcMLLGRDzQMMyNeT7XnjLTIh2Or/QldvpXyjg5L+xGy7TdWw5cYNDxAgY2UdnW/DkmSa3lUHx1jlC9sYAuipidn3sWB2+hZFGHLqA/JPnOs49+1l7NVOqQ3n0Q==
Received: from AM6PR0302MB3413.eurprd03.prod.outlook.com
 (2603:10a6:209:24::15) by DBBPR03MB6793.eurprd03.prod.outlook.com
 (2603:10a6:10:20d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 14:00:30 +0000
Received: from AM6PR0302MB3413.eurprd03.prod.outlook.com
 ([fe80::fd5:7b7c:3b2:8d1f]) by AM6PR0302MB3413.eurprd03.prod.outlook.com
 ([fe80::fd5:7b7c:3b2:8d1f%7]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 14:00:30 +0000
From: Dubowik Wojciech LCPF-CH <Wojciech.Dubowik@mt.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm-verdin: Link reg_nvcc_sd to usdhc2
Thread-Topic: [PATCH] arm64: dts: imx8mm-verdin: Link reg_nvcc_sd to usdhc2
Thread-Index: AQHbr6EUj3f9HCPDJ0SZlVgPZmR1jw==
Date: Thu, 17 Apr 2025 14:00:30 +0000
Message-ID:
 <AM6PR0302MB3413754B446FA2ED83578463FDBC2@AM6PR0302MB3413.eurprd03.prod.outlook.com>
References: <20250417112012.785420-1-Wojciech.Dubowik@mt.com>
 <20250417130342.GA18817@francesco-nb>
In-Reply-To: <20250417130342.GA18817@francesco-nb>
Accept-Language: en-CH, de-CH, de-DE, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Enabled=True;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SiteId=fb4c0aee-6cd2-482f-a1a5-717e7c02496b;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SetDate=2025-04-17T14:00:29.774Z;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Name=Confidential;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ContentBits=0;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR0302MB3413:EE_|DBBPR03MB6793:EE_
x-ms-office365-filtering-correlation-id: 2434cb64-439b-4755-eef1-08dd7db836b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?V0T2A/jrCI75DfF+DiEc4K2Og6MZlRv3jRnVaw91NmevEqjkqVA1sBqE6S?=
 =?iso-8859-1?Q?Ty+aJndfRo9GuyygwUpqZSyVUbkaCMPVhD+VtqfSSb+jCjdnL/rpSexfUg?=
 =?iso-8859-1?Q?da4DF9Bx6G7x7BYRicH6olYhSntYXgaHi7EnNFSgZ494np4+6KPrMPbIvB?=
 =?iso-8859-1?Q?pDeynFGiZ+Z0Ky5H67S0MswO6cS4rwQk9U6BURBZrww8LWUauAtp03QCp9?=
 =?iso-8859-1?Q?9EIBHth1gl1qPW2s2ahBETOTmU0aP9n3IFisREDHBbAlFpSEP9lql/YXGT?=
 =?iso-8859-1?Q?HqS+v1N3LlPuVYgWN6wqHLn88+obtkMLSENbRfYU9z2ORW0yHFeZ/VGlY5?=
 =?iso-8859-1?Q?d39hArH4PHpb7Kv86dXTCik+EtB9aC8H23LPi7abQLCK5ebNI+emxeSdaS?=
 =?iso-8859-1?Q?okSzErHjCg4L2dUk/dVu540BaTrDI0FeRvAYcjIsMHZ8uE+UpqXocOIH6z?=
 =?iso-8859-1?Q?F/EwBZSjhXC2vQdtnjccIkKzZ9FH+Tecs5wBWiw86+8kK0++wY87x4XB05?=
 =?iso-8859-1?Q?esXMBV111mSkjsiVCBbo5dYfBl0baXWtGa5IgKjgnyLkgeVdq+jPCBB/1a?=
 =?iso-8859-1?Q?sMCUK6n2Ll5EyzF2mf1DB3lIOI3YdzGjLsyQ/OFylTf9v4VkLqlXqKEraR?=
 =?iso-8859-1?Q?rFtCIpbIBmjYB27V/VHnetpO3ZrcGELZuyD4bM9gw6mRuiJvwFAb/U+IyH?=
 =?iso-8859-1?Q?OlPknAOoZgnF5qIOL4dNFirOaCMtUp0EjFx8/bULLLJxOBD0ARUEaubMBZ?=
 =?iso-8859-1?Q?lKPXmrkuPctiJCwx7VvdyxflX4nBG8KFEDDmtSxeQUqwELZ1j0w7VvZ1D9?=
 =?iso-8859-1?Q?J0ig802g66IFkVsJwx861O8nzEK4KqnuQBDjIEvSeGfHhhIo8aFH2lUSDf?=
 =?iso-8859-1?Q?1Rufm7vGitq+c3/GwF/SAd7cgFnVai385sWh683bN6GT28BJxhhJmOwdjW?=
 =?iso-8859-1?Q?cJjthMP82eEnc7fscRgOMshmOHXCSe178ZMFif1m55kQQlkNbq9FH18TGz?=
 =?iso-8859-1?Q?jt0CUgoWhSMmHRZGMEXH8mjDxS2tVy5BPHMoxLcXBbCDwyaLUBIzrBggEp?=
 =?iso-8859-1?Q?GZPln/00XndF0Pu3l95GcXjta6jDkiVfbqI8UkjQ9H0tgmIjfGcKy/BnN3?=
 =?iso-8859-1?Q?6WBskySeFJE28XbKh3zq80PTYKanN/ZGVCkLTP3fNOLyeaME+EDBynLZD5?=
 =?iso-8859-1?Q?Q+rPr19+omoYRbUA5wSZ4fraKxNYlOlZb1Sm6LZzSwv+e+8eKRaI8705uk?=
 =?iso-8859-1?Q?5l5cPLbIfFlkwqaVkoHD2KeUazbO0Gife0C5oLdH6ypAAbZRBPAV/v3i80?=
 =?iso-8859-1?Q?joPMdnGC9YB9d1buhlPHRpjKenMlC2RNsEDrflL/zqfJYMZmWY1oPbVvtT?=
 =?iso-8859-1?Q?SKVf7TUoF+yjOwRTUW4zeKlbv7E9eqA6SgLp2ml2n2/yrfKeEiVsJydFZg?=
 =?iso-8859-1?Q?pSwrGJ6KEXOntyWqRJUbqfprT3Z54stPK6BiobUMC0E8g/gCQQRFiKGAjB?=
 =?iso-8859-1?Q?Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0302MB3413.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+LpFOYA4PpqIzaZcM+0w47WTT6AvxLjQpMxqABcsowYOXU3EHTyKhSFJFg?=
 =?iso-8859-1?Q?d8W0wb8XBxaJtR6UyBcYTZOvg4/uuHao/6s1KVsYOtWW/t2UvTjGxTbYIn?=
 =?iso-8859-1?Q?GRWveB5Qtlep7XKAnVQz7hnR2VgKkrW3RTo7Q3UyU/h+tjXst4gq8ZZczr?=
 =?iso-8859-1?Q?tJstphDnSF3veX3Udkeo3njfuCkgcjGl0CL5x9dsu3oVhZcEf25C4gDse4?=
 =?iso-8859-1?Q?TwA+hXhG7GHRcNp/QPdoyVX02MoI1omp2rZyjZbbdmX4QWHqp5Tz87QKx1?=
 =?iso-8859-1?Q?xFSHC+5IriHqoj1S3ajUSiBQ8NLOrFyI+ZS72fKS3UPjnmXZklyMxy2V2x?=
 =?iso-8859-1?Q?vT7fjYlMpLr5ZTVHlA4FfP5qJP6Hn/ZmjH86+oK/1zPKvYNYgAXxwCdDA/?=
 =?iso-8859-1?Q?Kl6ILsqx6tm7+7xBlav6Nk3qlvtDqrSGvVTraINhhid6aODFRKQSyqcz0k?=
 =?iso-8859-1?Q?0exOxxcC72YOuFMcrHLPjbT888rXybPmiEzXjPLsraM7Mbet376N7nWge0?=
 =?iso-8859-1?Q?tb6nOFP5GWDhcCp0cM/NaTaKstbVdGhAx14mj7igNupf0nC29vIh02haEp?=
 =?iso-8859-1?Q?2PXf8ehKxqDTFq0R/VahDWzgL/THC7hHj6IXuvCUej/x/1dPihgl93i5Qf?=
 =?iso-8859-1?Q?TxSm2vWQ24QUoeMO2DJO/l24imIrXHLHqabGc/aP33GiV95DQm9Vhy0TuF?=
 =?iso-8859-1?Q?VbRN7TQC1LiHu4TCHHCNC9vRpZqmKfkp7mlnaxxdjOkS94UF4uWoWS5cPg?=
 =?iso-8859-1?Q?H7usahk2+hOzO4sKAJc92IBdubwhI5yHQXsXkCW4E0c8oOBpq7js8P5Rzu?=
 =?iso-8859-1?Q?4Oer3Yc/2GLD7sXDr7b68Eje6/anjH1CWJ1SXnMOqi+L5P88MQr5zwJ1E6?=
 =?iso-8859-1?Q?+snxiyTuba4aMh7hmqlFmy1ryHErxEcbvcRJwy41bBVmDyYGffcS7vSZ1V?=
 =?iso-8859-1?Q?+jbYg4JhZPy2J8pOjeGZcI6yWpEmpMqh3mv/Pq7ygYLVF2HlFrL4NXLhrn?=
 =?iso-8859-1?Q?/K7Z231K4nKuiqbAwjFgnrqMXdVGXDby2edLAjt4VONp3QyjU1jgkbCwUH?=
 =?iso-8859-1?Q?3TDoWZmwQo9mc1lAwpp9Fk2IB9XJH78KNLi/3G3Dy4g20BF8eKIsVVgEAF?=
 =?iso-8859-1?Q?9lqgI9wt070hWN5g5CVHCU6LDGX2IPFGI9oXxmbvTi9wzJcTnVdaDDYE9C?=
 =?iso-8859-1?Q?s7PBvhZJRtmr/lpoUmn+eE80nz6R8jne9XlFWkfiEwadmbSueLE9Q2utSv?=
 =?iso-8859-1?Q?Vrk75432Bf8hj1oa5OBmrNCZtMPb/7r1ZC0ypI/NwM85ftSqSnhEXdRExV?=
 =?iso-8859-1?Q?Zsa+T6us+9QB4aF+UgqAQf7hyKddQI6LDLAVwO4f55p/5CTlAAyuX5+9dE?=
 =?iso-8859-1?Q?nHpU1d2YHoqy/Rmz1flpp0eNgpTq875CsO/TE4ZZXuMXLJovl0UWxlGAUg?=
 =?iso-8859-1?Q?g4YyePtYkZtznzU24j2CKaT3Jamsg0JjN1suucV1n6/XW77YKTqQreWXo2?=
 =?iso-8859-1?Q?uCKRIZbb6gkUNT5RSbsvQTfHXJUHIYE51NdmAt710oGG2xmUsvHoV1Dxw6?=
 =?iso-8859-1?Q?ujgREVxr9CpQ+LPYsgU6O40rzGFVwKob5BLbaTlKblX9UGkLNNRkdGLnUg?=
 =?iso-8859-1?Q?6ocng5CJR3NJoMSUz4WIcJJaYQj1u4Y6iA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0302MB3413.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2434cb64-439b-4755-eef1-08dd7db836b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 14:00:30.2053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0m+2TZ235l9SJ1Gz9BSjolbIf/pekcOOmr6Ga/NSRHGt4ZvV+LYSchcs3P+m8RyZMdJApp35NpIkNLf8ixdhtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6793

> From:=A0Francesco Dolcini <francesco@dolcini.it>=0A=
> Sent:=A0Thursday, 17 April 2025 15:03=0A=
> To:=A0Dubowik Wojciech LCPF-CH <Wojciech.Dubowik@mt.com>=0A=
> Cc:=A0linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Rob He=
rring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Do=
oley <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <=
s.hauer@pengutronix.de>; Pengutronix Kernel Team > <kernel@pengutronix.de>;=
 Fabio Estevam <festevam@gmail.com>; devicetree@vger.kernel.org <devicetree=
@vger.kernel.org>; imx@lists.linux.dev <imx@lists.linux.dev>; linux-arm-ker=
nel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>; stable@vger=
.kernel.org <stable@vger.kernel.org>=0A=
> Subject:=A0Re: EXTERNAL - [PATCH] arm64: dts: imx8mm-verdin: Link reg_nvc=
c_sd to usdhc2=0A=
=A0=0A=
> Hello Wojciech,=0A=
> thanks very much for your patch.=0A=
=0A=
> On Thu, Apr 17, 2025 at 01:20:11PM +0200, Wojciech Dubowik wrote:=0A=
>> Link LDO5 labeled reg_nvcc_sd from PMIC to align with=0A=
>> hardware configuration specified in the datasheet.=0A=
>>=0A=
>> Without this definition LDO5 will be powered down, disabling=0A=
>> SD card after bootup. This has been introduced in commit=0A=
>> f5aab0438ef1 (regulator: pca9450: Fix enable register for LDO5).=0A=
>>=0A=
>> Fixes: f5aab0438ef1 (regulator: pca9450: Fix enable register for LDO5)=
=0A=
>> Cc: stable@vger.kernel.org=0A=
>>=0A=
>> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>=0A=
>> ---=0A=
>>=A0 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 1 +=0A=
>>=A0 1 file changed, 1 insertion(+)=0A=
>>=0A=
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm=
64/boot/dts/freescale/imx8mm-verdin.dtsi=0A=
>> index 7251ad3a0017..6307c5caf3bc 100644=0A=
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi=0A=
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi=0A=
>> @@ -785,6 +785,7 @@ &usdhc2 {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_u=
sdhc2_cd>;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 pinctrl-3 =3D <&pinctrl_usdhc2_sleep>, <&pinctrl_us=
dhc2_cd_sleep>;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 vmmc-supply =3D <&reg_usdhc2_vmmc>;=0A=
>> +=A0=A0=A0=A0 vqmmc-supply =3D <&reg_nvcc_sd>;=0A=
>=0A=
>I am worried just doing this will have some side effects.=0A=
>=0A=
>Before this patch, the switch between 1v8 and 3v3 was done because we=0A=
>have a GPIO, connected to the PMIC, controlled by the USDHC2 instance=0A=
>(MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT, see pinctrl_usdhc2).=0A=
>=0A=
>With your change both the PMIC will be programmed with a different=0A=
>voltage over i2c and the GPIO will also toggle. It does not sound like=0A=
>what we want to do.=0A=
>=0A=
>Maybe we should have a "regulator-gpio" with vin-supply =3D=0A=
><&reg_nvcc_sd>, as we recently did here=0A=
>https://lore.kernel.org/all/20250414123827.428339-1-ivitro@gmail.com/T/#m2=
964f1126a6732a66a6e704812f2b786e8237354=0A=
>?=0A=
=0A=
>Francesco=0A=
I will have a look at your suggestion and try to test them on verdin. I won=
't have access to HW over Eastern so the patch will have to wait.=0A=
=0A=
Wojtek=

