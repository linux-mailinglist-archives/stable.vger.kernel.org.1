Return-Path: <stable+bounces-222887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF2uILXspmmQaAAAu9opvQ
	(envelope-from <stable+bounces-222887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:14:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98F1F1302
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A5DB3036192
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96095383C9D;
	Tue,  3 Mar 2026 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="onkElITK"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7D3B5836;
	Tue,  3 Mar 2026 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547151; cv=fail; b=R6YwFzPET3Zye1GSmDgjSGFd/qJzwZIfsHRIwuk7+uieuYYISce2xv4Fo0IYpJEC8BeZBpsGZ81O1pV3kB9HgGu8NfVC9/mGFjYq4/dWpPya8NkDA5AzNziFePfN0WbBic2yceF1CgrKdq3UNyZZJ4OcXOWxLq0ny2BvdChpXak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547151; c=relaxed/simple;
	bh=sWNrkTJ3AfNjS1R0rqaqVMYWYANLD6AadOT6JRyAhdM=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=PsodLJn1vACdJE5QdM8NFTr5v5zc1NO6WiwaRAQOWnfKNHP0xVABTtk7Pi5sHtGvnbiAobD0JeZRkeO7kLpGEMCig0hXBvzuQLlJfe4Rupm2dAnSO535mpyN3acRY/k3lyAduTwO8zw4n8beXd3Uegcbnnf4uuLDwIZTcQKJICM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=onkElITK; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD/NBROBwJBfZBTh60LDxFXIEARRr0PiuwQ68jQQs47vP6LPtoXpziBl4xSmQllNzRCUyu9XPSieyjxU+gYTXzxpzECxJUn+CX0whugiBmizBrMgXigGQFfqL/q5qK5L/TVYHbHcZ/IXQiUuiVu9Zs1FL5ROxORZYOKzNAa2zqcM6hVh02bfBJAJb/VN/caDkYPzkj/LsE9nd+VLZkupilYiMxON38KqTTwk+Yfkp5GW63DWoQSZ4IkhvDQchXjNxCjfYWDZqslR3eIRrk5i1kI6aXiCdhqS3vl6PVOj3vIFH6vv1NPwlyPEAyhQFBNanv1obJDbbtn0uci1zuO5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r72d+Yh62Qlb52N9IAqnOmPq0ZDK8Ub5jY705VwLr+s=;
 b=JSfz+MYz/0GtNHqS2Mx4UtVn3kCBoctOvWV0EYmgmHzdgOhglb2qminz5t+0bsBmjO6x2zOKIx5KjpxHV6xf1/Nx0cpmR4vuwba5ZaVNnjTey1kTSc/ZQo45pxTeMyzIByAKR2GKL8lQsDunx8YlJNEaasXgnL4xijjFX/4JCmr2Sirnuuja9cnTVnUMj9/b/94RtZrK3Y3QlXMMRWCT2kHe5SNIyzj0LzjDIys84gEx4xxdFugyhyU59GCdu3nQ81gxa2Kuftrfupi/BbuvrWX2gXih/xRoy8KkIxuHE+rhck3H02h3+Z4QrxL7SZ6vUcVJbbHuDKAgiHpxCKpr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r72d+Yh62Qlb52N9IAqnOmPq0ZDK8Ub5jY705VwLr+s=;
 b=onkElITKRPfeEzaW3DMIdshnTBW5qkQk+91fXXG0zC82CSdD7a0VBFBgqJk7ACM+I6t7TrLkgY+rrcWmJgWHvWlzZaCjS4zJbZE0JhjPc8CoMSZxWN4sQvfT0Nq7ONtnsLzxmcTPxuuzQlJtEDpKhpf9pj9oz2RZNf240tq0PNEUEImF4HnKi/9WfV4ESXziRqNCCgTjGmNhcu7/I9UrDM6RiJ3jY+O+MbIfuBVB+StltYpY8GJZrvI3NCHqgyWAodByGbFJbqA9SZ5durO/MnzMpTwHrTR14gf9UfCFt4T38CGsiSwekc7+QBfUrT7N42ZjiJ+9uhY7vGrOjTSHdA==
Received: from CY5PR15CA0199.namprd15.prod.outlook.com (2603:10b6:930:82::16)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:12:22 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::76) by CY5PR15CA0199.outlook.office365.com
 (2603:10b6:930:82::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 14:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 14:12:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 06:12:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Mar 2026 06:12:04 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 06:12:04 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Sasha Levin <sashal@kernel.org>
CC: Sasha Levin <sashal@kernel.org>, <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@nabladev.com>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <hargar@microsoft.com>,
	<broonie@kernel.org>, <achill@achill.org>, <sr@sladewatkins.com>,
	<linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 000/334] 5.10.252-rc2 review
In-Reply-To: <20260302161007.2523181-1-sashal@kernel.org>
References: <20260302161007.2523181-1-sashal@kernel.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <85d4f11f-ee37-45c8-aa57-bf03ace678ad@drhqmail202.nvidia.com>
Date: Tue, 3 Mar 2026 06:12:04 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc70407-2335-499d-9990-08de792ee306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	BoO/643QYzywyHu3gB5MfMWZ1rS0lDzAk9co9bXa825E9TubWOWlAGKZvtT4g/Qbv9P40KB3gNJk3PTz4WRzj7XRmkvFu9mSAUznHEVpwPhgUSR3l42eTzLk74MU1Clphmj0CmlMy965Ifaio1/Ke/W0YzJtnYeVbGeSJMyqzMXuESzUJtl4Wi7THjnR29So1xINhrDMO3jUFrWUOSXpWUuNYomOG7GuXV2L6txiEr8IWEm+SK1vCL8EforuvUsmycDTOcKGw+Gl6MpZofIyIiOZ1JPGt1DupUNXhaFnHOFEHAEEF9c2RcvkTI4fDwvHXNvcnCo50vGPGx7I9gdY3U8X+wj6Nh1xUt9ArU7PuJKeRxMRVol8v3u1D4iGRn12hyJCWzVNYX188yQ1qj+5xQwvd1HcFNvqTe9ChxRnfRi8IWj7mw2vzzuDMCDpZ1qwYZq1EIUuJbaLLWhyrcqQ+ijJtNPbpbDZ2ASrtqRPVh+ENGvKE6e7XiYm+IqHLhRKWGM2/uiMXLJavjus+rDavdDr2P/xm+EQSt0tDGgEikbF0PS6zMwKB7II0ZwqOES9MI+DYBq8lBAHY1c7TVJ0z78djm0tP0S80Zak/7nBvz6RFIYTRmXpd9KN24rRqlHc3Tsqq3n48YqJMToG3canBlWXUkZYnrGhFrZJ4xMwACWaHiQeHmeYLHuZdhLa1Vw56BpxJOXidqcwvj1QjNVEz0YufC5OVhSMUrmXWiwybmGhIBjJJrz3Ed8x7ddPwon1O7ZRbAwYhCt/dtaePs8pT0Rx6mrrZKr15yFpG01KILFARB/uiWkZzJjHBshYTM+Q8/0NoKZRIdH8ov8+cXyYcw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D3pxBOIDpowkqW8LLYZfVMcEc93Wbr9XANrdVn7pUg8lITKa8nFKUTdInBwcCC+z0UR7yipIm2IpK7gf6h7zicG+LZfuqiFpZmn9Jy49o0VcYCIiSfJV9JnIexVlWW/OpEJKEM37ZbZVbWrfMmroYWKPVKg309QgmjtjnBmhIH3CNkNrrHOaXy3Lv0ACkN907FJdOGNrB3d9xPCiLxr1wdRNM1vEBmHgI6EA5KP0Q6prLaCxAk3kXapz8IH/WN+eCyfd8Df3gpfLnb7e32vmPA/koE0WdJVIl8k0WS6+/b98NrglT7HpAW+e1hFppG55oiLgqhKO3S+pPhlyx0iQVAVZ72Z45GVlvtiFp2g6LP+EWccVJoelWZ+5CZpuoA3OmVeEJCYtlOSKtEpN4PViGX0EXQOvbyKyc9nats2zD79KuyC9vUlddYUWCvru6IRt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:12:21.6098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc70407-2335-499d-9990-08de792ee306
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
X-Rspamd-Queue-Id: 6C98F1F1302
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222887-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Mon, 02 Mar 2026 11:10:07 -0500, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.10.252 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:10:05 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.251
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    80 tests:	80 pass, 0 fail

Linux version:	5.10.252-rc2-g6f75a63d8746
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

