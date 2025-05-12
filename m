Return-Path: <stable+bounces-144030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF44CAB45DD
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 22:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B61E1B41DC6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A729A31D;
	Mon, 12 May 2025 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n5/ZIy1Y"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1627511F;
	Mon, 12 May 2025 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083437; cv=fail; b=o0VCrOaavSuhwETP9mTY/o5bP2ahLduZ9Phx7QV8gThThqyNF9lCLWqiTkr5/HDEiXzobzuA1rClHo0lrON5jjqYnDEvewLhIyZIe3dZEgkILh2z8cVoW9XcUwYqfEV8lYzSZo6YA1hIrlZvqz2S75XLcEdHqZ7NxWQPVv16Q8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083437; c=relaxed/simple;
	bh=4OZPGHjt6fSWp6fwvEIKjmexIbXneSUSq0DPuL9fo9E=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=dm1LRoB3Ou0rQmBA7eTIMLLJnHP2V9sIXy4Vl4obeRjvvH4ka3riOi+TtEsaNNwmHExtQLIUJU1iQ6mqHU00opIAs+o0ClxnfGuLpiFmqhyyiTkFngJyCw0WFsV04sZ0J4OWDG3azfaRhuIfqGsoot4tizqRpmr6OdOEDBSdfm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n5/ZIy1Y; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPqnaMEZldNxaq0HYTTCvsuNVx1MDru+T6xBHMdYrSG2MEPgzaImK2xVo61o/S2fjeXoSDsgjrxRdplfbVRSeFqgXT7SuoshJFGSC7JNlR5aIP2iINljkCJ6xx4QUj3opI0RQF2xIxexsEXGIs4uUWCQcseerbzuydMKzbdT832W1ysQxoWVHSg9P/PPG+Lb1kDtwdpyzwkpElc+EVYmA8mwmHhXrZvOQVIpuo4F8VK+4V77zE0cmJiYrULoVXwnDSJ1m7DaHOe4VLfMLBQ/5+u3I4qaiv+PSPBOakxhtXTYCIErOvo0lRZ3MhH5Pc0fWJuGtwv52dd7qsCCv+Zi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW+lcs91va5mxhygklpFwhLrInQlMUqW1ei3nSEfgog=;
 b=b5gfcr38r6Ec/JayMAv0JW/u9eae4+aqLYchAixmDR1mKtv5YyOUAGCmI4vdTUp9k6uuMG6nXkChobHBhuCxm/UZRNX/OBEJ3RcVYWcp8IIrQMKUQoLaelXBONobmPrmoWW4YkpDJI+vPvEGUX/wMu7KBt06ED2ssaN8jmMU8xzCb+8OhHypfmtUgavKpNz1omVhyuoDRCISA9CCQW9rm/X9gJDEuyhbx6g+pKINdPe5uGqJ+nwxfq+Te8MnTNfyTjiYmGOwix5bos6yBusbLcpDNxLgGxgoVSQrkpRFKpndiJO8MRGS1cOEOBuwZFZvAxwq+h7bNkkE4Le/us1m2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW+lcs91va5mxhygklpFwhLrInQlMUqW1ei3nSEfgog=;
 b=n5/ZIy1YX5aU9pWFYQGh5IpERN3OxU4YwcvlmyRBK3/1Q8melvo0qj1wlkgev51H1AgIuYESZwaYv14OS6MStk5BzRRlPuGOcMow/P9gRmY3z+S1S/BVXzlSmSrhuf5ACKD0wHxvljFe/plrqyoDSBejeZ94VTWZOHnrkWjA5k8zD13z5HLmLh1ntNtNc83XJ0WngqfvYDF3gqSUmnPWozaTBE/Qz/xJ8Af5qMLtACTZhWKUKcCTKVoOnr/zVJ+wD4NMTWqVdBKs+FLbK7jcZhAyJ6JBEiBQL4xtCvtbc7GCzSUIs1/d6ptQS4Lejzbf82ImTs2ZBU0qGBqWV8fq6A==
Received: from SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::12)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 20:57:13 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::18) by SA1P222CA0176.outlook.office365.com
 (2603:10b6:806:3c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Mon,
 12 May 2025 20:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 20:57:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 12 May
 2025 13:56:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 12 May
 2025 13:56:57 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 12 May 2025 13:56:57 -0700
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
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <ea5de591-fb3f-4422-84d4-57c0df138683@rnnvmail202.nvidia.com>
Date: Mon, 12 May 2025 13:56:57 -0700
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b13ae7-b935-4b9f-645d-08dd919791e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDZHdHdWQ0hFZHpjV1M2ZUFTSUQxUDgveVdnVGRSNHcrdTQ2ekxOSzdJQWYw?=
 =?utf-8?B?bzgrU3kyQzd1STlpcXE3azBRNDVseDh5cXBadzlLcngrRzJaMXNNSWZwU0xq?=
 =?utf-8?B?U2ZrL3RFVjNrWVNhUk9NQmkxOWczK2cwY2s1bk5GNjlJa012WiszcUtkbDY2?=
 =?utf-8?B?d0I0TE5RSTA3WEFJanB4YmJJMFV3M3BITTZRdUx4SzNDaXMzQThkY0NXOENr?=
 =?utf-8?B?NVdBV3hyNkZSc0FoV1p5dmZGWmF3YzRPZWR5NEpnQ3lLQ1BPZUdRQjVoYU5w?=
 =?utf-8?B?VjRDcWt3RjVkUHNuN1hJSGNnUHp3STk1cWdpbnMzZ250bXI2SVI5b2hDVlV4?=
 =?utf-8?B?bXN6THk5aXlrZS9ZOUxOWXcxNkxQRDVRWmVwMjVFWUxQbnpMS2RyNWFLYXMw?=
 =?utf-8?B?anlNdjc2ZW8xV1B3NVNjSm1TWll1TG1UVXBoTW9uVDYxTmQ4Y0hFN3IzVkFp?=
 =?utf-8?B?T25aU3NQck05ZGJrdkZ5SXFoT1Ewd0ZxM3NoR3pOQ2hHL1M0RlRsZ2RCbmFE?=
 =?utf-8?B?cW10cHVKZXh2ZjVpYytZRUoyWktLQXppK2JpV3VGQTVIZ1l1VjR2NktwWjJi?=
 =?utf-8?B?ZjVwcS9sOStEOUdyN2lWNGM2UEQzRzNtTzZKV0lJS3dpNkFvSms2cGcrQjhE?=
 =?utf-8?B?VGo4V2NnVDB2eng5bFNYMGRpQ0QxOFNvOUVGOEdIVkljU0svdTgxOWVPaW9U?=
 =?utf-8?B?cEJpay9BY0FKNjJVczdWdmlHUE5Ha1lNU3IwV2hLczlxMkRiK2ZMTFhsK0Rn?=
 =?utf-8?B?aXlTbGlCUThTNk03RkxVM20yM0Izdmk1aW5nUmZMM0VpdVZ5T3NSaHdVWjUz?=
 =?utf-8?B?Z2NXS0c3bFNvejNrSWVvdUMvRG1Yd0NFUi8ycWt4OHoxT3lsY2kwSFNzZUtp?=
 =?utf-8?B?Y3JWMEIvSVVzRkcxWEFCVnJPV25sSzN3MmpRKzhTV1ZhZjVRSFZRekc0U2wz?=
 =?utf-8?B?VWI2cVRkUFpBMk5IOHNNREpJb2ttY1hxZHM3bGdGblJ5WWQ4TmF3a0drdi80?=
 =?utf-8?B?TVZ3THEwWXUyb2szR0QwUjhXYWVsVFh4alVpZWphY3JhTHFlbzRWVGE0blg1?=
 =?utf-8?B?ZzFqY0lzR0ptUDRJczFzUzdyZHNCVU5KbWxodWVoRERvV3BYa1VMeGxRKzVI?=
 =?utf-8?B?Y0FqME43KzI0NjFXbjRLMTlRS3U1dGVhK0drRGV2dWp0MmxCK29RdTNuWE5H?=
 =?utf-8?B?a0p1UzM3b1E0cGhQeVJBeVRtVFNkWkRUSTVxeWE3WmhtRFFiMlNwWktsc0E0?=
 =?utf-8?B?WFVDZElsOWNRYmN6dWt2RElsaVJrT0lxdHgwVGl0d2E4V2NTdzVJN3NkSUhm?=
 =?utf-8?B?bHg5b2YwWGV4YU5jRlhiVVE3cWtWc2J6Y3dDK2prYVc2ZytaNzdReHRpVmUw?=
 =?utf-8?B?alFCaGxLTUNIVE5MOG85Yml1R05kQTRjMkExdW03c3I4Njk3cUE4d290SStV?=
 =?utf-8?B?Vk9ybVlrUHRsaXRjR3ZYNmlnZ2RpNXV5MnhTMkhKbU5hRGtYek1ra1djNjk2?=
 =?utf-8?B?QTA4bERPeStxSUpZUS9LM2Mwb2E2RzZ5dnhtNVdjd1NpZUkxaHVZc1Frejlu?=
 =?utf-8?B?TldTaEpBQVdNd3NUVlE0OUh1b1M3bG5tUHRrdlU5MEJtRVZHbUVMdUVhVk1I?=
 =?utf-8?B?ZTUxaGNWVTdWV3NsbnZsTFBVazJkcjE5TEtMS2FnYko1UmVyWS83UGRPalZq?=
 =?utf-8?B?dUdHcFlJbWgxQmk0Y1Z1aFdpYzcxa1FpekxzMlA0R3daNTFzdW4vQnR3b3dB?=
 =?utf-8?B?MkxFQllndFdPT1VjN3FBTmoyZ1ZjY09JSlV3emF1bmphRUhsRnNtVStaMWUv?=
 =?utf-8?B?M21jZWFZUEkzbXhuTjNha1FnWTU1bnEyS1diRlJadTIzUW52SEk0dW9QK2lU?=
 =?utf-8?B?N3pPV0plSDY2WGl6K1VZMVFDcDFVT1UzcjZLWWthMGdTbURVMmg1RGJQVWh1?=
 =?utf-8?B?V1ZoSFpKM2JEK1F6OTFYYWhlVjd1bkx4QWVCV2o3ajdXampRaXllZzJUYVU3?=
 =?utf-8?B?UTFoZkFXV3UyTjdaQk1VQUkycW9WcWlSYS9xSEFmaXJvWC9XSFBETWpjVHNi?=
 =?utf-8?B?UjFUNWg2M0NTSXNXR1RPU2kydExVVDc3RzlHQT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 20:57:12.9070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b13ae7-b935-4b9f-645d-08dd919791e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607

On Mon, 12 May 2025 19:37:30 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.14:
    10 builds:	10 pass, 0 fail
    28 boots:	28 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.14.7-rc1-g4f7f8fb4f8e3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

