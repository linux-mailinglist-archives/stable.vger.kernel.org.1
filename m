Return-Path: <stable+bounces-176409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF1B3718F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CD7367DC6
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2927F3148A9;
	Tue, 26 Aug 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UzM+u+bj"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E47312814;
	Tue, 26 Aug 2025 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230257; cv=fail; b=BNRFCwxpydfWK2Fl9RDoXYYJmf+ZQs7SBEx/uccUgzGKnXEB82bp4rGtBlwRgW2hqG7bx4WHdEc4WMOebMFQ72Z1BACI3PWQpxbHIQMYVvsgV7a+m6PRWmQvE1t0pdVbsN8MXuggaJop2Ma8sT4j9rm5mWkAzD9oIB6EXps28ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230257; c=relaxed/simple;
	bh=Qxg8Ws4Pk+garjR8PJMOkUsQDwAVStPwWyl9Jb8Gm6g=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=de4jeQwk4aDl5PXfOBYx2H275XIlvMDer/4cvLFqwBSMB/EIhiE/RXyUMm7lW7SqtI+6myeY8hfoXomR63W5cjHK6MxXnkFZGLc/VVKhtNfXJv2M/9+YVsS7C4qCB5EwefVhskfM9A9cgHgCAPwhi3H/7lhXFK6co+L3nURKWPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UzM+u+bj; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXqRbkGR0DljDCCur1JkXQO0ox1FWI9owk6wDwl9T1fsX3+8swDgYNjJExOYP1n//8z540d8YUsd6NLhbBwrF+4Jn8+FQ+BY5hoVRUgO25Fr/BAraWvz6ZwiRq6a1DAeva81v03Vf37RKBCaFAHTaVfTUM1Scg0WWlGN8vNvKRwNc9TZMmpPq57MPqgvyN9iBB2y1bYSHabd2w0Q6nszLQNMlJAe5z2xb2B74DnB+ihXK48DD3F20JifXYaxRPmGH/zPUEczPIZ1Y76VoNhOAsXf6hZPBjE/sJSN6iJwDTpFRe8fU4lzO1MTxKn7BKU4inofEWz6XFyK3CYMX7isxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fudLUWSyyKwUJV4TV/bJV/mhWxD7UNDNVY6DtJ+BO8=;
 b=Emghh15Fz5nCjx3/+fOecVBa2BXJHy5RT431e1Vn8IL6Kc+rmLjtT2vwzpvAXDZod6j5IjWRsRmZWoYnctq/Paq+RkojeRHzxUw2MOW0gD33Z5mmArJTVDJ7eyt+J7yUiT0KI27r+wplY3kxNxEHEsV6Aq+hAjEdrlwsmBpFnGefjrNei1zBgxyLZMIxFdXyRFkeiJqyvmMLQf/tDZkLipOEvnVrnq548p6+Xmy2wRCR6PGnP/+r/sDetUgVTyy4TEyttwt5EaN0baqHF7Qiv7KvznL1V49wbvdMUY/rSZeIixm7NquDpHVwjsslfsnZf72SxYb+ud6gc1izjZn/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fudLUWSyyKwUJV4TV/bJV/mhWxD7UNDNVY6DtJ+BO8=;
 b=UzM+u+bjsThWXOhhynyRlNCgIhx6tq2LzyIqXIZojp9o6zY0dqWHuVWKdbpwDp4OtMy7sFBxHbDZ4+tIMBCGDeEpPS/jQyB0DevVob3/T+YZSi5h2LCGiiwzH12bzfAQ9YzYsYn2cXda3db3A0repzRIUZcudvEj+F6OLgxp0OlRbneRVfFNgYWQGIfts5mELPppFF1A9oMocKuGz5p34kKcv0KsI9q6Uzjel87yVPdZUz6jtZep/mrpifmPVdQMyiywODjmFE65sBskRAGmu40/9CMP2ew6+06bO5P66oQ2OwskrjjdtMKv2IrDgFch2MPfdszg/QEQJql+PD2WEA==
Received: from BN9P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::34)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:44:11 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::21) by BN9P221CA0019.outlook.office365.com
 (2603:10b6:408:10a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Tue,
 26 Aug 2025 17:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 17:44:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 10:43:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 10:43:50 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 10:43:50 -0700
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
Subject: Re: [PATCH 6.1 000/482] 6.1.149-rc1 review
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <017faae1-d368-408e-945d-fb1cd6c018f3@rnnvmail203.nvidia.com>
Date: Tue, 26 Aug 2025 10:43:50 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 0534e4d7-7535-4b51-8cc7-08dde4c82a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGFJaXlrenlFQ0xjdGJKdXRTdngrWlJxengyL1ljTTFnSmdHYng3RkxEVEVR?=
 =?utf-8?B?VW0vMWFhSEdRSzhEeWQrVk91dG9TdkNDTEordDFvcCtIZ3lIRE1WdHlCSzhR?=
 =?utf-8?B?VkdLRTU0d1ZwbnlWOVZQaExvZEdicjVQQ2pNUHdVdFJVbVpiWXg0RlBXaW5U?=
 =?utf-8?B?N0swMUVZUnN0ZHFlVkZoRmtQYjVoL05jV0ZlaTVpb0hGOHF0Zno2bDJwSnpD?=
 =?utf-8?B?UmRYTE03dlhvN290RUtUUGg2d2xjZUVWQzRiUmROWlpHKy9LL1NTb21objJm?=
 =?utf-8?B?ZDJOVjFsQmlFYWdTN095bUZ6WDZkK2hkeisrdkhsTmxXNE9kbXFEREdZalUx?=
 =?utf-8?B?SVloVGthQWlqNnVCdEdSQmk4Y3ZnK0xLbHkrTHZucnEvWFhiMTd2TUJabmxY?=
 =?utf-8?B?KzdKZVp2eG9ZbTduU1N4TUNMZnlWVW9DOXpsOWV5SksrWi9mUHBESldGUnVq?=
 =?utf-8?B?L0hvSVl0Wks0ZE1oZGoyZTMwRnpicUw0WkR3SVlmZ1VUUmRZamhiWmpRbFND?=
 =?utf-8?B?c2p3R0tXbmduNkFtTkNkNEREeGhqTHRwdDFxcGQrRnM0elpuL01PQmo5TWRJ?=
 =?utf-8?B?MDFQdlpmL1pIYmJya3pJK0RQdkdzVUN1L2JuZGpmU0Jsd2syNUtMWlhjSVVw?=
 =?utf-8?B?RUltS2JkcmJOQStFcTNGdjBjV1c1QmF1QzdvZnhKMHhYS0ZsdU5PaTJjKy9u?=
 =?utf-8?B?Um5jMWlJVGhiWE5JZFp5a2NLZjdSL3Q1S3FKUjNwaE1Mc2JPV0kzQWxMS2d0?=
 =?utf-8?B?dklac1FLVmZyblpZOHB1Q0p2eUxZV0g4c2d5YnAzd01oRFVqRE5XR1ozRjFG?=
 =?utf-8?B?YktFTkg1a0hJS0gxVDVkTVlkcysxQVBUcncvWFlXWHlNSnluMkpObWJJYXZF?=
 =?utf-8?B?cHdSdFpZcHpPbjlXNWw3OFB4dkJUK1VVTmxmaFZhTm9WSGlZalBONEZpdFYx?=
 =?utf-8?B?ZHBNMnRqbFhNMUJPNXJHVGdyL0JmTHlhK0NWTFBGcUVMUFZjT3dyR3k0am5T?=
 =?utf-8?B?bE9pb1VkWExucXovQkVWY3FyUjVhaDFqMXIwUXRhR2x2bjMyODlkT2hoaXhE?=
 =?utf-8?B?OURUWnBTTFM0K09nWUE4N1JKM1NpbHlTYXNoSFNSNGlpNFFGS0syL0ZoOUl3?=
 =?utf-8?B?bmhocGJ5Wm9nODArWHJaVWNvNzQ2MllrSkVOK3Y5NUVra0VMK3BFRmQrM2dv?=
 =?utf-8?B?amw5SGU1UzYxVVdEMzQwaWMvcU1tMExXSmtvSG1zWkJtZXBhZCsrdXhjSFkz?=
 =?utf-8?B?Ui9mME5GbmVOMzJvangwbjdScWx1dEZGd3lIMXdPOHZsMGx4UHIxTFdiTXNL?=
 =?utf-8?B?eFg4RERxUndQNGFpRUtweWZkVGFXTm55aW9DY0pSZUN5b1liODFWaklDeGI1?=
 =?utf-8?B?dERPNzBnc2JCNHd2dGdvNlJCZGZGVlpVSUNDdjBnbTVZZHJvY2FBN2Q0U1NH?=
 =?utf-8?B?RDY1YTUzeXlPTHFPbVNMOXQzZzhSaFZFNERpeDZCcm4ySkg1TzJxbmpQOVZI?=
 =?utf-8?B?QS9Yb3hwa0J5SUhJb3lrYXdNako2S05yMmZQRmR6S3FWaGJNRFhMU2ViVjhq?=
 =?utf-8?B?VnJ2bEJhclo1Q2FSYnhpVGxBQnZUY2JEN2NNK3ViWlQxNlpUYk1PK1hLelp1?=
 =?utf-8?B?cG9wTkpydXVQZWZnTVl0YjZvVm1RaEp6Zy9XTFFkVlhzWCtJcjlnQnhwbDVE?=
 =?utf-8?B?V1hMbmlCakY5Q2J2VjN6amRxNnA4ZHlBenFaTEVYMG9VVlFXeCtIRkhxSE1E?=
 =?utf-8?B?NnVFenAwTUNoNzk4dTBGa0VQOVJna05IV2FtNTRTQzczQjloSDFIUXgzZmtz?=
 =?utf-8?B?VkVwYUZ5aVc1ZXFFcHdUZ2M1VmVjRnM1R2tidzBpVGd4NHBQcmVzcUU2RG1p?=
 =?utf-8?B?Y1hHbVB2eDR5Yk1uVnljc25vcFVNQzViUWd1eUZVUWlmZUJqNHM5OWE4RHkz?=
 =?utf-8?B?dVRBZkVDMldXa0VtYWtMRHo0ZjZtQWZjNGhLWGozcHdGbHdlS3BOd0V4WDBz?=
 =?utf-8?B?YWtGVUtseHpBYXpBeU1lWTNCZEJEdjZWVU5lNmlSV01hZmR3c3JrQkViSkJQ?=
 =?utf-8?B?NUI1cE1nRjBkYWhkZkpaaGZiT1F6dG5rRmZXdz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:44:10.9496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0534e4d7-7535-4b51-8cc7-08dde4c82a55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199

On Tue, 26 Aug 2025 13:04:13 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.149 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Aug 2025 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.149-rc1.gz
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

Linux version:	6.1.149-rc1-g3c70876950c1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

