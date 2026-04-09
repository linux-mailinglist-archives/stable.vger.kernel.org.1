Return-Path: <stable+bounces-235361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HUvA+Bt12myNggAu9opvQ
	(envelope-from <stable+bounces-235361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 11:14:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B43C84C9
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 11:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51773053DE8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5423AA516;
	Thu,  9 Apr 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eTyMoOSD"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89572BE02C;
	Thu,  9 Apr 2026 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725519; cv=fail; b=ks7FGx3OVCOnyxyUcMBfUi/K3UQEgIejumnmPeIeCOAvtvCjze7a75bP26416Qeb5CffomDldlaSqG7G5IJYW9D8g9Ka8wYLpjNMx14KDxfqy/V6+yTHlACkN82xML7LmRz+oIfi1N3lY0aWqnp/DCPZAT7FKIXXsSzteW/ErhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725519; c=relaxed/simple;
	bh=S+7pfk9FcgQtDSL9xx1VwRgzFVBEs9KviyDrHqDjGZs=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=SzpuixgmFu+9K3o2VOEM0fColxM253iYbEcJ6bNAX+tT5xAnYLd4ii3RtnKpRz77psJgJ7lK97seZa46mcnL6hnsOZb9lnopJpPqvEaDNU4skrv7Zcsp1ThPhsQw+XRuz0RaAKb1Xm1M0gjDxIjq873IY8z4F1U3ZJAFG1IDmAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eTyMoOSD; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHRx4kkAPpxk4W7APLq4TFchyBa4lCWzffP/ntiZ4jc8htKJt3394QOD9LiZ/QJU8DwkbfEY28cU9SaAtceVLHf2aL6msyUJpNd+pB5VZbr72iN8nzQo5BAN7Qvz9/tkuWqznE25hu/eb/mgAFvE8PEWH9QJrUmDTu6qLyxHRsw2z/ssP2GQ8OkdIyV4lFbcBAJJf/dXsyPLQEhnzR4l3U7C816sRW0SM7vToyxwGztZHBOgQB9Dv3zuepeRGBYxFaIGJlevgd2q6Ct9WvbDhRosv3OyKivifgiuX1tQlJEWWVfQ67qmM6sxm2uLAJV19idVgbSfLlolIlxJdVSzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9t9kzo1ibG3TLrNGpqLW4sc0XjQRf+n947TZcXQQEI=;
 b=YcKJUrl44XUPXd3U3CuvUunEIOVnPISqq4Kp2hbR2P3ZBhjCjhyFF6Lq4aFauRwY+JrEvficqWtI+LLgyjVR/ToF6sAp9P9Ce+riwv/u5Uu6LdRJQFinXkD8yYmFkYiXZ4yOk8kKDAB6d+gxFvpyWiyZs9t1Z9sU6UnYl8+78ty2GI6dkMHAVmGPAzs/a4F4CXcX6pz2Cfp7+R+eL0MpVpr7U5ik8XNNbOax04gvKY0UC/hUC+uy3KtPOaj5N8EJ7Tq0Msxo894cpIY7dQHZa5ZEGOiNJLiqHqVREjkwSh+oa1eRIYg00WrDadBQ4nZNjcnfWANWucNO5HJ1anPxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9t9kzo1ibG3TLrNGpqLW4sc0XjQRf+n947TZcXQQEI=;
 b=eTyMoOSDPwJQ0wVfLhOZ5RAmQGvERWJ5g83otFeN90/lhk/7IwD0VqO7AWaKW/Wse7DRgN8owPGw9d+3H9lmDaFsINyOHOwgB11qrBMVWxnSpLEFUB2OgG++0WTlJfr9uR3Iz+KGhDxXLiSZTqNVn3NzAdknz32Bo64/LkhhrY5Z9MM3fIAagSq7L4J0BUWfsgr8v3Gl+phX3JMT2Qw9ZX4i8Yka/cDVUDux/9qZgmSxjJxW9z5aWa7KLrZJY8uwsS7uTYUyZ4g2uStNvNm2LzJnAmlT73pvlooKyfxKSPyJy9c4fS0jJ8MMb6YC0ZMzwSp2QWM2NMCcefoZOCMSuw==
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 9 Apr
 2026 09:05:10 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::45) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 09:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:05:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 02:04:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 02:04:59 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 02:04:59 -0700
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
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc1 review
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <50a91018-9f6b-4c07-9e0e-0f80172ace14@drhqmail202.nvidia.com>
Date: Thu, 9 Apr 2026 02:04:59 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e29cc1-e369-48ff-3f54-08de96171a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MQ8Zu967ER0lkbDTg+/eF0mQkEUeLtsPzdDDNFYsXjwGLfptFUw95I0F51tF5ObPt7QDl43732sdf7vQNlarLDlm96nh/PwlLjHX7+fGFSrVOjMkRtr6mT9q4wkVr1px3OUg9Gaas23f4KKNE8lyUSV7eUyM4+pKbb9TgoQzD7IqZgKpFlGL4yVSHx+witflHKWFY3pSr4Y2nYEV3RzL9OBnbnrw1czynBE7jIWmwFDidOpRqGnaFNH9hNdFqQleWQ8T2owyDOKINF2wMDH6tbZv777wRvZCpZ3jkdX2U5Bzeejop02Ws+V6CoCvXhWULbMho2WVkAklBLRBj/22n7YBgvUIYOPxFcnCICCDIShZnDissnHwbP1txfLTsjGf3kUYw0hyM5pV6AdT9exz58KYuN7r+sOHdouU0jZ6ECfdpabRClkberzox6Ey2fXoRq6Zs0abeWaLQGNip/FzFXKcJRayCKUVeFPIQKqFdiVAJR4dnEvCdb+csBYspLGk/1kNMs76g0qosuqGU2f/4cnEgBXwZIj8Kp5E2sv+3/zgUTJRwETaH/kb1sfdfyZCEnTj9OLJhWmo5rHm43Qq2p7PpcgFVrzYWa+T7BmoymXwmU7ZbtWw505hFevpQbDake2xn++F5C10lwqPTioVbON8L6/X3LNar6COgo55xY2txiJ9esLAeq6OE9tRKVOD93F4D68bKI1wa0QB9xvNQTLXovBlXDDBxk3hHFxrewiIRvl7lkUObpLP9hwlUpZwigJ5FkbpwWnJK/3PlDDrOg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7d77SDl11vYurkiQanFY+90pzdQv8kzZcWB5jLHLKKwiS6KOs/bywgYrjOCjSBLO++nIadCRh6jXHCsUMDUNjIHaWZfoVeQzg1cPAjTz2KUeVVMAjcJP1ukYhctIpoZO4z1rQi9xR9WeC8PFH5HCV/1lLkIPgHtpJlEV5n7pntCimG9JpGgX83OMoeLemAPaFPmo5CFFarrisQ6EndnVIVtWQUKvjXXPwAHT2lBJJ9ygL04bDzg7MzANu7v4ZrEVDunMHRp4tWKBZcyqmhPNyACnBqkrYUD9wXmfatDjgSEeL8q2SdYgXIDK655tjTDwUp+TbQKXEDWMU/KE6pfOMGyH27iBruiecGvY4i05H7ie3NYuNr99z2GTSEgW2wqbQTjB39b20Iz/biE65kawQzZk3K5VPu8V57PfE3OMraApFcrLWSGTPNtkiV33FYmm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:05:09.9767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e29cc1-e369-48ff-3f54-08de96171a21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235361-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,drhqmail202.nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 835B43C84C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 08 Apr 2026 20:00:00 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.12-rc1.gz
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

Linux version:	6.19.12-rc1-g571831a3f83a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra234-p3737-0000+p3701-0000,
                tegra234-p3768-0000+p3767-0005, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

