Return-Path: <stable+bounces-2833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A347FAE50
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 00:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412CB281C8A
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CDA49F6C;
	Mon, 27 Nov 2023 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pqv3Pd5z"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759371B5;
	Mon, 27 Nov 2023 15:26:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hww7vIfQulvxr9+A7+CMPF6t3yN4T9sQf6uzkORUGzcWCITj+8ooWdsVfPyg3FIBWr2aneTCj9vCWTZcL7ND3F/bAqGM71bMSeIamoDVltwTd++IUaWYF/UCP8/vmLeUOf8rzwjwOgBz3LZqgb41QNZtQvn+DJHDgXPBdTtym3/X5UTQLiKWbTHfk3jrMt5udvDG6N7lBEMUmNaV/PMS1DlPJ0sXlB7xTVVv5JE4hckDD4ii9BV16a376mm7rDIu5UOmQZ6TphHZI3NnMiejVUmYvLN48uCA0t5YI7g855nAPaY5KMjy/vjoHe1kfsVdI2aO0TI7aKdw0i9eXkVo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw59IpGSlgmE4d7zNpUD3gp2CEUA8oMqjfcppxUcJhM=;
 b=TxSl9K/zPK+6qcd9FiyNCuX9G5Z+w1gvRfKurzvJPRWtvKRCNS73d+odr2pLijk5IC4Hu2ngAyc57bN7ld0ODN9BQk0OOS6CSOfYvphg8WbnKYofzGrlKa+WHmVPDid69VxlSaTu0d/1cuR4j88VuwIOS5yZA75kcsKtAt0MdzO9rjTBydrwH17eTYSzoli32pvQX2hHbiyC2WZGByncggsYmjblpEyNN5/yzoD3LK+bY5L6Udr1RgJp+dOQLhDfXwjUZq+Ph1cyss1pZlplZcercyoor+QBJBD2F77D24kJvTXRY9tSkfURIy61Sj1RDMUtaZjD/6okWnudDLJyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw59IpGSlgmE4d7zNpUD3gp2CEUA8oMqjfcppxUcJhM=;
 b=Pqv3Pd5z4WPhq+8JMH1hZVBLQJe2fkJqLxcE0Y9qdwmkSZJfA8uiIPRSsG2RKfjDEIwC7MJJRIjHVJPYvrSFuhrh/loWZChu96gQfQQriCbQ5JJ/elrlupr5ajIE7OiS6I20GmD/FtlYz4rOSy+RPJuTSl2hvt009jv2AOWc9icP9NpuTBRJJekBiU5HFlQkNQh7BZ/VPNFMCgiFmJgvCO9On4bV1FXzxmjND1lpfQ9KonjgwaT62RW2vUrj7uMXTuuAZbOZvtUwFzuKpyiOlo+En38VsJWdKPjs5xeWIZMLbq4PJLnCqdoovtog0kAO0mcd+xqAYm4E+FbZrFwvUg==
Received: from DM6PR02CA0071.namprd02.prod.outlook.com (2603:10b6:5:177::48)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 23:26:14 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::cb) by DM6PR02CA0071.outlook.office365.com
 (2603:10b6:5:177::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Mon, 27 Nov 2023 23:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 23:26:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 15:26:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 15:26:02 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 27 Nov 2023 15:26:02 -0800
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
Subject: Re: [PATCH 6.1 000/366] 6.1.64-rc4 review
In-Reply-To: <20231126154359.953633996@linuxfoundation.org>
References: <20231126154359.953633996@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <052d5b53-01ff-4387-bc08-cfb9f8c76f52@rnnvmail203.nvidia.com>
Date: Mon, 27 Nov 2023 15:26:02 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: b14e965d-bb8a-45c9-0e6b-08dbefa03fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cpi/2GfJVIXhWF93jz449+7QihirNcufGrR700JPuDJH1VM3K402/7f2uiu9mhw+NHNQukPvEDaE1TF8frrGHiIKy/4+UtI6ncygMaToT9d6VGgpAgDDaj1584Z1SOwmjOpZz1jkuL4riqerVmUVdmpBNXeZ/HefSkztA5KzTC02MuzG3fjYqxshWCPOn7hMiSFUpfkB+NCfRFpxL7rHBMWnavOLsMxwLjmnVS0hy1VVUujmgyqx2ey+xfwQ+GDW866sWYYFENmX9ewVk+0feVaXEYq1AW9JyH164RxJtuDXRdO0SrxbeRcA9fhcx+VqEuWTNgcPqTwaI3l9f/EJshuY3wz9cFTHpnpbroKuHFwo8iOklFAfvD51yILxui6YYzjmyHpoesZtjILL85s9pInVppEc3x1ifbcJIq7G3/S43+POJD6HzySyUSDb13df2rgrfaBu11+rARgBhei0TXtzFJjSMjxHNMtMDVtyVamLQI8E17nsQx8N3Ip5crIqcQlHWLkjSthVVZNwN/qShU9jl2qrRYGCVajx9WZGp6bqM7hqLDsNERo3FeHNqi/AQH3nE1xn4eA9olChVibYtmrA38UWtvgKJOKRHt5GI4esPfSM5CJ0vlhaGKtsWPqlAEB7zF3LPg+a3g8xYT7oHowfGZTwfc8WNNKYtDFXPp003abSabNswBU4w8axdAc/jFacQvbLjzDuioYfIf17P/GJ/5/4GVb79RfklsvP/311J3UQ6YgvfGDkUAv7kbE+w9K1yu+WHwmAS5Td5ilb6BzSy0a9sTuf7CFAWgODLDA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(26005)(426003)(336012)(82740400003)(8676002)(8936002)(4326008)(5660300002)(7416002)(86362001)(31696002)(478600001)(966005)(6916009)(316002)(70586007)(70206006)(54906003)(36860700001)(47076005)(7636003)(356005)(31686004)(41300700001)(40480700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 23:26:14.4458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b14e965d-bb8a-45c9-0e6b-08dbefa03fba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406

On Sun, 26 Nov 2023 15:46:28 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.64 release.
> There are 366 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc4.gz
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
    26 boots:	26 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	6.1.64-rc4-g60c4064a8298
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

