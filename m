Return-Path: <stable+bounces-233942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA+oE0mD1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:33:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C43BEDE6
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E8F3017C04
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933F38F253;
	Wed,  8 Apr 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Bg02+kQX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392D27EFE9;
	Wed,  8 Apr 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665910; cv=fail; b=qhzZGM7I1U5/TQOqUoMr4nMWL/b8JIoTodG+tBqVCYtbV8T7hPP16pcAt279DJK9HxI+ezKmxcfyxnRAAqQOHxY7QoGrmaiKiMkZv4mVZ38/qgcB/dubJgAtzu97s/GYu2aFK6v0BNPrGrlweax9jNO6AGMkCKnxGnXKZKUrdo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665910; c=relaxed/simple;
	bh=xFVZ80iaHQKiVstOQAm88JboApvDwIzVMZj9FeRoH/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AG9Ajn/VZZgcMnwU/JXBYA2MaY8cvW+HDCS64tpovp924vumt61tt02J5vTycHbt8nrrpOTa/B74MeWbcsMdK+PccWDYWHnnJkWQThDAyhGM4V9O9fRuQcbdXfeRX0C+4d0+OA+qSxx8k/osjyJJPCQ+736V40+Vm8hZicLDrp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Bg02+kQX; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638G39vb1580619;
	Wed, 8 Apr 2026 16:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=po
	AhrdTIKYaqxWRBWLJStll6zaxfjxRWYtyC7iUC0Ns=; b=Bg02+kQXY4VWEEWCGO
	WRkDJzzNTeew5LJwrGCMOE9QmfJpZCSgr4XJ4ne8odfL6O4Bend7j5jrq6CCLIQC
	uGzE63zMkBm3uR0NcQwoyvRqQo7lD+4+UwddJBmSX907cHR2HH2TPmExqcLjquRk
	cauO6Jbfq2t3IBcotHJLv8m598yKyohKaFcxaOMn2+h6iX7JnXJqssqe/ZvIR0ed
	3/QjRzjtHBWz9cdAacdBHf9JQF7G92npwE/mH3Nd51iTSnhwaEENEhcXSzPEIvJS
	EUG8p7eWGyugjYs+GdHBMCwZG1g5i0M5JlB9c3tqnO6c+azltqdob61vDYXqp99R
	d6EA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddjtqpeba-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 16:31:27 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 4BBAB801709;
	Wed,  8 Apr 2026 16:31:27 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 04:31:19 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 04:31:18 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 8 Apr 2026 04:31:18 -1200
Received: from DM2PR0701CU001.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 04:31:18 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LV9UlqDNDl4TP6pi8v3GlNJuyXbhh2mHOwzCuUcFmym0GgmT193TvLS/8AYIyytJSO2UOjEwIFjsUSUvyzNaYBzC2Eu2uKnHaVYTFs2jj7CYQ1UFfhNDC1l+/S705iovs5lGacifkuB0FPr0RKRzXqSU+yu2axjLcbHPNKyuQSpQIdTSW5DpB4YFtkB9fGeZmCBPQEXRBzFzKScklFyx5vJzxPijHYFH2eJX7jukvDP9oLPN7vAEL3YaI75uZkkLN8L79i8OP6BxgAZeXEhGevJGyf9A3IcO5xyHkmvus+TMWjE+OKyrMyxo+b1ehYD3x+xwNTYkLuclHCLUd5D9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poAhrdTIKYaqxWRBWLJStll6zaxfjxRWYtyC7iUC0Ns=;
 b=tF3lMREz+qiqCd7HIarX9nWDxGGF2vah/FcZ1zwURpGjtP3Q3nbGdlBQKKC2miKUZxsN7/atQDhsinE/0LxdSoxWMiHC/6ba5CEdcs0xOOGCW1vmaQolwNJhcVtyAUpc4BfaAGoTiHcqA2tB0PNp+8uhqaC0WsLKxjVWhMEGptpeM3P10tkHFo+1apt9+SLamI5B/eGx0LR2wzQXX0vODXHiR6OoVH48ixyFlSDKGh1lBACPuC1fv8bQEEAY0IQaO9DeRnLjYRH9SrcHjYkTECsa4P7gftB05sxo1IAFYeWHaZMUp8gVFLCCuQ5Vlm7rQiFIQYh0TbLod72tge9VZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV3PR84MB3528.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:218::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 16:31:16 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Wed, 8 Apr 2026
 16:31:16 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@weissschuh.net"
	<linux@weissschuh.net>,
        "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
        "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Topic: [PATCH v3 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Index: AQHcx3UfFTkQtKPOGkePRLU7GVTHFQ==
Date: Wed, 8 Apr 2026 16:31:16 +0000
Message-ID: <20260408163029.353777-3-sanman.pradhan@hpe.com>
References: <20260408163029.353777-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260408163029.353777-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV3PR84MB3528:EE_
x-ms-office365-filtering-correlation-id: 5429282f-0749-4a22-07c5-08de958c41be
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: WK9VcuFL7GisRc5ucpkM7eHT1Wx/mmLrz9BS8iKKrzNMfSK+yGaZ/v7ksWAsMrj9Jt7KqBk8pRjdl9+s/w4g17PlDzgGLDkRTbeOTLO74owACjLv6l41bYaEliMlokwfDjZEpXawj5eKJDvGa/OUrs0WcGk6fq6WFGLNgNbUuo4LvPnRmVrzh+HO2nmo8pegBPm8etLQWv7PtCPjoX0bNqCuKuWW+UWSwV3EvHNiw8YTXM1ic90mlhAQgCTcuKOeQ3s3cKuno1sIDXY7s6ifCmUnQcKbrp2LeAZSspTgNy9TOxRRZPzZ29zzRjy6VaymI9bFj5HgzeWiSjp2281L/sNKQcHxKJlDz2uo3Dffhzhpe0aD+NRnzoNbOxscZpQoassfo5DJHniXAsShE1FWmkrHsettxMdKdeyIOMm+YYvArYcnBchMsxM6KcXI+uRmIMk6caW01MofYlrR0cK9ZOs8+CNPJO8B1Au2vX9gIWb7xsD1m1j0RjN/gpKcxZiPUfc81ujNj1CVfe+Qln13QP5Dve8hSv++se7nJTUjb/PGOCSB+6LlEZuSeZpz9ZAIiN7Ezg6tgsCgKBDwwCZY2HtZ+ZDVwyyyCNH6YJaIQ/r2phM8+h09WHQ7HkzbvuIvT9Rm6e2zlESZiZRgr1FVmlHMeqUgxNyUZ9h7BQ6iidq2CoYqKnQEMR90VBmMzw+JE20RPHtrbfICPkVPJ5vYvPqvixkMv6Q8MHGUFdM73BygHHEN4iGEWpmflh36md2uIQUKHhqF75df97IxLNlVfLxEMXWYLTCasXiAxh7YdJA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j9dwOnzKdDFXR5fXHezFPGxKP+Cx5A0bK/uXxBYzZCO7ofdJSrjpE9jsxI?=
 =?iso-8859-1?Q?Cq7G4Blcr9kVomtmvKujXXLVEdVX+ylbzLO67tgVlcv4uucl9IUDm3d/M1?=
 =?iso-8859-1?Q?HA277XGtSkjPfDDvJGyvXojpfp5o/WgIBng8w0pYqbjZDyKdFrZE1vb+hy?=
 =?iso-8859-1?Q?oE1JsmP+X4ZtAHNWgbA/FLr/S9Qay1HBGY14Fe52wcD5K03MKv5c+BUFC1?=
 =?iso-8859-1?Q?iMKhY8wYnWqyr5aWmrAOkP/aO6AGexBg7O8fpU6wlJGDfnwPdyBu2UVtes?=
 =?iso-8859-1?Q?c97d+GbWqrE7tMvFHjfmzl2EF1SLcDMUttdmRTN3Jyyd9vExnpIHJ25GL2?=
 =?iso-8859-1?Q?VBImp6bcH8p39FpqUjgW4Fm3QXAIcqetm+ibYcisLWF3iKM6zNxftm/nxz?=
 =?iso-8859-1?Q?L16S/AeMR+G4T6VLrKwLjmQRaBhrEhv0yEu9Zmc+SbUfw+5TiXngQoeSLD?=
 =?iso-8859-1?Q?cHcxrwcS1W286YVMiW5U9opNksvm+ggosQhS2ViDso8TxLrQN8kjzfVKkS?=
 =?iso-8859-1?Q?+H3p2Vrg65MIMoeAxfIpGvrft/hUBfurB0EftEO8cbUptZpC8lb32uOrmG?=
 =?iso-8859-1?Q?u1G/Z6T42ycWpfcv8W1+9B1ncTKf9b4gCSz+GU933Lrg9eWuta9zNlsRKx?=
 =?iso-8859-1?Q?50QppNAaS2z6Q7WJQvOQfctIp+XCK+OtFdbMJclVkeaoNBjUJL3N136BOJ?=
 =?iso-8859-1?Q?868vq4jAw4yRdDjrMDsI6CHI767UDZgm78kdQIp/rewXEAjwGRdwIdK8hL?=
 =?iso-8859-1?Q?79nC7rT4tKp6kJoB6QtkaQdn4itMrj4eVfj6EimUKHO/ujAoqdtWib71xU?=
 =?iso-8859-1?Q?HoKJsrX7m41RZLVbboK7bQsJkFKhZjIEjzQtg1/wZZtFt2tHDgbCqP5e3L?=
 =?iso-8859-1?Q?1vtZu9I/mWFYELmSNRbP4mS5FuhWihlhqzAbpuwQqk8VgFg2F8Ci9OD9x3?=
 =?iso-8859-1?Q?x1ekjA32CjHLEd7Ll+7HyiaDWMOIk6Duk/I/xH6sCdLpq7tv3Q47vVVYMH?=
 =?iso-8859-1?Q?JboDJt/uNDbgJ83E9jCNjwIFDmpy5Ej5LEcrAy49Um4Nma6pw9SyYCUV+b?=
 =?iso-8859-1?Q?LltrJhS5nZJKVYy/AlYi97/QmAoiw4DjPTNl7GpQESj98cBCRGoJGPgtIh?=
 =?iso-8859-1?Q?nS9yr45nliIVzyR0M5dIBnRCMykRArF7iWD/gPnJDChtC4sgk0tBZ2VLMf?=
 =?iso-8859-1?Q?jY8vfzYZx+ZluEWSDLHkCkwMUJCgXC612w5NDaM6/ylnfr4IAKTgJO2cVa?=
 =?iso-8859-1?Q?AkgImwEBM9bQRZATp6iAlrCIf/q/Sm2GzlIxaipjrLHVAQ1626P7UUEwor?=
 =?iso-8859-1?Q?bl3R1LUgD50eipzMiMWVkhoTo2bgRlBj96A6n4CrdSlmkC4l/YjMCXBS5n?=
 =?iso-8859-1?Q?QfvY4RoJGBlWIidtn+M43DpYKXaZaMV116ETwXQa8IEuaKjYIvP5lYO8X7?=
 =?iso-8859-1?Q?RXU7Zprh7EBigqPau1/A9eKgkL+pdxNTHu53UYtdyhWY4D+SPzI3rEbbPD?=
 =?iso-8859-1?Q?FAmJ2EOM/7CYq9Jh9JVso6mCj+rWnNzHcdLW2vWwzhAqGMdUU8q7wY3Sgh?=
 =?iso-8859-1?Q?pklpCvxy5NBkyzpWnE1/ePvRerd9P/MBwbPdnmumJfhi51WkZ6EnkJPFyQ?=
 =?iso-8859-1?Q?bwGPVR6aK2g+F9LfVImu7yG+L0hAXR2h2lUvpINkZU1GldpAizdYrEncs2?=
 =?iso-8859-1?Q?rNH2Mz16NR+gvEXdxW8Yy4Bh1drr4MjGAnUMK0Rxrt2Tv4zyzdE8a7QRW4?=
 =?iso-8859-1?Q?xLKn0jRvuXugCov56Kh8pKE23F+B53hgmRpxqUoPtoxnxE9OyBj1BTPRS+?=
 =?iso-8859-1?Q?VtVs16YHgQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oxfK2dPcFgv/3CKedTE15ZCAHJMji762rcLnPAbiNoQOcPD7JkoQVYwZRkTxFax8QkdptqzOihPt1rx51jZR4MYeQlxJzal1kROzxgv3Xg3k21JNjgkS25r9PgzRXgBoO5vVIEyu0eDJGOSHylcO+s0zJZDjSBCYU1h3YcKCZpDFfjDwEv7nVqJpGL41NVO+KJPpVyRyD+dE3xtPFjotXn5cpWQ5f8MdUwi4lTjDI8ryjY56rNPVety9nUp6aXjTDL4H/RRhmLcwnFkioqdEN3ptss+c0Q52Zw7YFXOTkUvytcvdx/y4Ul/vZ1lM/caf+ldYoPdwegxqq7pSVCavDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5429282f-0749-4a22-07c5-08de958c41be
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 16:31:16.4033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7P6ZKxJL3HNG6ONSiYTB7AjvDskrAkvDUzERLUVELeKkObzWtA0H7eBAL4JLJWdS06+g2p4FIspwk0FOjpCrvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3528
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=Ud9hjqSN c=1 sm=1 tr=0 ts=69d682df cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ZSrvDirOKP4VPF05hnFf:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=X0MvGafI_ScwdR0_kv0A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: DbEkgHZOZvWBdvwekBu5gFqNNOicAgpW
X-Proofpoint-GUID: DbEkgHZOZvWBdvwekBu5gFqNNOicAgpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1MyBTYWx0ZWRfX84SDjDwg4XOS
 RS4zd91ExsHQV9rp2D0n6J70Ib89X80hDoA5hnhuaBLEihLAwhud9cLiU5KR8Qm2zvw6WhxDPbE
 ZJt8kO8ERUTrj9lihOjzsEc2cXticfWlMHsP6Skvlme06Za0yhleMGti5GZu18zTUuA3A1LOHbg
 dcpcnNp6STaWcxD1kmZVOcgIxJ9CcWXviE+0fF6JoUfgXDwEbzvezlOIHVNb2gDuJPFNiyss7CH
 zi5Ifzse9mzOtYpnRocmn13xd02xFCufPMh5a+i13WvSPf5+2sHizSyns4V0q1oRuq6wNkhpRDu
 iYAapRjpPmmkkIMCjA10vJ89YXUTiPnDaqmPkUocMi4g3ZETJHOfDm/RJtYghS+G8cGyazvI9GR
 25yPLwb/dl0SxaCcjf5LT1/mcH2J1FIIca/BwsG/jck6u77lTJCB30PTktKfF29lnKoaAL9HQqv
 gSVa59rh3/UkJ76K2cQ==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080153
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233942-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[roeck-us.net,weissschuh.net,quantatw.com,carsten-spiess.de,vger.kernel.org,gmail.com,juniper.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid]
X-Rspamd-Queue-Id: ED1C43BEDE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
isl28022_read_power() computes:=0A=
=0A=
  *val =3D ((51200000L * ((long)data->gain)) /=0A=
          (long)data->shunt) * (long)regval;=0A=
=0A=
On 32-bit platforms, 'long' is 32 bits. With gain=3D8 and shunt=3D10000=0A=
(the default configuration):=0A=
=0A=
  (51200000 * 8) / 10000 =3D 40960=0A=
  40960 * 65535 =3D 2,684,313,600=0A=
=0A=
This exceeds LONG_MAX (2,147,483,647), resulting in signed integer=0A=
overflow.=0A=
=0A=
Additionally, dividing before multiplying by regval loses precision=0A=
unnecessarily.=0A=
=0A=
Use u64 arithmetic with div_u64() and multiply before dividing.=0A=
The intermediate product cannot overflow u64=0A=
(worst case: 51200000 * 8 * 65535 =3D 26834432000000). Power is=0A=
inherently non-negative, so unsigned types are the natural fit.=0A=
Cap the result to LONG_MAX before returning it through the hwmon=0A=
callback.=0A=
=0A=
Fixes: 39671a14df4f2 ("hwmon: (isl28022) new driver for ISL28022 power moni=
tor")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v3:=0A=
 - Use min()/div_u64() one-liner instead of clamp_val() + tmp=0A=
   variable, per review feedback=0A=
 - Add overflow justification to commit message=0A=
v2:=0A=
 - Switch from s64/div_s64() to u64/div_u64() since power is=0A=
   inherently non-negative=0A=
=0A=
 drivers/hwmon/isl28022.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/isl28022.c b/drivers/hwmon/isl28022.c=0A=
index c2e559dde63f..c5a34ceedcdb 100644=0A=
--- a/drivers/hwmon/isl28022.c=0A=
+++ b/drivers/hwmon/isl28022.c=0A=
@@ -9,6 +9,7 @@=0A=
 #include <linux/err.h>=0A=
 #include <linux/hwmon.h>=0A=
 #include <linux/i2c.h>=0A=
+#include <linux/math64.h>=0A=
 #include <linux/module.h>=0A=
 #include <linux/regmap.h>=0A=
 =0A=
@@ -185,8 +186,8 @@ static int isl28022_read_power(struct device *dev, u32 =
attr, long *val)=0A=
 				  ISL28022_REG_POWER, &regval);=0A=
 		if (err < 0)=0A=
 			return err;=0A=
-		*val =3D ((51200000L * ((long)data->gain)) /=0A=
-			(long)data->shunt) * (long)regval;=0A=
+		*val =3D min(div_u64(51200000ULL * data->gain * regval,=0A=
+				   data->shunt), LONG_MAX);=0A=
 		break;=0A=
 	default:=0A=
 		return -EOPNOTSUPP;=0A=
-- =0A=
2.34.1=0A=
=0A=

