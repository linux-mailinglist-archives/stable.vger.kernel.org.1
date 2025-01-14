Return-Path: <stable+bounces-108569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E6DA0FFB8
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 04:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EC07A124D
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 03:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D3B2309BE;
	Tue, 14 Jan 2025 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PoczwTrr"
X-Original-To: stable@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2098.outbound.protection.outlook.com [40.92.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DE849C;
	Tue, 14 Jan 2025 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826377; cv=fail; b=fX+9Cah+ppQFxQ0Q9r3a2yIYTRFuZFWXqZ4hPcDvRHAx5Zv+X2OFCP/IUHOSuyKJDtC8eCyTMW96AyTmY02ZgiLmRIGAhc1rnnHS4RsrbfvjAl9QXIFKZd3YsLGU0ieBaxy5LnNykSKmAJdHmnpvP9O1CaD45WAVbcR/5GvVdao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826377; c=relaxed/simple;
	bh=4cLz/aEqB6qYQiPIB62Kbl3R9iWjUVQap67b70S5uDw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fw1byhmnIyJlDjLRfAbRHY9rMrq/K/oA7qaxHeX3MW1Yo+j1daKHgKjX5RWwjOonbx3qFu8JwaDcSSxPwjdaFz/NmHxt02hLV7xIcguYPAdCvQATiCl4x2YqegtihRV4ZrRjzzg07OwE3CUM/QHXcWBpsKN3XBYNhQ1JtJpDfEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PoczwTrr; arc=fail smtp.client-ip=40.92.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5phY6Gr9zBnlDTxZoXGERZcqH888uBCUs2JJSFqyrWYjvHF4itboIGNaYNg+sefmlzEe56iHst+4OCmG7EojYEHxaOQXqvvW7FGCd3wOppJ7vLyHaWxL3+SDfMJ7dZ9rlWqRIAIKe7gJ7QpJw9K8aQk4B8v42o6UiAYCofoHVhGunKp+55e+anVw3wQzqooxo0+pEmU7xjYkC78K+jEQB9kHoK4i4+qIlQ0qHJzXCr5oc7Ecc8DZXqNcV81dBk59C3lLD1DYR0cIhUT3Bw8EAm6VXhK46l4vxmR8Bn+U1ThJaoXxjj9WKTiY9LKWknQCxUfKxGNB9cWXwM2E6tcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLTE0jSpDvkwvWG5Go1pbwlrf3F/WM/PFPLce39v7U4=;
 b=mOQfnTdmVhuF9/MJ3xmxZOmA7SRMvdQ7bI4KdJhO+YbrAIkFF6Q7T4eB7Jsie/PiUPb6UWgWBf2GYfN3R3Y85gB/KEANSBeexp8APB0tPCGXVC9aNzMR+XZCkwFaOffMoUaJvrhfcvajNg6vTYo0M/zux26A/ZoxCocIfvmor5P4bq6c6Gz1pwNDtLLRxkJohQEydD9ieDNvrAymy+t+aFcJV4T+t9JxAp7keClXPtiwi1mKVoTwc3GUYmjn6MxwW4F21x/dmza69S7GEquuiR78VdHoCx5PoZDX+fAMRQCZTZUNY54exx27Y1zJm1DrywDo8vFpxmx+l6BHimhhHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLTE0jSpDvkwvWG5Go1pbwlrf3F/WM/PFPLce39v7U4=;
 b=PoczwTrrfw0rf6lY1GbY6b1jjDfp3n0FYmpuZKl9+r0AFF/UkFPW7B7WJ8o2UVuIdBHWxROguDt2a2lu8OCxdL7EsGl19xRzzDc44xhqWsCHAgqSaXNdsj+AqRNG3VfveCKHU8Cim+lfv8WsSVnnMC6PCDqGWk/UFJYKEGUqrLXxkpV6r4r2IJifZE/ydPA7GhfxwK85W4zT/RDgb6VWI9iA909dIBadJjNY2MsYbXJinIFaAmPonjqwBL5urx7/nNIG81vZQmbMC8kQWb6JjEnluAG3Ikrdc2qGgOGCe2vdXn2/MCAdkuqJp17C1qwLUG/7LY/VFrTwdSu2h+XQwQ==
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::15)
 by SY8P300MB0480.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 03:46:09 +0000
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3]) by ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 03:46:09 +0000
Message-ID:
 <ME0P300MB0553E15D02A52DB482496B2CA6182@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Date: Tue, 14 Jan 2025 11:46:02 +0800
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
 <ME0P300MB05538EF3A86116EF73BE3BE9A61F2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
 <CANP3RGdj0gRohsT=3GUZ84dYZxPDUhe3-Zz26bQrsavYnwtDmQ@mail.gmail.com>
Content-Language: en-US
From: Junzhong Pan <panjunzhong@outlook.com>
In-Reply-To: <CANP3RGdj0gRohsT=3GUZ84dYZxPDUhe3-Zz26bQrsavYnwtDmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::15)
X-Microsoft-Original-Message-ID:
 <cd604ded-25d8-43dc-a19d-987d11a04007@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0553:EE_|SY8P300MB0480:EE_
X-MS-Office365-Filtering-Correlation-Id: 013d71dd-49fd-4ae3-a6d5-08dd344dfb84
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|8060799006|19110799003|461199028|7092599003|15080799006|56899033|10035399004|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVhZV2p5dWRmRzh3RmxKeHdHNnVHTmN4azN0VnVQZ3ozdE92NTBGMDVSOUVV?=
 =?utf-8?B?cndtRjhLeWRrOVpOQjBxZWNIdUxidUhaZnlNMXh6cWhnZWg0ZnQ1aGdqa2VT?=
 =?utf-8?B?U21oV2UyU3VzOVVGM0M3TEFvZjVHa1hUL2tnZTVlbFZOUGlMOUkyaFpoRGlU?=
 =?utf-8?B?a3BEZUVVZzV3a0IwbDM5ZUZzMkZBTzV3UzJnV3JaR21RandNUkdPTjJFQjZX?=
 =?utf-8?B?dzVVSjZ6Rlh4eDFhZStGVlBIdzlkRzZBNnFjaEhJZTVVcFE0a1dxRE4yWEl0?=
 =?utf-8?B?WFcxSXFrQ1pNVUs0QXZZY3dGT2dqSXlQSWFnZmcxR1AyZW5BTWJGZE8rNW9v?=
 =?utf-8?B?dEpaV01QVnB5ZTRrSXZUL00xWDNBUDNUWkhIUVAvM0FsMGhQak5pQXRxWUpp?=
 =?utf-8?B?N2UwYVc5K2pzdGZQb0NYV0RjbzFTbDBYc0hUeWdITHRkRWdmVGlrM0lienFy?=
 =?utf-8?B?Ulpma013VVl5UGhCY0VGckJJNGdmbHBzaEFsTG12Z2F0R0VUc3g0dm1KNXNx?=
 =?utf-8?B?bXlSc3pPbUJWTy9WUEVNU0xjU0M1cWlOc1NHVWczdzIxUGRhOU9lMFRFWm9F?=
 =?utf-8?B?OUNUZWRvcVFhSm9jTW10RWRSdWp2bWZibkYwL2psRjJ1MXo4UDh0Ykd4WDZZ?=
 =?utf-8?B?b1BaT29mUktrRWJiSFhkNUNaK3Q4MW55d0srUjhRKzllMjFSOFluRFdaU1R1?=
 =?utf-8?B?cFI3cW45VFdONUpkWnR4Qjh4QU4zdVdMVzFPeldUVnJPVnppSzl1Q0VTTnR1?=
 =?utf-8?B?QzlHOWlScmhMR0xjTkw1bm1HVU1JbTRsaUdOOTBXSUhPMnVVQm1VQytBM0NC?=
 =?utf-8?B?T2tFMnJtazc1L2FXSFZVaDJwV29rQ0tpd1duZmtpL2ppZndYZXVidlJIbTJ1?=
 =?utf-8?B?UkNyL1VWMWo1REtFWFRMVUpLYmNBTlowWXRMRkVwQzAwRGJLWU9WQjRRMFg1?=
 =?utf-8?B?UlVETWsyQ3pXay9CSnJmcDVEekJBWDhNWFFuWkp1eDE3dFJzeWdEMWQ4MVJI?=
 =?utf-8?B?TmNRZFpvT0NTWG92WmNIQW11eTAzdzVndyt2d3lNSTFvNWpnWGZLWkI3VE40?=
 =?utf-8?B?NUpGeUNObTFYQi9kSDZhU0ZiYzBRYzRsOTlENEdyS3FOMmZKSGtrcnpZNnhV?=
 =?utf-8?B?RmV0NGI4TmRQa2UyMEwvVC9kZ2F6RWl3NVZVRHpjaFRDUnFNckNQNzMyU2FX?=
 =?utf-8?B?UHNnV1hZL1U5ZStQdDJJcXRzNEJyYjFzdHhqbEZjTlVGT2lrN1kxbmIzVU5r?=
 =?utf-8?B?YTJadnJEUHNxVjVJWldlSW1OZ2d3Z0dLRW9jelRsWkN2SWIyZ250U2M1Q0dk?=
 =?utf-8?B?bjAyc2RxdGwzaE96UjFpZENuRWIyYnRBTVVwakI0K3B5SkkzVXJsYkhqMTll?=
 =?utf-8?B?QVpZL2s2ZEJxQUs0SXUvOHZlMFluMmFEZHJHL2J1bE9Ta2daUXRNOFpvZkZX?=
 =?utf-8?B?eVB0MnF1QkZQMEp0YVJ6cllPM09uenBaL0ZMVlRzVzlOV2RVNEhNUVpBZnZ3?=
 =?utf-8?B?R09HT3QxRlRBWWRFb2NhZ3JLMHh1d2dreW5XNG16andhRHpBeHllQmVtTHFw?=
 =?utf-8?B?bkxsMFJnTFF3NW93UWcyMUxPY1ROaytGZUp5QlNwcWJUa2NNKzA3WXFvSnZm?=
 =?utf-8?B?ZzZNQXJad09HeWk0R1NQRXpkdlgrK2c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3pMdUhzcGFoZ0pJeW8zRWx0cW5WVno1VjhvTm1WUmdINFVvR1Y2OEdwYWQv?=
 =?utf-8?B?aFMwZWVRRGVrakF3OTVPdXFhRUpWY0pYZ0hNbmFkR1dSejFNMXZUOTl0N0Ez?=
 =?utf-8?B?K3dqc0ZnYnd1bmovdnlZNHRmUGpkRkljTGJSd0IrS1MrL2FiRGNiWWhvbnB6?=
 =?utf-8?B?S3JyazZGYnhJWElUTGRGVm9DUXRLYnpYaEpYWi80V0JOdDNpbzlhaU82YkJi?=
 =?utf-8?B?aEJ2ZWRRYm9wYkswTlBGb2gzN0gwaTZDYURlQ3NHZFVrbGFlc3NlWUNRVnFi?=
 =?utf-8?B?UTdWSWIyMWNQQjk1UXU2K3dSQXgwMnFCSzhkVjlpazBFdUtZZ0dHcksvY3NC?=
 =?utf-8?B?aGFmaDM0UmRXMkFITU5sT0F4dmhOUVgwbXNIbU5GbEttaVNPbVE1bXJmSU02?=
 =?utf-8?B?QkpIbHQ4SjJkVUs5TzU2ekt2UGswenNYRmgvU1FpdzExS3lJb3R5MW9SZ0Nh?=
 =?utf-8?B?dmpjazU2WmJ0SXRnU2RXVGxFajVSQjdmaU90Y1NqOFFXWGdLZEFuRnpYTUtC?=
 =?utf-8?B?NXBlYXNoQmUySHhjUkhJeFQvbnRxYkxWNi95VnhSeko2bGRKa1pUQVZoVVZ6?=
 =?utf-8?B?UWloSUFqN3l0NHBucmphUDkyK2h1UHpDR3o3eFBENzBoaDVFY1BFZ2cybTlV?=
 =?utf-8?B?VlFBaFFkZUp0a3lLS3VOT3JwWDFsNm1odDMyVVpKTm1oaEFtVlpjalByR0Yx?=
 =?utf-8?B?WG9zRCswb0Q1MzlyamJDcGsrUWpLaXN2NTE4Y3lLM1ErQnU1WU9sL0ZmZW53?=
 =?utf-8?B?cWdFclJwNXlILzdNU3Q5Q3ExSHNEYjFVZjNmSGYxV3BuZDRTbmxROGMrcXhq?=
 =?utf-8?B?NGdiby9EN01GejVValFHd0ZVUVVrbk8vLzJNM3M4SFhHb2N3bFV6TmxvQXEr?=
 =?utf-8?B?S09INWtKdDl6Tng1eU5VTGRXSWFXU1BSajhhdyt6Tnp6K0NYdktqZ2QvNDNN?=
 =?utf-8?B?YVdyOVZ4Q0RHY0lydzgrMEVqN0RNSzNGbXoxbjJYY1BFNHk5amxUN3ZKaGlE?=
 =?utf-8?B?blFQMi92eFNabVBsWEFWVHhycmdjZVhwYXp0NFFpS0k0MEZYcDNhTzlhSjl4?=
 =?utf-8?B?SHVjdkY1QkNDT29HUjlWYVFIb1JYZTRJd3RxbDlkT0QwNHJaT3VhZ2lFVkt4?=
 =?utf-8?B?V01zZXBVZ2w4Z2Y5YlhIQUhUaU8xak4yMG15WXR1QUR0ZVJSS3dLZk5JL0lx?=
 =?utf-8?B?b1o3TzlJcXkvR2o0d09ZczBYbGdvZWNaN05HR2t6clJGakpsWDNiY1JpVFI1?=
 =?utf-8?B?ejdnRkZwWkVMY0FjZ1VJa1lUNlZLZ3hDVFBoV2FIUXJ3UXZTNEJtdXJ0N3Jn?=
 =?utf-8?B?MElsMENTNkZ4Lzh5VS94NEtJREJlaEVCU01tNVREN3Iwek1VNWZYSUhvQjZX?=
 =?utf-8?B?Wm1DT0pQUXNVSW5NdUNlZFAwVXZZZ3dTNWRwOWZJRGVMQk9vWlh0ZCtTalM3?=
 =?utf-8?B?bXhtMkVFZmlTbSttU1RVOEtjMnBLNEMwZnpsYk0xTnJVdHdEWmRpZFBFNG1y?=
 =?utf-8?B?VlF5YmFsdkFxT3VLR1djQWQ1eVZiUDhRRnJRSW5jcW5ZOEl2WE5SUXhqYm1s?=
 =?utf-8?B?ZTRPck1IYzZVWlB6UlZ5VW5pZkV3dnhValQvUnhtMXl5eUpjTVFwa0V3aTd3?=
 =?utf-8?B?ZkhEdWN4MVg1YklmZ0Z2bklKUEhrTVlsaEpxSXVCcVZCRlJ1TmZSZGY0VFRW?=
 =?utf-8?B?ZWhVSkNmOGY3a3h3YjZsZDg1MjRJUG42NWJheWk3b0Rnb2ZBRDlRbmg3b3VG?=
 =?utf-8?Q?9Sw5p6g267MlNttxZ4mWgpoACu5h+LZYZB0FCGs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013d71dd-49fd-4ae3-a6d5-08dd344dfb84
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 03:46:09.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0480

Hi Maciej,

Thanks for your quick reply.

On 2025/1/14 3:22, Maciej Żenczykowski Wrote:
> Looking at https://github.com/microsoft/NCM-Driver-for-Windows
> 
> commit ded4839c5103ab91822bfde1932393bbb14afda3 (tag:
> windows_10.0.22000, origin/master)
> Author: Brandon Jiang <jiangyue@microsoft.com>
> Date:   Mon Oct 4 14:30:44 2021 -0700
> 
>     update NCM to Windows 11 (21H2) release, built with Windows 11
> (22000) WDK and DMF v1.1.82
> 
> -- vs previous change to host/device.cpp
> 
> commit 40118f55a0843221f04c8036df8b97fa3512a007 (tag:
> windows_10.0.19041, origin/release_2004)
> Author: Brandon Jiang <jiangyue@microsoft.com>
> Date:   Sun Feb 23 19:53:06 2020 -0800
> 
>     update NCM to 20H1 Windows release, built with 20H1 WDK and DMF v1.1.20
> 
> it introduced
> 
>     if (bufferRequest->TransferLength < bufferRequest->BufferLength &&
>         bufferRequest->TransferLength %
> hostDevice->m_DataBulkOutPipeMaximumPacketSize == 0)
>     {
>         //NCM spec is not explicit if a ZLP shall be sent when
> wBlockLength != 0 and it happens to be
>         //multiple of wMaxPacketSize. Our interpretation is that no
> ZLP needed if wBlockLength is non-zero,

In NCM10, 3.2.2 dwBlockLength description, it states:
> If exactly dwNtbInMaxSize or dwNtbOutMaxSize bytes are sent, and the 
> size is a multiple of wMaxPacketSize for the given pipe, then no ZLP
> shall be sent.
I don't know if its a Microsoft's problem or really **not explicit**.
Maybe most of the device implementations treat the incoming data as a
stream and do contiguous parsing on it.

>         //because the non-zero wBlockLength has already told the
> function side the size of transfer to be expected.
>         //
>         //However, there are in-market NCM devices rely on ZLP as long
> as the wBlockLength is multiple of wMaxPacketSize.
>         //To deal with such devices, we pad an extra 0 at end so the
> transfer is no longer multiple of wMaxPacketSize
> 
>         bufferRequest->Buffer[bufferRequest->TransferLength] = 0;
>         bufferRequest->TransferLength++;
>     }
> 
> Which I think is literally the fix for this bug you're reporting.
> That 'fix' is what then caused us to add the patch at the top of this thread.
> 
> So that fix was present in the very first official Win11 release
> (build 22000), but is likely not present in any Win10 release...

As you mentioned before to fix it in the gadget side, it seems very 
complicated, maybe we need a extra skb with size=ntb_size as an intermediate
buffer to move around those ntb data before parsing it, but may (or may not)
lead to performance drop. Any other idea?

Do you think hacking in the gadget side to fix this compatible issue is
a good idea consider that there are still a large number of users using
Win10?

(Though Win10 will reach end of support on October 14, 2025, but people
may still use it for a long time since many PCs in good condition cannot
install win11.)

Best Regards

