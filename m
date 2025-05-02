Return-Path: <stable+bounces-139515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB34AA7A49
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7B51896685
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 19:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AF1EB1AE;
	Fri,  2 May 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nQ/XnWUY"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893C2DC78C;
	Fri,  2 May 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746214387; cv=fail; b=KQdzUIDW7utekCnFMOMO4npwYOWlDan8voJTD0GRnUbxYDHKzkP+0+ggwe75qXBgHOaPjAu30BH3yhsi6Ef37y8QiFc1Ez/InlZtYdep44vno6OJnLW17AGGX20K0Zji/pU+muXQ/eA0seh774ljriQpFtgxn70fUbFbWCg7OlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746214387; c=relaxed/simple;
	bh=xpYy4C2n3b+s4dsmRmkmhiWxpqIcW5avAMS3VrZjrvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCXibCNSDRBnSSUIOxsTRT2gRieG+LTFhQbKgxdJKqWpxByxE7pdhk6V2qtj3O3JQ2qeOYzDUYVBChhsvqPNLI5ikTMVOe6zl2/e5+h6MG8dxeDNyDznPPeGM0VysjckX0AEn9tLn5d7ySrtMD8TTbNQPZ/hwwnvIHbnwWca52Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nQ/XnWUY; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3//JwFsrWqe6WY05OLBaLZ1ShQRi7GtRjXN5Nm5+TdoFPU6Ks6EtKz2YRJO3EgoW8CBxYBT3ulQj/qaLjNgsjfUqLES4kj92jNkFHnJdyyOP5iLh/OdxTn5/LV2vjzTA7Gn0JlwC99p0lSmAbwcRGgcLxB0+4jtiygjy6WxcKoyRr+El5HH0Eoybb87occGiPEZy22JpxrxsZozbMMEIOwWa51optewqiNNaFhiQ+AoWXSHyPa/67ZKqjDDYJFwkrCxDiz+m7f477hN+XlMymrj0wM8WzuW8Ha9N4S7srK8evpUJHZpCFspVijnkDloBKYAMsI0iKWEhZ/mTlyXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M1A1ZnIJHzvo4wd+HZBu6BNpgMWI4xC9oF2G7jTAko=;
 b=aIg2qkJAkWT9LTLBpsxOmdQ+tGGtwt/ujRSu8exC7UaOpu/IYWei28dbUtU0UKgQXfmYptxrvgg5up5qA1LTk+0yjfGds9MqOIdtTEty0mN4aFMqwa2UqaWKLuQMIwunuHdwrJk+J7+ENGZEOug2KbPO1aSGqvtFT9YN5TnnLv1eGlbLIVo8wv9hjIFx9Edtk7RcCbemZ+vxB/1bzc1XE+WWUPRsMCeWh4l8dr3yn0dWSKh/3uBhSKjUUefciAXHthLR7+e8Rn788TH6Act827DunwkAXfB0NNqRl6mZEgdND7Sg6mk3+1TJDCXmjqZXEc0CfvsrBnJD2g5vi0oX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M1A1ZnIJHzvo4wd+HZBu6BNpgMWI4xC9oF2G7jTAko=;
 b=nQ/XnWUYgx2Bubji/lVHJfO7w1RrA4OTL8Apmi+NdghLTLgnewWlBdJb0Sc6/MDMvYVo3LRfB74jPJqOoG1TYq6BeA4p7991Kf/mBm7hwbXVae9RRORoe0+dy+uQNwaA+x6naRg0jIdHZOLGbEfRLhNiqhynmoZCKAcM6FdA4kU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 19:33:01 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 19:33:00 +0000
Message-ID: <dd0cfca0-44a1-436b-a115-44ad02369850@amd.com>
Date: Fri, 2 May 2025 14:32:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/sev: Fix making shared pages private during kdump
To: Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250430231738.370328-1-Ashish.Kalra@amd.com>
 <633b73ac-8983-fe38-dcdc-0b6a08388f5d@amd.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <633b73ac-8983-fe38-dcdc-0b6a08388f5d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:806:24::32) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 3142c4a8-cf97-4775-2e11-08dd89b0263a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cExQUlgycFk5WjFNY0JGdUtPdjlUeVVyamFpOXJYZ3d1MHVWVEk2RGwxRHBV?=
 =?utf-8?B?bXVRMXdTNDB4Z2FvczhSZHlmVi9SOUhRRE1rRGNwYkN4WkQ5VG9NUjVuZkor?=
 =?utf-8?B?MzVHdE9hdjdEZFo0RlZjNWd1alMxUFQzYldEc1lEL0s4ajR3OERiblBvL2E0?=
 =?utf-8?B?OU1scjd2NG1HVnhVbTV0bjJ0M0FNWDJUdVVSajR0T1RqZkE0NzBTYTdoSkx4?=
 =?utf-8?B?Wi9TQ0ZYRWVEaE44L2l3NjIrVGdycFRsbXltQ3lKNzJBYlRyYTRXbjcvanh0?=
 =?utf-8?B?aDA1eEtOY0NTVW5TY0JoQ05FREcrcE1QM0s1K080S0FvaGtwUkZGbDFIL3A3?=
 =?utf-8?B?L2NDL0ZnaU1hcFJNSVZyaTNId3RLcGJ0ZlVrU3h3R1hodldib2VpczU3WUkw?=
 =?utf-8?B?cDcycVJkUWFPRVk5OXBQbzdvM3RFb210cXZXQjV0azRlVnFlcHM4a0RTRkdp?=
 =?utf-8?B?eVZQSWJLWjAvYUdyQ1JrQU1uNGNUWHQ5WnpRVEtmWmtLWjVXd3N1dEx4d2V0?=
 =?utf-8?B?dkxSL0gwam01Ty8zUUVhODhDNFZvVm5UQnpqZ3huL1FRV3ZLd0JLbGV1eGli?=
 =?utf-8?B?NnVUbUJKS2k4Z1pqMmYxK3l2WGU1V1Q3bW1lOEo4ZUlhTklNcGZ4cDdlSkNF?=
 =?utf-8?B?ejFTbk9sQm5VU24rUmV1QVA3UW05QmpySSt0VW9uWnRZMThna3VkSnR2cjRW?=
 =?utf-8?B?YWZwbEN5OW1oL2V3UVlBTVpkVTZJOHVtUVVwS2h6NFEreW5YUUFhbTlMWXlZ?=
 =?utf-8?B?bFQrSWxESUpvOW8zaTZWZ2RmNmRQYmVoNW9wUllaUVRVTFdOMExKYy9lSVNy?=
 =?utf-8?B?WkErdDRZeXdFS1RiNGtTenZEWm5GYytKOWRwZ1JVSE8rQ29EeERVRll1d08z?=
 =?utf-8?B?SmhmZURIUVc5bmxUUlg4U1hXRnY1ZW1GdW5HakdYU1FTbFMzMkVmaWxGYlJ5?=
 =?utf-8?B?Y08yOElrd1ZTUHlwaG43Z2JheUgyWWk1MkVRZlFyWkxLaGlEdEloZGEvUkF4?=
 =?utf-8?B?Y0o0UmtpcjBnMzFnWGVlTHpJaDdIYisvN09tRkpDd2pIODBpdVJ3bUI1UmRm?=
 =?utf-8?B?azhobWQwMmlMQ2pQK041NHpJQmVtRlpZQ20zTEFyQk12Z0p6aEZncDV0WEFw?=
 =?utf-8?B?R05pUWI1a0ZWRmdaeTVpalQwVHFTMDZNcitYTHhJUEVqSThaY0xIdzFTSkly?=
 =?utf-8?B?d1NPUDBPayttQ1kxeHRiazlRdWNGa0JzOXVSUk9ISVpTQ2EwZlVXSzc5Znds?=
 =?utf-8?B?SjMrb0wvQTNzeG55NkJYb2xoL0pRVDEvU2hRMWpOMEtvRkhVTUJZRWxDdlRJ?=
 =?utf-8?B?SUJZK1hUR0ZodUU2SXJrWjBHN0hVa21oV21ZOVp4NzZMbXVtYUIraityR0Jj?=
 =?utf-8?B?bEJobWdiZXRPVGx4U3RwQklySkVKTFF3MnVEeGFzMHhCMit1aG9WLzFsVGQ1?=
 =?utf-8?B?VzgySTRPVTdNVnd6cElPbHZ6TllmUUYwSkdYQVk3QjMxWnEzNjZYaWxRZmNy?=
 =?utf-8?B?WW9QSTI0V2txZjQxcFZhYnNaZHBIa0F4V1pabS9VcEg0MnlFMU9ES2dsVkFn?=
 =?utf-8?B?c29iWExFYW9YVVR3VmlUWTJWblJCZU9IZ0pEOUVxYk9rTFhRdzZQS0Jja3E0?=
 =?utf-8?B?cWdyejd5Mmt3R3RCVDlUb0RURWVLYlpmbUlYaGh6MmJRaFhTTTRUcHVlTE84?=
 =?utf-8?B?TnI1cURrZXhlU1JIZ1BJV1RiQ3FzRVNQbW5hck5ZTDArUENKdmlzK1AybThl?=
 =?utf-8?B?ODdnWWhkZjRneUtGNjZ5UzRKOUJrakdGZDZLMnVUdGk0N2FHem5rSG50NFBq?=
 =?utf-8?B?ajU3c3d4Vm5nNGF5N052V1MydUp0ZXNUeUorYVJRUlZhcWQ3NjNSamVFS0ZL?=
 =?utf-8?B?WmJXNlJoUVhvSWpUdGxENWJXNy93dGd4MXRqdzlHNjFvT3lQek5sYjRWT001?=
 =?utf-8?Q?gluR1XderKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1NrQU1tUmJnZGlZYU83SVZHK3VWaVJmV3ZVdnFSU3dXaklldTRPT1l2VE5S?=
 =?utf-8?B?UmpKd0lZcm9lcDlEV1Q5bW51SUhBcmJOb3dzV1EzbmRRTm5IZnVYWUhLdXd2?=
 =?utf-8?B?QmZvWG5DZ0wvYXV0RjVxdGhvOFNMY2tvMFMvdks3UHEwRnh3VVZ5TXlQSDlU?=
 =?utf-8?B?enFMUk5reDlzNXd3d3N6WU16N0k4L05XekhaS2tmNEVBVW0wTWxHNk5udElX?=
 =?utf-8?B?ejVNNGltVG5pUE9lZU5wdjRQWUYrczdTUEFURGVzU294Q3dpUUZqdERCVktV?=
 =?utf-8?B?TGpFNjV6MlNCL3BXQ0pOUlh4Nm90K2NXTjcxUkhmeGNhK1VwOGtld0g5RFVw?=
 =?utf-8?B?YS9kdHUzeGdyUWU2NllyQ2ZyOURDNTJaZitKTktlZ0JDN0FxUzRzR1hvRHFJ?=
 =?utf-8?B?MkhjS3BYWFd5WHVURStwN3RmUVZaTFR5dmlnZW5LU1lhTXcreWQwZDkzelJQ?=
 =?utf-8?B?SitJZjNxT0NoT3Z2S0N1MjNuT2lWUVhGYnJnWklZbVJUcEk1SFg2ZUZBZmE1?=
 =?utf-8?B?Rk8vUDRlSklnZHZSNWJRV05DVVN5WlI5cW5vVzlHeHMrc2VkdXR6NWd0ZzlI?=
 =?utf-8?B?MFZFZGIrV3FTUkpYYXRNUDhYeTF4NUFoU0xmV01oamxITzVOZURlNkFtbW43?=
 =?utf-8?B?OWhkTVpCN3BhSkxZbTA0Q3pQNlAyUnU4K0Q1ajlIbzlYVTBQRytFcVZISUhq?=
 =?utf-8?B?Vkx5d1F3WXI3YkdwVGdQSVk3and2WVBTNVVPRlpma1ZydzlkcXI0aWx0Ry83?=
 =?utf-8?B?T0RzblNUZjZwQkdYaUg3MDY3YzRrYnRGTW9UZHZUaWJNRjhxd0dsOTllZzhn?=
 =?utf-8?B?MXM4UHBRK2NYZmczeGkxQy9aMWNFMUkybkNRUUlScjUvcWp0bFZoVURWb0JZ?=
 =?utf-8?B?M1hPRGlNNFJHT1FvK1dubXloK1RtWGwzQTRBTlhMT25LQVlxNi93aVJlbXBX?=
 =?utf-8?B?dmJySGZoYUpTQXFzUXdPNWpHVFd1ekZOSzlkYlVNckdGWkQ0cnYrZWM3cUgx?=
 =?utf-8?B?cUNtZ2pUZ3I1czNBMUh3dng2TndJU1FSckhxMm14eVZvcTFoOGhtWXYrR3Rl?=
 =?utf-8?B?KzVLU2M4cU9yMUkrV1JuSGNUTzlUNjhlN2hVYUQza2p2OXB5Z0kzVVdLNm16?=
 =?utf-8?B?RWlwcnNwZ0xwaERneXIxbHF6SVBTL1Y3MlQxb1hKTGxiMWJuSm16K1ViVkd3?=
 =?utf-8?B?dlBPdURzUjNzbUY3VWxkMzlNQXAxL0dEY3lnRUhzb0VqRTFxRFIwM09aSkZU?=
 =?utf-8?B?Ry9vZWpvNVhUNUFBZDBva3V3RWNHQ3ZUWENWd2wzWkl2NEQ4dmhieVdKRWFJ?=
 =?utf-8?B?UUR0azd1bFdwQnh0K3c2VlJtQnNCaG1ZbzB6SGt6ZWJ6ejAwazQweUVMeGVT?=
 =?utf-8?B?UXRscVNSOEVuSi9MVmg1emRwbmZjQ0dscXF0dFB6THlSRUNMNjhYcmw5dlA1?=
 =?utf-8?B?MDREY0dZK0NzeTZFK245WUViYnpqTFlVTlpWN05FRVJaems1dDFhLzZ5bkJs?=
 =?utf-8?B?K3FXSkRrSC82Ukd5czlQcDVwRXVoaVBlYm1Td2Y1eGJwUHZ2YUorRGdHZ1Fp?=
 =?utf-8?B?WS9sWk5xTExqUUxPdlFyS1pnZE9UdnRic0k4cG5YZkZnaXpKL2FEY016OFFZ?=
 =?utf-8?B?OThrT1lLMU14RldISnZSc01zTjVHTER1R0srT1kxT1JXSENoZ3h0ZUxKRFVk?=
 =?utf-8?B?Y3R3eUdwUTRuV3ZGbmxLeStxMzJtYTRGV0o5MnRROW81UVZYeVVONFZyTlhv?=
 =?utf-8?B?ZVNINUtCbjFDbXRLMDlBM01vaHExcXR2TGwrdnZvS0VRRXdwM0FLWnpUaitJ?=
 =?utf-8?B?aFNocnpqeS9ySHljOXlIV3dRaTJxS3F5WFl0Zi9qZkZWTU45S1ZPZ3o1V1lw?=
 =?utf-8?B?R0Q5YUlkRjJSQTNjZDFqMDNsanNlWjJGZG9jK0ppWlh3K0NJSW5nZG5qVUF2?=
 =?utf-8?B?c1VxWGVkVTRmcDF2eW9RVlpUdVVlRVJYYWZ3SC9kaDJqSVZPNThnOHJ4cFJs?=
 =?utf-8?B?TTE3SERZUnZRWmZHM2E5QkgwTTlhN3daMEk3aU5rOGJaRTlrV1JiVmdiUzVh?=
 =?utf-8?B?T0xvY2xhb2JYMVVDWEtSazI4WEJwcmpGZE82WFZjKzNjbGZoWForYTRxeUdq?=
 =?utf-8?Q?f0uo+76FFsZQSpQ0f9LNWX8uq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3142c4a8-cf97-4775-2e11-08dd89b0263a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 19:33:00.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgCy5+1Adj4Q+i4/sGR9iV+fEydHMfe6z45kXlJJgcMTE0JbeaUNYjXldkZ59KyHOIc0jbvfbSW0sa0Px9P3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829

Hello Tom,

On 5/1/2025 8:56 AM, Tom Lendacky wrote:
> On 4/30/25 18:17, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> When the shared pages are being made private during kdump preparation
>> there are additional checks to handle shared GHCB pages.
>>
>> These additional checks include handling the case of GHCB page being
>> contained within a huge page.
>>
>> While handling the case of GHCB page contained within a huge page
>> any shared page just below the GHCB page gets skipped from being
>> transitioned back to private during kdump preparation.
> 
> Why this was occurring is because the original check was incorrect. The
> check for
> 
>  ghcb <= addr + size
> 

Yes that is true. 

> can result in skipping a range that should not have been skipped because
> the "addr + size" is actually the start of a page/range after the end of
> the range being checked. If the ghcb address was equal to addr + size,
> then it was mistakenly considered part of the range when it really wasn't.
> 
> I think the check could have just been changed to:
> 
>   if (addr <= ghcb && ghcb < addr + size) {
>
Yes. 
 
> The new checks are a bit clearer in showing normal pages vs huge pages,
> though, but you can clearly see the "ghcb < addr + size" change to do the
> right thing in the huge page case.

Yes the clarity in these checks tempts me to keep these new checks, but as
you mentioned the right thing to do probably is "ghcb < addr + size" change.
 
> 
> While it is likely that a GHCB page hasn't been part of a huge page during
> all the testing, the change in snp_kexec_finish() to mask the address is
> the proper thing to do. It probably doesn't even need the if check as the
> mask can just be applied no matter what.
>

I agree, i really don't need the check as i can simply apply the mask as
the mask is based on page level/size.

mask = page_level_mask(level);
ghcb = (struct ghcb *)((unsigned long)ghcb & mask);

Thanks,
Ashish
 
> Thanks,
> Tom
> 
>>
>> This subsequently causes a 0x404 #VC exception when this skipped
>> shared page is accessed later while dumping guest memory during
>> vmcore generation via kdump.
>>
>> Split the initial check for skipping the GHCB page into the page
>> being skipped fully containing the GHCB and GHCB being contained 
>> within a huge page. Also ensure that the skipped huge page
>> containing the GHCB page is transitioned back to private later
>> when changing GHCBs to private at end of kdump preparation.
>>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: stable@vger.kernel.org
>> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>  arch/x86/coco/sev/core.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index d35fec7b164a..1f53383bd1fa 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -1019,7 +1019,13 @@ static void unshare_all_memory(void)
>>  			data = per_cpu(runtime_data, cpu);
>>  			ghcb = (unsigned long)&data->ghcb_page;
>>  
>> -			if (addr <= ghcb && ghcb <= addr + size) {
>> +			/* Handle the case of a huge page containing the GHCB page */
>> +			if (level == PG_LEVEL_4K && addr == ghcb) {
>> +				skipped_addr = true;
>> +				break;
>> +			}
>> +			if (level > PG_LEVEL_4K && addr <= ghcb &&
>> +			    ghcb < addr + size) {
>>  				skipped_addr = true;
>>  				break;
>>  			}
>> @@ -1131,8 +1137,8 @@ static void shutdown_all_aps(void)
>>  void snp_kexec_finish(void)
>>  {
>>  	struct sev_es_runtime_data *data;
>> +	unsigned long size, mask;
>>  	unsigned int level, cpu;
>> -	unsigned long size;
>>  	struct ghcb *ghcb;
>>  	pte_t *pte;
>>  
>> @@ -1160,6 +1166,10 @@ void snp_kexec_finish(void)
>>  		ghcb = &data->ghcb_page;
>>  		pte = lookup_address((unsigned long)ghcb, &level);
>>  		size = page_level_size(level);
>> +		mask = page_level_mask(level);
>> +		/* Handle the case of a huge page containing the GHCB page */
>> +		if (level > PG_LEVEL_4K)
>> +			ghcb = (struct ghcb *)((unsigned long)ghcb & mask);
>>  		set_pte_enc(pte, level, (void *)ghcb);
>>  		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
>>  	}


