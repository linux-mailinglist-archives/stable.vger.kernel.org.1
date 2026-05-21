Return-Path: <stable+bounces-253586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMJbNVUoD2rGHAYAu9opvQ
	(envelope-from <stable+bounces-253586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:44:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7771C5A8918
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E3D230A19D7
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A9E34A3D6;
	Thu, 21 May 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PLmJrMCg"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB3534846E;
	Thu, 21 May 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374994; cv=fail; b=N/JCMGmh74EhpmTIvoNkiquqeolpW2R61LcFkWnygkuZivhhBuzu+A6B4WUet8ou9mBsZihZdZFqg0k2vSEgfe1wFwljwkkBfTxjDxG/WQCKb/JFUo/Z8YyvU8E67QeHLLEEKAA34LwrQGdqLkL/UK6SMpIkNKgAUQ6b7VPVE4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374994; c=relaxed/simple;
	bh=a332tbGOruDnER/4TlUjfkGpYb7v14Il5evart2QsF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nD8FztiNqJHmOZ1Kmi8f8F89UBShoVjdWBD313jFH5R6JvNJPQuc35cnr6rJ8d16oj1BxZyIPToERykwpQJiWztgt4hjJ7yCnZ/fGwrv3X4uMujo7BOx86lbZA04w0+rFsLU4HxFdE3ccDqxWZCRaWM8nmqew2vXrDGs4hZRm0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PLmJrMCg; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgM7ByQE2ChFWXBDj2iqAXYAGdYZERsVcX3bzJdjk237sD6Yx0zSZ1xt3L3pX4Kvc54smC/1jBpWfcZc1COI7DQu5oBlbZObFI3V5O5YMIhjQQMXAUOGeaZQaWfBi9Iar+me4B+EvIWRbcRC7W+x9dKNBwyNk0BOJlU3UhQhI2avF+0patOA/AarD7kJn2pYLOrzEGOb59Sp5Sq1v7MObkMGz/ECmcIVcLvcRat2+XvUA0K13+RfEDV3QTBu0PUqs2ydiCyFcE7ZenI8tR5gdTIc9RydVG3ThF/lPawVwv3vS75971m97CpwXeaTzfPMqUpjRntuyt4686Hh0/wJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a332tbGOruDnER/4TlUjfkGpYb7v14Il5evart2QsF8=;
 b=CCSgnzsqpEz+lldkg7FTn+pnIA031nPmAztnieCjm4XK9CNHG8nIrtU/+WEDgF5o0iQ8Nxzj9KNQ7dEolhk5hqeYI+ytxk48tJhsj0NStyiFrDFcQDq+CXruixxx0ayQqqcXkGdVU8GUIg4KX0p98C94gQDoThb/mfjQfkhuCs7oTUQ0TlO9DULpnZOTVmgilXz9mAQ4HZcQBomW3sociVuIdyv93ehAOsQ2bxWWCZQgwpbwK5Ouj5ITDHjrwfyPyT/JKsizCZSDt8rEpbCx4MWDAhHegWlT7KAQzeZHvCpLCQt9uvOX5lgaN3pzz7JXOTJJ44DyjCNuZAJwlkHPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a332tbGOruDnER/4TlUjfkGpYb7v14Il5evart2QsF8=;
 b=PLmJrMCgcdgn8aL9Akd9IjJTl6U5NrhCEH2vWIVQHyPP8htqX9wMRP07LlSA6gL3e3XVoD+pmXU/+9kolfQRux2zI2NBhf4o1FzFODNuFESeld7amrBmcHMTb3hxPkhVEsbHMFBRqQOoExT2umjaNXxRGSByMqYK+WDfMnRl460Dzon9NQOxHcn9pNSB//JdvqX4zXEBCwnT+KPd6nKya4dsfv2zqt0Dlz7hdoMMBSHEK5RQ0gdezQHRsqiAQ4OxNFJv5KnGMy34AdZZfpLndHQUUMirjggXwXVsdwLreB1f3sczzulJ+OqaNX+TqS7mFESKsazpaff7Q+ZUAeZACg==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 14:49:49 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 14:49:49 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>, "Carlos Song (OSS)"
	<carlos.song@oss.nxp.com>, "o.rempel@pengutronix.de"
	<o.rempel@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Carlos Song <carlos.song@nxp.com>, Bough Chen
	<haibo.chen@nxp.com>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
 down
Thread-Topic: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
 down
Thread-Index: AQHc6TES6gIStpqWEUO7WAosK/G7yg==
Date: Thu, 21 May 2026 14:49:48 +0000
Message-ID:
 <AM0PR04MB68026A6412B8F844D1324B92E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
 <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
 <AM0PR04MB68027798D1B07FD63AEC5F23E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <22af0378-a3c9-4403-a0ee-da794847f41d@oss.qualcomm.com>
 <AM0PR04MB6802FE8B0E0BEF8CDA6DAD5EE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <ab96c900-9c77-455a-88f1-b6d8d8e4ff78@oss.qualcomm.com>
 <AM0PR04MB68024A0FAF0637726C08B87BE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <315029cc-f04c-4dad-a746-f5d3e7245cdc@oss.qualcomm.com>
In-Reply-To: <315029cc-f04c-4dad-a746-f5d3e7245cdc@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|AS8PR04MB8261:EE_
x-ms-office365-filtering-correlation-id: f0438977-90b3-4661-2b07-08deb7483523
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021|921020|22082099003|56012099003|18002099003|4143699003|6133799003|11063799006;
x-microsoft-antispam-message-info:
 Eif3MKJhEzMiqlRo8xFbf6YeS2Vcvyn/TmAV8cRn/wQCJeNHlpBZ5UKjY+Ez5Tahp7hN7AIIOR+PAId3d85IqOUgv7ZE4z8j2CoPFCXqgI7yM827Rd/iEeo3aZS65+4b64tK4BpKYrFHc1+/Qb5+aDaacPiWBd6Kv6W885Nj18MEsognyee+NXM6FfyRe0SpPHCZPOO6ERLkmxTLxpci4qQt+Jsjnn837Ab7wDYKcSVdAcoAqSNpsyAqV+DJWAKa5HJ0wVjPNauQ8eAHlj9FqUh6iQ6/JlvuQRi2woTzPxiY/cy1arVRkDUDBGW1l+/k4Itaf4cTDjhiwhV1wbsJWduepwtCG5wI6FuWhAiREEm2631ZhnUtyD+tb5tmPA7L//9Ql6wv43+/FC32haYYwQWuuOPlDO7Usddtn3sXF07MtHArNzJB7Sc5WjwVhSSXWWXnBOJvA1SmLHYw9L5emnGCYsJ/zYA4PSjJbnBqDpXQ7Oe7p7LCRqw3Ueae3vggQSvyXMD4i2hmqe61ZfDjIHzkPJ24bCaqLes+gDDcJBmcI2uAG9+NWIOdG1MRj9otmOkuqOFDsv9WCGYqGycT6AMXjk67yLfBT74Y7njCme77mvUFvPhGBkMWF7dqjdToegyrxmqT0oo5A6se7LUAiE1UnR1nVvdk+UZ5kZMu5SxP+i9BDGe/2XMuJZqC0hdOeFf7UBn6dhFGSxwSBAzH24/JIp1Rl/9yWr0Y7SYNnl3FQ5umUNWQfnX7s64OOWuWUKIJWtZ9/Ihl1UxA0Caj7A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021)(921020)(22082099003)(56012099003)(18002099003)(4143699003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czdJNVhwM0UvRUZ3MHFzU3BMRmhZNXNYWlM5RG02YktCbm03WjFLVFppYStV?=
 =?utf-8?B?dm9FWnFZMkd0L3g3RFRVemttaGY4Qy9NSDJZT2VQTkJZaXlFMlROY3hTa2NV?=
 =?utf-8?B?Ulk5Yldoc29XcWpHb2VkSkFFZFNQaUJMR25uekRNTUhkNU9QN1NhZHQ2b2Fz?=
 =?utf-8?B?ZWVxQkZiWVNNc0lvVXR1N1YxYkZOejlHS3NUc2tZV25JeEtrUU5GdkZ0cmVk?=
 =?utf-8?B?K3RrNXNPZkFlK0s3bzZ4QUpDM0F3WmU3a3BvNjBRM0p5NUZZOGUrc0dxMG9S?=
 =?utf-8?B?TjgwQzZXNXlZQWN6NEtUQVp6K1UxbkMreXE1S1g1TWZGa1ptQmFXSGtNWWFC?=
 =?utf-8?B?TWpWQ1V5ZWt0UGprQzdqa25LQUtUYkpkOXZmNmM1QmFjUTQ1S1hpdDRQOTlx?=
 =?utf-8?B?YWhIMmV1Mk1rS2tkK1Y1b1g1TjJyTWU5QkhoSEJmWFFrUHNVOFRoQ1ViRzI1?=
 =?utf-8?B?WWkrc0lzbHVaUGZ0R09JRUVWMXR1alhXWGY3SDZKd0Q1WEdnZ2Y0WEtSVGgz?=
 =?utf-8?B?emZNc1R2ZDN2LzhyTHY4cW5PY2lHU2gzeTFmRDVHN1N1NkowT1lUem0xYjh4?=
 =?utf-8?B?dms4Q2p4eW16M2pyRGRVSzdDVXN3eVAzSCs3Qk9nWlY5dml5aFhVMGk3VG0w?=
 =?utf-8?B?NS91RzlGVmM0dXZlZmdaM2FEUEdmRWJPZHJlTHdFK2NJOTlza2tBQ3lCRzBO?=
 =?utf-8?B?QTg3Wmg2b0lxbVhPT2diZUFUY2YvVmhURTdISjFEcnFQRE5WRkxBYnZqcXln?=
 =?utf-8?B?RUFUUlZ3d2taUHJTM2dKMVBpRkdxc3BTNkhPVGFSb0NWd2RYKzMrZVEyNXRC?=
 =?utf-8?B?TWYzSFd4Y0M2aDB2Uk1Ia0ZlTUZrNTlwMFYxalJVY29Mank2ZHFnOC9jS3F1?=
 =?utf-8?B?aE5HMHdWb3pPSi9hN1NrNXFmbHN6OUtKY29VYVpWZktVTEN1YWM2am5mS0tL?=
 =?utf-8?B?SGpyREFDWmVvTDhGMnMrZERMQk5QbkNEcFFxWHIxcW43R0dEdHFoN3loYWRP?=
 =?utf-8?B?aTBPdHJRbStSY0ZaTU1lMytQT0ZmbGVNTVNSOWUwZzhId29TVldpdVFqTGh0?=
 =?utf-8?B?VHFleHNXZGhLeGp0N3BkdmpyVVFQNXhmVGNqUkdJOGM1N05vaXV0SzhUYlBG?=
 =?utf-8?B?M3JTMTZhVmd2cnlCN01wSkhoR0phR3duWWFrU3hQTllXT295d0JvTFJYSHhH?=
 =?utf-8?B?M2JXekMwZ0JpSjRYQVo4Tk9sQTRlTkVFbmFPTVRid25zejF0c2paSzlOUHVo?=
 =?utf-8?B?aEg2dmEvZmxKSVJxMnJPc3c5enZIM2oydTV1UkRRYllwOGtPbGdvRlpwcllK?=
 =?utf-8?B?dk5ONTZCYkxDU1dVVEQ4WUFjeWVZSC9BU05Pd1ZjVEhjeHFUMElPQnNZWlFz?=
 =?utf-8?B?T2taRDU5eHM2Z0xZcVZTTUZNRDV3dkRZUlRJUVIvL3VRZDBpcmprbUtybVRr?=
 =?utf-8?B?MFFFVUtjNStzbUtsc3dVRjg4ODd1NDdRNEhoNEFOVTRkVWRGbDd6THZCSnNu?=
 =?utf-8?B?VzVVNXdMZWd2eG1ZOFpZcjQ1WTF0YXRmUDhrRjRsQVpJaDI0QWVKVlR6UFFM?=
 =?utf-8?B?eTlkZW8vYTh6eGpvTUgvOFRGNURiNDdQT2FQM3dnckVWNURHRmdVVTVCK2N2?=
 =?utf-8?B?d251OEtQVmRsdHRXaDg4bWd5bHJmTXJ3c1BBTldhaENrMDF2czVsaWRPdGcr?=
 =?utf-8?B?bTBPQldhZU50em94WE51VFFiM2tldUlzWWpVR1NzbU9xcVBWTHlwNmJCdDJL?=
 =?utf-8?B?MW1GeFVVdnd2a3ltWVRYRURTM1lna1o3Qm9TRFF2QzlXZDFxanJ2WVFoTWti?=
 =?utf-8?B?OTNBOVFDR2hHR0NBb3NRVk5mTWN1R1lWWGFMZGQwSnNnb0tNY2VqWFVVeFds?=
 =?utf-8?B?K3Q0bFpSUzhlaGduSzIxcHM2dkV4Y2pBUUd5MUNubUxzQjhGalhaa2cvYjVB?=
 =?utf-8?B?OW9KeDY4MTRjRllSeDIzb2JYZ216VVhEU09hNFZqZ0doamJuaDhyQyszMjVB?=
 =?utf-8?B?c0lzekkxUzhRK2pQdkJ0cVpPcEJsSHlaTHE0ZytyL2F6Q0pOaG5ITENpdEFE?=
 =?utf-8?B?cU5aSVFmUkttNnM1MU4waFR4QVZ2WjdsR094cVNaU0ZkV0V4WndiMzl4ckEr?=
 =?utf-8?B?Q2NVZkgvSFhIak5WdFp5UFR2clRtT1pPLzlpY0NHb1p6eWxmRjdwTUtpZ3Nj?=
 =?utf-8?B?b0wxTG53NXBFQ1NZSWVwZTkyYys3a0ZIUkxibGJZclg1NENkQm9ab2lTb09v?=
 =?utf-8?B?ZTc0Q0svMUJacG5tTUhyVUhtbVBNZm9SZy9ZUEp6ai9iU1UvZE13U3RQWnkz?=
 =?utf-8?B?SW5zandBdy96UjlDTng2cDBNb2xMaStuNWNHckJsaGhaM3pCcUpkUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0438977-90b3-4661-2b07-08deb7483523
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 14:49:48.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7pO5Bol6Eqbj9hWOJ7svdEOXzcIBY/CYgN2YDxjdNjciUwJ3RlBhxto/u8nVPEx/S6oY8e6XQVxsEJ8Zc6HKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253586-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7771C5A8918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTXVrZXNoIFNhdmFsaXlh
IDxtdWtlc2guc2F2YWxpeWFAb3NzLnF1YWxjb21tLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
eSAyMSwgMjAyNiA4OjQwIFBNDQo+IFRvOiBDYXJsb3MgU29uZyAoT1NTKSA8Y2FybG9zLnNvbmdA
b3NzLm54cC5jb20+OyBNdWtlc2ggU2F2YWxpeWENCj4gPG11a2VzaC5zYXZhbGl5YUBvc3MucXVh
bGNvbW0uY29tPjsgby5yZW1wZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgYW5kaS5zaHl0aUBrZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgQ2FybG9zIFNv
bmcNCj4gPGNhcmxvcy5zb25nQG54cC5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5j
b20+DQo+IENjOiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2
Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2M10gaTJjOiBpbXg6IG1hcmsgSTJDIGFkYXB0ZXIgd2hlbiBoYXJkd2FyZSBpcyBw
b3dlcmVkDQo+IGRvd24NCj4gDQo+IA0KPiANCj4gT24gNS8yMS8yMDI2IDU6MzIgUE0sIENhcmxv
cyBTb25nIChPU1MpIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogTXVrZXNoIFNhdmFsaXlhIDxtdWtlc2guc2F2YWxpeWFAb3NzLnF1
YWxjb21tLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIE1heSAyMSwgMjAyNiA3OjE0IFBNDQo+
ID4+IFRvOiBDYXJsb3MgU29uZyAoT1NTKSA8Y2FybG9zLnNvbmdAb3NzLm54cC5jb20+OyBNdWtl
c2ggU2F2YWxpeWENCj4gPj4gPG11a2VzaC5zYXZhbGl5YUBvc3MucXVhbGNvbW0uY29tPjsgby5y
ZW1wZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgYW5kaS5z
aHl0aUBrZXJuZWwub3JnOyBGcmFuayBMaQ0KPiA+PiA8ZnJhbmsubGlAbnhwLmNvbT47IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPj4gQ2FybG9zIFNvbmcg
PGNhcmxvcy5zb25nQG54cC5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+
ID4+IENjOiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0K
PiA+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2M10gaTJjOiBpbXg6IG1hcmsgSTJDIGFkYXB0ZXIgd2hlbiBoYXJkd2Fy
ZSBpcw0KPiA+PiBwb3dlcmVkIGRvd24NCj4gPj4NCj4gPj4NCj4gPj4gT24gNS8yMS8yMDI2IDQ6
MjEgUE0sIENhcmxvcyBTb25nIChPU1MpIHdyb3RlOg0KPiA+Pg0KPiA+PiBbLi4uXQ0KPiA+Pg0K
PiA+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+Pj4+IEZyb206IE11a2Vz
aCBTYXZhbGl5YSA8bXVrZXNoLnNhdmFsaXlhQG9zcy5xdWFsY29tbS5jb20+DQo+ID4+Pj4+PiBT
ZW50OiBUaHVyc2RheSwgTWF5IDIxLCAyMDI2IDM6NDAgUE0NCj4gPj4+Pj4+IFRvOiBDYXJsb3Mg
U29uZyAoT1NTKSA8Y2FybG9zLnNvbmdAb3NzLm54cC5jb20+Ow0KPiA+Pj4+Pj4gby5yZW1wZWxA
cGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gPj4+Pj4+IGFuZGkuc2h5
dGlAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiA+Pj4+Pj4gcy5o
YXVlckBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBDYXJsb3MgU29uZw0KPiA+
Pj4+Pj4gPGNhcmxvcy5zb25nQG54cC5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5j
b20+DQo+ID4+Pj4+PiBDYzogbGludXgtaTJjQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxp
bnV4LmRldjsNCj4gPj4+Pj4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gPj4+Pj4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gPj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGkyYzogaW14OiBtYXJrIEky
QyBhZGFwdGVyIHdoZW4gaGFyZHdhcmUNCj4gPj4+Pj4+IGlzIHBvd2VyZWQgZG93bg0KPiA+Pj4+
Pj4NCj4gPj4+Pj4+IEhpIENhcmxvcywNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBPbiA1LzIwLzIwMjYg
Mzo0NSBQTSwgQ2FybG9zIFNvbmcgKE9TUykgd3JvdGU6DQo+ID4+Pj4+Pj4gRnJvbTogQ2FybG9z
IFNvbmcgPGNhcmxvcy5zb25nQG54cC5jb20+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBNYXJrIHRo
ZSBJMkMgYWRhcHRlciBhcyBzdXNwZW5kZWQgZHVyaW5nIHN5c3RlbSBzdXNwZW5kIHRvIGJsb2Nr
DQo+ID4+Pj4+Pj4gZnVydGhlciB0cmFuc2ZlcnMsIGFuZCByZXN1bWUgaXQgb24gc3lzdGVtIHJl
c3VtZS4gVGhpcyBwcmV2ZW50cw0KPiA+Pj4+Pj4+IHBvdGVudGlhbCBoYW5ncyB3aGVuIHRoZSBo
YXJkd2FyZSBpcyBwb3dlcmVkIGRvd24gYnV0IGNsaWVudHMNCj4gPj4+Pj4+PiBzdGlsbCBhdHRl
bXB0DQo+ID4+Pj4+PiBJMkMgdHJhbnNmZXJzLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4gd2hhdCB3YXMg
dGhlIHJlYXNvbiBvZiB0aGlzIGhhbmcgPyBJIHdhcyB0aGlua2luZyB5b3UgZG9uJ3QgaGF2ZQ0K
PiA+Pj4+IGludGVycnVwdHMgd29ya2luZyB3aGVuIGNsaWVudCByZXF1ZXN0ZWQgdHJhbnNmZXIg
YnV0IGFkYXB0ZXIgd2FzDQo+ID4+Pj4gc3VzcGVuZGVkLiBQbGVhc2UgY29ycmVjdCBtZSBpZiB3
cm9uZy4NCj4gPj4+Pg0KPiA+Pj4+IEFuZCBpdCB3b3VsZCBiZSBnb29kIHRvIG1lbnRpb24gdGhl
IGFjdHVhbCBwcm9ibGVtIGFuZCB3aHkvaG93IGl0DQo+ID4+IG9jY3VycmVkLg0KPiA+Pj4+Pj4g
Q29kZSBjaGFuZ2VzIGxvb2tzIGZpbmUgdG8gbWUgYnV0IGhhdmUgY29tbWVudCBvbiBjb21taXQg
bG9nLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEl0IHNlZW1zLCB5b3UgYXJlIGFkZGluZyBzdXBwb3J0
IG9mIF9ub2lycSgpIGNhbGxiYWNrcyB0byBhbGxvdw0KPiA+Pj4+Pj4gdHJhbnNmZXJzIGR1cmlu
ZyBzdXNwZW5kL3Jlc3VtZSBub2lycSBwaGFzZSBvZiBQTS4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBX
b3VsZCBpdCBtYWtlIHNlbnNlIGlmIHlvdSBjYW4gd3JpdGUgIlJlcGxhY2Ugc3lzdGVtIFBNIGNh
bGxiYWNrcw0KPiA+Pj4+Pj4gd2l0aCBub2lycSBQTSBjYWxsYmFja3MiIE9SICJBbGxvdyB0cmFu
c2ZlcnMgZHVyaW5nIF9ub2lycSBwaGFzZQ0KPiA+Pj4+Pj4gb2YgdGhlIFBNIG9wcyIgaW5zdGVh
ZCBvZiAibWFyayBJMkMgYWRhcHRlciB3aGVuIGhhcmR3YXJlIGlzDQo+ID4+Pj4+PiBwb3dlcmVk
DQo+ID4+Pj4gZG93biIgPw0KPiA+Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gSGksDQo+ID4+Pj4+
DQo+ID4+Pj4+IFRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cyENCj4gPj4+Pj4NCj4gPj4+Pj4g
QnV0IHRoaXMgcGF0Y2ggaXMgYWRkZWQgaXMgbm90IGZvciBzdXBwb3J0IG5vaXJxIFBNIGNhbGxi
YWNrIG9yDQo+ID4+Pj4+IHRyYW5zZmVyIGluIG5vaXJxDQo+ID4+Pj4gcGhhc2UuDQo+ID4+Pj4+
DQo+ID4+Pj4gT2theSwgbWF5IGJlIGFjdHVhbCBwcm9ibGVtIGRlc2NyaXB0aW9uIGNhbiBoZWxw
IG1lLg0KPiA+Pj4+PiBJbiBmYWN0LCB0aGlzIGZpeCBpcyB0byBtYXJrIHRoZSBJMkMgYWRhcHRl
ciBhcyBzdXNwZW5kZWQgZHVyaW5nDQo+ID4+Pj4+IHN5c3RlbSBub2lycSBzdXNwZW5kIHRvIGJs
b2NrIGZ1cnRoZXIgdHJhbnNmZXJzLCBhbmQgcmVzdW1lIGl0IG9uDQo+ID4+Pj4+IHN5c3RlbSBu
b2lycSByZXN1bWUuIFRoaXMgaXMgdG8gcHJvaGliaXQgSTJDIGRldmljZSBjYWxsaW5nIHRoZQ0K
PiA+Pj4+PiBJMkMgY29udHJvbGxlciBhZnRlciB0aGUgc3lzdGVtIG5vaXJxIHN1c3BlbmQgYW5k
IGJlZm9yZSBub2lycQ0KPiA+Pj4+PiByZXN1bWUsIGJlY2F1c2UgYXQNCj4gPj4+PiB0aGlzIHRp
bWUgdGhlIEkyQyBpbnN0YW5jZSBpcyBwb3dlcmVkIG9mZiBvciB0aGUgY2xvY2sgaXMgZGlzYWJs
ZWQNCj4gPj4+PiAuLi4gU28gSSB3YW50IHRvIGtlZXAgY3VycmVudCBjb21taXQuIEhvdyBkbyB5
b3UgdGhpbms/DQo+ID4+Pj4gY29tcGxldGVseSBNYWtlcyBzZW5zZS4gUGxlYXNlIGhlbHAgYWRk
IGhvdyB0aGlzIHByb2JsZW0gb2NjdXJyZWQNCj4gPj4+PiBhbmQNCj4gPj4gd2h5ID8NCj4gPj4+
PiBTbyB0aGUgY2hhbmdlL2ZpeCB3aWxsIGJlIGdvb2QgdG8gdW5kZXJzdGFuZCBhZ2FpbnN0IGl0
Lg0KPiA+Pj4NCj4gPj4+IEhpLA0KPiA+Pj4NCj4gPj4+IEluIHNvbWUgSS5NWCBwbGF0Zm9ybSwg
c29tZSBJMkMgZGV2aWNlcyB3aWxsIGtlZXAgYSB3b3JrIHF1ZXVlIGFsbA0KPiA+Pj4gdGltZSwg
dGhlIHdvcmsgcXVldWUgd2lsbCB0cmlnZ2VyIEkyQyB4ZmVyIGV2ZXJ5IG9uY2UgaW4gYSB3aGls
ZSwNCj4gPj4+IGJ1dCB0aGUgd29yaw0KPiA+PiBxdWV1ZSBzaG91bGRuJ3QgYmUgZnJlZSBpbiBz
eXN0ZW0gc3VzcGVuZC4NCj4gPj4+DQo+ID4+DQo+ID4+IHdvcmsgcXVldWUgaGFzIHRyYW5zZmVy
cyBxdWV1ZWQgZXZlbiBpZiBzeXN0ZW0gaXMgc3VzcGVuZGVkID8gSU1PLA0KPiA+PiB0aGUgY2xp
ZW50IGkyYyBkZXZpY2VzIHNob3VsZCBub3QgbGV0IHN5c3RlbSBnbyB0byBzdXNwZW5kLg0KPiA+
Pg0KPiA+DQo+ID4gSGkgTXVrZXNoLA0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB0aGUgZGV0YWls
ZWQgZGlzY3Vzc2lvbi4NCj4gPg0KPiA+IFllcywgSSB0b3RhbGx5IGFncmVlIHRoYXQgSTJDIGNs
aWVudCBkcml2ZXJzIHNob3VsZCBpZGVhbGx5IHN0b3ANCj4gPiBpc3N1aW5nIHRyYW5zZmVycyB3
aGVuIHRoZSBzeXN0ZW0gaXMgc3VzcGVuZGluZy4NCj4gPg0KPiA+IEhvd2V2ZXIsIGluIHByYWN0
aWNlIHRoZXJlIGFyZSBtYW55IGRpZmZlcmVudCBJMkMgY2xpZW50cywgYW5kIG5vdCBhbGwNCj4g
PiBvZiB0aGVtIHN0cmljdGx5IGFkaGVyZSB0byB0aGlzIHJlcXVpcmVtZW50LiBTb21lIGNsaWVu
dHMgbWF5IHN0aWxsDQo+ID4gdHJpZ2dlciB0cmFuc2ZlcnMgdGhyb3VnaCB3b3JrcXVldWVzIG9y
IGRlZmVycmVkIGNvbnRleHRzIGR1cmluZyB0aGUNCj4gPiBzdXNwZW5kL3Jlc3VtZSB3aW5kb3cu
DQo+ID4NCj4gPiBUaGVyZWZvcmUsIGFkZGluZyB0aGlzIHByb3RlY3Rpb24gYXQgdGhlIEkyQyBj
b250cm9sbGVyIHNpZGUgaGVscHMgdG8NCj4gPiBhdm9pZCB1bmV4cGVjdGVkIGFjY2Vzc2VzIHdo
ZW4gdGhlIGhhcmR3YXJlIHJlc291cmNlcyBhcmUgdW5hdmFpbGFibGUsDQo+ID4gbWFraW5nIHRo
ZSBzeXN0ZW0gbW9yZSByb2J1c3QuDQo+ID4NCj4gDQo+IEFncmVlZCAhDQo+IA0KPiA+Pj4gV2l0
aGluIGEgdmVyeSBzaG9ydCB0aW1lIHdpbmRvdywgcG9zc2libHkgZnJvbSBub2lycV9zdXNwZW5k
IHRvIHRoZQ0KPiA+Pj4gc3lzdGVtIGFjdHVhbGx5IGJlaW5nIHN1c3BlbmRlZCwgb3IgcG9zc2li
bHkgZnJvbSB0aGUgc3lzdGVtDQo+ID4+PiBzdGFydGluZyB0byByZXN1bWUgdG8gYmVmb3JlIG5v
aXJxX3Jlc3VtZSwgdGhpcyB3b3JrIHF1ZXVlIHdpbGwNCj4gPj4+IHRyaWdnZXIgYW4gSTJDIHRy
YW5zZmVyLCBhbmQgYXQgdGhpcyB0aW1lIHRoZSBJMkMgY29udHJvbGxlcidzIGNsaw0KPiA+Pj4g
YW5kIHBpbmN0cmwgaGF2ZSBub3QgeWV0IGJlZW4gcmVzdG9yZWQsIHJlYWRpbmcgYW5kDQo+ID4+
DQo+ID4+IFJpZ2h0LCB0aGlzIGtpbmQgb2YgZXhwbGFpbnMgdGhlIHByb2JsZW0gdG8gbWUuIEkg
dGhpbmsgeW91IGFyZQ0KPiA+PiB0cnlpbmcgdG8gc2VydmUgaTJjIHRyYW5zZmVycyB3aGVuIHlv
dXIgcmVzb3VyY2VzKGNsaywgcGluY3RybCkgYXJlDQo+ID4+IG5vdCB0dXJuZWQgT04gYW5kIGFs
c28gaW50ZXJydXB0IHJlbWFpbnMgZGlzYWJsZWQuIEFuZCB0aGF0J3Mgd2h5IHlvdQ0KPiA+PiBu
ZWVkIHRvIGFkZA0KPiA+PiBfbm9pcigpIFBNIGNhbGxiYWNrcyBzdXBwb3J0cyBhbG9uZyB3aXRo
IElSUUZfTk9fU1VTUEVORCB8DQo+ID4+IElSUUZfRUFSTFlfUkVTVU1FIGZsYWdzLg0KPiA+Pg0K
PiA+Pj4gd3JpdGluZyBJMkMgcmVnaXN0ZXJzIGNhdXNlcyB0aGUgc3lzdGVtIHRvIGhhbmcuIFRo
aXMgcGF0Y2ggbWFrZSBhbGwNCj4gPj4+IEkyQyBvcGVyYXRpb25zIGFyZSBwZXJmb3JtZWQgaW4g
YSBzYWZlIGhhcmR3YXJlIHN0YXRlLg0KPiA+Pj4NCj4gPj4+IElzIGl0IGJldHRlciBpZiBJIGFk
ZCB0aGVzZSBjb21tZW50IHRvIHBhdGNoIGNvbW1pdCBsb2c/DQo+ID4+Pj4+DQo+ID4+IGlmIG15
IGxhdGVzdCBjb21tZW50cyBtYWtlcyBzZW5zZSBhZ2FpbnN0IHRoZSBpc3N1ZSwgeW91IG1heSB3
cml0ZQ0KPiA+PiBhY2NvcmRpbmdseS4gaWYgaSBhbSB3cm9uZywgdGhlbiB5b3VyIGV4cGxhbmF0
aW9uIG1ha2VzIHNlbnNlLiBDYXVzZQ0KPiA+PiBvZiB0aGUgaGFuZyBuZWVkcyB0byBiZSBjbGVh
cmx5IG1lbnRpb24gaW50IHRoZSBjb21taXQgbG9nIGluIHlvdXIgbmV4dA0KPiBwYXRjaC4NCj4g
Pj4NCj4gPg0KPiA+IEJhc2VkIG9uIG91ciBkaXNjdXNzaW9uLCBJIGhhdmUgdXBkYXRlZCB0aGUg
Y29tbWl0IGxvZyBhcyBiZWxvdzoNCj4gPg0KPiA+IE9uIHNvbWUgaS5NWCBwbGF0Zm9ybXMsIGNl
cnRhaW4gSTJDIGNsaWVudCBkcml2ZXJzIGtlZXAgYSBwZXJpb2RpYw0KPiA+IHdvcmtxdWV1ZSB3
aGljaCBjb250aW51ZXMgdG8gdHJpZ2dlciBJMkMgdHJhbnNmZXJzLg0KPiA+DQo+ID4gRHVyaW5n
IHN5c3RlbSBzdXNwZW5kL3Jlc3VtZSwgdGhlcmUgZXhpc3RzIGEgdGltZSB3aW5kb3cgYmV0d2Vl
bjoNCj4gPiAgICAtIG5vaXJxX3N1c3BlbmQgYW5kIGZ1bGwgc3VzcGVuZA0KPiA+ICAgIC0gcmVz
dW1lIHN0YXJ0IGFuZCBub2lycV9yZXN1bWUNCj4gDQo+IC0gbm9pcnFfcmVzdW1lIGFuZCByZXN1
bWUgc3RhcnQgW0p1c3Qgb3Bwb3NpdGUgP10NCj4gDQoNClNvcnJ5LCB0aGUgZXhwcmVzc2lvbiBp
cyBhbWJpZ3VvdXMuDQoNCkkgd2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBsb2cgdG86DQoNCkR1cmlu
ZyBzeXN0ZW0gc3VzcGVuZC9yZXN1bWUsIHRoZXJlIGV4aXN0cyBhIHRpbWUgd2luZG93IGJldHdl
ZW46DQogIC0gc3VzcGVuZF9ub2lycSBhbmQgdGhlIHN5c3RlbSBlbnRlcmluZyBzdXNwZW5kDQog
IC0gdGhlIHN5c3RlbSBzdGFydGluZyB0byByZXN1bWUgYW5kIHJlc3VtZV9ub2lycQ0KDQpEb2Vz
IHRoaXMgbG9vayBnb29kIHRvIHlvdT8NCg0KPiA+DQo+ID4gSW4gdGhpcyB3aW5kb3csIHRoZSBJ
MkMgY29udHJvbGxlciByZXNvdXJjZXMgc3VjaCBhcyBjbG9jayBhbmQgcGluY3RybA0KPiA+IG1h
eSBhbHJlYWR5IGJlIGRpc2FibGVkIG9yIG5vdCB5ZXQgcmVzdG9yZWQuDQo+ID4NCj4gPiBJZiBh
IHdvcmtxdWV1ZSB0cmlnZ2VycyBhbiBJMkMgdHJhbnNmZXIgaW4gdGhpcyBwZXJpb2QsIHRoZSBk
cml2ZXINCj4gPiBhdHRlbXB0cyB0byBhY2Nlc3MgSTJDIHJlZ2lzdGVycyB3aGlsZSB0aGUgaGFy
ZHdhcmUgcmVzb3VyY2VzIGFyZQ0KPiA+IHVuYXZhaWxhYmxlLCB3aGljaCBtYXkgbGVhZCB0byBz
eXN0ZW0gaGFuZy4NCj4gPg0KPiA+IE1hcmsgdGhlIEkyQyBhZGFwdGVyIGFzIHN1c3BlbmRlZCBk
dXJpbmcgbm9pcnEgc3VzcGVuZCBhbmQgYmxvY2sgbmV3DQo+ID4gdHJhbnNmZXJzIHVudGlsIHJl
c3VtZSwgZW5zdXJpbmcgdGhhdCBJMkMgdHJhbnNmZXJzIGFyZSBvbmx5IGlzc3VlZA0KPiA+IHdo
ZW4gaGFyZHdhcmUgcmVzb3VyY2VzIGFyZSBhdmFpbGFibGUuDQo+ID4NCj4gPiBEb2VzIHRoaXMg
bG9vayBnb29kIHRvIHlvdT8NCj4gPg0KPiBMb29rcyBnb29kLCBUaGFua3MgIQ0KPiANCj4gPj4+
Pg0KPiA+Pj4NCj4gPg0KDQo=

