Return-Path: <stable+bounces-195388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEA0C75ED6
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BB26357039
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753BF366559;
	Thu, 20 Nov 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CO4h6JYK"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF8368DF0
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663610; cv=fail; b=srGXMaKjl1jXgOOdNYgCMsC74pOf6ff+Kr+U22aQDApgYifGROp+Pb5tvRhbUpT6wNmwuxJnaIX420sLspEOBU0H1zXAh4bLMCRtV2mepakbsXGySB3VXSzXNMH5500KdTU3B0PK+2JX6VgAizGDWT4eqWtmyF3krhpeDGGM7TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663610; c=relaxed/simple;
	bh=3Ko0KvVQbWTd0PNVrGzZ4+GrBrxuhmZtbEfCSxPcW0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PRtP3uJ+ndQtmzs5Eoeq6SrJbej3xDy/W5+tsNmkZ78czW34opm8qX0KAv+RjLc9/TDXqzV+EFSwB8ShqEIXaCtdsP2l5rAjpSpxYbZQ/p1k0xJad/SBxU8jesSrq9wmqUinKt4MAvh01TlYS/uu4fwOeH+kUAPVDBGoxtHJoHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CO4h6JYK; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKT3un08gQPLc+ag43ANMmWA5b3uqbrI1bW+MRLVkZoy1IeV8BlvFpzfs1hLKvCx+o6JrVyfEVnE+xuQi2ruO0XLk6+Iw31sTC0ZR238iLmk00Nk68vDwhMN497srKsWNVd0gyqp8FtptHAyHkfIhK+ZOkOGyXOyTkWRIhhTqJ+PiyYuV58eZBIg421wYwQpWZxUhC1QBqCfT+24SScSP78ty4BqZ3197WCFIXsgF9BmT1qcIppgeZvsIyr+Qv9BN3Ue4SRYpAo2r+FewPO7NsZdC/P4d5VOgOwXIwQ69qDEMY/y411sufZcaSFfpaVpNAcNY5JehgoAsOetUW7JeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9iD2SAbb7R/k/6eLzKuDvtlWoSIe1vulSoK4jB/hJ4=;
 b=U9PSGqW9pYE1/xp0IieblZVhurRMYffqKVll3wVI32mfaEFXnuDtTMEabuCi+LGNPlNF4zMndk3QDBOKOj4LOnFYXDsM9el40zBKDn/yUhau/fmh/ibH0DmIxsYic3oCjhEUoCR2rtp92tiC3/n7BrnIIoFelsPtfMhMj8uTrVuO9gM55ztmXLTHQpNUlkbuGLiaADix/gD1AnodfDLXSiMQCEwaPsG1JZ0QEJ6pASP5PfDT+OapLENa7tkyyS50Z3h55I1Uewm/BnJqbUJcyWrUjp0fpr1v7uirFp8kQGXyRj9qARA2W9E1UDGmk1IUToy5XHAcBF3vwtIqRBV6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9iD2SAbb7R/k/6eLzKuDvtlWoSIe1vulSoK4jB/hJ4=;
 b=CO4h6JYKhDwLXzMuf8LQ+SKPfmJrmOxu6QSXMfmFl645ceJ6nLaLEsTJzI9RoPbPYfVOYShGWXZ8+L9RAsImCItM4NATm93gUMsERhByJhrdhJ4MijEHYgUMMqhVLftunyoj+vaY6ZY4eaGDIKFMMt/kMexJtRX6M1sPIHUBpTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:33:24 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::d87b:2c6a:4793:b4f5]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::d87b:2c6a:4793:b4f5%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 18:33:24 +0000
Message-ID: <49c24aad-90cb-4d87-afe2-1a65d2d85e80@amd.com>
Date: Thu, 20 Nov 2025 12:33:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/26] drm/amd/display: Correct DSC padding accounting
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Relja Vojvodic <rvojvodi@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 stable@vger.kernel.org, Chris Park <chris.park@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
 <20251120181527.317107-24-alex.hung@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251120181527.317107-24-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::17) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: c9507414-3dbc-4562-f85e-08de286349cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWRoRjdia3NpUnFUU2V4aWVQeitsVTYwZThNL3F0SEZiaW0rNnU2ZThtaytW?=
 =?utf-8?B?aWgrOXQrSW9IQzhicmZnM2hSb0VuNjdVSkpMYkJmdTIzMndpdTdmOHE1bEk0?=
 =?utf-8?B?VW02VkRBaDhJV3ZoV2k4R09FVlUxU1NUQ1FqaXJtb1JQdHRMMTJlWmF2YTNT?=
 =?utf-8?B?RERBaytSQVJYVTB4cnIyREhoWmFTNzVlT1VXaDhtd2tCZXFJZ3QvWFkxeEEv?=
 =?utf-8?B?Ukx3d2VUd0ZFOS80RlVqWE9xUmdhNWh1WTBGN0d6MkY2VnBoSmtvYUZFbktP?=
 =?utf-8?B?a1VLWDUwVDFUZ1ZFcnhWd0w4ZEVBckRLaVRHYXlaTld5eGt2dlI5aHJYQlU0?=
 =?utf-8?B?K2FrRkVzTmJyUXhGY0ZQdUxEckFTeTdJWVl4UGxXREtpVDQwRG5lWWY3UFM5?=
 =?utf-8?B?NHVXTlh3dWFCb1E4SzhzRmY1aFBxWTBXZm9XM2hMSW1iS0lGUnBhVWNJdXJq?=
 =?utf-8?B?QmxnSi9nc0g1dDAxTkY4eU1PYlYrcjhFUFhhU0lkYUxQM2VYd3p1OGNudnlv?=
 =?utf-8?B?aUR3Y3VXcktvbkNhNnIrNncrcW54S2Q2bUplMmVESDM5dzBmZXB1VlU1R1F1?=
 =?utf-8?B?aGkxWmRNbTRaM1ZKNDNINnhJQ2l3b2pwY0J5UjI4VjNlRkQ0QjZQWHZTdEhM?=
 =?utf-8?B?WjZaa3ZyTE45VDEwSUlJRXgvL21Bd2N4MDdGWk1vVVV0WWI0RUdveCt5dG5Z?=
 =?utf-8?B?SnE5L0NjY0RXeENZMVVOMVB6VW9ZZkFNSGR1TU1ZOWJDelpuNHh5TFdFdkZF?=
 =?utf-8?B?MDVHdndkck5nSkZpMlMwalVQQ0orODh2UnBrZm1oMkU1NFNMd0IxR3hXeUVp?=
 =?utf-8?B?MTdONU41ZUVyOW0yUkxma1dxNmV5ZzBIM2tQdVBpbUFYRWg5T3RXRjVxaFNS?=
 =?utf-8?B?bUhVcDFHZE9sMTIrdnVMaDM1dGYrNWNKOGNpQi9WLzVlbXVYTWxWV1JiV0xX?=
 =?utf-8?B?cWhOU3BCbm9Ecm5rME05OVJZVThHNzJUcnA3NmFmQ3FqL2JpWWRIL2R1TlVs?=
 =?utf-8?B?a096cWc4aE0vUVl2VjFSU2FJTm54bFFlZk1renl1dTBIRFBud2lUVytGa0F0?=
 =?utf-8?B?OGpOSzIxUkhjYkw2K0EyMmd3WExvY01PWGwxbTZQQWNXc3NScGR0MWsrN2pz?=
 =?utf-8?B?bWUybnZWaURvL0dXQmNQQTl1dFVPbkZRbjhqRlh0ZEdpT1BUSTVROWxnV3hC?=
 =?utf-8?B?c0J2eENGTnVKVFpqVk5DNndsbTZrSkxyVXpQV1ZnTU5TVzMrZmNGUEdNSkdT?=
 =?utf-8?B?OW5vQmdIRG9WdDVPaGZiK2JiNURNaUFsVFJaTDh0R1Y3dnM1UWN1K2g5Uk9q?=
 =?utf-8?B?M2RNbURFVCtEb2Q0K052aHUzV2VFc0YyaEVpTWxyTVdtbnBHaVNuUDdqWGgr?=
 =?utf-8?B?WDJRV2YrSWl3S1VSdklNdlQ5eG96Q2dvaDYzc1VIWjdVbTk2YkRBUUU2b0JZ?=
 =?utf-8?B?cmxZN2pkQVJpMlRIWG5TODRWZkVBOGhIMDVvVzF1RG5BRWNRZnBNTVoxRE1D?=
 =?utf-8?B?UHNpVTZyTGMwVE4rSVcxSG5PWExxUXlKd04vVkRxZW1hWjlhM0QxZUd0OWdP?=
 =?utf-8?B?d0l3QzZVd2V0cGJTVC81RHA0MTBjamcyNGFzWTZrUjNlQUp0cEcrSkw1SlJ5?=
 =?utf-8?B?MEJwblNvYk1iRXh2Z2E2L0kxa2xmUWhHdkhXeHF3aEdXdmFJTkpDNHZBUU1R?=
 =?utf-8?B?VE1wQkM4WnZLWUd0Q29wL3BDL0JNc2w5Wnk0cXZCVFV2S3Q0NlJ4eTZkS2Jx?=
 =?utf-8?B?NjVSMFlzdUpwVUFFTUR0L0trM3QrUnNzdG5WcktUNWdlZHArL2RDdzg4UVMx?=
 =?utf-8?B?UWNNbzlJU09uc0RsMk83K05LV0NCM3pmRm5CWXZZbnAxakhVSkN6MTFWWGh2?=
 =?utf-8?B?ZDNQaGQ4VWI2Uyt0UWgyQWU3YkY0MlF4WFV6ODMyOXVnalJLTnJ4L2ViNEtx?=
 =?utf-8?Q?jALO3OcLQz2r3oTdVRRbShDnRfNF+pVv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXJqa3UvV09jdDIvTndrY0FkUHV3YTErTlZzeVNPME9sQ2U0ZGZTU0V3M01F?=
 =?utf-8?B?U3RCb2ZnT0I0dytMOHp4VXNVOEhWYTlNa0MvQjcwMHFONVVjUzY1Mk1qQ1Ja?=
 =?utf-8?B?d0VieERkSDNCTHV6ZVhubjRxNW9KeU5COE1IaHpkWGxrM3VkeDlYcXBvU2xv?=
 =?utf-8?B?a0Z4aHVvT090ZG41S2ZSWlZlT3Y1azArKy8zdmpCc2NnbHFrOWplaTBvbzlI?=
 =?utf-8?B?REtlZkRpM1liMTU1VUdSaVpYMUNhcFdkdVFLa3ZSN2dZYmtXckJWSWZnMy9T?=
 =?utf-8?B?REFPT2tQejcwZ2FRd3BBZXpkZDk3UVN3cEZDWGQwa1VpYzJCdkpnM0ZBTytY?=
 =?utf-8?B?SElIc0ZRTmhoM0J1NG5hSkRUYXNpMmRBODBzQTFTR1JOeHlZbjRZelk1Z0NP?=
 =?utf-8?B?blI0V0pkenZSZzJSU0JiSWFFOEtnQ016OXpidWpJREVGdDhXK2xVQy9JU3J1?=
 =?utf-8?B?ek9qOVlpaFlNb0xFY2cyZnJhYTBtSEV5THpEWFBjT1BWOEZWQkloVGtwQzN6?=
 =?utf-8?B?WlgweFFPcGpPN0pFM1pESmpPL2R4aWErMXAySW94U3FIV09WWnZRcE15cE42?=
 =?utf-8?B?RFY3ZldjVWg0OE9TcTFaRUtzeXpKVzgzQnUwZWIxOGlBanRDNmE5MS9mTTFj?=
 =?utf-8?B?TnNKWllwek13dHF2a3BCUlNRSkh2VDdWeE1uZDY3M0V4ZmNrUnVtaWhXQXZ1?=
 =?utf-8?B?cTg5VTRXOXpQQmo0UEgvZU40UU9XVGVveHZGWmxmU082NkpjZDRUWFRVandl?=
 =?utf-8?B?M3FBUzZaai9oS2srYnRFWGx1cmV0YnNmMVBJODl0R2hZSnhnYmlxZXZOVWNq?=
 =?utf-8?B?c3pQa1N4d21FV3NzYVN0aHJkdHlKQXVaRFQxdFcwcWN4YjAvMTRyQnVoc1dQ?=
 =?utf-8?B?c0RmcFpYMStVQXdnRzVRRTh5NS85RXU3T2R3dW0zdG1KTlZjK3pDOUM5cjR3?=
 =?utf-8?B?aG9mSzJLUzJodDQ2bGdNb3h2aDFNdVNJRUgwZGZCVzlTTDhxRG5xL3pqN01n?=
 =?utf-8?B?TldVcUdXMlV6NkNvVnAvUnl6WitveUZ3SzRqVFpWNlkzWHorcnNLVi9sdzdm?=
 =?utf-8?B?cDBGODRQVEFHUE1EWWdQb0ZOWXQxZXI2YjFRanFnM25YdjVWTDRxVWp6WVpR?=
 =?utf-8?B?MVpyMkgrY1E0L0JreENRSDRJdXZ6dHhWT2ZRcDRDZENEZCtVck40SzJyV3Vm?=
 =?utf-8?B?K2E1TUtCeFlVZ1VWU1RQaDFhVWg4WVFibklmbVg2ZjRjUDdrL3lleTcybmZF?=
 =?utf-8?B?VHNDV2RyalVZeEovL0ZpQ2ZFbFJxZkdDRndia2RvVFF6Z1huS1NzU3VPcjha?=
 =?utf-8?B?SzNaNGVabHRoZERDdk91ZGRwZkIzOUVmMzNYdklGTForekFuelkwR1hMSTNQ?=
 =?utf-8?B?dUpycVkyMzZTT0xIVWpwT3BCTTVwU3NmR1B6TnVDRDc5MmJyQnFpV2ljMElr?=
 =?utf-8?B?cXhPdnFjeGhmbTA5OTlXbWxtNFRDVzlrZTdndHA3V210MU15ZkxwYUlyMmQ0?=
 =?utf-8?B?YXk5aWlacFduVGFIWkRtR00zRG9TVW8zckJaRG1LRGJUd2hNZE44VTIxK2Fi?=
 =?utf-8?B?cllYemRXVmdXRHNtRG05d2lYRnM1bTVsSGxheDUzQ3VkNmNVUWFKWm1VTHBQ?=
 =?utf-8?B?SlllNVhOV3hSYXF2Q0dnY0J4V3oxR2V3ZHplTGR5V0swVVV4dWlGWk1DTjlh?=
 =?utf-8?B?dmw5MmhvcmhBN3ZFb1BoTzE4dHNRd0NVZXZobUF1YThrRWVTVTBGUTR2R3ha?=
 =?utf-8?B?VUFwd1UyZ21WUThPR0pqN3JYaGxWM3pwWFhRek1KcS9rOCtsZFJMS2g3ekpQ?=
 =?utf-8?B?ckhCMU01QkREZytSaGE1ay9yOER1dmtpemlQVXVVVUtvUVF2aTQrSzZiT3hL?=
 =?utf-8?B?cDhSQW9pbU1PVUFxR1R1eDMvOVlUR3NCMnBLeWVpRzhDVlZVWDFJZE52N3Q4?=
 =?utf-8?B?QUt3dUZpVFhKVG9SQzUvMWJyNXduY3F0Mk9KMHdLdTBIZDBtMCsrRDJzbHNu?=
 =?utf-8?B?OUJpWnVYTW9zbHg3WC9ZMDFhMURvYWgzaitaSXh4OGtCcDhVWGkyM1pWYUNN?=
 =?utf-8?B?bnU0MUVzNnRPbkYyNlZla0xOUW9qeG80OHQxdSsvZUYyUFRJU3p6d3hUSGln?=
 =?utf-8?Q?ML0/4YJnRTYErA5JrCaUXDO3h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9507414-3dbc-4562-f85e-08de286349cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:33:24.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dj7od+3rKYuAF6CsWNQ13Z77xZGQ/181jRE8A8i7clUJ0KrSEPB8Jvwj3KEsIPTW/U/UtDJF1/r+t0MMvJbILQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989



On 11/20/2025 12:03 PM, Alex Hung wrote:
> From: Relja Vojvodic <rvojvodi@amd.com>
> 
> [WHY]
> - After the addition of all OVT patches, DSC padding was being accounted
>    for multiple times, effectively doubling the padding

Can you double check when the OVT patches were submitted and if they 
were CC @stable?  If not; I think the stable tag should be dropped on 
this patch.

> - This caused compliance failures or corruption
> 
> [HOW]
> - Add padding to DSC pic width when required by HW, and do not re-add
>    when calculating reg values
> - Do not add padding when computing PPS values, and instead track padding
>    separately to add when calculating slice width values
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Chris Park <chris.park@amd.com>
> Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
> Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c   | 2 +-
>   drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c     | 2 +-
>   drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c     | 2 +-
>   drivers/gpu/drm/amd/display/dc/link/link_dpms.c             | 3 ++-
>   .../gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c  | 6 +++---
>   5 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
> index 4ee6ed610de0..3e239124c17d 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
> @@ -108,7 +108,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
>   		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>   		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
>   		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
> -		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
> +		dsc_cfg.dsc_padding = 0;
>   
>   		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
>   		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index bf19ba65d09a..b213a2ac827a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -1061,7 +1061,7 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
>   		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>   		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
>   		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
> -		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
> +		dsc_cfg.dsc_padding = 0;
>   
>   		if (should_use_dto_dscclk)
>   			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> index 7aa0f452e8f7..cb2dfd34b5e2 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> @@ -364,7 +364,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
>   		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>   		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
>   		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
> -		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
> +		dsc_cfg.dsc_padding = 0;
>   
>   		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
>   		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index 1b1ce3839922..77e049917c4d 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -841,7 +841,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
>   		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>   		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
>   		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
> -		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
> +		dsc_cfg.dsc_padding = 0;
>   
>   		if (should_use_dto_dscclk)
>   			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
> @@ -857,6 +857,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
>   		}
>   		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
>   		dsc_cfg.pic_width *= opp_cnt;
> +		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
>   
>   		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> index 6679c1a14f2f..8d10aac9c510 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> @@ -1660,8 +1660,8 @@ bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx)
>   		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe || !stream || !stream->timing.flags.DSC)
>   			continue;
>   
> -		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left
> -				+ stream->timing.h_border_right) / opp_cnt;
> +		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding
> +				+ stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
>   		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top
>   				+ stream->timing.v_border_bottom;
>   		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
> @@ -1669,7 +1669,7 @@ bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx)
>   		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
>   		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>   		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
> -		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
> +		dsc_cfg.dsc_padding = 0;
>   
>   		if (!pipe_ctx->stream_res.dsc->funcs->dsc_validate_stream(pipe_ctx->stream_res.dsc, &dsc_cfg))
>   			return false;


