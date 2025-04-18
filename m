Return-Path: <stable+bounces-134617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA02A93AA3
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2C28A1CED
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B7C21ABDE;
	Fri, 18 Apr 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQUD/LKD"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392621A44B;
	Fri, 18 Apr 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992992; cv=fail; b=FmWcTWaDirlwvt3DFZ8ZtB4mtQ3tiWBG7IPCc6ELCs91QpLvZkJ7ksmQChWWBYOPSphbmwOSISMNn1tK3kNbN9S6DV7t0v9Bo1CO/ckCR4yITfrL1or692VYh0xUQhwtAyQCDgt6z1lehm4YtV68dEPSea4dBRdVvysdse1yiB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992992; c=relaxed/simple;
	bh=cJU0zy+Wp498ZBQP+mjC1sBu4Y5ObQZ7IdEC8LzcGC0=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=aAVBD/LxK2idzBVDlgrp/hSb5k7QO0rn5V2ETZiMgfwjKdXxRq2Lrxj0xBWHlS2dOnf8opwLWhV/Wj8qo3W1Mv3LZqw1IcBKW/aLuMgL7pZU7OJQPF0b6B0yFCfERCnp2e3BaH+i1Vhxm2qu1ULJKPRRgoiv+rFK06c2Z+A0hXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rQUD/LKD; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxbW0hjEHmRpeK/S4QMdmUF1ADAqTQMBAryXjjSBMtvIxLeAYqtHKWqlGHs4c7u1HmcYxEv4d1e2mDWyQtv+8ktEKdH7RwUAKe3bn+g2tuas6WTi3u/9JWqdtBakVojD4ovjD44dUvpEE+L6BikWxnpDpa0rhenx+A5kAD+ueU8tn4F4BC4GWN6An2JMc9tqkRTVstbl8W0Q3cQP/JMwLwziNl0CsA5HBtyfuby6RbqN4dCXoyRKrNc4HQJltQ4qAMn5oJGn5O3Cws7H/nZAQs4P2m2aI+RqN+lUNNhUt/Ww4JDUgdlupKCgBxszKI1aoXt1qWr2X5mVghasQcdj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niDPNEV+4NrPMqwQi855YIshiIGxYOoOsY9OM8w15v8=;
 b=I8nC9VG04NSL/Da6xPyOkf9uZ78zsQL7xlneSuK4pZfkQlj8q6Zv+u3FKJs0u4OnVktpVmSamhXrrDAswOVgIWQjj8fnntaqmLmN1z5l0PMOHSkeFe3+BHof6TEHUaeHCLI5etg376NvF8LEc4Cwh4qML5UHZfFQK1T5MFKY5PC+jUrysLzyPz7eIla5gynRo9zb9mxJwxNTy1r0rBSdug7PWorialLbrXmF31QfNgNm2E3wAf5HQ5tv3txgtCygU7iCzRTj0ztmqgAJ6ZXDPpky333jUDDTzFTwwaTeE0baIwDF0TkykU0BOTM0OTAXr4aV3eif4hoRIIp5NKaeNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niDPNEV+4NrPMqwQi855YIshiIGxYOoOsY9OM8w15v8=;
 b=rQUD/LKDHKSlCF0p6vNl8ntQgFHzZpo5ilvsCNukR5dERCfntPSk6ntqLlTJ12euPupTUoBXm6ySc5AscgyrbRyYoqWmWwGx6b3lttRds/Qyqx7ptnWbAr368SrKbFJNQWUfXrbCgYsmH3qYQ8Y924cyDryir69PtTjzmf7XabhHmt26u+bTqwAwqQxuTkguQ/l3VyD/gRG26TROPBC7YQjDUl8TG8sLggN+a188DtrylL60rw7i+w2kI4FKvkOIAZWK7r9b33gaY6ALvCqPZPDIR9BTEmF0AdNSZhdwllaIA5hCYS8Spk4ZdXERKoS0NjsHJHVy/Adz4XGLoHJRkA==
Received: from SJ0PR05CA0120.namprd05.prod.outlook.com (2603:10b6:a03:334::35)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Fri, 18 Apr
 2025 16:16:27 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::54) by SJ0PR05CA0120.outlook.office365.com
 (2603:10b6:a03:334::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 18 Apr 2025 16:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 16:16:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Apr
 2025 09:16:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 09:16:11 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Apr 2025 09:16:11 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <hargar@microsoft.com>,
	<broonie@kernel.org>, <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.13 000/413] 6.13.12-rc2 review
In-Reply-To: <20250418110411.049004302@linuxfoundation.org>
References: <20250418110411.049004302@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6a7e535e-29f2-414a-a3a3-a057fa150005@drhqmail202.nvidia.com>
Date: Fri, 18 Apr 2025 09:16:11 -0700
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 829000b1-5b16-48a7-695a-08dd7e945f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzhWQWJuSUdLaklNM2dBZXcyZFQ3SjlMS0Y2NkthM3o2UzI4a092Z0pWaGlW?=
 =?utf-8?B?OG96MThIMnBRM0VsZ0NIa0NLaVVITnA3cExoNnh1bTlTOVJsVXFHQXdIa29y?=
 =?utf-8?B?VFpsUnRWcklLZTI3UWdmUUw5SUFHbndveFdsTXBPTElDM2FNOGIwNjROUElQ?=
 =?utf-8?B?d0I5b3hWVTQzdVltUFc4Q21BMnVlelNqbkZpRkQxZjZwMDNuNFhHQlpLTHB6?=
 =?utf-8?B?LzRPSjJ1MGRpTDU4Rk1uSzVocktXY3dBVlc3RkQ1eUFBSnRzQ3NaamRYTGNr?=
 =?utf-8?B?SFZkQVp4a2Q3QWJEV3hzUVpmMGZTNDVQQWxldjlESFFhYmJScldWVUl0bkkr?=
 =?utf-8?B?ZFZkaWhUTE8xMVFKV0R4b3pXUyszZWlXazlDYU84Q3N2UXJkZVV6eGgxdHIz?=
 =?utf-8?B?OHgrZzhOWk5GTDJIeHN2THBORkgvQWwxVHFnSlBacXIvRGRVL05nUXAvWW4v?=
 =?utf-8?B?Q1lHbWl5cmVRMmROS1ZUNVgrbXlLZVZTT05QY2g2ekJqelVCdUlJY3hlUkc2?=
 =?utf-8?B?WG94MWdieW16T1gxcVB4YjNZQ3N4ZlFBT1g2Z1FrdjlUS29VTlgzcFBBZ1Q0?=
 =?utf-8?B?OWU3SmRRNDFGMmRJOTJLK3FGYmM3bEVmNjgwaGswQXdsK21rR3JhbFZ1NGJs?=
 =?utf-8?B?S0JrczRDNmxyb1BFcHlFWXZtVnV1OVlKZ3VFN1EzbVQ4UVY0TDNyVGNmekNW?=
 =?utf-8?B?NUxiTjE4YVNnempsTjU4SHk4REY1eHMvQy9NcVozcWdTcmQwemN1dWt0QTUx?=
 =?utf-8?B?U1IwbmlpVHdFZjBGc2UxZ1RxYkI3bUR4WjJ0QitraU5wVFFzSlV5anVJa2NN?=
 =?utf-8?B?dzdQcERqSFZDd3o3dEhGM2h6RmdZT3hwcVN4OUZZR2FReTRrWk5jNDhHY2My?=
 =?utf-8?B?SkJSYzdDR2ttaTR3V0tvUHI0WUNzZEI4bW1haW5DUklSYldPL1JLZENJSDc2?=
 =?utf-8?B?MjV2NFdicmxNVE0wM0FSckV2dmNEMHBITEIxN0pyb1pUbUttNDlPVkFSNm9z?=
 =?utf-8?B?c0owVTdRR2tSTlNNR2QyeEVJeGhLaVNzQ0kwWGxxSGQ3SnhvM1JDaUZoaUVa?=
 =?utf-8?B?QnA5bS9ROXM3Q29SUjNabjU2b2xEUXlVazdOSnpNb2FoY0R0d1FRKzhZSVJv?=
 =?utf-8?B?TE92OUpPZWo4eFFocEZTRjJIVnVVTHhmUEZJdXdaYnNHUTY3NWRqZFNqbEFn?=
 =?utf-8?B?OWNjTzJCSHJTK2pwN3RIZWpTMzAycTAweG5mRi9mRWoyOEJ6ZkRKdnBFUVI3?=
 =?utf-8?B?Y1plVE5EWnE2V3VTcit2V0lwdUxUaHpWU2xramQxTkhodU54SmI3L2R0bDVE?=
 =?utf-8?B?V2hqSjNzbldXaGFrbi92RTRLQ2xCeXlFdjdoQk5CRmprYWhjSXI4NmxnKzVL?=
 =?utf-8?B?aVNGZUlOTS9WOHg4OGJyR1NVWnp3M3dGQ0U2TmdhMHZiNDF4amZicjJwUFd3?=
 =?utf-8?B?Qjl2TVRtWC9nZTJBMEk5bjFtNjNKSWtOaFFDRkpKYlNWMXFPTnc4aWxNNnJ4?=
 =?utf-8?B?dWF4TStDYTlBanQzOEsybFI5ajNMVExKVkVsR09qdzlDSFlqVTA5aFVKZHN3?=
 =?utf-8?B?QytQbXh3UWtjNUlKb2h0QWhDajFKdnFuM2F0SnM3OGhKdEJBOU9kbXlUT09h?=
 =?utf-8?B?TWJFcENNaVA3VzJ3VlZvSDdYaUplazhPWFhOYWF0UnlnS0dja1pMRzFaQ1J6?=
 =?utf-8?B?L0hmd3pkd0tIbTBHRFgvSmk4dFFVSGx2R295L3RUK0NoV25yMmtoSGpwWVIx?=
 =?utf-8?B?amxRdnhMRXZTYVl2TDQ4d0ZmaFFVRXVLNDVhREc2R3VGbWJmVmJEUTBQdlhl?=
 =?utf-8?B?cWUzT3RkV25mc1JyVVVUKzFKVU00UkFPUExqWmNuc1FpOGZXa0RNYU9acUpF?=
 =?utf-8?B?TFFhUTJVTXFuNXlRTGllQkJyeTMzSFlPV3FUQW1KbGNkZlRlNEx1M0tjNHNl?=
 =?utf-8?B?NFZyMXdnajd3MUpZNGpOckRkUTdmZE9DdTA0YnhTek96aFBvai9ZanppdXNE?=
 =?utf-8?B?T1VCQTV4NTdRWFd2N25CYTVsTlRaT3pqaExpTGQwQUgrMVg4cnNYdGxRWUIr?=
 =?utf-8?B?dlBBNlRBc1dKMHAwZ1NvRmV1dE1Rc3JpQmRkZz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:16:27.5576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 829000b1-5b16-48a7-695a-08dd7e945f5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241

On Fri, 18 Apr 2025 13:05:17 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.12 release.
> There are 413 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 20 Apr 2025 11:02:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.13:
    10 builds:	10 pass, 0 fail
    28 boots:	28 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.13.12-rc2-gdc7115a5e746
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

