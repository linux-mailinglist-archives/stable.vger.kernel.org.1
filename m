Return-Path: <stable+bounces-145809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17446ABF25B
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86567A80E9
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89E22367D4;
	Wed, 21 May 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="fFM5U2Cn"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2010.outbound.protection.outlook.com [40.92.91.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960684B1E7B
	for <stable@vger.kernel.org>; Wed, 21 May 2025 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825516; cv=fail; b=gz5eanvIw7kI0jJ4j4PpNrxM8LEbPTiA91kY5YlKmI6HyQPkV3E5C5hbmUiQo06a5FAQLfcUDrWnQx7aoYF8AKPeN/kER6Sjp1wWFASJh0KnH7pFCxDVD289bGmCyGTR1gsAobRkDyBQqx29hZvxgVDW+KOEPq8xwy56P8IEp5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825516; c=relaxed/simple;
	bh=NcUwAB9CxEJ1Hkn7TO/jkEd8hbJKtVaHW0C5tKG+O4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VC0px2En1nojDvr3CuWYR5YnoDVKtZ0atQFgzjrv0WER/GpGYUKNnQs0bH+zB5IuWRC/5o6Vki/ObT6z97ojtxb+fQgkoO3L2WnDpplprsAcJIhHTdT8eyllIlwdu4HpEo0gP7AiTCqB50kRw0/dESep93T0/4Os1ItucF2okZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=fFM5U2Cn; arc=fail smtp.client-ip=40.92.91.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bViW+xFSA9TqXPeT8u92ExbQpwOrqQz992wFoJ1NMosdDdeb6M8KBKotH1Dl0BDJ7AIY+KhYIWSgxNmP3Nwdj7RrbWLB5ZPM1LI0uPQh5FFfBh0heMdNuvvxLsH1gmArs/kzh1ezSZI1RUsHuB2UEXJB+yn/KtPMb4RkIA9mxJ6ERt9z2ISz3ohRoW9Z0TUmvpcbQi+W/ss8X9YgH7m9El8J6ssZA8IH6fdA8mwFHmC2D1/7+nxFP6IrvJMXU0B857re5Svx6DchqFF7HqzGXUO9OWZ7ha+pgaH3yPv1Pd1wFkJJwrC/7BZda5FmokXJ5iPkp+ZVNDV2knWX9KVmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw85P9YwRjKNrgrf5Ru3nv73qbAnl/PSpEz2ojAEV5s=;
 b=V4d+JmYFh/Ubq3cX027/auuI50fXRkoOiWKQnmPeA3Z3IBdcReb6XOGFPKyLgZHJTOsjOJQyCV2IiEk2Q7Pdyvq62hsgfRQw+4A9ofhokfMW1nVcvaWJeoRD1sXKRXY/o2cWSqvb7Tvi8oxeVGcJCUkALU0iCp0YOgUS2OnvhktZcK4+YiaebZiPsxiRuYw/Md3qfIkZB3nqOusjY7DW54PYoeHWS8kObVd2sLZqh5XnsCSjDzOYMocNIU/69SO6BI/T7UK/EscQq7HIXLuk0rS7Cr4HYd6Ws0vJZ8Nct1bQ/2ADA4gMdvlRtIH3XLe7Rs/muV7cBPM1gdPIhz5/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw85P9YwRjKNrgrf5Ru3nv73qbAnl/PSpEz2ojAEV5s=;
 b=fFM5U2CnRw+5vP7XPiZhgNcrmy18VuWz0K+9sqS34z/8oOZFIEsiYmyMJE8jk7kiZv5C6eSgN/WHIVTRcQNyVQJkl618N34FQ0PKYvnaKAyp9QtRiElrjWv+YvoXLYmJolWbW9fmlk/k5+cxceoBOGBNecVvMZJ9fG72de9fkCJZy66QJFYmykFSsd+v0CV2+tIDVvpzVhLWLZRoikV18IjFekoaAT8xDjNVdXBuEauXH8Qvec6fE+b5AwuG0TmKzfuiwiH93S2sAzih2gbwmxwD+59UwwSl5sHYFTvpNm3vg2p/DuXmfHg2VUclHnK/Rv+7jHXZjgJrz85iWPRs1w==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by AS4P189MB1941.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 11:05:11 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 11:05:11 +0000
Message-ID:
 <AM7P189MB1009A8754E90E4DE198DAC32E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Wed, 21 May 2025 13:05:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Panic with a lis2dw12 accelerometer
To: Christian Heusel <christian@heusel.eu>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linus.walleij@linaro.org
References: <AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <8d249485-61f6-4081-82e0-63ae280c98c1@heusel.eu>
 <3352738d-9c0e-4c23-aa9a-61e1d3d67a50@hotmail.com>
 <AM7P189MB10092C41B59EF58CBCB290A2E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <60a9ea8a-edb1-4426-ae0e-385f46888b3b@heusel.eu>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <60a9ea8a-edb1-4426-ae0e-385f46888b3b@heusel.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::14) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <ff8a1abf-8238-44f5-9433-c3a1aea07746@hotmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|AS4P189MB1941:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b074e7-5715-43d7-152e-08dd98575af4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|15080799009|19110799006|6090799003|461199028|5072599009|4302099013|3412199025|440099028|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZktEc1RYRUFXeFdwUGZ5SmxQQS91WURvSWRKVDRHRTY5M0NNVWcrT1pRRWFz?=
 =?utf-8?B?L0NrTzFwZjdhVVVGVEJIeGJ2OGlkb0dIVm9pTDkzUzhha1B6QlA4UkR5Z2wv?=
 =?utf-8?B?b1JuVThnSTBlOUZycUpaOU0wZGNUOFNxaVM1RjJDOWpJQlFJWS9rdmdQNDIy?=
 =?utf-8?B?M1NNNTFORzJaOHlUQzdKSVN6REk2eHg3Vm85RUU5ZU5hRGJGOEdjUnU0VkYz?=
 =?utf-8?B?OGFHZHhwQUZxdnh1Mm9Fb0JMOUczbzB4L2ttQ2VTSVVBQXpFM3lMVlJ6eFJN?=
 =?utf-8?B?OFV1T01ETzdzd0dVMnZjVEFaTXNvd1Z6Q1pPMnUzTUZRbTRuVzUwM1QwSmNv?=
 =?utf-8?B?Vkp3RDJ0ejV2WE9hUUJzSGFHTUxPNHZhcUlRZi96NHExYTh0VUk5UGo2SHF6?=
 =?utf-8?B?NlFPSys5NXVyL0pSd2RKK0hvQnBvU1FORUg3akFrMUM3cGJCUTdOY3kxdTNN?=
 =?utf-8?B?aGVmcytjNGozb0FWdWVPalQwREFtc05sVzdCTmh0blkvY0NJSG83dExSNjZT?=
 =?utf-8?B?ZzVFNzFiOW81MnNrTDhmMUFHQkFPdWpmSGxRczU3R3cxZFVUKzV3b2puVXhh?=
 =?utf-8?B?SkZqalN1Y2JrQUc0RnZOYjlqRDNZWFAyR1dFbVlaSUN5NWxtM0JoNUdEMFF0?=
 =?utf-8?B?eHNFYjU4V21MRG9qK3duMWlWNFJESUtUOFdyV005amVtVnNBd21qLzVSb0sw?=
 =?utf-8?B?UkRYbG1YeFlyVms4aTFPUW1zbHh6bFNMNFMzZkdHaDh1QTdRUi9HOTBaY2NI?=
 =?utf-8?B?UDBnYVdMUCtSb29qKzlhNUJ4b093L1NHOTdFckhLZG1Rems2SWx1anhQM3lu?=
 =?utf-8?B?UUxjYlFWcUlodUtncnZnRW1LOEdMaG8yRHBQdGxTRS9lRDRFbVQxL0FPM1Jv?=
 =?utf-8?B?VGRZQ2c5T25pMFI5YVZEOXFBSk9vK004cHlzMTBqNlI2TmIza2Q1cjBSVlYv?=
 =?utf-8?B?Ukprb1dhaTFrb2pkU1FxN0VZOTBVRzhRcGhQVHlhUnpvQkxCdmZEdWpjdHc4?=
 =?utf-8?B?ckZOS2xOU2hpT0VZV3hhd2phSzVaeENvYzZFT1hkTHJGcGVJUDBkbVJzc0xM?=
 =?utf-8?B?OFF4NG1oclR4R2RycDdnM3M2eEpBUnpWczMzM3RNRThGMllRWHBhdlJGRmlp?=
 =?utf-8?B?ZmNtSjVoZ01aRVR0Tk1mbWF0dVVZb0ZTZEVmdkRHaEZWMVpINXZlVW16Qm1n?=
 =?utf-8?B?ZDRjdW1pVElWS1drUXcydlQ1endLNHVPNXZ5YjVHK0Z2YWV4bjF4SHhQYnJr?=
 =?utf-8?B?M3BQQnFEMktoOHpYcjgydVZ2aFVTblNVNy9rQkppSmFRTXRHQ0Vtb3JjREMr?=
 =?utf-8?B?SGpJSTdDL1VqaHkxQURiaGU0dk5ZTE50SktZTEpoTkR2aGVSMU5NekozcUFs?=
 =?utf-8?B?Q0QxL05SSjYzdXZndXFYVVAwYjhyVjkrbm9HVXJRUjU0QS8reFhmc2RzcGZ2?=
 =?utf-8?B?QTY4cVZVRk1kTE11WHlaS1FaVnZMUllhY1huSWlGT1RwWWRYUUw0eUVlUG5K?=
 =?utf-8?B?QmNyQ25CaUpGNnhiSUlma1BHUWQ5cklkOE93VHgzald2c0duVjlTTy9NQndn?=
 =?utf-8?B?czM5L0hqWnk3Ymp6dEk5VXNtWG1LdzIxMnpydVN5SnYrZk44aHV3d0JBYm03?=
 =?utf-8?B?SkFibFg5OTl5SzVkNzVnWXBCSFdrL0p6SzFjNnlLdzJXMms1TDNqQnVBWmxF?=
 =?utf-8?Q?iR9KpUt9sqXRK75WxNod?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei9GVUU3WVpIOXVTRnZHN2liU1Y5RTZnNStVVmtHVnhROTFJTDFDclp3WmFy?=
 =?utf-8?B?OXZwQ0RseERzSlhOSXhQalFRSTRGWmZPT2RRelQwbEt4MkFDeTk2MGxpV0RY?=
 =?utf-8?B?enpDM1V5ci9OTW9JK3U4Zk04Vk5wUjIvQ3gwcXZOQUovbVVYTTNtNDViczZz?=
 =?utf-8?B?SWNzVzJCNEFxT1dqbkVHOGtrUkN4TVdFL0EvWnNyd25uSmZ4ZXZXWnNQU3lh?=
 =?utf-8?B?dm9CSHVjOXBZaUNtNlJ2ZXNpU2hhYU1TSDR2Y3I5VkliNUQ0R0gvWTRoSEtr?=
 =?utf-8?B?elRvcTRBS1R5Z2NoUGhyaEZwV2JyS1R0NlFmcldZNjFqL2lwQWRyM0tHSDJ6?=
 =?utf-8?B?S1k4eTZkY3hjVnhEbmFwVmNGZzlNVlVvT2x3dEhHZVBDY3Q1OFNIR3NOVGla?=
 =?utf-8?B?MVh1TXZSRWhlUVY5REpUUWJvTzlXTW4xOFl2UC9oQk5uQ3c4emo4S1R0a0VD?=
 =?utf-8?B?MEpDUGdzdFFXVnV0d216SmN6RlpGTjVkM1RJWUx1Z3ZDSDRVdzFvOGEvYjFI?=
 =?utf-8?B?YWx0WHVZL2FCM1YyMHA3TC96eDd1SGRENGVHeDdHOVAvRkdhb2djbUV0MXZq?=
 =?utf-8?B?M3lOUUFsQU5NU0VwWHF6a2FaNTZoNmNPRUxGZWtmbjhzREg3K2VGWDliaGdt?=
 =?utf-8?B?M29pSVB5Rm1MOHl4bTlyVGVyS0lES3JaVkpPajk2TmhocVhiUHY5VDhhTXYv?=
 =?utf-8?B?eno5NnNnZ2lYT0F5bDFWWXd1bDJDUHdqam5SRERLVndHdEZKamloRkhia3hU?=
 =?utf-8?B?Z3YrSmJGYVZpNDQyK1VJM1A1ZzdwWGp3dmxHbUpmeHRJWUoyWCsrZGZsVzFD?=
 =?utf-8?B?UmlCZEpkbVNrUlN1aG1kV1p2cjlWQTJiOVZRUFNMb0FBYis3cHcyV2FYclQx?=
 =?utf-8?B?azFDYTV4YTJuRENkQyt0alFaRG5qNW5oUzVPaDFnVVJ3Wk8vSUVNSkpKS1lV?=
 =?utf-8?B?Uitzdm5CNGpsTnd3VnF5cUJZd0FZMlR1RmdXM0o5cEl1WiszOVVIMU5Sd0lo?=
 =?utf-8?B?SmdrWm9pLytrK3QwRUgvenc2cU9IM3djSng3Y2t4dTY2K2VDa0FWMzUxdnVr?=
 =?utf-8?B?ZkJydm5ZcXlMRHFIa1AzSnRXRjhTdlBiNnRZaW5iT0hGeXZpNmo4MjYrd0c5?=
 =?utf-8?B?eStoWnhqNk1lSHBGbFRmQ1N5YjRvOTVtMDl4UHJoN3NnZXFOVlRLQXZ6SDdC?=
 =?utf-8?B?VjBkSVlJUEJMM2VXdVZOdXpVR245c1MwVUxEMTk0bUFlOGZxNTU5eTFLMUhl?=
 =?utf-8?B?dURPT2xkZHdkbGpFK3pVZUpBN3V0SUpUSU5tSGk2VCt6V2Rwa3huNzc1eWEw?=
 =?utf-8?B?aW1vK0U4ZUhmU3REb3JnaFl6cEVKSTgrZ0xvS3JBWVBvNHdqTUZMZTlwZWRt?=
 =?utf-8?B?eWM5cURwUFJ3S0Y5cHlTZGZFTWhNOXhQYnBvTVVmaXVFSmlvYUR1VlRXQ1ls?=
 =?utf-8?B?TzF1aEYxZko4ZUc3dzB0YzNNeDRoYTE0Z2ZXY0JhbzdJNHRVVlVVdHZ3Q0o2?=
 =?utf-8?B?a0hoSjkweS9mK0VCa3VQaGFyRS9PZG9FNS9xdUVzd2ZrTVNpd0ZLN2RmRUx6?=
 =?utf-8?B?Q0pBNllXb0pXSzFkYVRqcGkxZVRtNDcxS01OaUw2bUV4WDIxSCtydTZkUFd2?=
 =?utf-8?B?VzNacUtsc3NnanhMUklGTm0xT2U1YmxlblVwUzRQUHRkNldiQXdsWXVwU0tU?=
 =?utf-8?B?TGhNbVhSMEEwdlVUMjJBWVZrNkpWTEh0T1FCRGFPaTBIak1DNElvTGsvU2FR?=
 =?utf-8?Q?wmjhK5wu5OhfpNn01haxvVV36uhblT5f+bZBtyP?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b074e7-5715-43d7-152e-08dd98575af4
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 11:05:11.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1941

On 5/21/25 12:08, Christian Heusel wrote:
> On 25/05/21 12:03PM, Maud Spierings wrote:
>> On 5/21/25 11:48, Maud Spierings wrote:
>>> On 5/21/25 11:29, Christian Heusel wrote:
>>>> On 25/05/21 10:53AM, Maud Spierings wrote:
>>>>> I've just experienced an Issue that I think may be a regression.
>>>>>
>>>>> I'm enabling a device which incorporates a lis2dw12
>>>>> accelerometer, currently
>>>>> I am running 6.12 lts, so 6.12.29 as of typing this message.
>>>>
>>>> Could you check whether the latest mainline release (at the time this is
>>>> v6.15-rc7) is also affected? If that's not the case the bug might
>>>> already be fixed ^_^
>>>
>>> Unfortunately doesn't seem to be the case, still gets the panic. I also
>>> tried 6.12(.0), but that also has the panic, so it is definitely older
>>> than this lts.
>>>
>>>> Also as you said that this is a regression, what is the last revision
>>>> that the accelerometer worked with?
>>>
>>> Thats a difficult one to pin down, I'm moving from the nxp vendor kernel
>>> to mainline, the last working one that I know sure is 5.10.72 of that
>>> vendor kernel.
>>
>> I did some more digging and the latest lts it seems to work with is 6.1.139,
>> 6.6.91 also crashes. So it seems to be a very old regression.
> 
> Could you check whether the issue also exists for 6.1 & 6.6 and bisect
> the issue between those two? Knowing which commit caused the breakage is
> the best way of getting a fix for the issue!
> 
> Also see https://docs.kernel.org/admin-guide/bug-bisect.html for that,
> feel free to ask if you need help with it!

Thanks for the link, I had heard of it but never done it before. This is 
the result:

ed6962cc3e05ca77f526590f62587678149d5e58 is the first bad commit
commit ed6962cc3e05ca77f526590f62587678149d5e58 (HEAD)
Author: Douglas Anderson <dianders@chromium.org>
Date:   Thu Mar 16 12:54:39 2023 -0700

     regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.14 
and 4.19

     This follows on the change ("regulator: Set PROBE_PREFER_ASYNCHRONOUS
     for drivers that existed in 4.14") but changes regulators didn't exist
     in Linux 4.14 but did exist in Linux 4.19.

     NOTE: from a quick "git cherry-pick" it looks as if
     "bd718x7-regulator.c" didn't actually exist in v4.19. In 4.19 it was
     named "bd71837-regulator.c". See commit 2ece646c90c5 ("regulator:
     bd718xx: rename bd71837 to 718xx")

     Signed-off-by: Douglas Anderson <dianders@chromium.org>
     Link: 
https://lore.kernel.org/r/20230316125351.2.Iad1f25517bb46a6c7fca8d8c80ed4fc258a79ed9@changeid
     Signed-off-by: Mark Brown <broonie@kernel.org>

  drivers/regulator/88pg86x.c             | 1 +
  drivers/regulator/bd718x7-regulator.c   | 1 +
  drivers/regulator/qcom-rpmh-regulator.c | 1 +
  drivers/regulator/sc2731-regulator.c    | 1 +
  drivers/regulator/sy8106a-regulator.c   | 1 +
  drivers/regulator/uniphier-regulator.c  | 1 +
  6 files changed, 6 insertions(+)

bd718x7 is the PMIC on this board, and one of its regulators is the 
supply for the lis2dw12. However I feel this regulator driver is not the 
actual problem, but the actual probing of regulators in that driver just 
doesn't work well with the asynchronous probing.

