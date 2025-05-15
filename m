Return-Path: <stable+bounces-144513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDFEAB847E
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 13:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2AF3AAA5D
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A2297A45;
	Thu, 15 May 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j6gUa+t4"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4C10E5;
	Thu, 15 May 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307039; cv=fail; b=kFIiNpRdEWZ/JI4pUxKKypjxg8eXvSBxA5kjE1qdXIuRgWWalrQ4n/i8W23+2GbVKrzuAdQsqiBYZzhqL1iRSD7BBOVrhXRYElvtO436wOjajHpmbUE8l1F+DNBT6DYbsuVX7THuxYIuWb2HDMMza4iGJ9EsNr7qJPGEzGCJUxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307039; c=relaxed/simple;
	bh=mJj+BmsVYtV0TLoHyNeh1HlZ59MH7Mh6smnkyArfzyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I1TOywh7MdVwyr4nZai/KDvTNBd+oLUOwuktzPItg39/TFDtGd1SYzYesc6KNv2XV+LSlFKwdZaSX1pNdoFdqVpL/QjkHQG1KE2WAsFDt5VJKK0+Wgey5d766BNS//p3p42nl4+tFdmcSPE3JOIOdBLuiTB2gIE2iAzup8FVCvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j6gUa+t4; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFYpWKvE+IibmESuax/w5hxUlK1+UnEQxLrr7ncuhJXXay1M/7uXbMu+sFjEaK1tjBNkKrtWEz13cuOvafdNwBrprUsoTR5thrOkeH5kQCCD3NBoITtxSZamncQXgPyBXNQg7yNLScrMK+EVSl18TMJJe+h6p93FK5VykAQQfOGZeb/X2/EihTQxtSCh/AMQEiNG14mM/5J37e/UHf4bxrn+509RRkgb8f5CtBxz01i2ybHRJA+k1HnW1dhhF4n9qNr7AIWHrIP90iHnuNCaHoWgFVrPf6+fhaTWHFr4oRn8fnq6SufFgjT099vKSaFpULmEQrjxuAw0B3tYpFfq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7L0l+9RJki79J+Y69Z5Ri/pKuIxnWFk13+3E2FVz+w=;
 b=VYCMyNGB3sA2PVuuxWxhpnIDV40KkPHpQr6qQbKcanTRljeYEX4yHRiwUNVPh+fchGbOZHkSoPE7BN8RON4EfMtQUKY0AzpePdcHr3oh4POYwb7UFleqWQ75kH8Kk9UgBYS32ucVd9YQy4zeBS4B7FrM+gNRCOVxKcvKLt9gLaOhviqgjSw+957R2SGYArUR26MVBLff/ep45M6MIOJmsK++3zpDr51/Ql2Yeqdne0Hjs3TtRrxpb6EFTqNZxW6oWKybg0edsEA3cKB2mk4o50MlylFo5958TzWhRKRvfjVuIzKEA+YbbEubLS3bJpumNBhrAvlXDk1LfBu14K/VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7L0l+9RJki79J+Y69Z5Ri/pKuIxnWFk13+3E2FVz+w=;
 b=j6gUa+t4YD1E51Dc5qIkPcAPvQ9sUcD5+tn6x0gQf9dmkYU/ts/PEECWFw9/FXv5M+Gtti5Bn16HkgG6kqiaBkuhnXfPzGJt+G69WKL8J+4mGCvrjWGAhEtPUf4DPJLxMPkQyfGVBXM0siuBvEDp/6tSyOrBs5/+BCTfxkK8XJ9omLGINpmVLUz91ZMXT3jFGecCzCVcrPKgZh5HqkTZib0uXQ7qoqVVNWK21WT8WKXEUDDJpPf5Pzc2/Z0SnPf5G5anektvdF1r3RHmvdX0QqZwcSueRNwEBuGWskz2E+p2mun/vTDYuUObSB6xNd8zk53CltKeeLIkvbCOPTz3pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 11:03:52 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 11:03:52 +0000
Message-ID: <b761ca95-906f-40f6-a51e-b9a1da379a3d@nvidia.com>
Date: Thu, 15 May 2025 12:03:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] phy: tegra: xusb: Fix unbalanced regulator disable in
 UTMI PHY mode
To: Wayne Chang <waynec@nvidia.com>, jckuo@nvidia.com, vkoul@kernel.org,
 kishon@kernel.org, thierry.reding@gmail.com
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250502092606.2275682-1-waynec@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250502092606.2275682-1-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: cf11f601-1f1d-4944-c035-08dd93a02d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE80T0luQU9hNnU0NTlwbWV1VkpuUDE3eG9iV2pYbEZKbXArUE9UTTFIYlRY?=
 =?utf-8?B?VThsbHlublhGOCtjOW5xUGZpMGFlL0tCMmFRTys0REp1V0NMZHF4U1o4ZlRN?=
 =?utf-8?B?cGRiMVlyR1ZoSWl3Zm5YcU94WExxZUJvZE52aWVGTG9RQjAxUFNXUld3U2tj?=
 =?utf-8?B?YjJTVG5qYjFFVzJLcjYwdmxLejAxRTdKZlgxazJaU3dmQUNqY1BvUUw1Y2Ja?=
 =?utf-8?B?ZkdtMzJkVW1TQWI5SU1BcjU5UGhNR0xFOHNpZ1NsdzExdVFadE1kS3RvWDc2?=
 =?utf-8?B?U1RVQUNSVzd2UmN5U2tWOUFOMklHbW1ld0lwaFZUNEhWcS9sZkxTdFFGVzVP?=
 =?utf-8?B?Z2Q3cjJIay9ZVXN1TmhPOGxJUWNiaEhUaGJ1QVBXZVRHSHdqMnlidXpxSU9T?=
 =?utf-8?B?czZWWjFLM0o4SFVHdFRYVGRhd0V3d0tiS0FTQnhaeDViZ0NQa29pa3JCV3Y0?=
 =?utf-8?B?eUM5OElTVlpiSk1QR0JJdXZhWkRjZFF2aWNiNjU1dHRSWjRxNDRhOU9oc0Zl?=
 =?utf-8?B?dktCUnlCNHhkdXNURXVMc2RzNFlkZDdDT096YmVNc25yWU1MazZYUkovaVl6?=
 =?utf-8?B?Q0VPVmZMYU83Wm5ETVQzV0thRmE2WExXb3R4K2Fhbnl0RHFHWlFQWFFkVHBR?=
 =?utf-8?B?RHNUZ3hHdWNxajF4NVlsdTV6VU1qNXRIQUFINlhQVnJNTzcvait0QUxYN2xC?=
 =?utf-8?B?VHJkS3JOZ05XeHBQN2l3N1NFY2hiRUhvUnBUc0tQdW5GR2JMaFFaNmx4MUZB?=
 =?utf-8?B?Mm9HSGZEdWlpWFNMT1NVdGVvUmFvWDh0YXdYM29OUkc5VDZrM1RaMHRkaUlo?=
 =?utf-8?B?OU0yVnc0ZlBmTWxkUG9YRmhzNDZyaDFuVktOZzNhZ3lJYnREbWNpSmtqaFkw?=
 =?utf-8?B?RWNocTdkV1p1OG93SmVZZU93eUFlTjIvK3FYaUZqa2NCc0tyeDB6S0JnNEZV?=
 =?utf-8?B?M2pVZWxMY2JxRU1pUFJtRmRBR2JBNzBpZkF5UmxOVVhYQmtML3lxbCtPb2t1?=
 =?utf-8?B?VTM3TUZrR2srQ2RycXJHUkVSU3d0cGJlaXF6RlU0SXlxaE5Ta0xSRHlzZmpk?=
 =?utf-8?B?NVlrODhlRi8rNk00VUw0MzJmSHAyS29nL0FYclpNMW5KTkpnelc3U0NLKzdZ?=
 =?utf-8?B?RkFDMnlQenZ5aDl3QThzM0NpbGxiOHVad2gwaUpQZFhBYUtpRk5QaFdkTE9q?=
 =?utf-8?B?c3l5R2NOVThmb1BZdFNtSlVwSWJDRWpPejk1Tjd5OEdtYjU4TnFrVG53MVo0?=
 =?utf-8?B?OE5VQVRKOU1XNXlwaXYzV1RkaWh0cVlNdFdrbzhnZEZmZWZvYlYrYmVDdHBX?=
 =?utf-8?B?M01yUEhhckw4eURKTkE4SUhnNVFDNnJpMWtWTlJEbFU3U0ZjVjhKajk5T1Y1?=
 =?utf-8?B?YjNjR2dwS1NCVXhKQllCT1FLaVZQQXRPdjdpQk0wNmxUVlFZeFN3R1ppVWJv?=
 =?utf-8?B?NnhIOFI1NzJrc0xhR1Y3anNBdHFRcEM0SjhOWmY0czV1b0lablpLQlduTDhB?=
 =?utf-8?B?TUhNbmpSalFmUHFZS2ZqdVBwNGpsRmhuMTBXaVFUeFlJRUQrY3JSYzJ6TUpG?=
 =?utf-8?B?bi84WW9TY0ltMTdDd1NxeFhjK1ZJS2IxdkRidGJ3Nk12R3ArK0txeEJ2Z1ZW?=
 =?utf-8?B?aEdMc210ZjlOTW9oK0srNStPbmx5RTAwYktxM3JHRkJwLzdzKzc2ZjYvSXNV?=
 =?utf-8?B?NUg0dE1VVUIrT3ZYQzVGdWlFQUU1SlVVaXBoMkxSZVA5dXdzSEVPWEc4OG1r?=
 =?utf-8?B?b2Q5NzRQWWFRVkdQeURTQ0JXNFpHcUdLc0VTZ0lWbjE2aGpKVzVkMzhuWHF2?=
 =?utf-8?B?N1BOdzJsQmhtSmxDMGhGTFpyWVRaNTBiSWpRUFFpZjE1MFY0VDF3SHN4bzhE?=
 =?utf-8?B?Q0JrbVBwdE95TndNblIwd0lFd01ETnFMVFdKYzBuVE5GcHBlM085Tzg2SWNH?=
 =?utf-8?Q?hFibE6QVYYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEhaU0psdndHdVg2VjNBS0dUQzRIY0REK3ZZWkgvR25MbUVtODhNRGxtYWRL?=
 =?utf-8?B?ZzRuS0sxbjFCcjBGNFM4UXFaYTJ0WVZma1I4ZXVQWU02L3dhdUI2OVNVMDd3?=
 =?utf-8?B?a044REcrdWR1OFRQWitON2pZNjg1NGhRRGcwOFZGNWFia0IxSEZLNHZJYWpi?=
 =?utf-8?B?Z0IzM213MHZPbllPbEJmWERxOUc4T1ByMUtNSWtwWmNrVklDdGNXdnROSkNu?=
 =?utf-8?B?a1B4cnVwcVh1eHM5Z29EWThqOFc1VnBMbnA0M2tESFVOeXhNOXlxN28zTWdD?=
 =?utf-8?B?WEJ0TEs2ZzU3STVVL0dDZi9CbkxtUjlteHlSRXNHL1h3Ry9zeGNtdGdIWk1Z?=
 =?utf-8?B?UVQvc2ZEdUdqdzUreXhiL3N5K0pVeTVJYjh0OE1TdXo1OXk5UytVMFB3TExQ?=
 =?utf-8?B?USs1MHB4MlZqSGlTSjc4ZUNWZjVPQW1zV0hnRHoydmVpTEZDUXFra3ZJL25s?=
 =?utf-8?B?aGhNZG1hWHR4Wkh4V0JNblRLL0UyWC9yVEZHSXZ0cGM1WFMwNHAwd0Z2Uk16?=
 =?utf-8?B?c3loUzcxczNIb2ZlZjdkT0NyaS9QdEVVRkFpcElqb3JlUWpsQWhkSnl0QlNt?=
 =?utf-8?B?aXRtWkNEbzZpbSsyNXNRNWRVT1NFcWE3ajkwZWV5WUhWOThaMUtYSDhFdnAy?=
 =?utf-8?B?OW5sWHQyTG5vREVjejU4YWtaNnJjWTFubE9ldmJCR2lkdTIrb05tamgrakR4?=
 =?utf-8?B?bjhFNkRDWkhGSnl3aE9SZ1dCMXJlYWRxcFRzSHZlYjgvSVNsMXNPZHl5MTVh?=
 =?utf-8?B?dnk0bDVseVE0M2NOZEJmMGlnZXJRQlkzL3p0V0ZqT2lQTVJVWTArM0hxaGtm?=
 =?utf-8?B?LzZBYWQ5L0pNdUJxN2MxS2REMkQrc20vWDZROTM1VDdGanI3NDNCRHg3TzU5?=
 =?utf-8?B?WTRId2h6aHhHVnYxVHFERkFrblU3M2UrUmpTN1VOczFLcWN4b0doNEl3cTRH?=
 =?utf-8?B?NWhxUHNvQUdCUVN3SldvaUxCdEdOVTZ1WTkvY0M1U1pqV1RiTWFjOGdScGRS?=
 =?utf-8?B?NzZhTzBpWUxuZmFyZGc5aDVDNE9zVE82NHVuSjQrWUNnRFA4bU1HQ003QWFh?=
 =?utf-8?B?MGFTVWNWK3hSeEFFcEMvYUJxbkJLYnpWOERqV2xIaHRvMk43ajlUY0NqeG8z?=
 =?utf-8?B?Y3kzWWRpeWxLQ21HcmFXZEN4V0Q0V20zbVhtTzhhTG1DRHpUcXdxTktyWDNh?=
 =?utf-8?B?WEJneDBtcG5JWmd5OTdzeURjd3pyMEpxaFQ1c0FmUWdYNnlIWk5Ia2hjVlFv?=
 =?utf-8?B?UWtkbmFPQytmOVJpMVIycGd6dXFoZGJyQURxeEJVRys2dGJaNFBoejArVU9n?=
 =?utf-8?B?TFlITXNsL2dPUHZta2Z3aUlBSm1TemJ0YVNVYnd3QXAyYUl3OWZ3OEFvaWlF?=
 =?utf-8?B?cWdCbmhXaC9jQTBUYTcxN0VGVkM1SHpNTDNqSkVPVHVBS1Brak1SVTZoVEE3?=
 =?utf-8?B?Z3doTXpTaUpVTkdnYUpSR2VrVi9XSVlaQ2NrSnI0Vm1IdWhGRkpPSU9CaFVP?=
 =?utf-8?B?Zk5VRmNleldvME5mM05rM1ZDK2JGRFFrRGkzYjh1UG1WcFZSbFg0ZCsrQW9U?=
 =?utf-8?B?NnB3ZjFNUUN5S2JCditlSG5SVkVkSk1RWEZGTW52VGpha0JwcFhmQS93ZnRi?=
 =?utf-8?B?ek55NzVlRTgvVVFuLys2eWkwYnRvMXRpbVVERVY4WGI0WUVDK0pyVjBkL0ZE?=
 =?utf-8?B?Myt2Q2ZOOUlRWVZpRFpVZWR2Q2tLbGkrS05lTStDMFJGTlBZVlZ5SGQ1UzZq?=
 =?utf-8?B?TDdnSmxqN0daYTE3N1RhbFMvaTdPNE11UTY5RFBCUE1yZGxaVmQwbG50bVFU?=
 =?utf-8?B?UDQ5RWlkeXcxeXN4bHBnNWZQejhyL3R3NXJlS1BjR29CL2c0N1prSW9lYitJ?=
 =?utf-8?B?MCsvemxYeDZ1SjVCZm1TcVdDWUhVcFM4b1ZwdFJUZkdHSjVHRmFBcmk0aEZI?=
 =?utf-8?B?bm9ZUFFZZzEwenZWSnVPKzBDS1grcVF5d2xZSnNydnMvZFkyOWIvNkNlVDBO?=
 =?utf-8?B?dm8vVWJRZkM1ZEJIV0EySFBvYlFJN0RnMlEwczJSa0dMaEl2aVpBRWttREkw?=
 =?utf-8?B?RVUvbnptaTgyWXNaeWJ1T2Vzb0xjN3pIcTUyWFd6TmV6dWpuSjNNdXVLTi8z?=
 =?utf-8?B?am9ERDZTOUJIdlZUYU00bVN0NkVwQm16ZkVxUk15VUZQUFJhUWxXVk5NY1R4?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf11f601-1f1d-4944-c035-08dd93a02d54
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:03:52.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2aLP5hgnlExoQJYxp/lLe0ISxmvCqz1gHTaYhuV94HlhBhQxuhiZREpCFhnv3hNsKU3BIwLi3Qc6No7QDaujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089


On 02/05/2025 10:26, Wayne Chang wrote:
> When transitioning from USB_ROLE_DEVICE to USB_ROLE_NONE, the code
> assumed that the regulator should be disabled. However, if the regulator
> is marked as always-on, regulator_is_enabled() continues to return true,
> leading to an incorrect attempt to disable a regulator which is not
> enabled.
> 
> This can result in warnings such as:
> 
> [  250.155624] WARNING: CPU: 1 PID: 7326 at drivers/regulator/core.c:3004
> _regulator_disable+0xe4/0x1a0
> [  250.155652] unbalanced disables for VIN_SYS_5V0
> 
> To fix this, we move the regulator control logic into
> tegra186_xusb_padctl_id_override() function since it's directly related
> to the ID override state. The regulator is now only disabled when the role
> transitions from USB_ROLE_HOST to USB_ROLE_NONE, by checking the VBUS_ID
> register. This ensures that regulator enable/disable operations are
> properly balanced and only occur when actually transitioning to/from host
> mode.
> 
> Fixes: 49d46e3c7e59 ("phy: tegra: xusb: Add set_mode support for UTMI phy on Tegra186")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>   drivers/phy/tegra/xusb-tegra186.c | 59 +++++++++++++++++++------------
>   1 file changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
> index fae6242aa730..1b35d50821f7 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -774,13 +774,15 @@ static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
>   }
>   
>   static int tegra186_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
> -					    bool status)
> +					    struct tegra_xusb_usb2_port *port, bool status)
>   {
> -	u32 value;
> +	u32 value, id_override;
> +	int err = 0;
>   
>   	dev_dbg(padctl->dev, "%s id override\n", status ? "set" : "clear");
>   
>   	value = padctl_readl(padctl, USB2_VBUS_ID);
> +	id_override = value & ID_OVERRIDE(~0);
>   
>   	if (status) {
>   		if (value & VBUS_OVERRIDE) {
> @@ -791,15 +793,35 @@ static int tegra186_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
>   			value = padctl_readl(padctl, USB2_VBUS_ID);
>   		}
>   
> -		value &= ~ID_OVERRIDE(~0);
> -		value |= ID_OVERRIDE_GROUNDED;
> +		if (id_override != ID_OVERRIDE_GROUNDED) {
> +			value &= ~ID_OVERRIDE(~0);
> +			value |= ID_OVERRIDE_GROUNDED;
> +			padctl_writel(padctl, value, USB2_VBUS_ID);
> +
> +			err = regulator_enable(port->supply);
> +			if (err) {
> +				dev_err(padctl->dev, "Failed to enable regulator: %d\n", err);
> +				return err;
> +			}
> +		}
>   	} else {
> -		value &= ~ID_OVERRIDE(~0);
> -		value |= ID_OVERRIDE_FLOATING;
> +		if (id_override == ID_OVERRIDE_GROUNDED) {
> +			/*
> +			 * The regulator is disabled only when the role transitions
> +			 * from USB_ROLE_HOST to USB_ROLE_NONE.
> +			 */
> +			err = regulator_disable(port->supply);
> +			if (err) {
> +				dev_err(padctl->dev, "Failed to disable regulator: %d\n", err);
> +				return err;
> +			}
> +
> +			value &= ~ID_OVERRIDE(~0);
> +			value |= ID_OVERRIDE_FLOATING;
> +			padctl_writel(padctl, value, USB2_VBUS_ID);
> +		}
>   	}
>   
> -	padctl_writel(padctl, value, USB2_VBUS_ID);
> -
>   	return 0;
>   }
>   
> @@ -818,27 +840,20 @@ static int tegra186_utmi_phy_set_mode(struct phy *phy, enum phy_mode mode,
>   
>   	if (mode == PHY_MODE_USB_OTG) {
>   		if (submode == USB_ROLE_HOST) {
> -			tegra186_xusb_padctl_id_override(padctl, true);
> -
> -			err = regulator_enable(port->supply);
> +			err = tegra186_xusb_padctl_id_override(padctl, port, true);
> +			if (err)
> +				goto out;
>   		} else if (submode == USB_ROLE_DEVICE) {
>   			tegra186_xusb_padctl_vbus_override(padctl, true);
>   		} else if (submode == USB_ROLE_NONE) {
> -			/*
> -			 * When port is peripheral only or role transitions to
> -			 * USB_ROLE_NONE from USB_ROLE_DEVICE, regulator is not
> -			 * enabled.
> -			 */
> -			if (regulator_is_enabled(port->supply))
> -				regulator_disable(port->supply);
> -
> -			tegra186_xusb_padctl_id_override(padctl, false);
> +			err = tegra186_xusb_padctl_id_override(padctl, port, false);
> +			if (err)
> +				goto out;
>   			tegra186_xusb_padctl_vbus_override(padctl, false);
>   		}
>   	}
> -
> +out:
>   	mutex_unlock(&padctl->lock);
> -
>   	return err;
>   }
>   


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks for fixing this!

Jon

-- 
nvpublic


