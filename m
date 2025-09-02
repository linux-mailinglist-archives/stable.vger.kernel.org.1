Return-Path: <stable+bounces-177032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F2B402C1
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00FC166154
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25277304BA4;
	Tue,  2 Sep 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eirtgBUu"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA902DCC13;
	Tue,  2 Sep 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819188; cv=fail; b=IkksDReqP7Fnusxnc+AXZ1qXReGP7Hk7zVElH7fhVa3sNjmJUFcuu5q7hqVUrnPXyIyFsXQf2Qd0knsqmREUf+nrwst+X60IQSa+FTT1ROBeLCqQbs5sskncimQ95H3yqj0cW9fk+rj8wbHqa4W2aGSJmQx7jDfAZL0FnZDFozE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819188; c=relaxed/simple;
	bh=L1QGBWYOnkgU5csXw0kMCAB/ZdkrsTt8ha3G63Ktgzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gJXEZrt475cA6/u4ey7bI70HzBRsukHIIBXYR5cgnQkWRjUTWfwveqSxGLJKEx4lzvjrB9dF0SmUNTdc4xzOw8v2SpOLsovKj7yX2peA314z/+2VEL5PK4s4K6ybpCu3zDrc7Nqyp2LDcrHOZErQ04paKLP25a1Rtcfn/V435eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eirtgBUu; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KohpgCQMMeTTjoLmdyRb3wf+VGYx8GjAgi3jKVB087gTP26tUBvCnjrT6p1c8aWNOJVPqeKRx8AsOZwIGw8Xf8zzZa3Y004YcOHCZY2+gXby9vbzgjzRAqcCC7Wpow6w3WNpfHACIQdRI0g8qkI5xlGWMX2QfIvka/2BXRH0fApRXO0YidafG7uKP01Q6cwLinRuWmxpVA+lO/xl1WPHela/ztUoaK7yTC3Z3sJ34nej7fCyzvjE6uZ7cQoZDLGiTuDE7IpUBTY7SNi4vq0vtq0CgM7k0ifTq9/0OUUs0knkOXSDGABgcdiiXgN6QxlqdzJ98LoMLakbEaEtwmtyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Phw3KGbO+C9DA3AUfvQ3QzPLNfyDQku0ErMjHLzDKww=;
 b=VOmD+NyFx5/4NQFqptS+W2hxPf1rT/YymWwYx1q8Cy2GTssywLvxLPAAxny7rmB7IBtyrgXvKa4HngYCHq7ybZGUcXwIVj9qjxBZuMI4vyhaVQM0gHZEPbDwyNtSetEpkPRp+ZFpGLGNpb3gP08nCtytR5+0sX3rMi5MMxoFjzGTUqSWTvzwPudEjdcmQ80o8NNF4ewRZSyLMw5Je7VMC+kezK3ZL89NmZRaUputm4d83YkJCdYJort3YSg62k79NxAknTiTV7WLDYWi6pjzMzFP9PQdaSehGX4TJkSRQR4bde2oiqr8kb+b5HMhAz10gl/K1fFkP8gmdvr1BLJJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phw3KGbO+C9DA3AUfvQ3QzPLNfyDQku0ErMjHLzDKww=;
 b=eirtgBUupEAV1wOAIr5fN20tvyodiInMbJqvVUDtcPrKs6UF/ua0YkOKECRw7LvIYLDG/M3vxSH9lwnn0rd4IZtN6eIgf/k9cuj3Wbc0b8rGpDz1N/xvlf/X10A1iDV2Etw57BQjF6xn8gS96UQDCXC/KALEvd/9LneZqq+Bvws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:19:44 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7%5]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 13:19:44 +0000
Message-ID: <5df8ff26-a834-7cf2-0a6c-fdca2af35437@amd.com>
Date: Tue, 2 Sep 2025 18:49:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] cdx: Fix device node reference leak in
 cdx_msi_domain_init
To: Miaoqian Lin <linmq006@gmail.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250902084933.2418264-1-linmq006@gmail.com>
Content-Language: en-US
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20250902084933.2418264-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::12) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 48aaee98-029e-496d-db55-08ddea2361a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWtPaXNJZTZJc3BWTzYrazUzcExXUmI2L2hRTDQzOXh0NUdCMDNkaDRBemFT?=
 =?utf-8?B?SGoxTlVTS09VK3UyaTRhVHRFaFV3UWI5YVc2Q0FFemJTcVRGTkxiaERadjA2?=
 =?utf-8?B?Y25QQmFVL0JWNmVYbml4bGxmR1JKdE1pdTE0NDU0TWFqWC9yRHhtVGN2STN0?=
 =?utf-8?B?aElvbWY2S3FCeVBNL01SNHdmTGt1V05adzNBZmsvM3pRNmhnUk12dWRmRGNC?=
 =?utf-8?B?MWV4UDhRU1hEZFMzM0dUTFFVMVdkMjFSamx4NWFmYmh4dGg0cUtjRVZDNW14?=
 =?utf-8?B?MFhvNFhCRlRmeGg4YVdwcm1WU3RrMzhldlhIV3RkTU1LQWtSS2VLTkJGQlJ5?=
 =?utf-8?B?MHpvaW1iUWhmamNXdDFHaXBueUVRaEtjcHZ2OGx0S3J3UnpXZ090c0NteEpR?=
 =?utf-8?B?NyttSkl3Q0ZzSUJtZG81dmZXUWNpSmJ6TnRPQzhqeE4rcjRCK2YrUUI1QUxQ?=
 =?utf-8?B?YU1BSHlRN3BoY0ZaM0NKbUJYM25jSXQ5d1ZjRktCN2JGaUU5YUNpenFyNjgw?=
 =?utf-8?B?Y0VnR2xBOTJkRlNKNnZFRE94aXNaTGlYRUMrVEFEV3JVWml2d0ZvWkdON0Fv?=
 =?utf-8?B?TU9LYnkvZ2F6dU42eU1kcnpXL25nTFVwNzN4cGJPTUNyenpta2M3cTdic1Fx?=
 =?utf-8?B?cVNNcmVsOXJreGoreTV3eStDVnphUzhONElCMnlwS3lEMzVIL2hvQzlHM29w?=
 =?utf-8?B?S05DckQwL3VtNzZMekFGOTB4MldQWGIyL0x1bjliNzRHMzJJWFBHUVczeGl1?=
 =?utf-8?B?MGtldTFLcUVJN0JiZ0dwQS8yanc5T25BZXhja1p6aHNmSEhESmNudjNnQWdT?=
 =?utf-8?B?bkh1SUtvcnF1bnBURGZTWjhhSjNTdU9JRzB3aEZDb0F1SktoYlp1bmhHNlhF?=
 =?utf-8?B?UnE5dzRtcVpKNWJXYWxSWmd1azZjcVpQLzVCSXU4WkZUV2ErSm9BY1VPZ0NV?=
 =?utf-8?B?Zm9OVkk0emFzMk9Tby9pZzNnVlJjeUlaQmg0Y1VVS1hEdk5uUVZaRDFHWm5L?=
 =?utf-8?B?L1g0YmMwWmo5MHBCSXJjK0ZrdG9GcEQvQW91TkdDbmV0bUJIMEhKWFllSXdU?=
 =?utf-8?B?cXNiT0ZRMWNQbjFZaDN5T0NmM1JpRUVEZnlEeXNpdE0yR1BZbW5ZZDZ0cDd3?=
 =?utf-8?B?c3JyVkZVVHR2a0I2VjNyMmg3dllLRzRWVkxYanRWUjFUajhzQ1YyT2NaeUFD?=
 =?utf-8?B?ZkVxVXJUd2doTkFqYWVReTNpMW1wVkswTmJvaWFEeFNwU1c5OGdzVE5CenpV?=
 =?utf-8?B?cFFOeUg2d3JUbXhob0lOWUhkbnpuZVBjOGJtYTA5cE1mM0pkUnpBSXBqYWVj?=
 =?utf-8?B?R09WM1lUM1JmK1h5ZkhJRVFWVnBjM1VzTW8zbjI5SmJtSUlnU25icVlRWVBL?=
 =?utf-8?B?bGQ3ZWllR3ByNjZRQkpzcnZ3N1krNHh2YW5TQUVPcmY5T1Vrc0lPWlpBanBh?=
 =?utf-8?B?L0RjMWt4UTBMTDBXakZHUjR3dFdhNXpLUmRic0RMc1dva25aT0VhbEFLR1FX?=
 =?utf-8?B?bE9IYUtPTmg1cnYzeEovdyt6aEpRbzNEM1ZEdE1nR0lqK1RUNzl4TjZETXcy?=
 =?utf-8?B?czgyem1rMWVlTjluUWFVK2NvSVJCMG9JY29vZ3VsRDZGMUZqd3k2NFgwVVhB?=
 =?utf-8?B?ZDhEU3Rvem9ieHpZY3ZzZEtaOWdMK0RXa045a0dZU3Q4YXc0UUpvUTc4MnZS?=
 =?utf-8?B?NWhGbGJuQlYxSUdtb2dZdHhxc1pZWi95WUNORFpqdUM5N1hUc1o4cDdDblhF?=
 =?utf-8?B?SWRSN0dEL1Q5WXArcGUzajhjWVM3dHoxOEZxQmVKYW4vWngzYmRzMVdtSHJj?=
 =?utf-8?B?cHBCSFVyK3BxNVVRS3AxM280bm9FU3VIbWwwSFphdFhrb3p0RTRoK1hUWnVB?=
 =?utf-8?B?KzBQSkUzWExrSEJQUmVXZkhQM2Q2c1dybDVUVE03MWkvcFJOdGxEOFo5QUtn?=
 =?utf-8?Q?/ENkCyK2H0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0xnNU5HRTFDSmNCQ1d2TnptSXhVZ0JzczU4V1ZmdFZVd0M4Z0ViaTUxb0Q0?=
 =?utf-8?B?VFlieTFXMFY4OUFSajhhWkw3MlpVYk4xNTdVK2ZFUU1EbjdUa2cwMTNKZW1p?=
 =?utf-8?B?ZGhwbWR1MEZSRlhSVjdFbk4yT3dFNVhtbEQ3bUZGZUJxQmdBWkE0U0s2a1Y5?=
 =?utf-8?B?RHJFZkMvL1RyQ2J3WTZiL2hUOGxxYlYyS2dieWpMaFB5bE9iNHlLemlaRUc5?=
 =?utf-8?B?VWdIS0M2Vjh3aXkzU1E1VC9CTEUzdmoxeVVqeXZXbUFieGFzSFk3RUdVbURG?=
 =?utf-8?B?dkNZdlJERnYvTm9PeVFKWGxpYmpWUFF3Z2pEVVYwN1pWZ1VRVjV3cCtRZXRZ?=
 =?utf-8?B?Q0RCTVZxem1PVms1TERNK2VNUzMwWTVNZlF5NHcvbFVBWS82dVBzQ1U2SXho?=
 =?utf-8?B?dkZZUjR1dll3SEpndk9aV2lUNGpZc3VLSG5VRVBoVlFxcGtWQXBTdVJJMmZF?=
 =?utf-8?B?YkttRjRvWE5yall5emd6U1JiQ0ZkS25PR1JnYnFDd2VJQVVIRVp4djVSTG5Q?=
 =?utf-8?B?dHBqVzhkNjkya2Q2NFMvZGdFZWlMYUkxSTJTYVNsSE0rbHZJOTQ1VzFPVkhN?=
 =?utf-8?B?ekFHdzFUTEU4V0dnUWVmK2w4b0hiZ1N3U2pVL2dwdEhDWlA2VmJ3SGk0QWxF?=
 =?utf-8?B?Ymlha0gwMU5xSi9yUXVGZjR0SmRsUTJlS2xRamRNZUpyUHVwbWQ1eFJOUE5x?=
 =?utf-8?B?RnB4cmYxajRJR0x0OXNDN3Z4YTRCd2xBeEszWmg1WnZQczE2VjdkeFV5K2tW?=
 =?utf-8?B?bWNrNm5ONDdnRUdWMFVwL3RvRDFCaGpqaE1lalQyV2FIOG84cElKQ25zNmxS?=
 =?utf-8?B?T3NtRmV1MEtmSDVERGxyNDdQYzVSUkx3Y1laSUZLYVpHVVlwK1lQMWtwdWNZ?=
 =?utf-8?B?Z0pCQ2JKQ290Zi9veDMrcGxKc0ZNSDZvaFhRZFdOcDd4MGdtclplcEMraUtJ?=
 =?utf-8?B?UlllNlBTaVNTYlN1L1NNc05Sa3RUaEthbnVWd2MxalBwOVpxd1Zzc3hzVlZF?=
 =?utf-8?B?RmJnQ0hENWNUTDErQjdUTDRGWWZOaFNmTHpSMnNCYk9BZVlhWFUxbzc2aTM2?=
 =?utf-8?B?dWJ3UWtaYW1LRkgyaTZITjlsajgxV3ovN0txalIwcjhqY3c0NjRaUGtZOXVK?=
 =?utf-8?B?MU1VaXlaNnBtcytaMk1vRDA4NnRQM0kxd3VvdG9kaisyQlAySnA0YU51VjFz?=
 =?utf-8?B?SHlGdUhJR1U3YjBrVDUyV1pycnFKVGljVkZyNS9IaWlUUEhRM0UwSXRjSHA3?=
 =?utf-8?B?U24rd1NpMDFCSEYrZE9zaFBKVm5TcHJnQUlIYXZIQWxmOXR1OXFrcUhVV24y?=
 =?utf-8?B?WnJtSFQ0SkpQVXNMVUpXZ0wwV3JUVm1Yd1RuK0RpekIxSXN3QlJTTkd0N2dw?=
 =?utf-8?B?aVlQSzBxUTkvV2FvWWdUd20xbjNhMlBhM2p3WWpocXFQT0ZUZHRGQ1ExOE1w?=
 =?utf-8?B?NjIrQjBNdG05NVNGU00wczU2L1M0UGEyWG8xMXFNSmJTRExpc3JOSzBnMmk0?=
 =?utf-8?B?ZXltdjFoYlUrTWw5SWRianlNM0hiMk9IRkZPSXRhTFMrM2dNRGE1NUhOc09x?=
 =?utf-8?B?a1h0VHZad0NQaE1KMytBQkxJMHBHN1ZaaGZxLzJXaXJBK2dFcjcxS1c3SGpk?=
 =?utf-8?B?N3Bab2YwMlgzM3grbTV0bzd2WTlMeUFacDdvSnBTeXIyWnljcGNiTkVranha?=
 =?utf-8?B?RURBcUgyWTE1bWllWXcrK2JabzRYNzJlUndOczhYRStpY3IvS0lJRTdCOWNC?=
 =?utf-8?B?Z0pLSnVGQW1CLzc0Wms1YktldEZ2cEFndEI2aVZHQ2JURXBYYlNHeHhRN2My?=
 =?utf-8?B?QkJ5aTVwOEFha2pnZTd1djhSRkVOUE4raURzMjFiT0lwV3FmN3ArV2txYkhh?=
 =?utf-8?B?QXF5dDcrYVdKdldtSWw0SFRFa2NsQU9jNnNuN2RZbFFzV3FYc2RjL2k2c3hN?=
 =?utf-8?B?clJRRVVlNndTeGZETFNZR1dsaWNJK1B6VURVNTUvWWdtcVZ0aTdaaUY5RCtQ?=
 =?utf-8?B?bU41eXdlMzlXU0tEU2kvaWZYalN4VDlteUhJUW1rQ3YydVpFQTkwVHZRZDlX?=
 =?utf-8?B?RDcwSEhrdllFdXBIQ2ZhZGNZaXBYaWNUSy9IdDB5dzhObWFIbXNCais1N1Nh?=
 =?utf-8?Q?uSSJ+dX87vNBWHQJTKWKqHh1d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aaee98-029e-496d-db55-08ddea2361a3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:19:44.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsohTSlMhMH3rYN5/2wY3F5tmGOocvur1xlyJUEJM02T585O4ERyL8fOU0raBJv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318



On 02-09-2025 14:19, Miaoqian Lin wrote:
> Add missing of_node_put() call to release
> the device node reference obtained via of_parse_phandle().
> 
> Fixes: 0e439ba38e61 ("cdx: add MSI support for CDX bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Acked-by: Nipun Gupta <nipun.gupta@amd.com>

