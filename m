Return-Path: <stable+bounces-136623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FEFA9B871
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 21:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAFE3BA83B
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F028F52A;
	Thu, 24 Apr 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e5Tm2+xg"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDC5695;
	Thu, 24 Apr 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523937; cv=fail; b=mz+Yj8jQ5dZO9G9B3WCg0D1Yh/T1Zlp0O7UAj+EwOu7UisIXkxs3e7xlVmT6eoxY5MkAfb7y/whbCVVpgayrH/0PC2M6QadF6kOvVk7rDj63HwPYn05mx9itXpIFA9gYCUb0yV3mWKPEP+s5HmDdT6iczz2jL2YrGrAXd9+CM1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523937; c=relaxed/simple;
	bh=Yf/r+CKgmKFpUhRKIQKq7W42CTIXAbW7/r9N0E/ot4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvMbDISMu4RfKDvR5wPAKWznoF/uc/FCiSurvUWWsnhWsekxptj5j3hnDz/BidZHdwfr0GH2aEQ3cqgY2TB/f4Dts2Wl1k0Ih2DUkukz/6rCdwjfu4fveSczIzqtpdzqWJcHkrZV2Yeljwi35+l/5ShftlO1fJajrYaLgLvQ7TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e5Tm2+xg; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dP731TNgyofq9yX0xGoJjFSDKNL0j+51mrSBf0K6BgCCwxdlzGAYve3pkrA8FtO3rrXDXp7qHMioFZzrUSR8NQnJq/Zr5d/Nv4fh4oPEzA/Hz2jhBxJ2XE9HfDGavIDkzhkl4NXtIOfq2mjv5gANEJIWrqT5Txgo225wu5OE9gSU3rGVeTeYPFgr/QBZWm/vSiFmvfYjkQmgPQaBRurjhPau7NSuGq7WUs1VjBGiWr1f4i5aiW/1ax67xvxavsTXwFX/83YlwWEVO7ifixfWE3WRdsQTPCkajojWzY+NzqH2JJ7P0KQD9m92Pfg8N1HcbES0jg4XhRaCbQgzzgZ8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6UKRl7YoQA5gPkIkrWbiHV3KCUGRfBssUtS19iBV+Q=;
 b=WGk7/bpzZPC+nj8Ip1SLMvwhT/c/vba4LfKmiC05k+0AMsdBa6+wZZnOrCgrisTetKfB8Zt0LZz39qBNXoTr6TCU5wJ+2Muj+A0j2BM6ndZazpdzTowKAMcNdf82HsUZvJj64PD/v0hnz8rjQuL4EslusjkyLttuJKmNEcCyduVSTKNtwYka3lHCVe95Y9BiBpXfsbhA6IC3Z1hINadcAfo6b0Ve3ERrFmjW7IMj9OPxhY8ymmF1yr0PnfGDSyio8x29o8ETfriXtPfTSkmKXwtaUmZH5FsmUlpmQddKXCmNHei21HgOVZ5JGJbfn581t3xW3P4eyfTJfPZrXHtMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6UKRl7YoQA5gPkIkrWbiHV3KCUGRfBssUtS19iBV+Q=;
 b=e5Tm2+xgrijqiKq8FocG8XmUrtchjl9/kKs1SWT5EYMRjab8HvGotJpYS3T+O/1S0UoAeSKgRk9Clg0zylk/T/GHgNhvgGte3YaQhi6nKDwImsL3JjeutV+1wBelhipkvsw/NOEe+ybx+MSoYuKSLVj2IjtSBGp4MMLQC79z3po=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Thu, 24 Apr
 2025 19:45:32 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 19:45:31 +0000
Message-ID: <2ec2ec0b-0537-4502-948f-4fa725ddbdb2@amd.com>
Date: Thu, 24 Apr 2025 14:45:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Fix SNP guest kdump hang/softlockup/panic
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com, kees@kernel.org,
 michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 gustavoars@kernel.org, sgarzare@redhat.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250424141536.673522-1-Ashish.Kalra@amd.com>
 <20250424180604.GAaAp9jG7N9YyYeprz@renoirsky.local>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20250424180604.GAaAp9jG7N9YyYeprz@renoirsky.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::28) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 9633427c-89f5-4613-853d-08dd8368927b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUxaM1BqM290V0xUNTJyYWlLUTBFU1FKek93ZVRBYkgvb1pvVzRyaGV4alA3?=
 =?utf-8?B?bGR5QWxmMVRjVGZZcXZTTlduNENOWUxNejk0SmwxMXVwWVc2K00xbUZJdURv?=
 =?utf-8?B?VkN6ZWlVdElKUHo0TGJnK3dzK0J3K1pBZFlEbDllWUU1d2lxZ0x5YVIwVDZE?=
 =?utf-8?B?Wk51VmkwQ0FnOHp6MCtQTHBtRkNFNll3MisxbzB1OWpRWXBFc2JCNGx3REtP?=
 =?utf-8?B?YnV5VFM3N2RWVk9MY05jZW9CL2hVaXNxY1IzUHVNaXdDNEVzaVpwSTJxRE5P?=
 =?utf-8?B?RzZUWGt6dW52UjgvYnNzNDU4V0loaVBsY2pSTi8yaStKRU1TeTZMQTlCWGVJ?=
 =?utf-8?B?RnVGK3YycjdqUld1c2JHNnZJUnUweG51YjY4KzcySjRrbTIrWTVIRmpRSzU4?=
 =?utf-8?B?RDg0Y1BkNDJGSG9uck9vMjNJRXozRDI1a1h0UzNqaGhXTmVpK0lxZ0VFVnRK?=
 =?utf-8?B?bGdqTjFoRmVFVUJTYjNValJpWTZFSlBaWXQxNjl1SVhWSy95eGhoelo0aUNt?=
 =?utf-8?B?MC9ZMUdnV09KT094cVk5aXU1WDBxZHdqbkRVVHhMdHlSa3ZJUUU5OXRRRVEx?=
 =?utf-8?B?NGZXdjdNdlZSejd5b0t3Mks1bStxYXNsdDRvZUg5Wlo4b2hCNUNQK1NyVGxG?=
 =?utf-8?B?d3c0VEVJV3htaExOT05PTlJ4blZNdmcxYnRkM0FhZ1pqZnhsck9FSzhacFdP?=
 =?utf-8?B?Sk9DYWxGZzZrRTl4eEh0UjF4cDc3czlDOUxjTysweDNjakZ3UDFhNjBqUHVJ?=
 =?utf-8?B?NFdWT0VQVDRycmtmWmpzWmJBVVMvclZ5cUEyOUQ5QVl0dGFFTHRuZjRjNWRt?=
 =?utf-8?B?SXlKcWN4N3Y5VlpGazNrTloxcnJnZXRLMDBqVlpaMlc0Vk1ZU0l5SERlQ0Fi?=
 =?utf-8?B?MHljQXNkamFNZm4yZHlPcXloSE9IWXpKdFpUOVppcG5wV1o4MHY5TkVjUUQz?=
 =?utf-8?B?YkVvQ1ZXdURkM1FYaGk1WkovVVZuaVhiVjlDNmZ4STUyZWdrMjl2WGRmaHJD?=
 =?utf-8?B?VjhRdm1MSTJkLzBPMm1USXpkS2hxNGNIbmlnc09qVDVLek4vdUlvZkFYQmc1?=
 =?utf-8?B?TTdNb20yN3JlM1FhUjVjM1BoMzZrRmEvWnhHQVR0cjQrRTEreWxRV3dackNN?=
 =?utf-8?B?ZG9Lamp6eWNKTXpGa3g4RXh1Snk3TjUxeGtCTWpmK0ozYVpGVGMxNjZXU2p1?=
 =?utf-8?B?QlFzcTE5UlpDMkZYYmJNaWZEY3dwVmpxaGsrV05WRUd3Q2R4clJYV3h6d0tv?=
 =?utf-8?B?aEh6Z2JwUTk0VDF4RmFhai9SblJCbDdISkhQeDdGR3NNQjBSSUtqcXdEbTBN?=
 =?utf-8?B?VU05VjBJVHJXUjBWc0RwVHM3dUZPczVWRXEwZDk0dmNJVm9pRDREYXNxNUxQ?=
 =?utf-8?B?RXFzSU50WXVXRm9vM1ppVjBFMjkrUnRPdThFN3h3UStiOEJNSUQ2S0EwMmN0?=
 =?utf-8?B?YnQyVnZFUkNLeHdXYjBOQzZ5cC85blBuVUtEamoyeGRXZDd3WTJvbjZxZTBm?=
 =?utf-8?B?NG9MbWtpd0cxL3BhbzE5QmdqK0RiNWt6bklPOVhGVlk5aGx6emd0d2NnMXZ1?=
 =?utf-8?B?RDk4Tmt3ZkFPVW04cW9Fc0dkUkI2cG5MQytnSGJmV2lJWHZxL2hIWStSWVRV?=
 =?utf-8?B?dUk4T1VCZ2RONk9OdmErWklvWVRzeUh0eEhET2V0RnJXNUU3MnRhZ085bGxv?=
 =?utf-8?B?ZzBxRW1kUEtUV2YvOHpIeGUxYUtLVkxDcFZxRWMwdnVYUzUrUTdkYjlDNVV6?=
 =?utf-8?B?V0VESmVZQ0k4MDUrQU9rNkIxbmR0NlN4WEpPTHBhSUx3QXpaS0FFbmNvd1hM?=
 =?utf-8?B?ams2ci9XcnMvTU9ZQ29YenQ4Rk9ZTW9Vc0t6MHdubk8zQyszeVFDV0d1YU9T?=
 =?utf-8?B?aERzREVubDJaM0VaeU56U2gzazc5Q3JiYmQ3R2JKYlVBTVJUTzRDV3JaVlFU?=
 =?utf-8?Q?cWp7sRKDXxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFV6NTRlVzFBZU0wek1veGd4SS9saDZzd2hEOHFVQkh3TjlzeHlXdkVnNkpx?=
 =?utf-8?B?OFJZcWhjNWRva0huRXZvSTlCZUdPSElENzUydzVKVUFheXVORHdUcnZKb3NV?=
 =?utf-8?B?eEloSGNIUVhCWEcxdXoyNFFLaFZ2azFkeWFqd1dwaUlmVllOcXZqd3JvalZr?=
 =?utf-8?B?d0c0ZkJoNFFUdGVRRWlDbnppQ1Z3L1IvMlRKVjliMjh5b0UwYkdQY242aU9F?=
 =?utf-8?B?ZndSVFF5VXU4b1RTVzBGR0pjNmwreThyS3FJWlVOVlI4bkNFZko1azhWTkdV?=
 =?utf-8?B?WEdjWFJpOS82RllwS2pybkJzVGhleVdKdUJQc1FRZmUybSszeklMclpQUTdr?=
 =?utf-8?B?VUZLd3NXcDIwS0toVmU2TnEwUXdjQnMvQXdEVmtOYU1OWW9MVzVNcmpFK2pG?=
 =?utf-8?B?U0lObWpXdU1OMGdYMGlMVVVLU010U1phSVRicUdqcnQrYk5teFgzRm9PV3JF?=
 =?utf-8?B?UEU1TUxRcEhoNXZ6czl1NVo2ZCtVS3dtNlowaHd0TCtjNy9sTGdWKzJpZVJK?=
 =?utf-8?B?ekxLSUpCMU54ajVialhhbWlOREhKbzhkaWk5bG0vTFRYRzBnZldSMXBkaG9H?=
 =?utf-8?B?VjR4Q21Bc2lnV0R5V0pOZDgwVjJmU0tvMXE0SUUvOTdST3lTa2tVR1A3RU0w?=
 =?utf-8?B?ZVdneUZLemExQUx1RmNJTjdSUzAxdmRxcVlpbjVQYnNOQ0EwTzNPM29veGIr?=
 =?utf-8?B?WWV5aUdNdVFTK1U5Z1RiczdEQVRTWEpGdkgvV1lMbm54TTNZQU9hU29Rd2Z1?=
 =?utf-8?B?RkNkbTNGN1ljSUd2QS9LT2tVbHNvUUppWVVkTVlnYVYrVE01bCtVbkVHOUs2?=
 =?utf-8?B?YmI0YXdNQTJ3a0o4VFhSa3VGUVdicE4xVHcyK3pLWHpyV1NQZkwwNWJUbDZa?=
 =?utf-8?B?cUYzUFowSXlGTjc0S1JPRUVMdXZKUXRoanM5WWVoZkNYS2pNY1gxU3NnTlVP?=
 =?utf-8?B?cnJIT2pndG1GeWZaQ0RPcTArWkdTTUJ5ang3T0dnSlpGWHlYYllzM3hxakZQ?=
 =?utf-8?B?SW1QS1U3d3ZZUXg3Y0pjYmNjNmVDTFVPdEx5dGRUVmhzdzhDenc3N3pHYnVn?=
 =?utf-8?B?TUVmUW5DVlByKzIwZCt1cEhwUGQrMHdKODhCNnJqMHBuL0lWWCtkTElldWlx?=
 =?utf-8?B?Y3FraVlBWFpKU3hrY0FhMjQyRkFDTGc1WU15a2J2MDNSblZCc3ozQU9EK3BY?=
 =?utf-8?B?SWVsRXVwR2VIZ3hodkdTZzUxUmNHYjd4ZnVFMnF2ZEhlKzNuTFBTL2o0TjJ5?=
 =?utf-8?B?U0lrK0FKbHFYRlVJTXh6djVXMWNzUEZEenRmV3VENXpQbm5IMkZFMW5pRjhH?=
 =?utf-8?B?OTdPblBTYyt6ZzgrTjFVWnlGdTQxeVhvbGF0TkhpbjNyWXNlR2xWUThKUnFj?=
 =?utf-8?B?aXRjUHVCZVhGZTlFb09jZ1Z2K1UzcEVxTjUrQ3JXQTNjaTdTY0s2SWUrYm5y?=
 =?utf-8?B?RCtxdW5ieGhjMlBxSFMycUhVYU5zQnJyZ3VYNldwL0tuamVaWkptdUdhaWZl?=
 =?utf-8?B?NEQyYi9jUzE2ei9yemFFVkF4QVorTkh1TDEzeWpRQlg1NVlBR21haGxWTUdw?=
 =?utf-8?B?M2xvbk9YOFJRSEpHWDhhbEcwZmViLzdNemdyaTM4b2hZazdERXdBcVdPU01r?=
 =?utf-8?B?ckdxTmVwUzZJektLR0Z1emNNYldub0RQMW5EMlhEZ1d4WElQRnpSYjE4Vm5s?=
 =?utf-8?B?bC9rKzZtak54OWZoazNaL1FJR0M5ODFZV0ltamJiSmF3bGdDTEwrT0Z0WnlQ?=
 =?utf-8?B?LzVwdjdjVkhwUHJudEVCeS90bFhCOTBSb25Qa3RTdGkrRVZTaVNYV0Q4bGNo?=
 =?utf-8?B?bkJRL3QvMUlPS1JQQUJqb2oxbXdVYTIxRGlWWnZYU1hjMmRlS1FyVnFQYTdj?=
 =?utf-8?B?MUVIVnQ2ZDhIYkdWVmJhWHFvUzZhejRZVzJhQXZIVGdCZHk5WW1kSDRBWXFL?=
 =?utf-8?B?RVlYeTI1MkRCV2VKb3JmOFNvck1EVWFzNGlxUXdUelFhMCtGeHMyNTNCTlhH?=
 =?utf-8?B?alRJbWdMN0Z0VDZvdXRSVzdwVkI1c25jVkxnQ3RlOFR0SmlUa3E0TW9Na3pF?=
 =?utf-8?B?Q2FUMmlMMGdJRDVranJIS1hSWUZxcnNmUFJRbVRUK2laNUpZQjJpTE9QWWVH?=
 =?utf-8?Q?CMtfe/78zQJc1cuCK/Gp50dz5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9633427c-89f5-4613-853d-08dd8368927b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 19:45:31.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6MxfdTEfHhFMEh1evyx6SsLQ9AMwhjXmHPeje3lwFCnI2HRzOiOPzjU24kl3El6croQqAs8pHlDGQg/ZRHSyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631

Hello Boris,

On 4/24/2025 1:06 PM, Borislav Petkov wrote:
> Rn Thu, Apr 24, 2025 at 02:15:36PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> When kdump is running makedumpfile to generate vmcore and dumping SNP
>> guest memory it touches the VMSA page of the vCPU executing kdump which
>> then results in unrecoverable #NPF/RMP faults as the VMSA page is
>> marked busy/in-use when the vCPU is running.
> 
> Definitely better. Thanks.
> 
>> This leads to guest softlockup/hang:
>>
>> [  117.111097] watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [cp:318]
>> [  117.111165] CPU: 0 UID: 0 PID: 318 Comm: cp Not tainted 6.14.0-next-20250328-snp-host-f2a41ff576cc-dirty #414 VOLUNTARY
>> [  117.111171] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
>> [  117.111176] RIP: 0010:rep_movs_alternative+0x5b/0x70
>> [  117.111200] Call Trace:
>> [  117.111204]  <TASK>
>> [  117.111206]  ? _copy_to_iter+0xc1/0x720
>> [  117.111216]  ? srso_return_thunk+0x5/0x5f
>> [  117.111220]  ? _raw_spin_unlock+0x27/0x40
>> [  117.111234]  ? srso_return_thunk+0x5/0x5f
>> [  117.111236]  ? find_vmap_area+0xd6/0xf0
>> [  117.111251]  ? srso_return_thunk+0x5/0x5f
>> [  117.111253]  ? __check_object_size+0x18d/0x2e0
>> [  117.111268]  __copy_oldmem_page.part.0+0x64/0xa0
>> [  117.111281]  copy_oldmem_page_encrypted+0x1d/0x30
>> [  117.111285]  read_from_oldmem.part.0+0xf4/0x200
>> [  117.111306]  read_vmcore+0x206/0x3c0
>> [  117.111309]  ? srso_return_thunk+0x5/0x5f
>> [  117.111325]  proc_reg_read_iter+0x59/0x90
>> [  117.111334]  vfs_read+0x26e/0x350
> 
> I ask you again: why is that untrimmed splat needed here?
> 

I will remove this.

>> Additionally other APs may be halted in guest mode and their VMSA pages
>> are marked busy and touching these VMSA pages during guest memory dump
>> will also cause #NPF.
> 
> So, the title of this patch should be something like "Do not touch VMSA
> pages during kdump of SNP guest memory" ?
>

Ok, that makes sense.
 
> Because what you have now cannot be any more indeterminate...
> 
>> Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
>> of guest mode and then clear the VMSA bit on their VMSA pages.
>>
>> If the vCPU running kdump is an AP, mark it's VMSA page as offline to
>> ensure that makedumpfile excludes that page while dumping guest memory.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> 
> This one and the next one you sent are fixing both one and the same
> patch - yours.
> 
> So, how much has this one and your other one:
> 
> https://lore.kernel.org/all/20250424142739.673666-1-Ashish.Kalra@amd.com
> 
> have been tested?
> 
> I'd like for those two to be extensively tested before I send them to
> Linus in this cycle still so that they don't break anything.

Both patches have been tested by me and additionally both have been tested
by Tencent in their development environment, so i would say they have been
tested fairly well. 

>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>  arch/x86/coco/sev/core.c | 129 ++++++++++++++++++++++++++++++---------
>>  1 file changed, 101 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index dcfaa698d6cf..870f4994a13d 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -113,6 +113,8 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>>  DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
>>  DEFINE_PER_CPU(u64, svsm_caa_pa);
>>  
>> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id);
> 
> No lazy forward declarations. Restructure your code pls so that you
> don't need them.
> 

Ok.

>> +
>>  static __always_inline bool on_vc_stack(struct pt_regs *regs)
>>  {
>>  	unsigned long sp = regs->sp;
>> @@ -877,6 +879,42 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>>  	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>>  }
>>  
>> +static int issue_vmgexit_ap_create_destroy(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
> 
> vmgexit_ap_control() or so.
>

Ok.
 
>> +{
>> +	struct ghcb_state state;
>> +	unsigned long flags;
>> +	struct ghcb *ghcb;
>> +	int ret = 0;
>> +
>> +	local_irq_save(flags);
>> +
>> +	ghcb = __sev_get_ghcb(&state);
>> +
>> +	vc_ghcb_invalidate(ghcb);
>> +	ghcb_set_rax(ghcb, vmsa->sev_features);
>> +	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
>> +	ghcb_set_sw_exit_info_1(ghcb,
>> +				((u64)apic_id << 32)	|
>> +				((u64)snp_vmpl << 16)	|
>> +				event);
>> +	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
>> +
>> +	sev_es_wr_ghcb_msr(__pa(ghcb));
>> +	VMGEXIT();
>> +
>> +	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
>> +	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
>> +		pr_err("SNP AP %s error\n", (event == SVM_VMGEXIT_AP_CREATE ? "CREATE" : "DESTROY"));
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	__sev_put_ghcb(&state);
>> +
>> +	local_irq_restore(flags);
>> +
>> +	return ret;
>> +}
>> +
>>  static void set_pte_enc(pte_t *kpte, int level, void *va)
>>  {
>>  	struct pte_enc_desc d = {
>> @@ -973,6 +1011,66 @@ void snp_kexec_begin(void)
>>  		pr_warn("Failed to stop shared<->private conversions\n");
>>  }
>>  
>> +/*
>> + * Shutdown all APs except the one handling kexec/kdump and clearing
>> + * the VMSA tag on AP's VMSA pages as they are not being used as
>> + * VMSA page anymore.
>> + */
>> +static void snp_shutdown_all_aps(void)
> 
> Static function - no need for "snp_" prefix.
>

Ok.
 
>> +{
>> +	struct sev_es_save_area *vmsa;
>> +	int apic_id, cpu;
>> +
>> +	/*
>> +	 * APs are already in HLT loop when kexec_finish() is invoked.
> 
> Which kexec_finish?
> 
> $ git grep -w kexec_finish
> $
> 

I meant the x86_platform.guest.enc_kexec_finish() callback, which in this case is snp_kexec_finish().

>> +	 */
> 
> Btw, comment fits on one line.
> 
>> +	for_each_present_cpu(cpu) {
> 
> What if some CPUs are offlined? Or in this part of kexec that's not
> a problem?
> 

Yes, offlined CPUs won't have VMSA pages marked busy or in-use. 

>> +		vmsa = per_cpu(sev_vmsa, cpu);
>> +
>> +		/*
>> +		 * BSP does not have guest allocated VMSA, so it's in-use/busy
>> +		 * VMSA cannot touch a guest page and there is no need to clear
>> +		 * the VMSA tag for this page.
> 
> This comment's text needs sanitizing.
> 
Ok.

>> +		 */
>> +		if (!vmsa)
>> +			continue;
>> +
>> +		/*
>> +		 * Cannot clear the VMSA tag for the currently running vCPU.
>> +		 */
>> +		if (get_cpu() == cpu) {
>> +			unsigned long pa;
>> +			struct page *p;
>> +
>> +			pa = __pa(vmsa);
>> +			p = pfn_to_online_page(pa >> PAGE_SHIFT);
>> +			/*
>> +			 * Mark the VMSA page of the running vCPU as Offline
> 
> offline
> 
>> +			 * so that is excluded and not touched by makedumpfile
>> +			 * while generating vmcore during kdump boot.
> 
> during kdump. No boot.
> 
>> +			 */
> 
> Put that comment above the previous line: p = pfn_...
> 
Ok.

>> +			if (p)
>> +				__SetPageOffline(p);
>> +			put_cpu();
>> +			continue;
>> +		}
>> +		put_cpu();
> 
> Restructure your code so that you don't need those two put_cpu()s there.
>
Ok.
 
>> +
>> +		apic_id = cpuid_to_apicid[cpu];
>> +
>> +		/*
>> +		 * Issue AP destroy on all APs (to ensure they are kicked out
>> +		 * of guest mode) to allow using RMPADJUST to remove the VMSA
>> +		 * tag on VMSA pages especially for guests that allow HLT to
>> +		 * not be intercepted.
>> +		 */
> 
> This is not "on all" - it is only on this apic_id.
> 
Yes.

> Also, your comment needs splitting into simple sentences as it tries to
> say *everything* which is not really necessary.
>

Ok.

Thanks,
Ashish
 
>> +
> 
> Superfluous newline.
> 
> Thx.
> 


