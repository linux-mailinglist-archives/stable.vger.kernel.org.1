Return-Path: <stable+bounces-235457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAafD+Df12klTwgAu9opvQ
	(envelope-from <stable+bounces-235457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:20:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ABC3CE0E1
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FDEB303CC2D
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247C3DD530;
	Thu,  9 Apr 2026 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJ91+P10"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFC346AC2;
	Thu,  9 Apr 2026 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754972; cv=fail; b=r4XRQ/e7jyAC6lOqA7QdUx8zM9/T4aNpqtMp0x49pGn5JkSrE5tllIS53oEDbIOYD7eemoM6MsmhLlG5JZq1tcnXX7r5kJ4wUZBsl1FE88C+Op+T9X2Tqglc40owVl2NKpUKsSYzwhfkYjXSNBUW7UnaeGHnU2A6moAhDn0EWUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754972; c=relaxed/simple;
	bh=aodlW73MOAsQvMSl+5Ak+W3y987TAIhoH2EM63QeI/8=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=MScuQzjuhLQEee4Ho8TaK2X7+ti5qePgcr/DBxJEy0Mshz0PTHqSnC8LjhP/sh2IOyGfM0ZkCWZT2E5HimquSSkxBxwvAedz3VQvVTpTS9m7L+zkER8LhGvePZ60wWS4b8M79btY04LN0sBg5gVM1Z9GxOekcU7JVPGj4GFcA6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJ91+P10; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVN8YfGy0mju/rmJ5+rUEduTOvMipkNPnSpuDmKTsuZKB9NK6FJ3laFsOdSo+6KQExZxxm5/uv+NJyr0+QBIFWCae4Ad+vCka5NtgsERiCZEalMtRHZe/ZqY2oqR1F88Ki3ReFqsy1kDoKM73ot7kurrgrlCF1Cole1E6/KfLwfChDTWDIEuxurCkOUTSwhKh7yKgB8rN/LUDzGBUcAOx9cNZFSuQzOVtXz4cM+s3p0IAyLOSty1BVdBxY7P3QMFtWqZkN4zMy16ii73PLRs7CrWP8njD7GFR2gCBaKgQryfxeihOJQFXoSu+x0uLmzYLXVYKftQznCT33VFGZJ4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPSy59OI1QYViamPwRDEjam69nSwW2tMLQjdAwNaIGY=;
 b=RhI97WwgZQW9C3KfYsoqflyVZFS2yRCIwGwPq7LTi+dFhywcaxrQHiIonrEuOoADe6lLfTTD3jGln7VPketRkyq2QY81X/hMVgzppBohFkclmVgbKMZa7qpObK+f2OEo6OsMPB7meY54SNdFsBUk4VhaOpDTEiLUNsZ0+q4dXWF2XNpjgQ6WAckNFhRHuk4ZM8SiqpEgJPSDwFNN4e/XnHa3bVh7E63xZa8lo5TJmzrUMCG1Oh55NH0UkWm7JeLFMa+eFF3o7Kzqtr0OcAtayMFLnw+IAwYN1As7ZEPb0mmAxRwM8f+6hcytSzi5dlMLxX8ZIjVkZMJM7zcZTYpfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPSy59OI1QYViamPwRDEjam69nSwW2tMLQjdAwNaIGY=;
 b=RJ91+P10ASzyKZpg4uFFji32Xgl0xfJClf4hyKtPWSOwy3nfpdlkhZ0LCVqQpvSaVpPa77xwYx8pCzH1GE67bHyMw+uDQKHtWSejWdJeIwiL59DbePGUl22paZ6c6nWynqhGLF3wtoVO2dyfuijh9rSbfZuZbj6nayQ/2kR+JvJM3MvdiOLr+WdWlv9zTb1qOM8PIawlLE1GnUXcJaJEhwyRdF12NMPOEG1OtFM9bUzzOHY5vZl1upuQ4M5DE7pU0XaG8QVg6WshubAM1DA0jOL8D0hgOSe28CXtDGOo3VmyyRPAJQCG9mbUbdYel97E8i9lsaXoPIcLsLCbdNBcyQ==
Received: from IA4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::12)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 17:16:06 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::d1) by IA4P220CA0003.outlook.office365.com
 (2603:10b6:208:558::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 17:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 17:16:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 10:15:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 10:15:40 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 10:15:39 -0700
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
Subject: Re: [PATCH 6.12 000/241] 6.12.81-rc2 review
In-Reply-To: <20260409091733.126574279@linuxfoundation.org>
References: <20260409091733.126574279@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a37f0f12-b7ee-49c8-9e29-b63718e5b723@rnnvmail202.nvidia.com>
Date: Thu, 9 Apr 2026 10:15:39 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 54366513-e583-48a0-f36b-08de965baf8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BnBPlUeSwhcSdNVB4uhBY/aOnwxk8v4dOXU+3lDX8weAAYI9UiHYeX7FP7gDSiE4pexArv6oEWMgxKI1nRmTeFYkb8VE5V6fKO5HcbKA2+joKq/2NW/yS9znFP2mQQ48arU9z29NpjXOUw9HqYzw30/OhlcXW0lzBcZks3ggjojReMTr7yQxKQ1uSmX7zaKP/hFQrmqgJNa1LHEy+jVzkhgL7156kK2sTwo84ar4PaYjpwF97N1Rt5ZVfP+BB/YMnd89bZ/YB38gOhUlkskNM0HOOkF5ibg/2F2s9EcneFD0oc8BQiqQY/rri9wNy926d84gK9QXZ6ztJxdxEwZhEhHoAuKONaa/vtwB5q0hvIxxZeU4o+/lFKAesuE3Vk5PD2ROysDo7d4B0ns916le6RP7NZ7dirpcIvQ/854w+smUP6aq1/4jFg1j8LqpNwABZra7VGagEK4kZh05klmAMF9eDtusheSTHx1jc5QysvUfME5e4myIHPJ85iBATucIh6rW30rrX4xJDgXajbLY17CFLJ5ZTJvjBIxl7qvtYrE3ywI2cPMZbgDN5DIa0tjukbk6sBiccLkJVpm2KSMG29KBkn24QYeKQcvCg5F/zS+PkzsHM/RDSrgBasgLHroY7kWFBVaFjB6+Xa/SU1hZO/9uygqZ/o+VQGnZrwurj6EJdTvtt31YUTdsiMGbz1UCBkucNQtJHjCLjZtl693T/3AAeAnn3EwNju43U8lMkcHHVT3GGSBq4sMpqZXooRN7MdeF9jHxP7qcf4O+8FgpBw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EFJ28F39114yY+wRttNVwf4hP1UGx1I+2KwDjN3zL8qaK6OcMfw5/B8gN0Cdmz3LUrrf9lDM0bnv8aXBOkvjXRaStFFknGDuYJuwcX/Ba6N8WiKNUROAhzX0YQuSsSWOD3KYUwi7W0EQQ8UvjQIAM8Hz5D83CyLORe+T5+jYi7YWKe3Tf3RHlWXZqLgeGGXPMbEriaasyDhBzkQcxCU4Bckk/VKiGg8kQNPHi+WfyPsllL0+4t6OlODcOYJ6RjHlTF5VsKhcCDOFlvgLML6H9Hi0K66oGmWjb8QGdH3zQ3sRi4n2LsVuPx59wrSFRz6iD7sqLrn457QcaZqtNOz6jyRsXt8m47uQ9fVfHD2kV/GM+9dckFuxdEyZWx77+BnUlk1qqBb53dMuHm7THAsfmRpEN4RkcW7yInC71Wo0TucdSMEq3EnV40bHIOSdCZHo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:16:06.2901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54366513-e583-48a0-f36b-08de965baf8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
	TAGGED_FROM(0.00)[bounces-235457-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,rnnvmail202.nvidia.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 90ABC3CE0E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 09 Apr 2026 11:25:21 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.81 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 11 Apr 2026 09:16:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.81-rc2.gz
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

Linux version:	6.12.81-rc2-g0ed76c578036
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra234-p3737-0000+p3701-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

