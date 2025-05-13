Return-Path: <stable+bounces-144193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE31AB5A6D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABE3866328
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2903F295DA6;
	Tue, 13 May 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qVrQ7jTy"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9631A23AD
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154468; cv=fail; b=I2wdmAu+6vfLKobT/kgT0mk7Uess1YzGhWWnU/ESA4VN+w6iN4DIc/NO85ZXVBaOpvqcQtSmBGnrOGYTZbC6PnfbxAVTDQcC2AwoxFzBnGWS+nfcaRVict7Rli7mGHnv8RM6fgzoQ1rEDJ2eWwF6DSlrWb6IYnbtsQffTTSCDkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154468; c=relaxed/simple;
	bh=PA5GhqRTRvXHMJjLj+lkjF51XwXVN2EAY7gOQeg5FYw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WcbLLlNhiJ4mveCanCuPAKozjygtB51AWEUUmC/3fQYBHFgViQHmq70Zxw24Wt1xmFjA8cRjgB3+aPUAL3z/TcL/XDJ/m3xj3ZugSU9+ZloViGsox+FNJj5doyQdGCzIxx544LKqqksMj4zVq8JyEDMaYoRIA3PhyS6lfuheF8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qVrQ7jTy; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h79twNuMkKRKBjwuLckjQkI+c+PprxV8Ncsx62tEgApbR3sm3UpCXQCO601PE49HUrQ9YHnQ/qwGf2TVSpeVIjW+U/P0c8e5BADo5m4gtbvIWNaM7kicxSt6j+16/1n80zFEdkKVJfijt8xCKFfWnLRCsEbl9yxM96nSRlZZGyqiiwyvCQAYJPI3Uov4pv2XWBaxTRy7xx+qUnl2kPWeGGqKhc865S/UJJPOGdA25JwFN6ya8cJcMICNh97tfwFZCNUeXzy+fgfWxKaCWH/U0e2dlZp6XYYyC933LRquDgyp+LKMP1CRfWpySNcxE8JkC00YxmGkwulO+xVT3wmrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVnMMhYbwNrXWjJxOuX+nBDHa6Xpqe2BU9vtcAZlxMk=;
 b=cI/VXtfiJOC/sE1iVYlrmm4xRzNEmuOT8YPqzCVdSOkgUc5563oUPk793fnsWViwOnqvx3dpJ4kpIS/8ONQ3NUeQytvZE0+oKZsukiz2vms8yTktJ1GQreFT9BuD7HOWoLkofa3kDcD//CI4H/lHcxbv6pokWgjUp/djHL0XbOVG7xzJmK3DacuF9xiNEbI0YpboqehpJlDMoevFyCQw37OqL5uMZzIulk0NMzCZPQ8ripqfb3SGPqHJTEqbBywMfcnitqh9hAzkcwxFWbZlk1YIDBeQFqYSUG69FSvJKTHRhHI67RsmSpndbkQ2CFwbf11PRqlYjCA/bRBRjZKuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVnMMhYbwNrXWjJxOuX+nBDHa6Xpqe2BU9vtcAZlxMk=;
 b=qVrQ7jTysEZenDNR1VY/HWyTuSfCmP+AiYjDliJmVlJDnaWYgyRJWN3wYc3TtyerXTCpvFOXp1EN6ZjwAhnVu+H2GyDDwL/vfiJUmDwIYVRcKUJAHVi5dzDnLES/QhE5GNBFjBvSoa4J66DzBttIa8zaaUS8Qv57btdVlM+zS+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 16:41:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 16:41:03 +0000
Message-ID: <711258cb-4530-4119-9127-6e0987f01711@amd.com>
Date: Tue, 13 May 2025 11:41:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: read back DB_CTRL register for VCN v4.0.0
 and v5.0.0
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com, stable@vger.kernel.org
References: <20250513162912.634716-1-David.Wu3@amd.com>
 <20250513162912.634716-2-David.Wu3@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250513162912.634716-2-David.Wu3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ac8af1-cad2-4980-a6a8-08dd923cf36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFgvUUxzZ3pFWTVEdWpQQ044SVNObGpRUG9HWjNrZTIvMERtcGorVldreTYr?=
 =?utf-8?B?cUQzM3JYQVZtSVFobHlneUNJaEtFWHhycWsvTy9ORURUVWI1TVFCcW10OFV1?=
 =?utf-8?B?eW94M2dqZlNwZytFNXZoRTBFcm5YWE5IM3hYVXZUVC95cGpRNjQyUEpwQ1R5?=
 =?utf-8?B?T2g5ZWFqM0VYQWZucFJ4SDV2TE5xWU53emJmT2xzbjFlc2NJNmNRRWw1VGF5?=
 =?utf-8?B?OHlTaGlQSXNjSy8yQTV5NmQ2Y1hvblVvV2hHTHgybTFnclN6TFp3c2UxR3M0?=
 =?utf-8?B?UHZxYThFcVRObWtXd0c5ZzlZS3R4anRqNXYzaVBkWENFa1k0aU1XbThsaG5V?=
 =?utf-8?B?VEc0RU5UVnVYN2prK3RVU0hXemhoUnQwZ0d6cVo1Z0c4S1QraDV5cXF1aU41?=
 =?utf-8?B?TU5ocitNV3dCeGhpQ1cwamx6RSs5YnhtVGlaY0NhQTJpSmo2NXQzamo5MU5G?=
 =?utf-8?B?L2dSMVI4RDFxY2dybFVOSi8wV2JMSWgxVnJVSDN1SDU0NVk2c09IVXA0bzhS?=
 =?utf-8?B?SjBIN3Z0S1ZLV01JdWREQjZKd1hsY2NobGdwY2R5d2FyWFdZaEYrRFJmSERz?=
 =?utf-8?B?Z3Y4V1lCRUI1eEFGRzNObkJFWENxQTA0ZGtXZ3ZScTE5cUdoNG00NWlmMVBY?=
 =?utf-8?B?WlJZWGNNeHh2UlN5MGtjOXA1aWNlR2dZM2RQakYwOHgvWTRnMU5jV1p2YUdt?=
 =?utf-8?B?Y0cxZktsbkNzWjNiM2tsME9UdEtmZ0pzMVUxaklvQW04Q0Jkc1ArSGlPNHVJ?=
 =?utf-8?B?VDJiNllGM1NaRTVWYUQvVFZQVXhsZCtwaUN5TWJqUEJ2emp1Mk14bG5Hckt1?=
 =?utf-8?B?akc0ZWpIR1FsaGF4TzRqRFJNYXEzUkJycGJ3YzV2NjdkYTV2bFM3NVdJL0Vk?=
 =?utf-8?B?dFBHTjZid2JvNjduMHh1REFiWjN0SUcwUzM2VnlFK21rSlMwby85RFNCNHND?=
 =?utf-8?B?N2ZzdWxPWHpTNlQ2aEpwRUo1eGRnemtLeU5FTEgrSnMxYnVhWERyU1puUFp1?=
 =?utf-8?B?MTFtMnlEOC9iMHJWTmNkUlNhY0ZSQUtPOXhycHlLNHJGaXdocFhyNjBjQkl4?=
 =?utf-8?B?eGJsS2xUWDNnMEdzdDdqNVJ0MGVrdjk0ekFJWEV1b2pza002U0s3MmRYdEFH?=
 =?utf-8?B?eE8raTA2Z0NDdTA3WHBkSThWT243V3pLS00yUkpuUTFZbkd1RDAwcEFZbWd4?=
 =?utf-8?B?RTBnaHFaN0tSTC9qd2k5YjBKem9jbkVLZHd1NVRoWlpZM0c0MzAxODlqemF1?=
 =?utf-8?B?NWtabTZlNVBTQWFOZVZqMzd2dmpxYXE0Y0crSkpGYlJWTTl2UE1EVzFPaHV3?=
 =?utf-8?B?MnZPS2dPMGlIWlVveEszRE9zVVk2b2JnOUV1dk01RnRNVnF5dkU4ZnQ2RkxI?=
 =?utf-8?B?eTF1Z1pRUHpYMTNOcWRkZDJJeklTbWRIS3lnTnRDZ0wyTDJqMVBVYlZTeG5G?=
 =?utf-8?B?UVloR2tRNmNZVHo5dzQvalljL1ZHREZoT05QT0dMenBYYXJPTjZqZVdwSmdQ?=
 =?utf-8?B?Qnc0ZzNMU1FkcVVUVUFBd25JY0ZvbzNUc2xxcDZlOFBsVjBPdE1aa2IvdEs5?=
 =?utf-8?B?NnlaajlVTURzSTB6R0VUUElqYkxSajZ3V2paZG5DRDdjS0xYcE5qb2dmbWdO?=
 =?utf-8?B?elRIQ214cDh2RkJGSDQ2empCT250QUZZVmZENmJXcGpPM2JyM205bituQVBv?=
 =?utf-8?B?YkhWVklhdElRVCt2ZFJPTkxWYW1TaEhubTFRdTZLbjdwa1dUZmpneW1YdnFY?=
 =?utf-8?B?RUdidGpxWlM1ZFhDTVdxdSt3ejVEQXIzOEw1WnR1UmZkYmkzUHhveU5uSFNP?=
 =?utf-8?B?djZ0NSt6dm1DV0ZQSER0U1ZlUjhNZWNPbHRSdHlvcVpmS2w0dGtPT3Q3ZnZi?=
 =?utf-8?B?Snh3WG5zZkxNdnNKS29zM2dVVTZKZTJucyt3WDh0eVUra09XYXhHdkMwaWlu?=
 =?utf-8?Q?H4+CW2acvbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG9Palg2a3pKQk90UG44YVVBYzU2eHJaVlJLYjBBc01EUHRycjR3dUdxR1VZ?=
 =?utf-8?B?TmszbGg2cXVGMmJsNWlnYzBaa0VSb3pwcnIzYUJMK1UrR1FuMHdVSWhhcWhQ?=
 =?utf-8?B?Y2Rpdjk0WVFEaWRNTVNDSkhLeFJYaDlQYkNZTzdDK0E2d0loOXBvY3lHNkVW?=
 =?utf-8?B?ZFFRYTg0MHE2S2pSRnV5V2lsNlBzcGNRcmszblZiMCtvTWZsQ1N4R3hMUWNW?=
 =?utf-8?B?ZlFuWnZyaUVRS1dtTlJwQmlMVmoyMkd6TG41dHdnbGx4SlRZY2xiQm1jQnda?=
 =?utf-8?B?VWM2UFhaTnpwQ3J6MGU1VFNHeC9CSm9iN2d5YmRqbWViUndIb2FTdmZHTEVm?=
 =?utf-8?B?MkFiV2EvQ25jQWZpMnVTTDlyVXNtMms3djdEaDBLcHV6TTBjc09CVVNKY0w0?=
 =?utf-8?B?Q0ZQaTJGUGp6Q0hSUURjQTZZQkNtU1h2c0M5VGdrVGpUR0hmZ2h2RWJBMllG?=
 =?utf-8?B?Q2tCc1NHek1sQUZuWDMxS2ZEM1BERFhkZXdueEt3MFlkcXN1R3UxYWJESk0z?=
 =?utf-8?B?SjRnWlRFUURtRHQ3Z1BmSnVoWDBSQ3QwS3loZXhSVGRPVmF4N1JiK3RDbEJ3?=
 =?utf-8?B?QlplN1drcXd6MXJIcUJlYVROckNqYXJuYnJKS3JLb2VnMG5wKzZEREs2Qndj?=
 =?utf-8?B?ODlOSW5NTjNKMnNUNjIvR1A0d0puV3NCZWhzdTRtUDhyWHhpMGQrRHFoZVkv?=
 =?utf-8?B?M2RLOWdTTnp2TzVSRFc1eEtGREYyeWo4VjNQelBPYXNGZTZselV3MEN0UStU?=
 =?utf-8?B?VHVidDdqbFArQllFWFhsSmZkK2JES1JYRzdLRXIzYlFsOE9vYzFXS21FQ00r?=
 =?utf-8?B?RGZCUCt0YkdNVFBqdHZHY2MvOFAxU1M3aEttSURTdUZyQUt4ckRsRHBLU3RJ?=
 =?utf-8?B?RU5NeW04NnROVm45b2FTRlRmT0tibXVmY204azNVaWtFN0lvWjBwYUx3S2hp?=
 =?utf-8?B?dEF2OGpySG51WXdiT09wVFo2MnZCM0NCQWt2N1AwYkJqbGhWYWF0bkFBQXlZ?=
 =?utf-8?B?WGJSUE9EbkRXTHhqeC9sbmJ6aEtXL0luWnRBWGlzMGlGVVBsRVhTWHpjZGhE?=
 =?utf-8?B?d1BvTW9KaFMxbnFYd0cvL2FZeUh4a3BWS1ZVRkw0ZHZzdkIrbFFra2JRSGZz?=
 =?utf-8?B?UUM4NXFjbmV6QVVVV0VVUVBqNFNNL2JsRmp6dUxGZmJ5cjU2VzE0ZlVHTi9I?=
 =?utf-8?B?emkxdmRjWTRWblJ6ZXpyMzdsRzhNSjduN0pybjh3eUo2Z285RHVvV3VLRElX?=
 =?utf-8?B?cFpXRFBVR3VmL3NSeThKdFU5enVRMzBnWGlsNzUvekxzaiswcEp4b1NjNEcx?=
 =?utf-8?B?dlFLc2Ntc09zb0x5VjZGQ212RUV2OXhtTjdSeVA0WEcrYTNLK3NLVDBTby8y?=
 =?utf-8?B?c1ppNUJJenJtbFZRcFlsdzNiaEhyTU5Wa3ltNXZsWlloTnlRQUFTdzJHSW9m?=
 =?utf-8?B?VTN2enE1Rmhyd3dudkY1U2hFbW5YcU9vbHNQRFh6OTYrOU5uZHlMNkhFSllM?=
 =?utf-8?B?emM3MkNUQkhqcjRuaFdhNG03Y3EraVIrTGpqNXVUNkRRL3duWDVkWEJrOVcv?=
 =?utf-8?B?M3lmMEFOS0FPNlNvMkNMdDZZNUpzOXdIMTRvbGFkeElmTmtXTHQvQWJGbVcw?=
 =?utf-8?B?d213RW5mazVXSVBXU0ZydmYrZDkyWWIzMzQ4QTlybFIram53VFh0cGp5cGM0?=
 =?utf-8?B?d0pveHFVYXp5UlJxR29OWEtydjJ2VHZKcDlEMXpZZDZoOEFqNEc2U1EzdTVF?=
 =?utf-8?B?SFlPMXlYSUhCMUNrUkQyK2podkdxaTQ1OWx3Q1JIL1ZjdVdQZWdBdE81MDVF?=
 =?utf-8?B?UjNpWHg2NG0yOTlIVzFDeXQ5K3g1WjFqcE9iK2t0ajgxKzdubzB6WmlZMy9v?=
 =?utf-8?B?UVpuNmtLMyt3S3Bid3dmanQ5TUk2c3owZ3ZvQlNmNmhiaFBDSVJJd0d2MzNH?=
 =?utf-8?B?UGRHSW5qVVRaKzZiLzlEcnE5Ky9aMm1tYlBiWDd5aEs5emFUZUVwSkw5M0JX?=
 =?utf-8?B?RUZ2a0NMUGppQXJ3em1IRXlOMktnZTFaRlB6QitDVkFLdlE2T3FtcVBEeTcx?=
 =?utf-8?B?VmVhWEVXMVdVUWw0TDArQmRVaFlyQXUyZUxqOUJVaDFidjRqWnlUZFF0cGJh?=
 =?utf-8?Q?/O5Nn6dT70/Pf8FVge4lZny15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ac8af1-cad2-4980-a6a8-08dd923cf36d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 16:41:03.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxO+PJ5j8s/Ll4SzBSCVzfNP9RO8HY8ugorqR/5+7g9H0SF3jKEwn0Adnvyxw6JTRYhnNxKPoDgMyMZmxSHgxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303

On 5/13/2025 11:29 AM, David (Ming Qiang) Wu wrote:
> Similar to the previous changes made for VCN v4.0.5, the addition of
> register read-back support in VCN v4.0.0 and v5.0.0 is intended to
> prevent potential race conditions, even though such issues have not
> been observed yet. This change ensures consistency across different
> VCN variants and helps avoid similar issues on newer or closely
> related GPUs. The overhead introduced by this read-back is negligible.
> 
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 8fff470bce87..24d4077254df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1121,6 +1121,8 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>   	WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>   			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>   			VCN_RB1_DB_CTRL__EN_MASK);
> +	/* Read DB_CTRL to flush the write DB_CTRL command. */
> +	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>   
>   	return 0;
>   }
> @@ -1282,6 +1284,8 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
>   	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>   		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>   		     VCN_RB1_DB_CTRL__EN_MASK);
> +	/* Read DB_CTRL to flush the write DB_CTRL command. */
> +	RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
>   
>   	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>   	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 27dcc6f37a73..d873128862e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -793,6 +793,8 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>   	WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>   		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>   		VCN_RB1_DB_CTRL__EN_MASK);
> +	/* Read DB_CTRL to flush the write DB_CTRL command. */
> +	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>   
>   	return 0;
>   }
> @@ -925,6 +927,8 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
>   	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>   		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>   		     VCN_RB1_DB_CTRL__EN_MASK);
> +	/* Read DB_CTRL to flush the write DB_CTRL command. */
> +	RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
>   
>   	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>   	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));


