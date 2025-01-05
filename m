Return-Path: <stable+bounces-106757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D9A0186F
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 08:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF33F7A1795
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503335973;
	Sun,  5 Jan 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C5OiufzU"
X-Original-To: stable@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2014.outbound.protection.outlook.com [40.92.63.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD3442F
	for <stable@vger.kernel.org>; Sun,  5 Jan 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736062164; cv=fail; b=Pf83raUYmtgsrUaZNygmfZKOqzBaZ/Wrd7bGsYYCKkbkXDKd8Q56a+6N2+j9sDrCye+aSRmaUicEvtvUEEPc7dN2TX3tTBYGBETIZec+ZCKmQM260C1XBwRDox9mGBWT843zP+TRLkPlmkUv7gMbQG6tPuqoSTd7tQEZg5WFtzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736062164; c=relaxed/simple;
	bh=a3yEBaGOekwFNpIeSI6/Zk34FsvOHPpzMYGQeSLvg8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kz3PO2J+2UrUYrQi9g8hx+P3zqoc90Lq4jtRhxz8dv2C6opfiwNA9xCSYQPmcO2wfo+2Pgi1B+OXWWJ5ovx9dvPTlB48yV9eMgPTjAbJ3S1nKyQI2z7HeGHJwZA7S2SGkewC7juEsTOPlqjjRpj6AUsI05csYtEXUEoahOvTGl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C5OiufzU; arc=fail smtp.client-ip=40.92.63.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AX2KBH6B4ABxwFsziMNzsvIN2DQtvFc5I6k7he5140olmlwmaTf7Xy6js3yIV424he22rz3pYxvR7MSiimw7vcPeTIaIQzswpeaGbuUHfjNOavzF41+yT0RB+vv1m77sUUhrsX6E/iCJTJqjYa8YaH0gSppLu61RUmq//Tw9K6AwEuNsbbDA/Yo6TSArteQ8D/4CP/YHgiWVzxxKLvJy8vnYEVpkQLF4wbMt6sbJ0PLhy/jQUaz5hG9z6OmHBSzzsQR39JyrngD9hHXmy9gDEHhciGLnDoJS+t6GVrF+rK/c6u0rndgATJ1Y29rmPXLybzL4vWaq39lQ8Se7/0StAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQJZkbNYQCbt8vZokaVMy0OS/OCvXDDSsKROipnAEwQ=;
 b=Y11QBQz4GHnEYVKJZUhdou24BgF2DdvkfDKvtQ4b/zjmcdJlCn+fjKiBu4fbnemPbJbcUx62fMPT+Xo+zxb4MKUjv2q6ClWsVoqGu6k+9y0GMSUmDn9V01ylJ51ApEKRqhIT9FMGj4q+klp0xOWyRKzbOhxpSd6JNmPnteRoUlvDjZ1/7gjaWwZEB2d8GQyPMMNTeqBtU4xt6XLnS53ph8EmLQBQVqrMCKs8rAwBWb/57DRHZnZBQEOC2EHY6EefQx35Dh2dY72M+7VYTCTTktA+wvTu0y6Fr5d5hf6U2IrGTVhu+4A2xbzh7oCzD9QU2tPAaYBqS345Ai19PxfBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQJZkbNYQCbt8vZokaVMy0OS/OCvXDDSsKROipnAEwQ=;
 b=C5OiufzUDq7onlgcDzdIqRarFd/6HE529WLFGsAsmFUCRwaXerJq9roz7NSTW89uvc1D61eC2BZWpSJv8TvTy5NG4r003Wqu51tz3JQ7YyyqTB0wo7MWzGTcQgT21bzT/uoDn7txx3kP4FwJeyhSd6k73Z5hyPrqPgno51cNSUj90dojk1SOuZhzr8u+7Sh+AsbQQECjNFgpb9dyVJ3BWnRtw9LefWIPgRzV7hr9UEp0VUchzsMff2qmn1onzxCBIvkGcXj4I6PFVehb5LymcscYEzRupCZm99/nKumnX+yn1XrLxoPiz5yE6iI2cHXKCXp+c0AVGV7nK+n7RRM3WA==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 MEYP282MB3482.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:17e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.9; Sun, 5 Jan 2025 07:29:19 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%3]) with mapi id 15.20.8335.007; Sun, 5 Jan 2025
 07:29:19 +0000
Message-ID:
 <MEYP282MB2312577632CB3812D002FEE6C6172@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Sun, 5 Jan 2025 15:29:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.6] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>,
 Alexei Starovoitov <ast@kernel.org>
References: <20241126073710.852888-1-shung-hsi.yu@suse.com>
 <MEYP282MB2312C3C8801476C4F262D6E1C6162@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <fz5bo35ahmtygtbwhbit7vobn6beg3gnlkdd6wvrv4bf3z3ixy@vim77gb777mk>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <fz5bo35ahmtygtbwhbit7vobn6beg3gnlkdd6wvrv4bf3z3ixy@vim77gb777mk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0194.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::22) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <3b9c9c0d-1ed2-44d4-adb5-884f3e0778c3@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|MEYP282MB3482:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dea97a3-b0c0-40ff-6804-08dd2d5aa99d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|461199028|7092599003|8060799006|15080799006|19110799003|8022599003|1602099012|10035399004|4302099013|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFc2T2dDaEs5VmUwcm4rL3NHb1Jna3pNMy83WG43NWMwUWhQZDJFNGxTU2R4?=
 =?utf-8?B?a2k0MGJqS3RGTWduL2ZxSFNrbDdjNzliRjR5cXpod21tU283VXRpTW9GUWl4?=
 =?utf-8?B?OUMxNUhhVmdqZ254cHdrclNLQXNJUWZBdS9LNFdQMkNBbFNkWW96SGVsd3RE?=
 =?utf-8?B?b3BqSzhwaS9XYUVPR2ZVU3lFK1M5RVlVVThSaitibUlhWTB6bnNNNEZsYXo1?=
 =?utf-8?B?ckxSaE9QN0RsYVJkQkRJdjcrZzU0U1Y4d0xFcDlTOU50NC9CSkVCdWRBcnYx?=
 =?utf-8?B?dVJoQ2JjVVhURnVWSnR6WTVGRHZxdTgxTFE3WGFwYmVoeFBIeExuZzd2YlFK?=
 =?utf-8?B?NEJhdGZHU0s4Y0NURDRPdXJuTmZ3YnhJOE8zL2hXSGpCbzVxRmtJLzdwT1hE?=
 =?utf-8?B?WHhKcUxGU3IyS1grNURZZXF0c05OQ2JSU0loRG1BUEV3SE93SC9Bam9weEpp?=
 =?utf-8?B?YmtWYUY3WDl5ZU5LcXU3WDhFRUhPSCsvVnE2VUVTcFpmUUNjM0xPM0xqaEVa?=
 =?utf-8?B?eTNkZjg1Q0tTU3NnL3NkaHVqcUtyV2dhaDlJdnV1bEZxMmcraFA0ZW9OWkVu?=
 =?utf-8?B?dmcxOWtNdExFK0ZIcm43Q2syUkIyaEFpZjdGSU1HalhaZlhLT1hXWm9YZWxZ?=
 =?utf-8?B?MDB1T05JM3lMWjRNQnBseGRiVU1NOWZpZXNiZFFpQnlvRTFIb09NSk5ma2FC?=
 =?utf-8?B?dEFXNWt5UWM1UFBKblRsTzFlNXkrakV3bitlcDQvcXhLc2tzeDE1Y1NmRXlB?=
 =?utf-8?B?bmtTQjdIdzJycnJPUGlHWWJBVndtejM5YVEyVGdLSC94emhJWHpjL093QUJi?=
 =?utf-8?B?V2RlazBHdjNJNHZpMVhVaXd1RDdSZk1FVHlEUlhONU1aTHp3UjlmZy9wOE52?=
 =?utf-8?B?aW1tQ1ZESWovaUc5T3p6TXFJc1I1TFRJS1RvTUxWNmNnejhWODF4ckJkU0Zo?=
 =?utf-8?B?U1pTK2hwdmdETHhDNVhtejd5LzJnSHlqR2JWdlgwUUIvTFNOekZvb3hZek5K?=
 =?utf-8?B?Q0VLRmVYeFdPRUVxQWUvL0o0ZWtGU0ZJVnVQTFdzK3BQT0VMTy9YdlgzL05I?=
 =?utf-8?B?UkU5VjlGbnZIR1pYQ3FVMkVOU3lZN1pJTGhiMnFtTzNnUHJMOWREeVpaRW51?=
 =?utf-8?B?UEt4UTVQUHdCM2M2MCttVnhYc2RaZ1VHVFZVaU9nTk14U0k1VDJsUjFMaVh4?=
 =?utf-8?B?eWg2ajdIaVhCMWJ2a3lCQVZUenh6YUticVk0MlR1ZkNlam5FbHVEUzcwYXNL?=
 =?utf-8?B?em5MVzhYYndXa0dkVUM5WE44TzJVRGd1UmhiVzdVNWJCZFZyeTJoc2VlOGda?=
 =?utf-8?B?TUVwZFY3TEVTYUorOGUzRERRcU1mdExvdkk5VEhobzFLcEM3Y0pSTG1FVlB4?=
 =?utf-8?B?RTRmeDhBT2pFb0p5by9UTTl1eVBTRWdKMWlzNnBJMG0wRDRzL1Y5VWxZZ3VY?=
 =?utf-8?B?dVN4WkZybHhkSjdsL0hZcEN2ekRqU3BLRnhjZkxGU1BDOEM1ZGUrYlJ5Skx1?=
 =?utf-8?B?TThGOVRsQ1JDS0thYlJjUU5uVmxvS2NsZFhEbVNkaFlRWEVudWxRbUpIR3ZF?=
 =?utf-8?B?bkpSd1A2aTQxQVFpZ0ViWDcvRDk2RkZtd1ArK0RPZFUrcDZ3VjVoTDM1QVBQ?=
 =?utf-8?B?WUY4endiMW9KclNteDFXdmdUYU9admVwTEZvV0Zzajg2MnI4MW8rQU9qRS81?=
 =?utf-8?B?aS9NMkRNTFFzTGR4V1NIN0g3dit2L3dEeFBaejlpNW1mZXVZNFJYYzZRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlllQ25LM2JrNXlReGFmQmJMRnJoODd6VUxwWU5sRnVjWFA3RVViZUloc3pR?=
 =?utf-8?B?SmtuUGNIUzM1bk1oOFRNMHY5eVhPWVN6UmVycFFSQ05ZTlA5MWwxR1liWEVG?=
 =?utf-8?B?MWVzOTlQWGRBbFZxZXgvcExXeGxDRmNVNlgxOGExTTlQOGtDWmR5OXVXSWZG?=
 =?utf-8?B?ZGhIQ2pPWDBMQ2N6ZnQ0cmNVeVhST2YwRFJHQ202dG0vUjg0TGNCYVlOcy9m?=
 =?utf-8?B?YTFTeEV6aXFmMjNzdHd3T1pWWUVieGU1cEViV09RMFRvek0xclZlMDZrcHZ6?=
 =?utf-8?B?UHd3eHNBWDN2cXlxQ3lyQmhYUjB5eW5JVFRUTUo3NHA3ZUEyci9kNlJ3RTB0?=
 =?utf-8?B?MDhsNW5vSkx6Q0M5YnM4YnpJdXZLRDBCZWp4Vk8zdVg4eUR5QlJDYTFpSUpR?=
 =?utf-8?B?OE5OZUMrWXNaSHJodnczSkNVMFpzV3dmR3RSeDNLYllrN2tPK0dlWEMxVTdZ?=
 =?utf-8?B?VTAvZlU0aDJ0LzJpdEhBTnVLai9LNG01N0J1L1JkcWppcXdpMHRBSUtsRjlF?=
 =?utf-8?B?cGhZOC9NN2tVMnU2ZDdSbUJMRkVjR0FvK2pnSTVRV2hXSzVQaWNXRmxobDEw?=
 =?utf-8?B?S25XR3JYbFVSTmpzMEFXdXVvTGc2cDV2TEk1RTBTaWZzSTBtUzlsNmFlcGls?=
 =?utf-8?B?eUhtS2huVlN0R3ZRNlFaNnhWVlRJaURtVnExUVFtOTJDbVhwcmE4ODZMZ01p?=
 =?utf-8?B?RVZNQ2pscmZ0a0hzN09BR0VMWVIzZmhlRDZZME5xaFNGWklRWWY1YTJDRVA3?=
 =?utf-8?B?T25sdTUvUlNwVzJkTGdkSjdjZGhMbjlQTjQ2bmNXVWhPZHRvMkRBTmFXRnZu?=
 =?utf-8?B?Zm9ybEJ1aEt4STQ4VUxtSmxXOHJ0K3NzakUvaUsxL0lOTyt1bTRlYWFYYnIx?=
 =?utf-8?B?TE1Wc1lacUxEanY2cUJqSENBWXJZQlRYb0lLZERadGs4Um10WDFyVXJvUjBE?=
 =?utf-8?B?RHpQTFR0TEl3UTJiYUdGdzIxaDhuM3FjcHF3MlZxMjlvSjlkSjZPa3FPUjFk?=
 =?utf-8?B?SGV6bkxJOHdOVnErSndDdUg2YjQyQ0RGcGxhaC9yUGRsclFNMnZRVGI4MDB5?=
 =?utf-8?B?TlZ2cmVpdXlzYkc5WG1jWW9wbVFGU3g4bGZ6N1ozQUI3dGhZYXdmQldUREgz?=
 =?utf-8?B?UlFUNVd0RFVzdDJwUGI0Vm5oV3A4WnBZa1cwelFvazVPV1FqTnJEM0tCWFBO?=
 =?utf-8?B?QWJOcVJBbFpFZyt2dFc5SEdqcmFEdkFpMGEwRUwxQklPaFIySEx3d3BjS0ht?=
 =?utf-8?B?eXJPQmJFMW9lWEtYTk1jSVc4UjMvdVNKY0pWeW4rTDBpQ3NOL2ZhWVRyTlQ0?=
 =?utf-8?B?UFMwMjc3S0ZXcnBleStUY0hvT3hQL29Tb2ZhbXM5b3JBVkFscVd3OGwyNHo5?=
 =?utf-8?B?RzFaL2RrZ21lL2Z5c0pPK3NNZG5LeXdjQmxXMUIwbzh0R2FRcTRNSmpSS2ZG?=
 =?utf-8?B?VVVxemF4V0RqZjlBUW1qT0Ivb1ZkZ1dBUEdCMWVMdXVFRGRTN0txMjJXK3N2?=
 =?utf-8?B?czlHRkR2aVRHWFlNQ2Vta2xxQVl4NzZqREpPY2g4WExwRDRrVVJQbkdwRjZo?=
 =?utf-8?B?M0RiU1pxeUMwdWFKTGtMMUo1ZlI3THhaemIxRUpLU0t1T21veEkzdGlOTDRS?=
 =?utf-8?Q?cl8yNDzVOxz3GcH5Q9oufBa8pVxTfzGBO/iqbsdw8RWg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dea97a3-b0c0-40ff-6804-08dd2d5aa99d
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 07:29:18.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB3482

On 2025-01-05 14:03, Shung-Hsi Yu wrote:
> Hi Levi,
>
> On Sat, Jan 04, 2025 at 11:02:43AM +0800, Levi Zim wrote:
> [...]
>> Hi,
>>
>> I think there's some problem with this backport.
>>
>> My eBPF program fails to load due to this backport with a "BPF program is
>> too large." error. But it could successfully load on 6.13-rc5 and a kernel
>> built directly from 41f6f64e6999 ("bpf: support non-r10 register spill/fill
>> to/from stack in precision tracking").
> Can confirm. I think it's probably because missed opportunity of state
> pruning without patches from the same series[1].

Hi Shung-Hsi,

Given that 41f6f64e6999 is the first commit from that series and my 
program can successfully load
on a kernel directly built from upstream commit 41f6f64e6999.

I think it is unlikely that it is caused by missing patches from the 
same series.

Probably there are some dependent patches for 41f6f64e6999 not present 
in LTS 6.6 but present in v6.8.x
where 41f6f64e6999 comes from.

>
> Given it's a regression, I'll sent a revert patch and try to figure out
> the rest later.
Thanks!

Levi
>
> Thanks for the report!
>
> Shung-Hsi
>
> 1: https://lore.kernel.org/all/20231205184248.1502704-1-andrii@kernel.org/
>
>> To reproduce, run  ./tracexec ebpf log -- /bin/ls
>>
>> Prebuilt binary: https://github.com/kxxt/tracexec/releases/download/v0.8.0/tracexec-x86_64-unknown-linux-gnu-static.tar.gz
>> Source code: https://github.com/kxxt/tracexec/
>>
>> Best regards,
>> Levi
> [...]

