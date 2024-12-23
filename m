Return-Path: <stable+bounces-105622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FE19FAED9
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 14:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA58C164947
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6AF19D074;
	Mon, 23 Dec 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="OOWAgocm"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD74EAD7
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734960219; cv=fail; b=tAqrxAK4oaip34xMt+5WVrqTjahAcjlhvoun1hOM6VinQkoRDb+Ts/qLHrlHhNn4uNx462iAtib1DoVAXyCRY0urjUldoXZ/16a3TKyNgkYashWXWdUsK3RYiMTwzxji32jIaC7X9VSPaAAuVcr3qYVoNlQISHZk+CLNBW9ZTVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734960219; c=relaxed/simple;
	bh=V1yv88XKjkOwZlgz4hpFqkDb8ffpiMPZMlHndleXSe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yt/+7xkHYAr3kGYwurMFuBx9MWGqTjsXECI5we1PjJEbLUSLWQyf7C2X38hJYGcB1P1UYgUZ8Ky1p8uBG6ES3OwmHrp8ABihwlqNJSbSbnCxZeOh8pt4xChMgP8wk08+/umvMnINRYcOHLo3hp2lYJGa40RUlvrX0z33of1h2No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=OOWAgocm; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVpiV+EAAiYNASgl4HdfcLAHZ5M2+PwY6B3SNSu9TCmhPi6FRME/hsFjyGKdyAc8kYfLgR/n7fZiGID0KR63BJiJEdsmd+hEGK5u7gTwQwzLDHRfqtk4as92SX4pGyPEsJtPczY32GDQXrPp3sOsMAfaVN5IfocNJhmkxqq5GiCDLNKNZNpCPkaVc2gJM7J7tZtaApP//5nvUgbiA7ZoJL5LoKjODuvURgJZFE4IlsDsQtrXjcmlH0Da+vtHthDo2a6G+Vwc6CiZGANuNWeYuOCSdGPCaE0pID8fGuyDdah3z4w/SwmH6PfFi7Iiqkz2uqrmNP2VYqnsH48YyqD3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWRRogm45UwJYxjEXZQbewOrqOOkkRfBF0CsGlJ71xw=;
 b=Qqm775OuiLQE7lddR7ic9joFfrFO+iC3wuyhiMhhk1+LUYqe3UmnXbW5mGLhYeRmWkbgudA50ux2A63lGnv9n8Z2/Mtcl7ICw3Fb+rPQUNyr0N4zeijX3l2D5s4znL2yEVtvszvUZeO9Agg4XF9YFwMZClHAx6i+kuLZ4FjUHqf9q9foloba4IJ6nOa+XkiG/YSMOypScTnLiZ8CqiU9mWx8x4JcOlbU3xmemS6IVFi7FSU8wsHMvd9Cy221S0+Sa3g7y85DKfcfNNUzFyH32cjDwzqoxO8ezi0ho3FCH9FGkwlO3Og2rb1gHCzdP0CvTJdsj31HDqNHRQAq9FM3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWRRogm45UwJYxjEXZQbewOrqOOkkRfBF0CsGlJ71xw=;
 b=OOWAgocmLXiShgJsR/+ijJehoZhB8sIDuSrsmWYZTGiOfcmIkNZK0VUv+HQnPs9BH3g5cnQAj/Ntjevg4OZ1F6KVnkVAbhaTnsOa/2ll2yAKO1/ZRUnhoUdg2b1r/elTHy0+Q63IJrJfOGxTvGy3ortCH8PxlJGUudjj0qIWBaU19WalNjxffOzLw8hjKXWCb8JGSpdEUZKtnziSs4lisPXAkzfT3Bz6YUqISwh9eq6jnzdogAt2E83aHcs7PxnRTt4gAX7kChlIl92gmnDtUaSX6zNk5IMZtIpMaKuuD68IIBV6+M+vzrzaW3tbUCOuIwrWtZaying/Jok2UkEP+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com (2603:10a6:102:368::9)
 by DB9PR07MB7753.eurprd07.prod.outlook.com (2603:10a6:10:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 13:23:30 +0000
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf]) by PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 13:23:29 +0000
Date: Mon, 23 Dec 2024 14:23:48 +0100
From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org
Subject: Re: Request to port to 6.6.y : c809b0d0e52d ("x86/microcode/AMD:
 Flush patch buffer mapping after application")
Message-ID: <Z2lkZC_MgXe4rDRW@antipodes>
References: <Z2GZp14ZFOadAskq@antipodes>
 <2024121745-roundworm-thursday-107d@gregkh>
 <Z2LABy6mqCSdvBge@antipodes>
 <2024122345-demotion-zit-15c6@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024122345-demotion-zit-15c6@gregkh>
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To PAWPR07MB9579.eurprd07.prod.outlook.com
 (2603:10a6:102:368::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9579:EE_|DB9PR07MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc9aac7-603c-4909-8223-08dd2354fdbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clBSa21uYzBpMks4VmJ2OXlIZlVCcUt6Tm1jWWh4dEhUdEtyRjhvM3lSNGxr?=
 =?utf-8?B?c0hGbWMxNjhQUWZmTE5vYnhnZGNuaWdBaWlBT0NVVTQ3bHIyUHFTYkQ4MWl6?=
 =?utf-8?B?MUJqKzhjYkZrcUc1TTVxOEJVelhCY0pxelY1YmE0dkIyaEIvU2llOXBQUDZU?=
 =?utf-8?B?cE42TUxhRHRreDkzcys5QU05UVRyTnZGeGx1K1h6UnNzZzdXL3Z5TGtyRjJs?=
 =?utf-8?B?Y2VPZW5Gb1pnelhEUmRFSjlEeGR2Tkl1OVFDZkJFRlNOSjhTa0tBNTRQTmVC?=
 =?utf-8?B?b0xkNXNLRGVFc0Z5TnpMYklZOTZ1ZFdtUXBYeUQ4cGZKazVEUVVOREhiUWhQ?=
 =?utf-8?B?Z2tTTzd3eUhGVk9iWVB3SWdZMGl1d3BCeEFXUHV2YXYyRDZFMSsvdEJiMzdH?=
 =?utf-8?B?ZWNnVk9JZ3FCY1dILzJmM1VtRHBYaEFGWFVVSEhsbE1oQlJ0NTVvZUNINlFj?=
 =?utf-8?B?VndqVjJxcFFqcTUrdjBweFJJanJnbHhJQzhDejhBK3hVSG5aeWZQRWhvTkxM?=
 =?utf-8?B?NGsvcnhHYi9CK1RRZDlMOXFadWh5WThGWDl4K1NkaVpIempDeTZWeEo3UDBt?=
 =?utf-8?B?TkxqMUN1UXNING9HUUhxRElPSUErZDIyNVA1YkRVcUZJVXNmOWNOUVJZSVBz?=
 =?utf-8?B?OG1xRG9zMFhDUHE3d0hhNjIyOHRrWU42aWJSci9MUEVFeEo0MnZMQW5YM01X?=
 =?utf-8?B?c3hiem9mc0tqSnI4YjRuLytUNmJCNXVZOFpYVVo5emsrck1SakFHRGl1VHZR?=
 =?utf-8?B?cWZncjhNRHdqQ24rWEVTeURFV3drYm5mZ2xDT0preWxpaDh5TDhTSHhnU2h3?=
 =?utf-8?B?TjhxRS9VZkRTR2NHSGRndUh4QTNBMWpXS29sbGpJYnlrOGpFcTFzeWJ2WldL?=
 =?utf-8?B?QU1QYzZaYkVEMUtVK3JCU3ZzVnNPOWFCM2ZzYVJ2b1VBT1RWcnYwdEE2Q1JY?=
 =?utf-8?B?QjgzVmc2UkVwNHo1UElVZ0pUUlRKOHVBd0dqUmJDclpoTlhVbWc4ZlFnTHBJ?=
 =?utf-8?B?c0ltbFREMVgvNXJuMitPTnM2bDllUFBYVkNzSTdNcEV6RHU2MmxYSnJ4a2t3?=
 =?utf-8?B?TlJaVm8yMmlmdWV4OEhoRC9QS2lIbk4zakVQUm0zKzBJaldRcml5RDV5ZU52?=
 =?utf-8?B?ZCtOTURVQ2V3UXgzSjUrU1F2ZThMbzZvOGtXVWtKeHlrSWVuRTdnZ1l3TGhZ?=
 =?utf-8?B?aTlDL09IWnVnbTBSSjdSaHZQekY3bzRabUdiTGM5eEw0NVhtLzgvMWdtTTdB?=
 =?utf-8?B?V0NGMG94eXczRDA4bU9ORXlRVkdZQlNTRXhuZWlRbjR6TzZCOEc1cmtES05u?=
 =?utf-8?B?UThZU1ozbXdRd0RDLzBLRzIva2RrZ3NtdXFSU3kzYTQ4b2oxUjBzcUEvb2xO?=
 =?utf-8?B?czdjQlUreWhCb0tyTEZ4d1RXMWhyUXRyK3N2cG1PdkpwWmdpREx4cGNERzZ2?=
 =?utf-8?B?Tjk5VUQ3bGFNQXZVbytvR3lsTDdqRzBNWjRPZVhHaTZQcFp0ZTgzZ21yUko1?=
 =?utf-8?B?QkhMM1RZUVZidFlLdVFHb1Y2SHZzTUNYTEFHYUIrZTR0ZndpUFg1VlIvZmNH?=
 =?utf-8?B?SU51TGxoNk9aVkRpK2Y0RThRTTk0S1owK05xRGJRdmNMbFV3WHBsTm9PNUh2?=
 =?utf-8?B?TDBzSzMyUVgrZnRRdFhHbkZUeFhlK0RiWWgxZTNBSjFsUzRUMnd1N2E2RnJI?=
 =?utf-8?B?U3VpUjZnYnV4UFpwZFlLcVhGbjR3M2dDU09BOGNlQzlVR2JxeG8vVWN6VW94?=
 =?utf-8?B?K1E1ZGZCUHZTa08rQTRhK0lxWkljYm5iaVMwVjhNYnJQdm5YMDZZc3BkcW02?=
 =?utf-8?B?ZElsL3hiV2pHakQ3YlNQMVQyOXFPeUJlcEQ1UDhMeEkzNjBkbnZjN3ZiOVc4?=
 =?utf-8?Q?H/+tlj54E9PJJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9579.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wlo3MkJ1L3Vlc2YxTkZFbzU2dFRDRXFoZWU0L3VmVnQ3OG12bStMV3ZLbUU0?=
 =?utf-8?B?L1VJRkVzNDU3ZjUwTldOak1Jd29sTTMrbXBsNTkwd05xb0YzcXVURTVMblJ5?=
 =?utf-8?B?NUJzc2x6aERJSzNra05Ja3NEVXp4M0xuWDJqcGdhZEVWZ0JEL0hNYjluM1ZC?=
 =?utf-8?B?SnhLaElveDVudW9zc0NZRVM5V2VUby9UYi9Qd2Q0MFVCN3RkY1JOY2FOeUlW?=
 =?utf-8?B?cFBqQ2NtRVFHeUw4VW4vbjg5bHVsazZTQ2tkeFJYYmlydXV3L3JGZnNmRUxS?=
 =?utf-8?B?QlpTeW4vQkNZQVBUeWpTUFpPOHd1bGFKYU15L1dmdnA4blBidmQ5b09LalI5?=
 =?utf-8?B?cWtJbFBvYWRYWjFSOFdxQU9sMXBLYlpBNklrRjlvK20yV1U4ejlmZE1kQVdw?=
 =?utf-8?B?c1hsWGhhYTZzNGhSUkk5dlVIUlJhZDNYdFVMWFBPQTkwNk1Ld2pTOW1ZQXlr?=
 =?utf-8?B?NmlnNWd4OW9KMU5Sb0REQUl1L0V1NDlod2MxUEdnM0poTEoyQ1orV2VWWEVx?=
 =?utf-8?B?MU1qTEtNd0d0bmg3M3V1enhtdDk3dDZGWHkyd2JXNGw1dE1sNlZIeHBMYUY0?=
 =?utf-8?B?Wk9EUDZ4YktNaW0vdzN6T3c4YXVEZWJiZThyQUhTWkRxNmNYNGxIN3dYbWlZ?=
 =?utf-8?B?eFQ0azVXREhnbEE1ZUVodDU3SysycE51R1E4NzRiUU5ITFhxZXIwTlNuLzFa?=
 =?utf-8?B?Y0tmRXN5RFZtMFcxVkZlQnRYYVArNGwvQlpadURiL3ZLQkFtMFFOR3ZRellS?=
 =?utf-8?B?dC9tVzNzY1VlOG5ucXdKUDU2cXdnMTlSYVhkelhQL3piZ1FlN0o0T3ZjMDV2?=
 =?utf-8?B?TXNhb0s4RHB1a0ptQUdmTDJxd2VVUTF6Uzk2YUgwNmEyS3NiWE5CaWMzS2tJ?=
 =?utf-8?B?Y1dkSi9IOGJsZXhEZXRSWlA1RFk4Q29va0ZMQk9DcjE2NTdCZ3NscWVHUUc1?=
 =?utf-8?B?MmFDaHgwZEgwT1dVSHNiZlQ5eGgrRUM1VzZSQ2hTYWlad2lEL0xWTDkrUHRS?=
 =?utf-8?B?STJleGZieE82YjB0OEcvQUtIRXlhK2xBUVhId3FrdXhYOUphb21nYVljZC9O?=
 =?utf-8?B?N3JSTG9OOU9wOS9oQlBWZTRqaE5XVnhORlk5NmY2cUc3U0JkSE1nMDB1bVRm?=
 =?utf-8?B?dG1KMG9rb1RBWVZXUW5QbmRjTUxkc3N4UFdxbjBxVUhpN1d4Qm5xY2ZtZXVG?=
 =?utf-8?B?RGxNQW0yRlprOThmOVVCck9oVGdKZkg1ajkrdnlBeHA0Skx1UmNxS3ZTbVEw?=
 =?utf-8?B?b0pqQzZTU1hJMmlNWTRnRFh1TE9DV042V2lKNzVEK1VvaGdPREFoNWEyWnYv?=
 =?utf-8?B?RmdlY0Y0N1BaWnFwSWJYMTRIR3laL3VmelFSZjlUZkpETWcxZmZFdklCYkVm?=
 =?utf-8?B?S3Q2NU13bWxxUmpMQkdVSzhQOXlhSHoxSjN3OG50dzdDbERzTWVvbVpKZ3A5?=
 =?utf-8?B?ODJDUSttTHVtOUhuclJjOEJMVm1zWDhlYTdRaSttVlJPMDF2VGhGWEdhcFdQ?=
 =?utf-8?B?SGo4WFlZRUxmT0VlWmErYmFUSmpJL0hzY3lPVlBKUTZRVzNjTW5VV0VDdmN5?=
 =?utf-8?B?RTJxNytGazdhY3BZeXlVNVpUaWYxUmN3U3p0YzFSR0g4UmJpMmR0S2paeTlt?=
 =?utf-8?B?ZzVOaVZ1TUJac2tVM0dEWDVnWHZaaVVnSXpJcjdUSCtDM3VSeW1wWVdaOG90?=
 =?utf-8?B?N2NORkFYelErMXAxWlh2U1FxMUlZQXNac1lzdG40cy94Y0EvR2NCc3JmZ1d1?=
 =?utf-8?B?aVl3TjZIRW0xa0E4ZnE4Um1KVlRMMld0QWpzcGpxd1BOMEJJOUQ3aDVVUmth?=
 =?utf-8?B?YlcwaVNSRUs4NDEzY3J4d0MyZmNVazMvMjBWeUdmUWdvY01aV3BZZW1TeHAx?=
 =?utf-8?B?c2ZLMnVVY0toajExWkg5NWxIN0IxSXU2UTZPdjZZa1oxeGJIclZsOFZyQWpv?=
 =?utf-8?B?U0hNNE5WYWpVSEQ2WjhhK1NzWDh0YzROeUNHeDJSa2xPVlFvWE5lK3pSQVFD?=
 =?utf-8?B?VU9XYUdTU0R5RWd3c0lxdG96Q1lYZVNvRkVBYmVQV2JCUkFETlBtOGMrNTN0?=
 =?utf-8?B?NnJubWJOSlFTalZjVlcxdUhFd3VjVTROWVRZL0FpQktqMTlxZVhHSEVvd3pH?=
 =?utf-8?B?L3l3M1o5b3E4a3QycktYc1dpcTE3c1g2N1h2SnJ5dy9PZ2o2V0l6VXR5bldk?=
 =?utf-8?Q?ZdAtuI6k1rW62eEpHPBVOwE=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc9aac7-603c-4909-8223-08dd2354fdbd
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9579.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 13:23:29.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4KKuzQKuDa4BenlqwCbh5e/B1ILTOQpj5pLDys/KABGJquTdB3eYUI1Z1MP02J6ApgIXEt2h/0P4/z+ae6yXHYVX/YxTfLfdguwaMc3UA1lPtdtsa1a+AUO6q4zzHpS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7753

On Mon, Dec 23, 2024 at 01:33:17PM +0100, Greg KH wrote:
> Wait, why do you want these for the 6.6.y tree if you haven't even
> tested to see if they are required or work there?  Why not just move to
> 6.12.y instead as you know that works.

The original problem was reported by me on 6.6.y.
I tested the patch provided by Borislav on 6.6.y. As mentioned, a small change
is required to make it compile, but this is a nonfunctional change in the
tested code path and so didn't influence test results.
I can therefore say with certainty that the fix is required on 6.6.y .

In these discussions, I requested Borislav if the patch could also be submitted
for 6.6.y, and made him aware that variable 'bsp_cpuid_1_eax' used in the patch
does not yet exist in that branch. He replied [1]:

    "That's fine - stable folks usually know what to pick up. If not, I'll
    provide backports."


I cannot currently move to 6.12 for these systems, this has other consequences
and testing efforts.

Thanks,
Thomas

[1] https://lore.kernel.org/lkml/20241119111728.GAZzxzyHj8U99cEHQ8@fat_crate.local/

