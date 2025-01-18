Return-Path: <stable+bounces-109421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AEBA15B5D
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 05:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E047A0291
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 04:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D7377102;
	Sat, 18 Jan 2025 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KjdpzKcM"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01olkn2075.outbound.protection.outlook.com [40.92.53.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45037FD;
	Sat, 18 Jan 2025 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737172854; cv=fail; b=SExCE9DtYPUpVi2hABxBjDqWqM+yezdEYyeDBrg91Xf6lwANkTOcw3mAGdC8YU07qAw21ffMjeBlwh/79y3/SQHVrLDu8jfo3eMzVu299GzXzmsbMWUrZZGiamp/BKZe0hUHWs9EfGxmU173dkHf0RhGiS5wj6V7Li7nYjSWMpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737172854; c=relaxed/simple;
	bh=HXMnNIlpkSkRUu9CMvKoZSUim/+5EzXwIDCl2NcUoZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sA2DGqJDgNA0Y3jzVizTAECAFCZZg7GXxZ/Y837IH3GVKElS7kvn1wTIRUzGDIz6ImY+NpQCOiRSlLECMHpTQWv0ERv+xCcUWEyEn0zkl1fCqUIaIh4R+TItSQqP9LUFoJ5581ae1/5ceMCGgKVdUi6wE2Yk2TTEhD/Crh7IGQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KjdpzKcM; arc=fail smtp.client-ip=40.92.53.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAtbfXF5rsGQA/M/XBG29GKJPTncdS3iXucvVkpyQfzPudrOGH/JFFwnlNwLdPj/7VfLHPXOfaDIi3+Ca3BV0RRqHqLDk2Jg01DrDw37ItZix8LvJyaNAPLDpyYBPJ45RnGn2eKlhuFKVg7aBg2Ay5Rshk3VYKJP4Xo/dDt5dm04J3lVvCDg22sOp7/MwwID4bnPsu9S9gMmN9Ylnovn8pRthHDj6F8Af18/oej0dcOlBJP8v4VldQgiSR2vZGjbDGJDcF25znysR6vto7RpbMJyEJdkWq2dmNCs51fOsn+OE/uY33tEaJEt1yqT6+qrbeQd0MvimMc8TLWufueVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YyCyFODTpMTXaUtYhMMzpo2PwfDubl6LkOiL+8ZhXM=;
 b=EPW5hUpdEwSy9kPgqhn8vk3O35D9xCrir9LCR9v8I+tCfRcJiJPEsVAbKOgPiC4Ag0G3BDMEZljpY5ITUfDyMzhEN53o1YqA0EtO1pn0g5jF9LJC/Ajenl4rYYM1/XgCL9g4FIm84qBp3IHeDQK0odBaJq9I7ikyunW0i4q4qtqNS/cShdyZdCcltmaUp4cs73ZOhOUVeKEABmIY6Hvm/z61EFJneO28mIrJIQDxblPfgKhBxUSGsm1tXlvnp/Z9y9iqHpilxo7g+xEQqeoS69ZZqh9S3nC/QJqwSedamDmShcDli2uz1sYwCWkeVWEExD2JxWtf26k74mNEhWt0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YyCyFODTpMTXaUtYhMMzpo2PwfDubl6LkOiL+8ZhXM=;
 b=KjdpzKcMX3/2Frj7jxMgm+fjhUQeU0WKLrqGmTZpnW4SDazfT6WkJ0evjVq2kOZ8Xh061BQ270kI2Ly9AROVEAlC4mGHPapUYFSIsBkBLZ53tbwdShqtmP2alVVHcOk9Zz92WQqPSFYk5s3V+po1z8WW+/LUMbxNml0oiBAJHf7CqpbfKaNBK4QZBiXUkd2JCGAP5kZeoca7zPdphqSMujMYlEogtrizewqrdNm5+oLtayxD5xTlCI77bCGmSIxoIPW3dE5To16mQVLgS1mSdNTaxjADQ0Nm02lqDUhdZLDvxjRDJrzLkF89WRm0d6yXUb44qoTzu8r+jMYIueEleQ==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by SEYPR03MB7757.apcprd03.prod.outlook.com (2603:1096:101:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Sat, 18 Jan
 2025 04:00:48 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 04:00:48 +0000
Message-ID:
 <TYZPR03MB8801A04C30D95381FD9205BED1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Sat, 18 Jan 2025 12:00:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin@zytor.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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
 <d96d60b9-fa17-4981-a7e9-1b8bab1a7eed@zytor.com>
 <21a2dc23-a87f-42aa-b5c0-ab828b1c6ad8@zytor.com>
 <9315ac61-f617-4449-ae23-72ad23eb668a@zytor.com>
Content-Language: en-US
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <9315ac61-f617-4449-ae23-72ad23eb668a@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To TYZPR03MB8801.apcprd03.prod.outlook.com
 (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <392c3622-1b1b-4214-b67e-728783cf0f4c@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|SEYPR03MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fc8e49-6ee6-40de-b7a5-08dd3774b0d5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|36102599003|15080799006|5072599009|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2h0c1NycG1zalE5WlZZMEtac2VuM3N3aWE5T1czK1NQL0UvMEpockJ5QVJT?=
 =?utf-8?B?VjMzS3JLcERYTHlnQVdmZnlGSEQ2c1FEOU5YSTliSzI1VWxXK0lYUDN5UU1u?=
 =?utf-8?B?L2hLSGdNU3hpVzNsVGhWZG04d3RTWHQ0MW8rWlY5ZGhEM3d5T2JMQml2R0pK?=
 =?utf-8?B?WWpMU05sd3FncjE2eU1iNWRRY01hbi9pMElueERldVZwbEQ0aTh5Uk1wTC9o?=
 =?utf-8?B?Q1V1enIyVjZraGNqbVF5KzhMUi91cjBiaE5VWjAyV2xoWW00cTRmOUJ1MWJv?=
 =?utf-8?B?VVdPZXF2bXZ0cjBXdjMvMnBmSXBKS2VwTmFna0tnZFM4TzRmZSt4ZkdMRFU5?=
 =?utf-8?B?M2VBb2J1RUR5UWtDR2VvNVBEaEd4S3Rzak4ra1lGRHV6Vnlvejl1bzJMelRi?=
 =?utf-8?B?OVJHQlMzRmJHUTFpejYzS1JpSUZ4SFBVSHRGOFVObVNmdTZFUXVNR1E2M2FX?=
 =?utf-8?B?UjZIaFVNMzcwN0o3YmlzQVFqNGxpOVVBQ1pnNjd4S29OcTQrVGp4U2t1dFFT?=
 =?utf-8?B?VTdHMG9OZkxnSzhmS1Y3MW41czNjOWVRc2pEY2dzTGxwOWROdlljL2xVWkJI?=
 =?utf-8?B?a1VWaTNXaU9RK2QxVHZkVml2WjY5U0RKTlNNaytubktCVHFGYm1KRnVQQWI2?=
 =?utf-8?B?emJpZnRDT1hNc0Q2QTFjV2tjdWd6bERPaDlGSlV0eHdnenQrcFgxT1hMb0NK?=
 =?utf-8?B?ODZma2M5OG5WUEVJbnZUakViU2Zmc21iMWFacGxNakg4Y3ZMTWJhbkxsYUJG?=
 =?utf-8?B?ZkxSSU5GOTl6ekhNOG80ZFVTQmhoUng5dFMrQklPWDNvYmxla3BpYVdaenFW?=
 =?utf-8?B?b0F3ZVJBSk4rQm5IejJzSmVYRjRlWjhIMEF4bWIzczhCWlRyTHNjbkNhMDBu?=
 =?utf-8?B?eTVzcEFITHIxZ2RnUUlkSGxLYXNNVUQveXhRMjdwRnRaL0lVbFVIYkFMVUFh?=
 =?utf-8?B?QUFhdUJUY0NscjByeG5qVy82dWdqYUttV0traFErQUJJWTgwSko1YTlpbHNH?=
 =?utf-8?B?cEdEei9UVXRQemJrUkNxRW9MOC9tZUo3cnZnNnlCMlRVMm9wbEVzRWdRM2I2?=
 =?utf-8?B?bWFSc2NWRThORkJpNWw4RzNPTnQ3REFwV3pnK0Y2dnhXbVZzUGd1SFh1RnBy?=
 =?utf-8?B?SUIxMWlqTERWZm9nL0ZKaGtoWWQveThZM1dmTUVYZ3RuaHgxcGxWTlFSQW01?=
 =?utf-8?B?U3ZkUGVZNmFJSmw3NTJxcTRBRU80K3U4alRUWktVUnNBS1JCVDF6MnBqaHZn?=
 =?utf-8?B?cFFBSGlhOTk3UCtHbU4xRXB5cnYvRzJIQStQWFZWZW1vQUNjRThTNlhrVENB?=
 =?utf-8?B?NURlMXdQSWZzaFUwT2FPMnBMZjFjUjYyNVR0UlpwaWM1NEZydTlGUi9qZDEw?=
 =?utf-8?B?ME5KV29iSHFZSjNhUm1EaTBnTVFHdG1yUXFvK2xXZGpVOE54aFIzaER4QUJq?=
 =?utf-8?B?c0wzNGJ6azdqVytnTjgxMlQwb1VwOVhIcUZZMHJSN2FRZFlIYnZFY1ZmbUJn?=
 =?utf-8?Q?ZU3kOw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmlwdXZqTVNsaUxYbFhWNC81VDZNeGJDQXd2OUJKQ2dNbGpCRWhqOCtYc0FC?=
 =?utf-8?B?SDJSL1k1WWswRGZpKytEZmxLTzkwVXJ1MWhQVEk5Z2lTZTZubkZwWDJPZHJl?=
 =?utf-8?B?MGJtdFMxMnRJZ2k0RVMyR2RQTStlNExITmQxVkFScllJYmtIdEorL3IvcWZs?=
 =?utf-8?B?dGNmL0djbDUzdFJ1VndmRGJBTTE5bklSakY4d09ydWVJR3N4d1k1dU5zUWM1?=
 =?utf-8?B?NXdISTlpNXNMTGJUOXFYa3YzT2V4UFNoQk1ZNDFVYmhhTzFTQ0pBYnFuR2Ir?=
 =?utf-8?B?aUxTNjJUTFdLUGlNVjNxRDFueVBVQThqT0gvK1JMM1N5aHdzRnZ4TlRJRnBS?=
 =?utf-8?B?eXArMUxWYkQ0UWNPakhYN1VUNE1tRTFiL0NnZFNEMnh3MUVadkZ4dlhZRDBF?=
 =?utf-8?B?WENsdFU3b1pIZ3Urai81Y2xvSlppTWhrTmFKYmlnUTBta1ZjUWlCV3dmUWdW?=
 =?utf-8?B?OWtVQVlpSU56TUxYSkp3enJUSU9OZGVoeFNFSzBtYUFFa2QyMTRZK1Vkblgv?=
 =?utf-8?B?cVdVTnltZEgxejFXVHlZMTVnNzlOWFFaQ3ZKSXUvZ0V0U2l1dzk3eHhDdVZM?=
 =?utf-8?B?dStWaUtMKzJxL0d5b3FjMi9ucXlwb1NEd2JoaXhqSk01YWV0RHRTeUhBaEJO?=
 =?utf-8?B?UHc3NGhnSHVhMnFnK0NrMWhqbDlCN29CUlJVTE1xYUM5enU0MDZ3aUhXTkxF?=
 =?utf-8?B?WE5jYk4xaXJUUUp6dW5LZkZUcHh2M0t6WmgwdGwrSmRMcTlndzlHWENVK0lX?=
 =?utf-8?B?azUxTzJxQjdZT2gzVDVzRU04WXBvNXZ0cE40NktqS2FEOFRLNCtjelFUUDBl?=
 =?utf-8?B?UDdrTWFXRUV2akZmd3VDMDNKMHFzckFlVS94L2Q4cHFnYTRpNTJIVGlwS0xR?=
 =?utf-8?B?MmtmZUxmK04vSEhUVUVmaC9jRDFMYWZ1YzZCOVExbFVFcjZ4cnYzNDlEa0Za?=
 =?utf-8?B?Mmk4NUJmRW1GNkYxM0FWdWpqWWozVFZqb3RuZ2dsNDZGTTBVM2hZTG1KMEpV?=
 =?utf-8?B?YUtnM0Z5RGFiWjVRREdSOFFUTVRGa1BxWWRMR2RuSHhKSFVrRjZjK3hlK0h6?=
 =?utf-8?B?N0VQSVZ3Tk90LzdkcCs5U2lvcnhRdFpadUdnZklZdys1TENCL0JPdS9lMmhj?=
 =?utf-8?B?b0pxY3REZXMyQ1dKd2RyVG53dldackpTbVdEZ3FRZ2xIL0VwcTdjYldGMXpu?=
 =?utf-8?B?dmgzVjNNMU1DSWNqY3g5QU5NTktMSDNSQlZyQzRDYWJ2Z3pCekJiQng5Ykgz?=
 =?utf-8?B?SzQ0RlBKN25ERDFQN0JIcm04ZWZrU0xtS2Y0ZE5TKzBIcGpsS1Z0dUNyQjBF?=
 =?utf-8?B?RDFwY3R0Uis0bmdQUndJUE9XQk5UNWgzVEp2NXR1TmhwNWorNnJpR0doeVor?=
 =?utf-8?B?OU9VVG05bUJLZExxcTRvcjl1ZDBKbUZvUkxrakhxWEhqMVJ0TjV1S1FQckRP?=
 =?utf-8?B?anEvQ2R5eWthTm40Q2Z3ODFVZVQ1ZEdPT3hHNHhMNkpGYlU3K0phZmtzMS8y?=
 =?utf-8?B?U1NtVVUraXA5L0FlOWxEa3VBWjliL2NkWXNCR2Q3ZDFnUjhmRVNtSmJVWXRX?=
 =?utf-8?B?TmRJVmU0ZDdFekF4SGtZZTVzdlpRbWVRNkhxM0ZhVk1TRlZEb3dMbzRMWnFX?=
 =?utf-8?Q?0I37TkloH79GDQOShHVyi+FbNn7ZcTc+1dlFfae7FThw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fc8e49-6ee6-40de-b7a5-08dd3774b0d5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 04:00:48.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7757

On 1/18/2025 12:23 AM, H. Peter Anvin wrote:
> On 1/17/25 08:17, H. Peter Anvin wrote:
>>>>
>>>> -       switch (regs->fred_ss.type) {
>>>> +       switch_likely (etype, (EVENT_TYPE_EXTINT == etype || 
>>>> EVENT_TYPE_OTHER == etype)) {
>>>
>>> This is not what I suggested, the (l) argument should be only one
>>> constant; __builtin_expect() doesn't allow 2 different constants.
>>>
>>
>> The (l) argument is not a boolean expression! It is the *expected 
>> value* of (v).
>>
>
> Also, EVENT_TYPE_EXTINT == etype is not Linux style.
>
> More fundamentally, though, I have to question this unless based on 
> profiling, because it isn't at all clear that EXTINT is more important 
> than FAULT (page faults, to be specific.)
>
Perhaps the conclusion about which is more important/higher probability among EXTINT,SYSCALL,PF only applies to specific kind of workload system,
no one-size-fit-all conclusion there to dig.

But for a normal system, it is certainty that events like EXTINT,SYSCALL,PF would happen in higher probability than others. saving some cycles for
their paths isn't hard to understand. just like taking shortcut at event type dispatching level, no other changes.

> To optimize syscalls, you want to do a one-shot comparison of the 
> entire syscall64 signature (event type, 64-bit flag, and vector) as a 
> mask and compare. For 

To whole event dispatching path for syscalls, yep.

> that you want to make sure the compiler loads the high 32 bits into a 
> register so that your mask and compare values can be immediates. In 
> other words, you don't actually want it to be part of the switch at 
> all, and you want *other* EVENT_TYPE_OTHER to fall back to the switch 
> with regular (low) priority.

switch() seems not too bad, at least compared to jump table.

Thanks,
Ethan

>
>     -hpa
>

