Return-Path: <stable+bounces-181497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23266B95F52
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA4188FE7A
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC8326D44;
	Tue, 23 Sep 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D/a4zlfq"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332EF324B30;
	Tue, 23 Sep 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633056; cv=fail; b=W3kyiZc4x8YT1+QgzExBz/ZfvZ+GOvwhbbIWTC2qEKXYBCFe1Qy/lIJ9FxnAPDPGcUESz5JBAvAoZNeYeqdmNORB5PoGsVlwD3Wst8GDWQQgZq70T/OvSfkDodY755pfI77fOHR648lW9bSL2vxM6WyzBu9WfFrYRdVbROii5B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633056; c=relaxed/simple;
	bh=sjdBuX+BHkkYj7W4eK/N6YqYUb0C0beJVkp24ls5scc=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=iTy1apJ4QT8NCXKnQThwlKkVGzIjxiAgTsl+0nKLa8vEBUvQ1Ky6W8GE4aPZnyVsrdK5G27EemAcnZG3++2bz1vErtwFh3Zop0ORH22j7S2qUzNG3dn61ydt0soI4fMRy9cAoHL+kkzNgjF9trR6Qkw1ntRf20CszlP5bRGDy1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D/a4zlfq; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNu1De2Vv2KrKsw6/cja1OAkeaJZ4EY8pNV/VfW27m4pe5YdDgsDfCpVHLDUI4AOohvqXMvq/pu8ZBprPP15VBZtbGsPmT9R2NsmRBPDuzJ2LHya8bpz/jSUtej4sck1osLAsgAUEhwSN7gK1pmOmj68h1TbepynIUnsMrje40qtA8KBCDEMtC5Jbu0YtV9g6ziqxOi8Y4wOTUA065RZAkSLNgCSHhIlbiekqfMg+ec34QR9tFs5xEHr4nmg3nsEgyxOiWfE+mRq01k+USHv1TUAGHQf8GcE+E3bCMK2RJbHqQ2nfuAKgsApDg/oYJegBzDj09/p7mGckVf8t9DKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L63xTlacJWUedsmKMiA03qmlv/DqreTvLBxId+7qmrY=;
 b=xoWeeCENZ67FONb+DyK9ZfEY91cgORgMmMVviSNmMe8Tm9uR4ycJyj3IVxjj4L5USa2EW72pDZ59WfLUCGUVvfMT/0kwi+7CtZNROm6fS7m3LxVoLCe9V5BnmqemVB1dHfqY6Bug/3TEsvovOV/CoHOEto1uOAuchBKxwaIeSEY1HZB6YZpWHr4pAyMM5HiJkj+2yNRN8nl7HfxSGSZIVZdNVIamRmWFzOLLHn4tbcpfK8Ihe4tmwHnz9w2rcslD/VGE6GPcxfFpnVgoUgmPPWR8tUh5/R2iwJa5R56eGBF5qnQxlbhNOeV4S352NMESPsO9d4ZD0O2t6rNnWZBtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L63xTlacJWUedsmKMiA03qmlv/DqreTvLBxId+7qmrY=;
 b=D/a4zlfqb0rjfT1RyM/4/CS9vhOSltsIMsOm4yI1i5/kBO5qtxsP4TkCHNiRBjB0nsqQ/ovk/FowDp9/m/5uVKbs7yfRtcskoRDxaNBPUDqg7AUsH/Yqy8ug6jh+/gE0mD6qnIT0SfTcQwiN9wLoL+gKcqN3afCEpY86oLRvATRcMQ2GM24gT6RieL/3q/gbNdtKkw20ViSnbNCvJdRpccQg0MQ/YGw3ggmKaWlVSSX9/oJbWt/wRwqELdLJX4qJTU+fDvQK/YuLeskV8/QqXESEYd3PgmlZ/KkKjmhVIapgvryIv/g28EBGVRTaBXCrWlGr68FHJvHmN5NgT95F0w==
Received: from SA9PR13CA0044.namprd13.prod.outlook.com (2603:10b6:806:22::19)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:10:50 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:22:cafe::26) by SA9PR13CA0044.outlook.office365.com
 (2603:10b6:806:22::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 13:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 13:10:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 06:10:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 06:10:32 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 06:10:32 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <hargar@microsoft.com>,
	<broonie@kernel.org>, <achill@achill.org>, <linux-tegra@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
References: <20250922192408.913556629@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <d4d35374-941e-442b-9726-5ea83b944463@drhqmail202.nvidia.com>
Date: Tue, 23 Sep 2025 06:10:32 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7844d7-8d8f-412c-ebfd-08ddfaa29df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3JTUHVBdVRDZjZCbEJHaHFQdVk2U0N0dlZDUEo2WUlUb0dsNGNRclNPZ3Mw?=
 =?utf-8?B?REhTL0JQV3N0WDArRVdNaW5lcFFrVUJnUlFsMjk0dUhtUW5PeFdBU0E1SU1B?=
 =?utf-8?B?L24vRitDdXVpK1hEQjNWUVQrSGtkWXFWQ0MrTHlvcFpiNnBkcGFwdHRMUVJH?=
 =?utf-8?B?bE9JU1dPRkxLdWhDZ2hRNHNYck9tOFJ0eFNoR253TnorVU5kK0oySEE5d2dU?=
 =?utf-8?B?OXR1NXdScFByUDE1ZlpPZEdmY1NydnVKTXdiVmN1Ulh3MUd1SGtNcXhqSGMv?=
 =?utf-8?B?NFFLa3BPeUxCUXJJcXRHeEtUcmVSVUFSdkNJQ0lPT3h0L3JHeG1EMkx6MmEy?=
 =?utf-8?B?OHpZOFoydXRCNS9vRVJ2NFZmZThGMzMxaFRhVXB6M3BWTFdLVkwrZDNBYmdr?=
 =?utf-8?B?Y0xUNWw1Qm5nNy82Z2JJZi9ONlhuQWRMQUZzeVZnemszVnRST1d4T0QxVjg5?=
 =?utf-8?B?TWx5Y0NseDAzclFELzJ2NjFYcnRIM0IydDlxSmdGMExqN3M1WWh2emV2MVhr?=
 =?utf-8?B?bVBXL2NhQm1LUVZjMlg3WDRobFlJM3ZxUkh5YUxvWXk3eEhicnBZMXlvaXUv?=
 =?utf-8?B?LzBobk9VUDhRY2p6RThZaUtKTDM2b0tUeXFiU016dUdpM2R0Z2FMaE4yaGhK?=
 =?utf-8?B?NXJTdEM3WjJabTF1UHVMSlphUkluUVFGQys3b294eXU1RTBRbnYwZS9ENFNN?=
 =?utf-8?B?K1FNeHo2L2lFb3krcUNLV1VXU0J4dTlNNEN2MWpqU0d3QU8vdmg2SktXeDVZ?=
 =?utf-8?B?a2pvWjQ5Mjl3ZHM1cDB1WnRKRERqMUgzcWJUOWc3YThwQUdyZGxsSTV6ODBQ?=
 =?utf-8?B?a1VEbVByRXUyQkNTdEcrVElJUzFoM3I5NHFLNDVkMUE1Z0pTanJvWWNjYXY3?=
 =?utf-8?B?Nk4wNzMwbXNoT3ovTGR0N2J6R3k1Z2ZkdG9MN0ZWQTEzNzE3N2wzRWllNHhJ?=
 =?utf-8?B?VXY1R2RxWFRLQ3ZWdDdFU0toaVpXSUdXdFpjTzd6bTVudHAyZldLZVRKOU50?=
 =?utf-8?B?Mm9ZNzJ4VFhjakJibjcyeTQrVW5abHBxNjhCQlpSV1BxbGdBN3J1RGhsekhB?=
 =?utf-8?B?U1AyMTZoc1NGd2VDRldUUnovSyt3MHk3Um9SVnhBa3MwaW1NSzdIdW90bUNn?=
 =?utf-8?B?bWJwdkR1L3J2NStmcHNJbXhRNENkaSt1Y1g4bGc0UytpT1EyaVNFM09UN0Vt?=
 =?utf-8?B?L2NsUFZFeVNoWjZSMzB4b2tUQ01tQ01VTkVVYlRveUhSOWM4YkI1bWRsVlE5?=
 =?utf-8?B?RDl0Mit5d21nc0cyK0U0NWFKWGRkZDBTRUFuT1FxbWdiSmNOZ3FldytjUTVK?=
 =?utf-8?B?REd5SXNiQXVhZkMxaUdJa3pMZytuNjRVcDhTRWVtMlQxalNvNFpJK1lYNGFn?=
 =?utf-8?B?WFkvRG01dHJnM3EyZTcyR1BhQ0F4d0Q3TGJqQkhmM3ZMNHM4WTlEY0pJeGhq?=
 =?utf-8?B?ZldiUGJKaDFzSUtrMTE4QkkyZjh2TjZDb0FGZGdieU1wZUI4cW5FVlFnYmVr?=
 =?utf-8?B?RlFncUVSb1RWY0Fpenc2aXBOMFpqUENlTGM1UnJtbEd1T29hc1lOaFJHbjVJ?=
 =?utf-8?B?WWtuc0l2U2JISmNPcXZPMFRSd3VDeTdDd2xUb1IyWkE1MGFWdkpSa1dXMnEy?=
 =?utf-8?B?L2VNbTlkQ3NrbWpkamcrSkpISzl6QXNsLzNaN0I4QlM2Vm43bVlGS0xaZHlv?=
 =?utf-8?B?VCtDcEhKQlRsMGpvd2FTbkFzQ3VVOG5nblJIaHl5Y3Vtb0YwOGdwRDA2UCta?=
 =?utf-8?B?VVc0VHNPMGFLUS94bWFsYm1KRzNPaDBVeXBXRk93V0U2SjJuMGw5ZTZkQmc3?=
 =?utf-8?B?c08xcUUwTFVkdnh2R2dFNWgxdzhUbnJjMzhmejNPYXVLU0tSdmErQ0lweHVE?=
 =?utf-8?B?UDUwYVdJOWJucjNtVDB1YVUvNDN1ZmtEcElINFgrc241Q3VMVWVKVlFLUWp0?=
 =?utf-8?B?ZlhBODJmazBSWXNiWFNteGM3dTNUL1JPekdQdWlHY084aUwwcUhsMWEwSGZw?=
 =?utf-8?B?NzFUOWFvT203a01DR2pTeGJnQXdVTU5qMVd3K1A0S3VaWUJXNjl4dytqcGNM?=
 =?utf-8?B?dXZ1dEdDdFRnYndKVkFpSzdNdkNHRFU0dHpsdz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:10:49.6646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7844d7-8d8f-412c-ebfd-08ddfaa29df0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287

On Mon, 22 Sep 2025 21:28:43 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.49-rc1.gz
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

Linux version:	6.12.49-rc1-g1fcc11b6cbfd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

