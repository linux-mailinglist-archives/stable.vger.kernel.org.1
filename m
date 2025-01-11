Return-Path: <stable+bounces-108258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E848A0A2CB
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 11:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07290188C1D3
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6F19046E;
	Sat, 11 Jan 2025 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pSR1+Koj"
X-Original-To: stable@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2059.outbound.protection.outlook.com [40.92.63.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0B81E;
	Sat, 11 Jan 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736591512; cv=fail; b=fYeOizih9C/TSPFGFBjdBRmwceIN/+WoZeKajyFY9U6X6FD1phD05ntcQ/7I3I+Rd83zdR/Bp9tFjzXVdEUFQMJbl2hukEi1vA7+VKphCnEX/BPZrRR/xUXfBeg5q0fcbZnClgLGFaxxvoCrYO50/QP8nciRNlrsenVSdAH48M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736591512; c=relaxed/simple;
	bh=W8FumOv/ccMv5QAc1d3o1I73JayftILNiRZtL0g4E8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LIZk8eXE831mQbioBxNvzPmhmc6xcECIxxLdeTMvhRGlNRS34eclAYN5YgyGmJSdEYsWdf8lAuVw43wxZLP1+e/cBeNBQQUxnurN55Nu6ZZeLnWOFqobTOL1JczLiQNE83kdR0PwiK3cnQUaVVA6DqY41TrIWQUEfDAF7AI+KPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pSR1+Koj; arc=fail smtp.client-ip=40.92.63.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2DgtpattSzeiVWq88QLQcvYv3ahaRO1AnEWICJoTbh5xI1XbMYMv1HnTAp3XtNg6Moxxb7Q2M3l37hql2sYOkOkIvoTGHKEgH6eP9BTatYzmxxFXld4+0eRK3MzWEQcuvRmz9rcQeGVHXea61RV/QiXkuOGzRKm6wUNwt3yNP7IhD8FGtAJKj2j6BDJKcgXnb5/POxOQUvnzySnB2THCnrVCTWc4Z0LarJmnc081qMG91Z+yI6g8HXBJsabxyk8N2eIBeJ+4BXHCioRmOW6ZAzjKqwH7O6jAF6VPX8J01WKwwGuYZvpU3GhWB3ofVLxuVe+Blu40o0xaAsF9o6UaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSj9JWlain2p9cLCU0EKjlXrLhjuPkPM4kFoi95wFjs=;
 b=f305yIeUr69UG3w3yYK8c76KigdsE8kmXavfG7g7SxgtLXvUfgtManbVE2Io81db/5oIjBUoFmiwog/9otvn6eKyTlhuwe+RXyQOxq38VEHYsUtXiCfSrsKEUvhaUTMDkSKzpfDt7Zl8I/dllwqi2sj8DU92R7F+xGn/yNY3gDu5TS3JRQ5WWvnRa4nofSsrQYJmTkTmd5i3PAiS2mnjlmmgszNNuFF9jWkfvSHAJxXMWsYoffSsgcZL4nj67NtE+t5zvzLhDQbD0F0U5ITyvL4PYxZCEmf2t1vk2/IeNPpGyKXe5t1fG6XxcA5kQs4TjQe/Fw8RoHMVNj6Y7QYA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSj9JWlain2p9cLCU0EKjlXrLhjuPkPM4kFoi95wFjs=;
 b=pSR1+KojF2iwXfkzRYZKIpuHyR3j8+VttuylLusFjjeBUvtpcFf/H1ZDfNA9mIngCm+WMZPc7AT+uA5MW+ZdQb+dynoun0P992YCrJ78WMTlzRkFZw/K9s43FwjF7VVJLvmkWbAgx+2mHjJLCKXUDtgjzICYM9cKfltixZcetti5DdDNL9T+zb6L3BEApn08PnOmQRaLxg7iNXJ5qvgBSaCQdXGNKbdzlqoWRdBRKGtZoX6WtODTk7l1pZ2SSUylQBU+CS0z5RHcKaT6Sr9eYcAoVnVpPg8XOpO7LsXjAxcmdetu2aljSqUIwLKzYQLqlJ14+oAA8HzvagfPp+yRzA==
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::15)
 by ME0P300MB0713.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:229::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.15; Sat, 11 Jan
 2025 10:31:41 +0000
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3]) by ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3%4]) with mapi id 15.20.8335.014; Sat, 11 Jan 2025
 10:31:41 +0000
Message-ID:
 <ME0P300MB0553900AF75E50947B011FF3A61D2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Date: Sat, 11 Jan 2025 18:31:36 +0800
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
Content-Language: en-US
From: Junzhong Pan <panjunzhong@outlook.com>
In-Reply-To: <CANP3RGc_SBROWVA2GMaN41mzCU28wGtQzT5qmSKcYsYDY03G5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::15)
X-Microsoft-Original-Message-ID:
 <4ab59c04-a6ce-426b-83ab-98337fd56f00@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0553:EE_|ME0P300MB0713:EE_
X-MS-Office365-Filtering-Correlation-Id: 39483df5-da2c-4cc7-5be5-08dd322b2342
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|15080799006|8060799006|7092599003|19110799003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NExkOXU5ajdiWXFidWFZdmh1VGxHUFdFcnB1blBLYkRZN2pPdjRNbE9NQ1Ny?=
 =?utf-8?B?YWxPR3dHUWRVVURBRFh5UUhjK1JzR1ZlVlhMd2QxNFJQbGZteHMrZytqZng1?=
 =?utf-8?B?bDQ5LytvUVNyS21XQlEwL0NPYmxCMEdEeTc0R3VsWFhueUpjYkR4SHV4WlIr?=
 =?utf-8?B?R1dHVVNHeEY3UnpHZlNCRTNNRmVHZEtMdUYvQjVGZ1Vjamt0VEJaWjEzRzhi?=
 =?utf-8?B?elN3bENjODgzYTd4bWk2dWZTV1dwVlR0cGY2SHg0ZlBPcmlDaVl2NXFBT2to?=
 =?utf-8?B?RHFpeUl6TEJrNkkxUHl2NnBMZnp3aEgzMy8zZXNNOWhXZG83OUcyODhGTCtx?=
 =?utf-8?B?T3VRUmpsTkU3WnlEL1pZYjBZMVowTkl6cmtIMEd4YkN4SHBrTVB1OVFvVVVL?=
 =?utf-8?B?ZmRVQ3hFTFBoSmRYWE1uZmxqM1lOQkI4U2FWV1lxL2YxQTNCRjF0WjlraWFG?=
 =?utf-8?B?TnpPUWVtc1NjV21idzAwMUNxei95dTduT3BXcU85cngrVS96NlRsS003NnJX?=
 =?utf-8?B?a2YvYkJzMXNrRDRrMTM0akxCa0ZWdUd0QUxHVm5CTHVVMFRKY0E0blNNVHVH?=
 =?utf-8?B?NFVHYld4WlBKZTJHVnJPZW00dTczUUVCcStEUEN1UnZ6NEFkdGZzQk5zUlR4?=
 =?utf-8?B?TkhtN0ZRWkFnWWFYNmRmaGZpM252bFRQQm15Z0JPWlgrMjJhaStJUTBVQ3RQ?=
 =?utf-8?B?L041SUpvTHJtTytoOVRSZHVDM28zVjRDR1p3N3dCWjFPNHhqYml6ZGZhdGZP?=
 =?utf-8?B?NmpEdVFaWm9NM212WEMwckQwQk1PMDJIOC9vWndFd2wyV2MySXNJd1ZtVUMw?=
 =?utf-8?B?cENZSG5zcnhidVFBZjVOL284MHgwM3Y4YTRPbi81RTVZYnFkaWFmQkczZUtq?=
 =?utf-8?B?TzNtQWNvTnZCUm90NHpDVUYwRXFWTlAxUXVjTitZM1JuRENJc0MzempmQW55?=
 =?utf-8?B?ZDhnTVZBamQrQ29odkl4QkVBZk1qcEdaQzU1QlM1eXo1TlZuY2JraFE2OEdz?=
 =?utf-8?B?U3JpNFlXSDhONnU0V0lRT0IzWGRBVUVaOU5YbHB4WXl6VXZRTlFSeFF3Tkta?=
 =?utf-8?B?VEJlcEpENVZBSVVoUkp6RjM0NFNHWXhlUXBDdi95MFkrTVpXNWZtRkRZTnc5?=
 =?utf-8?B?VXNDSHRuMS9aVHM5Mlk1SVMvQlJBc3VlRG9XSCtUYVN0VyszcUhyNkhqNWoz?=
 =?utf-8?B?SzJiY2Y0NW43N3Rzc0E2Z3hOejRyVHBQV2pJbnBDUUU2TVpNWGRRbTRZa1RF?=
 =?utf-8?B?OEpLNkNvTC9sdnphVW5rT1NRZ1pyYzVYSmd2YkRIMkhWQVVLVFdONlBDRHkv?=
 =?utf-8?B?alVMVWplRVdBNDB6SGo2QkVhTzhVMlljWVAxaUx0OFh3UUtaOTZFSEw4UU5B?=
 =?utf-8?B?RkhIYWdZNzM3ZGRaVlMvYll6ODE1NExzSDRnS3hCZis5eHEyZXNZSDRIdVRF?=
 =?utf-8?B?WFlscVh6dHZHc09XdWV3MDh4QzIveDlrdExsUU9qTzN1MHZaVjc1cWQwbFE0?=
 =?utf-8?Q?P0reAo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUV2NEVnRnRRRkYyNEJ4YSt3MWUrZ1BGYTVnMlJQQytQYThpb1pxbzZoRTFP?=
 =?utf-8?B?NSszNTRrZGMxNUFsajkybGx0WmpoNjk2dFkrSmpaU3c4TXhJL041RUlXWVBR?=
 =?utf-8?B?Vm84UElzQkdqRXljYmVMTkx1K1o1dVluNE9jS2RHK0R6ZGE1WFlRbFBLU1d2?=
 =?utf-8?B?OURRQkpzZDV2bUF3KytybUlDMEExa1RHbTNEUXdDYmV1VE94TmNkeFRGcjB0?=
 =?utf-8?B?ZktqRUpZQ3drTDd4c1o5NS9QV2hneGt5REEzQzRRWkF5R3NDM3BPSndHK1pH?=
 =?utf-8?B?a1FsZlJxOFdKSDBJWDVJSnF6dUpnQitKY0NiMHNpNFE2TkQxNm1HcHRmYUli?=
 =?utf-8?B?bEVuaUZtRk9Lc3BFQnRyWHJJK3RCNFlGVVVmdmxZcXZMVG5TM2RISXR1S253?=
 =?utf-8?B?S0paN0FtQWlQNC8rZGxLR3ZEYy9BVXBNMFJ0dzBvU2RmWWpzNVJyUm43UFIy?=
 =?utf-8?B?SkppY3d5YzU2QXloNFNtRCtFaC9PaXZYUjZKRi9TZmdUMnhIUU9iaWZKZzcx?=
 =?utf-8?B?bXFyTE9ZNnNleXgwQUNGNnpENkk2RlRlWVkybENzbUxkYk9TdnhQR2liV2hE?=
 =?utf-8?B?ZWN0d3NzU0tMUUlUMUpGNnR3NG5TMmIraks4T1Y5MTFQSmtwODFUMUlpRnZR?=
 =?utf-8?B?bFR5c0dIQkJ1cTNUNjdnWmpVbkhOTXM5N3ZwbWp1MlhIcGd2ajlPazErZ0Fz?=
 =?utf-8?B?WDJ1b0tZUlpoT2pDMmhvSHE3MVMyZ2xsK0tMQXF3UTl6VDRad2o3RXZKZENC?=
 =?utf-8?B?bTlEOUhuQnk0cUs2V0RacG5CVTV4MjRTZXJrcDBIdHlRM1BLalJqNHdhcU5L?=
 =?utf-8?B?aWVPbWhjdEtqSmRJdGtjcjd3cTk3Zk5VNDd5WVB1dmQycVh0NnpxK0FqRkwr?=
 =?utf-8?B?cFlkSFZGZHVIYkEwZmxSNGxoZEN3R09xd1hKdHF1c2F3OUVObFR1ZkdMclA4?=
 =?utf-8?B?dEFGOERJcFRlOEF3VEdoR0ZCZ2g3K3JySTcrdXhXWEdvbllhOVkwRndueWlW?=
 =?utf-8?B?ckxFdGd6azREZ3luR0dYeTcreXRqQjcxVXFqRC9pc1lxN3k5Wk1EMkpsRjlP?=
 =?utf-8?B?M0VhTnlDV0JvUk1ndGVsbGQxK2ZtcFZYVWp3QjhlSllQTm9SOVEwN0F0dWlh?=
 =?utf-8?B?VUl5bWhuay9qb0hwVXFHenNwRitBMDdUcFFSVHdXbWIwK0pMbjZYREJsbE5H?=
 =?utf-8?B?TlFsWSsrb0o1clU3SkJHNzdDcEFQd2VDdTA4QjBJWEttYzVxVXJUWTB5NERt?=
 =?utf-8?B?WFlXZFk4WVUyWGpuOEhLM3ZLdFh0YkQ2ci9DdXZZSjZQM1lVNWVvRVE1cmpF?=
 =?utf-8?B?aGRHK24rSzg0U0NnUHJaWkttY0EyUEdabDRLMm15V3dIRktUUzBYMXBZeGk1?=
 =?utf-8?B?OFhQYU84OW9BMHo0cmt5RnRwTkNDS1VYNk1DU1FSektlUHduUWxndGx6ZTND?=
 =?utf-8?B?am84NlNHcTZBNW14S1JsNHpwaFdFZmlNZHMvQ0szZWg5MURGZEl5djViNFBS?=
 =?utf-8?B?aVBCZ0hOL1lHV3lVYm1GZ1hvNXA1bmI2eW83MzI3bjRIMkFDVGhnYlNQOStp?=
 =?utf-8?B?c1dtTWZkQ2JrOTMrSWkrNGM0YU9yTEt2NEtDaTczNHAzd2RZMTFHRi9lRTdC?=
 =?utf-8?B?MDJSYVJYa2dWd3hVbms1UnQxMFduelk0OURuVis3d0tyU2tEcndQU1lKWEhR?=
 =?utf-8?B?Wm8yN202UkxCTDVONVkvYWFhUldaYVB3R0FLUHVVNnJMb1NCQkp3OWVDZE5P?=
 =?utf-8?Q?t+rhK0gCu+79CnaR3oG2+D2CbjlcAWMzg+1gv4L?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39483df5-da2c-4cc7-5be5-08dd322b2342
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 10:31:41.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0713

Hi Maciej

Thanks for the reply, I am sorry for the unclear description.

+remove hgajjar@de.adit-jv.com from CC list due to mail delivery failure.

On 2025/1/11 3:00, Maciej Żenczykowski wrote:
> On Thu, Jan 9, 2025 at 11:37 PM Junzhong Pan <panjunzhong@outlook.com> wrote:
>> Lecroy shows the wSequence=5765 have 10 Datagram consisting a 31*512
>> bytes=15872 bytes OUT Transfer but have no ZLP:
>>
>> OUT Transfer wSequence=5765
>>         NTH32 Datagrams: 1514B * 8 + 580B NDP32
>>         Transfer length: 512B * 31
>>         NO ZLP
>> OUT Transfer wSequence=5766
>>         NTH32 Datagrams: 1514B * 8 NDP32
>>         Transfer length: 512B * 29  + 432
>>
>> This lead to a result that the first givebacked 16K skb correponding to
>> a usb_request contains two NTH but not complete:
>>
>> USB Request 1 SKB 16384B
>>         (NTH32) (Datagrams) (NDP32) | (NTH32) (Datagrams piece of wSequence=5766)
>> USB Request 2 SKB 14768B
>>         (Datagrams piece of wSequence=5766) (NDP32)
>>
>>  From the context, it seems the first report of Wrong NDP SIGN is caused
>> by out-of-bound accessing, the second report of Wrong NTH SIGN is caused
>> by a wrong beginning of NTB parsing.
> 
> Could you clarify which Linux Kernel you're testing against?

I am using linux 6.6.63, but the related codes have not newer updates since.

> Could you provide some pcap of the actual usb frames?
> Or perhaps describe better the problem, because I'm not quite
> following from your email.
> (I'm not sure if the problem is what windows is sending, or how Linux
> is parsing it)

I think the root cause of the problem is because Windows 10 ncm class
driver doesn't send ZLP, meanwhile the current parsing is depend on a condition
that NTB won't spread across usb_request. 

This is observed only on Windows 10 but not on Windows 11.

To reproduce the issue, you just need a Windows 10 machine and run iperf3 -c
from the windows and iperf3 -s on the gadget board, configure the gadget
with the following os_desc, windows10 will bind its ncm driver automatically:
        echo 0xEF >  $GADGET/bDeviceClass
        echo 0x02 > $GADGET/bDeviceSubClass
        echo 0x01 > $GADGET/bDeviceProtocol
        echo 1 > $GADGET/os_desc/use
        echo 0x1 > $GADGET/os_desc/b_vendor_code
        echo "MSFT100" > $GADGET/os_desc/qw_sign
        mkdir -p $FUNCTIONS/ncm.0/os_desc/interface.ncm
        echo WINNCM > $FUNCTIONS/ncm.0/os_desc/interface.ncm/compatible_id

Reproduced on dwc2 and dwc3 controller with linux 6.6.63.

> I *think* what you're saying is that wSequence=5765 & 5766 are being
> treated as a single ncm message due to their being a multiple of 512
> in the former, not followed by a ZLP?  I thought that was precisely
> when microsoft ncm added an extra zero byte...
> 
> What's at the end of 5755?  Padding? No padding?
> Is there an NTH32 header in 5766?  Should there be?
> 

Okay, I will explain it more precisely (some numbers are corrected).
On the USB wire, the transfers on OUT endpoint is like this:

OUT Transfer #1 issued by win10, Transfer length: 512B * 31 = 15872 Bytes
	OUT Transaction 512B for 31 times, no ZLP and other things. Parsed as below:
	[Offset 0x0000] A NTH32 Header with wSequence=5765, dwNdpIndex=0x3D90
	[Offset 0x0012] Datagram blocks
	[Offset 0x3D90] A NDP32 describing 11 Datagram blocks plus one zero length item and padding, len = 112 Bytes.
			(0)index=0x0012 length=1514
			(1)index=0x05FE length=1514
			(2)index=0x0BEA length=1514
			(3)index=0x11D6 length=1514
			(4)index=0x17C2 length=1514
			(5)index=0x1DAE length=1514
			(6)index=0x239A length=1514
			(7)index=0x2986 length=1514
        		(8)index=...... length=1514
			(9)index=...... length=1514
			(10)index=..... length=580
			(11)index=0x0 length=0
			...padding...

OUT Transfer #2 issued by win10, Transfer length: 512B * 29  + 432 = 15280 Bytes
	OUT Transaction 512B for 29 times, and OUT Transaction 432B for one time.
	[Offset 0x0000] A NTH32 with wSequence=5766, dwNdpIndex=0x3B48
	[Offset 0x0012] Datagram block
	[Offset 0x3B48] A NDP32 describing Datagram blocks

In the u_ether driver, we first queued a usb_request(buf=skb.data, length=16384)
to the udc driver, the udc should give it back when it receive a 16384B data or 
encounter ZLP/Short packet. 

Since the OUT Xfer #1 doesn't have ZLP or SP, the udc won't giveback the usb_request
with req->actual = 15872, instead, it gather some piece of the data from OUT Transfer #2
to make a req->actual=16384 then return to rx_complete.

For f_ncm, we now have a the first usb_request givebacked from udc driver having
skb->data organized as the following structure:

      usb_request #1
	-----------------------from OUT Transfer #1:-------------------
	[Offset 0x0000] A NTH32 Header with wSequence=5765, dwNdpIndex=0x3D90
	[Offset 0x0012] Datagram blocks
	[Offset 0x3D90] A NDP32 describing 10 Datagram blocks plus one zero length item and padding, len = 112 Bytes.
			(0)index=0x0012 length=1514
			(1)index=0x05FE length=1514
			(2)index=0x0BEA length=1514
			(3)index=0x11D6 length=1514
			(4)index=0x17C2 length=1514
			(5)index=0x1DAE length=1514
			(6)index=0x239A length=1514
			(7)index=0x2986 length=1514
        		(8)index=...... length=1514
			(9)index=...... length=1514
			(10)index=..... length=580
			(11)index=0x0 length=0
			...padding...
	--------------------from OUT Transfer #2:-------------------
	[Offset 0x3E00/15872] A NTH32 Header with wSequence=5766, dwNdpIndex=0x3B48
	[Offset 0x3E00+???] Datagram block piece from next NDP (wSequence=5766)

During the unwrap, we will first report a "Wrong NTH SIGN" when we try to redirect to 
the NDP of wSequence=5765 parsing the second NTB in the usb_request, since theie is no
bound checking, we read some garbage data from skb->data + [0x3E00 + 0x3B48].

Raising the following message (without modification):
[  174] configfs-gadget.0: Wrong NDP SIGN

After this, we go to the next usb_request, at this time, we have a short package(432B) from
the OUT Transfer #2, thus the udc would giveback next usb_request to us like this:

      usb_request #2
	--------------------from OUT Transfer #2:-------------------
	[Offset 0x0000]  Datagram block piece from NTB of wSequence=5765
                         3f 98 a6 8e 17 f8 bb 29 07 b8 da 13 7f 20 80 8e 77 ca 32 07 ac 71 b8 8d 84 03 d7 1b 96 9b c4 fa
	[Offset 0x????] A NDP32 describing Datagram blocks

At this point, the unwrap function try to read a NTH sign but got unexpected user data,
then it raise this message:
[  174] configfs-gadget.0: Wrong NTH SIGN, skblen 14768
[  174] HEAD:00000000b1a72bfc: 3f 98 a6 8e 17 f8 bb 29 07 b8 da 13 7f 20 80 8e 77 ca 32 07 ac 71 b8 8d 84 03 d7 1b 96 9b c4 fa

In short, there is two NTBs across two usb_requests, the beginning of a usb_request is
not necessary a NTH sign.
Do this make sense to you?

Best Regards,
Pan

