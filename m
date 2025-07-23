Return-Path: <stable+bounces-164419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C439B0F144
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E9D3A5B69
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 11:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8B2DA746;
	Wed, 23 Jul 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S9ZMP50s"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF122A7E6;
	Wed, 23 Jul 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270505; cv=fail; b=OrwzTwsr09x5dCyU2777dP986Pft0uKOYtQn3KtNnvbLk9NpoEiTK+MoXYn29SYRhjgoYO2s4Fx/er2CdmXroIKl72tBOJc2o/dkum02bDduN1fD8QzbtPZeI7Gw3M4yXLpKjRcF0zMdnwKA98+hTU2CpP5cU+swBpYv0n0OIcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270505; c=relaxed/simple;
	bh=k3Ljyj+Gp6b85c8CeOPhMXo77iNcwTPfcDCPSegbz9A=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=Z8Z8haYDad6qVXWQ2YnYrUpIN/F58FotnHseeAEOlzsy5CKI2UUwVnRc5v/nrdxYmCpUiTBbsYLzSpyL6dbgjedg9oHoqw40PAdBCL+tlodLyFiPtorgtdwS87MORo2yXE+XkFe4lEHkonZRVy0USE3DfGqjCejhEMiV7SdczCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S9ZMP50s; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KO3EJ3OH98hRrg8m+WVcXD7dzo79ocQHRz7O1hgivfUIBJaGAtS6UGB2cJKRgcKr2JAZlzu6KmQIG0tjky5iKunrrzNd6HNAy65sGf8RE6C6gGqLlSGRUj4TTG+gwzK82N86NeInLssIM2Sg9NItNg9EbE6R9SeOcWXv2vmm4eEPwCSFtFDAXuy+mjhVCKXEyhNMaS/BeFTsqxnZr2x/+rN5g5rMdmcr0iSbVZkBiUz5R87CRwqLmwlItxhzHoaJpU3s9yO4HAX295qO2ouQwajCYGANQJREnF30z+I91JYkOsZz9i/Quc3xLlUMRp0n1euH/VBX9I1n0OJx5pY1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlzR+tlYDUBSfAip9hhYX+oHzy9nnItNaGjsY6GVizc=;
 b=t4l79Jn5aBYjxtmfnivE8A+A2fIcILRVJ9DVm81BzmnwZnKvhV9cSDVKi3C3ocb4JtpoJfg8s8owT8T+qcd0+EjLh/z/R8n6dvlmEF1S5BttzwEBulQnyls4PG0v2YD98mIavepdQOK31viX3z1ApsuYpMgYzsfcDqRyrPfbWdiaUW2Br7a9niiIM0IZX0g14bA3nyeeRYMhsDzUNO4cobK7Ok4XiImCkHC0tH9cM2V4EMna9ltEOxsX4LutVCsjVrnKVL1MJgtG0rhufb6GYRtUQPuJATZ2ryVYTGxzBVp+lnRb9cHFT/qpVBjfdCkpPBHs8NJLMs3snPRoMkUuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlzR+tlYDUBSfAip9hhYX+oHzy9nnItNaGjsY6GVizc=;
 b=S9ZMP50soQ6lXvhQBEwMxcewkRnM/gxBeLPZNgPtzzGvxXQoh+S1YvE8Wfg47aARyku25zZDhIoJHElAs2wUopToLHL8ey3n46BECbjmb/DmhI8nwJNdARU9MeFkDNcdRvFOq9rQnTsKelAWT+DXdfydXS6Lw0vQEq4ScJ8pbuZSzsmXuZQDc/ubDn1FmJwyu6edrTCcZOUF+SOHg6wLL5cFlxRxApa05bPK9eD28GgrrBWDs5pjObfZz+yAeB/U2K6++hqF1Xgnpm2XJMS7HNl+EkCy9Yu7x01fEmDxu/dQoUaVViFAM20wo+fXr0MSdEHppcYxZsei+bYQaWIl2w==
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Wed, 23 Jul
 2025 11:35:00 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::d) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 11:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 11:35:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Jul
 2025 04:34:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Jul
 2025 04:34:46 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Jul 2025 04:34:45 -0700
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
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
References: <20250722134328.384139905@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <10412ac7-b76b-4489-ac68-bde0da651918@rnnvmail205.nvidia.com>
Date: Wed, 23 Jul 2025 04:34:45 -0700
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8f733e-5a7a-42b6-a9cc-08ddc9dcf557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WldCOWxhek5McEovdWF0YmdsOUp4WVVQd0pjYlhRQ054TGx1OCtvcWhlU0Rs?=
 =?utf-8?B?ZjBLanJTM3R2OVN6bWJlVU9aQjZxRnVpR3ZVRnM0UUt2N2ZyWUlDN2Y3VUZl?=
 =?utf-8?B?SVZOTEJYTEdKVlJFU003eTJsdFVBZmtjcEErc2hxeVBkVmU0NTlsbjcxY2hG?=
 =?utf-8?B?aUFQMVRNSEk0WHd4NUdiU3BsMkJrVHNaSldBMUM2Z01jSWs5TWtQWmREV1pK?=
 =?utf-8?B?MzJQdVVDVTMwenpzV0lRQ3VFRm9hc0w4Q3pMdCs3SXMzeW9TdjR0SjRiR01u?=
 =?utf-8?B?NE5YQnZ6Snk5M2ZmRHBNWW5tQ0ZVaHZjR0txUUthWXhsTTlwWlk1NEtSNnBh?=
 =?utf-8?B?SmtHN1ZKUEJLei83emZqbUNoMW0waGM3eFZ5TkVqWXZPd1ZCWnpIbi8wRXRo?=
 =?utf-8?B?Wk5YT3JmbEZnckF5cER5TEgzbTZiVjZBcUYrWDZ1bi9jY2hnbHppMG1uZUFT?=
 =?utf-8?B?OXF3OC9uZlJOSUl1ajJEK0VTVFFuUUFIaGt3UTI4NWNDek04YXdxZ3IrYUN5?=
 =?utf-8?B?UjI4NlJDcFJnS0dNOEFYMWJ1bmtteTAwa3V3TWpCYlViWU45azZjbHVLUUJv?=
 =?utf-8?B?YnovT2FMV1BhYTg5QUNRa0E2UStwVFg0OE82ejNTN0NySzNFTHdyUHo0Z0VW?=
 =?utf-8?B?OTBNT3lMdUFRc2FFTlFYeUcxUlNzTHI3YkhGdmFJd0tQREZQcXVsTloydlBs?=
 =?utf-8?B?dVpSaHFEeHI2VmdJUGRYT1g2dzIrekFJdFc0eVVCV05PQ29JVmFjVWViU1I4?=
 =?utf-8?B?N2FrSXhQanA3d0ZrUmd2SWc0dFVaMW1wNExlQ1JPQXcvdFBhRjM1c0lISUhD?=
 =?utf-8?B?NVphb1lTWTB0Nmp4S05MU0pJYTdlalBEMVN2N29vc3dWVmlxTTM4MWxtUlRy?=
 =?utf-8?B?c3dPRGxnQng0SnVUdkE4Z1hwQnR5eVdINlhxVTdWQUpzV3I0V1pWU0MrNVpa?=
 =?utf-8?B?YmNycEkrellYbURibzRMY2hReUFyNjZBdjVqSmkrczgwWDhNdTZsZjd6UElD?=
 =?utf-8?B?OXFScElrNGRQWWNNUHJGNWpFR0E5dUhicGVsUVhDVHI0OUZFR2xST1ZvMkdt?=
 =?utf-8?B?TGR3alByZUlNWnhsTEhaZG1hRkR6WTZ0bHZvZ05oT0ZjQ2Q4OHNZQVhNckR0?=
 =?utf-8?B?dEk1UXJHZzFLbkhWYjBURmVQRFJHNE1RUE90THl0Rml2ZEg1NXltbjFRN1py?=
 =?utf-8?B?TE55SDNBUWhhbW81Vjg1bDVyY1F5NlAreGg4WkRLWlBvWGxLN3FWOXZ4V0hL?=
 =?utf-8?B?c3MvKzRMMS9ZVUljV3UxazV0aXp5YjVRRk5xWVdpSzc3eDA3UGhxenlucVY0?=
 =?utf-8?B?VWNRY1JkSkduZTMvemxDTnVxUnQxczFkc1Vtbk9FQlEyNjFGUDVpa0lLeXhO?=
 =?utf-8?B?TXB6QnRpZ0h4emZiTlpjYmR2UEt3MkdpMFBVbFBCLzJhN0Y2eXVOOXZPbXg1?=
 =?utf-8?B?UVdpN2JpQTRpendCVHgzWEl5cFNkaUREZVVXNHQ4Y2R0SDAwblpYdlJFU2wy?=
 =?utf-8?B?dWNhZzlSWTZEbWNLRC8zL1g2Mit2bnNIQWlqQzVjdTZMMFlzbUQ5Y09VbVBl?=
 =?utf-8?B?QVB5aVIzMHNZVkpaVUNZbVhDMUU4NzhxNWFQUEpmckViTTJzWHd6cTZQckFO?=
 =?utf-8?B?SzNSMlJOSGJ5Qllsa2FnZ1FiVVVvTXVYT0NWUktJUE5wRUJnb29ZNUZiL3RW?=
 =?utf-8?B?aTZnU2xQeXZzYzRPT2lwSVpUczlqU1ZLOGZ6MWlNQnVhZ1dJRUhMTk83amlG?=
 =?utf-8?B?RlZFRkNybmdaT0pSV2kxRzFMeVNpOXJ3S1o0WUxkVW1mbXJET21lYzJOcGNk?=
 =?utf-8?B?V2tVaGh6ZSs1WnZUam5acEJKUVdJY1h1TlVEYkFKZ3NiTzhYak5tc05CZFd3?=
 =?utf-8?B?Ukdvc1FWbEd4Wk9uVUZyNlJ1R2d6WnBLaVk0M21Id1hhdzdmOVR6SnY0blNP?=
 =?utf-8?B?K3RxWmovVCsxLzBuZ2loTXFwbmlEa3FkS0tUYmtsRGhjWjFwUG45bHMrVkpx?=
 =?utf-8?B?c3ZhampqWk8zMXN3YWN2cnZOU3pRYzgvb1gvNlk2YW4xVzNmL0dZQnYybmQy?=
 =?utf-8?B?NmZQWUpvckVDbDZDZlVlOXowNWFGRWdpblYxUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 11:35:00.0825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8f733e-5a7a-42b6-a9cc-08ddc9dcf557
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243

On Tue, 22 Jul 2025 15:43:56 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.147 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.147-rc1.gz
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

Linux version:	6.1.147-rc1-g3a0519451f2b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

