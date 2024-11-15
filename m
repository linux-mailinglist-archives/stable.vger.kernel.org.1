Return-Path: <stable+bounces-93575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B73F9CF39A
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA0C282B86
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6631D8DF9;
	Fri, 15 Nov 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YuFmqSmT"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596E1D5ABF;
	Fri, 15 Nov 2024 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694100; cv=fail; b=JfM8ohE8Vxe69qF/goEvjWihQauQBaVJ9b4AGnNvoN/yqi2iPGgvI9Rhj+ZzdOF77TrdOCPfyLdGUVrXhNXZEUfUdoLC+nqMDBLmva50XS4APm3zPpWQaKtZLgw7e/MQhmjQQCNKZs4tOECCUQjH0xXxE52TaT2JRD1hzpcOcZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694100; c=relaxed/simple;
	bh=jtP1UmmD3FKl2w8ES3KkAUeYhf7j3zsdwaA6huJ0DiM=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=dhirK5x8tUFb1YLtiI4vxyzJNcC2Chef7U2rHWiWasJfaCG951LP3mEX+Mu/xpgmDGyDifWWAZg61CmIkDAjBgtQPt5l8qpuCTUIkEmVLziW/pWuxw8kt7kFWJ0LpH66CT8oTigBIT0v3NDmooZ4wesfuC8Fi3CFfIUvwsxhYyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YuFmqSmT; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIUFS7W682IXduJ7B5LnVexleFCNkh9aJ9TU1KLixVoN0rNmo7UlreQljgmJkADKRfusX6Fxrn00w7U47s4EhgVxq1B7418gRw7P5+2BSZGvazbxR7mQQdoCLsCXBh/4WdT2OQJMCLY85RmvlRwJvNWTe6bzr35wbr0b88ERrR92b8RHkYKN7/1HIYXVw5FrEHAaRJIrqNMSee+J/YDVGLb326PM6ny7kjhfEXHR/xpHO21iekM1rTkDd1jW6LV1wK44j6VuZbjCw602UgRWqNK2G6Usts/Kxbe63JHHnuNtGOCh7ZyizaaNmerojgqGpmdcFAhTmqhG4fXwVc5imQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MowJyq28tS1YjveUjVviUmXnD1WPG4aKusmmbhRRLwE=;
 b=UiD8jy+44EVn5A2MJ1DMiBdTfOHbls4yM5k6zegWsXwmfFJAheX5LP9p0CAc60D25WrHBJ2rZO2BnZcx9Xca9Kn1wUW1fGGLIwRtLPUBuNvyWjf5CjbHPlUwVM3Yu7W5TQyJreWEfyBRGLAuicJhs3kkwQcm+RInQXQ3ROPhHakacaflReAdIEKN4rdDtUIEtEm7QfsLUuOx7KnJe/o/kXOUtMyw19fP5Blx2M66tjO8a6Y5UIea/IbJTZWZs04gYeG5+DvFEIBTM0WLUivXqyqnPc4C7jHF44Up51+mPsDDeYW3qHweh/+WK0DrdksksiyMLKz86Voo56Ny/zQZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MowJyq28tS1YjveUjVviUmXnD1WPG4aKusmmbhRRLwE=;
 b=YuFmqSmT2AXxXDh6m0t2VuxqaMlKscLEV5MI5QiOxvMsfkJYXkbU+XGdjBxY5WSscq/HFml1IkPzT0PEzmVKyw3qc5JieLA4VCIpSKEEAXMGlgmVBeDTgewxJca8HedpDDi/3XwbEBgk/xETo9x3pndJBGjmlmucpgfV4V+mIEAhCXzeVIcBW7/HMO7BIXIz29zuXUIQEYUFlHmAHgXLuXkXhZ2QjHQTDK+7sm9/PfjnuZGOb/Cl9mWw7k5cdTEqfT22flUQTCKhilZ2wSeFm0vnnVSn84LGTcXnPr56miRYDpLXIR6Ws2fwTlzvllkFSTDs+fqV4LXvmnRytNFRCg==
Received: from CH0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:610:119::7)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 18:08:13 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::f3) by CH0PR03CA0373.outlook.office365.com
 (2603:10b6:610:119::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 18:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 18:08:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 15 Nov
 2024 10:07:55 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 15 Nov
 2024 10:07:54 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 15 Nov 2024 10:07:54 -0800
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
Subject: Re: [PATCH 5.4 00/67] 5.4.286-rc2 review
In-Reply-To: <20241115120451.517948500@linuxfoundation.org>
References: <20241115120451.517948500@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6407ca9a-354d-4a8d-9d53-175ada57688b@rnnvmail201.nvidia.com>
Date: Fri, 15 Nov 2024 10:07:54 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fa26f9-0ef6-48f5-e5a0-08dd05a0789c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXB2eit3WmpLcnJmRTcxaEN0VXBpTTR5bmVLMmZwY1JVcjFKTXdIRHF3M3Rm?=
 =?utf-8?B?K09IdGZiUldjM2ljalZLL2VzQzlrN3Q3QS9SbHE4a1RZZjFOSGNNVWIrSy9H?=
 =?utf-8?B?QTFoNms5Zmx4Y3VaVWRZb1lkMVlPZ1NtY0VMRURuZ1RaSzdHRHFEbHZnSkha?=
 =?utf-8?B?QzNqY3hjbFB0WnRwSjNaNnFBb0lCWEtvdTRUbkZ4cEluYlJxZnd5bjhtanRU?=
 =?utf-8?B?TklkNzZaSFUrei9wS09HV0J2KzRwc2pqVVc5dXBhem1Nekh1VlVGbzk2TUQx?=
 =?utf-8?B?cGJDT3IwRUVtN0RMa1k2ZndQNTVxTHVEMTRCeUtLaENxSUxXc0tvdXkxRFF0?=
 =?utf-8?B?YmJYT3hwZXQvOHl3N2lzdWlGWG5MR3dpWUxTQXNFNHZVQzE2cjBmZHFiOXpL?=
 =?utf-8?B?c2hvVkNiY3JET0w2STc1VDhWOWFvWHRiR2MxSGk4NUNsbytRenZkQ2QrNWQ4?=
 =?utf-8?B?SGZoTEdxeDlxeVZlaGVzaTVWRDdDRG4yeHdWcHpwMnRhaDhoREUrS3hMU2Fv?=
 =?utf-8?B?K0k3S0hXako1WlR0MkVWMFhySDY1ajVNNS84WlBjSHlhTXY0WlhiUCsyc3NE?=
 =?utf-8?B?YVJXZUQxYzloRmxsdEkyUEsxQzBydnplOWthYzYwRXNjSFU2VGFBcFh0b2s2?=
 =?utf-8?B?SWpiRk42RHdFODAwdzdBVkw4UFhraXRhdGErT0cvbmg0VkVML0RaYW1nZlFE?=
 =?utf-8?B?RWF1enp6c0Y4dVZCRi9TNWNpTDBheDdleTUza3M2MjNaRnBKS0tLaW1lTXNG?=
 =?utf-8?B?RDZRaXQ1UjFrZTBHSTNhRi94VDN3RFRvMzl0UzdZS3lWQVFZTDhJbm9xQnkx?=
 =?utf-8?B?SkhsVGdBdUk5WEtmUjE0WDhZSEE0cGlQNjdvVVlvQ0c2WHp6c2dtTmZWUXNB?=
 =?utf-8?B?N2pQUDVncVhQWlBTc3BrNkxmeFJvS3lJY2ZnMDlhcGdWWXRPWGxkOExrTkpK?=
 =?utf-8?B?K0E0Y3k5TjNRQU5ER0F6T3NQTnBtTGZ2RC9lWTh2NDRYS1hibFU1WUJBeDUv?=
 =?utf-8?B?RVUyYk9HWW1KN0ZvMm5wYk5LZmNSaUJZT1NGQkVwUHFvcllFY1d1bTgzVStO?=
 =?utf-8?B?NiswR3k0R1Ntek93TTBqcTRGUXI5SnZ5TGpxYktDT2kxWlBDZG9lZk5MMDJO?=
 =?utf-8?B?Qm1vVUlpRWw4OXZ0M1hOcHpnRVFnako2SGZlMWZoOXlCLzdLeHhXRnZvRDNO?=
 =?utf-8?B?U0RDNmwzRnd3eXlQNHdSVVB2YkpTSTZhcERHUTc5UW9OaFlEdmVKdFZlN2l3?=
 =?utf-8?B?YVhQbXVDNUdCL3VPZ1hHU3QwN1YwZURUY3RWdTQ5REIxZFBFQUZNalg1S1Ru?=
 =?utf-8?B?aGdqL1JIRTJ3Qk51a2VvVmU0MUkwNU1WNWFlc0VyclY1L0wxR2NkZjFJOWpy?=
 =?utf-8?B?dXJEKzFNQ29qcWJ6aS9vRTQ1eWxrUEJpVnM3bUNIZHhkQVo2QVpieFZwWVli?=
 =?utf-8?B?Nlh0a3ZNM3lDTlpZeUtpbEQ5OFh0K0Z0REdVRzRFQkd4bjQxUlpiTk1RMUts?=
 =?utf-8?B?TFFMMFIwZXJoak5EbUZvR3JWM0Z2bmh1T0VqZ3o0ZmJnTTVwRkw3a3YzTmNN?=
 =?utf-8?B?eU8yVHRnQTZnenhjTFluWExLcUFqYW9MdWtOa1A1Y0JhMUdNTzZRU3FidlV3?=
 =?utf-8?B?dEUxTlVhdlp5citvOUlDVTQ5QXZFM0pyMmVUeUswRzBOd2dFVHI4N2x1UGs4?=
 =?utf-8?B?VDlYL0lVWGxZU0p5MHMyNWlObWRYdmhmQXJJSHp6c3orTmhXSE5IclUxTzVh?=
 =?utf-8?B?NDIzMUdVRm9rUnBQU3g2OVFTVUxqVmx3b21nNmgvblNwWi8wUWVUeEdKMmdF?=
 =?utf-8?B?R2Nqanc2ZnFVdVBSSnZTWnNsS0ZpSFRuV0tQNUFqSiszWktmbTByVzUwTU5O?=
 =?utf-8?B?SmFLeUgzdk1CSXhybjJsd01VTEtNRFd4T08rd3pTdW5QSWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 18:08:13.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fa26f9-0ef6-48f5-e5a0-08dd05a0789c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202

On Fri, 15 Nov 2024 13:05:13 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.286 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 12:04:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.286-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.286-rc2-gc655052e5fd8
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

