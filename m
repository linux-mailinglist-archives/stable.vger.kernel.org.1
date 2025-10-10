Return-Path: <stable+bounces-184026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47006BCE0EC
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2FE3B3365
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2EC212B2F;
	Fri, 10 Oct 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r5Tu6cjq"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1DF3F9C5;
	Fri, 10 Oct 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116536; cv=fail; b=hBw4fQk6IxDseQxF+T6N8VEY/HajPElFkJhinZQ0ZuXFdyOMP26aeQbM+mh7dtv5Ulr9r1E9S2lrC0eBKVNQXjdyLEqfmPPIIkPB6YySjj+VMwehKCgMrOKS3lHkJK21JuesetHLJ69f4aBnMZqi3ZEnHwXAJwOwad2croUcnZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116536; c=relaxed/simple;
	bh=5pE/H90lJs6b4XLBfjOzH2ehUjUvJensxMnuuslj3dE=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=Pe1h+bh5RK6q7s89QwfG8oeeG3SwgwIYZb47uvWsVR/4Xdx13KB8Ceq+/89e5rt+8OorBQPU8qDNwTwN+negj1K5DtJNasbDFixk2Ke/IhWoVB3L8g2YbRcN7xOZ0F577av+QkkDIzLhZRbyPiXQB8gMWOvi8KDWI98qUnkhP+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r5Tu6cjq; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmcwrv/iA25ATRFtLpWJBcvJ3NLtlXTxStFm+m6seGMPDJ1FWtHWbEy2vIDMoYyLwv0YToCOMY626AP+cA/6OtJ3g0G3UKu2TRZlgoE+wugTYYSstNxkEEalo6sz8jwQ+Rz7wsF959x1slkt7jE5PaKOJiCX6yCqaDJDLaQ6H+RHWcQkD7ka+g421tJyHj4Qs0/SVeFIZoEesFk1eI/w0CIgeqdDGi4A0tbGkGij7El+RC3k2h/Sasr2oFzs1pmMBBn8vsAKnF5Wt6zGMUMwPdN9KUzVcbt8pfs5oDKfdAnxSueBWVUTas+fuzM0D2sL5pb9WQ87nMy44JfOvEVGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPVwosis0FR/P/tc2cTgpPxuBJ1qA4Red6ptMj8u9FQ=;
 b=EuE3Sil5Qibq1XVkUses1ElyxfzwUV7yaCHEaoK+Fvlso6vp4+uZft2u4Y4Ldu2atBT0+UAjiFf0z7tPltZAbBC1NzVAYAhnRbIneHJy0Z0waciVRh5MYZDXux5By31Y8kmIrRTl6AkD8pwWrfxCp2Z2SKi8ZNTe//TEtWZopQnUxXDkrrSHnDYpzQtY//qAlHpXO6DXYa4jxEg0+uOptCPwLWexzfOMcTf0JmGgPWi4WS0ta3K5T6W/2tGaT9TjYqrGZyM9mOeoH8+IHn9YoZMzA8Osn8qoVNUKmLuy4Tg9SlvR4LaFdcfmIUhu2AXzRGWNDbcO2icOOTbueyHRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPVwosis0FR/P/tc2cTgpPxuBJ1qA4Red6ptMj8u9FQ=;
 b=r5Tu6cjqnNC0Ngr6MTadtkN4rZHmHfZjmS/tMuP9D0Q32WSkOxz2jGKa+mOIHMxUrKgBo9k7+oxGqAe1tntywtwvFOMsBXG53DV/HCZfgrrn0trgJ8TDSB1nWQxDycwjIFL94Xw1MWJ3oFHzh+uKKpGBpAJPBRMbVjIc4z8bPBpc9LyktCgXH72rCfCebdCacOe/sU8JVEVDqiVet3lrcu8vWGfPwpNLz6BiJJ6DjN2Z5GwDUTWZ899fNSmGy3e++i5byVz1AJTdAgGXgIFtJqPRQwXWP5u7DyqZ7hjgiR8d+atUT+gjkLKjssj8UWqHaTxxzoaDYW1l2VquzusJTg==
Received: from SJ0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:33a::18)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 17:15:30 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::80) by SJ0PR03CA0013.outlook.office365.com
 (2603:10b6:a03:33a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 17:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 17:15:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 10 Oct
 2025 10:15:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 10 Oct 2025 10:15:07 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 10:15:07 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
	<conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
	<achill@achill.org>, <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.12 00/35] 6.12.52-rc1 review
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
References: <20251010131331.785281312@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <fe969bc5-ec43-450a-aefd-ea37e29923a2@drhqmail201.nvidia.com>
Date: Fri, 10 Oct 2025 10:15:07 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: c32b7339-4d4e-4afc-60b9-08de08209ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXFyeUw3Q2tXaUJ3L3d6SWplMTZuM1VYMzNkbjlyRWNFVWZRUDVTS0dZeG1s?=
 =?utf-8?B?aEhFVDkwaVk5N2VaVHJhV0hJcThzc3MwVDJyV2drU2FvWWpRNUowa2xBdk1C?=
 =?utf-8?B?YWp4VjdHQ0NncDdIR0hiUHptOTdZWXFKY2xJMUc3SGlVZkpuTnNzUWdKazE1?=
 =?utf-8?B?TDBjQ0NLUjh6N2FkTTJQenN3ZmpJeTF2THlBZHE3U1ZmUG5zQndheDlnQVhY?=
 =?utf-8?B?OVgzT01WT1gvS0h5NmFqNmdldURoVElIWUwxMEJCSm9pbjZnS0twbDRYT1M3?=
 =?utf-8?B?VGpSaFZPOVU0aHlnck1mTDl1eUJhN20zQWRUT0R4aDdmdHNadHFmbzJ0WTZM?=
 =?utf-8?B?QXRRZ215Y1dZRjFCQWI0SXQvUHR0RHEraHJpemVRWFZySzFoT1JjWEZndWtO?=
 =?utf-8?B?aVhDb1d0angwS0EwNkJIQ3BMWTFxRittVlN0cFJ5Y3pVZ0V0K3RVSXErMHdX?=
 =?utf-8?B?bC9XNExLYTlUN3UrL0Y3bVNNWlRnNFArb0plZUJOMTl6YkM0MWsrYXdQNzhL?=
 =?utf-8?B?WktDaHFDaHM4RVMvekJ4Nk1mbWNNTGZyb2FocmZGODcvbjg0RnFkSEx6NHRO?=
 =?utf-8?B?N3lqMit3SXpDOWdidkhhTXFCZHREQlM0aUtDTG1pbWVRaVQ3a0EzRFNxSUwz?=
 =?utf-8?B?MHVnb1VZWFFlaGtId25rUjRKKzFIU2t3S0RoZ2JSVTZBT3lCQzgxY2tLNVh1?=
 =?utf-8?B?U1M4Z2R5UDF3M1luOWNVcFN2KzQ1Y2dHQStiSTAzWG10K0RDTk14STh1WmtB?=
 =?utf-8?B?N25Rb2VKWkVVV3pVeFFSdkpLdUNSTXhaZGg0SGxmb1NKbjR2R2tMZVNvb3oy?=
 =?utf-8?B?M2t2Z29hUnJaN29WdS8vTzg2QUEvZXhTZUs0RlJzMGdmM3BQL2JXWXFtVmYv?=
 =?utf-8?B?RFFkeXhpbzFiVG0vdDBRUnJIUkcrL3JMMGR2TnB3a1VhVE1vc054MUdzR0o3?=
 =?utf-8?B?ZkorOFN2UDRwMUMrYmVoTFMxRG44ZEpKVG9NVkYyL0VLWHFmUFliUzV5ZHds?=
 =?utf-8?B?a0d2b3VMNGNSRHBwaU45cG95YjgxV1pieldja21mU1JlT3loZTQyV0QvSHdn?=
 =?utf-8?B?UVZ1MnROTTMyNkdVUnhadVlXOTJ6MEdVNXFTVlBzbFVrK3VLQWNBdWdBb1Y1?=
 =?utf-8?B?MEcxOVNQUS94L09sV3lPT0JRZjhvRm5OaVhBMVpwU1dTUi9tN0Z1YndOUWJn?=
 =?utf-8?B?UmhNdlJydmFkUitwTnFmRXpMSjE0NUlHazJ6ZlFwTTZiSm9XNTgzaVVJY0sy?=
 =?utf-8?B?ZnkyTlJxNEI1b0Z5QjExa1VxcGdid2ZveHFqWGJacnVDNlpNb3I0WnoyYWsv?=
 =?utf-8?B?ckl2MUFnOVhaWi9sYzEzTkV5c1hkcGhGai9KN2dOdldEeGx2WHdocnpUY1Vt?=
 =?utf-8?B?RjFMcHNKL3cwVW55QnlrckJOU0VqbGJHZXFVVXlGb0pKcVYzSXgrTjIvMjJP?=
 =?utf-8?B?SllGdGpSUG5iQ0p0d3lscjAxdG95WTN3NldYU1ZBRkJ4bEpCbjM0TW5lYXN6?=
 =?utf-8?B?MXVHamh4Qmt3Ly85M1NEZDdybFFiMEQ2UmxMWDU1b0NlMFoxczFKWmpvL09T?=
 =?utf-8?B?QkdOR2xJYWlSNnBIcFdZZXZpL040bXJsOXN5UTBkRHcxQk50MjFHZTRQVFpQ?=
 =?utf-8?B?MkVRY2lVRUlsdGk5S2NLS3RQQzJZU2RpRVE0R1VISDhISEdpSmR3QXRvbytO?=
 =?utf-8?B?emJ0YzRUakc3UEJYbExEZ1NVR3lMSk93REFydGZTWXNiMmlXTk1wOHpQdmZY?=
 =?utf-8?B?d1ZpSHoyN1VlOVV0V0Roajd4ckRNRzlmYnhBdEFjRlBmUjVBZktwTUhBU1gw?=
 =?utf-8?B?U01pWWtvVFo2aVloUWhtN2FISytiY1FOVzlWU3VlNXFkTXBQdWF4aVhWYnlH?=
 =?utf-8?B?Tng4REtkb1BDK2ZZK0RBSmk2Z1Y4NFNqVUd1MU53VkFFd1N0YnBGN0U0Z2Fp?=
 =?utf-8?B?YzVtQkdZdXh1N2x6N24rS25DSVR1ZFZIeGZ5NHFNZFpGbndYbUFiTHVGeTE2?=
 =?utf-8?B?dUk5eU10K05TdHhRampIdTFlc096SDV0VnlpTndDN3ZZVWg5dkRaNkUzdlVi?=
 =?utf-8?B?bkVVWE1mWldsZnlHNjZid21vZzRlU2NVaDlNUllqY1Nsb1VHOExqdmRwWWdn?=
 =?utf-8?Q?OZVY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 17:15:29.7077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32b7339-4d4e-4afc-60b9-08de08209ce4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358

On Fri, 10 Oct 2025 15:16:02 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.52 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.52-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.12:
    10 builds:	10 pass, 0 fail
    28 boots:	28 pass, 0 fail
    120 tests:	120 pass, 0 fail

Linux version:	6.12.52-rc1-gf7ad21173a19
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

