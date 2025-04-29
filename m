Return-Path: <stable+bounces-138938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16736AA1AE4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCCA3BCC9E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6461253949;
	Tue, 29 Apr 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nDkvVFqr"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5B21ABB7;
	Tue, 29 Apr 2025 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952286; cv=fail; b=kU+NzS++hM/r/SijWwoAikTlVDhWKDM0dhxKelyHAgqLcEMhMkBUhqT0zC7WiZIRYktc7gGRkKGDkj6kXcoYCJP0/9UxK4H2j4jwC0AoTpcdoJKCAgfGHH7YVWTb8x11u33PBsvAZLYWcaR5fpmO4YIyYVKaoJJTCgnn9/pHst0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952286; c=relaxed/simple;
	bh=5YxU9NvFFjswO/Z7J7glRL+bS6wU16xtIevgIOxiZRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s9pIeP4Fn9pzI3lGbaAzYMTGGCYiFfCTcO6q3AV523ucSX5DRDm7OJfCKYRj6Oc2wLw8CdTuHIAzj2S6/QTMMWOly8P8UAaS2FFtjnvtjeF5dvubpmpwOTGuklpgGDKUuhtEE7gPFL1OfJY1HQTokGtAfolmOcfaDXZlSuioZtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nDkvVFqr; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3piPV8MFoLuWzGjnXXfQrKUofuQ8PNBk22r3sjXl3bTb2t225NGCEuj+OXXzOBieXvoQCmI8GbmbcA7Sc5Wx19hHpyirgy4EjnPsa6ShqUUQgYVytOmbSqaoXNS91puVpHkNAbOrcZ4GpSV04AY1m0cbsM80wIJWJGhe4dywzPC3zRYCT7KpsSEiaui6/+K1o2ccURITGGVt2p9mieVJ6hnlFxMDiLOen1chYIkN0AjNoEa2COyPYBV9xr7LBl6qq3zICgpWyR5KOOedoH6dmsOwwdQBR1khD2pzFEgB81NyTKxdm5r5Loy70jQdOLt+yWszm9K/YvwBHrKwB/ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBoF8pXhc49pEKPTC9uiXg4n4A1y53O4A1Xt0FP9HrE=;
 b=be6LyU4AL7P0E4QTiRWim09o+FlOhrBi0meBRKzZCgn3zPhBzZ7Qk00oyQ93/SaWNeLUhIQLZKwhQqMXHROTICRU9EeG8kSumq17IXa1Vcd5ddM3geOpIP5EIxeBz1WQuuI5iLcihLfIOvUmyYrhsHVF7HvDuIw12VaTF44vbWw/n6ENY2FefsRB52RBN/Q/iZ0+x4wbKlzHUH14GwH2uprzBlm73MSDaya1UU9Ytb2cCL1c62km9DJRjTwDzKpr7PVpL80LbDIjTNkazTZue25iZrNf/nqFLDpBEm8n2kSFuJ5kBEBl6zMVK/JpBoHFgsBq5y+YJRFyoImiwP540Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBoF8pXhc49pEKPTC9uiXg4n4A1y53O4A1Xt0FP9HrE=;
 b=nDkvVFqrpL+0nk3cljAwOwCWmmGOXx3G6kuz1OitUfQ4Po92+HjdVwwW4Ed4WcbojzNbk7YSdeTafAN/ccRu0nYgU+Jhv3l+Mxm+2/LRJ4cj0Sarza0+qKN8cjDflLqWnyc4JwGA8hSG5+nwKHB7OL6AfUsUttIUXdABV06Rpxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 18:44:42 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 18:44:42 +0000
Message-ID: <b7a8dce0-96b6-295b-d2c2-3d4439181488@amd.com>
Date: Tue, 29 Apr 2025 13:44:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] x86/sev: Fix making shared pages private during kdump
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250428192657.76072-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250428192657.76072-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::6) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4d5644-30a1-4c46-26fb-08dd874de74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW0zdVZWSnpGUnV5RDUvcngxNERuY280RXZEYkNFYkVZTjhWcEx5OGFnUFc1?=
 =?utf-8?B?elVmaEUzYjZPL0UrNnBUMGFweDRnR3c2VGdjWG5Qa3RyVUdmTUc4TmRnQ0k4?=
 =?utf-8?B?RDd6bnBCVFFXUEkvdFp6dTByYlUwVjZDeUF3bVo3aHRMYXRvaUMwTnl4Y2Jw?=
 =?utf-8?B?TldyendVMW5JWUh5NDVkWk9YbklkNDhLVXZYT0l6TVRDTlNXZE51c25EcjZk?=
 =?utf-8?B?YXJMRWxlaE80eUxwUnU5WnNRVFJ3ZEJjM09JVkZHZENodThUcHlwTTlSOXdP?=
 =?utf-8?B?K05XRGM4alVpMSt6S2RaeWdOR0NaalVMT2JrU25qak5iaXM3aUtTWm85Vnds?=
 =?utf-8?B?UFNocTBiUTIwT3FZNVlzYm0zbXBiZURmMzhyUDFNVkdzdTUxMkZVUFFNN25I?=
 =?utf-8?B?bE5HN09hVkRyWXZQZDVTRjZScFcwOXJxa2k3blUzanJyZlUxdDJFcVhpaHE5?=
 =?utf-8?B?b0t6ZGRZdTJGUkR5b0E4clNuWmJSU0lHeHYzc05SZCtXU0ZVUUdaQnlnOE9P?=
 =?utf-8?B?WGs3RElJWXBQWjRIK1paN2dXbUw1Mm84dHp0MnVvbGptNUJTeGVGRjExdDNW?=
 =?utf-8?B?OEtGTTRXeGVoc3d2eGVEZkJQMEdmK01abE9FL3dSS24xaWNMUzJCbmpXemhY?=
 =?utf-8?B?RS83ZUNKejBGcElDbktEMHIwWWJ4T1hXK2V4ZTJTcHdzaHFGWEQ4cmhIVDVp?=
 =?utf-8?B?NHZHTDRHU2dBYkhiQUxUV01RaWhnbFBoTjhzVHJpWnZaWHNrMmNTNGFrMmg1?=
 =?utf-8?B?Mjh1ejhEREpNMzRock8rWlgySGt2R202SzErU2IvOHppUXRtNERtRndmMzhB?=
 =?utf-8?B?TW1rbzFNY3JWeUZkcnNzTE8rQ3E0YktHNG1WaUZtVnM2aFRNZ3NBZVEyOWFH?=
 =?utf-8?B?MUNLOWlMS1pELzVFMmxHSFN0NlpmbW45TmorRUYwZWYyOEY2a0RVcXBlY3hJ?=
 =?utf-8?B?UVp3QW1KZnk3cFo1TmlnOVUxT2pSVloxYi9QZDBjem01ekw0VUxmSm5mRG1j?=
 =?utf-8?B?U0tRcFczaHd1UkRxcGY3Sm1JUWhLNkRtNkU0ZlJaNTZwNko1YkpYc2N0R3E5?=
 =?utf-8?B?cTN1QzRCWTJ4V2ZhdEVtMGxFRS9vaENoaVhhWVZ0ZFRPR0M3L3RZSVZpUzUz?=
 =?utf-8?B?RGVkM0lmVGVTNFpleXk2cjdMTjlQb0J2RGlSR21aS3dYeThHS2svdUZsUnVD?=
 =?utf-8?B?eWQ2MEFmR2RoRVQ2M0s2L1hDQk8vNDNKUyt0QlQ0Tm9SYXQ5OFlEWllaSmVY?=
 =?utf-8?B?YmxKdStycTRVSGNseC9lZ1NlYWVRMUVIb1ByMDd6UzVLaitNMHcxNGNZM0o0?=
 =?utf-8?B?amJjRUJBOVQ3dGVlRlBSUmZ0VzBSdEg3THhoREsrSzhwVzZIbmhBYzUrQ2Vv?=
 =?utf-8?B?WUFzVEk2TGw5dStRSmRtek9SOUxmNFp2bjI3MzZPL1VEQldIbXZMUWJIYzhR?=
 =?utf-8?B?RFV5c0NCaXZPTjZXbEF0QnFqWERhdFE3ZEgzWXpoL0VQdUwyeDhGSDBMQnlP?=
 =?utf-8?B?YVZPR2t2ZE5DTThyTGhiRUdiWnpyNHJNUXJmRzh3Q1RlL08wamNtQW1ndHBh?=
 =?utf-8?B?YVpPc0FWckFZT2YzcDJmTTA0Nk1yRlAwTWVtN0tvaktIMlZQM0g3eEVpVlNn?=
 =?utf-8?B?bGw1eEFhcDhRU2lxbnBGQ1NEdG9XUWZseENCUk51TmRjYnZtbTN4NUdaMEg1?=
 =?utf-8?B?alVRbjljVW9WS3hYcEY3MTFOOGxoMTMzcFNyeVZZdUtjRmQ0aHpvQ1V3d0Jl?=
 =?utf-8?B?d0JmTkJ6RzJ4NUlXZWxZd3VzNmk2TDFQMmdyUUJaNmw4em0vYmRCUHdPMUdw?=
 =?utf-8?B?c1h0VS9hL3VwM2k5UDJnSFhDbExhSmtFYUJYNEpYZUdEMHIvdThWejVZK1Bo?=
 =?utf-8?B?UTVSU0pCUXpGenZvZWUrdkkwT3RHUXJQcXRmNWxoSGtYU3ZDSTRZZ3BaU1Ro?=
 =?utf-8?Q?fQEkIIsmcn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXNuL2NORm5Xd1hYckdKR29pSGtrNWFHamRoek1mYUxwbXgwVnI4RHA4WFhL?=
 =?utf-8?B?c2ZLdWZ0REtncnBTd0tYYjVsUVB3THIxSEVIUkJLaVBKaEVTTGZKTk1IZmp6?=
 =?utf-8?B?U3RhN3dNaXBNN2ZBTFJiSHQwRzdLUE5jcTdtMWp6ZkI2VFdsdGR3NDFJRm9s?=
 =?utf-8?B?R1F1ekpZTXhoNEtZdHpUUysvdElONExCM2F5SHhlMmhkWk83VWJuTWptcEFG?=
 =?utf-8?B?VE5iM0U2WnpDZ21IcTV1dnlSc2UyaEdxM2FHVFN6dEUrUUY4VXFNcmR2U2d3?=
 =?utf-8?B?RUk4dUExOElHcjNTWTlPa0xhUHZhakNabFk5d1VkdlJGcGpsL0gxTWliWXFK?=
 =?utf-8?B?YTJlTlRpeWt4aGpOT2VBc1hkU3VJYU1Tbzh1dk9JVFdyZEF6bEp1UHV4UXVW?=
 =?utf-8?B?WTdxdnFlRlhEUzRBenVJT2JOdFA5Y3ZnZ2ZSQ1M2bE4vQUczNzJ2Tk9LbjJh?=
 =?utf-8?B?Mzhrd29hZkhwaTdsbUpuRWFJeFhJclF2RGo3aUpvS2RDNnM3ODlLOVJzeE9z?=
 =?utf-8?B?Mk5iVUNML2crbWRoaUNOVHlieVYxZ1ZLSzY1UUZoTU9YVDRvNGYycmpQYjdC?=
 =?utf-8?B?SGpNK0hPWnVUVTI3N2FaZXRhR0tSeVE2QU5mSks0WjdTUUpQanlQOUZCSjZK?=
 =?utf-8?B?T0pmczYySk1QUkFITW1mZDNLaUIwUjBCVjVVUU5qNGhJYzMwUGJ5STk5SjJH?=
 =?utf-8?B?Y0MrZytDcmVPb01kZEZCNUhlbmRQYzE1dFBrbTh3Zy9NQzF0cDdEeHJCRFJY?=
 =?utf-8?B?NmgxVW9TTjhYYlNyTjY1WWpldFNDZUJheGR5M3pDVGtJK3MyRTd0Q2lvYzRG?=
 =?utf-8?B?eGk5S2xPRC9DZ3RDdmFDM1J1a3dBUE8zeklYT3VnbXFCR0xWSko3RDVCaGZo?=
 =?utf-8?B?eENXY01IK0JxV0ducGVxdStsaDFxQWFvaWZsb2hDUUtwaUJTOTFmTm0xNHFY?=
 =?utf-8?B?VHo0TWFTMjc3STRieUpBUy9wVmhIamt6UUI0c2dacVZpWXlRNFhEV0RsVnpp?=
 =?utf-8?B?L0NUenZYelZ5N3lBdjRxbUIxOUpoS3RyYXZ6K1lIKzJpWjRRemUrTmxFbloz?=
 =?utf-8?B?cjI5S0hGZlZCbTEyTGpuZ2IxTm9WNXJRM1VLT0xPNG5LMlVPang3Wno2Vkg2?=
 =?utf-8?B?WUM5UUdGaWh0OWhHZTRoQy9uWTZsb0JFUmRabjBjN1VtODJxVXBCMkgxQmg3?=
 =?utf-8?B?NEttbkNhUFpyR1dWUXcxTFRTS3ZVazZIVXAwdHhsZ3poQnVSSWsvQXAvaThY?=
 =?utf-8?B?SC9leitnbmNJT0kvYTVaSG40SUYzZmRKWkl1NjZyTUZXZGpZMVhHWmYxUjZr?=
 =?utf-8?B?N3ZSQ0FJdUdtc2ZiQUk4OGgxUmIyL0Q5Zm1DWUJIS0tReGorYzY1UXpJV1Mz?=
 =?utf-8?B?SGg1TlJrZ1F1emVaUzZabHNHbjJ2SU5GVE5DSDdhbEdmeDBoOGozUVQwVm9B?=
 =?utf-8?B?UFRsK2xxMzFEL1I5cU1vT2dpa1BGamFYQmFFVm1aMDJTSGt5WTJUQXl1L01r?=
 =?utf-8?B?YWFWU0psUm5uRFltUTRzbGRHUkVzb2RPNGhpMnZmeGMxUThNSzJIY3MrNUgx?=
 =?utf-8?B?S1ZTSjJCMkJEK2NodHhrVmdnZXFXbXNJQUtBS3M4TWY0RnA5SWJSdlN4QWx5?=
 =?utf-8?B?WkEyZ2I4WGYzVHZyUTh3MWtKTlF0Z0NSTWYyT2lFNVM0NkdVaUZjQXFyazE0?=
 =?utf-8?B?dzFOUVc0UWNtdUdsRnV1Mk1OZVN3YWErQlpBWExlaFNIMWtPQTZScnZrbHRM?=
 =?utf-8?B?MldzVU5DMGg1dTA2bVVEWGYxQTFTMTc5dnJmQUZNUllIV2VmNW9PQjlDaTBP?=
 =?utf-8?B?cGxDRkszV0EzTjNEOVpQcTAvSVpLdHlTU2pxTmZidDM2ZHU0YzJEOHpaME1N?=
 =?utf-8?B?K2xYQkRucURZUWhTakNxei8vOEJGbFJFVFZmU1BwdUhFUjYxUkNDSTBuTFkr?=
 =?utf-8?B?ZVJvTHBnK2hDV1RzODBGUEZLQWFBVC9sN0ZZZjY4L0d4WnV3SzJweFFRR3o4?=
 =?utf-8?B?ZVBjZ1JBc2NIdWlXcXVqamdGdnpJeS9DMHUwU0dUUFJ3L2VEREt0ZUdRVEF2?=
 =?utf-8?B?RVNxbmpaNXFmcWp2RXIxdTErb214akVnQ3pkMnVPQ0NMb3E4cE05KzBsZFpv?=
 =?utf-8?Q?Hr+VLpzsK+gV6xEjWm5AjpHl5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4d5644-30a1-4c46-26fb-08dd874de74f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 18:44:42.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyBtbcgkC4tRhV3U6Yu0vZSEhyzxXN5oXdqdXWa5v7c+LHx20vQ3sfpo7XvNxJRTGVUxM6PPubEdFtbi1MKMBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

On 4/28/25 14:26, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When the shared pages are being made private during kdump preparation
> there are additional checks to handle shared GHCB pages.
> 
> These additional checks include handling the case of GHCB page being
> contained within a huge page.
> 
> There is a bug in this additional check for GHCB page contained
> within a huge page which causes any shared page just below the
> per-cpu GHCB getting skipped from being transitioned back to private
> before kdump preparation which subsequently causes a 0x404 #VC
> exception when this shared page is accessed later while dumping guest
> memory during vmcore generation via kdump.
> 
> Correct the detection and handling of GHCB pages contained within
> a huge page.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/coco/sev/core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 

