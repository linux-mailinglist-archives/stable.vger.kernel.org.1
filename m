Return-Path: <stable+bounces-197976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D6AC98B11
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 19:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 325E4342FBF
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BCB33858A;
	Mon,  1 Dec 2025 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lohdBQ4B"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44540333452;
	Mon,  1 Dec 2025 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613170; cv=fail; b=S+DKvpX9KpswN5t3FDv4ZFQhyn/5wF9R7N5p3WIgt2qOm8CwsK65FU3e/1Bl76Egp1pCThsLfEze2Leus4aHaiGEh/+tUb8cqWypUcZ7Wv67mwEuNTy4FIAekFM+OVirDHfEk/a8T+fk44sUOHS+yepTGbg13leepiF1tL2bvxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613170; c=relaxed/simple;
	bh=e81mO/6ODsxbCPCn286WwoujqczRcCCXqZwOzLxu7Ho=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=kAu+vU4RNROB7hJBlx0FPGstXx+C5YlgpxNHWf3ysRFVKj3YH/oWs0oX2dzG/egcLNj7EYPiGGerE2tF0yVsZs4Y/Zb/wTzSX6/yIG5sBw1ARU9XUlUw4xZP0Kb+r8phtdJtYzgBpSie+8XG7Rq5ltHh7pBihwGS4Ce24Kd4O7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lohdBQ4B; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP/Su+I3QJJ2ZjCDURcf/BtbZ9LUlXNMgPxgcWkjBZ03TFqtlc4bd52sfg+6+xPK2rHFE/6+ryU4Sf6leA1T47SrQ36wa90tINbt4doA96NYfsks2Ky3kbZ2Y3979pGxFxwOm10VGpW+5BeQLRTwZon2cUzXJfRW1U00SD8AmvKSofHt6jK3Ld6Q7bydjU/SH2mK8NlF9fNCFPVdBmreTQmtFGsgpMiiGFSQ12kHlf97E6uI6/QEl5djvz8h96W+fa7xSFTSFj4/XeSp5rdX1tKHGxQWddf6shYZVLZJtr59u3VoNroCHBR/Xj/uEkiqBOlAEmJHg8qvOYEqBWi/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvz0vZ77UfumMdRFjwgId6JwM4dN4RZiRGy8rWGGLfQ=;
 b=LXX0VodWLjnsNL8OEEnC62/MYXX0RcrJOPN4+UIVg+Jin/cEITI+8hx/86k7Rio7O5jxiIBROTYTn6BKuZ0q8C8X+R5bMQNPDKLhsz5nWRwAGdtkmEZOkmkTq1GQ4LpN0piiOaVLFL/ke9OuJ9R/F4KC3cE9r0ToospyefLleBSbWQHUwqelEnFWXxuzwmuuLS98wez4u6rnYJEP3s+bbs3os5JRY2IpQMa4d0Bfdw8mmKakU/KK+Num2tQ8/VV4X1gMnEth/JUyAQefGTr4QSUko0IsDEYETTZpBoTV3DOe5wWonAIuTsUebxfgMnCMkSOb9sp27hd7DLCUyw5hCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvz0vZ77UfumMdRFjwgId6JwM4dN4RZiRGy8rWGGLfQ=;
 b=lohdBQ4BdjIO1nUJzFWeXenBFVEuZ4/o9koSM8hqFBKRzlgT82tQ8uvIuaiB6eF/u2hfoqrqkIByO4NMb8VP0TUcx2vaezHPMcMbhoBrRcGAYC5smiOrOEfk0w5xOplgWKPON1MY1q3uUqCvYmdt28RGiDgcORd9n74ZNDmuxSlvBYoMzTxcU49URc4AYhL1REm8iIy7rPQwRKHrlZw6fngT2S5B7QMB8YSk6yws+P8XYHPgh0XsiQ6ywb5fcqzAdEr803PgP3vPYAmWd8MANtdN2rr8LyBd1mKHDRbNqb3prZvGzrSgGv37zIBmifyhyJzoYUs3p7UBfj5ky94u1A==
Received: from PH8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:510:2d2::10)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 18:19:23 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::2e) by PH8PR15CA0007.outlook.office365.com
 (2603:10b6:510:2d2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 18:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 18:19:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 10:19:04 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 10:19:03 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 10:19:03 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
	<conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
	<achill@achill.org>, <sr@sladewatkins.com>, Sebastian Ene
	<sebastianene@google.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.12 000/113] 6.12.60-rc2 review
In-Reply-To: <20251127150346.125775439@linuxfoundation.org>
References: <20251127150346.125775439@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <69c1725b-3cfe-4e8f-949a-a4a689f050e6@rnnvmail205.nvidia.com>
Date: Mon, 1 Dec 2025 10:19:03 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 9850a7d2-b668-4582-98de-08de31062700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zys2OTJNRmFmcll4Q3VsY0NwdmJPZWhTYlNmdTdLa0xlSWk2c3FBcy9MKytQ?=
 =?utf-8?B?QTBEb3VhSDlzTWJwK3RralFmNlpxZHVsb1hVVFRzTHBTdk0vNjBLdFdhakta?=
 =?utf-8?B?QTBBdHRtaFM1SVFhU2s4K3hJOGE3U3pidkNZMkR6aTFWSENJV2tnZXdxRUdy?=
 =?utf-8?B?N0UrUUJubkJ4SnAyODlRUTlUZWpQV2FsdjNmazVENi8wVXdMdW4zeVg5ZkM2?=
 =?utf-8?B?K2cwYUhEYTExUGJxTUo0WDI3d041N1J0Q3RNa1oyMGpWMXByMWdFMlg1S1Na?=
 =?utf-8?B?ZlJsYitGZElWSHo1TXcyZ2Z3RWJINERtSFF3UUw3OXBjTTdMMGFtaDRJMXBE?=
 =?utf-8?B?dDJjVjk1THFDK05oVHYwc1hJYUpQd1RzaHFaRTE3aXErVUxDeU85RWM1dGE5?=
 =?utf-8?B?SWZIK1BaaXJGT0s5ODJ5NHk5TU9POEg1V1lyNTg5LzZpeDVKN3BiTlN6dGpD?=
 =?utf-8?B?QXRwb1Nnci9PYzdrTVBIUTFOMmpFaFpOZnFhZnFjZEUwVXJxYUNpMWNVYVEx?=
 =?utf-8?B?Z095eTFlR3c3d21TUXlOWXp5K21QU2l3VnQ2VGVmc3ZEK0V5OG5jNmxFcU5s?=
 =?utf-8?B?STFBWCtmM0ZUZy9PVmxEZUhySlFkeWhBNzVaV1l3dk5ZaGwreGVXeUd1cGtC?=
 =?utf-8?B?aGtVZzNCTGlHM1hsQzFxcHRUUmVUdzVRWDU3R1creHlGWFVTVE80Q2YrN1Er?=
 =?utf-8?B?Sm9pbVZLa3lrNHJ1Vk5sMitMRzE1RDVMU0tsa0RhU0xRblUvbUJhVEw5MUNz?=
 =?utf-8?B?bWJDd3pFNkp3NXZRczBQTmRzNU9QdkVWR04vSFhzL2ZPY1FtWTJ6ZFhwOHpW?=
 =?utf-8?B?K001TUhXTTE4TFFpRjRydURxTUVxWDJOdzNWWGRYMEpmNElreFIrVGdoR1dk?=
 =?utf-8?B?b0NGeUlvNWMweWR2NlhKV0VsQUJUaUM0WEpabHA2QkM5c2VmZ2NEQlVRLzhU?=
 =?utf-8?B?UjhpVmlvcFdWazlmQjBKamZnZkxlLzBlUDVjMkhhVUdYYjNLcmRteTF5aDJ6?=
 =?utf-8?B?bGRnc3Rpdng0LzF5Wll5azl0cGl1czlCQjZmQ2pTa3QwS2FYVjM5RGhKNFA3?=
 =?utf-8?B?Uk9kS3VVbE9Va3RqWTcrUk1FTDZpYk5tMUpRdlhTeWRSK1huVStQcnF0MzJE?=
 =?utf-8?B?cWFSaG44WGRiZlFJaWhTKzI2ckE5TjhkY2JrMGd3SEVBWDhRbHRrOVgyOE1N?=
 =?utf-8?B?aGQ1M1ZwalA1c25tdzhtTmZLcG5BWUF5WkRtK3E2aTQvZC9ic3BWNXhZdVpv?=
 =?utf-8?B?NWR4WXFJNm9CZEVrN0s5Qk9OUERBb2kxejBwTExOZFBXMXUzQy80VWFXRmZ2?=
 =?utf-8?B?ZHJaMWswSDlXbG1Hc0d1amFvY3c3bGRabFJ2eDVETVZMVjNLQkFEeEpnSGIv?=
 =?utf-8?B?WkdUMG01U1JVenJSMVl2RWNKWnlJTldWdDlKVFNTalBBN2Rsam1KZVBTaW9Y?=
 =?utf-8?B?WFBvbG9jWW93RFJYN1YyMWdVSWFpL21zYlMrZmx5T0wxS21QdzJxbXpOVWgr?=
 =?utf-8?B?ZmR2dkFZTzJJeTlMNzFLQ0M5WmtHUEZra2thck40b1RlUUcxdnFuYzFTNnk0?=
 =?utf-8?B?RDY5RlJKZkZDeEJwYUdsU3VrL2ZRMnBqa2dXamRoN2lKT20xMGo1S2YwL2tm?=
 =?utf-8?B?aDlqNHBPU01mcTVVeGVwejFOcUs5eXFGeUJaOFl4cVExUE0wd0p4a3BLTVVG?=
 =?utf-8?B?TFdnTURsNWZPd3Yxb1o2RnM0dG9vcWJxWHNUc1BDNnEvSUxMMk80Z21hOUd4?=
 =?utf-8?B?a1AwaVV2SkFvRDhOdC91MFhkOCsvWEpmWkkwTmJYZ3lVeXBTQzNOUWhMY0k4?=
 =?utf-8?B?YjdvS3E0dURHWXUxVDZ4UitiTytQVTk4UDlkd2svbW1xWCtwbTR1OWtaV0l3?=
 =?utf-8?B?Q1Q4dDlybjdXTTREZlRhclVGR0RVM1dCMTVCQjJCaWRKM1J2UVVPREhXS2lo?=
 =?utf-8?B?M0ZqdzN3ak1tSlprZy9QaWt5QzdHVVR6cTZwdlRpa0pGOGhtWis5NSszNFNJ?=
 =?utf-8?B?NmR2VnAvRmVKYnVTQm5DNnVmOHJDYVkxVVBwcGM1Y2YrckErZWExcTRjdTJk?=
 =?utf-8?B?VXllbjBNdVVEdGNEeC9VVVM1WGJYOENGSC9yeGZ2aTdXT0YwY3NkUEQ5Z1Bn?=
 =?utf-8?Q?wPNU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 18:19:22.5949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9850a7d2-b668-4582-98de-08de31062700
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

On Thu, 27 Nov 2025 16:04:22 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.60 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Nov 2025 15:03:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.60-rc2.gz
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

Linux version:	6.12.60-rc2-g375669e5645f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

