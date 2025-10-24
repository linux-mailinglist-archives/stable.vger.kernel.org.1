Return-Path: <stable+bounces-189252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE89C08351
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 23:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EBC3B1848
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 21:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47AA309EF8;
	Fri, 24 Oct 2025 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NrSY1lOO";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NrSY1lOO"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021126.outbound.protection.outlook.com [52.101.70.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6711D61B7;
	Fri, 24 Oct 2025 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.126
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341864; cv=fail; b=ieQ/qagjvJrKflxh8BayaejfuirnMtv8ME3Q2MxW7EDBbRxNmPcSIyn4ilOma8YGE4I5zCMwmlqM0t+9uWNhN8J+mef21tAnofZz3IYUx9Cx+G3x/MPSixRWABJck0ejVGZR9Y4BZMNver7h0OeBtWOp0/zugoxrw7WD1r7xDb8=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341864; c=relaxed/simple;
	bh=beBygKH38peY/qyRVDDoL4e8WZ5FQBUQvMyBQ9R9ybQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MiGGNQXcm01MlMcF4ZXgyPEtUCL1YrnypVx7Ms2negvIeTemF7TJzjiYKdlo6r2L8dyo6P1Bu9fZLWMWnhczI9E2W0LPTLVhNyiFu2Hhn6HOjoXZDSvPNclovDaU8/yRo7z10mxgiRyH570eWnjM37bPg4+WNOdslyH0WGq1fH4=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NrSY1lOO; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NrSY1lOO; arc=fail smtp.client-ip=52.101.70.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dD0aNeKge2aH6dEWPluKfMi5AbqT24fz+YPmkfuaoC2SEtd/nfyAz5qAmIKrpGm3oH2mErbRShz2rA3xS29IGdlVCzJZrZpz4YP824qZ/8PpB/vRzV+1dZWB2pCBP5rJ/OeLgwk+4VN1m7nM1U+lgavPyP4SHy6+pTZYvr2W2y3KYfuWXvwbDmJeTDbZ6wB1O/4Q+BrB49v06CdG+5ZUeH/T882MfHw6dWrpkCeKFiMh73LlCCOdbok+FRKWz5l2dgheZx8NqYvgZ2jPrZVCHzbeoXuGO+Nmc84U2raoBa+3ERme9w4Xm2eI0HaBm5ML/22tLsmOrP73vfLxHqOCxg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beBygKH38peY/qyRVDDoL4e8WZ5FQBUQvMyBQ9R9ybQ=;
 b=uNkcOP4LCalfCGjvl/5OKXQjxeZ/UhxS3nc/xXgz6La2rqehlsocPfqxaWpYLzXrYzsVscESOZrMaXclCguWih1spkWCdgZg6wkStig8dixCT5M4IOK3yKT8tH3Mx6Eq0hq4f5USVqGiS5dDGsGW+ywZ2Id/rqBszKHdXJa9jfTIdxJHja4muxVuj3geX3cF/BYVkF+IdeMjdbjuK0bYnqyomS2EM87/Twi4ifu/YHDyTIi1t7MppcNSgwRvvJDeauixDTe2Y3b5epJc5BlZC028Oj6kWPtvbaLhXt+II4X89dquOjiglZyvOofCuM1qMrNYJtBNmOUQ3WDnVPYO0A==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beBygKH38peY/qyRVDDoL4e8WZ5FQBUQvMyBQ9R9ybQ=;
 b=NrSY1lOOleg+R3/6r/WIfFuPq3nIdaN48wjWFodLFFxarEHL15D8s2wUvxLSrPtG3w91IQVpa2/djHBHCgo+iDwrDXhZ5qU70vRUJdv3cz3YdcvYfeImgij01BFT+PysLff7PkY4i7aPRwPjSqR1hBBk7vhD6vgL22vQvud56L4=
Received: from AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::38)
 by DB9PR04MB8265.eurprd04.prod.outlook.com (2603:10a6:10:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Fri, 24 Oct
 2025 21:37:38 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:208:17c:cafe::e9) by AM0PR10CA0028.outlook.office365.com
 (2603:10a6:208:17c::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.15 via Frontend Transport; Fri,
 24 Oct 2025 21:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 24 Oct 2025 21:37:38 +0000
Received: from emails-3039815-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-152.eu-west-1.compute.internal [10.20.6.152])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 41FC7808C3;
	Fri, 24 Oct 2025 21:37:38 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1761341858; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=beBygKH38peY/qyRVDDoL4e8WZ5FQBUQvMyBQ9R9ybQ=;
 b=IrmykN94JzUtqfT2COjDe39eYJni5zoboIBwEBn4l9WG3DmpY8rp41bx6a2TJi3V9qhII
 2OqXmST3aOQ3nhTBuCbAFBehvkyf40R/LOcWbGBB1a9wwgnN1BQoM3869AREP5txx7bbYqC
 nqOet7bzFrI5XfnFday9Tm/xXwPognA=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1761341858;
 b=T4EinNInVVF+KY5XAix1vPiYr5f3jLpq48o3yljsCxP1cgr3TJm/bX8T4zHRcxgLFyjaG
 w7Mj4zLfe8IkLduF43TFS8JK4S+NeRfgQhZhMWCoAH16Z9jWdkN9cIwQvswNcElx+ulPUs6
 43g/j7lpodzNQE9fZrR4py+aksTzWkU=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re4znAmFZnRekybL0BP7c6xd4BtfpivcaGaff0jxF7NjVw2fkeL158iPpYANbXw1snWO3xrF39lOfPdt9kKbIk7aznQ3gvUvlInEkFfP8aZrnzjE4GM49S3kYndqAB3YTCnh11MY3WWiauvVYZj18qOvbI7B1IXo0yN0LZo2/xc2v0i4Rox9MyLIIUsQZNiYM0YWoBtCWz2TlQq4erUv8v11iCc4rHzWcidZgHT2xqDFUxBx9GvyrgjSvPjk82Br9OC2nEkHGgvoAOgOhxLx7GPplZRjvOE/IwA/mUh25XD1E9VX2Xnybt+ztJhvB8dGYLGe5MnEulx1bAAx9RVelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beBygKH38peY/qyRVDDoL4e8WZ5FQBUQvMyBQ9R9ybQ=;
 b=uPs+2FLnaMC4XIcU+xnAC5oEsnqY47tcLTure9sRD5gtIvPu+AOp0FAErF+aydWyu0Sea/BX9u8K1hcybcHU6QVAYj7SJ3Pw8j45F/Q1VKgr1oSNW/Hdi/rNvq9X6v3hrjEIMfBgIdaapBxs7U+IkDFrBFz1Gc6kGEEfhb7HtDPNkuPzRblSjrleL3JdqAtpesOYk1RSeisjR46bbFRrj5SwF9uZudryPmWh33knPDsIms/MhoYvkXB354tTEmAr6nh519kGcO/JOUxG+N6JSI8O6pe3zQLS2RTdLXWUbkRVp5ID9KuRNVjnLdJ2ihW5/oy+c9/Rr6nu2qK6GL/2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beBygKH38peY/qyRVDDoL4e8WZ5FQBUQvMyBQ9R9ybQ=;
 b=NrSY1lOOleg+R3/6r/WIfFuPq3nIdaN48wjWFodLFFxarEHL15D8s2wUvxLSrPtG3w91IQVpa2/djHBHCgo+iDwrDXhZ5qU70vRUJdv3cz3YdcvYfeImgij01BFT+PysLff7PkY4i7aPRwPjSqR1hBBk7vhD6vgL22vQvud56L4=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GV1PR04MB10535.eurprd04.prod.outlook.com (2603:10a6:150:204::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 21:36:50 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9253.013; Fri, 24 Oct 2025
 21:36:50 +0000
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
Thread-Index: AQHcI0ngX3qW4F/IsUCKxCrOhCtl17SOi9YAgApAcYCAADjyAIAAAmMAgAAXR4CAACEsgIA41fiA
Date: Fri, 24 Oct 2025 21:36:50 +0000
Message-ID: <acc3c98e-e662-42aa-a1a3-a5ccb1a7b0fc@solid-run.com>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
 <20250911-cn913x-sr-fix-sata-v2-3-0d79319105f8@solid-run.com>
 <9272b233-b710-4e57-b3ff-735f45c03c74@lunn.ch>
 <dbb10e82-ae10-4987-900b-17d4f4b62099@solid-run.com>
 <dedd4222-b2ba-4247-98b4-504b5c032f69@lunn.ch>
 <eab0cc63-de1b-4b41-bcce-7a2308d4f446@solid-run.com>
 <2589d2df-8482-4648-b63c-5a4a86f01fbb@lunn.ch>
 <8a092724-c3e6-468f-9fd8-e4cb7c69438f@solid-run.com>
In-Reply-To: <8a092724-c3e6-468f-9fd8-e4cb7c69438f@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|GV1PR04MB10535:EE_|AM3PEPF00009B9D:EE_|DB9PR04MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: ba59a4c6-4c3e-4055-2a38-08de13458dd2
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SHQzOWp4Rmg0cWl1LzVzTmg3V2Z3dVY4QzZoWFI4MEJ4NzJXMk5aaUR3RndD?=
 =?utf-8?B?Q2xyMVY3dTYzVUZIRnpTT3hRcjdBZ3hoMHFUTVFKOUdkVjJ5cXdJOGpFNlg4?=
 =?utf-8?B?MCs1bFFRdjVYU1lYTlZIN2FOWnI3d3FXYTc0TVdKY3JTYlBUSE9ycndCTU00?=
 =?utf-8?B?c3BxdTlKWU1ScUJCRjBLOUNBUXlsVlNNN3VlcUo5TGhIRkJOMm5oblBRYzE0?=
 =?utf-8?B?ZlRSZFhlRHN1TXJ0enp1N1Q2VS9PMUUwOHRpZGRIVzRGZTVxeWF1ditxU21C?=
 =?utf-8?B?NFJvTEk2czZtSTEzZTJabkZjeTN4M0NlSkw1TkpJaUY0dzRzUjNKLzBCNDlz?=
 =?utf-8?B?bzFPNjJ6TU04MFcwamVJVHpuS3pZakRINFM2SFYrRWhBN25URTQzWlE5V2Ri?=
 =?utf-8?B?T2lGdHpvMHdpN1IyRmlOTEZOYmFBMjZjRWp0dG9SbEJyMVRxQTF0TlJnQjB2?=
 =?utf-8?B?cGY4TzJhRFhKMmtDN1hpZ2IvUGZGbjJ2a2F6MDhmS3A2NW8wMUdza1JqVitn?=
 =?utf-8?B?ZjliS1U0VVRKSGg5SXUxS1JhUWxpTUlmSDErYjNtb0xlSU1Yb2JqZ0xFOTgz?=
 =?utf-8?B?QjIvbjNUaThORHVyT0FTN0NCM3g1S09SMWg0TUR4K09RSC9sVkpaZkVFejlu?=
 =?utf-8?B?MXV5dzljUEZmMS9mdGN0My80WHp5bUVIMy9mdTc2YWhnZ3NqSEdhekNabVN1?=
 =?utf-8?B?K1lZNlpnVjJUSW5yREwvYVdGelJDUzUxUW5GT2k2dXIvM3Bla3lHanVzci9P?=
 =?utf-8?B?VWxDV3dwdGd4NnNSWjBUY0R2dUxaSXMybGtFMGdlOEhONURKdTBrUHdVQUNJ?=
 =?utf-8?B?MktWTlk5cldCNS9NSFl6UzF4STJHRFBvajBtdjdrWmx4TFpXNVZCZUhRYmNG?=
 =?utf-8?B?UVVqWmw2Vk1jTytSbVFwbzA1S0Rqa04wNVQ5UUZNR3M2MXVpOEN3MjdLenRj?=
 =?utf-8?B?MHJmcEJYeVFKeEtIdnBON1FhRTBsTkJ3aEtsY3hWNHd3LzAzaFNKK3l5MjFl?=
 =?utf-8?B?YnoxT1lyV1MzaittdmFXRGc3cGdkcnhjVW1IMEFxVzVMdVNFU0c2ZlpEZ3Zj?=
 =?utf-8?B?TXRYODBqemxjazgreEFLWXZqbER6RlVyaXdCa3V5bkJ5SFc2UTBudzUrR0dw?=
 =?utf-8?B?aXJQbjdRalQ2S0toamY4dXRWck5VZ1J6Y0JBVkhVOXpUeWVTNWs3QlkvbHBo?=
 =?utf-8?B?NnltRzZBbVlycW9pQ21oV2I3VXg2UGNWOVlqWVpRQXh6dVdESVE5S0Z6dmVq?=
 =?utf-8?B?b1hzaU5jcG9LT3JWb05PenFhNTZLR3RXMzB5YUZMbE1aU1NwSG9Ea3NJU0Nl?=
 =?utf-8?B?aVFwaVNhU2owYlZKSGxpWllRaGNqOW5JZFJrVjNXbFRHc1UwQkdiQ3R6TUUw?=
 =?utf-8?B?eU5nOFhtRkEyai8xbHlqTlRGUWhFT2phM3ZPWXNKNHNEUkIrcXBMVFV0cmty?=
 =?utf-8?B?WERwOWVJbkxINFlNVWFnZ1VFN0dhQ0FBTWZyN2FFSHdVM2Jpcko5RjZMcEFw?=
 =?utf-8?B?elBVTFVFQUpESjNRSUkzMW4xblJFZkoyK3BKK08rTmNaM1Z5dmcwSDc2bmhB?=
 =?utf-8?B?Z0NVY2dlK0w5NXNRK2V6Z0VhaCszekNITFJWdVlPUmg1UEpnKzFGL2pKb3RP?=
 =?utf-8?B?Nm9tRldzdGZ1NDJsbFF4RXM2QVQ0SjdCSm1FZndTdkVLb24xalpjNUpLUEsr?=
 =?utf-8?B?QXZiWUl3cjFTT0VVenF1YUJPMnF6U2tsakdyOXBjaVFiWEFZcFlrd2N6THJ5?=
 =?utf-8?B?cHh3M01rdVQ4RUpDem1acXlveEVxTWw1bTJFcU5nL2lTa0s0Y2dzMlgxZ0k2?=
 =?utf-8?B?eGlDZXA2aHE2UGJRZkw5RXByZGhYU1ovTThUWTg4S0hycVJmeWRPNzEzc0lz?=
 =?utf-8?B?UW9iNGpmNDR2ZTFpUWlvZ1FEc3RnZ2VlZTBCTmdCVDd6QTRUNDRsSmJUT2ts?=
 =?utf-8?B?dkdnd0NHZUNXajluU1hZR0QwMldwclFyVTJ6NWVUa3VONHJ6alQ4ZHVzaE44?=
 =?utf-8?B?dVVKMFJsYXVRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFC31C8B352F86448B73B98E788D2E49@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10535
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 3cbbc3b028ff4b42a250247b951e8e92:solidrun,office365_emails,sent,inline:c53c0952b38074a019870a5535e394f9
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4a5f1e95-8a18-4162-d756-08de1345713b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|35042699022|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0NnTEY3dUtQQnlkTFpBcEw2VWtOa3RibVg2Qnl0WW5tUUVoYytJcTJQWVQ4?=
 =?utf-8?B?OEdTWWdOaElnejlxUGFGcXBlQ2c1c0IzUGxjMmxIZEwxTnZwOTB4TEM4K1Iw?=
 =?utf-8?B?RWZxUDM1VVBzd0JUSTM3SEV1WmpnQi9wVkErbUpNSFprRFdlK3BEK3dIbEdC?=
 =?utf-8?B?cWllN25mL3lHaGdCV0xIVmEvK2ZSQzhVdmdzYkNjMytsSHh1TlJiTGxDcHc1?=
 =?utf-8?B?YTBUSi9pU1pyM3ZZY3VFNitFWTFMb25rajBRUWlHbSswMDNLS0diVkFFcXZv?=
 =?utf-8?B?d2Z6Q25oSUEwcUR5emF0cXB3NTIvSzFhQlFjZmFHd1ZiMHFxci9xUml0UzhJ?=
 =?utf-8?B?OEd1ZW85WnRZMzJlZStzcHN2Mi84ZTYwWk9Jd2p5ekxra2RhVW9OOElsS29N?=
 =?utf-8?B?bC80aVdyRFliclBuOG1FdU5zZGg0bUcxR2JwTHk4OU13YjFJa29GOER3eFA2?=
 =?utf-8?B?dTQzYU14UnNTOTcvMDJ3ZVREbjJ2NHhLWVVHaVp5VWFkK3M0V0UxNmxFa2Ft?=
 =?utf-8?B?M2RBZkxqSWpIb3VQNWJSWTFGZXhXbWN6OXZsNUVaaWNZelJsQnlyWUEvU2Jq?=
 =?utf-8?B?SndIQVJwWnpOemNpTlljckpsL1dOQWZVTUVjV1RkSDRlL1gvZEN0SlVCeU5v?=
 =?utf-8?B?ZFJqU2M2b0FuWDdkV09Lb3ZCbHhKa25GY2x1aUZyd2xoS3o5ZlpGOXhQc1Vo?=
 =?utf-8?B?Z0JxeHJmR01rdFVaU0xtYmI1d3ZrVS9iME52WXNHOUhFREFIUi9FbVlKdXVt?=
 =?utf-8?B?S0w0ZzJ0cWJFcFAxc1BNZDVCeUhka0lFbFlaRXRwYUt1bGF3c0RiLy9aOVpR?=
 =?utf-8?B?OGRZQUJqczJVT2NzaGlvNDhDUlkveS91VnU3WllCajJ3Z2x2NzNtNU1tQlRp?=
 =?utf-8?B?bklMTlB3bnNuV05HWDRkM1hVajdhL3FoZUUweTgxVzVFd3F0c29rcko3RHZy?=
 =?utf-8?B?VnZQVDZpM3ZGdEhiVmlaVnZzbXdsNFJqZEV0MWdqVGI2YlQ1QVJQTFY0ZzFE?=
 =?utf-8?B?dExMRnlaNWFuNk45aU5jWU1oZVVyN0wybTFibXlOYmxqZGltNmUweVhmUUtM?=
 =?utf-8?B?Skd1cTc0RVcvZDJOMHlMWTkzT3hPSFJ5QVRldjJXVGxac3QyTmtXRktycDlE?=
 =?utf-8?B?bUZOUjA4V2Z1Q3g1alpsZGRhUWRBVnBJWE9qdGRCVnRqNU9DSFZhMnBZR1JT?=
 =?utf-8?B?RzNkR0xqZTFFWEhNQWhEclV4ZUdtd2NFNzdtOEZDSVRWTGVYNkgvSEovWlE4?=
 =?utf-8?B?aTk5aE14dGxKbzloVHQxdGJ1RlkrWVpVekRxcFU2WmlvWG8zbmxrL2tLeHpR?=
 =?utf-8?B?QU9zTzl2aXYySllKdWE4S3lCSTB1WTk2ZWNlQStHdmNPZjJVR1NDTkx3R3Rx?=
 =?utf-8?B?ZEZYUDFycGczTUhpOW5ubmJRV2JjVlF5YnVWZC9FUXFSSmgrNUg5Z2R5R1d6?=
 =?utf-8?B?QWliQ3ZnSkJNSVZQbnBXcjFMOUJOVlo2blV1Z2kvWXVtaDRmOWxkQ21TcEYy?=
 =?utf-8?B?Tk0wQUE0aXFFRmN3UEU1M3MzeUNOak9VZloxdDdJdEU4YU9FSTM5dmczS2Mw?=
 =?utf-8?B?Z1JOUGFxY25ScmNFUjRFVDJSWXNJblVxSExPQ0h5Q0kyb1ZEUUxrbndLZ0hT?=
 =?utf-8?B?NUk3UFBubExQakExUXZzU25EQlAwcS9Hd0ZUWElGZEFYQ1duMjB0TVR4cHZV?=
 =?utf-8?B?dlJsS0kwaUY3bUE5djZUOXpHOUlRMGdsM0pXRlNzdngvZDAxOW41QzhIK3Vt?=
 =?utf-8?B?Q1lxVlU1eHlDd0NVU3lBU29HaTcva1pWdm0vbTBFamt6dEt5dFNUTUN6SnJm?=
 =?utf-8?B?bjduK2pyTXgrUG8vTzc3ang4WHIvQVEvVzZHMDFHWUVOYmpFaW5vdnlSVzVS?=
 =?utf-8?B?a0p0Rnk5OEFuM3pOeHAxVW14SjlMTWUvalJ2dW5qZHJQSkN6SVRHaFVTNGZK?=
 =?utf-8?B?OEhLeDYvaGdLRnJTMjJhQU5WNFdGbmhXa2x0Q1JUNkVzaG5jOXFlN1hBQXVk?=
 =?utf-8?B?YlhkMTdoZ2RuV0VDOEd0NVU5VnZYbENZUmVvTjhtQjJHKy9KTUoweDhwYW5V?=
 =?utf-8?Q?vbUaew?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(35042699022)(1800799024)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 21:37:38.5309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba59a4c6-4c3e-4055-2a38-08de13458dd2
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8265

SGkgQW5kcmV3LA0KDQpBbSAxOC4wOS4yNSB1bSAxOTo0MCBzY2hyaWViIEpvc3VhIE1heWVyOg0K
PiBBbSAxOC4wOS4yNSB1bSAxNzo0MSBzY2hyaWViIEFuZHJldyBMdW5uOg0KPg0KPj4+Pj4gVGhl
IG12ZWJ1LWNvbXBoeSBkcml2ZXIgZG9lcyBub3QgY3VycmVudGx5IGtub3cgaG93IHRvIHBhc3Mg
Y29ycmVjdA0KPj4+Pj4gbGFuZS1jb3VudCB0byBBVEYgd2hpbGUgY29uZmlndXJpbmcgdGhlIHNl
cmRlcyBsYW5lcy4NCj4+Pj4gV2h5IG5vdCBqdXN0IHRlYWNoIG12ZWJ1LWNvbXBoeSB0byBwYXNz
IHRoZSBjb3JyZWN0IGxpbmUtY291bnQ/IFRoYXQNCj4+Pj4gc291bmRzIGxpa2UgdGhlIHByb3Bl
ciBmaXgsIGFuZCB0aGF0IG1ha2VzIHRoZSBrZXJuZWwgaW5kZXBlbmRlbnQgb2YNCj4+Pj4gdGhl
IGJvb3Rsb2FkZXIuDQo+Pj4gVGhhdCB3b3VsZCBiZSBhIGZlYXR1cmUgb24gdGhlIGNvbXBoeSBk
cml2ZXIsIG5vdCBhIGJ1Zy1maXggYmFja3BvcnRlZA0KPj4+IHRvIHN0YWJsZS4gVGhlIGNvcmUg
Z29hbCB3YXMgdG8gZml4IGJ1Z3MgZm91bmQgaW4gRGViaWFuIDEzLg0KPj4gSXQgaXMgbm90IHNv
IHNpbXBsZS4NCj4+DQo+PiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9w
cm9jZXNzL3N0YWJsZS1rZXJuZWwtcnVsZXMuaHRtbA0KPj4NCj4+ICAgSXQgbXVzdCBlaXRoZXIg
Zml4IGEgcmVhbCBidWcgdGhhdCBib3RoZXJzIHBlb3BsZSBvciBqdXN0IGFkZCBhIGRldmljZSBJ
RA0KPj4NCj4+IENyYXNoaW5nIGF0IGJvb3Qgd291bGQgYmUgYSByZWFsIGJ1ZyB0aGF0IGJvdGhl
cnMgcGVvcGxlLCBub3QganVzdCBhDQo+PiBuZXcgZmVhdHVyZS4NCj4+DQo+PiBMZXRzIHNlZSBo
b3cgYmlnIHRoZSBwYXRjaCBpcy4gSWYgaXRzIDEwMDAgbGluZXMgb2YgaGFyZCB0byB1bmRlcnN0
YW5kDQo+PiBjb2RlLCBpdCB3aWxsIHByb2JhYmx5IGJlIHJlamVjdGVkIGZvciBzdGFibGUuIElm
IGl0cyAxMDAgbGluZXMgb3INCj4+IGxlc3MsIGl0IHdpbGwgbGlrZWx5IGJlIGFjY2VwdGVkLg0K
PiBJIHNlZS4NCj4+IEl0IGlzIGFsc28gaGFyZCB0byBhcmd1ZSB0aGUgRFQgaXMgd3JvbmcuIEl0
IGp1c3QgZGVzY3JpYmVzIHRoZQ0KPj4gaGFyZHdhcmUuIEkgYXNzdW1lIHRoZSBkZXNjcmlwdGlv
biBpcyBhY3R1YWxseSBjb3JyZWN0Pw0KPiBUaGUgeDQgcG9ydCBsaW5rZWTCoCBjb21waHkgYXMg
YmVsb3c6DQo+DQo+IHBoeXMgPSA8JmNwMF9jb21waHkwIDA+LCA8JmNwMF9jb21waHkxIDA+LCA8
JmNwMF9jb21waHkyIDA+LCA8JmNwMF9jb21waHkzIDA+Ow0KPg0KPiBBdCB0aGUgdGltZSBvZiBz
dWJtaXR0aW5nIG15IHBhdGNoIEkgd2FzwqAgbm90IGNvbnZpbmNlZCB0aGUgYWJvdmUgd2FzIHJp
Z2h0LCBvciB3cm9uZy4NCj4gSSBsYWJlbGVkIGl0IHdyb25nIGZvciBjYXVzaW5nIGEgZmF1bHQg
d2hpY2ggSSBzaG91bGQgaGF2ZSBub3RpY2VkIG11Y2ggZWFybGllci4NCj4NCj4gVGhlwqAgbnVt
ZXJpYyBhcmd1bWVudCBhZnRlciB0aGUgY29tcGh5LWxhbmUgaGFuZGxlIGlzIHRoZSBwb3J0IG51
bWJlciwNCj4gZm9yIHRob3NlIGZ1bmN0aW9ucyB0aGF0IGNhbiBoYXZlIG11bHRpcGxlIHBvcnRz
IChlLmcuIGV0aGVybmV0ICMyKS4NCj4NCj4gVGhpcyBtZWFucyBhYm92ZSBkdHMgbGlua2VkIHBj
aSBwb3J0IDAgb24gbGFuZXMgMC00LCB3aGljaCBhcHBlYXJzIGNvcnJlY3QuDQo+IEZ1cnRoZXIg
bGFuZXMgMS0zIGhhdmUgbm8gb3RoZXIgcGNpIHBvcnRzLCB0aGVyZSBpcyBubyBvdGhlciBjb25m
aWd1cmF0aW9uIHRvIGNvbmZ1c2UgaXQgd2l0aC4NCj4NCj4+IFRoZSBpc3N1ZSBpcw0KPj4gdGhl
IGRyaXZlciwgbm90IHRoZSBkZXNjcmlwdGlvbi4gQWxzbywgaSBhc3N1bWUgdGhpcyBhZmZlY3Rz
IGFsbA0KPj4gYm9hcmRzIHVzaW5nIHRoaXMgU29DPyBSZW1vdmluZyB0aGUgbm9kZXMgaW4gb25l
IGJvYXJkICdmaXhlcycgb25lDQo+PiBib2FyZC4gRml4aW5nIHRoZSBkcml2ZXIgZml4ZXMgYWxs
IGJvYXJkcy4uLg0KPiBJIG1pc3NlZCB0byBjaGVjayB3aGV0aGVyIG90aGVyIGJvYXJkcyBzaGFy
ZSBzaW1pbGFyIGRlc2NyaXB0aW9uLg0KPg0KPiBUb2RheSBJIGZvdW5kIHR3byBvdGhlciBkdHMg
dGhhdCByZWZlcmVuY2UgbXVsdGlwbGUgbGFuZXM6DQo+DQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWFydmVsbC9hcm1hZGEtODA0MC1wdXp6bGUtbTgwMS5kdHMNCj4gYXJjaC9hcm02NC9ib290L2R0
cy9tYXJ2ZWxsL2FybWFkYS04MDQwLW1jYmluLmR0c2kNCj4NCj4gQm90aCBjYXNlcyB0aGUgZnVu
Y3Rpb24gaXMgUENJIC0gZmlyc3Qgb25lIHgyLCBzZWNvbmR4NC4NCj4NCj4gSSB3aWxsIHRyeSB0
byBsb29rIGludG8gYSBtb3JlIGNvcnJlY3Qgc29sdXRpb24gc29vbi4NCg0KSSBkaWQgc29tZSBl
eHRlbnNpdmUgdGVzdGluZyBvdXRzaWRlIG9mIERlYmlhbiB3b3JsZCwgd2l0aCB2Ni4xMi4wLCB2
Ni4xMi40OCwgTWFydmVsbCB2Ni4xIC4uLg0KYW5kIG1hZGUgYSByYW5nZSBvZiBpbnRlcmVzdGlu
ZyAvIGNvbmZ1c2luZyBvYnNlcnZhdGlvbnM6DQoNCjEuIEkgd2FzIGFibGUgdG8gcHJvZHVjZSB0
aGUgcHJvYmxlbSBpbiBhIHNlbGYtY29tcGlsZWQga2VybmVsIG91dHNpZGUgRGViaWFuLg0KVGhp
cyBpcyB3aXRoIGFybTY0IGRlZmNvbmZpZyBhbmQgc29tZSBzbWFsbCBhZGFwdGF0aW9ucy4NCg0K
VGhlIHN5c3RlbSBvbmx5IGdvdCBzdHVjayBkdXJpbmcgYm9vdCB3aGVuIHRoZSBjb21waHkgZHJp
dmVyIHdhcyBhIG1vZHVsZS4NCg0KSW4gdGhpcyBjYXNlIHRoZXJlIGFyZSB0d28gc3VzcGljaW91
cyBtZXNzYWdlcyBpbiBib290IGxvZzoNCg0KW8KgIMKgIDIuNzQyOTY2XSBhcm1hZGE4ay1wY2ll
IGY0NjAwMDAwLnBjaWU6IE5vIGF2YWlsYWJsZSBQSFkNClvCoCDCoCAzLjczMjA4NF0gYXJtYWRh
OGstcGNpZSBmNDYwMDAwMC5wY2llOiBQaHkgbGluayBuZXZlciBjYW1lIHVwDQoNClRoZSBsaW5r
IHRpbWVvdXQgY29tZXMgdG8gbWluZCBmaXJzdCwgd2hpY2ggaXMgdW5leHBlY3RlZCBhcyBpbiBt
eSB0ZXN0aW5nDQp0aGVyZSB3YXMgYWx3YXlzIGEgY2FyZCBjb25uZWN0ZWQuDQpUaGlzIGNhcmQg
d2FzIGRldGVjdGVkIGZpbmUgd2l0aCBjb21waHkgZHJpdmVyIGJ1aWx0aW4uDQoNClRoZSAiTm8g
YXZhaWxhYmxlIFBIWSIgbGlrZWx5IGxlYWRzIHRvIHNvbWUgYmFkIGVycm9yIGhhbmRsaW5nIGlu
IHBjaSBwcm9iZSwNCmFuZCBzaG91bGQgYmUgaW52ZXN0aWdhdGVkIGZ1cnRoZXIuDQoNCjIuIFdo
ZW4gdGhlIHN5c3RlbSBnb3Qgc3R1Y2sgZHVyaW5nIGJvb3QsIGl0IHdhcyBuZXZlciBpbiB0aGUg
bWlkZGxlIG9mIGFuIHNtYyB0byBhdGYuDQpJIGNvbmZpcm1lZCB0aGlzIGJ5IGFkZGluZyBsb2Nr
aW5nIHRvIHRoZSBzbWMgZnVuY3Rpb24gaGFuZGxlciBpbiBhdGYsIGFuZCBsb2dnaW5nDQphY3Rp
dml0eSB0byBzZXJpYWwgY29uc29sZS4NCg0KMy4gSSB3YXMgd3JvbmcgaW4gdGhhdCB0aGUgbGlu
dXggZHJpdmVyIGRvZXMgbm90IGtub3cgaG93IHRvIGNvbmZpZ3VyZSB0aGUgbGFuZSBjb3VudCwN
CnRoZSBjb21waHkgZHJpdmVyIGRvZXMgaW5kZWVkIHBhc3MgdGhlIHBvcnQgd2lkdGggKGFzIGlu
ZGljYXRlZCBieSBudW0tbGFuZXMgZHQgcHJvcCkNCmluIHRoZSBmb3JtYXQgdGhhdCBBVEYgZXhw
ZWN0cy4NCg0KSG93ZXZlciBBVEYgZG9lcyBub3RoaW5nIHdpdGgga2VybmVsIGRyaXZlciBwY2kg
bGFuZSBjb25maWd1cmF0aW9uLg0KSW5zdGVhZCBhbnkgcG93ZXItb24gb3IgcG93ZXItb2ZmIGNh
bGwgZnJvbSBrZXJuZWwgZHJpdmVyIHZpYSBzbWNjDQppcyB0ZXN0ZWQgZm9yIG9yaWdpbmF0aW5n
IHdpdGhpbiBsaW51eCB2cy4gdWJvb3QuIE9ubHkgd2hlbiBzb3VyY2UgaXMgdWJvb3QsDQppdCBw
ZXJmb3JtcyBhbnkgY29uZmlndXJhdGlvbiAuLi4gOg0KDQpodHRwczovL2dpdGh1Yi5jb20vQVJN
LXNvZnR3YXJlL2FybS10cnVzdGVkLWZpcm13YXJlL2Jsb2IvbWFzdGVyL2RyaXZlcnMvbWFydmVs
bC9jb21waHkvcGh5LWNvbXBoeS1jcDExMC5jI0wxMjU3DQoNCjQuIFRoZSAibW9kZSIgYXJndW1l
bnQgKHgyKSB0byB0aGUgc21jIGZ1bmN0aW9uIGZvciBjb21waHkgbGFuZSBwb3dlci1vbi9zZXR1
cA0KZGlmZmVycyBiZXR3ZWVuIE1hcnZlbGwgVS1Cb290IGFuZCBMaW51eC4gSSBmb3VuZCB0aGlz
IGJ5IGR1bXBpbmcgdGhlbSBmcm9tIEFURiBpdHNlbGYuDQoNCkluIHBhcnRpY3VsYXIgdGhlIGJp
dHMgaW5kaWNhdGluZyB0aGUgcG9ydCBudW1iZXIgd2VyZSBpbnZhbGlkIGR1ZSB0byBhbiBvdmVy
ZmxvdyBlcnJvcg0KaW4gc29saWRydW4gdS1ib290IChiYXNlZCBvbiBNYXJ2ZWxsIHUtYm9vdCku
DQpUaGUgbW9kZSBzcGVjaWZpZWQgYnkga2VybmVsIGRyaXZlciBob3dldmVyIHNlZW1lZCBjb3Jy
ZWN0IGluIHRoYXQgcmVnYXJkLg0KDQpGdXJ0aGVyIHRoZSBiaXRzIGluZGljYXRpbmcgdGhlIHNl
cmRlcyBsYW5lIHNwZWVkIGFyZSAwIGluIGxpbnV4IGRyaXZlciwgYW5kIGFsbCBvbmUgaW4gdmVu
ZG9yIHUtYm9vdC4NCg0KQXMgYXRmIGlnbm9yZXMgcGNpIGxhbmUgY29uZmlndXJhdGlvbiB3aGVu
IG9yaWdpbmF0aW5nIGZyb20ga2VybmVsLCB0aGlzIGhhZCBubyBpbXBhY3Qgc28gZmFyLg0KDQo1
LiBUaGUgcG9ydCBudW1iZXIgcGFzc2VkIGZyb20gdS1ib290IHRvIGF0ZiBhcHBlYXJzIHRvIGhh
dmUgbm8gZWZmZWN0Lg0KRml4aW5nIGl0IGluIHZlbmRvciB1LWJvb3QgaGFkIHNvIGZhciBubyBh
cHBhcmVudCBpbXBhY3QuDQoNCg0KVG8gY29uY2x1ZGUsIEkgdGhpbmsgbXkgZGV2aWNlLXRyZWUg
cGF0Y2ggaXMgbm90IGNvcnJlY3QgYW5kIHNob3VsZCBiZSByZXBsYWNlZA0Kb25jZSBhIGJldHRl
ciB3b3JrYXJvdW5kIG9yIHNvbHV0aW9uIGlzIGRpc2NvdmVyZWQuDQoNCg==

