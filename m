Return-Path: <stable+bounces-110166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC3A1924A
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B96C3A25F7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F91B213226;
	Wed, 22 Jan 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DkVLlNaY"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588EA212D6F;
	Wed, 22 Jan 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552201; cv=fail; b=Zj2R6BmCZVDM/qWnmIMWFOxP4cqBSVIyjou9mYXAWRc9obYlIkSZhoWp/LZN1DFIwlVNvfQBc7VsDWvwHv2bL5SWJ2hBH7sTQtGdqIDEkcEyZx69a/0q/mMOWWWs/yQsNjoYsL+zQixXmNEZ3r8xu9GFJKANUGWj4CY161HVr2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552201; c=relaxed/simple;
	bh=Q7i7HkExnhICAROB5I12l/WyYlYgXOi8D1RrNeZkIVw=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=C5va+gtT/aO/CisgwUv7W2N90ke/yaiGqnm4+7bYkFfwOY/bRyJvoxQ26xTWMY8y/a6pYTULm3py8wSw+7Uu0f+nSk6dMnRe6FtFySmpqKuGfNohigmDFPWzqbcnMQ/ZF27y29A9fa4VF6jE7fw7kI96IP4zf0Al3yQ56HyJ4uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DkVLlNaY; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqSEnOImHwwxJx4AMwBhbGIkbhz6FtiffDCoyxWecLUItpYYtJjQY7ogn00bHfalwLxHZ7v6exCKBwBx5+xpkHWlyTjJxROuWKb5L4JQVpFD15E4gqGmSBVBOarraee9h76moanPFsHjskjcNsrkipcu9E2FUqJGzxlob/ahoUcI044eXIE545F8N1l94zYiwg+8Hn4b7OfSy/k/INbgrJTY01VJeDEywX7NARXEVtq0TazAtGzmG9p17O7sTpOmPDlpqBTW8Jnefu6Etmith4hs0NlVCRY1x+mAZow2dLQTQXhm+Z8NrW0JLQpUAbHbObYW/jA4+evfhP4/9rktgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAMc1qy7P3Ga0IvVbDHKtIxJl0TXM+3EZMrIT57oJEQ=;
 b=ZwpPMYxiQOLaAxydFM6fOGh+KyhKLJWa7XitPeU7Dq9DvruaPnRZoZnHtVfLvrlWTE1hTfld9VTz/qrrsfkcot2LdOlk/v45hb4Qk/Fvs5Xd/mggMoqCFxPRBUcHXNGeHaBp29xebZtRZsSOvd/26CTDivXZR3sgOtMQ+dD4Rzn9AgasJHxpk7CZxoW0Bxo6rDw6GI5F02dafDEGx3z+LBnyJ+k4oh2YGEW2eGiGWGL97qbYVXg56BqPNtFAnpNRHmWZAQ1oVTzA4vpRk/CTGcGlIVATtTwKVY88IP/qPQ9HnC6vlJzFTCqsHY07JKAJkicflTpPYaip5EKWsjIPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAMc1qy7P3Ga0IvVbDHKtIxJl0TXM+3EZMrIT57oJEQ=;
 b=DkVLlNaYkAgzsEyjf/Iu8UEfN/CULGueVJ+BkWYw6mE9DzwyWJGOhriAqTAuCgKCPnZzf04fKCc1rZ8tcbsfRET1JV0D+nWaXWE8ZngtOgEH7s/Igxa069shIdPE6r2ZzYcmuvFEC+S5sL2MdSdc5EoGDQYZaOASIOb+Qm5VN+SDjRZ0w6dqGfQDqyjw5VIsbSgOcBSTPFb4DkG0E6OK4WScKvx/IQPzijDNsoGjUQuQ4PwRIEiJBp5T44fk3loZHTbmT7yvAUP2Cs3jVL5qB8Gq57AVvs9lf+xRc+Ux1dxEoNAJiuxF5wS72kSscKtKWtucOa5vDci8ue3pkn4utA==
Received: from CY5PR15CA0192.namprd15.prod.outlook.com (2603:10b6:930:82::18)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 13:23:15 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::ff) by CY5PR15CA0192.outlook.office365.com
 (2603:10b6:930:82::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 22 Jan 2025 13:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 13:23:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 05:23:02 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 22 Jan 2025 05:23:02 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 Jan 2025 05:23:02 -0800
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
Subject: Re: [PATCH 5.15 000/127] 5.15.177-rc1 review
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <ff3a3294-a316-4378-9a75-0806602ddd39@drhqmail201.nvidia.com>
Date: Wed, 22 Jan 2025 05:23:02 -0800
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 10699d8b-e530-4fc0-5cdd-08dd3ae7ed51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MSs1SWZlaTc4TERsTXpJM1RObFNVc3gzaDNUQ2V1WUhWeDRjWVh1eUJhNFVQ?=
 =?utf-8?B?UkpBZ0tKU3ZOUjVpbmI2MGpwQjVjdXZnQlZWNkppZ3BKdUU2UWEzV3dZaEtO?=
 =?utf-8?B?Tkd6V3pxKzVSSkVBNlFiNlB5NEhna2hQbGZGUnNMU29UVnA2RjVMaS9EVmZF?=
 =?utf-8?B?WkxLMWU2aHFyaTlodkJPSFBQNXl5T0VkazFrZ0FzRXErWlpUYzRTc2l5VThL?=
 =?utf-8?B?VGp5dlEyK3FmSlIyZEdDWFN6MzdQaHQ2dXlhT2RYOENPOUhObHVNQ05sSHNE?=
 =?utf-8?B?djdLckl4NFBhMjJZSlIreXppK01hUDd0OGl3bGNJRisrM0xuREZzeHdZTDZy?=
 =?utf-8?B?VDBaTHNPU25rSjdSYWJhSzZNeEVHemxLczY4MW1NMHRqUm41T1ExbTdPMGFL?=
 =?utf-8?B?UTc4MExadTdNKzZMNDlVYkdHcUhvMXM2cjF0K3dtUmNETFFhQTNKbUV6NXcw?=
 =?utf-8?B?dnpCZ2pRM1NUMy8zamlZakRoRFFENk5Lb2xyeDlrRnBHcmYweSs0a28zZVFR?=
 =?utf-8?B?Z0w3T3FyaXRRZXZvMGc0c3FVS3J1V0wvWEhmeGM1aTdOKzUvMUF0Y3RUQ2lu?=
 =?utf-8?B?Z29XVGhvUkI4cDYrWFk4WmlrRkR3b0EvRjYzL3NZRGxydzRudllHMjN4bXZM?=
 =?utf-8?B?OG9FMDF3VmdBQjg1Z2ZXdEhxbzRnR1puc2NLczl0NjJ0eXZMRnZFS1dUbCt1?=
 =?utf-8?B?MktwSG15ZkgrMi94eHdpdXdQUXM0R0I4RzAzbk9MbmdBbmJDaHI5bDBYamFz?=
 =?utf-8?B?Y2tCWkpHYmErMG1pRW9MNS9CYkpRcmk0NmVkYTJNK3dyTlAvOHB3SWJVODA4?=
 =?utf-8?B?bnVvVytORHJKTU00MFRsR3JaSWM2MnpJWkd6REREZ1FrR3JHekZYaVljZG1H?=
 =?utf-8?B?cjFDWXJpZHBDSTBBNThYdUdmMUNEUDdvMjJnMkRtZXdBYTdOaGk2WGllUFU2?=
 =?utf-8?B?ZWh2alI1NzA2ZmZWUnVrcFJ1RnMwUGtiMFBCL2w1aVNqNGl1eW1WV3h5Nm95?=
 =?utf-8?B?MnFHbmdOV0ZjelpwV0ZvbE1CbHhqOUxpbHhOY2IrcUFhdGZIWmxYaXl6aGNw?=
 =?utf-8?B?VVZ6ZklBcFNOWmJ4Mll1aCttaTQzRkdEWUlPL2h4M2RadnVIUE54Y3RvbHdG?=
 =?utf-8?B?bHgwNm92OFBjbk05WXRPdmdldFpmK1Jlb3ByS1pNdmdNOG1KSEZwS1RYUzgr?=
 =?utf-8?B?Slk0S1IyVitoS3B6ZWZqenJZanZENlpZM1AwTDRMMmw1WXY5OW5OQ1dwNGpr?=
 =?utf-8?B?MlpsUFhGMmRNemhQVG0zOEpQYUFsNFRZcEVRcjZaS3NTcWlEMmMwOTNtNXg1?=
 =?utf-8?B?VVBFK3QzT0xBUXUzRFl2TmZzT21YMDNPQVlZOXRXOFV1QkQ4SjJyUm5xVmkr?=
 =?utf-8?B?TTVhVDFDZktCTm9zSnI5YkpUWUNLV056T2Z2MllodXluMG5EN2ZOV2JEUEFM?=
 =?utf-8?B?UjlKYk5zb3R0ckVMdU04TTd5TE1EMXNCb09qNHNuQWJ0WmwreVJCUlZrTGxW?=
 =?utf-8?B?MWtiZ1VQdkNzT3kyTEF5QkJHcXBsdUNnaTBHclRRTHV1RVZnOEh6SmNzRzNn?=
 =?utf-8?B?LytXQ2FHMG0xeXFDbjY1S0tBTzJyMEdvU1MzNTV3bkQ3Ti9wWkVhSUIvTzRj?=
 =?utf-8?B?Tmc3L3lsMlBTd0MzSTVZcXJTSExVdHVSazRBME91R3VxOU4vZFcyZW9FSERZ?=
 =?utf-8?B?MzVOZ2IzQ21JS2ZLQVJSUnJVd2pqdm5YZlIrdnFmQk8xRnZvSFVQOEVFYXF2?=
 =?utf-8?B?a1FqTmZVSDBhVGcybEpmTVVUTm5oTlBrSjdLUHZQamxCSjl1UE5GZS9oVFJ5?=
 =?utf-8?B?TGxvaE4weU9DbEw5b2o4VUNkZHZkK2Zpa2FIOG5FU2NQNXhmYkhBQ2dVRitE?=
 =?utf-8?B?bDJnZnNENG4vNU5yekpnYzdvemtLbmdQTnJNKzhQWndtOHVONnN4OWFvSFAz?=
 =?utf-8?B?YTFESGVCVDV0WWt2UHNtMHRJWFRMM0dOQ2U4Zkx3b3IwT0s1a1daeGx3b245?=
 =?utf-8?Q?QgOKnHARVrk6KNdvsvhfya6+In5GHg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 13:23:14.8929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10699d8b-e530-4fc0-5cdd-08dd3ae7ed51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924

On Tue, 21 Jan 2025 18:51:12 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.177 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.177-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    101 tests:	101 pass, 0 fail

Linux version:	5.15.177-rc1-gc77b3036a1a3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

