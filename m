Return-Path: <stable+bounces-108437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40CFA0B830
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEA91661AA
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2611CAA66;
	Mon, 13 Jan 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fHx8MRMW"
X-Original-To: stable@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2039.outbound.protection.outlook.com [40.92.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426622CF36;
	Mon, 13 Jan 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775098; cv=fail; b=LI5Q2fsMUQIwrN71yIkV+/TdZkhSEgbjqEQi/5rr9eQa79KCIlcSyC6Wv9xVX5Bks8/NUngmd5qQwHBnejVuJyhuWZDVddMBI+sRsrl19ndEkOB64fn21qixvSEYfIPAK+kZ5oKf9RqdNYtycvN5oL5Z2tLV7xDJcV5iC+54n1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775098; c=relaxed/simple;
	bh=kwHfXW+HKMEPtPDiczoKXVCKPvqn5z99ZosMyW6d84s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TrQSzEQxWgw1ZZOeAvubWeSRld1Hrvw4XzVX4wASj2RXw9LeROjlxVJRwHozCjkwebVfq6AGekKAoWLABPuxTWLBTj1jp0JMt6Q0bx6Lp5PVNSqF6WIWRC0MuK+QB4tG1XquMFYiqvEijxEoX6gbKS3FL4ihZvWSO/bGaovjCWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fHx8MRMW; arc=fail smtp.client-ip=40.92.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ev5g32feHaioiCu3P0R5pswhcvNqpGYgxTXkLdq4qu8CadmmTfBn2qseQGWCkq0p5ZUp5lJ5aprCWIoY9PV/nfbZISCSLdhCuBWUVtHKDhWomVrgVytLGlq6XTYUaVN/8nQrNUvtRiZ5tMXdpIKQu04r/FXlldV4fiioT1YXIpQoq5N0GffWY141yq4lwYRtlN6Ids+5SXr3FriQ1WtvBK0aAxtQPkdsocCpSKoYmo47Gy1oOJ7zzMlGj82qVVByO9pPZTAIFY8FYIska4xPi2NbKgYxRENt9pBcgIL+SSTg6kw+xF+xGFYCTzWN2MZv7bj9fKJ/ZQdTu9X99Sp95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZtxLUcLhGFyIifoztrJvGcUweLv1X7EtPSMeaKF8WI=;
 b=ROGEvTzA5n7V1KgJ6zC5bdUxQgSHdMZJQrIDOO77Z16Tt/dd5EROIiiB72qCumqZ3WeEQG3KvJsZEaF13OZdtk2TRJKnuwv2kbJUmhFcj/N/ax5dI9ts41apT2wZC8cyXokUPwG137JMR4OW4tGJT15SDER6aDdZRTyegCwQ0h/ONrunwDrRrbJgvc67iQSnUlQjn3qODGxjqQMkzZ270tnlgx7Uh0ZYM0SxLlGjfOdbZb1jwRo30fZFTghIEXM9V3EmH+H+uVqGEFWouTA6f+IAc46Xx6HLHXF+c5gU9SVVuY7Wfzw19g7Ybzi7olBgpD1iC9VIFDg1AUaAGx7TJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZtxLUcLhGFyIifoztrJvGcUweLv1X7EtPSMeaKF8WI=;
 b=fHx8MRMWS5uc+rem/dsU3L3mVMvXzr6n494ZHwfjgT7h2K/S8foGy4VI3aUzwa2qciws1vMPmYbnXsYYIOklttPJcdBbq0GFLeYsI9ga0+0I8iHQrrJLC8QIpHYHl12mDfYc4mwKjv6q7w9HqGNF8vvb2+2aDMFMPEsInNQtN9VDukubrwOgW8hYdtR0IkIiklDfPcJ3V7u0YISFkqGvxCzhslq/B7fuwlV8XQztHBneRt2HygpH7RASeoOhjhRk3+R5sNvzVIRAybLfzhAielZD6AhBchxhjjtsl9D5EDADqQtnvJFYiBJ3LXucg6dDzMeOvNlrlfqXz7+YWVUB0w==
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::15)
 by SY0P300MB0514.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:31:32 +0000
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3]) by ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:31:32 +0000
Message-ID:
 <ME0P300MB05538EF3A86116EF73BE3BE9A61F2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Date: Mon, 13 Jan 2025 21:31:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: quic_kriskura@quicinc.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 quic_jackp@quicinc.com, quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
 stable@vger.kernel.org
References: <20240205074650.200304-1-quic_kriskura@quicinc.com>
 <ME0P300MB05534EDF5293054B53061567A61C2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
 <CANP3RGc_SBROWVA2GMaN41mzCU28wGtQzT5qmSKcYsYDY03G5g@mail.gmail.com>
 <ME0P300MB0553900AF75E50947B011FF3A61D2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
 <CANP3RGc7n2vv6vGh7j0Y=7DNqfXnQxZaTcwdPD15kzoY1in08Q@mail.gmail.com>
Content-Language: en-US
From: Junzhong Pan <panjunzhong@outlook.com>
In-Reply-To: <CANP3RGc7n2vv6vGh7j0Y=7DNqfXnQxZaTcwdPD15kzoY1in08Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::15)
X-Microsoft-Original-Message-ID:
 <f3e34217-981a-421e-b288-3bfaad4562b7@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0553:EE_|SY0P300MB0514:EE_
X-MS-Office365-Filtering-Correlation-Id: 879d4570-f441-4fa3-09b8-08dd33d697e9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|19110799003|461199028|15080799006|6090799003|8060799006|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVhtRG1qK3BDK240NXBrWFBNMTM5QVZJNXVMZmphY1ZTNG1KMTVCYkVZUmtV?=
 =?utf-8?B?L2s3UXN4SE55U0JlYUhBdlNFeFlOcy9NVEFIeDVLT1pZWVpUOTdWOERnVGFF?=
 =?utf-8?B?VHk1ZG44bDMxaENHenhPaFlHRDJQNVhIUExwRFBIOVN3eHAzeXgvRVFHM2Y2?=
 =?utf-8?B?VERSakgzOHF0MlZwaXhGbDYxMjdUVDBHK3RYcCtGaHNtYXRYd3lzOE04SHhT?=
 =?utf-8?B?ZEFEdGhlN0dPN1Y0b2NycXNVR0crVlJHeG1MMS85MnA2bndWb2hBNjUwbGNP?=
 =?utf-8?B?R3gxODBnRUVEV3c5ZHBNWG1PZTNtcEhvQWV0cUc0UG84MmNReWRveW1kbE5s?=
 =?utf-8?B?VjhxTkNraEk1ZU02WHduNHlRRy84VWtkRzNyb25hNkFySmFoWU5BVndDVnZu?=
 =?utf-8?B?OTA5bFZLMWplWm5jWGVJRjlCaFZ2cG9vZXFmM0hlRXNHbk1VaWxvQUVJK3JD?=
 =?utf-8?B?cWJON09oWEJHMUZUdU5pUkdKYVVjUkd6Z2ZVYWJOLy9qbXBDdmVZYU9BZWl3?=
 =?utf-8?B?cU9RL2ZLSzc1Wm5ZSk9zWkNLaGcxTjYvT09jWUFvb2VsQjdVdTUzb2tXV2cr?=
 =?utf-8?B?U1hQa2FsaDUwYVVYTXd3SS9DTzk1UnEzWnlUK21yYTF5SHVudUQybURNc2ZR?=
 =?utf-8?B?d3RvSjRjUkJyREIzZ2daM2YzbzdpMjVneWhtbTMzRnZvZDlzVTFGS0l1WUsy?=
 =?utf-8?B?Z2hnUVJOelJNaVRtdVlMMlMrdEE3MzB3OWpsQmFxK2EzTGw3SmtzWlNONDZw?=
 =?utf-8?B?UHNKeE9EMU1Qc1FXcXRlbFdnMkxpS3I5clZQZW8rOThGWU9SYzVKZy9mTGU2?=
 =?utf-8?B?Z3pLc2ZqWHQ1MFlCY2x4dHdCSG1lQ3B0UWE4TTl3U0FvMGRZQjNKU1RWbGNI?=
 =?utf-8?B?MlZ4VUc2bGRxb1hZMHpmZEpPWDg4ZVR4eEZ5bnpYck54YlZaV1RrSGVoRWxF?=
 =?utf-8?B?VE43WFQ2ZjNDMHU2dk9JcTNiU0lLT2M1Y3IzblJteEFOeXJEWjNGWWo5bTBs?=
 =?utf-8?B?QlNQdlJta3ZHc0R0VHZBVzFoYTQ0VkZEUmw0SDU0ZFVSQkMxdnZ0VXBzbWQz?=
 =?utf-8?B?SFVPRktoRlZhdW1DbXRqWTNIdUd4a3RlR0RhUk9wZHNySWJYKzlEbTRaWEkv?=
 =?utf-8?B?WUNjMnk5T0FZVUFpcnI0Z3hBSGNNR3hiM0ROdHYyYU5KS0g3RDNuL2hrVnRh?=
 =?utf-8?B?K1RqTU92c2pIWGZBTzRQTWZpbG5UV1BrR25pbnFHUUNHc3F6Umg4Wk9uVDZt?=
 =?utf-8?B?VHlldmIvTUVlZVJHK3FSMitNZHpZOWdmZ1praG1GQlU2UGZMaU9SNEZtb0My?=
 =?utf-8?B?MzdUbEMyOG85WHJTZFNLak43SjFHYkFKaVlIRlYwYWFnbGZkWDZYeUdmWUwx?=
 =?utf-8?B?MzFsUHoxRkpZWjBBakR0NDN5N2NpWUMvVHR6NG1ia2F2R1l6eXozNXZkY00r?=
 =?utf-8?B?eS9HZE5CaWVLYlEyRzVGOGJ3cVpyVWY2R2NCVGhIM2VCMk5wdERFTmpSYlJO?=
 =?utf-8?Q?MQKpYU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a01vZjFENEJnSTRRZUpYcExTUWdlYzA5S2Y4WGJFM0FjRFlBOTFUUUdZYjM4?=
 =?utf-8?B?RFk0TnlhQzRxMEpSL2xlTDJyKzVnNEJqRG9jL0dBMGxCdXpka3htR2lsM3lw?=
 =?utf-8?B?RjlMVlYwY2xYWWFXeUVXbW83Z1hsMTZ6VXBIV2twdk9FRktxbythRmRuS0E0?=
 =?utf-8?B?UStKME5MM0x3R1RjYTB3QWpiOHBkL2dvQm1iLzZSMGVBZmRoaUNUeGN1SG9D?=
 =?utf-8?B?bDFvL05aN285ZmpCV3dMemNWbFROUlZGcGxpN2txUUt3WmViTnFpTGRWVDFw?=
 =?utf-8?B?NHBicHowK0pNK2k0bVdZWkdEa0taUTM2RkxYTURRc2pKN2NZYkV6V3BlbVpp?=
 =?utf-8?B?VDJVVm5ZRzc3cytmRXAvM0ZiSHhFN1JTYk9Ea0hHTU5WRnJFdDdwcm9pV1ZF?=
 =?utf-8?B?R1R4UmdCdXVaWjkzWnB1TmNNOE1hMElxUFFKQ3B0NXBhcnY0OUlPejVrYTBo?=
 =?utf-8?B?WlZRY2RuTnJqZDdOdGVvYnhDVk9Pd1hnNEtOb1RnQ2MxRWY2cE95d29QT0lZ?=
 =?utf-8?B?SXRlSXJlSTVzRVFaVk1BZmttTFIvOU01S0ZsN1FvUUM2LzVXdFdwN1lnWXVi?=
 =?utf-8?B?a2VCRUZuVlUrd2RBSzZCUEhlTlVNY0d5Umd6ejdLZ2ZGYnUzU0RicDEwUUVS?=
 =?utf-8?B?RHBySlBBUEhsM05XR2d6aEJtZW11YTV2a0doSEhCRHEwbTlFZ1U3WDlLS1E1?=
 =?utf-8?B?eWloZ1AyVldjRXBnS1ZBaEQrYUNiSzZXeldXVVA1YzA0TWJWanR3Rk4ybTdz?=
 =?utf-8?B?aFBERkpSM043dnhnaUpoTUFPdGh0bTJIM0pSTzNEZ05mV2NGUnVwNmxMRWY2?=
 =?utf-8?B?S1lvcWlZd2NVQldkbFVIaGduaDZBcWphSVlvM0lOdHV5SjJDT0l6VkZIWHZp?=
 =?utf-8?B?WnNab1JqU2dNTzR0cGsvOUJnVXBwWG95N1J6RTNlWlN2Z2V4MDlWV2ExUVB4?=
 =?utf-8?B?YUdWcTlKRWc0WWhHRG5xOHluSzdMYkVaMFo5WEFFd2NzR0ZkeGduMUk4SWZG?=
 =?utf-8?B?b3JuclVEK3g1ckFQV2lVaU50SnlLQkdhbWo4R2hkbHVsamJETDEybTNNL1pz?=
 =?utf-8?B?ZkpTVjRBMTJLbjh1WUV1dkZQR0ZnYitUc3Y1dVhLUGlhYVBxQjRWTjhTOUp4?=
 =?utf-8?B?N1RZRW92dS9WRGtsbTFWbDNSU05FNHFPM2ZXV0N4SkM0ejBFT01hTmFwalZu?=
 =?utf-8?B?azg4VGQ5TFd6ak5kWWRrSlprUXR5U1NZYkNEbGhvRHBrbEhlanFxQWNJdTJu?=
 =?utf-8?B?d0RvcmdybWZvR2dCakYwcUtybHp6ZHpKNzhvNWJOUDI2NzZBT1B4aFFDYTBn?=
 =?utf-8?B?Z09TRGg1dlFNam1rWGw5SUdudDQyRWE4K3AyemlSV1RGRUxnOFVtQjBOZFRG?=
 =?utf-8?B?TVREMFpIMDdYandodFhLK0dsRzhFNEhwVlFCcGhhZG0xZ0xBV3pMS3FzOWJk?=
 =?utf-8?B?SXV4TVJpdGlQUmJaVGFqWnZ1eE8wWXNKbU5idFE0WWtRVkJEK3NBTUJ6YUxS?=
 =?utf-8?B?RHJFaWdsV1dZRnZyd0gzRmtZMzZGVmNzaG9rc013aEhvMUxCOGMzV2VRZUIw?=
 =?utf-8?B?NGtjWjlnUW9YL1dhN3JiajR2dGlHdFJic2ZWRVNoNDhPWDZ5VkMzYUdnc2ll?=
 =?utf-8?B?YUVsVDFaOGtORlVESUk5ZUpINlYrbjlvWWhScElobEU4UmpsbUxUV21TcWdm?=
 =?utf-8?B?cmo4eVpQRFpFNjd0cndIdk1uZzdyUHRUYitWZWhFUXBNbFk1RGxPeVRmamtK?=
 =?utf-8?Q?tD5oT3iQ/1DswS5Z6AbMnh4TOhufAr85YLHUQkG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879d4570-f441-4fa3-09b8-08dd33d697e9
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:31:32.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0514

Hi Maciej,

On 2025/1/13 1:49, Maciej Żenczykowski Wrote:> (a) I think this looks like a bug on the sending Win10 side, rather
> than a parsing bug in Linux,
> with there being no ZLP, and no short (<512) frame, there's simply no
> way for the receiver to split at the right spot.
> 
> Indeed, fixing this on the Linux/parsing side seems non-trivial...
> I guess we could try to treat the connection as simply a serial
> connection (ie. ignore frame boundaries), but then we might have
> issues with other senders...
> 
> I guess the most likely 'correct' hack/fix would be to hold on to the
> extra 'N*512' bytes (it doesn't even have to be 1, though likely the N
> is odd), if it starts with a NTH header...Make sence, it seems we only need to save the rest data beside
dwBlockLength for next unwrap if a hack is acceptable, otherwise I may
need to check if a custom host driver for Windows10 user feasible.

I didn't look carefully into the 1byte and padding stuff with Windows11
host yet, I will take a look then.

> (b) I notice the '512' not '1024', I think this implies a USB2
> connection instead of USB3
> -- could you try replicating this with a USB3 capable data cable (and
> USB3 ports), this should result in 1024 block size instead of 512.
> 
> I'm wondering if the win10 stack is avoiding generating N*1024, but
> then hitting N*512 with odd N...Yes, I am using USB2.0 connection to better capture the crime scene.

Normally the OUT transfer on USB3.0 SuperSpeed connection comes with a bunch
of 1024B Data Pakcet along with a Short Packet less than 1024B in the end from
the Lecroy trace.

It's also reproducible on USB3.0 SuperSpeed connection using dwc3 controller,
but it will cost more time and make it difficult to capture the online data
(limited tracer HW buffer), I can try using software tracing or custom logs
later:

[  5]  26.00-27.00  sec   183 MBytes  1.54 Gbits/sec
[  5]  27.00-28.00  sec   182 MBytes  1.53 Gbits/sec
[  206.123935] configfs.gadget.2: Wrong NDP SIGN
[  206.129785] configfs.gadget.2: Wrong NTH SIGN, skblen 12208
[  206.136802] HEAD:0000000004f66a88: 80 06 bc f9 c0 a8 24 66 c0 a8 24 65 f7 24 14 51 aa 1a 30 d5 01 f8 01 26 50 10 20 14 27 3d 00 00
[  5]  28.00-29.00  sec   128 MBytes  1.07 Gbits/sec
[  5]  29.00-30.00  sec   191 MBytes  1.61 Gbits/sec> 
> Presumably '512' would be '64' with USB1.0/1.1, but I guess finding a
> USB1.x port/host to test against is likely to be near impossible...
> 
> I'll try to see if I can find the source of the bug in the Win
> driver's sources (though based on it being Win10 only, may need to
> search history)
> It's great if you can analyze from the host driver.
I didn't know if the NCM driver open-sourced on github by M$ is the correspond
version. They said that only Win 11 officially support NCM in the issue on github
yet they do have a built-in driver in Win10 and 2004 tag there in the repo.



