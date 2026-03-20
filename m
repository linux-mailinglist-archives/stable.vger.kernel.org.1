Return-Path: <stable+bounces-227432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFE9MHe/vGlz2gIAu9opvQ
	(envelope-from <stable+bounces-227432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:31:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A72D598E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B49E307C8B5
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C7628469F;
	Fri, 20 Mar 2026 03:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="kDAI/wZq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6146F9C0;
	Fri, 20 Mar 2026 03:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773977457; cv=fail; b=dVXIVxQNTaCzSfsJIb21AGkTqC7K1n5mzLuKTGdzk/o4XOJgRmuqTJoCEI23lj1lQioToJ2FYNuHXuUEFik8rJw9RX6bPpGLSRon7ZQJv7NmGal5Kq05oXhyPLPxjWmZYJ8ih7vT31lh5bhPv0B3izHQUpNRbyuJBOMjPoBCfrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773977457; c=relaxed/simple;
	bh=wodPdY9QqnAY990hj2Js/3REpROFjpiAST3d09uqX/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bvUkN4UFZis/3mRzqILKZ4lSfKjav07LaX4q8cd0pUNBRvDuCE5lNPOI+gr0i0CpjwKD05rhRq/NmiisWXkpvWyASGShC7bFA5Ka6B7mYdsrkXLQ4shKY2AVv5YcpyOJGgSSwJAZpfGtGG1fCnO769TyVUNYvgl2a6Abst/mhwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=kDAI/wZq; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K2rPcf1758979;
	Fri, 20 Mar 2026 03:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=yJ5Dv6Immu34SJYMb7uz3qmp4qV9fUP2uIODBCeAWLs=; b=
	kDAI/wZq9G1rbQA8Tc/dj7yv0qAuy8nOB2CuQYv7mbsvhjtmrNkD+IEVWGD4ylfz
	4NGIXj1DJVgvSwDDOyiPTCX/1gL99zaR3iBE/zIdhV7kg0IRxF8gxApfdtq4X9sL
	1usbgV4VSp2S/+cHLqgRUqKo+EpueaxiKLFDPLq5+BERKACreK6g4QdWradBSSFs
	XShKrLkjp3qloGxZtwzREdLRtUdGrdSEJEeU0N0SuFid4mNgf7Zbu5SBlVP4gFQA
	Df3/yIovgR2MRjE0ROHa7fSIlQdsI9ebIw3gioIsbAvBcW0YDLQU0V7i6xo9ERPT
	Zm4hRnrR0GtiB3+u9vRr3g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cxm66dc5e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 03:29:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FY1DdGwCK+LwbgdrSJc6drii9rpBEQQyyfDhp6QLNWY4OX8fqlXY7zc9FKGiZHj5G4+xont54OOohKYN3JRuVmoqxPCvYA+BBHPBSBsAcCuWpAAOywKJw0k8i3ATDlGkejW5Nm0NtTXtm+/GuXwyizxw4ZohqQHS2s509xgEoB7cn+2Q8Llxi5xQk9UCCz1wpCNoqu8TGVsfZ2O8mnQqPwJ/9kp98bphLXMvpUHpZeF1O1AZ909qLNkLGPRIWnXY/IxCxFhUan9SSGfZEm2rjBRfNAne1LlEfXaHK7waT3ATY8Jw3VLwMtn2QAdElxc6EBMw+v9dKvvcTNGUNnIT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ5Dv6Immu34SJYMb7uz3qmp4qV9fUP2uIODBCeAWLs=;
 b=G0C9BFuUsBWdUntwhpG9284rwcA0xk7icc4PRlw+YuV1aolfrfzW/kqsItBbX1AujhffD0PomqSNngctP8d7zpPe1o9Rp2Gt0AiGznSvDOAGj99GZCgmn91jGoPlRfRDLchySp5QYeJ5PXZ3pJZUQJa+63/1ubKm0wAzLQ+z41YDKt5jzSPGfFm0t/+3/2K4MDnoDNEnTzX1LAbBA483ifMmSoFboyIZCejY5MwuTkhBcOkLjWQQv6n2bZGKxwy9IUL7zR5hHWHhj8YxX1RhnzaCGaf8Z+r1c0pC+uvxt3CHKBJi/zTNuGVI0c5yfs7fd6Y/AYtRj8XCzS+FX5/OOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by LV1PR11MB8820.namprd11.prod.outlook.com (2603:10b6:408:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 03:29:02 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::7b99:70e4:edb2:30c2]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::7b99:70e4:edb2:30c2%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 03:29:02 +0000
Message-ID: <06ffdbe0-1743-470e-b83a-d2c9a4702461@windriver.com>
Date: Fri, 20 Mar 2026 11:28:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] perf build failed after 5cf6e76e4f4f ("libperf:
 Don't remove -g when EXTRA_CFLAGS are used") on riscv64 with gcc 13
To: Ian Rogers <irogers@google.com>, Chingbin Li <liqb365@163.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, james.clark@linaro.org,
        linux-perf-users@vger.kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <813bc5fd-0c35-46af-aea2-90798154daaa@windriver.com>
 <CAP-5=fW_O_sm9JzfCf=qDXyaffoLLRH3mob1zckESUHsG2rp-g@mail.gmail.com>
Content-Language: en-US
From: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
In-Reply-To: <CAP-5=fW_O_sm9JzfCf=qDXyaffoLLRH3mob1zckESUHsG2rp-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0115.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::7) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|LV1PR11MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7ff46b-9ff1-4a15-24db-08de8630d4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NZf1mjaLJh9GpHEWiZ9B+0rStSNQi8pe2ZcZ+FDMYBYG3tcOJ/gl/G0N3UIr0YIW2xVcuhPN8kNPQuKMKfbF3sdjhCDYkhS76+uJrkCUETGI0mZfkKLPh+c1iV3648NzNONi3KM/kZ0I2WauEZKUlI7WfgrnkRGX6kbR8+9bIlp+miNIeJk10+Y3ORwH9srqh/4Gw56srhMLuuTsQ/wE9l0kFqUeXpMDgYu3oH+rHGFC3SDuPXHx3AJ9fZhEOaMk1XNycugWtRwx2n+jLLT3x6+Rua6lmAGbTmSYHuiCq5qZJu9mpQjlu3blLYndj3z+DEBnYlPnsv6haM0itTdKXJfcAygAE+zG9puaPPIemT5ldTGZQpB8D3fjOJule5lyL386WnGNMFdxUMsyz3QZDevv8Fe2C6hYHoeuI7LiGMsLk9M8/5CrJge81Ou0V2+pAyvnhur4jo4F3Qv4h5rVzwMZVxtTaTxvSOZSK38s/LpLpf55l5x8ncnaOPwDZ/aofbMn6aHYBMegzXmZzptQZDxYs8Ng4yBFBj3HTwRYEjS9ILPaTNINTA3/VtVlFMrgHJCtPyYGElUB4ZUXbr8LIqbe1M5lxsCMQr4iej3aaj2qnxahE7DdqYCOMj/5hks8SzH5t4BBUE2lqhkXxt/4m/DaTOXFnLRt/fBRNrYL7+3+yqLnKMtNxs3KBK2i8qk0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azdVdXBCd1IwVjgwUExtTlljK2ljWmdFMjQ3cmF6S1Y2Vm5jaEh0cm5lbjlt?=
 =?utf-8?B?QlU5V00xVmVrOStPQ0ZONUJVNnBYWWMxZHRZVkZ6UnRBVDI0WkxCMnJsaGlJ?=
 =?utf-8?B?ZU9PQ3BmcWdhYmo1bWhSeEVPVFgzYzl6anJIaEp4SWdaeGJjbzhqZWs1WjlQ?=
 =?utf-8?B?VnA2V2F3M2d0Tkp2QTh3bk01bmIzdVlpSUdNSVBPSEtZM0hDSzFROTFIYVZG?=
 =?utf-8?B?V0dSUHp5ZFJPVk14YlcrVGg1Nk9kMHFjZ3p3ZVlsVEZtTkIxcVdhNUxmajM0?=
 =?utf-8?B?ZUtGWHU1bzJxcUxmVmQzMlFTMk8vTHJwNkFNdTRlVkNVVjNqRWFvNzR5TUhV?=
 =?utf-8?B?WFJYMVRUbkI1V3NYN2pGa0dkS0dmL3d0RG5zdXNGNmh2V3hTeGNWZmhiaURE?=
 =?utf-8?B?dERTeVVuNUhLTUQ4OE0yMFIvd3p6M2dHd2RaRGtKRWh2NHRHaTFGYlZyQmgy?=
 =?utf-8?B?ZFBGNm8rRktiTDZXMkJZZXJsRllURC85b2J1TGV6djlLQzZOZHNlMnIvWGhO?=
 =?utf-8?B?UXkrQXU0b3ltTGREd0pncnViTjJUTy80d0ZWN1FmNlRvY3c0bDZid1NicDEr?=
 =?utf-8?B?dnRaVDVWV1J5U01uQzFMM0pmbkluMVZZc2t4VTlhWHh5MThGSWJnQzJseFIv?=
 =?utf-8?B?WFVsbWFpY1lGaVVOSEJFL2E0SGs2NWZSbUQ5Y1VReGJEaXpsSHhCN0ZEdllt?=
 =?utf-8?B?RzA5WTU5bzlhbk9UUmZPVjBVS0RwZHhyUC9STWJvUkVhejFyTEtncHdPcGZh?=
 =?utf-8?B?Q0xiV1pWc0lhanc0di9jaWhwQkg4ZG8wK0lkTkxzOWZFY1VMa29yMW5IZ0Jq?=
 =?utf-8?B?Tjlpa25xTVVSZUFGTjcxeFVrTEVMdUN5aUdQeVV1bGUvWTVVczhFU3FGVDlu?=
 =?utf-8?B?TEdSQjZSOFQ2OTRPdS9NNExTb1B6TnRMZHI0TWVEQ2NLNW04bzB6eEp3SFIx?=
 =?utf-8?B?OUp0a0xXOEJyOFF5dFdnVmtWcDRrSUFVcERXL1I2MmhaTVZqUmxQL0hFcCs5?=
 =?utf-8?B?dVFnckhQRG4xZHBqNmdrU29vZVlCZWV1SkszT090V2tPS1VWMUMzVWd0U1ds?=
 =?utf-8?B?eGN4THJhREplV3pEc0JlOEU0OGxncjA3MmZBTzh6M01EVHJYYlMzckNDR1hv?=
 =?utf-8?B?SkxCVTBGemNsV3NoTGxKOXdueGZRUEg1ekhCSzJReWt5ZkhrUkltSGZ4USsr?=
 =?utf-8?B?RUJnUTQ3VGxiUHJweGxBaU91WnNiTVllcVVGTnFPZjRnR1d5ZlJNMGVGRUhW?=
 =?utf-8?B?UEtiLzlzQWlEaDZaSlhzT1BIY1JIOVlVdXR3VGgveTBQNEU3aFl6ZFZZWTJR?=
 =?utf-8?B?WTNIWCs3QW9HbUxLUUVpdkxhUlZZMjloNW40QVIzcFBwWmdnNjcwclZNbnVa?=
 =?utf-8?B?TTZNVWZzV2JEdHM2NHdIekRrUWg3d0xtNGNHZkpjL2F5K3FibnlFT0lGbG1v?=
 =?utf-8?B?N3hiMjhJNndPWXRrWVdOaGtNb2VnVk1UZERIZGRyanVmemNQR2h6NlFOUjcw?=
 =?utf-8?B?c2JLOHZHT3hobFhXUkdKMVI2em5KWGV1TW4yR3AxT2JqZ2R0OTVoS0J0OHQy?=
 =?utf-8?B?VGhuQlE1S1BteUkvMnpkV3pHalJxVzJIL29OeTIzUHZ0TFljdEVSWlFia2RW?=
 =?utf-8?B?SEpCcXJseVJUSWtBRnkzNHFDRnBtYnRpb0Izc0lCaU9uMzdObS93MGJCajJW?=
 =?utf-8?B?d1d1MVcwdUI0ZGhLUytIaVV4Z0FIMTlpN1RDTGNvR24rS1dLeko2V2w1VVR2?=
 =?utf-8?B?L3ovVDRodjg4dVRBSS9jOUVwQTdMWGk5MXRWbE5acWtpNGlxU1FWUFdEK2l2?=
 =?utf-8?B?TWY4T0RmZExtWEZlVUVvbVNua0FVUTBwV0Y4dWpWUnBXZUt5QmJsQ09nc1RB?=
 =?utf-8?B?Zzg1clZJTGJ6SFV5VzhLbHhLcmlGbGVlRkd2d1IxR2xOTHptUE95dThKMHl0?=
 =?utf-8?B?cllOV0tvdGJ6enNqejd3RnErMWgzYUpvWjZRQUZTUnRYaklIWE1WdTAvL3VK?=
 =?utf-8?B?b01zL1piaWRMVllGVitoL0pnWWFBTmxSRzBhdHJITG1nZ1FreWJoMkI3Wi9H?=
 =?utf-8?B?WXdOc1dVSGw2MEErSCtPdzNjK2d0WnFDSnZhZnU0NnUzUG95Y29kenhwMS9E?=
 =?utf-8?B?RUZDTzRNR05GS3J4UHM1aWlGQXoza0YxL0F2enR2eGxydXpOVEhHVUZnc05m?=
 =?utf-8?B?ZmN5dDVFT1NWajkwZVpVN3Fad0xCYVQ4RXlGcG5XanVpblVMTEk5VDV2dm9E?=
 =?utf-8?B?Y1RETGJJNG04S1ZoL2tFMlpscXdMU0VFa2c1L1FPRS9TMHNiVDl3UTdQZDI1?=
 =?utf-8?B?RENtSGhtREM1Wkw4dDFXTUE4QjF3OU5RTUpzVUREcXhGMXJCUGdUV1htSDkr?=
 =?utf-8?Q?jw8N9kfdJcwdMRT8=3D?=
X-Exchange-RoutingPolicyChecked:
	g6b1Xx6hvAA8lRsE3UTvyeYPGCDwXLG7DmisMwIuTk4/hgCW8pR2DEPdNE9HyzVuOeoIBnNKz6yJGPKlYovXlxghsRj8IIQYCnqLecyzSVCM/R8Khi+sAfZnBhuSNv9cMIyNN7dbpobplo82sgGPxsLsQBeDQHIMiuy2YOJSWmPbU/9rGIaUBVe4bbURnumx1Yje9almxrIt69J7yPrLMzVHCoA3xJaJabzHphGMG8XOdJ/Zo8TCl5lZv/d74i99zX4WwIfZJ36Amvorsc8aO6LWesaIS6AjzytgOgSDCZLI2UKCVlFpOFYO1Wz8Uo9BqqE++zh/CqFBUUyha9UfaQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7ff46b-9ff1-4a15-24db-08de8630d4c7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 03:29:02.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIDL45LpYyU/zY83IeamWDqDuZKuL0yFxkGIf8dUqfG1Gm1+n4JLZ9bHpo9gntUsucYEPKUD7+FdZK7WXkc3MKrVjf7yau3vQMUsGhx44qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8820
X-Proofpoint-ORIG-GUID: G6gqpH1Mg9e7_p_n10PsukcYTv2zYSEL
X-Proofpoint-GUID: G6gqpH1Mg9e7_p_n10PsukcYTv2zYSEL
X-Authority-Analysis: v=2.4 cv=fLk0HJae c=1 sm=1 tr=0 ts=69bcbf01 cx=c_pps
 a=RSwuJLpHzOwHBpypAu37kQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=1XWaLZrsAAAA:8 a=iGHA9ds3AAAA:8
 a=mDV3o1hIAAAA:8 a=t7CeM3EgAAAA:8 a=IJxojsRzdbPxS6_aMgQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAyMiBTYWx0ZWRfX/k8kia08zAsS
 snzL+51mTiYFfLMAx5rqOI0KUIRot5fNFjVk2XDICLorgZGgn6A33pVkdXFpSQP+5M+XDMUE8Tr
 v4NUsYLhnO3lUFT3HZvQwjuOgXOuJn2vFYfDoM2m+ZrYQEukQFfBZ0bGirxFuHl0e5mChlL33/C
 +UA/pT29gCK/g/ZwH1DqqNW05b9CN17PTL2W/7vcxXl9aRnczQ0dugoRBxukkXlaGYU2sc+OM4m
 WH4tist5ItWBLCRFxZUSyWufu5Pp7CcsILPqpKhDlQd5nop6TyKq/puZmWLvUYnuj7/NA5b6gIP
 cmMj47JmnpOH/QIz14HEVqbUgGc2bliX07g+Jn5zxewG/xQCL1xwytUbnY6yG9M6Tf9VeKJtooQ
 FU8Y5XtpYhkuiZpQPsOx5Cyv1OeS3HRu82rB3rWv+GP0rrf3GbbrU9TmOjKRlh23iKlOG+zzbO3
 rvy2u+Tan9FkE9gmViQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200022
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227432-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[google.com,163.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haixiao.yan.cn@windriver.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[windriver.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 557A72D598E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/19/2026 4:21 PM, Ian Rogers wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, Mar 18, 2026 at 6:57 PM Haixiao Yan
> <haixiao.yan.cn@windriver.com> wrote:
>> Hi,
>>
>> Commit[5cf6e76e4f4f](https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/tools/lib/perf/Makefile?h=linux-6.6.y&id=5cf6e76e4f4fee54c0056758b639cf4919cffba9)
>> changed the libperf Makefile to preserve external CFLAGS instead of overriding them. As a result, the -O6 optimization flags from perf's
>> build system are now inherited by libperf during compilation. This triggers a false positive -Walloc-size-larger-than= warning in GCC 13 on
>> riscv64, causing the build to fail with -Werror.
>>
>> | cpumap.c: In function 'perf_cpu_map__merge':
>> | cpumap.c:422:20: error: argument 1 range [18446744065119617024, 18446744073709551612] exceeds maximum objec
>> t size 9223372036854775807 [-Werror=alloc-size-larger-than=]
>> |   422 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
>> |       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> | In file included from cpumap.c:3:
>> | /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/work/qemuriscv64-poky-linux/perf/1.0/recipe-sysroo
>> t/usr/include/stdlib.h:672:14: note: in a call to allocation function 'malloc' declared here
>> |   672 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
>> |       |              ^~~~~~
>> | rm -f /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/work/qemuriscv64-poky-linux/perf/1.0/perf-1.
>> 0/libapi/libapi.a && riscv64-poky-linux-gcc-ar rcs /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/w
>> ork/qemuriscv64-poky-linux/perf/1.0/perf-1.0/libapi/libapi.a /buildarea5/hyan-cn/project_yocto/poky/build-ris
>> cv64/tmp/work/qemuriscv64-poky-linux/perf/1.0/perf-1.0/libapi/libapi-in.o
>> | cc1: all warnings being treated as errors
> Hi Haixiao,
>
> this was raised before by Chingbin in:
> https://lore.kernel.org/lkml/20260212025127.841090-1-liqb365@163.com/
> I was concerned about the introduction of volatile to avoid this
> warning. I've mailed out what is hopefully a fix without volatile in
> it:
> https://lore.kernel.org/lkml/20260319081843.1650640-1-irogers@google.com/
> If you could take a look.

Hi Ian,

I have verified this patch on the master branch using gcc 13.4.0 for 
both riscv64 and ppc64 targets, and
can confirm the issue is resolved.

It would be greatly appreciated if this could be backported to the 
linux-6.6.y stable branch.

Thanks,

Haixiao

>
> Thanks,
> Ian
>
>> Steps to reproduce:
>>
>> git clone -b scarthgap https://git.yoctoproject.org/poky
>> cd poky
>> sed -i 's/af240d7d57ebf66e87bc2dff34855e630a97ead1/5cf6e76e4f4fee54c0056758b639cf4919cffba9/' meta/recipes-kernel/linux/linux-yocto_6.6.bb
>>
>> source oe-init-build-env build-riscv64
>>
>> cat >> conf/local.conf << 'EOF'
>> MACHINE = "qemuriscv64"
>> 'KERNEL_VERSION_SANITY_SKIP = "1"'
>> EOF
>>
>> bitbake perf
>>
>> I have confirmed that:
>> Known to fail: gcc 13.3.0, 13.4.0
>> Known to work: gcc 11.5.0, 12.5.0, 14.3.0, 15.2.0
>>
>> Not sure whether this is a gcc bug.
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124549 filed to gcc.
>>
>> Thanks,
>> Haixiao
>>
>>

