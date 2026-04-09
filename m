Return-Path: <stable+bounces-235459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N5aLfre12klTwgAu9opvQ
	(envelope-from <stable+bounces-235459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:16:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F063CE019
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1649300FB66
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0BC2F49F6;
	Thu,  9 Apr 2026 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kdthVLIe"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D443E1CE9;
	Thu,  9 Apr 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754982; cv=fail; b=XDE5KOyWsCUSRD1sw6SLaU8nwAKpnhcb4FtSvZ8F5ZoKCRVCpPHm4EJI8epREHVqqza4NTbERS2kZ2eipHe1ZNnU2O21zRGeO89JuDt4cgejpLExbWk7lB2qQ8AEdedPOGTYPMsjvVwyy97Leob7EQf/j6CYdL12ouCuqztPgzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754982; c=relaxed/simple;
	bh=i5Cqpv7arwRLDh14CdfUOy1N3kbfkdXZy6rPNmAhvkA=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=eK3Ig38tZlHBRKqYJq3octpRIud0guPZwzyZbrPhh2gIroeU+2gX5tRDvv0kjNjBQYHkOHrjZIJCZ2mBcZW/f3ISmMz4IrqXHUwN9cLZn3pGBUW39fLCSb6dZu6vSs/tU+r56vIULBHr5+j3nWDiltanKbtkFhUI9OtIUdzGXtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kdthVLIe; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJmwjNxOOSfvkiL+ju3qaFPusiphqwvXYFuNFUxe6qUonFDOwVWwBDUOOCQOIc2F7JTl9/20V9GwkE5S579QDhNShoTJrkcUcYIsCgiXTG/H4+CigSozv4/H+kHEqj8G5OADLzJ9Mz/642KHRr637oqvrqCwX8QShyhlNaHlXUtsRVw4bt1r/6itFkHFL/XzxT0GKIZyi7tQK88+2SzyzgFf/sZ0fDV9G9/EaLioZN4tjSNu7ZiVIHGFeGfSXRmZLQYjnvHZb8mXAMI2bxxBesvuLUsROPrBXxodfNG67yp6SkG9U/1h6DWa1pQJVQXwOx9llptWAr/L8qSe98rV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlzC3Ex5//6HpGH6QZPM1w9t5S7Zvt0PZ4+iBpmX4nE=;
 b=V5PrBcA9wrtSoWKCnw3ymor9e3qsLZSpRXq5rHeMyNW5DVPABcxg8hP2hjYYpLtuPmjPHg+iQg1BVXRqa+q5H1yMFrfzziIFez+p5PnzodHpJfX1+LuyRz+Bjhu7/AAMi9Bp01dud1x2SyS5HeIFtCa2r+9ST+H8dTvIv4eeY+OD9LVRTiPSlOLSUzHngW9W8838nNpKkF+2wDe+4l7meYGaXbxk1QUP0YifdL5gLu6hSxoqqq5TL4Fg3yhbsws9/UvS9kL5S4+PE16OpKT3HSHH9kNBU5HFpZj9kJwqvFRU8qaB8GbGU/S4Jgt9HwkZPKapK8zsoaZvu7JesIJuDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlzC3Ex5//6HpGH6QZPM1w9t5S7Zvt0PZ4+iBpmX4nE=;
 b=kdthVLIe8kaYsvEerGjPBgG4ZaiH/9Gdll4BotqsCEmHDKjWGpdKcQZ0k2aKchvGgTjNkSdWPTJBGu/cDzE8TJd7aO6QIYW0hWWI3Yv//53VeOD6l9Udmwm2FLnuZagtBfYUgY5EzVhlWWBMl2W5JeY3FU9lJ4jADpOlJ05DXaJwKiSzVambimJ7ze2XKbm9RkImoMdRRUSKXUwKM2v7ICvBornfQDChcyffz7Ya/NF6F8gv8OTq4aoZZkmf7K2r8uLzKvYK64o0j5uBaNVq0kq7nFX2+lEs0do+UwClH8bakI+SuIGjyz9pR5LinIFcgvyB8y2PyC0MhKboB56V+g==
Received: from MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 17:16:15 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::ab) by MN2PR11CA0026.outlook.office365.com
 (2603:10b6:208:23b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 17:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 17:16:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 10:15:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 10:15:48 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 10:15:48 -0700
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
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc2 review
In-Reply-To: <20260409091742.514769762@linuxfoundation.org>
References: <20260409091742.514769762@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e4379ca0-f44f-465c-b29f-dc7c85d479ee@drhqmail202.nvidia.com>
Date: Thu, 9 Apr 2026 10:15:48 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2083f4-8b98-41b0-b670-08de965bb3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lL8/5rKHyEPjLJA5+AXVYZfDuLzcUsB4M9hGFEVu3mvFeZdoaSxC67YZQn7uKE9LVbGsv+BOMz0FpVtCZ7+D0VV9QOlL1v40E5/gDxb5hq8uh2kc4jx4QdehWFg1D0Zq7lL+qPE1hhJRDiRRGzWzUdMPGnY+jdmpSv3QWxV+Ea47LLQURWJKO5AassXTivARhzaOz5Ubf73WPNiI2m5dIxSI8pArZtNROuSDkLX7nZN+PuqkBECg3QhMKG8TN+nu/XwxvLP3+Xkugze/8gl/Ub4jrfmi89KObEwXldsLBv7vfgaqkFE8Dt8Um/wXz7eYW4azkXlubt2Jdjs4JvxI2ur2vVAE9V6Qb+zYrUifUm91tCYiPfvh6Y4wQeiRtPFPv67nMpyF3B0aTJ9QJIq56PjRMru3OXORJVWYyIPVP3GTDjAB+NSFUQq11cT0sjBAo2df0rwNo5EFiUyTOck4F0PImd7kmQJlKd2S+gnmb2PS9C43G6afTvvvTLNNmwKp0knchp7DeGO8s+ecfUGSLwOjHP+9hWsQPoL4o+ANLmcnkHPXNO3Zu8dzyPpVvntVhS/TPAgtOJyQM66eXP3onqdxyVvCwE5WBKfE3gz7t8IRcHtf3usFP7fLz38SbIpYpz5lIDy98wFCyEm6FFrAo9Z/Sx4NMZLNpFrAqNUSRHCDAN7h4mQCO1JjU727V8jttzf7QEgh0amhOKuiQxEpcpX+3Ai4o/kRoMnxjcpORAF1ZNrJ1mm7U3zxlKkvPcQjLjm1HwGrob1dcYHSiGyOGg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X0BEuqytb21CvKzwt+IrV5peOh9YcAnYe7lWW2dX8Az8oFjTTWKqznkShxnemSKpjUHkBcyO5yjSbR8mHrXw5al7tTfiFHHAF2Ec6/34gOA3SXyX2Z0eDdApMMYuhodfpNZbO3eRBu9AqIo+yjEx0egS5EMwsdYvNzcsmHOR6/X/b8UTxyqrMHXJbYmc8sVLlez2TOmEWI+//AK0RSw0ZbHDKTfiQHKMfz2qpOpqgd96/PT7TSw6VhoAL/Ezq3HEyLgwUuAxb1D3LMANuS1ZimMp6B46dFC2cISqf/2irYvGX+E9+Nb81HEEoJGjLauapmNGmj0KQKWBj96Osx62SYUft3EzS4ncVq98kiLbOgeB4p6QX/H7wHbqzJr8jRlGqLS/b/L5R6yCBxxU7aD+Tw/u7XzIRoCJTqBJmEmeoyOqcAPBV7TEzXp26Qlh8Mwj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:16:13.3975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2083f4-8b98-41b0-b670-08de965bb3ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235459-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 22F063CE019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 09 Apr 2026 11:25:28 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 11 Apr 2026 09:16:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.19:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    133 tests:	133 pass, 0 fail

Linux version:	6.19.12-rc2-g0d57c706dc2f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra234-p3737-0000+p3701-0000,
                tegra234-p3768-0000+p3767-0005, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

