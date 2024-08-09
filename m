Return-Path: <stable+bounces-66124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FA94CC8B
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37811C20D03
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B718E056;
	Fri,  9 Aug 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RCVS78DB"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58041219E1;
	Fri,  9 Aug 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193117; cv=fail; b=DgROCE2ilZtEHiZdSeKk7a2GuGI35LoyC34eBJOhpNQ5eSz+JE7u+xCIDCyUXkRkOD8Yvk4Gy2TNp3YYoZ+V+hsTBsjLmUftRNcckrAhBTt0oJFTlnzVVP4NVKqVWoWPdSwRMBdovYr7+SyRvmDEwm1u0j5GGklaDT7UJBFlgM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193117; c=relaxed/simple;
	bh=RUS4KHgmJnb/aMkQOCMviNXzGydqhFmYS6W4GUoEKrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFi2543AkMBitsY+dCcxk72r8BNCxlH9be905f4NOdAUfzNN26LAYBKrZOCqaMb8sIsZx2aOqpVgQAhevy2TnCqK78l9WILejAq/+bkwFFNOg4HowSD+ROWZp14lUUMZGcnYyl6mbX4dxaOXmVDJZoy22Z3MqnhbO30Kb4TdMno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RCVS78DB; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ42UtpJEgm1swbz1N6EGEx8dry2Vcq7l5l+9iBr+oxV0pzSwfm2PdNuoqXLA6UBu5TGD62OeskQNY8/icDN/VzN76IKc+wR8/Qz08d6P2KHwQM4Sl67sxmUCdSVYHgwP4Pf93pDeJLSwujE9t+C+fYTDUzJNFzLm08Cmgktepi66hvtIEjZAQO6k7ebiDDuyMkuAbnnJymivWR3xf8lITY6Yb9fhrh0aFzdQD1D2+UphdXa9HOmE2Mqhtb7TyQVFYUuO+XAZPHLJPeMph/DxWL854AWxp0l1HMNHOAkvnN1VLnViJNdIP6ZwmTRVCmpHbeawbrwoFiwKmf4weFdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUS4KHgmJnb/aMkQOCMviNXzGydqhFmYS6W4GUoEKrw=;
 b=lypCzI5b1uJtuWvJjcSsEL5Nwj73TZ+AVtcQn3uz4hfvebJASvb2v+JA/jgkT5Vb+P0iqvTPD6YJ+Lm50kPsPoJ3+h2OkVhVasQBncyTfyfxi+gZ1lPgrx9hjMF4TxLoQxXVYR7qH6Ip/NqY1I1iHDnI9j2kM35trbzU+J/tPX9i1pCUolTQZykSdZ96xZmHgyHP+WJETXz/3qLOLOzM+SbSP4eHL4IvukIeBseMxljQVNp4a5nTWlhE19JdaLrYadnMqB2D+stPWipEUtXchPdbjke1cV0D4VwzTjk7pauMJsh1VNQWvuveqCHn08jLLY0Kf5lGo/7YWgIX1lFEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUS4KHgmJnb/aMkQOCMviNXzGydqhFmYS6W4GUoEKrw=;
 b=RCVS78DB09biQKXJAY8zI9RsRpMAJf/kbT4X56AizmGDkMLzq7JdZP+NX0jtDRZEpb3CddciNdhW4+2Az5UdJU2qHf6J1NOe2PGcJbbAOFDdrEIMt7vGogZWOz2F7HSB4BZo/Czwpk/xocfi4z5A+TsAyMrRPpZRFyZNLOGQKjjbBtYCCZv5PbmKvzurPPK7A90AiLfI6XviFV7lVdztffI3/jaLKq09C0JXm2xytVBuXNwe14c1vkrpCefMn0TZbCxoUTV4emSqBBHVF1ZmAojEvAlJn2rlZ4O4xz+CDLpYDWd30PxamM2gLLbfyvjPcuIZY270umDG3YcMK0ibtw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7411.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 08:45:12 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 08:45:12 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Niklas Cassel <cassel@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "tj@kernel.org" <tj@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Thread-Topic: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Thread-Index:
 AQHa2aEYMAHnp4ur4EKNGMJk8l3hQbIEgLWAgA7NqZCACTJ0gIABA1qAgAAnWoCAAQ7C8A==
Date: Fri, 9 Aug 2024 08:45:12 +0000
Message-ID:
 <AS8PR04MB86765DB41F64B3FBF3DAFCAA8CBA2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
 <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
 <Zp/Uh/mavwo+755Q@x1-carbon.lan>
 <AS8PR04MB867612E75A6C08983F7031528CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZrP2lUjTAazBlUVO@x1-carbon.lan>
 <ZrTQJSjxaQglSgmX@lizhi-Precision-Tower-5810>
 <ZrTxJzmWJyH2P0Ba@x1-carbon.lan>
In-Reply-To: <ZrTxJzmWJyH2P0Ba@x1-carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM8PR04MB7411:EE_
x-ms-office365-filtering-correlation-id: 04e1863d-348f-4cf7-40d7-08dcb84f9506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?eTlaaWRvM3ZjYjBLNGNTbUNGdEdPaHhHdTd5MU9HYlVCWUU0dGF0OVU5UXZ5?=
 =?gb2312?B?RTVqUDA2MldPUUJBVnZ1N25CUUlGRDRydS9rWlZUV2RtcDNpTmQyVC8vUVNu?=
 =?gb2312?B?dENHdGlVaDVwRlovdExPY1BYVnMxRG1PcnQ2RXhYMHNvZy9WckdXRXJlS0M4?=
 =?gb2312?B?c1VwSTc5U2lOTitZOFVvSytDbUJWQ09QWkJVSVRTakRCZXNsVkhaREdoS0NE?=
 =?gb2312?B?UUFnTzRUZ2ZDVVdaRHNjZjlaSlVEb1NpNEVUbndUeW8vQy92UkJwNnJkeHpM?=
 =?gb2312?B?bnU2cHhoMUV3TnB6VHI1S25xM3FrZVZCN3FOSWVLT29jai9NTExZaFE5aUI3?=
 =?gb2312?B?K3gxYnhxMlc1MFN5RFp6ZjJ1RWdla2hkTG1aNHIrU0xKTEQ4MlZnRVdBbmZy?=
 =?gb2312?B?U2pYVW93eS92NHJ1SEM3WXFadmtlWlhoamJkNHg5ZUNzRUxicVQwRkprRlhw?=
 =?gb2312?B?TGcwTEZXbGUwclV5RVZzODRxNCs5TTlhVmY5aFFZTzliOC9mMEFJcVdRSFYw?=
 =?gb2312?B?S2RDb1EwM2JyeWZOcVVYeGZQV2hiOUtIc1JXdE9IU0FNRnIyNEswUmtpb0Zy?=
 =?gb2312?B?OFkzOG1LOVBoMEtJUlhCdExYOHF1VDNxWXgyeExoeEdwOWFvV2tRQU0vS2V1?=
 =?gb2312?B?M1J2SGpUMTVYK3dNLytSQXpKRUk4OWM5UFJ1YjhUOVpLZ1E4TE4vZHhJMGhF?=
 =?gb2312?B?M242eFFHR0hFa1FCWGJrak4vRlJFODhGeGh0OVlQN1FZQlhXNHhSS3UrZFgw?=
 =?gb2312?B?Q0o4N1pDaXNwMU5qQy9QV241RUpUREIzb0d1b2FJcDYwR1cxME4xcVIvYkZW?=
 =?gb2312?B?T1NONVQvNll6MFI5VHFHNXp1cWdhbnpwUmIrOERaSUNWWjJvRmZDZGVVUmVj?=
 =?gb2312?B?a1NrQ1NaRGZCSXJQbFUrVy9pVU02Ukd2TW5jMWpvNVc4bjJIbjJHc1ZyZ1Zp?=
 =?gb2312?B?VkcvRkx4d2ZqTHlpVFFyV3JWeUY4bnczY3hwQ254YXNFN1JoUHJ6QXorUFlW?=
 =?gb2312?B?WW42U2NTTGF1aHcwTHlzdFNLVWI4TGxKMW9oRTNPYXdqQW8zcVJ1VzQrUW5I?=
 =?gb2312?B?T2svSjNnVTJTMUVDWkJteU40VGk0T1hVdnJDa2tRRDdSYWppcWJNOFQ0bVEx?=
 =?gb2312?B?M2NsSzA5TndKNG5LSUdPT0FWdEd6SXAvd283UUxnU0tQQnZzYVNJQUhHcEdB?=
 =?gb2312?B?a3d3N2lVd1c5ODdyYjJ4UnhyQTlCZGU5ZGhZRitqUzc4eS9sUEJBUjZDYTk2?=
 =?gb2312?B?ZmpCM3RvYmdnZGMyMlMwN0tkR1BFV1hqUVFFWDk3dlR1dExqRy9xZTYxK2Y5?=
 =?gb2312?B?Ukx6MjZJQnI1QW1WNEJZeU5TM2hrVWE0ak1SN0ZiVXZWN1ZqV0xLN1RZVEgv?=
 =?gb2312?B?ZkxxOW9COXZZNDNySDU2MlBZekQxYUpQajZhLzdMa0Fic1lLalhIVktsZS8w?=
 =?gb2312?B?SGNuSlloazV0NlNuVFQ3U09RNXNTSDUyM0p4YjEwV2tCa0FtWThKRXZkRjNk?=
 =?gb2312?B?dE5iUFRkY0VBalgyTVk1WTB3SFVEdnp0aE1hSCs3R3ZYazhhc0NLL01tVkFQ?=
 =?gb2312?B?bnd1Y1pGY1NCVW1QV00vWTFmZTJmdDljMk1UZWlJWEh2ZTl5RXc1NzdpUmZI?=
 =?gb2312?B?L1FIN3hzWkY0UmZZbUFhZEhnTmptZlZUeitEM3IrVWE4aG1jbHBCNjBmWFEv?=
 =?gb2312?B?U2ZjZGpBckNxZmtUWmt3TU5ydk5GZ3pMcGhJY1FWbWxUMWR3WkFFK2tTaGpu?=
 =?gb2312?B?VHdDMzRLbzlzNER1UTVIcFV6MFNiVlBualJTZUtPMkJlMDNxNjF6SzZlcXZN?=
 =?gb2312?Q?qvJXC3HYTy4nuwg3XVxUKno+Ozqw9nFCvwJTQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?R0d3dTFvbzJOSGNCT2RmL2FqK2U0Nnh6NFpyMnhuYkR4YjNlZXZWdEFJUGkw?=
 =?gb2312?B?UnJidHFVKytGRFRoaC9ERC9kTk80cWxxTktLelVDRFI5MmVUQUtNWU1mbXEr?=
 =?gb2312?B?aU9NejRlcW1zN1VMZDFvY3FnZkgxUlQzaXhPSG5wbHB6MFFQMjhsdVJabDJN?=
 =?gb2312?B?c0w5YUxxQjIwanZkSWg0QVl1UGFGcHF5cjFJeGh1UVU3cFE3QkFvZ3ppbW9I?=
 =?gb2312?B?WE9wUE5pbkUzaFZIMUNaditaMm9lNTVnWk5NY29Pb25wWE1TMkRZVnhCUmg5?=
 =?gb2312?B?R3VDd3UrMExVOElqK3c0Vnl4eEJyQnJpcURDVmh6dmdlL0lRYS8zNS9XbFZW?=
 =?gb2312?B?UGNKa3BvaUFzODJzWm5GRi92VUxOL3djanIwSGw5bk1HZFpZcFVoTHVFc0U4?=
 =?gb2312?B?bEpuamF1OTMycVd1SGE3c0Rrd1FvT09WWm5MN0NPbGdPZUhienJvenBEcHk0?=
 =?gb2312?B?VjFiWWZmMTh0aXpKc013R1lXUHg2Qk1LbTBtQlIxYk13bGh3SGY0NUpOOU9L?=
 =?gb2312?B?aW5WNzFPeUxuTlpiVzRMSWd3cFVqRzZvcitpNGE5aC8zeTRtWXFxdXJ3TS90?=
 =?gb2312?B?Qm96N25JNWJLT3V3bGF6T1pZYVVUMkNDL05lcUN4bklXM2RiRVRoUjJYK3FQ?=
 =?gb2312?B?dXRJbmdaRDFvbEF4czllMHBkT2ZVbVc5eUJkTU1RKzJQVmdSeFFKTTVFS0o2?=
 =?gb2312?B?MEwyMnB4QS95OHN4NXJOdzZDaFZ0SkVxa3ZuWDUyb1FkT2JkK0ZEODRyK0pU?=
 =?gb2312?B?Z0RTQXNlNGpWTms3S20xcElXaUhYdUJaazBmc0tpYjBVZ2ZXcFFBNHV2dW5K?=
 =?gb2312?B?a3l4TW1paWJ2cS9EbUJJQUgzSmNrTjIrcDJYbWZTZEFkT2ZhUm5LcEhrREVX?=
 =?gb2312?B?Z2xBTllkMC9ZcGZzUGxsbllCaWN6N1hMRGs1Vk1ZQjk3ZVVtSWJhNVlWQlQ0?=
 =?gb2312?B?bXZXdVd5L09iNjdFYWZyWG9aeVU2d3dXbXg2K2d1RnFyRHU5bUxFY3lLc2FI?=
 =?gb2312?B?enp4MkRzRjNobUxHc1Q5L2RucVU4OXRBUjc0bEZGWTBpS0NtWEoxSks3S0dT?=
 =?gb2312?B?RWtmMllwaUdISSs2QUFFRlJMVWNuZ1BaUTRoVldScUFqenUrb3FFdklkTnUx?=
 =?gb2312?B?bHY2TmdldDQxSHFxNGdGZTltbjQyQitvTzhFVTd4bTFOSWdPOXZPbVlTREVq?=
 =?gb2312?B?T0NJSjNFOGJjeThTa2ZFUnl6TGZjcjZRWlVPWEFjZ2xlQ05OdFNFSXVUbzhv?=
 =?gb2312?B?Y2FWb0FrK2t1S3A1K0FtT1N3NXR1VEdxQ0c4b0YrK1FvRG8rUTRsMDhFRmdJ?=
 =?gb2312?B?TGxSRTVQSXNVbzdwem1BK2xyb3BLVjM3R09TK3lUK09VZEZRV0h2aG91MG5r?=
 =?gb2312?B?bDhDRzQxMVJZb3cxbUdIZHBVLy93TnZtNnRwRGFHdFhvV2NGcElGWjc2Q2Vr?=
 =?gb2312?B?ZTB1dlY3YzVScHh3OW1kWUZjbGQ0V1dEK0k2NUp4aXZ6b2J4VmRKMENxdkRN?=
 =?gb2312?B?elFsQ3NWaGI0RGNHMDZ1Rm42c3ZhN21Pb0RaalY0RzB2Wlg0L1l2TnltUmYy?=
 =?gb2312?B?RWVackt1YmluUmFJb0Z2UnIxN3dSRmZJKzRUWDlURTRZL01DWUpJK2FDNENi?=
 =?gb2312?B?TEs3cHppSzY0eXpZRk9lWm4wakx5VFNoSlc1T0l3RWVVSnZHUU5lSFpxbGFC?=
 =?gb2312?B?M2tmenNmS240djhjeVEvczVOTHdLcDVKc0JBMTg2UjRkNDVFUndqVkdjU1Nn?=
 =?gb2312?B?YlVTQXZScGQ3dTA3Y1ZsZkR5QUk3TERyN3daL1IxSWxFSVVBNzVZM3JvUHR2?=
 =?gb2312?B?dmlxcHRaUlQ0TURJcnpIQnIwOCt2akw1UFExZkJOTGFuYnpseXFhaitIZ0hP?=
 =?gb2312?B?RlgrcjRIeGNmUTlGQ01ZSjQvWU9OVXZOQ0RQU0dyRW95V0IyU2RON3pFNnl3?=
 =?gb2312?B?THg5ZjN1WTEyOWMzalNFeGd1TnVRRkFSMHZhR2d5bDh5K25PSnloOEZ4T1Fv?=
 =?gb2312?B?VGRJb0dzaGJHeURzMUcyWW11YzBwQm0rajhLd2N5SnFkRlV3ekhpaS8wVWNP?=
 =?gb2312?B?VHl5WHFkNEFVczl3aUVUeXdyZFZMWmJvYjBjWVB1VlVQMG5iYlFXdFByMnBa?=
 =?gb2312?Q?veOmT7Kl16xCdOc8WGQMGKvKW?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e1863d-348f-4cf7-40d7-08dcb84f9506
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:45:12.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktMVLV6o6ssNHdW29ETa6RFDyOlgML4n2wppjZjAWXSmdNpUOTL4YBB9yney7yrrpAVY331xwa0ynNtCmdkOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7411

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtsYXMgQ2Fzc2VsIDxjYXNz
ZWxAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNMTqONTCOcjVIDA6MjQNCj4gVG86IEZyYW5rIExp
IDxmcmFuay5saUBueHAuY29tPg0KPiBDYzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhw
LmNvbT47IHRqQGtlcm5lbC5vcmc7DQo+IGRsZW1vYWxAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwu
b3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNv
bTsgbGludXgtaWRlQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsNCj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxpbnV4
LmRldjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQg
NC82XSBhdGE6IGFoY2lfaW14OiBBZGQgMzJiaXRzIERNQSBsaW1pdCBmb3IgaS5NWDhRTQ0KPiBB
SENJIFNBVEENCj4gDQo+IE9uIFRodSwgQXVnIDA4LCAyMDI0IGF0IDEwOjAzOjE3QU0gLTA0MDAs
IEZyYW5rIExpIHdyb3RlOg0KPiA+IE9uIFRodSwgQXVnIDA4LCAyMDI0IGF0IDEyOjM1OjAxQU0g
KzAyMDAsIE5pa2xhcyBDYXNzZWwgd3JvdGU6DQo+ID4gPiBPbiBGcmksIEF1ZyAwMiwgMjAyNCBh
dCAwMjozMDo0NUFNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+
ID4gSGkgTmlrbGFzOg0KPiA+ID4gPiBJJ20gc28gc29ycnkgdG8gcmVwbHkgbGF0ZS4NCj4gPiA+
ID4gQWJvdXQgdGhlIDMyYml0IERNQSBsaW1pdGF0aW9uIG9mIGkuTVg4UU0gQUhDSSBTQVRBLg0K
PiA+ID4gPiBJdCdzIHNlZW1zIHRoYXQgb25lICJkbWEtcmFuZ2VzIiBwcm9wZXJ0eSBpbiB0aGUg
RFQgY2FuIGxldA0KPiA+ID4gPiBpLk1YOFFNIFNBVEEgIHdvcmtzIGZpbmUgaW4gbXkgcGFzdCBk
YXlzIHRlc3RzIHdpdGhvdXQgdGhpcyBjb21taXQuDQo+ID4gPiA+IEhvdyBhYm91dCBkcm9wIHRo
ZXNlIGRyaXZlciBjaGFuZ2VzLCBhbmQgYWRkICJkbWEtcmFuZ2VzIiBmb3IgaS5NWDhRTQ0KPiBT
QVRBPw0KPiA+ID4gPiBUaGFua3MgYSBsb3QgZm9yIHlvdXIga2luZGx5IGhlbHAuDQo+ID4gPg0K
PiA+ID4gSGVsbG8gUmljaGFyZCwNCj4gPiA+DQo+ID4gPiBkaWQgeW91IHRyeSBteSBzdWdnZXN0
ZWQgcGF0Y2ggYWJvdmU/DQo+ID4gPg0KPiA+ID4NCj4gPiA+IElmIHlvdSBsb29rIGF0IGRtYS1y
YW5nZXM6DQo+ID4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZkZQ0KPiA+ID4gdmljZXRyZWUtc3BlY2lmaWNhdGlvbi5y
ZWFkdGhlZG9jcy5pbyUyRmVuJTJGbGF0ZXN0JTJGY2hhcHRlcjItZGV2aWMNCj4gPiA+DQo+IGV0
cmVlLWJhc2ljcy5odG1sJTIzZG1hLXJhbmdlcyZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUl
NDBueHAuY28NCj4gbQ0KPiA+ID4gJTdDYjE4MTU5ZjdhYTQyNGYzZTBkOGYwOGRjYjdjNjhmMzgl
N0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWMNCj4gNWMzMDE2DQo+ID4gPg0KPiAzNSU3QzAlN0Mw
JTdDNjM4NTg3MzEwNjMxMTIyMDc4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5Sg0KPiBXSWpv
aU1DNHcNCj4gPiA+DQo+IExqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lM
Q0pYVkNJNk1uMCUzRCU3QzAlN0MlN0MlDQo+IDdDJg0KPiA+ID4NCj4gc2RhdGE9dVlKRkY3TWNp
NGowNjhMRjFFdzhxckZ2YzFwenJtV2hKUzBVcWFXdHZZUSUzRCZyZXNlcnZlZD0wDQo+ID4gPg0K
PiA+ID4gImRtYS1yYW5nZXMiIHByb3BlcnR5IHNob3VsZCBiZSB1c2VkIG9uIGEgYnVzIGRldmlj
ZSBub2RlIChzdWNoIGFzDQo+ID4gPiBQQ0kgaG9zdCBicmlkZ2VzKS4NCj4gPg0KPiA+IFllcywg
MzJiaXQgaXMgbGltaXRlZCBieSBpbnRlcm5hbCBidXMgZmFyYmljLCBub3QgQUhDSSBjb250cm9s
bGVyLg0KPiANCj4gSWYgdGhlIGxpbWl0IGlzIGJ5IHRoZSBpbnRlcmNvbm5lY3QvYnVzLCB0aGVu
IHRoZSBsaW1pdCB3aWxsIGFmZmVjdCBhbGwgZGV2aWNlcw0KPiBjb25uZWN0ZWQgdG8gdGhhdCBi
dXMsIGkuZS4gYm90aCB0aGUgUENJZSBjb250cm9sbGVyIGFuZCB0aGUgQUhDSSBjb250cm9sbGVy
LCBhbmQNCj4gdXNpbmcgImRtYS1yYW5nZXMiIGluIHRoYXQgY2FzZSBpcyBvZiBjb3Vyc2UgY29y
cmVjdC4NCj4gDQo+IEkgZ3Vlc3MgSSdtIG1vc3RseSBzdXJwcmlzZWQgdGhhdCBpLk1YOFFNIGRv
ZXNuJ3QgYWxyZWFkeSBoYXZlIHRoaXMgcHJvcGVydHkNCj4gZGVmaW5lZCBpbiBpdHMgZGV2aWNl
IHRyZWUuDQo+IA0KPiBBbnl3YXksIHBsZWFzZSBzZW5kIGEgdjUgb2YgdGhpcyBzZXJpZXMgd2l0
aG91dCB0aGUgcGF0Y2ggaW4gJHN1YmplY3QsIGFuZCB3ZQ0KPiBzaG91bGQgYmUgYWJsZSB0byBx
dWV1ZSBpdCB1cCBmb3IgNi4xMi4NCkhpIE5pa2xhczoNClRoYW5rIHlvdSB2ZXJ5IG11Y2guDQpJ
IGhhZCBhbHJlYWR5IHNlbnQgb3V0IHRoZSB2NSBzZXJpZXMgcGF0Y2gtc2V0IGEgZmV3IGRheXMg
YWdvLg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWFybS1rZXJu
ZWwvY292ZXIvMTcyMjU4MTIxMy0xNTIyMS0xLWdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodUBu
eHAuY29tLw0KQlRXLCBJJ20gYSBsaXR0bGUgY29uZnVzZWQgYWJvdXQgIiB3aXRob3V0IHRoZSBw
YXRjaCBpbiAkc3ViamVjdCwiLg0KRG8geW91IG1lYW4gdG8gcmVtb3ZlIHRoZSAiUEFUQ0giIGZy
b20gU3ViamVjdCBvZiBlYWNoIHBhdGNoPw0KdjU6DQpTdWJqZWN0OiBbUEFUQ0ggdjUgMS81XSBk
dC1iaW5kaW5nczogYXRhOiBBZGQgaS5NWDhRTSBBSENJIGNvbXBhdGlibGUgc3RyaW5nDQp2NiB3
aXRob3V0IHBhdGNoIGluICRzdWJqZWN0Og0KU3ViamVjdDogWyB2NiAxLzVdIGR0LWJpbmRpbmdz
OiBhdGE6IEFkZCBpLk1YOFFNIEFIQ0kgY29tcGF0aWJsZSBzdHJpbmcNCklmIHllcywgSSBjYW4g
ZG8gdGhhdCBhbmQgYWRkIEZyYW5rJ3MgcmV2aWV3ZWQtYnkgdGFnIGluIHRoZSB2NiBzZXJpZXMu
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+
IE5pa2xhcw0K

