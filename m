Return-Path: <stable+bounces-109422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0281A15B5F
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 05:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A773E168E4E
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 04:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1333487BF;
	Sat, 18 Jan 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QIcfSJ0/"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2066.outbound.protection.outlook.com [40.92.107.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C57FD;
	Sat, 18 Jan 2025 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737173195; cv=fail; b=NF73V6ZNQTs4QCCyTExVPFxalYBqEcSk60Nmh7BkeRHw7vudCys9MYj9M593pSNCobHqDfasZWo8Wu6MV4Fc9YEzRt4GTlobyCu9MCzN2wdZYqJ5gSOyAOzxh6MINUp92vGYvNaQM+bE595/SHwgMtl6pL3fgJ2zQ3Zzeh5LFEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737173195; c=relaxed/simple;
	bh=bonNK+ArhWGtB97KUpn5tW59BK+XauJgTujz1nTzfZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MqHDVIEXhs7VO5+BmXJefUlHSLtjicyhfSmaGzR7xd3f7AL5qornIYSNKfTLg4r9+Xh7Ked9Kgk/mJ/og9oE5ni+0wsDjKMbhb0G1Gc2z7/9IkSTCZ13IEjjVaCzXtQefZk7SMUylEoNmlsi0vbxpl6xW8B+m6EOAkI/7qVkGj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QIcfSJ0/; arc=fail smtp.client-ip=40.92.107.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY4LOa+BIaQexGxXouPWyywt3y1BkEHG8SbZMwStGDIiF2rhHSycykqrfyZfwCfm4ngotUO8BOZh9rUq4pqaONAHay8BydkVSJWSS3Msy0rHrVdsUnKpBpVwKh/sVNAB+kHQkQYmz3ENvtKPhWqpVbpa6tkLtwi8uTHEb2TUcpF6nqC7t7r0lqpT8KMH/qAkyQ8rak+F0APGyhigJbFU+A9h2E8XZjV9MCKbVXzsq+VqtGwWHNw7qMIWMNW+XESut5zP/Upfm1qu5aoEO582HYyAGo9U44Uul/Ji2TABVnUdYFLtDY4G9ixnbVFsbNh2zI9VrHcAlTkxQBwxkHqN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBrdz+BslU/MR0z+hZvm27MFA0E0JHfggP9cGga+dUc=;
 b=tWb1Kfa+EPEcho2Z/ofN760dtrkOxz9mz91S0TwAtT1LdKBwhjG0l/Fuv67A3KTsg2ngBvziUNwtcPe2om3HtS+YOTdt2ohKzBeJ/+EtZOexj00r7BhYVXl/tYI7+x6w8HnYOxAbepiyl7mjawgw/zATvDH+qp5x7HaBXvrPXCFAee1q6iYcyZhqYvGfc0ie5ExbzQ+no9pedNUxcfpUxASA6qoMxLC53F2pmhYYOSrRvKnj0r0+inskf1nLIa0A43/eZTVdNE4BWJVb5E2QMdzq6nrgebw+hY4VR30eR2CX+RjydzhAfEppUxnK0vKWOGUuDhh7s94EjZo+LQnalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBrdz+BslU/MR0z+hZvm27MFA0E0JHfggP9cGga+dUc=;
 b=QIcfSJ0/cxpJECXST/08jFKujODTomLg09zTJnNE6/1511g3NjUGuMHrB1XXzP771PfpUJztsnTYPddrVTSizxYtSXXxs0qeNETSyCdtHVwgEsp79joPvKhs8d6/oa26MaIiKmdbn8cM+DSc9mdOb+8bjAtv3ihLeEvt0aA/7AR4F6rMFubahHRqpbKw/ihH1ORxyBFwIEvkfTtnQMZW+afeO6zVVbwpHGbcmyze/Xk165u4cyF4yUNTmUQehU64lnHWR81QyW0ChW9E4GQ598Q6V98ec5tbnStZcNgPns+sjo8hwomIqoQ7C7+N4QeFiReyZELaeDVDXcA6K9e7eQ==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by SEYPR03MB7757.apcprd03.prod.outlook.com (2603:1096:101:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Sat, 18 Jan
 2025 04:06:29 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 04:06:29 +0000
Message-ID:
 <TYZPR03MB88015FA45675DD73D8570834D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Sat, 18 Jan 2025 12:06:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: "H. Peter Anvin" <hpa@zytor.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, Xin Li <xin@zytor.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
 <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com>
 <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <d90975a0-6b01-4a2e-92c2-2af2326e1299@zytor.com>
 <56b92130-7082-422c-952c-9834ebdb7268@linux.intel.com>
 <4d485294-959b-42a6-a847-513e8e3d0070@zytor.com>
 <33b89995-b638-4a6b-a75f-8278562237c4@linux.intel.com>
 <c111ecfe-9055-46f3-8bd0-808a4dc039dd@zytor.com>
 <TYZPR03MB880148D071B32806DBB1ACFFD1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <C3BA43FA-06BA-416A-B8C2-0E56F2638D80@zytor.com>
Content-Language: en-US
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <C3BA43FA-06BA-416A-B8C2-0E56F2638D80@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To TYZPR03MB8801.apcprd03.prod.outlook.com
 (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <cc7438bd-3d49-43ef-a39d-25fd797bbdc4@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|SEYPR03MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3200975b-3e16-435e-bb23-08dd37757c10
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|36102599003|15080799006|5072599009|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3o5WTNtVWpUVHJQV0hLdFgzVTZOcklwSUNtL3Rob0I4SnhyRXlmQnR0WVhB?=
 =?utf-8?B?L2s2NStKb21MeWZKS0d0T3ROOUUxZ2JUem55UDhLMXk5R0RjVGZCMGxsdEZW?=
 =?utf-8?B?Z1QrZWowQTRhaHVpUjZYLzkwaWI1SENGTXJ3RERmRHZ4Qmt2SmYwNWhmWUVE?=
 =?utf-8?B?RWNVYnJYSEhBenBYTDBTTzU5eitOQjdZdHpLdkRTQWRYR01OMm0rV01jcGF5?=
 =?utf-8?B?cXFaNTE1clBYd3IwVk56WkE3emw0MUoxMEg5N3ltWlFYNUovWTRiclJmUUxM?=
 =?utf-8?B?R3RHUUtGMEEyS0lrRjZPUlg4aitGejNuc0IrOXF4R1R6cmlzeGx4M0dod3dK?=
 =?utf-8?B?b1ZJelVqQXgzSzFubEZLdm9NZ1BMU2JNMW9nUUJkckg0TVBiZEZwQ1hYYVkr?=
 =?utf-8?B?ajkyRnZMMXc0VW0vRWZLWHJFb1c3bFJVKzllNUhUenhZTzc2emZxbmNXd1Zy?=
 =?utf-8?B?Y2Rub293Mm9Ud1lGR3lqMEJEZmtNSjErMVd3ZlhuWUZwY3hocVBDcXJ5WElx?=
 =?utf-8?B?MWRjNVRuYU5wUTJpTHFKK2o5UHN3OUU1SWxZbmZxMDBmT3FvTDBZWE9KZjVK?=
 =?utf-8?B?WUFlZnRjeEdSVU4vUzh4QnowKzdzNUorU0tpTGgyYUpIUHcrb0czUVVGL3p3?=
 =?utf-8?B?R1ZKOUU3aFYxL201Z1BuZkorUUYyWUJSdVRVNDI0VkplMGYzZlRaUkZqaGRH?=
 =?utf-8?B?NHB4bHcyclY5YkY1MGtxSGcwczhXYVY3cERCbFkyS0RmcWhpaXlobGJIUEdI?=
 =?utf-8?B?TjlPQzdJQ0JnVFpzdFhrajdpd01ESWNHTGRoOHg5OTZNR0o1dEF6OGZjejdn?=
 =?utf-8?B?MGNpd0pPN0ZqOXpWUHFIRVN6OWpJUkJKWW1EaTBGSUZaOWRObVpieGpnUStH?=
 =?utf-8?B?TFhESE8wUE9vTkI3SWRTSU9vbm1VdUs3Q1A4VGNXM3FKQUZhajUyMG1pSnlx?=
 =?utf-8?B?Z3hwcEVkeWs3NGNiZHVZdEt1bmZBODJQOVZ5V1hXRTc2dW0rR29OV0xJeTYz?=
 =?utf-8?B?d3ArYVJwa0IvTTYxdmFuN0FTTkVMVW1vWkNHWEp6UmplZDBxNjR2RFIvWmNa?=
 =?utf-8?B?dkJNUU0rSGRQNVl5ck80U3RDdGE0bWRVcDZkM3hOdk5UQjdOZXhhRk12bnRa?=
 =?utf-8?B?SGpqTStxaW14UjYyTTJCRGp1dXh6UFdoZ3JGcXlwUDNNR0gvdmlBVXZKQk5N?=
 =?utf-8?B?SXl6VkhtTEVvYi9uSE95OG1xVFB5dzhZbmMwaDZKemozZGpZNW1vUDAxV3BH?=
 =?utf-8?B?OGU5NUllYlhjY1gyZ3VvQ2I5bmNhUUZUQzNqc1V2NytoQTZ5YmE0cS9JM1p2?=
 =?utf-8?B?VUFUdndvc0xTZ1NyQmhlV3pScktkQnNpYWdaR2Ivd3F3djZQUmU0Y2VCOG9T?=
 =?utf-8?B?enhIUkQ4VFM4MkltQlR5T0ZYVERySVlaeXI3VzVBamdyZHl0cElORzl5aFBJ?=
 =?utf-8?B?QUJVc3p3ckt2dUcwM0UrbE5VVmdiN21XVm1CWS91SWRpYmRuOExnUGcvL3hs?=
 =?utf-8?Q?X4Rt8g=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1oyOUlidTVScTAwbW5GamQyOWxNMTNwY2FzdkVPOXM5ZVNjYVdCQW1IYm1L?=
 =?utf-8?B?UE54N2djeVZnelI1R2JKWHAxV2ZJR2xPNHBNRmdpTUlTdU9FejROdTV3QUtk?=
 =?utf-8?B?Y1N2bllBZzNoVmoxd3dGT05GbE1hMW14YW1nbUYyMzFsYjFqS1pSYWFyT2dy?=
 =?utf-8?B?VlE0MUlacStoaSswbDJ6M0ltcGdCQ2t0cm1pbnhWcmtjcmsrbDd6Mm42VkM0?=
 =?utf-8?B?SHN4QXVOODNUaHV1RG5ORTlyT1pZSDlVQURzem1wQWpNNi9lN3lXTmxXL1ov?=
 =?utf-8?B?R0M1RWxVNVg4ZW12Mm00VlhranZUMXBwKzV3K0NPczJJdUR4eHhRblJjUmZn?=
 =?utf-8?B?S1gxSXNDZ2p6aGVRT2wxNW13enZCWCs5elNIZ2Q2R1pGYWUxOHJYQUkxRWZL?=
 =?utf-8?B?aTEySlY0YW1TU0N2c3Bqbmx1dWFlQWFPVWFYaS9OY1pWd29nMHVYb0U2bjVm?=
 =?utf-8?B?K0cwVWpOOXVqZ0c3VnhPSTk4WndpZDZSMndKYnF1Wnd0UXN4TjNEUHB0Sy9O?=
 =?utf-8?B?THBQTTdtOVYzZEhUNmpKTUtOdkNSMVlLbXc0Z0RRQ3J4Uzc3YWNkN2huS3lU?=
 =?utf-8?B?Z0RGU0FWakpQTk1ZMnU1TXNLY2F2dEdJR01NNm9ydFAvQVpjcXpWcStUcktO?=
 =?utf-8?B?RlFpdnJXN3ZPOE52V29yZC9zSkdzdXBvWG9oSHRVcmZpQm5pSEl2Qjd2aitr?=
 =?utf-8?B?MUJnYkdRT1p2enA2cjRsamlmU2NNblBSKzlRR1Zpc3ZDdnFuQjF4L1pWY3Vn?=
 =?utf-8?B?OWJBNWQySmJiUUpIYkNDaWlENitXZUhpUk1ML2ZFVEpYY2tIcXB1NjFLaity?=
 =?utf-8?B?SVYvSzdvOCtKaDA5NW5YeURVWHVEQzNxaFN2bDFPUDhmQWNOeTU5eHdaS0lx?=
 =?utf-8?B?MktSQWxRVGJ6N1VvLzgvUEloZCtpQ2Y4bURmSHFkUFJHSXBRNGRKK0FhYzlC?=
 =?utf-8?B?Sy91SW1HU2NqdU84czMrNzEvdlU3TWROa1Y4ckFoa2JFcU9nTDV2UmQrbUoz?=
 =?utf-8?B?Wlk3K0dWZ3hxRHhXMm5QVHdlNENsaDVNazhUUFUyVnl0a0VSMUdsU3NDN29Z?=
 =?utf-8?B?dDlYK3p1dU5wSTgwSDZRbGFaOHRWTnZid2NTcXRPbldUZFBzU3NOL2tpOUY1?=
 =?utf-8?B?dWhMTjQ3bWR2Y0R0ZE1GS3ZGRjJnc2pGMCtBNXl5OWdTVFMzbEdQNDEyV25h?=
 =?utf-8?B?WFYrTkVlNVRWRDAzcWxmMU1MSVNtTFhVcUZKWmROeGJ3SzU2bEMzY0NGRWVt?=
 =?utf-8?B?RVVoazZkNjJ2Unk0alRYeUd2dzg5ZjRTVWt4Zm5rb0VnV2FzemZCd1lNYzd5?=
 =?utf-8?B?K1FSQ2w5NkF4alVUd05GQy96L0F5NlV5ODNMdTdFb25GT2pKUE5VVFl4em9t?=
 =?utf-8?B?ekxERERTL2J5dDZ3NHlOTGk1ZDYxZWZsdXF0RzN1RDZlcTFEVlVTZmszTG9w?=
 =?utf-8?B?aDdSY2tHbVJlTzB6cmk2SGxIOVhtN0I4dnVrRWd1eFpWVDdTRHI4cW9zMXdz?=
 =?utf-8?B?aklBV3VKMlZQYkhIc1lqYmV0NDRPcXQxRkxVZno0SkJzaTlLSGlqaVVacllN?=
 =?utf-8?B?SXRrcEZVR001L1VhZnF6N3JOQ01EcS9UWFlia0JHUklnZ1ZCTmdOdmhxK3pL?=
 =?utf-8?Q?IbDbGrpf7z1zNgJQqmDcc+HYe8Vhuq8AvuBpVG5+FRA4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3200975b-3e16-435e-bb23-08dd37757c10
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 04:06:29.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7757

On 1/18/2025 11:41 AM, H. Peter Anvin wrote:
> On January 17, 2025 7:29:36 PM PST, Ethan Zhao <etzhao@outlook.com> wrote:
>> On 1/18/2025 12:24 AM, H. Peter Anvin wrote:
>>>> In short, seems that __builtin_expect not work with switch(), at least for
>>>>    gcc version 8.5.0 20210514(RHEL).
>>>>
>>> For forward-facing optimizations, please don't use an ancient version of gcc as the benchmark.
>> Even there is a latest Gcc built-in feature could work for this case, it is highly unlikely that Linus would adopt such trick into upstream kernel (only works for specific ver compiler). the same resultto those downstream vendors/LTS kernels. thus, making an optimization with latest only Gcc would construct an impractical benchmark-only performance barrier. As to the __builtin_expect(), my understanding, it was designed to only work for if(bool value) {
>> }
>> else if(bool value) {
>> } The value of the condition expression returned by __builtin_expect() is a bool const. while switch(variable) expects a variable. so it is normal for Gcc that it doesn't work with it.
>>
>> If I got something wrong, please let me know.
>>
>> Thanks,
>> Ethan
>>
>>>      -hpa
>>>
> That is not true at all; we do that pretty much *all the time*. The reason is that the new compiler versions will become mainstream on a much shorter time scale than the lifespan of kernel code.

Yup, time walks forward...
But it is very painful to backporting like jobs to make those things in position for eager/no-waiting customers.

Thanks,
Ethan

>
> We do care about not making the code for the current mainstream compilers *worse* in the process, and we care about not *breaking* the backrev compilers.

