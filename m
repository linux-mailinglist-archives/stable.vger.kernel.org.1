Return-Path: <stable+bounces-2832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FD17FAE51
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 00:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D831B2130F
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2996495E9;
	Mon, 27 Nov 2023 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="apho54sU"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE041AA;
	Mon, 27 Nov 2023 15:26:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc+nNhjX0eIpNlK3XyKM1F7ybBJnwTq6OuVMNLQn5svCkmNy+idW5oe9vRGpVCyb76zBuF7NeL279JQoIDGiEOFhzNjxwYtVLaRsTjhrPWjMo4fHjd2UfrEeoGEze98vEvg/Pjv7U/kNGUU7j8+tAzVMVfT68Ixhc950cqWhOx+xigZv9L0HCQla0ADVMc8DPyWW72uKNdHPMZvgRJ2281s7JTIFwqAkCwNa3bpZ9HFd34xPVeur094zO191LFkqRImXDDLU1ekuDA252qElHxkRd86QTKl/hTz9AaYf718w8IpwZo4NFfQNcrFbr8IVzdqG5Kb+P8EruucWiWa2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARV1C4nVgylpdQmlyLDeyLgqILjqZyY/SQVoQYw9dGY=;
 b=iBLK04AmmHLvI4qeEBHGW0WhocqMTe0JK5Tt3H9Nwd+I73varatXr4tUfaRswQpIguV/OX2OoKpo6lPp/XeYnM3YsMcG/cqBpYsdjKUpcvbjT4l+p5JAhMDqGN4XzSjbiW2qSU2M8s13I9eWVW4N0mUT29+5z0XQGjWFAy/St/lKsKHcibzehAAR/44eGZTeaXFF4IcMmGvn7uhKAuTuZ9wD/YuJpSW7SLPRCp3g3tAeyge+X1wzEg5fm+UyCWIralVFJlk1kozahN4MC2AHJDEk7q/3U8HjIIcsJYlahpSUCEnPWAwrnaT3+IGA40yFpsrDR0RBJGGSTJWQOfcG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARV1C4nVgylpdQmlyLDeyLgqILjqZyY/SQVoQYw9dGY=;
 b=apho54sUnY8porFG9D9HQ6e9Ije28XHKYa1fF06BfQwJkCsZKVRfiZwlqE8jobW0AWkcvxtAE+5wEry/QKKokJGng72ps0PhHBIN1UU1wit60/GIPK2nfJUUYSb41ADwLShl51FODJByYKWlT+zPMTqxi4acOS16Bb4Xm3UpwHVzanb45rQyv9X8hay7P55xJC3EmVvjQXfgbOR63936gurwafYrRsHjGLC0hliSUheo0TXrcf15OOE4jbTbcdSaFgnTEIJ1rY7axhOW41B2S2wLnvcnxDmJ5MQtyozaO0e8sHDk6kxY5V6jJLIW73gOGCYNg6e20yhv9wrkZiK0Tg==
Received: from CY5PR15CA0157.namprd15.prod.outlook.com (2603:10b6:930:67::29)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 23:26:15 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::9c) by CY5PR15CA0157.outlook.office365.com
 (2603:10b6:930:67::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28 via Frontend
 Transport; Mon, 27 Nov 2023 23:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 23:26:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 15:26:01 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 15:26:01 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 27 Nov 2023 15:26:00 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
	<linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.4 000/152] 5.4.262-rc4 review
In-Reply-To: <20231126154329.848261327@linuxfoundation.org>
References: <20231126154329.848261327@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <76836139-9f6e-4c6f-9de0-b9d54dc9c5db@rnnvmail202.nvidia.com>
Date: Mon, 27 Nov 2023 15:26:00 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d6f104-de6e-4f15-6106-08dbefa0400c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eHLQzUmFyHEGtfcr5cqwRxgEFQar/6xAOiS+J3gv5Wslfw4UpCWVHfB3YyJe/J1r9A9itxw2fSUKGMiBAmqgMJH21U8CBCSR4naLcgXNJsciA56p84vplB5yrRyzkCebAkBh8CiDKeTQg8YmdT8BPaLvIeT7L+D+eAZQlt98cwRBP9UXBLCEypEMuaiEUS37rvnIP4QDM56OIz+UdBlF3MTgBdoWZHc5bRTD3bzLQU5uWoTL7eHaqe2njis10mPQ0VNEl/E6bQ4HuMVnoqMfMMVouszOCVwZX1Eer/Q8xSJfOe31ttr5ME02zp3gYtQcD14sdHdm4tG65FghKjh547ovJIymVHBp6bxOp72AgpY8vqaJaHfBWc9Kmf7V/l78EOVXqb6CR53E9x354w6pNRUvtmgqd2cGAbm3PTVFXgqOHPUdSpqTv9ZIJqDbl+Qo7MgYRS1rx/y416ffizJeR9ziFZkCjx5BGcZM7fuJmCnkojnw26ssy17LMkKS7pG784AmGDIfpGoGLlgX97uDAT0Raq3nust5KmRd8+9oijdl8lGkPeBe/LNonFsvxy1gE4KpknELn3NCzRfrLQGVvuEogGs6ojO9eQUas6Ss83L+SuDHflCDawAnE3umI5FMsMe2rWrNmuDqrqnsGq8kB7D+iHDHRyfqcKoqQrHsytn5Qy+l5iXrhg4JPKeOtJNpOW0urbFaLFssag1UjqP5Ijxd+mcYOfKvw+QluZGoOiiwbS60A28GedcBuWjAhMxlO9xlbeGDz2DjBovtLOUNqOwUjkSfTKP0eC5thX7HV9s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(7636003)(356005)(40460700003)(86362001)(31696002)(41300700001)(8936002)(4326008)(8676002)(6916009)(316002)(54906003)(70206006)(70586007)(478600001)(966005)(5660300002)(7416002)(2906002)(31686004)(47076005)(426003)(336012)(40480700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 23:26:15.0322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d6f104-de6e-4f15-6106-08dbefa0400c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407

On Sun, 26 Nov 2023 15:46:07 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.262 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc4.gz
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

Linux version:	5.4.262-rc4-gc60c08fb3b15
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

