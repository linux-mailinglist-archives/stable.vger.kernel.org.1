Return-Path: <stable+bounces-2834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC07FAE53
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 00:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337B31C20BB9
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 23:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9F495F0;
	Mon, 27 Nov 2023 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XdZuLtnW"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F0310D4;
	Mon, 27 Nov 2023 15:26:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJnixnFnRNet4fMcTupX+YeSeUM+KiIMqBt0pYNS9SIVRMDDbck0DlTrPxxExMyWLYND1tR78b7nSNlYTKTxe4FN5p3Y6y+ZI2FkN3q76L+DK0HmOurHBg9fE+nswXTBI61CUlrkMa0nNOLJEg/tBO2/QtlbJSOaaB1/Xq/+x2Jqq4lSDmXZbxqFYZKeBp6bR7A/W0HbDe6NqLfdWn1WpohMiRc/nhZQEkTNv/F9aI5D36HNTRAG7L4qYyZFwAw7cCodjTcRAF6OEnvXOcF3yqh3hdEJjSFPNfYJ3e6A0wqgKVZ9Svl1DOqC882AZ7zFI24pERxoObVks+2ZV7Wn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnSOYr6aXXg9MTJhF12kYKSA3lG5IXHVupBIzwHAZoM=;
 b=Ph9mrv3CTNsOBS607dOLVADDwxQGzg/qon7RHcWFXmxiYbNh+HAkkseOarpRNqXUpdLmyulVYEb9DmdSF7gHFIyHPvinkfZRyIM0mrY/N+snGHvMuRbnOQ6z/PWp9F4Lc6T0LMXC05z7BPmhw67z+ZG4DeFRtR1V9yFqTqC+JPxs1kWEMePaSy25MqHC8fae6yvPuk4aedlsHtptqoTjv7xpqBjXZe6GAPcSByWXRgB/Pe3dL3v4aG8ZDf3X4w9B4rjofHkcK9+VT3+G1XH/Yxo3gYE59sjMnS+UArjrtEPz1EObZsfkDVPe4VYqQ5MFNUZ1k7KB5Ujx1QB2M5oi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnSOYr6aXXg9MTJhF12kYKSA3lG5IXHVupBIzwHAZoM=;
 b=XdZuLtnW7VFMpNvHNtcOfeIh49r1Z0ZF4AptKqhDcoacccZ6b7H6hQFfQKxIIaqo6rEK/hvsjISj8Ka96TlUx6Ghdl6rDeEw7n3d+HJt/eaFhJKQIM18JxTgiZmZPvoockBtgsoNFgwDPOtEjeNuofR1mX4zyRNY1wOhWChe8/2vLTYS18yGMyCChNTT4U1Cb3+wV3T+nafXoUGelFPfaNEKoPOYyt9o+qQNgWBL7Nu0TSrLRV7OsU5hDIoYBdrQcFQqKNCZjAUA5412eFiTGP35crUNQAGbOuvtXCB+sUGX9+FI4cp1yBJpTnK1ynpNGVVpcZHiG5tVvG6GnJe42Q==
Received: from MN2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:208:23c::19)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 23:26:21 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::d2) by MN2PR18CA0014.outlook.office365.com
 (2603:10b6:208:23c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Mon, 27 Nov 2023 23:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 23:26:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 15:26:04 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Nov 2023 15:26:04 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 27 Nov 2023 15:26:04 -0800
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
Subject: Re: [PATCH 6.5 000/483] 6.5.13-rc4 review
In-Reply-To: <20231126154413.975493975@linuxfoundation.org>
References: <20231126154413.975493975@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1f780b0b-da9f-486b-b28f-68d341f08dc9@drhqmail203.nvidia.com>
Date: Mon, 27 Nov 2023 15:26:04 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb9527c-cddc-46de-75d9-08dbefa04348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	47YyxtrowxXtCuCA4wT0ifRX4GK9u3CTDTTZ3pNDTNs1oIJTIRqEwEISvFmG8WZ42pOM7cX0druxeDivuRAh9RWKk/oulwDZdhahHNPmyFQFIjvl/L9b65Xc3fslLDvNVuxeQrkdmbbRMErBJQ58aPkHzFvfBd+sBQpAk9p/tMY04QStX7/lH5lVfIHm/EDvO/QzWkevkworj+1NMlYCIsgLVBJ/i5mlaKYnI2rtFyXpldhWOn/otumm0X+U0Aiz27OnDptm4CJgNEmFj8jJ+jDsy9zce9HAjw8Tnu/I71s+ZbORv5A7o5LlkpWmWn5cssjXAzFMtoVCXW63h2bqgAoKeNbZBPywAPE8DxQIJCBTbyHVXRLuWk3P+ES/9g5D0M1ACK49Y4XI+q0zLC9gmFmlWjjwaD4nuNwSp9XoRkF1CgjnYSfPrlCNGIwmSv1dPLF7PPnELXCXDE1uR+aCg55zBwCxxbkhW+mQVrwTvhO1TYguJw71RhDU2ySdhrIFLUPabUbqxDXI2G4LgLW062YxcW5G2Vp32FZ0HD0HX9V7gOJq6gnzb3dkzx94CxvhXOnKbzS+THPvUtqUEDMKzFny+5a7Rl1KV271AlMVxCPm3yb3iZdm2i+owzRp9xM5mT4xltgkRqz0+IdRwKRA/flbTa+r3xTzJwf1kNy8WOD6AJkpCHgL7iLFxuBZyvlhxKfVyqdoptJt8syWYZ0TzpInAOWi67MdoXC1rqesIsFMvZOq7fwgSv3wnnsDyY/HSh71UATgTdkLg28YWRb5v3o5U0zquK8CjyVrIbVsErc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(46966006)(36840700001)(40470700004)(8936002)(8676002)(4326008)(31696002)(70206006)(70586007)(54906003)(6916009)(316002)(966005)(40460700003)(478600001)(2906002)(7636003)(356005)(47076005)(41300700001)(31686004)(86362001)(26005)(36860700001)(7416002)(82740400003)(40480700001)(336012)(426003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 23:26:20.3653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb9527c-cddc-46de-75d9-08dbefa04348
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

On Sun, 26 Nov 2023 15:47:04 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 483 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.13-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.5:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    106 tests:	106 pass, 0 fail

Linux version:	6.5.13-rc4-g1c613200bbe4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

