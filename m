Return-Path: <stable+bounces-235359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MRhGrVt12myNggAu9opvQ
	(envelope-from <stable+bounces-235359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 11:13:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C07F23C849E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 11:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EC430C6979
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852C03ACA6C;
	Thu,  9 Apr 2026 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnTV49i6"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D613AE188;
	Thu,  9 Apr 2026 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725499; cv=fail; b=mvxX2OvaWfEbBgOnFg4vEF+T1WNPnmCCrtTkoik9lTCQRBcdrruujWpNr8EOMGOg+Kllzr1b6DMmZxD+dFXlq5hHgeuy/Vrq8ZV5U+NmxcIVUmx0BCRZcXJtDgWbT9U8tbrrj5bDQkQ0JbOS2iFBHGie+SfF4JdSb+D1rezBU/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725499; c=relaxed/simple;
	bh=BEREg9hjqQp+A3JdABJ8hZwTZ68rmqjuyaeLzwawAN4=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=oP2RAfLKHkvHhQqII1+q2AASuAZWnOvHwi8vxLVggc/LcgSN7fKw5MTa2yRIYZS5W5o3CVzf5QPANYn2zagtbg5ockwBKbyYD4JqcTWWQGb34t5DZkM9LRiROiGJGpSdtq0L3KCVIRgRftxUdrS6ns9L5lyp/WO2clwNyPAMSlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnTV49i6; arc=fail smtp.client-ip=52.101.56.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWdYfmwz+oQtdNZz46JAL+TaQqNKfP7sjtWdW+rkhvFI0fyNV3/SAww7c6q1JyhA7YGAenbDfnZag23LX0I7qJKPzCTY413f75MuzSK7fWBjvN63F+2ILmNGXmHwVuUOGZG19CTZjxyB1s8lXvUTCjoIEf7daA20r6UYAugIP/AxG0843xaI3Eo+XF5Q/L3WqaHzruvh3Qi8lIseEEaYLB7y0H1owfiXRul3k6ZVziRHkHVcXlIY5qJDJubPSK2gmrGxtUVT95Tmd1IuwAXGBJ8HGa/yK5oGSv5dwBx33CQ52txE++L74UPhWhBAaOGt/HTgvVOfq7qa2nRa2fsvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAnMPGsuBBuWi+zfXHZVgMiL+2c2RjrGgGb1gTlmIZ8=;
 b=SCB7lGdzWXkKyyyip5blpZ50jJW41odZrW3Sr+PZhMK9Y1OfXKV14tXV4GdEADXpauTiKlsSxzPVKgIvuI0RXCdORGQXKWCvVubhSH0lemVHMSISYJFl+GPKWciqOIiptQLqd24LeG/uKb8jRsYCpjNqkcotE03gWek4fNh6qoTSt0ZP8FihUDC3julFewEYS07+AUnPCSHM04ccHt4tIOkX/c02ceHiV1lvnmMcZ395TvyA3eDYLoSPK3MafgFNmQWdSJ9qcjIkL7R8kALguzYD4Uu9WyLIzUJBA0LSZsttM8dK/xm+qp5gJR4XbbGIBkSqeyU9VBcj3GMRSlEWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAnMPGsuBBuWi+zfXHZVgMiL+2c2RjrGgGb1gTlmIZ8=;
 b=pnTV49i6tzNgaa8yShjcFz4uLp9t7XmWfQAbryzCMK7vdoFjct3ycs83D3i26vlzy0kDl3tA0wZA4x88FAgucs7RnKyVGV2x6ZdM8CxdzHgda7I24w4xFiFBZPjm+hrH+juFH4k1UrB3g0ufR1LjQis/Y79XJ88Q7mcU/yfA48Tb1QTQimiVtVDZsI1WFBYWXZOpgByxSc1agpJZ1zWHQofsEOlTfd1MPPxXsIIb3otV1KIb+7C+4zF4DIj5cmKyVGdezm5ynixeYYDWuSaEdD8SLiNYLZV75RuumFFajJpqUj3rBaqgrbTTHEXp4GKgeKMtYKuv5/HRj0FIG+XqMA==
Received: from BL1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:256::8)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 09:04:51 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::95) by BL1PR13CA0003.outlook.office365.com
 (2603:10b6:208:256::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Thu,
 9 Apr 2026 09:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:04:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 02:04:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 02:04:39 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 02:04:39 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@nabladev.com>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
	<conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
	<achill@achill.org>, <sr@sladewatkins.com>, <linux-tegra@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 6.12 000/242] 6.12.81-rc1 review
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2abc8c42-090e-4c7f-8730-0c3b0a7f2960@drhqmail203.nvidia.com>
Date: Thu, 9 Apr 2026 02:04:39 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bc19e8-315f-45c2-5cab-08de96170edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|22082099003|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WzFQT2Rq8/fhihbnCM2I71kCuaq0/9DvH0IZBhR5QOx7oszp8brNYDsRdk6EvcbZ3uMipySjzgibi7wCf9WNRDz3BiazISGKlJR+YmRT5Ydt96EcV56wbQnVBGfv5P0XBBp4lL+nJzv/xkGxt0fHs2uS1P6NJfKS177DPqB9n/CR7mUycuSn1rlGj75T0CwrvhqPBDiNzFF+YwBIHSIbZGI5/cFXChQefkorDqtI9mluO/17EYoISx0hnO16FGQmQJbF116MBcC9nMeby3FspsKGkFlcSoXX7X1OCO2yaUONJe7PZFEGdy68xZwGjsWFied3aaJCskmelZwKfPROepn0bAaSKK0v7wrdBF0LehNrngTwhzn8VzbYzWGMbnU4Rm5syvQjYW2kfOmEF7BSm63mypJEjYINeA6js78P+GhDFdsMuCyd2ZlxQIN1OcKhULtl0Y/2r+VbNL8QgeyrVCJpT3b2TXGe38YqPBNfjBkVT2tPkCS+0U5ic6A4xlHM8hNTsmqnBguFkERqJ23dimx7Pz2TjcXnlyKzy2yGZsXFLOl6r2yqCnGDttK5uGLEgMBadFIJP3B+yWoAUilp/SdpuUuBo5PK3aQ0LrTqJAgDbqmQP+8pjBIhqPQw6xbdATEheVLQijvddu7Gwz7NCg1/lDGPZMp3dxeZmgZqGPxqt7u1XX4MnHqCKVI3tErBmmrTsw5ljmIN2Yl/6kVtVvE+1DC7QkkmTyVYc+yBOeHrK14Iauw+4SPXEbPMlCvOjhjnH4apBlK5HTvDSyzUxA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(22082099003)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	50D5xDCNEkONG5GRf/AwBvcTFPsKgv5abhIbKzvqNSzPsvhv595i064JQz1iIt1dR4FIiG6lEnXI9cU5WbYZOF7o+o72BDwSIbTcMr6mGecNw2/uP5VLtSneTQJieK7ShAjvpinDhTeJdw5hYsn4iPdp1vSkSS8r8uU3MnVR8Sqs+eqrPsQzAlYJxkZ2LijPRdwFWjEzRjrzY+/KsMEzRd2H26e0AchFQyDr8zw8QnetdsltlygZF6uhcpuvQjbCxQEMjYriUgpykICT6BYGh5DYlshj9wZWnyKmgHQOLgdT2SXDbxpUanKoI7qK69+jtSdAk9d0Vrr65Ddh3x+FMlZRaWfOMSse2ty4LZqnLc5QzJrTGIflikdUazSfO1PyfyMcpm80YbK8bBuKJ+guQaxpdnV5rxdSOJMw+gsysHtHKjPkubuFzJwNv2k6p+Ol
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:04:50.9205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bc19e8-315f-45c2-5cab-08de96170edf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235359-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,drhqmail203.nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C07F23C849E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 08 Apr 2026 20:00:40 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.81 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.81-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.12:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    133 tests:	133 pass, 0 fail

Linux version:	6.12.81-rc1-g725a3d574146
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra234-p3737-0000+p3701-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

