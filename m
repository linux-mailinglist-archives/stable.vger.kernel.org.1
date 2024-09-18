Return-Path: <stable+bounces-76701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9762997BF00
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 18:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15A61C2131A
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A81C3F16;
	Wed, 18 Sep 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OKqMqtqd"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF41ACE1F
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726675925; cv=fail; b=UAmkDJ6qRb/k3jC3+6PIBB+AeMCtWm2x80S6EoEuYweN3xVmPqI+bQ5Yqw4peLgDcXYh8jsYHqyBRKw8Y/gl9Sd/YjYrBo/aVLLjRa1EIKKky7gogSsw5OygXNVwoSipWY9aRUUiLQCigcpXfTPVhm/4VlxGc+1tY4wfvrbtFuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726675925; c=relaxed/simple;
	bh=3hqBM7s+vzJUsfr9aVnt9cHcaP3gTxA4wM2E8TqLpqU=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=D1OZMX0GQvUod4+pLoCNV2BziN1pcqvVZ+7ef/mjsLi0kN2ASo8KkuYPNbDeq8F1bBBK5FrK3paJdLT/fxmlw+pMOUl0WdE+8cn42qalJJuTJvbSzlRXkwGA8cW3FSR9Gs07LxFZAeuXwBrFzM/8WnFTgo5LiqUAo6l/+LGD/aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OKqMqtqd; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6cRQOLczY9INF0wjwdOtnIvwitYEDxWeWBmq27VtknVTxWR9545y6ciW+6mqoUOmvRpgZGwfcTWTGd14Lk/BMbXIvGrraiRen1/S85R5GC9Z64vkgEPG3J++4S1DhhI3RwswAfwQd7gK9ppcOwy7Qp33hXMZ+61C4jI7B5iqT3aO2S5pobIapezLdGEb2gY6cBrYSdzTTBuOa79VDTiSNkEYhMsjHBfaSqBq+s5RT2pfNEaOcRRjj1FU3+ZLX35OvDkZ9ab8GzP7spPxHWwc5NFfalO1QJpZt1h+KaJ5HVnszXVWr4kgp2Lh4Z81wmm4NQi0t4s4DB51QD3sk5htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=856g/bmLPKfoYtXMYJt4S63bRQ0zxa8IUfQnyAaRKvk=;
 b=OpNvYYIT7yJaTBUIG9f5Y3tspvjiO6i2IMaTawUme5iiWqP6x/W9zn8cGVkK0pOu4Kri6u1ZiVH0GyWy0Uf9efr8gwsoMmceQEFD4CL17iYq+SVucbTRwRpjsezAG5BzHbhyMHWGgbkQXcq//KUihrmxz9Krp4L9AB2OeegTjX7SeRso8P42iBXt51RZvsFUKrTp/24D7rq94PzbFcTvCh2qlm8zj8m6uVDAXUe2YWWtEsfUfELNGtMVFWXIP3SoCD4lWTI9bf5ykxADMydNL+Jhxk11+4XC4Ifuispqu1Qs+gXncwROMOkkc62aNFr864TYh2LtsdomXF5cekdeiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=856g/bmLPKfoYtXMYJt4S63bRQ0zxa8IUfQnyAaRKvk=;
 b=OKqMqtqd9oNZ0XJeS8Tk0d58GVBRQ/S2Hn1jMjcoBwLDxiX3ApW2pa7q0ZHp09upNfbiXdxEsW4wZX998g/3DC8RUVHx61Me4E3pGvnSbus0Wl6wrLIFGf9b5zABgRoj7UyAChWTBLaeyZxVkiC3Bd8Ju1wqzVLDOEWfKA3f3xY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 16:12:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.016; Wed, 18 Sep 2024
 16:12:01 +0000
Message-ID: <b962cc44-51b2-4ff5-8663-da38cd95222b@amd.com>
Date: Wed, 18 Sep 2024 11:11:59 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: AMD Family 0x1a RAPL reading fixes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:806:6e::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: cb09a367-c9e9-46d5-34ed-08dcd7fca11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1RCdWc3SStmbDN3NnZlUFdVaFpNeS9wRGpHZlBBR2EwVmVXZnROZFp4NzZT?=
 =?utf-8?B?Y3o4QlpxMk9jYmhEMFNKSkpPZk5sdjU0Z09SbzVFZ2l5UU5qSXBaUmdTLzFS?=
 =?utf-8?B?SThKZkdZcW9adWNwSW8ya1NHVWdqUm1JODNpSXRpTXVWRnM3UzI3SEF6TnY0?=
 =?utf-8?B?ajNjMTE2Wm9PdnNZYk9zUlhoY1Z0Uk03MkJrRFdncG56bnplSGhFWGNWM0Fn?=
 =?utf-8?B?Tzl0TGJYOTYvOWFDa2UrVXdMNHlZcmxxNys3MXQ5Tmo3TW1XQ1o3UDZtUXpO?=
 =?utf-8?B?Ymh0elc4WEp5ZjU0ai9yTVlhS0VaVlA0clFvS01CMTVpQjVkTkliclcwc3l0?=
 =?utf-8?B?cjhiWnhiNDBwK3grd1BNWHJzRWZaWXRnckRkVDBydkJNUE5oWmJXTXN6eXl2?=
 =?utf-8?B?R3YzckFOMXRhVDhIVm9iTEYzYSsyemxxTWF5NWl3SzdPL1dGQ0tjS3J5QlBK?=
 =?utf-8?B?OTAwYjkxMzkwMnBvSjVIdmhQMEx1ZmFJdS9WZkluYmNCdXpJWld2ekpQSEcy?=
 =?utf-8?B?dm5XTlp4bW4wVG5Zc2tpOUFvQjdJYU5lMm8xVFpmb2F1ZEVkSlJ1a0VVODBq?=
 =?utf-8?B?MXkzdElRZ3N6Nmx4QUlLWmV6MHk2Ym9zUlpGTU4zTjcvN0FTVmxDdVVIbGJ2?=
 =?utf-8?B?cUF1amhsV3c5UjFFMTZvVlhBTnJDY3pHdE9zcjZrQzNoR1V5WmVlRTBBRkl0?=
 =?utf-8?B?WGdVMGk1bVROMzYyNUx3TXoyY2JwUVF3WVl3aUNOZzZuQTlqR2ZHVzY4WUlh?=
 =?utf-8?B?cXd4TzBoL0RGei9Jb1dwRVBVdWVmZG5hNUlxWVZVV05zS0oxUUl5UkJCSEdV?=
 =?utf-8?B?UGJMUlZnZlpkalh6aWNBeGxLVTV1QjNuZ1pjaUZKdjI1UDRUakZSb05RR1py?=
 =?utf-8?B?MmozSGNaQUZnajI4ZE9RbzNHYjNpWEhQVjRZNXRUYnByK1lBeUx0NVEyK0Uy?=
 =?utf-8?B?akxXWU5Fd0JDQXVLaVR5UEVIUlZ0RlVLaFNNRE1LYjdYM2VUUzgrQnRydk4x?=
 =?utf-8?B?NCtLTW5IYmhKdG1iNHB4TW42anJISTFEbmNwWUp1cExCN3Z1WUdVZ3RnajNs?=
 =?utf-8?B?bnJMT1lLY0dtY0hkc3JJUmJFellzUEpueHZwSHlsd0djNWZvd0JTSVRvUVpH?=
 =?utf-8?B?eHJReU91QTdrUHM2UnZ6ekJGZnkreDlFd0NKOEpWWkZ5ZGlFcjRhai9HQmxV?=
 =?utf-8?B?WnB2aEZrT0dZRlAwNTZpSXFsWlRPWkJTUHFkVWlMMXJjbitKRDQ4VnZIT0RG?=
 =?utf-8?B?TnorcnVOc3F1MHA4dklPZWYxdzRPejNWUk5oK0ZOemVTN2UzaEtMKy9mL2hM?=
 =?utf-8?B?T1h3bEJOcnA1WnFGcFNPSkQ0Wk82NzdJajJBdWtSaHlQVEx4ZCtPdDI4bXVa?=
 =?utf-8?B?TUFlWmtXNE1obXJkeitOSTR1SFF0UDNZbFkwdkhjcU55VjhtNGFsT2EycDVh?=
 =?utf-8?B?Z1liNUl6S1RIOWZYVWRuZTVWdWpNRGJMUElRTmJUOWpqd0NQRnhwUnNEMTU0?=
 =?utf-8?B?RDh4WmhmVkdOcDZmVnlyVUQ1Q2N1T1pIaHhad2NtNnRwWDV0MUtQT0hkS3M1?=
 =?utf-8?B?MUJwUXNxSWFsYXUvQkdrQjdGVFA0TkwxVVUzM21uU2kyMFJZaGVpbENSTklY?=
 =?utf-8?B?ek5DbGZxcnNiNjZYSmlvVVpjYTBDYXY5ek16ZmNwd1lGd2svdkNBZnpmWmt1?=
 =?utf-8?B?YUpHcEVrUnMzRFU5K21wRVF4R2xUZkdkc1dxZGxCY0pIMURFU1dCZ0pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm9wVTF1YklpbXNGRVNvdWhQSzBSVCtiV2R1L1UxdzlZcXZ5QmFwQS9ybWl1?=
 =?utf-8?B?aDA3TitUZTVMSnhLVWRid3JvbEQ3Nm14c2EydWQwUTdCelNtVWFJUVVVcytL?=
 =?utf-8?B?bUlpSXQ0NDVXYTRPZUtreHZldFpFQjZ4TmZUaWRpN1luMHJPTVJjOURaaHFT?=
 =?utf-8?B?Z3BmeElNelBjeVk4UVJiSDc2VlEwQi9UQ2pTdytUM0FQQW1wbU85M3NzK3Ar?=
 =?utf-8?B?R0RKUDk0ejRSNFpDem5JaklPTGFEYm1zajdKQ25EaXplZ2VUUThjZmdZOC8x?=
 =?utf-8?B?dzhjNC9JTHZHdWJDbWI5QkNmZTRrSlhSZjhiOUhuMUhRWmpNV1VoMEpCNHJX?=
 =?utf-8?B?cjZxUDNsV1ltZytQWFErUUV0K3RuUFQ5aEJWZ0FDdmhHcnpxZ0JkMU0xVEZl?=
 =?utf-8?B?VUJqcHlDQWtsMGhOc21XL0RDajlySk9mVEhPdFlsdkQ2WkRmenJZa01GdVlr?=
 =?utf-8?B?OFlDYTBKVXUvK3Y4M2dyNlJpdEl5YXk4YksreTFhN3N6UkhTNSttODV6VkhC?=
 =?utf-8?B?VjlGNFlMQS9GeVlhNjlnbEIzYkJleGJubkVVNUczaUJYdDNNMFBJaDFOdWdu?=
 =?utf-8?B?bXNkREJjRlk1MFZGZTF5QVFvMHpOZGdBbEh2ZTQ4ZjF4OUQxUWZGOS81bTkz?=
 =?utf-8?B?S2lmQ0J1SFM5UU43RkF6TThPUnFKS1Z4cTg1NklNUU5nUkVtUUUvYy9ReFZK?=
 =?utf-8?B?WE8rcHpvdE9ZekdhRjd6VkVIcjN5YXJMTnN1eW9jVnF0dXAzak8vM3hrTnc3?=
 =?utf-8?B?L0drSlNNazJ3WHZBVS9RaDRSRjlEemcrQTlHUFhYWHdNbFhwdVBMRXB2WlA3?=
 =?utf-8?B?YnAreUp2MjFXYTdZVGVHQjZPVERzMFhmMFNpUzczTmU1YXJvUnVuQzViS3VX?=
 =?utf-8?B?WVNMRFdPS0ZsTlc3Vjl3SU5ORUZyZEpLYUhLd2lXSXVvR05zVSttVi9hTDVS?=
 =?utf-8?B?ejVJNU84T2V0aGp3R3J0OGNOVndENmpwc3F3WUtKNFZkOTRmM2VVUnI0Vm52?=
 =?utf-8?B?YnRsTndheW5pUis3OFgyWkdUajB2T0FpclJYSzRucEhoQUVRUjBaOE44N2w2?=
 =?utf-8?B?ZjNDa0dTN3YwMzlzODNzenpPNHA2ZGJ6YmU2SUV2NG5xZWJreW8zd3JMeldY?=
 =?utf-8?B?ajdNbjFMSGRwYm91ZENBaUcySzBRTXBXb3VmRnlzWEMzaDFSK2JYUlU4cmQr?=
 =?utf-8?B?WW9LaCtmL0MxMDBtWUkvTXU2OUx2dk11YTNIMForZUw5VC8wbUN3SHZIeHZW?=
 =?utf-8?B?ZFpUQUtObVdPYml5VGRpVG5xclU0eDFKSDBJUDIwQTBaYzMrbDlCQ2F2QjU4?=
 =?utf-8?B?ZmNrb0o0cnh2TFZRVU90RDhLaFVEOGpTQ0d0RU54azZmV1RKSVpHZURCTWYv?=
 =?utf-8?B?Rm92RUlxQ3RTRytySU92N1NueGtIbnU2UHdicjV0VC9PVWNTZHJZbkdVMmdH?=
 =?utf-8?B?RlRVSGtRaGR3S1VRbFRPR3dxODh1UWR5aTFBWmR6MTF5d0VsUXorS0trcUxs?=
 =?utf-8?B?RzBsc0RzcFRmTktSaWFqL3JKWjVhVWtiK3RuZjdkWTM1UUh3SGVWdVlMVldB?=
 =?utf-8?B?T3lwc3RWSWRlRlRZOURpL0lreC9BQVJOWjd3dklYeXpBTU1YSGJzdFAyOUFo?=
 =?utf-8?B?SXJoNlNxVTV2ZmxlNGdKOU5uWE1ZTzliSU9pUTJxaXB4RlZwSWQzUTdvZkhQ?=
 =?utf-8?B?c3RXeWhBWHBKT0s1ckhOOGhxWmZuZnpNa0RCWkp1U1luYlVRanVodGh5Wjc1?=
 =?utf-8?B?QThrRXhSSWhMajR5Y3F2YjVaOUtubGRRNGlkN1BUbDR4aER1bzFQN1RGTXNa?=
 =?utf-8?B?VXNhS3RmVGFqOWpDanoxUEVWcGVvejl2WmZqdkY1eWFmRElQNUZTMXFSSWFw?=
 =?utf-8?B?QUxCZEFMVnlhdGpqdzgzTkFtdGkwTVNCOXgxcStiMmIyLzlWVjJsZnVpTGsx?=
 =?utf-8?B?UjFhTUdjQk1ETTRDMVA0UkhIb1dJU1VETXlrWXRuT1NTRUkvZ3NiSEgrcm16?=
 =?utf-8?B?WWh0bGk2cWw0MGgzTG91REx2clpWV0ROelk1TUI3NXc1bmN3UkVOODIra3BT?=
 =?utf-8?B?T20yNW9BMXJPVzg4dmw2RlFodTdUZ0RqVEpCT3UzS1lyWGZpOGxBZHlhNU9Q?=
 =?utf-8?Q?wWjPswikbMgw+TDSFNTm1sP8M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb09a367-c9e9-46d5-34ed-08dcd7fca11e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:12:01.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0k4ifS+MH5oY/g543WdWL0wmtzWorQKEll5j5QtdP38sKJbQm89N2ZcBITe7TBNC82ELzdZJeuIH0yJ3KyZbMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

Hi,

There were some fixes for RAPL reading issues recently on some AMD systems.

Can you please bring this commit to 6.6.y, 6.10.y and 6.11.y?

commit 166df51097a2 ("powercap/intel_rapl: Add support for AMD family 1Ah")

Can you also please bring this commit to 6.10.y and 6.11.y?

commit 26096aed255f ("powercap/intel_rapl: Fix the energy-pkg event for 
AMD CPUs")

Thanks!

