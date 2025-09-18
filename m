Return-Path: <stable+bounces-180569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A26B864DC
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 19:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC58175D94
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87EF31B133;
	Thu, 18 Sep 2025 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CdMOEMxm";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CdMOEMxm"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020110.outbound.protection.outlook.com [52.101.69.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DB319601;
	Thu, 18 Sep 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.110
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217243; cv=fail; b=IeMDbT2cQ9DtoBsSJw9VjiJgKdp6sFXeP4BvxpknySJiMyN7G6BFPzpuccrIlnuzacHTHuMpVOjb7ZDowNJkAWNuFgrqwWc8MjhhpMdSDUaS1Es/yA6wNErkcEvfN/hwKG76lQSado++cOfZMriAeQmRMmVnU4+8KTvos53lhHk=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217243; c=relaxed/simple;
	bh=1vA/rFGng0Ysrft19Mfp9rwjQbFA0x8TDGlqvtMV6dA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oBDwigr0vkL4XV1seydFAOOMlvyG1i4uuIY667RH/Fa4+dT/BtCIOsCwbqjt6udgAkSsk4Plpr2slx8OrT82h5PzAMlNYfnp0dUVoMgIOeRAlytqR7w/9Ru/c/c2YfcxCIM+7r2zsyaCp465OyOs7AMWSD+2wi3WkiWbSI79yOc=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=CdMOEMxm; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=CdMOEMxm; arc=fail smtp.client-ip=52.101.69.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Tjm4Yh5JFWKctpvCnVh4aAtc9RrtyIsP8gbPYEthCDf0jn8tCCK7r1ZmOlQ48nWx/FtuCJC40S0Xz5S7PtkHVThyhLw+8DvzrzRSDcSB0hLnFK/+hH5W88xGZUbATdqQsfhac8bSflDbzO5RpZeNUHbE5guUg6Vak9KxqAubI3WKDVTOzd71284mMMVKqZkxC/151EYh/OmdgiLlM+5Q0+8lX3XOJE0DrNgsZmMBrEORkdKQdWt65DZX4kQeP38URvP9xSzuDHE4X2AXPqWeALUyHSwGGL61fN1+UTFBNxdj6YbyusrGEMR1vX9pisZdfAlucdgo60gxm7k+q3GArQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vA/rFGng0Ysrft19Mfp9rwjQbFA0x8TDGlqvtMV6dA=;
 b=CnQz3R0fd/FtvPsEj9ssBazwNqXajNWB0F/IxCBf2VPVkX5Upm0iM4zgqvWwrY7wNDdMVX2cHFPfL0eu42ON9YkEKbEGaO+/0zsfqFxa7nW+QIXz7rantBg9+5wncZ2D42hXX5SkdkgK1e7RotH5BVujRHSKHs+5fgCPnwgMLr2LTW1bc6wIrcZI9SiFGKBbseJVuRkSZHoHTojcvu//tueGDtHeT6oGIBh9/EYc3NG9HyOJut/hpS7pkdIsGLtdLHsv30stVGo4mNwxdtpnRlwV7ZWSdkVJ9I18E8cHBAAM13WwYCc6iN20nj9GcO9xTqG5w1Lt+O1UHFhSAHWb3w==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vA/rFGng0Ysrft19Mfp9rwjQbFA0x8TDGlqvtMV6dA=;
 b=CdMOEMxmg2g9XXdQfy5rlturWVntDHGi2nqNPjJrT15und9++nMr+b9GIq3VcJ8s41fK+uFRogbY0/0eQ3lCKYzWlMXu7mYdkpNqlSXTEEN78oH262842ZyrobQ4rhj6/KSNpWiJLMMgbTv6n6YkoYekbycVrWwaZRa2VErKuKM=
Received: from DU2PR04CA0227.eurprd04.prod.outlook.com (2603:10a6:10:2b1::22)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 17:40:38 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::b8) by DU2PR04CA0227.outlook.office365.com
 (2603:10a6:10:2b1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 17:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 17:40:38 +0000
Received: from emails-9600462-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-207.eu-west-1.compute.internal [10.20.5.207])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 3B2687FF21;
	Thu, 18 Sep 2025 17:40:38 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1758217238; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=1vA/rFGng0Ysrft19Mfp9rwjQbFA0x8TDGlqvtMV6dA=;
 b=nzI/kwMqbBM6bdzhCZvWebrbzW5P4F44uB2QFcldh6p+P12+ZpMbJPov/yCMMTWqFWekC
 tUUUS7Tls8Klx1N6vX316ddbv0fQtooeophrQqWFh0Rvw0GDDGvr4vuamEbGAR9Wu6bQPxD
 EVF7iBqT8xSYIOitmvJN1N7KocI09No=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1758217238;
 b=J6DmChjjYkdhithS0KLiPexbNsLtxq9Y1oD0LWJnSfWvqkLt21WkIr2tWeNN7lFKhauE4
 93anZz5pPg0Ig3MU7pm1WkoBj2neq3OnMtf1G0psMaLbj0ZqdgEVovXGDY8QOPrpFSk4J1F
 I0rLv5PXPN4MgdWWEa3uYXLdzQhc53w=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXjswg8V3XdoAYBz/BSUzV7aIJjEBhe8PmPm/xutD/s1RpkpfAf43u+wWrZIsjCgrqvd0sUNx0t22l1Ev33F9zV50yf5lulS6DooGJl1AYjg/iqEkPfNc8/i855nH7vWzSe04wo6rnwlAFxfhMAEuO15QTKs7A++OASWA8JUt2XHgTfcaEQxZ24ea6/LZc4QU//lVl6a+gr0Sr8gNGz9ub3v0Wl8EclPLoqpvkC9givS9hx+CuJGOdx3FQFp4AwZi7vwBS7poUkJZpJA545PQtxHdZ5z9qh3jAHS16vVKYTo4d43jhUkpadMMor7xngMgW2e50WE/pit7gmGQZTuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vA/rFGng0Ysrft19Mfp9rwjQbFA0x8TDGlqvtMV6dA=;
 b=b6yS54g0FbT0JCVJSQWnYi4rPSBYqO7XvpSyOcgm2C8czHV7X9sEnaVjOo2thFNBP08rshklVwKDKYbjvDZMOZGKXhFOu5Zvh7HVlGHiiE166ba2dQQ813ln1IJZ+DnMeE/yqHOBdzf2CnzKroZ4JrnGRLE2S40MaTwEmKkZmvLEbBQbTDav0Pfb4nngTrIJUTfUEAoMmYiQrxGmT5wwR/eYFlRoxX4THCw1PkRS74cEObmYXSYYtRu8odP0bZWuhkA+Tb4u/CSf2f0C3g+79Wr1lz97NgXfNewsrSJpU+nn17cA2C04rjlXLVuo1ubH5tICgyw8ZTYoHnc8ruMS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vA/rFGng0Ysrft19Mfp9rwjQbFA0x8TDGlqvtMV6dA=;
 b=CdMOEMxmg2g9XXdQfy5rlturWVntDHGi2nqNPjJrT15und9++nMr+b9GIq3VcJ8s41fK+uFRogbY0/0eQ3lCKYzWlMXu7mYdkpNqlSXTEEN78oH262842ZyrobQ4rhj6/KSNpWiJLMMgbTv6n6YkoYekbycVrWwaZRa2VErKuKM=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI1PR04MB10001.eurprd04.prod.outlook.com (2603:10a6:800:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 17:40:28 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 17:40:28 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank
 Wunderlich <frank-w@public-files.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: marvell: cn9132-clearfog: fix
 multi-lane pci x2 and x4 ports
Thread-Topic: [PATCH v2 3/4] arm64: dts: marvell: cn9132-clearfog: fix
 multi-lane pci x2 and x4 ports
Thread-Index: AQHcI0ngX3qW4F/IsUCKxCrOhCtl17SOi9YAgApAcYCAADjyAIAAAmMAgAAXR4CAACEsgA==
Date: Thu, 18 Sep 2025 17:40:28 +0000
Message-ID: <8a092724-c3e6-468f-9fd8-e4cb7c69438f@solid-run.com>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
 <20250911-cn913x-sr-fix-sata-v2-3-0d79319105f8@solid-run.com>
 <9272b233-b710-4e57-b3ff-735f45c03c74@lunn.ch>
 <dbb10e82-ae10-4987-900b-17d4f4b62099@solid-run.com>
 <dedd4222-b2ba-4247-98b4-504b5c032f69@lunn.ch>
 <eab0cc63-de1b-4b41-bcce-7a2308d4f446@solid-run.com>
 <2589d2df-8482-4648-b63c-5a4a86f01fbb@lunn.ch>
In-Reply-To: <2589d2df-8482-4648-b63c-5a4a86f01fbb@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|VI1PR04MB10001:EE_|DU6PEPF0000B61C:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 368529aa-cc1a-479b-8cf9-08ddf6da7b0a
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VGxMQ0E4Y2NBSW1kWHlIbklEV3UxcFhZdytCdURlQXhQNmxJcVRGbFF2K3Zr?=
 =?utf-8?B?MU5DUmU2V2ZTYzYvZW1aZXJJOER4RjlOWXZHb1NtSlNIT1ovZ21mem4xcUlp?=
 =?utf-8?B?d0VheHVyQjk1QUpoc2N1VFYvb1FCUWRkT1paSkl1aVdSdi9nUzA3T3htZjhM?=
 =?utf-8?B?dWFHbVNWdy8rZlJMMlN3WENhTjlBWWt5cy9uNnVkNHF4WE1KWDgyTS9tK1Zr?=
 =?utf-8?B?M0FRVUpaWDlNaUE4bldLcXhKM0N6RG4xTTQybkI2Q2tlTmMzcUhWQXAvZEhv?=
 =?utf-8?B?YklKbGExYWV1dHNQY0tGSkV4RzZvVWk5UXgxM25CcGtLTVJRdkFHNWlXM09R?=
 =?utf-8?B?NnBVZC85Z1c3dHArOTRTc1ZhQ0Q5MVlOYmJaNFZkOGdQdTJ0cXNJY1ZZOTBH?=
 =?utf-8?B?djBPZGhMMVpsdzdERHVGYjlVOEpOMUlJeEtaZWdrNjIwNDZhWkJYczBaTjBF?=
 =?utf-8?B?VGdHOEpoeE9udFVsalJKWGFsdStmUE51WDRZdERFcWZPM1p2YVNHL3FObUww?=
 =?utf-8?B?TnZYdGNVZE1TT3VoaHF4d2tHOTUvbEVPU2E5Q0g4TCt0b0daM3B2RW02NW9T?=
 =?utf-8?B?V1BpbUxGdkwySm55QU9kbzZRTERyK01oSmhkbXRRZ2xUZUhsdVE3RFppS3Aw?=
 =?utf-8?B?Tk1QTGlvMHhWVzdTOEZoL0p5NENDTHhleGRFK1Q5L0RhNnlndGNEUkQyemxy?=
 =?utf-8?B?VDN3azd2MWFMZklJbmtoNDVrMnpudmFZakphVnl0bGJ5NElDQlczekgxb0ox?=
 =?utf-8?B?QVdNajl6d1d3bVRuclBNMmZVNTE1N1UySklPNVp2eFNoVG5KVzNtQTgrekZI?=
 =?utf-8?B?STgxRy9pMWNVWVEzcmdsYnovNFkvOG85cjNEQm1USkxsTkxNeXBHeDNra21u?=
 =?utf-8?B?QVkya0RyOUhiWVZKaWtYWEFpUUtvSHVnK1JvemNTdWJaWDFkWXJrTmhQQ3Rv?=
 =?utf-8?B?QzZYc3V0ZFFraG9WRDA0VUdLdTA3Um1seTIzUk1TV2lBMlZFTmdaeDBmRjJs?=
 =?utf-8?B?L2lOZHNHNGd2M1VOdUE5RWp4Y1I2dnUvaFNKQUJWL0RZenRQVnVMUmlTTVo4?=
 =?utf-8?B?YnN6S1Y5cUtzWW16TndFZmlhS2xJZDNQU25rSXJSVWxEc0FVOEJBOWd1dTFN?=
 =?utf-8?B?ZmxwYXdYYnl6eFNYSzJGa0sxZkJPTmtEdXo0L1NReWlBcCtkcS9HZytPOEo3?=
 =?utf-8?B?N1ZLamhuMld5dS91ZS9VTjNkOVlJelNCT2dOcFhrZDlocHArV2o2U1JoRWhk?=
 =?utf-8?B?SzBEZ2RYKytsa0xhODFEL3NTd0dZSitFYXZLMTl2NExhb3J3V3FLeXhDaDZP?=
 =?utf-8?B?cmJDTjZrSlgyTlVBVlZtaXFyeCtKczdPYWdBYXVWd2RjNkxIOUZMVEFZS0Fi?=
 =?utf-8?B?MVZDSGJpSjV1OElIVE44SmVBbnhXQnY4dTBoTmtUenhsNi9kNm1lNHBuREdm?=
 =?utf-8?B?UGtLbmtGVWRkWFZiaGV6KzkwVHNXZjMxT0RwUFk3MWRETFdlVTh6dG9kTTdj?=
 =?utf-8?B?NUhCNFVyam1zbTg1UmJNelRKbDRzRGpWTnJEcXl1OUhWay9Kd3AxTS92UXl2?=
 =?utf-8?B?dnFzZGZGUWFFcHZjZDFGSWtkYlJVeUV0akV3eDBEbkVBR0FMYlg5TzI2K0RQ?=
 =?utf-8?B?Y1dCUGtxUURnWEJQOHlnVFRDODlBbk9aWkdMRlEzRktzRHNnbk5UK3NvMkhK?=
 =?utf-8?B?dWtpSmZoV0ZTanJDakw5TUE5eFBQWUJsWWk0TmJseFFab0NQSFB1a2ZkZFFR?=
 =?utf-8?B?T2Z3dzBpTDJmZlN4OVBuRU93QWpyQVQvRnFRN1NBNXZiaWxobnFxV3ZnWlNZ?=
 =?utf-8?B?akNxamRlTDRXU2ZKellvM3A4UEY1UEpWK0NWdUFvb2VqR0Y2UW14Tkg5bUln?=
 =?utf-8?B?aC9IVHNIcW9KWVhQSjZjbms5KzQwbjRwY1M0MWYwZEZ3Nmx2WW5JMFBpODlj?=
 =?utf-8?Q?UmYFxN1jA6w=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <04B418F8FF0C78478889F0D6209E678A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10001
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 9f7b28796f014910a2d7ef3e74b5bf12:solidrun,office365_emails,sent,inline:c53c0952b38074a019870a5535e394f9
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	88e2935d-f429-4f31-0f13-08ddf6da74ff
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|14060799003|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWhYMlppaGZ5WEpZQVgyS3BkRXltc0cxT05XOEp1N2pZZGhEcUhvYXF5L2tu?=
 =?utf-8?B?WktTTy9WdFlCSHlXSHhheHhLMWVENWhhTDhCZjY4UjI4QzZIK09wYWZiWUQ5?=
 =?utf-8?B?N2tpQnQ3NWgzRTlwKytNVWRaWmkzejlpV29uVndEYW1ERkkwOVFUcDJDeWND?=
 =?utf-8?B?azZIdkxiM3BzbEU3b2dJUFNMOVkvTlpHVXJFY0VKZ281b0VrYmdzUnVDTDlT?=
 =?utf-8?B?RXlEU1VhNE5QK09DdFNucy9pQXdFcmpvSHhDbTBpYzZpVmtBd2Yyd0FpTnlN?=
 =?utf-8?B?YndzQ2lad2FBNUJaMDBJbEJQMFpLYkVveW5FNWJ6OCtDRU41c25SKzRDTVM4?=
 =?utf-8?B?a3BXQnczV1BCaEZJQTcxTnF6bjFUSHdSYTJuWkNXcFJkLzc2ckg3ckRwRDkr?=
 =?utf-8?B?YVR4VVJJdFIveERXZi9VemIrQW90MFNueXM0Rk9TdjRsaDNRU3V2R0w2WmNu?=
 =?utf-8?B?UlhlMHVHc053NEdnbWxDWHRFdGxKLzBobWpTaFUzK2ZMeGJadGxMR04yUE4y?=
 =?utf-8?B?RHNDbkVnaFdUZ2pEUHR3bElXSTkvanBFazNXbUg5Y1hBTkF5OHN6SDlaVGQz?=
 =?utf-8?B?WkYrYzFmdlhXMlpxSnVaRmFRZkJEcjhNbEljQm0xOVk3N0NJLzk0WExVS0NI?=
 =?utf-8?B?bm5tUTlIdHN6L1ovOWpUNU4zbWtnZzQ1YXE2UlB0N1JNNFFqYi9iNWlLR3Zh?=
 =?utf-8?B?VWRWRysyV3FhSDBCTDFUbTlTQWZ4WXovQkNHWVpoOWhEVlFqdnlOUXU3MkRC?=
 =?utf-8?B?cFNFampWNCtwUUhVTzdkQXVWR3duZnJTTTY5WGVXTFNUd3RvakdhT1pFRTdz?=
 =?utf-8?B?ZlBhUW94cGpBWHZnalIxczlsSGxJVCszbFRHeEF3K3ZCZ1lkb2kxNklnUU14?=
 =?utf-8?B?WXFjK29aNXdqRzJwdk92dzEyZm1nZ05vRWVzM0hLRVc3WC8wVlBPNTBkaWJh?=
 =?utf-8?B?NitEV1hic2p5WmFZTmtJL3JrYWxBVGdTOEIwU1BhbEE0dDJZRnJ1L3hmRXZt?=
 =?utf-8?B?MXNhTUZiUCt6ZmRlOE5nc1A1OGhEelQ0cnVqUE94TmdkMWM5RWIzS2FBN2cx?=
 =?utf-8?B?VGlDOGZsSElpcU9UVkdKUDZqVU1wbEROVTBQMHNnQUcrZVNKY25vMDA3M1pG?=
 =?utf-8?B?Nm53WDZhdFBRbk9xNTFoTG8xc0tsSkZtRGw3NmdibXkxNmcyQ1dZYy9jemJp?=
 =?utf-8?B?RGlEdFRiVHRkT1YyQ3FiNWFBRlI5dGtsS2xJN09uQ1lxVGRQbHNEcUdrTzIy?=
 =?utf-8?B?QXNvZjhEektjRlNTNTdLaUhPbzhhT29xZTAxQmtQZWxOQTJndXJYa0RaZG5G?=
 =?utf-8?B?VWo3bzNXTlVaNWM1NStXQTBkaktHbUdaOHhCUFpXZ0FaNEFkVkZBK2RveUsy?=
 =?utf-8?B?eGF4bFVXeFJXUFllREJvaWs2NUMveU8wTHJEcDQ1QUp1N3BhQnN6dVkxUVd2?=
 =?utf-8?B?ZXhBeTJTSVhkb0Z1UXBYaFFWMjdRWjNKMHpoWTM4dE5yWm9saTVSRm9DclFI?=
 =?utf-8?B?V3NrME1LMTE3SFJGMjFweTNwOXR2eUI5dDh6K3hRcDBCVE04eVVpTUp1MWU3?=
 =?utf-8?B?Z1VVQ29HZzBxY0tzeWpnMnZpN2VjZWcxaTg1SGQzU0c2aWs2RW81UkMwWW1m?=
 =?utf-8?B?a1Z1VC9uUTdKeU1IQnpNZlJHUXo2NFF6cmxwNUVoQlNPL0syRUJhZ1NveG1h?=
 =?utf-8?B?Mm94cUpkZ3E1UVJUT3Y5TnczK3lDQnN5VFo3clM5ZHVtVDEyYSt5V2tudmxw?=
 =?utf-8?B?U1BIQWZ3SFpuMWdWZGYyRnoxR1VCYlpBcDBwSEFkeC82NTIxSjZLcHl5NFdK?=
 =?utf-8?B?U0lTMG1SNHdGK1BRV3pEQ29NRGc1V3VBbVlTbG55Mk5ReTFrZHBWZlhDeVNv?=
 =?utf-8?B?L1FEVG1RdytYRmt0YWl1U3R1Rk5nbFE4b2d1bm1jdXlTMld4NmU3TVg1TmlF?=
 =?utf-8?B?cEFMVVJNUVRXMzNIRFl5SzlQY0sxNVNmTWN5SUZwS2ZqTlFjSnFlMTc2ci82?=
 =?utf-8?B?MkRrMmxXK2d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(14060799003)(35042699022)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:40:38.3616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 368529aa-cc1a-479b-8cf9-08ddf6da7b0a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414

QW0gMTguMDkuMjUgdW0gMTc6NDEgc2NocmllYiBBbmRyZXcgTHVubjoNCg0KPj4+PiBUaGUgbXZl
YnUtY29tcGh5IGRyaXZlciBkb2VzIG5vdCBjdXJyZW50bHkga25vdyBob3cgdG8gcGFzcyBjb3Jy
ZWN0DQo+Pj4+IGxhbmUtY291bnQgdG8gQVRGIHdoaWxlIGNvbmZpZ3VyaW5nIHRoZSBzZXJkZXMg
bGFuZXMuDQo+Pj4gV2h5IG5vdCBqdXN0IHRlYWNoIG12ZWJ1LWNvbXBoeSB0byBwYXNzIHRoZSBj
b3JyZWN0IGxpbmUtY291bnQ/IFRoYXQNCj4+PiBzb3VuZHMgbGlrZSB0aGUgcHJvcGVyIGZpeCwg
YW5kIHRoYXQgbWFrZXMgdGhlIGtlcm5lbCBpbmRlcGVuZGVudCBvZg0KPj4+IHRoZSBib290bG9h
ZGVyLg0KPj4gVGhhdCB3b3VsZCBiZSBhIGZlYXR1cmUgb24gdGhlIGNvbXBoeSBkcml2ZXIsIG5v
dCBhIGJ1Zy1maXggYmFja3BvcnRlZA0KPj4gdG8gc3RhYmxlLiBUaGUgY29yZSBnb2FsIHdhcyB0
byBmaXggYnVncyBmb3VuZCBpbiBEZWJpYW4gMTMuDQo+IEl0IGlzIG5vdCBzbyBzaW1wbGUuDQo+
DQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3RhYmxl
LWtlcm5lbC1ydWxlcy5odG1sDQo+DQo+ICAgSXQgbXVzdCBlaXRoZXIgZml4IGEgcmVhbCBidWcg
dGhhdCBib3RoZXJzIHBlb3BsZSBvciBqdXN0IGFkZCBhIGRldmljZSBJRA0KPg0KPiBDcmFzaGlu
ZyBhdCBib290IHdvdWxkIGJlIGEgcmVhbCBidWcgdGhhdCBib3RoZXJzIHBlb3BsZSwgbm90IGp1
c3QgYQ0KPiBuZXcgZmVhdHVyZS4NCj4NCj4gTGV0cyBzZWUgaG93IGJpZyB0aGUgcGF0Y2ggaXMu
IElmIGl0cyAxMDAwIGxpbmVzIG9mIGhhcmQgdG8gdW5kZXJzdGFuZA0KPiBjb2RlLCBpdCB3aWxs
IHByb2JhYmx5IGJlIHJlamVjdGVkIGZvciBzdGFibGUuIElmIGl0cyAxMDAgbGluZXMgb3INCj4g
bGVzcywgaXQgd2lsbCBsaWtlbHkgYmUgYWNjZXB0ZWQuDQpJIHNlZS4NCj4gSXQgaXMgYWxzbyBo
YXJkIHRvIGFyZ3VlIHRoZSBEVCBpcyB3cm9uZy4gSXQganVzdCBkZXNjcmliZXMgdGhlDQo+IGhh
cmR3YXJlLiBJIGFzc3VtZSB0aGUgZGVzY3JpcHRpb24gaXMgYWN0dWFsbHkgY29ycmVjdD8NClRo
ZSB4NCBwb3J0IGxpbmtlZMKgIGNvbXBoeSBhcyBiZWxvdzoNCg0KcGh5cyA9IDwmY3AwX2NvbXBo
eTAgMD4sIDwmY3AwX2NvbXBoeTEgMD4sIDwmY3AwX2NvbXBoeTIgMD4sIDwmY3AwX2NvbXBoeTMg
MD47DQoNCkF0IHRoZSB0aW1lIG9mIHN1Ym1pdHRpbmcgbXkgcGF0Y2ggSSB3YXPCoCBub3QgY29u
dmluY2VkIHRoZSBhYm92ZSB3YXMgcmlnaHQsIG9yIHdyb25nLg0KSSBsYWJlbGVkIGl0IHdyb25n
IGZvciBjYXVzaW5nIGEgZmF1bHQgd2hpY2ggSSBzaG91bGQgaGF2ZSBub3RpY2VkIG11Y2ggZWFy
bGllci4NCg0KVGhlwqAgbnVtZXJpYyBhcmd1bWVudCBhZnRlciB0aGUgY29tcGh5LWxhbmUgaGFu
ZGxlIGlzIHRoZSBwb3J0IG51bWJlciwNCmZvciB0aG9zZSBmdW5jdGlvbnMgdGhhdCBjYW4gaGF2
ZSBtdWx0aXBsZSBwb3J0cyAoZS5nLiBldGhlcm5ldCAjMikuDQoNClRoaXMgbWVhbnMgYWJvdmUg
ZHRzIGxpbmtlZCBwY2kgcG9ydCAwIG9uIGxhbmVzIDAtNCwgd2hpY2ggYXBwZWFycyBjb3JyZWN0
Lg0KRnVydGhlciBsYW5lcyAxLTMgaGF2ZSBubyBvdGhlciBwY2kgcG9ydHMsIHRoZXJlIGlzIG5v
IG90aGVyIGNvbmZpZ3VyYXRpb24gdG8gY29uZnVzZSBpdCB3aXRoLg0KDQo+IFRoZSBpc3N1ZSBp
cw0KPiB0aGUgZHJpdmVyLCBub3QgdGhlIGRlc2NyaXB0aW9uLiBBbHNvLCBpIGFzc3VtZSB0aGlz
IGFmZmVjdHMgYWxsDQo+IGJvYXJkcyB1c2luZyB0aGlzIFNvQz8gUmVtb3ZpbmcgdGhlIG5vZGVz
IGluIG9uZSBib2FyZCAnZml4ZXMnIG9uZQ0KPiBib2FyZC4gRml4aW5nIHRoZSBkcml2ZXIgZml4
ZXMgYWxsIGJvYXJkcy4uLg0KDQpJIG1pc3NlZCB0byBjaGVjayB3aGV0aGVyIG90aGVyIGJvYXJk
cyBzaGFyZSBzaW1pbGFyIGRlc2NyaXB0aW9uLg0KDQpUb2RheSBJIGZvdW5kIHR3byBvdGhlciBk
dHMgdGhhdCByZWZlcmVuY2UgbXVsdGlwbGUgbGFuZXM6DQoNCmFyY2gvYXJtNjQvYm9vdC9kdHMv
bWFydmVsbC9hcm1hZGEtODA0MC1wdXp6bGUtbTgwMS5kdHMNCmFyY2gvYXJtNjQvYm9vdC9kdHMv
bWFydmVsbC9hcm1hZGEtODA0MC1tY2Jpbi5kdHNpDQoNCkJvdGggY2FzZXMgdGhlIGZ1bmN0aW9u
IGlzIFBDSSAtIGZpcnN0IG9uZSB4Miwgc2Vjb25keDQuDQoNCkkgd2lsbCB0cnkgdG8gbG9vayBp
bnRvIGEgbW9yZSBjb3JyZWN0IHNvbHV0aW9uIHNvb24uDQoNCg==

