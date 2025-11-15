Return-Path: <stable+bounces-194834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA48C605EE
	for <lists+stable@lfdr.de>; Sat, 15 Nov 2025 14:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D4FB4E40E6
	for <lists+stable@lfdr.de>; Sat, 15 Nov 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A42D94B2;
	Sat, 15 Nov 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qwu/fXvG"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010003.outbound.protection.outlook.com [52.103.73.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EB239E9D;
	Sat, 15 Nov 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763213291; cv=fail; b=bKIvg55XF4GKNjuGhI64ddGAlYEqGqhQPJBgoIcP6djPuNc4F6JzwUh60RUHojV31v1LfLHXGxEbr3fLkNFSBOQWtzKSBoz7J5IHxgGZSeBAikLnMNjWGoV5rwCVz9+TL+zV0+0xdSk/+6TRYF4ycoKLMLtjm4rnGGYvywiajI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763213291; c=relaxed/simple;
	bh=rk/pH1gZXF62FATxV9j4wigTu1noY6oIGUZW9y7OVSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CUpy1UYUTmKd1pjC2qrD6nczVRpUWeWm61dG3ICdBoN0I7VBXJQSl8gptrylQSlBGcm4vstkZ/NVHCuuArNNDxfSFNkNyvv4HRRLQjN2gwVTFmDgGi9XNg2htxPEaK1hwLDOW2VT7xG7kNIRjv26CyrnVT8E7FWSRHeTC6ZBeM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qwu/fXvG; arc=fail smtp.client-ip=52.103.73.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLuVTD+nKSHHFk+9kmwOFvf+0G5TNtgUcu2CpGk04LQzGbrie7ajDe8jlCeth1Ng8MYPEz2UDZ+kCzI98XBRADO8Qhzio8usWkg9xjdejy3PnAVV8J9h9jnufnPogjGdKRJ2ezrG021vjhOpM/ZEhoZe3AHnhFxd3IXHTJkjx/LOtgTNJfGKqSYW3wf5R4v4nGL1GU78yhyNWwa88NVWrAAb0SLBvvxDbq43dznmZ3/cPlHIVzkx7pXkGAPsgOnNrfFtISWbmFOo67EjHQw6aDJ7/YnxQ94zDxQzS4P0DVGLNoPkfVfHivjt4VFWJAJGb2qkrcg50GZu9YiyCXxvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbSsgWjar5KhMn9qXB/jnsrEWpwI5yFlKt2Gw8vC5jI=;
 b=UhaByb+YjZG6ttzQvTy690v0KCBxA11Nq3sxnWAAEixkoxm+TF/PoVbYD3GrD7rZviyB8z1HKVrv0MlBfTqOoeNj7xYhYO9AVkkXGys+gDsSTWB2dSBk4qAW5AchWeOCdd7CasIQHWWHtRzObjKhcMfvOVuwhkyzxDANhkvCb9Gpfw/QbUBdpIeg01a/ELCopI7gYLHMzTHQ+yRtg7IrCyKATbgj/udkA/pKUIpmqciZgoZ1LKHNI8bMU2XbG14qYidQB9l7Yz4T1EckRrGd+uURJZ/gvCBDvYI1HcZF6ngEM6d/KvHEwiP0tB1vENQ2EFBW8eKe37jDd/LFFDoe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbSsgWjar5KhMn9qXB/jnsrEWpwI5yFlKt2Gw8vC5jI=;
 b=Qwu/fXvGyZWjxM+AWU0WE1NkgXGnl9DJtAUce/Q5YrWZf2w8K4HZD9cOyiAaQzjZ/G6sTm0Ciy9O/uD3OGjJ1r7G5UvX5atoDpvJsi2ko5ivyZF6l1aqrjham5l6dbWPwy+s1NDrlKit9k39fb2SyNeZ/Mj598N2Or9HIiqjwM7TsA4bkxas8pngE5jRCp84Q6UIzL03ZaJYC/sI4e+By7Rl3CCV9eBioCg8TQ7Vx5mWC0uPqxM0CDuxIS1LlwY39tXdkvfcnA9neSmAiTtUe+ncK7auihhZqSY3I91iqmtTEY3Mm21KG6NN3Ex+wRuSUETID1vazvGFhpYSWpwPTg==
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::18)
 by SY3PPF4A3113B3A.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::492) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sat, 15 Nov
 2025 13:28:04 +0000
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::141a:53ec:2e47:a156]) by SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::141a:53ec:2e47:a156%4]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 13:28:04 +0000
Message-ID:
 <SY0P300MB0769CA2A15FBD6EAB0F7F7FCC6CBA@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
Date: Sat, 15 Nov 2025 21:27:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add one more ID 0x13d3:0x3612 for
 Realtek 8852CE
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250927-ble-13d3-3612-v1-1-c62bbb0bc77c@outlook.com>
 <7926abe4-f824-4ff3-808e-e31b7869a7d6@molgen.mpg.de>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <7926abe4-f824-4ff3-808e-e31b7869a7d6@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::18)
X-Microsoft-Original-Message-ID:
 <5f9bad62-3726-49b2-bf01-b4d03fcc664f@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0769:EE_|SY3PPF4A3113B3A:EE_
X-MS-Office365-Filtering-Correlation-Id: f2494ac7-e6b3-42ec-d7d9-08de244ace5f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|23021999003|15080799012|51005399006|461199028|5072599009|6090799003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTI0WGk2ak5HZDVaMXJIY2dRSlV0OWNHWU1sNnZ2S2hqTVBZY0w2TEpXRlJy?=
 =?utf-8?B?KzhZS1VSR0RYQmE1U3FvM1NOZ2ljbDJoRGVnTmJmaGRwSDFXRjNsWXcyaWtF?=
 =?utf-8?B?V0ZudFNXQWRQNnQvT29yYW05aXBIUmM2bDdOeHQ2R2Y4VHBXU2dPTDluUjI2?=
 =?utf-8?B?b1dtYWlLazUwL1R3YzVMenRBb0kxdFczWjdYVjNIcUVDUU9QMktyRlZZanU4?=
 =?utf-8?B?eE1HeVF5NXdDSVdrLys5MmhMTE4zemdzQkZFQXU3ZnNYZWwxSG9NWXIwODhQ?=
 =?utf-8?B?d0FKNWVKdWI5WUQ0WVdmeTdyMk15cGVJYXNlZjcwTkJaczlDbE5EQUtwTTE2?=
 =?utf-8?B?ZDZoUUhDaXU4YXF6UnhuVW9aUFUxR21qa3NlUVpzWmVXUERNWE9oOVJXbW5v?=
 =?utf-8?B?QjZYV0FuZDdCNWk1elprd080N1g1QlkxaW45bHlVNlJkeGhFY01haHNXWEFK?=
 =?utf-8?B?OHdjY1NsNGI2bXZNc0t6U1czU2FIODRXN2xLQ1IwTms2b21OUlJ4OUNhVXFp?=
 =?utf-8?B?NHJEMmcyditZSDdKV0tETTh4V01paEplTm1EWXM5OGNPcGN2Q0JMSE9ZWklV?=
 =?utf-8?B?Yk5zWVVOVWpERk5LcHFqbWdNTFAyNnA3S2JXcVplN2xMYXdBV0NXVEdjV1cr?=
 =?utf-8?B?blB6UjJTZS9WSjRHM205eFlqNUY3ZlNxYVNZL1l3d2w0U2FKb1U0dlpQNWpU?=
 =?utf-8?B?T3NqQXROMDBTU01CVEJHUXFZbk14OWdSS1Z3Rk9nbVhrTTV5UmNqYUhuSWl5?=
 =?utf-8?B?bWovdnF0cG9zM3VuMHN1WDk3TUZLdTQxRURHTk9SUmE0RXBleW5kU2M2bDEw?=
 =?utf-8?B?ZXBpdlNPeitBcVFZUkhhRnB0S0NidjRMS2Q3UG9PZCtKODIwenFtOGFxTzN1?=
 =?utf-8?B?dWNOQWgzTVRBV0VKNW1QUzZDSXNDaytZWmcvazhlSFZnR3RwZks3bTJweTAr?=
 =?utf-8?B?dTJXbHFnZHhwKzV0N1MyS29FYi83MGp6V2toWmZIdFpoZE5EeEMwRGVra3hp?=
 =?utf-8?B?dWliY0gyRElhY29UeGoySzBBVGJRcFB3TUFiVEJycmtsaUdzN2k4aEQ2T2Vy?=
 =?utf-8?B?d0xOeEVxYWJFdE53L2dLb3hNWEthekRYdHlpMnY4NUNsVjMxcWw3MXJ0dmhR?=
 =?utf-8?B?VTZtYjB2eThQYnkwdzRRMjlIN2xwUHU4RXQwQUtUQUZQTnhrZ2dpd3c3MFFy?=
 =?utf-8?B?cGovaThSYjBCZzJSU0hWM1g3QWRYUU1rUnNKOXp4QSt0VGdKUCtvSEV3a041?=
 =?utf-8?B?WGZEUnFrOFpsOEpvUnFpemZhcndVcCtVa0MwbTA1clhwb1ZmY3pTWkt3bHla?=
 =?utf-8?B?K1pqSzQzYUgvaERhSlFkZmZtOEZOQTVDQk42N2JDZHF6aGZKNklYVEhYdXh2?=
 =?utf-8?B?L2NiZ2NnMGFxUzRGR3pDQVpUOXdHTExEK2xIZmJoRGdhbHFPSEJBNUFiaUFh?=
 =?utf-8?B?aFJIMmFpcUFTblBvYTkzd21MMUQxNkxYNWRNMDh3eldOa2VXd3R6RVV0TnpQ?=
 =?utf-8?B?a1d6U0Z5ZTQ4RTRQNzBLV282a1M0Y1ZsVDFxVzFQMWM5NWQ1d0hjYzJLbmxF?=
 =?utf-8?B?NVZrYkpKWWZCem1zdVo4VFI0d0p4ME4vZG5aTnAwZWd3T0RyOWFWRmgxalV3?=
 =?utf-8?B?cnRERVVzNlcwLzBBTFBaQmtyOVByakE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjJyVUZSQTBVNU9mT092REU3MXNFY2IycnpIc3dvWk55N2tqZFVnUDJ4bFNI?=
 =?utf-8?B?Yy8rdGl1eEIwVVBIRkh4TjFrZHA4dUlIUGtWN09zdVI1RkxUcmtGVmQwWDBh?=
 =?utf-8?B?aXI5dyt1cHlMMGlZSjBocitMVjZvS2JxK3ZNalQzRkt4QU12aVp5UnJEMUpX?=
 =?utf-8?B?TGxmQzgzZ3RCUHB6U3IrT0pMa3gyZDZjQlkvOFN1b3ArbHdGYzRTaG8xRlhu?=
 =?utf-8?B?YmNiMFl1YWp5TmZZWkN4ZlJocGYybDJMSTNMdEdsM3VpKzhsREFzSFQ1SGh1?=
 =?utf-8?B?dmd3dld5QXBSbWdBZzh2TUNTSWpHT0ZLUjRacWxCOWVLR1lKK1NtdUx6eFU3?=
 =?utf-8?B?L0FveDI5aXNmbDFYdnh6aXovUHF3Yzc1WjI0QzBndG5TczBYdWdGS3FlL2VE?=
 =?utf-8?B?YmdYVlJFRGhGVXdoRTAvbmNvNjdFL1Y3a3dIdVhoQVlQYWtjTjFZZ2hTakFv?=
 =?utf-8?B?NGNPenA4QU53MkhVS0VNU095RGc4Yk1MSy9idmk0N0JGUWtmWmRTWGJzdk1t?=
 =?utf-8?B?OUhLNVFUT0hrc3B3U2Vqc3JuV1ozMnNTL0dMRllvWXFaMjBJOSsxZU9pRFhR?=
 =?utf-8?B?ZXM1TXZ5TDhJcHNjdU5xUmwzckYrTjJPdVVsNVY0M1JQUlM2UTJvVTkxVnhD?=
 =?utf-8?B?bC92a1B1YkR1aVJTQkZ3cVY1NEwxd3I0WWlndEYyUFIrY25TQy9tUHNyUVJI?=
 =?utf-8?B?ancxTzdGQmJNSmRYeGthbTdpaDRjL1dCaGErbXU0b0EyOW40czBldmZudHVt?=
 =?utf-8?B?cDkrUVROamF4TkxScDY1bjJqamZmbVJQUFZFM3BraVordEFIOUhlZ2ZSaXYw?=
 =?utf-8?B?L1hHbzY0ODgzTlVRRWozZWhZSVVma01VNG1VaHczOVZRUlg0dEZNdkxMQ01j?=
 =?utf-8?B?ZTVKb0R0MWs1TzE3Ty9LQzgyZEZCYkFQdXdlME9aMGJjZ2haSm5pOU43ZkFD?=
 =?utf-8?B?eWVic1UxaVorU1MzanhVa3FYUE9zMUdBTTYwYy9GMUlJK2o2QjNyTU9LZHZF?=
 =?utf-8?B?R0NCcFpmaWgxK0tuZVI5WE1BbXBXQ1FOREw5WjZXenluM3NhMVNmOTR0MHdt?=
 =?utf-8?B?SHhjZGZvWXFwb0JORnRYUVdoSEdUNEd0REdHMHJZcm5ZUEdod2xRTndyaGlo?=
 =?utf-8?B?ei9nNVRYcnBaNi9Ja2tMWTVwaDBDVi94NkV3NTJBdkdOa0NSQ21PZ0R1UU1U?=
 =?utf-8?B?ZXhXZkUxYk9LbWJJREtNZHN1SUx4RWJ6NXlzMDAxTkU0bXNZWjFWbVJnZnFX?=
 =?utf-8?B?dFBLWWNmbkNIVGxpQkpJZVc0Q3NVcWU1cUpBek4wd1YwSTBKSFV2N080N1Mx?=
 =?utf-8?B?U3ZRc0lYMGtObmdJcjRoNVlOaUFoY2RpNVQ3dlgyL3d3bE1NMHJtZ1pxZHcz?=
 =?utf-8?B?eGt0bVlGalYyYVJLOUZGcmxiWEV1bHd2cVJTR1VXWmVQaFo1cDcxTXg3ZDR5?=
 =?utf-8?B?bm9Oc1BhUzdaeFVqU2d1RWc3L1VpUWxyMHBlcmVKRENndU1MYTg0bS9mOFZY?=
 =?utf-8?B?blczNTY5V09sOTZqK2ZDQy9Yb3QzWmRUeGtVOTdaTXNxZzNpZ3h0TEZjV2Vm?=
 =?utf-8?B?RGhzQ21TMHA3bjY5WHdYWkNEV3JWVkR3RHVHUUNyaHhzWVFNOEpUa211RVo4?=
 =?utf-8?B?Yy9qT0NNMHJPMW1ER2VNMzNDTnhSTjdOZE5hVjRFTUZLMytMMWl1Yy9URDFn?=
 =?utf-8?Q?9GwBlIqbFES0XmaRk8gk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2494ac7-e6b3-42ec-d7d9-08de244ace5f
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 13:28:04.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF4A3113B3A

Hi Paul,

On 9/27/25 10:25 PM, Paul Menzel wrote:
> Dear Levi,
>
>
> Thank you for your patch. For the summary/title “one more” is not 
> necessary.
>
>
> Am 27.09.25 um 04:29 schrieb Levi Zim via B4 Relay:
>> From: Levi Zim <rsworktech@outlook.com>
>>
>> Devices with ID 13d3:3612 are found in ASUS TUF Gaming A16 (2025)
>> and ASUS TX Gaming FA608FM.
>>
>> The corresponding device info from /sys/kernel/debug/usb/devices is
>>
>> T:  Bus=03 Lev=02 Prnt=03 Port=02 Cnt=02 Dev#=  6 Spd=12   MxCh= 0
>> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=13d3 ProdID=3612 Rev= 0.00
>> S:  Manufacturer=Realtek
>> S:  Product=Bluetooth Radio
>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
>>
>> Signed-off-by: Levi Zim <rsworktech@outlook.com>
>> ---
>>   drivers/bluetooth/btusb.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 
>> 8085fabadde8ff01171783b59226589757bbbbbc..d1e62b3158166a33153a6dfaade03fd3fb7d8231 
>> 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -552,6 +552,8 @@ static const struct usb_device_id quirks_table[] = {
>>                                BTUSB_WIDEBAND_SPEECH },
>>       { USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
>>                                BTUSB_WIDEBAND_SPEECH },
>> +    { USB_DEVICE(0x13d3, 0x3612), .driver_info = BTUSB_REALTEK |
>> +                             BTUSB_WIDEBAND_SPEECH },
>>       { USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
>>                                BTUSB_WIDEBAND_SPEECH },
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
It's been a while since your review.

Do I need more R-B/Acked-By from another maintainer or is there any 
other thing blocking this patch?
>
> Kind regards,
>
> Paul 

Kind regards,

Levi

