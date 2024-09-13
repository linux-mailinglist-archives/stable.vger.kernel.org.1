Return-Path: <stable+bounces-76093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94006978595
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAE21C221C9
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C74D8BB;
	Fri, 13 Sep 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xqNHuS3w"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D714A21;
	Fri, 13 Sep 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244226; cv=fail; b=anfLeDgqZy61UZ+qs5BTS/ed89VR4HPpjnQmyhIrnlySo5QzOAUppErTMjALguNBayoF7WspcdzOdoTrlC3M13bJF2iHQBNI2NuJDoGA8VnfRMpMXyE9sfu6uiwJiAsgCbDdnfU3BNlhxKv52w4ax/HLQtOc5NJgjpS/BUh+LJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244226; c=relaxed/simple;
	bh=ojKNMPVQLAycQUIeSan8uALfsRsaYqxUnV45dnTKA9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMy21jKzqgDhhoxZWw+mgP/GL9mS8cmZWf7+KuKiAhQUcAOdoR0OTOjDrOwr72+FLmPMy+FifORSCTZc+LE0H3BULDXKqgSYL/uAupj6ErJce1ceehxGkIAm5jjVAw5EHC4o8kUh8RyX3CBMukp5cI1B9yGu5SS5N+m9ZILGEDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xqNHuS3w; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1ijSn2HPxONIgL+3ckbehMxz8bOUvoMRaTWwAnte3xx0QdzRDJX80lMAUSfQymkW1t3AZNQTgFaroXrv0FrIBkLFl42KxUYcwaNNqgNXgATe1Jn3IJmlzVOKDADWmKEHS8j4kgq/6G5iYQaNW4Q0DIlAD9UIK/L4BVoSdVX7QskIOez/ZriITiRyAb9of8qTEzzC28ZfIiVZ0Rmjwhs3ruj8y5RIEvfEw+CsBzQzqbaxjbigyCqaaoXpBaPYhfZPy7TnEoPX3jfpWFnm4l0IOkZ2NR6l4mejp3yGj9PCo2LJ/RKq3HmZzJdujoqqfb/kbzpiMwhSnFjnkjEOH6KIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojKNMPVQLAycQUIeSan8uALfsRsaYqxUnV45dnTKA9A=;
 b=B/7i3FJh79Pok1IFBOk8+tb2ldlanTn6Dq0iP2vhp3wj9dxDdCmIjxEqZzbaAAnjNjcSUCt7qNb+l+IXEvOY3RWHWHBTbdaELvam/IXqX9pFuJXzmT72nOX7WdvQJUIZnuCg5txyuqf8giABNJ38Hm5RdF0PAIcq4bi0zUOruR2yZQT530ePCaBlAwNWIvcEOH9uLfmvpqQ6bzZtdilCfFlP0L0JZLN3nUvHpIu+/p+aNRwacsupZKaTeD6TdYRKL5Rm67TphDcWm0+7NFDyi/SfeZW5JYrQefb+NnjrTgsf2VL706x5cjGhWbD8/ipJ1Jcvyt/SHLqLzctYwkzzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojKNMPVQLAycQUIeSan8uALfsRsaYqxUnV45dnTKA9A=;
 b=xqNHuS3wCyRzbpUY9LYP+We+EJ4FWY9CFA6XVGeqTORCUYTBA5hjp9j79vSvwVxOU4s5/UHrA0RgmLU+VG6W/HKKUCoYeWvnT4+lcev3jEzO7xtAsYmz7OweCexJbUA0fJXQXipjQtMj2wlCLIfYpMx/Dirs0+tvzIQQum9SiwYGxLflp/CPAo3+rAJkPKlBu1jVep7pPCZNjP3TwicU85IpBlp679vxRjbh5fVDqMgN39k4JqjF6q5E3YQdjKr5i+Y4pH3sucPKrvp9/Xmj3T5/h8n7dJywD7Cd1TXdqteF8yxO1TpyOZcAtsP/C8H/4gJa/H2GPetl5tEUyO2ugw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB6869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 16:16:57 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 16:16:57 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Thread-Topic: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Thread-Index: AQHbBFjNdrluTsjNlkqTR6odzDTPnbJT8NEAgAH3MQA=
Date: Fri, 13 Sep 2024 16:16:57 +0000
Message-ID: <ae8d43993c2195925c9cbb4a9db565985709eaf8.camel@siemens.com>
References: <20240911144006.48481-1-alexander.sverdlin@siemens.com>
	 <20240912101556.tvlvf2rq5nmxz7ui@skbuf>
In-Reply-To: <20240912101556.tvlvf2rq5nmxz7ui@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB6869:EE_
x-ms-office365-filtering-correlation-id: 93624741-c51a-42d2-83ce-08dcd40f7d73
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rkc1UWoyZHNDeEt4NGptdXRIU0Y5cU9JUm9nZ0t3SFA1SmRHMjd2UFIwOWsy?=
 =?utf-8?B?R1lxSEl4VEhSa3VPUTN4SEdNNjNGZlhFTXVJL2owc1RRSWM2QnBEK3RuNUJT?=
 =?utf-8?B?bWJXWWtXR0h0ZFVKaGNzS1E2bUFFMVdFV0V2dFNTTGwxYVNjdE9vRDFtZ1Ju?=
 =?utf-8?B?WmF1UERTdWpJSUUzTnBlVDhFaU5ra1A4UUgzbjY1TS9Ra0xkMloxWnBvOG1z?=
 =?utf-8?B?YlNKL2o2YUpPNW9zeENUSnZlVXJQbW9hbkdiZHBKTlBQWFBBNGRoeTNsSlhD?=
 =?utf-8?B?SW5ORCs2T2E5dHQzODBDSkZuQy9Xa0E1VHFEbzEvbHNnNWxVTmI2WHQxUUt0?=
 =?utf-8?B?S3QwbkRkYURsSDFQd2RUYmJqYklqSGcxWGhHUFArQXpjay9tNFRjY3BvbGpO?=
 =?utf-8?B?SzFjWENPRjJhaTFIaFJFKzRwSW9ZOE5OdWtUdGN2clN0UDIydEgxM2ZQOGVD?=
 =?utf-8?B?Y0ptcWUvaWRmQlNZK2JXVkNCMnpCUVR3Sk1Bc1p4SHZQVnA1OFZQQUxURzBK?=
 =?utf-8?B?NUdaTWVlUkdpU1FrK2NkM2dQa0dCOEJQVkRsSXM0ckRRaDBmTmgwSThsMlFQ?=
 =?utf-8?B?aFFza0hOejJUUWdIMkEwdE9zMThHVEorMGFPQ1hDZjNPMlhqUE9rNmdYWFVa?=
 =?utf-8?B?Y0NGQzAxeGZNaVFiQ2tEbE11Q245L2dpdEtGcDNZdWVQdVVoU3NSa3ArcUg3?=
 =?utf-8?B?SmZNRW5vb3I4dW8rUlhCUlRkTDJXU0N1TUpvekt2VFUwUHJPWW5lVTVlaGEw?=
 =?utf-8?B?dm1jci83WUpLT0k5cWwyL3R2aGhRb3FJSzBVc1RnOWdlUlE4cHFJQ3ZwRHFr?=
 =?utf-8?B?Ukl1TEdrNWttVmN2WTlZL0pVNGtDWHZuZ1BQaGM2YU52Q3dISmltQ2Z2MVJ1?=
 =?utf-8?B?Uk9CbFdBK2pJNTV4WTdqS2xVZkt1eHV6a0Z3V1BIUnNSVk56Y1VQQk4yWStk?=
 =?utf-8?B?eHdRMG13bDBNd2FPbmhvMVd0S01uRjdrMlgvZmpOQjBHVnd0WXJobHloMWlR?=
 =?utf-8?B?V2VRa2tWTThlT1ZvVkRNSlNhUDRxR0cxSkg3TjN3YlhMYXJmR2NjWDhQa0h6?=
 =?utf-8?B?YkdXcmpVVEJyNVVqVFJvd3VGR0JsekF5VzV0QjhKdVFCNEVnY0IyTDNRRWdG?=
 =?utf-8?B?dVlBRVRKWEpUMUZhSVRVa2hMQzBQTlVLTnJCNDZueDQvRmZkQ0w5Tml2dzB4?=
 =?utf-8?B?ZnF6NmhzQ2xSbFJFbm5aWUNkN0U1ZGU4eU5CWVphOFlNeVQxSXFRdEFmaUEz?=
 =?utf-8?B?YVlBUFR2QjhwS1cyT2hYcnBRUjR2eXphcWE3enAraHIyUkMrckEyUHkrNndC?=
 =?utf-8?B?dHB0Mi9BaVh6TTFnREZEUURYbDg5WnBTY1ZEdzFaYWJvMCtDdGhBcElHT0Vy?=
 =?utf-8?B?bzk0dGxGems3YUtPREVYQlhaeWx0N1FUa1I4Y1BrczFwVU5VRkgvTTQ3bVJN?=
 =?utf-8?B?eHFyMWNXL0xPQ1ZMbXdPTENZWDZVMzA3NndhWHZhOTBtTHRQNFJyN0xZcEx2?=
 =?utf-8?B?dWlXL1h4TkpFaGwrb1ZJR1ZOb0prY3c5a01qcDV0NVpwTTE1eEFjS1NBZnVj?=
 =?utf-8?B?ZHBiNXJpWWcyREVoUi9iVjRxZzV5ZlB0UnZHU3Z4a1ZvdEkvOTkzUDlhOUtr?=
 =?utf-8?B?WnljRlFBakx0ZWlVd1lOV3VDa2JHZFJQS2lyNGRiSkQwNUVJdklMOXRRYWVV?=
 =?utf-8?B?ajlibURxTTlQWW5VVXcwZEVCbkozNkxQRmhKZldDTkwxcDFYd29pWUpXekds?=
 =?utf-8?B?L3JMSENZdlRmQytBYURnV3BFUW1UUnNDTTZjRkQ0cGdtdUR6YlNBdk93eEVs?=
 =?utf-8?Q?4ouNm9QX8KyJXwpuYXM8WGqtd889Ni+pPbeXk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjIzaGhDZzdXYm41ZlpkN0ZDcWdLUUJCQW5OT2JTUmRIT3dTRW5kM2hSTmo5?=
 =?utf-8?B?Z2tOT1RpbFl3cUliWmJ1ckExM3o5R2F3QkhCS3o1aWhSa1lHTVpsbE5RV3o4?=
 =?utf-8?B?MGJBVVRhQ2FrREhkUzZxZi9ha3l4TXd3SG4wSk9WdlNyOE1aaUFEcExMcUNs?=
 =?utf-8?B?dmFqREcwMDR0cHZld1BYRm55b2lHY2V5S0NHTFBINWxyMCt6ZmJsaTF2VFRp?=
 =?utf-8?B?NWp1Y0pEa1BrZDYvM2Nhek5FdkNEd2owZCtaWHNRMEM2a1UxNVZ6NGtBWjhq?=
 =?utf-8?B?V1dwVmRqMzFkbjhCNXFBWG9vcURkOHF2b242NWhvSzVwT2pYWTJNSGxxSWI0?=
 =?utf-8?B?MWxnc0hRS2JTQThFa1B4Qk9pSG0wTkordzVUclEzS0kxVmN2WnY1c2xIdm5l?=
 =?utf-8?B?TU1rQVJmTjFScUhVWndIQTZ4WnRBdTRHN1Y2d3JkQitCbmQyK0xwZ2NCcnZB?=
 =?utf-8?B?RElyVW5hQWt3c2V2VmtjUlVLbUZJK2ZZaEV4RHZ5dU9mV0FqdERtdkVGcytr?=
 =?utf-8?B?S1ZYTHZlZUl1VmhJcGJzeXdLWVNaSTBLYXJBWnMzOGsyVXpRakxqMFBLa0Rj?=
 =?utf-8?B?aUJteCs4clVNNldocnp1aUFscC9rMDFTcEkzeDhoOXlJNWxwYmZ6amJvaEl2?=
 =?utf-8?B?M2JHRVR6Y1hvL3Y4ek9CcjYvWThQTkVZOFdmVFdVV3VDV3dPeFN6bzh3VCtN?=
 =?utf-8?B?YlRLL3hCck5oM2xQVmphWlRpZ2UvTWNXVDhVT0FzaVdUVFdjaS9mM3NXSjVY?=
 =?utf-8?B?K1dRNkxtRE1EcUdmT3V3QjhRVnRQd3BCblFOY282QXZNKzk3aUtZYnB4RFli?=
 =?utf-8?B?NzdoN2ErQnRJRHNRclNvRGI0NHpiTVV6SDBUUmQ0YUJmYm9WRkUvSUVrWXBU?=
 =?utf-8?B?VzkzS1RMR1ZFdTdoODlnZm9rMGlYbXpUY1o1Rmt5a1M0UllxcWFNaTFmeVJL?=
 =?utf-8?B?ZWdlME1yRVFSR1pzWm5xeGNPa3E5b3FveHM5Tm9kV3VXUWlyZzdLZU02QWdM?=
 =?utf-8?B?SFRpNndxMjZSb2JGN1FQTEIzYWc1RXZrN3FNYzZjblBYamw2dWRqZnltYXI1?=
 =?utf-8?B?eEQxc1JJczRqRG9LRnByZmVKUmcrVFZMUHdxNllmTWZlL3lkZnovSGU4L3Ru?=
 =?utf-8?B?M3U2b3NOVEJaZzVlcmtUK1oxWkR2K3EveUd3Y2pqaThYUndGZVkrVDlOKzIr?=
 =?utf-8?B?Nm9ZWHZoOThqU0ZSb1dYS2JLbFhYMFB0aGV0WWp2YytIdmxUTXg0aW91Ukx0?=
 =?utf-8?B?S3BiKzRLS1RyWlZTL2RaQjBrRmg1MEJ1Vk01dW41VmllSUI5YTB2NUNOeFQ3?=
 =?utf-8?B?MjNaVTJ1K2J4WXErUkJNSTFiWFBPNGk4UGtUVDVWVWZMVlE2alRxQndZMm9o?=
 =?utf-8?B?TU1GaDRiTWhydkFVM2l6b053N3gzSTdadWIxbjYrMVp5MEhVb3BGbjhpZStv?=
 =?utf-8?B?bElhN1JQRlJHZkQ4ODdVUFlhTm1tT3ovaVR2ZjVRRU93aDZVTHdlYUhWekJT?=
 =?utf-8?B?b0NzZ2YvWUw1YXk4OFJSVTNnTVBMZ2d0ejhlVTVEaWpDa0xiczUxdFlxdjFy?=
 =?utf-8?B?K3dla3FFTFp2T25haXVPM0NPRmJTeVd6SWJ0Z2dXMExXaFZXWTBWTzJCRU9M?=
 =?utf-8?B?akZsTElLMU5kSG5obTBVVUYzTlBGSlpyd1VsYnpEeEFQTEdxNk9nRFJKdU5s?=
 =?utf-8?B?emlTRTJqeDdBSnFCNGRRNkQ4Y1VSNm9pNjhVWmJkdE8ydGZldGp3MUpmSDBX?=
 =?utf-8?B?aUgyNC9jaGdadDFRanpQQUkrTHFwbzBUejBpUUdSK3NSS1ZvR0tXTDJ0eUxD?=
 =?utf-8?B?UVorbE9xVXRadUFYRVV5Uzk4ZXI0VHlmeWpWUnU1M2JiREJHZTJxbk12S2ov?=
 =?utf-8?B?cXkwVXd2NlpCMW1LcjROV1oxR1hwWWxkQ0s3WEEwVGZSa0NLR203T0F1dWZU?=
 =?utf-8?B?NllKUHlYUDRkWGtGRm9tM1JySkg3aCtjZTJiRVNYUlhLSWQ0YnhQQ3ErUS91?=
 =?utf-8?B?M2t4aWNrRE9HSUNNUzhBbGlCSGJhM1ZXMHJnU3o3T09Ma1ZMRE9oZ0JzQndo?=
 =?utf-8?B?VitWZmVOL05LOXc3akVqZi9YTGNxeFFiYVRwdk8vZE5FbE15bUJxRldWeE44?=
 =?utf-8?B?ZTZ3aUZqVWFERitueDJtR3dNR3FCdGhoc0x5aStROEVWZ1Y0WDNjQ2V4bzJL?=
 =?utf-8?Q?z2EQVL6jhfsGJmGtApLG/vM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D888D0418F15644DBF29AA37B279FE8C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93624741-c51a-42d2-83ce-08dcd40f7d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 16:16:57.3992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLotbJEZ+WGxQ7XkniHxWVnxdTIdHCFqnGjjDQl6HSBw60tOWJSG5joCPbtghhK2dHPTZGNMiJq5Hckh+00wR2jfUoPFQ6zGEK2G/thESwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6869

SGkgVmxhZGltaXIhDQoNClRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIGZpeCENCg0KT24gVGh1LCAy
MDI0LTA5LTEyIGF0IDEzOjE1ICswMzAwLCBWbGFkaW1pciBPbHRlYW4gd3JvdGU6DQo+ID4gRnJv
bTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+
ID4gDQo+ID4gZHNhX3N3aXRjaF9zaHV0ZG93bigpIGRvZXNuJ3QgYnJpbmcgZG93biBhbnkgcG9y
dHMsIGJ1dCBvbmx5IGRpc2Nvbm5lY3RzDQo+ID4gc2xhdmVzIGZyb20gbWFzdGVyLiBQYWNrZXRz
IHN0aWxsIGNvbWUgYWZ0ZXJ3YXJkcyBpbnRvIG1hc3RlciBwb3J0IGFuZCB0aGUNCj4gPiBwb3J0
cyBhcmUgYmVpbmcgcG9sbGVkIGZvciBsaW5rIHN0YXR1cy4gVGhpcyBsZWFkcyB0byBjcmFzaGVz
Og0KPiA+IA0KPiA+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDAwMA0KPiA+IENQVTogMCBQSUQ6
IDQ0MiBDb21tOiBrd29ya2VyLzA6MyBUYWludGVkOiBHIE8gNi4xLjk5KyAjMQ0KPiA+IFdvcmtx
dWV1ZTogZXZlbnRzX3Bvd2VyX2VmZmljaWVudCBwaHlfc3RhdGVfbWFjaGluZQ0KPiA+IHBjIDog
bGFuOTMwM19tZGlvX3BoeV9yZWFkDQo+ID4gbHIgOiBsYW45MzAzX3BoeV9yZWFkDQo+ID4gQ2Fs
bCB0cmFjZToNCj4gPiDCoCBsYW45MzAzX21kaW9fcGh5X3JlYWQNCj4gPiDCoCBsYW45MzAzX3Bo
eV9yZWFkDQo+ID4gwqAgZHNhX3NsYXZlX3BoeV9yZWFkDQo+ID4gwqAgX19tZGlvYnVzX3JlYWQN
Cj4gPiDCoCBtZGlvYnVzX3JlYWQNCj4gPiDCoCBnZW5waHlfdXBkYXRlX2xpbmsNCj4gPiDCoCBn
ZW5waHlfcmVhZF9zdGF0dXMNCj4gPiDCoCBwaHlfY2hlY2tfbGlua19zdGF0dXMNCj4gPiDCoCBw
aHlfc3RhdGVfbWFjaGluZQ0KPiA+IMKgIHByb2Nlc3Nfb25lX3dvcmsNCj4gPiDCoCB3b3JrZXJf
dGhyZWFkDQo+ID4gDQo+ID4gQ2FsbCBsYW45MzAzX3JlbW92ZSgpIGluc3RlYWQgdG8gcmVhbGx5
IHVucmVnaXN0ZXIgYWxsIHBvcnRzIGJlZm9yZSB6ZXJvaW5nDQo+ID4gZHJ2ZGF0YSBhbmQgZHNh
X3B0ci4NCj4gPiANCj4gPiBGaXhlczogMDY1MGJmNTJiMzFmICgibmV0OiBkc2E6IGJlIGNvbXBh
dGlibGUgd2l0aCBtYXN0ZXJzIHdoaWNoIHVucmVnaXN0ZXIgb24gc2h1dGRvd24iKQ0KDQpEbyB5
b3UgdGhpbmsgaXQgd291bGQgbWFrZSBzZW5zZSB0byBhZGQgdGhlIHNhbWUgRml4ZXM6IHRhZyBh
cyBhYm92ZT8NCihUaGF0J3MgdGhlIGVhcmxpZXIgb25lIG9mIHRoZSB0d28pDQoNCj4gPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdmVy
ZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiANCj4gQ291
bGQgeW91IHBsZWFzZSB0ZXN0IHRoaXMgYWx0ZXJuYXRpdmUgc29sdXRpb24gKHBhdGNoIGF0dGFj
aGVkKSBmb3IgYm90aCByZXBvcnRlZCBwcm9ibGVtcz8NCg0KV2UgaGFkIHR3byBMQU45MzAzLWVx
dWlwcGVkIHN5c3RlbXMgcnVubmluZyBvdmVybmlnaHQgd2l0aCBQUk9WRV9MT0NLSU5HK1BST1ZF
X1JDVSBhbmQgd2l0aG91dCwNCmFuZCBJIGFsc28gcmFuIGNvdXBsZSBvZiByZWJvb3RzIHdpdGgg
UFJPVkVfTE9DS0lORyBvbiBhIE1hcnZlbGwgbXY2eHh4IGVxdWlwcGVkIEhXLg0KQWxsIG9mIHRo
ZSBhYm92ZSBmb3IgYSBiYWNrcG9ydCB0byB2Ni4xLCBidXQgdGhpcyBwYXJ0IHNob3VsZCBiZSBP
SywgSSBiZWxpZXZlLg0KDQpPdmVyYWxsIGxvb2tzIHZlcnkgZ29vZCwgeW91IGNhbiBhZGQgbXkN
ClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVt
ZW5zLmNvbT4NClRlc3RlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRs
aW5Ac2llbWVucy5jb20+IA0Kd2hlbiB5b3Ugb2ZmaWNpYWxseSBwdWJsaXNoIHRoZSBwYXRjaC4N
Cg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

