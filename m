Return-Path: <stable+bounces-161450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7FCAFEA72
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482411C4806E
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69F2E0910;
	Wed,  9 Jul 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WgOfpSJW"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32EF2D8796;
	Wed,  9 Jul 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068409; cv=fail; b=kqvoqL2M1fGgGsR1CDDpe+vMIdmH+QUCQewZakNMbGLRz8SJ5NKGHp5QGRRvi9Htnko0arz+4Lbah0Bd8RXsQhmzzcFf3vMh/m+Pqi7A1tXZNS+1Xdv3bG2UkeO2fHTs+wjf8fhK76xn6QDm9yfNVgDpBStkjaX2+pbzOfBjegM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068409; c=relaxed/simple;
	bh=hCt6S+nL9mcIKBLI0Z4qj9zXv8G+BQfD8TX9+603rWg=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=Lxv/wTKNmBrJpz/Kk2mzMHBH5bBKXoT1d1W3V/Sj7+2A1+AOQopdFRhbFpOPDngYbKxUiw1/lO9CIPsIfC9T2UC9xJYef3jUXz7yNC04LcRIzLzpOYxS4PCJMarH5hTg7+gMVQo8L7b5q7vQKhLySONgHxXLaxmNgJc7xMcSR5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WgOfpSJW; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLLjo2ngNRw1Qe/PV5/StuFcvBPDRCxu+fsLGD2gg8xzqrpVIHvrflEO+VIwOdZvntJ6hArwXUGkhbVXGjSiVg9G5tC+gx8jnQpojQ9CB1u8+7nyEl2am0j+IG1IZMxeH8linyTzuVs6BOER30pZGX2Pta2nbmoAlGKLXwGmu9g06M8QOQskkzCdnWzAjpKLPzve/Z0CQ4gmj5PIqb8Y2zMhjzmJabHv4meUIg8Bb93nEFitSvU1omlwGC4CS/nq4NAcdLlskKs7WZDWHzDjc2or7JXP3l4Z1cEtvl+Ox3S9e/4ppsY+3+YtpZJXQBrFrtt9zMSbSd1oee/YWWAXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPhFuSru7fesli1fDsroAboMWz/n8NN0AIiQRdwD41s=;
 b=t4jLmsGzftctJTn/5A4iArNyOQdIbRWupH3wJI372OuKHwX+oSXS3BuvZ+x0eIfaxbSc/f6Y0DIkxYu9FjBvLlxrlmB+v/ClsMN9xTpo+APPR0FhL0fMiSJWkhJfPFP+4HBP9GRj/smcrXz1r9SrXgu4XYd3vU9dZjpAIhZHVc0OxvKBGgKR1ryiHNa5ogtyerd4Sec94pNulS0N5xsKuztJ3jA+YNNaE7rUnLxrOWgmguHUJIABvnV7JmI89pN/RrmMRMjSS/Bg4Kjnrn6+7VgQF5QAUZetvLkKwl2QL0Wo8Oyp7iK6iauAbCMRn0qlbquClyICB5ej9nn/n9Yczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPhFuSru7fesli1fDsroAboMWz/n8NN0AIiQRdwD41s=;
 b=WgOfpSJWmCtW6qzPOrowYMaFMH4wlTuwW/AaXjgFmsCjcQ+nIKkuYTSU2Rn8MjnAcDjXMjJs5/FdFe0JoeQd50aLlwodf+CAhig6BKsCd1nlNGV4RnyawKwOVjc/M6Xt+cj9p5bBgzb2I7uXSuR2UJbybsWFa3t8lP/PO2lP9K2hxBGH6XJiPbAn9MDt+0rVhRc4kM7/9yBERJiiFdFZxMRZ1dI+nPpJRW5HVSBMg7NmmYd48mv7cNbkBFqD5Xh1+IGmgl05v1H2S03Ialv85nSK2akqUPnQ4RIpWM2n2wsWfGFl3jnJOQ3iUcsOAu46xqQOulFHwqXQRL2kve+7OA==
Received: from PH0PR07CA0031.namprd07.prod.outlook.com (2603:10b6:510:e::6) by
 DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Wed, 9 Jul 2025 13:40:05 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::c) by PH0PR07CA0031.outlook.office365.com
 (2603:10b6:510:e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 13:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 9 Jul 2025 13:40:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 06:39:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 06:39:47 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 06:39:46 -0700
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
Subject: Re: [PATCH 6.1 00/81] 6.1.144-rc2 review
In-Reply-To: <20250708180901.558453595@linuxfoundation.org>
References: <20250708180901.558453595@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <727863c4-f086-430b-9720-36d4ec3654a1@rnnvmail204.nvidia.com>
Date: Wed, 9 Jul 2025 06:39:46 -0700
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fddf9ef-4e2c-4057-c1f0-08ddbeee1c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzMyOE11TG1YNHU1d2FwaFplcG1reEZpYlRpYnZtbGdXRWhsR1NGYlRBSGJM?=
 =?utf-8?B?cENQRk92aE9oUU5aMFJad0llMkp5bHQ3TGM5bFhiVWFUWnBJdFIxVVg5ME9V?=
 =?utf-8?B?MWFDL2x0eHhQNXgwK0pvcVJxbGZiZS9xSnBLYmw1Yzczd1hDUjY1Y05jdVNh?=
 =?utf-8?B?enlHTUdzUkRmR050Ry90Vm1oTHVpeFdOa1VuTTF5aWIxNVAxWWRHU1JaVlZK?=
 =?utf-8?B?MzZXTEovQTNHdThaQXVRR0xMdEYzcythbVl2bGh1OFlpeUJUWmVvc2JZTTE5?=
 =?utf-8?B?UjB0UGxtaG1HaU5PbEViRVU3ajN1RE5Uc3lHelFkLzVJWEhxdGZJS3VvV0lG?=
 =?utf-8?B?S01TNXNwUnltN1AxQmE5NnBCTWhiNEhoRzVrSDJaZlBla3g3M3F2bFZLNzFj?=
 =?utf-8?B?eE8yZ2RUV1NTY2swei8rNXkzKzdGZlpTT3VyUlByS0QzbHlybGV4T3JoWGVw?=
 =?utf-8?B?MWRFTU5QbTFVM3liZTlkN2RXZVpHL2NZQzA4TjFORDRDdzgzcWVkZ09ENkpl?=
 =?utf-8?B?YldxZnNHaEsxU29tajUvZWNmWldBemYyNG1tL3pSUGI2REx5QzhrVGZnZE43?=
 =?utf-8?B?SlcxR3FoVEVWRVhXNjVMK3MvMXlYQi9kaWpSdUd0N1hVMGtNNkpGQy8vL2VM?=
 =?utf-8?B?QWVBRndwQ0ZLVDVZNDllYjNoamhTOFhvcTZXWjBHNC9jZUxmamdka3dXcVk4?=
 =?utf-8?B?Q2xaaE0zTmwxRWIyN04xZFRMNWdFYm1nWEQ5aEtaTGJ6eFdRYk1wdTIzNXNo?=
 =?utf-8?B?TGxSeVRmQlRpTmtIMHNIbEpkWHlCWkRUUWlnYlZoekp4aHlBTUpCK3l3Qy9N?=
 =?utf-8?B?Z2tBS2ZvTjBjQ0pBWWl2dXVLSEY2bUpGMFVlT2NrWld5bS9vditvWGlncFFD?=
 =?utf-8?B?citvUCsveXJlSFMxT3JHOXhkSlY1VWlZVTVYQVVDTlYvUkpyS1IxTmpGOU1a?=
 =?utf-8?B?RXVTNm54M0t0M3YxdlgxMHRYNmM0L1ErMFNMSUt1Nmd0VzJLLzFhMU1kRkV4?=
 =?utf-8?B?RkFJNHpnYjh0YytvWFFCOWpqQTUyOFdabGZpRnE5YlE2MWl2ckRab3IxYUZY?=
 =?utf-8?B?c3dTT2pDWGp2UHZSeHU1OUhXMjZ3ME0yUElxY1d1V2tET2RsVGt1UDlwUnJM?=
 =?utf-8?B?aFg0NFdoZ3EvUGhNWk9Ma3dwV2k4SEdTeW5xSmJkaVY5RFc1VmZMNDcrYndL?=
 =?utf-8?B?bldPRXFDWTBnbWI4c0lVNEFYMm5NbDVxN2pjb3dpNVRPbGtjcXhkdURmSFQv?=
 =?utf-8?B?VzVEeFVydGs5MjBzSzdGTzVmdWdlOEdjcEhxbjd0RjZ1RWI5Q1I3RklZQnNp?=
 =?utf-8?B?QjR3eDAvekpCSU94OWJydWwxd0VQV2FTQjFJcjVEUkFxQWxMbXcyV2R3SUJC?=
 =?utf-8?B?YnNMWUxHTThrbFdQVzh3ZStDUzFSQVYrNjY1cG9uU01kOHpQTFRla3h3QkNo?=
 =?utf-8?B?TE9SRGttdFVQVi9URXlZa2JvNzA2SnprNkZQVFhpcWpNYlUvSDlLalI3M1pw?=
 =?utf-8?B?VWo5aU9FZ25OOXZoTmdld1JuQVg1S21WN3JqRjZWaS9ySlZtajl4c2I3aGky?=
 =?utf-8?B?N3VVWXpvQ1VqSVZBdEVwalN0dkptMXJJbWNjM0hZckRwaTFkNTBrejM4ZkFC?=
 =?utf-8?B?bHlyVUIwZ08rS1pETmZlNHhycjlDYnNFZkhWN3RzVS9pd0lNR1hiK1F0aE5P?=
 =?utf-8?B?ZjJ2M3BMSHBOZC9abUtjWkZkd1p0QXlTdFJJaGlvbldJbFovV09OYkRxMXZk?=
 =?utf-8?B?YUlzMkpydmhLaUo1b2pCanQydmppTVcrZEpZckhVanhCZHlJbXhhTWdVeXFh?=
 =?utf-8?B?bHpyQWJiREhDdmxZbzBlbERZV3oxbXZ5VlE3OUgyN2treThjSTlEVm1CcGZL?=
 =?utf-8?B?WVdWRjBoTVNHZ2JXZzVVRUtNRk5mWjA4V1d2NitKdE5OLzhlRW9rU3dRaU1C?=
 =?utf-8?B?bEpHRldLb2lid3pvV3h3VWRBTDhJUjA0V29kYTEyS0RuNkVMcVBuNFg2allh?=
 =?utf-8?B?eDY4aWg5TGlqd01oRThtbmtHYnZIeHhoSUwyakcxNGNLUGU2VFRobWpVeStv?=
 =?utf-8?B?Q0tUNnlYeEQyZnhxbkhrZ0JDNWw2VEFuMEJPUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:40:03.7532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fddf9ef-4e2c-4057-c1f0-08ddbeee1c11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597

On Tue, 08 Jul 2025 20:10:16 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.144 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 18:08:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.144-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    10 builds:	10 pass, 0 fail
    28 boots:	28 pass, 0 fail
    119 tests:	119 pass, 0 fail

Linux version:	6.1.144-rc2-g10392f5749b3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

