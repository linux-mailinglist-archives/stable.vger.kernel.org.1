Return-Path: <stable+bounces-135294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB67A98D25
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB963A8FC0
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729661BEF9B;
	Wed, 23 Apr 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wdbawFCs"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B496149E17
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418779; cv=fail; b=IqZ2ah3oXU4c54xbKvLees+cRQOIPXsm1pGJZZwgrbtpHGavPZfwKuxGKDNYR7BTNragB0yUH4wQ2c3EYE1++oeqnelvw86lU+0rFI7BjLnzGGk6cMMirlTImF+FxvYKt4TTxlr2XgKmebh8ZZ4Yekf3PJkMHRabNEfMGICIZaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418779; c=relaxed/simple;
	bh=wVx8gRgANiTQxlYd90GHQhEGolibfxZRyx47Y18xb+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dyof34qQTWE4HFS+26dWrgXzRsP+snjRe8FWxyH0ztrJAGucjVq3PmXQuX0ScKgEwRJ2Wt3k8GH0W9+GHv4MHJB+8qOL4zaxEX3luPopplPsAt3w762c6vJ8saJHyEW9673s6OJt05OyHiVnKqzTasLBHBNkmxuSIMLpsgntUOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wdbawFCs; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7suMz/7PvPHdXQlFQfrSOpHG2mBSDTXZhfnybMe3T+yFrXNDPXuiOhwOV6iIW/JlR2q0CbXSO3/LD/CkZF93rC5fO8rs3hHchv6phFXFjEqaMWz/tytQkov4vWEA8YKh4e6Zm7nX9HkhjTnRsSTRroJ6M3P3G7QXj641b1Lx1PeC1xAM9rbdNAXrks1X/8OOT16CXa3HWojht/5gidNH19b8YsjAmNDse94KjmB0RqLHXw4hWaWu10ku6v2SopLqWmoIOChJRSmqswkVGx4H74GrGqo5wR5zPhUk8MUQD6Y9P8JuOzD3oJWvhuGPT16boOXXP1rTE/6gynAy9SdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0uhe0D8TF5uPGk3UXDeBLnp4CqRsUXHkBmNowJdBnc=;
 b=YMcmxkYQpBoSg8AdSDLLVSil66iUl9XGlFV3MfQtcqT/hBnCWPBGfU6EQkUCxyGC91BlI9jul1j/dBo6qAA9LYFHvcXZARO44os/MqdV2nH+opTvKlxIU8AlAxGQT4o4wljxN4RX6/McKT3YwmELFjaopB1DhMBz3DzolD3G9P3PZAnfB4Q/X7i1JnpnTIlmH4InX0c+fkzf/lucrkz5HbiZ9kTkWz06TezOOEm8bq8BCIwxNZILXao6rLCfhjXsMtb4PmCJMQCQydo6PAy1fKj606M0LGKVbzEZ2C8gAYVetovWSMonbs1ltqVm7MW/sfmxh6Oz9+tflfM1CZP/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0uhe0D8TF5uPGk3UXDeBLnp4CqRsUXHkBmNowJdBnc=;
 b=wdbawFCsAtsDIjXZY9SJzIqeCcBYgjoQRU2yjrQYeTV8ZIoVxjDDr3f0h/Cb6WJBLUeq8ge2qMeUosKYdsSsZV6vmPz7JZgQmH9shpZA4est6/7NpfBTItBwPWxOWrq2ZrqnFMQqrIDy1RohqU45ybtOmNaI3/6ofiBJyV5zxRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Wed, 23 Apr
 2025 14:32:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 14:32:53 +0000
Message-ID: <e19f13a0-90e0-4e24-b547-607496d8983d@amd.com>
Date: Wed, 23 Apr 2025 16:32:48 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIGFtZGdwdTogYXN5bmMgc3lz?=
 =?UTF-8?Q?tem_error_exception_from_hdp=5Fv5=5F0=5Fflush=5Fhdp=28=29?=
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Fugang Duan <fugang.duan@cixtech.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "frank.min@amd.com" <frank.min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "david.belanger@amd.com" <david.belanger@amd.com>,
 Peter Chen <peter.chen@cixtech.com>,
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
 <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
 <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>
 <D9DAIUZXIWH3.1L7CV6GEX4C9M@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <D9DAIUZXIWH3.1L7CV6GEX4C9M@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcfb15f-148d-405a-4a95-08dd8273bb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmJNdVFiUGxFOWV3WUt5OGJoSzlnbkwvRytwREo5amJzVjhDNTFKenRIeWc4?=
 =?utf-8?B?bjBweFFSMCtCMmlTRGtJd1lUU0lJZ0phZnNtT0NWL3cxZnRxb0J5Z0RNT2tk?=
 =?utf-8?B?eTc5bEdna2Y4ak81S3FGWTBTd0xRZGQxRzV3V2E0TXczV2V5VUY4dHJqVy9j?=
 =?utf-8?B?ek9xUmprQzdPbThDd2ErOUMrY1plMUVsMHF6elpVL043cnd2bm16M3F2NFRz?=
 =?utf-8?B?elVWR29mdUs5aUFKakE1YzBJTzBWQkI1NkdiNnF2bWRvbm9pSkQ3NXpuTi9G?=
 =?utf-8?B?Mjhab1pEL3ExMnBZRWMvUkJyVEh6RlFGbmEzWGpSWk1FK1liUUJEWlFxT1VO?=
 =?utf-8?B?TlFWQi9XRWRURkhHM3JIR0F1Z2ZRQjIrRis1M3NxY0xxeXVkMDNZQWdGV2N2?=
 =?utf-8?B?V3F1V2lFSjM0QWlPWXhTRC8vTk53WHNqYmpmdWRlMENGUGo3UUFUZzN3YkFL?=
 =?utf-8?B?blJPS3RFUzV5MHladWhySU9DYVR3M0VSUVY2T0R1M2JXdUlKVi9DRnpiR3hT?=
 =?utf-8?B?amUrZVgvKzJNa3ZTemptdVoyRGpuNXB3QWIvb2M3MWtWK3J0SlhMV250aDd0?=
 =?utf-8?B?ZWZmUWpyUWd6NWZDazNwRnhxbzE0NmZKRTBQa1RlYldIcGIxWGVTOHNCVXhO?=
 =?utf-8?B?WVFickMyb2dLNkMxbTBneFA5V2J0VnVlRmo3VHdMZXJHR1NRLytsMllRejlV?=
 =?utf-8?B?RUovNnQ0cTJDYzNWZFJJek1SQ1Y2UlNGalhWb0tXOXk5VTBFQkYwVzdnOU9j?=
 =?utf-8?B?ZTRhRHNiN0tSMTFPLzFSNFNoTWNOeHNibUtGRzB1TGhuMDlVbVlxVEpLR3Zt?=
 =?utf-8?B?UHZYbnlZb0V3QlNxQjMrTmd6RVl3WFpWRHVjWDZPRnR5Ni9Ra3k0blJMQlg5?=
 =?utf-8?B?VDNmdXFOR0ZpTzI0K1NadXM3eWdpR2R5QlRDUERJNnNLamIzZFlKVVV3MXFp?=
 =?utf-8?B?aHY1S2p1V2pHbTd1M3FwdlQ5T2NTN2QxNUJRUnlpRjFlOTAraHFBTFJvZmpn?=
 =?utf-8?B?U1gvdXVlSUhGMnR1TU1FYVE3K3ZjUFlXVmFBWUttSkh0ODhuRVBPcVV5VzNt?=
 =?utf-8?B?WllXNUtWQyt3WXB0WnBKbm1VNnJ3U2ptVlAwSmh3MDgvRi96a0Q0MUNGUFgr?=
 =?utf-8?B?Qk5MZ01BaTRZbVRqM2UrRGZITzd5aUM0WkhvU0pNckZOQTJpN3FEd3c1K3Bs?=
 =?utf-8?B?NFk5bTJUNFVFTlJxeGdoamxEY1dVZUlNaFVNZm8vbFZ2YTNCcGROdlR4a0g5?=
 =?utf-8?B?cDF3bG1lRm1qRUdWTm1PRS9KOUd1MVBaMTBleFd4bVVlY0s5NENWa09MOHFz?=
 =?utf-8?B?U0ZkRjBxNElDa1pmUnBnQlJVRTVCN0RrUmlUcGFyTUlyeklPWjN3eVVXZjBW?=
 =?utf-8?B?SFM0bDB0Nkl4YWREN3FZTnhHUnlxcVYzQUkrSTF5cE0wTzlwVGVUeG9jSzlS?=
 =?utf-8?B?aGJkTU5nQk84S2hmUVNVR3RyUHBXdnc4Q2Q0bzIrZit4UURWcGhKZjRJa3Y2?=
 =?utf-8?B?b3pER01tM08vdzgxZTNIblhUVFQ3Tmt5QXBTZjh1NnhvZEYxVzdGYzBRS3p2?=
 =?utf-8?B?SzllN0FnRmhnNzJFYnFjVmI2MzVxOXpJZUtraVM2L2dnTmRveXJHKytvQ2hH?=
 =?utf-8?B?VlQ5MFRQUzBoTFQ5WWxNcVpIVU53RjI1S21UdmVtczhZOEgyNXhlM25OS0Yx?=
 =?utf-8?B?eVlralVzTXVhaTJnYXdRQ0g1cFl0SXdWekRkUmdRUDFSa2ZZc1E3UlJFemw4?=
 =?utf-8?B?dVNDQzR5Rko5aTQvN2tPQ1RTVlYvampPRXh2SU5ScG5aSE0yL1hLY2h1dnNW?=
 =?utf-8?B?d1AydWNHalYrOXdZbGlYaXhvMnh3N3VEemFUZEZhQU9LSGRqM1lCaGxNVXU1?=
 =?utf-8?B?bk5KdEp2bEdQNHUwdmNGZVdyWTZFaVNRcWJINXZVWXdSMkM5T3oyaUdqN2Mw?=
 =?utf-8?Q?nPmhUWTnYic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjFKSVpWY3o3azdZWXFiRDAzQm94SjJnM1NuUzJHcWNVTGtRR1lHSVFLRE54?=
 =?utf-8?B?SG5YbHppSXZBYmFpajVVcjB6NHVvR3FuVGlsUzFmc05GczhxNnBoSWdvSnJx?=
 =?utf-8?B?MlRwSFpzaEpKSXN4QkMvcXBrVnBVQmE5ZDRzejRaVmZjYytmMHg1TEZUeGZl?=
 =?utf-8?B?eWphbzRLc0ZSRDZRQ2l1Qll4K09sZjIrL3RXR1JhMldxcE14VDl5d0VDRm9G?=
 =?utf-8?B?MXdLbEdBbDFVSTRrVnR6NFdTMzVDRkxqeCtXUUNvZDhJaEg0b2s5b2hueHBX?=
 =?utf-8?B?cDhFVW5VcGYzQUt1b0sxaDV0OG0yTXBpRFpESVZXRHhvb1lMY0ZvNlNaMzhh?=
 =?utf-8?B?b1Y1ai9ORXUyRVVrbGFCZ01IRHBqTjZLNUdBQ2RTRzYvdkhoalJtUk9ISnds?=
 =?utf-8?B?bkdCY0oxWG5JakpWeHJYUlNTYzdNek0xL3M4UWNIL1B2dXM0RWhCVUE2OVQ3?=
 =?utf-8?B?RFJsUGg1Z2wwcUc0a0tIK3Y2WG5xYXNBUGxQekFHWjFmOTY1MUVJcFkvY1Fp?=
 =?utf-8?B?S2QvWHRaWW1YMFkzUWV4SlhDZnlRR0lhdm5KVUhGZ3cwdFgyUGlMN1ZRUlds?=
 =?utf-8?B?YUF2S2YwRHRjdEltMkhlMnEzcGhHZ2tlUXBUOGhKT0F1RFc2eFpjaFN2M1Jv?=
 =?utf-8?B?NHA1aE5NQUlCMWthVkVKbTA1U2J6dERkNERDL3hVTWtTRTY1S2NyZDZ5c09S?=
 =?utf-8?B?TDdaeHpYOFRsTmd3ZWQzeG9DSTBCVENzQTVMOHRTRjRjb3Q5RG1MMnIxVWRu?=
 =?utf-8?B?LzdZa2tsc2dac1Rkc21FcGVCVWpoTjRoRS9Weml2N3dnYVFPd1c5T2dmTUtH?=
 =?utf-8?B?c3Y3MVVPOU1ZckwrNWpGSjhQSktyMEl5bEcxTmFGM3dKYkFWK2hkTzFad0NO?=
 =?utf-8?B?NnI2b0pXeHc4RGtvbHR6ZTRWZHVCTnpaR0l0WGZabk9YbnBzVjNUd2Rsd1JL?=
 =?utf-8?B?TDUxWDc1cTNGYnJHVXd1dUZnKzNHOEVJUXVNM1p4dkVjNE5xaW9sVE04VFpz?=
 =?utf-8?B?ZE45V2J0dEYvT3RLOFc1YVBTZkZHNWF1QkZJUXpWZzdyR1RVME1VK0Z6YUFy?=
 =?utf-8?B?NHlGdHlBeVRETXZLczJ2U3F2LzcwRFRmZ255MXJ5TTU4ektnQ01hYVQ4L3F5?=
 =?utf-8?B?NzNjcFNncllyN1IrY2RYeG1td0tCSFY3K3dsWHlLVTBQeFYyODVhdmtaakFa?=
 =?utf-8?B?SFdmRXhvKzVRdW15dFFJN2V0Rno1czhTcGJKQ2FHMWFBWktRTW9raTh2ampJ?=
 =?utf-8?B?THRMTVIvM2RSeGx6UXc1OFZqYk9oR2VUZXMrTStBbTFDOHVvU29pWUgrNUwx?=
 =?utf-8?B?TG52WkFQa1VZenNXMVY3MlJ6VVF1T1NESzNrWjhsb2g0LzY5MEhrZjJId3ZM?=
 =?utf-8?B?cjBaeERTQllER2QzdmpqY3hLb0VGWTVQYjFLNlcremNqMGo1S3VBaG5WOXh4?=
 =?utf-8?B?ZWtaWXdSM2RzZmVVNk84OHdFUUVWN1NqMGEwZmVScUlqUHpWc3NIQ2ZFM0dB?=
 =?utf-8?B?MUtrSkw1d0VxNWw0RmFyUVNudWR1dmJQVERGa24xaEZ2Q013OHlXUjlJZHpz?=
 =?utf-8?B?SUlTY1V5czZUODlkREpNUE1Zc0NDL3VuWkNSOFpBUE0xU2JBbTZuTTJVSXRk?=
 =?utf-8?B?STF3Rzh2dVJqY2ljOUttbGthY0tEYVFwMzhzWDJyZXVMQjVCVGh3NFpGdlRq?=
 =?utf-8?B?RzQ5NmxTU1pVSEFtRkx1WFRlNDRZVmRZbklFUjRrMy9LeXp2djNZUE8yNno5?=
 =?utf-8?B?Y080aWlabCtUSzEwdUhWa2FROXBVb09rQXY3UVJWS1RVU0lxc2FFVnRpTEZm?=
 =?utf-8?B?RkQweEpoZFNXT3B5aUQrMTZSVHRrMm1aTXE4VVROM29BNGswT1FlUEVtdGJB?=
 =?utf-8?B?RnR4RzRUOFlQWkVNZXFtUVI1WVgybXVDd0t2V0JnVU0xOWVab2hLNktua0RU?=
 =?utf-8?B?SGsyY09WRUd0SGxtSFNoZ3VxdE1DTVBLdDRvSm94Zy83UE1FaDNLRDYrUUQ3?=
 =?utf-8?B?MkU4NmYwSWI4L2tKRFo0a1IxYmJNUTBBTzd1VS8wcEozcjc2N3VPc2piU0c2?=
 =?utf-8?B?TjIwZlBRbGRzZUgyaTRjRUhObU5neVY4OUpYT2hFSDViVEp5dHFiZGRNMzY5?=
 =?utf-8?Q?2zSwjO8RyGFTFfTY2HtpFGD64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcfb15f-148d-405a-4a95-08dd8273bb04
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:32:53.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hvg713tbo/Dol+qBPe6PvYJI/Zef7AEZNaK9wbg8VFQPc9xAjUS8JY1insfAr25
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391

On 4/22/25 17:59, Alexey Klimov wrote:
> On Tue Apr 22, 2025 at 2:00 PM BST, Alex Deucher wrote:
>> On Mon, Apr 21, 2025 at 10:21 PM Alexey Klimov <alexey.klimov@linaro.org> wrote:
>>>
>>> On Thu Apr 17, 2025 at 2:08 PM BST, Alex Deucher wrote:
>>>> On Wed, Apr 16, 2025 at 8:43 PM Fugang Duan <fugang.duan@cixtech.com> wrote:
>>>>>
>>>>> 发件人: Alex Deucher <alexdeucher@gmail.com> 发送时间: 2025年4月16日 22:49
>>>>>> 收件人: Alexey Klimov <alexey.klimov@linaro.org>
>>>>>> On Wed, Apr 16, 2025 at 9:48 AM Alexey Klimov <alexey.klimov@linaro.org> wrote:
>>>>>>>
>>>>>>> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
>>>>>>>> 发件人: Alexey Klimov <alexey.klimov@linaro.org> 发送时间: 2025年4月16
>>>>>> 日 2:28
>>>>>>>>> #regzbot introduced: v6.12..v6.13
>>>>>>>>> The only change related to hdp_v5_0_flush_hdp() was
>>>>>>>>> cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
>>>>>>>>>
>>>>>>>>> Reverting that commit ^^ did help and resolved that problem. Before
> 
> [..]
> 
>>>> OK.  that patch won't change anything then.  Can you try this patch instead?
>>>
>>> Config I am using is basically defconfig wrt memory parameters, yeah, i use 4k.
>>>
>>> So I tested that patch, thank you, and some other different configurations --
>>> nothing helped. Exactly the same behaviour with the same backtrace.
>>
>> Did you test the first (4k check) or the second (don't remap on ARM) patch?
> 
> The second one. I think you mentioned that first one won't help for 4k pages.
> 
> 
>>> So it seems that it is firmware problem after all?
>>
>> There is no GPU firmware involved in this operation.  It's just a
>> posted write.  E.g., we write to a register to flush the HDP write
>> queue and then read the register back to make sure the write posted.
>> If the second patch didn't help, then perhaps there is some issue with
>> MMIO access on your platform?
> 
> I didn't mean GPU firmware at all. I only had uefi/EL3 firmwares in mind.
> 
> Completely out of the blue, based on nothing, do you think that
> adding delay/some mem barrier between write and read might help?

That would still be quite some platform bug.

> I wonder if host data path code should be executed during common desktop
> usage as a common user then why it doesn't break later.

Maybe it's some kind of write/read re-ordering issue.

 But yeah, I also think this is this motherboard problem. Thank you.

You should probably ping some ARM guys to figure out what the fault code actually means.

Regards,
Christian.

> 
> Thanks,
> Alexey
> 


