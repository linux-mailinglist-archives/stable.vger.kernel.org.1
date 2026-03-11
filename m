Return-Path: <stable+bounces-224736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKP+IWirsWmzEQAAu9opvQ
	(envelope-from <stable+bounces-224736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:50:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A52683FC
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C596B30338A7
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881163370F4;
	Wed, 11 Mar 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="A2dteuFG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="KKkgdm7n"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58AD30EF8F;
	Wed, 11 Mar 2026 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251427; cv=fail; b=NP2O2bb03fvvbgTb8y9fPdXBuKay9lnFGYd//TvhbYyZ/YCWk3IJtW9Z8eNO4GwzkYo+biM9s0TZ2ler/AbbtcRkvn1RBcuKGx6Ne2z+k9tzPNLAxMUvo+xs/3NCrDjKAdWHC4WjWasxLWECgGlRZBBu2TLlkeIapr25IhsGEss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251427; c=relaxed/simple;
	bh=PwSKHdVVEpnKAyGaqnFY6xLQQ2TQ8XHeJ2cE6QfK0ew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ebDF+S1TofE6J4qpOzc/S5JmnntzfIu57HXxfUjNZK0aoLqkpkYOV3r67DJUEAU+lOtN1Zvkh6cvt60dsr/Prr4bjHjda/AKQKPsbSzCufyuebIid53aTpGRFuynTu3cNDbCMc8jl5E+Nva+d831nIjswZGuxPhK179/P2DOCj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=A2dteuFG; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=KKkgdm7n reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108163.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BGklEH2626649;
	Wed, 11 Mar 2026 10:00:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=wwBr7ykGFVkRPEeyaeO8ez1/s96O3ZQ1e7KlSVRhsjw=; b=A2dt
	euFGvi3Aobu2nt4ro90jbytGzh0TvpMwVAqwIBpIro4cesYfhzPx2UPXdVxNlmGQ
	f2PnttH+sGA29/2WXE1Cn4rs+Dj/duyLyUn5Iu/pdGWCNFpeg5fwxyPnV1MXI2h5
	MxNXBA2rdUWkb8zAaQoeeZ3hvf64YqpP2r4z9Ac+OujstA82jqcKyBN3CLoV3SD3
	ktu2OJtg540aEPmL8fqTlJGvxpA/MH0BFXhgfuOu1IZGiA10NabpEQp+D8MFXr9z
	0xxl5TaFMvllAj/C6CkUXxQYsVn/86RQqG28gjle5EjsW0dpHC+/e/pdGcXrX854
	Ai3OpxweHFhzIWYDMQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 4cu52djb9a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 10:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUH3oH8zUOC/PPb6lKdSqhU0p1iyi3Bsv45eDC8a1D+fn+PMQBRXPYlnAUE5TiO1xIiiS25fJEWS5PhwT5+07+YY02AtmP+Ar2sUfXx14UZmBfZBV0fmaI8pcBPpHOSeQflV6id+UMw3pJ+jdkGebTb8h0JOCTOccjxo0JeZGkSU1381n+id9xX0K0PQrMjY3YaSu6qGE/g79NK/KYrFvtg0V7I9VbysMHnkS2fW9i+/PC6ux6WJaYxENW44o+4cA1FUYJb2gtr1K7+QmuxKKN1So65ZeSJnAcgndJIeTD5kk64B10PehpHno9g6l/jEbyKBu9idd8Xc83q8GNJyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwBr7ykGFVkRPEeyaeO8ez1/s96O3ZQ1e7KlSVRhsjw=;
 b=rPvLHQ0HO3bIfOVJTJs6Hl0cwE+Q4OdcoIGiN+hatsLlWzck1fhnzynONWiJKDwuGO3q7tytPejF6mYu14e781QsrcsH1iUAgXEgG5tHtIRKQ4u0VMX0qwKv0IW4TlNSQZtdzCYl6Qin6Tmq2WO5xWwA5uAw0FRa1QJCNai9uyD9JqDznimNXI61aJ6QATre/lfn2R7wMpYD+efY21qjUVvD2RcHA0u1RBY0GCXs8IwzIWa1VaZTfvkoqysYiH1Plp6UdKoQLlZyraGSTpiqlldB1BkLr9vk6UJDcScBYwPyielI9Lzx87mAQnFd0N4XNt3+eDoKEKYDQDNjeLfH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwBr7ykGFVkRPEeyaeO8ez1/s96O3ZQ1e7KlSVRhsjw=;
 b=KKkgdm7n2yaeKVcuZnA3ISb5LOaGaGxcZ554V52Rj5rpZgDuJzKqyqIRgFTJmKThy9sXjDyDmiok4ZJtNh/SbqF+TzQxsjBVp6F87ITTB/AlCVfvCnVMd46GL2Y2fqi0EcwSq2sR88tDPIV7HV5HmytFPs30ZmXK9ldR2zzlD5k=
Received: from PH0PR05MB9745.namprd05.prod.outlook.com (2603:10b6:510:283::11)
 by SJ0PR05MB9912.namprd05.prod.outlook.com (2603:10b6:a03:4ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 17:00:46 +0000
Received: from PH0PR05MB9745.namprd05.prod.outlook.com
 ([fe80::76d3:570:cbfb:f05c]) by PH0PR05MB9745.namprd05.prod.outlook.com
 ([fe80::76d3:570:cbfb:f05c%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:00:45 +0000
From: Brian Mak <makb@juniper.net>
To: Lee Jones <lee@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Herve Codina <herve.codina@bootlin.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: core: Preserve OF node when ACPI handle is
 present
Thread-Topic: [PATCH v2] mfd: core: Preserve OF node when ACPI handle is
 present
Thread-Index: AQHcp3Gnu+SgoWRapU6tNIrs/eSZA7WhjgkAgAAP/gCABfG5AIAAEeQAgAIAnwA=
Date: Wed, 11 Mar 2026 17:00:45 +0000
Message-ID: <D6FA2D4C-EE9B-4B30-BE9D-A00F83D4C19F@juniper.net>
References: <20260226224511.458065-1-makb@juniper.net>
 <20260306133806.GM183676@google.com> <aarmKE49wgbIblRb@ashevche-desk.local>
 <20260310092148.GE183676@google.com> <aa_xriW62F2j3Cpu@ashevche-desk.local>
In-Reply-To: <aa_xriW62F2j3Cpu@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB9745:EE_|SJ0PR05MB9912:EE_
x-ms-office365-filtering-correlation-id: 6f720618-dfc1-4b84-b056-08de7f8fbc85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 C8Q+PyABKLrcng6ewngE3MqN9DDvhP5nTyBOB/zu6406T3ErrAD4rzr4gxVu9bIi9QNlJtkGktR2Ke7w6YkWB1g7AGHZkyibIqigwCXIYLsbJz5nmQlvVVQhnwnMOpWf/9kJxBk3D6WOgJQmj+yqycSHM4402O8nuc0AzpwKoD/i4VAYi4eri3CGONgzOJ60lbzSba5YiZ1xviabonZBKX+sVGu4sprMgZE4jw1Vgj+aD40BO5yuPn7Z72zaAWsMAaJQmDHbCjjMsc+mtj9o8EihyOaTZ/CTDmYQizg83H58mJdvQBB3Ftau/5qkgoPmJB6/EXLOgX7+EBeTixNv0FustUk28yJ7E6gVA1W7zSq71F8aP8Wn/lynnMnKjkgnX2cB/aE4GW7VYzrIkWzNPvzNHI59683esN2HpOUAL22fC7dZqVwgtx5C137ifbbINvPF0qjHIFpeReXVmfez6w1AfNRqy3K8z2vwZYQrNcPY6rVcWbR3RqbAeEuhgMdLcxsd6lqq0cS543nyqwltaH4Pw0msiQWFRIyBSSZfcyGgTaU/Mjvw2AagCoi960mHAjT5MMPwd+GqlYyPj1miKfmEn5DOUnU3HPvCRiLjMD0EwkoDyq5TRJY1gn+Rw3VEfPAvbVJk5I1SMwbaqNQ0e4xpYgoymt/Oga0oXU0nRfuKlMf1N7ZvrTYaqzArim/MZDCN5o2wj1rEtZS200gGvU1M/VdYQuUJOENSBQ8KpuTRoueMPGEjWkU1XZHxiXYBOiVG9TDpwUiYqMZVFalU/ezfazMRhfdpkivScAaR/Tg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB9745.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mOvX30Ih16Sk+/HVfhq5juDYcHwYUiLaayYe7a+bF/0in0o/B14yNx84FSuh?=
 =?us-ascii?Q?bgpJVqJwjqTSdTsFbUct236vS3Mi8r/yW6PtPW7nofZ2SDYjWSF6JkuziiCy?=
 =?us-ascii?Q?DLy+lASHtyKrKb+lruq/2dSUNam/H4bozweNSNuy1WupNyNMJ+6fcEons8iM?=
 =?us-ascii?Q?Y2w/DaNVPBaKOJhb/v8Mf/iY5i/gNW1VbWwpD89bDf56YeJqWbFc6X0QRLDA?=
 =?us-ascii?Q?YNsYG3HmwfcHkjOJYZqZBRJdWjzF/+ysQ2ypeGjKzqwCGr0FWn3+v3+M+1pi?=
 =?us-ascii?Q?gMmJY+EU69yUcD/X4zI7YlNN1/gCJP6+l4a+RNcM64entZDltd5e+LkPTpvn?=
 =?us-ascii?Q?ZTFlW/AAQCFir006UVcusX2iYf5r2ZHpYQy9q86Z7itBFzwnYw96A2dNydv9?=
 =?us-ascii?Q?T+hMrC0OjgH5OvZEbEZn1ChGFpLg/QOfSKm6oly2kfI7ulYhqsfBthS5WJU0?=
 =?us-ascii?Q?jZATeN89u3XebbBz6XGrzWojdIVC8Tyh/ir874JnDosFx/fzGLUmLdiLZmXd?=
 =?us-ascii?Q?D5vNKK9vSMPWaU0zRG5YH2szLu3kx6x5ZtTlHdhG+dX1HX0Rccq/6fkB/Igr?=
 =?us-ascii?Q?F7BFndELfXHQpKAupzln4tJqu4XQwbPXSezr0eCWBeGQZyyVgjCCn1dw9pMT?=
 =?us-ascii?Q?dA+ZNHdlJU4M7y6xSzRuxcgwaqyP8qxcHg/DCgABQtwm9Bdvxdpgx4Az8vyk?=
 =?us-ascii?Q?YQ6LWfd50zCiKJYJ6/AqRxuPs2PCdo731R9CST7035niaKNpYg7ExDYR3TDB?=
 =?us-ascii?Q?MZI6gPzKVvsBCrL+1/Ha0Gz1XzZw63mivcYvkdWu/7XzoJrlkMR3VDC3PLi9?=
 =?us-ascii?Q?3ykkBnVAD4tN1ZvHfJPUQUUadmtZuwOGz4UCU/g2nShO/9JH+Xl9woK1kuQp?=
 =?us-ascii?Q?KADVBEUWmVUB2GXD7sg4Mhh9WIhjFe/lpwJqeajfGPCouEssSn2ouJewVRR2?=
 =?us-ascii?Q?jc7f6fRQktOOWya5fBOJBEyIMHA1LcQ+m5hXoSPFGHd3GFLUx8mntw5MYlqY?=
 =?us-ascii?Q?Aoi9JDCRYtZYmeh2h4hqpGYUvQ4uYGYb3JrrIYZ/otsUvyN1tCKiMWJfmNzP?=
 =?us-ascii?Q?K7ioJGmbIKpHBdfeQPIXXy2fXHjOwQwPUY2dGxVO15JTGQixTPzAOoklTi0B?=
 =?us-ascii?Q?fe2kdSLXhvXKMqVGRetv2jsTcTxi+PHQBxAduraQ29NQgQcQ5c3inAVffQhx?=
 =?us-ascii?Q?EbwAu1uFnGU4SRF56JhDOIhZ39AdnZOIn8A+xXMxwS7oJ5+dG7QEGnCwMb9H?=
 =?us-ascii?Q?uwxOKFZxbJ3L6YGYKBNf/KWO6YEU7eexPodR7QLmpq7qAgSJZ2rp3PG3D3eu?=
 =?us-ascii?Q?XZ8B6bXZj/C5Kpkl0DJs52AHNJmVsuCbYgpV4+xeZCpdQKUaZcOxt6fROb5s?=
 =?us-ascii?Q?Uv4rNtI5cLyfhCCXOeYZj46BfAkH5lPRpuGQjVPIiUufGnmX+anb4SlspRtG?=
 =?us-ascii?Q?v3BX3BGramrkUjQuMyqqajN35d1IhSliipx0Yb6U5erYf4YIboXfwYiuWimn?=
 =?us-ascii?Q?vo48s77tBDtOGU4ep7M4DKLPREE2UESZNX7w2K19N7W/Yv+K+lS4MeXxfku0?=
 =?us-ascii?Q?h+T2TyjXHaCBCp1emsjFpIuY2skpHSO4ml4B8sRJPM4dcDq07L13DYDaHrvV?=
 =?us-ascii?Q?w76OUIFizhKNFoVsjpCH0pv1X9n/HSSq2UaD2Hma3HhY0R2oMvJxVJUNvs/n?=
 =?us-ascii?Q?33cwBMx1aGH2tdAwbEctcKErpP8qkcVXarA1/yxGe6RIXZ3ec/bHOdqA1Qjp?=
 =?us-ascii?Q?jioe1npdEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A2DFA8FBF61DE479F5D38300D85E890@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	t2uAiSPrT8uTCy0Uf2U65ZavUy1hkvYFgkzHsc3xwoSsc8ezfmiCIug15HUplo+MKnwKO2ITnJnSMza87XdDWQAvune99GSltXMnEVXpZDbsH36v26I23yeU3zhsJBKiy3kh3G9HtEiztAMA2uvKLQt2LTT6mSix91zLWIokCqSccJw9ddLYSRtrogCKU/J5ee6WXQerSDfoExVqdfkoCZ9Tf9sSIilA0NgjN225JnQGJD+iexGytzgUimQcZTqLWVVD0xyH3tEQcDlO3WyO3IwtX0IeYCt7M1gACNsf9NyPl7ja/at1zQtk/VyuviG6Va7UVW3LOctUAl7gTc3TXA==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB9745.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f720618-dfc1-4b84-b056-08de7f8fbc85
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 17:00:45.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1S3QygT4Z7675DWL440dVxy8Qs2fevaGiUBi6hpGrWkiG7X2ZmtE/q2RfrbYHMWb++3+OVFeS+9IbcVvbBbWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB9912
X-Proofpoint-ORIG-GUID: bnDm1O3h1PNUPK90Mi5jggwe2YcEXdaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE0MyBTYWx0ZWRfXyxMt0ndKyoVx
 1J8nsGlzrpHRYfrQwqK6pI8QYTqTWkXgg4wheqTorQsXmTWIKpVWD3SeSD1yIpQdZHZkDNzfWFV
 zvQbXg6kvTz0g08tlxKCZxr1RJMTrezUoJfLOE7Zf32slHQv2fskdNQXe3/Fjq7a+UTBJffRsgH
 AvFHHnG30he+zYGj+l5QnH83RxFe9Pr/CJF/zk2Hcongkm0jcfIN/ASYIngkVkBnAFvd/mjFcY4
 XDjiKjpw5VGoHApwtX70O85BlcnEh6NNxDTLU03UQOwHZG4gRb748AdLMLbiMJjMT/Sr3K0jThh
 YH2OXB9L4IzW8KHK54E6UbHsrbQtTvYBiv3vPfiAIdjyUKQPeeQqY9V3gr+yMOYMG90fOmGGvFM
 p9iBzbxc5A2wll6WQQRE9Jn18ctyAXJOVj+fYOHWlQK0hybuEMgBRFwoAKlvUh4A3o1oLTE65K6
 nLImG+OGLEpS7b6LqsQ==
X-Proofpoint-GUID: bnDm1O3h1PNUPK90Mi5jggwe2YcEXdaN
X-Authority-Analysis: v=2.4 cv=Xob3+FF9 c=1 sm=1 tr=0 ts=69b19fc1 cx=c_pps
 a=7YeuQJ2t1o+NR7xo1DCA9A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7vL3O5uBSuztJ3xaqtyr:22 a=kT44gYg0zFKYNBFEzlFE:22 a=QyXUC8HyAAAA:8
 a=zEbuT_0w3zmnzz-ZSFMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110143
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[juniper.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[juniper.net:s=PPS1017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224736-lists,stable=lfdr.de];
	DKIM_MIXED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_PERMFAIL(0.00)[juniper.net:s=selector1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[juniper.net:+,juniper.net:~];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makb@juniper.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 015A52683FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mar 10, 2026, at 3:25 AM, Andy Shevchenko <andriy.shevchenko@linux.intel=
.com> wrote:

> On Tue, Mar 10, 2026 at 09:21:48AM +0000, Lee Jones wrote:
>> On Fri, 06 Mar 2026, Andy Shevchenko wrote:
> ...
>> If someone is going to do the work sometime in the near future, it can
>> stay as FIXME.  A few releases isn't going to offend anyone.  However,
>> if we're just going to sit on it and this is likely to be here for an
>> elongated period, it should be changed.
>=20
> Then better to be just a NOTE:.

Ok, should I raise a v3 patch, or can this just be changed when applied?
I'm okay either way.

Thanks,
Brian=

