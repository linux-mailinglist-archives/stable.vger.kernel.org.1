Return-Path: <stable+bounces-230091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLt3BsNUwmnNbgQAu9opvQ
	(envelope-from <stable+bounces-230091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:09:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF523054B1
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75BDF3057590
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00DF3DB657;
	Tue, 24 Mar 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qPEGuWj7"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895163DA7CF;
	Tue, 24 Mar 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343074; cv=fail; b=da+8zh08blZKF/Tt7d9Dg1pAwLPbXpVacD+8XudnOqQ1kqTa4iT/ZJLNt/mBGsslO0UBZepe123Xm+mrMy5B+5EGuz0tbze+CE3DLvKxmDF5yM5SnRai/iycaBlhLRozeehC+Voa19dLVaZWN4OGCtQsk5tvIMp+blr0lzqX17M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343074; c=relaxed/simple;
	bh=uBbIDnqMZ1HLkWwpWnMFVv6Qb8u+V/LFUNCI/UGymW4=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=P3fFha+BeHDbfg47kMvO2s+GRdAaUbAXxxkl2Fa5v7ZTT1QcoA7S6xhOiELwrCdgFuHL5QtzOLDkeSCiqRy2ADjTVkPpzbKGbCxq2XwLjbFAFSseRVXxnSDeelhv9ZXsXDfgkq0SZOLrTd9I8XOX8OCBwfte9zxuObpZsOCEvXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qPEGuWj7; arc=fail smtp.client-ip=52.101.48.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOyX++9iarcOC9AJc+WOmSz9NPduFSwC3RtndaM/eapEPIQstDzO3h+LZA7ib1ce7PQRQ/JVRomXIychLy69ZmoLZqIUQ1WBQlFA6sJ4iRdlqYGyD886i+zRL1e3Bl7VCjBmV7jBoYr++kPje0mHk70TbxeVWl/g5ZELxg4sOm2MIaEHtn2knOC2y8ql+1BCk6VLlXs7w1REy23P7ZXZ4uIQpyQ644MmMpTkB9YI+pPdhvvIfGByDi2E3WYi/4Dyf15yMkrGqLjyf47zgS/VVRu9cImSpcsm9QTGhvZt5V6Zirhl22P41GZz7lroOHfr4wjy/ds50h23wL9UpG2LoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDeyQCsEczZ9CsAiezFZwM1NAJnbET31FSBt8dqX+oE=;
 b=nvg8wQh3e1XwqJHhdwbn8fH4z5HcwORKHdQROoREUscXIk90FLyiRbJwB+vb6gvsG477wb84Js4xJAzbb6k+Yhx71d2ekexb86u5vHnLVMif15LHmhGT+B+UDyVW4Y7SF3ZYcc3HcmDXAoYWJxKXIvBQS6Som9+7BJknvcuCCh8yj1FccnS0ZlE3XLUvECI2dCt/bOCfwnkI+SyBYxC/kEbwswxYTwjPlPc9N6oifpaBNZPU34S99hxjJzV604CdpKv61KEJJmMQwC4y8XtWA7DjEJgxqUvx5vKUeMjWt4UqrU4HGMAxkM82WXYWBHr733uym4RRnc/Ubg3jAwH34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDeyQCsEczZ9CsAiezFZwM1NAJnbET31FSBt8dqX+oE=;
 b=qPEGuWj7vDO9bbEqt7zq9nfyuFlFzbBgPZGpCJuojIaCTw6wm+Aszd27wLWljvdRNOk+D9BH9itRKw26jUWj/Dj+hrjlwsmwE7ERXALIZmDjTPKucFT1Ku6gHrKg1G2qDAGnKjQXlWMkUuAtqcJfQkglSw9IMrMUxde765MWe7FwmjRiq3U8j3sFwYcMauIJN86AFfIp0ETqSZUpd1zupmv7FdsWHJAvF+wjS+XQ4+hIIBjpGxTxVDkZ0ZX/b+1xq2ixwjVJn9C6pKsK4m3M2hRVgfVbyFwLy9x9qUIOX8WyTpFS6OdmJy9fPhmJomcDmuLtZCxqfGGHiZckUPHYyw==
Received: from CH0P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::12)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:04:22 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::f2) by CH0P223CA0024.outlook.office365.com
 (2603:10b6:610:116::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 09:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 09:04:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 02:04:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 02:04:06 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 02:04:06 -0700
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
Subject: Re: [PATCH 6.6 000/567] 6.6.130-rc1 review
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1c29cbf2-1b5c-4278-8607-a76807372f2d@drhqmail202.nvidia.com>
Date: Tue, 24 Mar 2026 02:04:06 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 524b8d6c-760e-4fd8-9d77-08de89845700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iYiDZ/TEsV7HG6oHLWTdaxedDF1icMtlvWYffHVnrOt8xcvSKaRH9RyrxgqxmWo8YMBULRUIBNRyus7CeXhQCfiZ7w0BhLsfZ6MhiixkL4UYmcWMOfY0A+4hbApwTTSntD9kA1UMPZQL6QDYJPfmbtF5mToShuD5yFMHwIgU0na1boLcRZPXhXFlnE6cVMqQjT/swWkdGYum7jwwbB161xSerABWEC81MDdXDOhP32ZjUThRvw2OMWC3a9vRioPQbVDoHvpPgYqmJKmy9Tpj3gjhxibWGMCzfghT8+BeG/PxHDh73iHlx/jOMaeg+fPT2nQwSE7Wc8I3coc/CioqM0X7jFEirzVCr6jTQRAL41SP3Ap5HH1cvIU5lenF+a08lEgijmKt/VVdpgunW4UaMLa1TpZmVLZNyt3L3TIhdxDy1au3608Rvwp8/wm1T5pfixKPL/Uus8/tHAMPx7Bfpb0tBUYVt3B6XRWxZv+G0W8kiUIvTv2cEghT+g+EDlIoU6x89MyEM7zM/5rq1pIhe+bqOhoVHnvqUmrwQObUuiUweBG6paOnZ1mykEiv4+c29YXDAEgMhx19CbGSnpel1d0slR/IsjZhSj+Bd7z4EYz5hoqg1jgpCsY7UeeRXxhjA90L/7oVp3q4zMvGOlqAl5csTo0LAs1yaUhPza0H6TBOfXuDYmpyQVUmd4EoblmOQagPte7jlBuhfXMugu1o9hog1c/yVah5CKMVczZDlxPpseQPS2Gy16LiVFc/BmS6Rp0VLxXcchuRbYDCf6jScA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qu7P8ltLFYY8mIN3ciUcO5jbaYqVrIxyakoTyGAotdL8Q+8Y70Q3loQV293wlUCN116W8IOtPhE7guO01Ui8Up1onx9bI5Fpa2F8ZbszcxZ/YKshJEkBfEDCjJl44RhUElED1G9nH1iDpx1HhOOBboLvnO23qKQEDkajq26kIUjCIXay5OhjCIDCtK8+yS8mCqp52WkjXY63U6z5B1dOCV1AEGO4rA/srWMe71IyUuguPW8ah5zKMU00qc0Iq8NEUd2OvSVgtWaTD7cc45twfiqZ0e12EURjRuKge8Oo38Stn3SKADiDxbOkfduSDVuLxPA9nUHqGULXTIKM2yLZZou7gqxUKL+Xrxq2RLJ9gAJVAqDRijcEXPBnQ4di/GP9LmYrUpGTnwVy4NG5+mH7Y2FWomSwo/eK0pYWHPLwza7GTDGP81fx7bum7y7IU5rq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:04:22.0095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524b8d6c-760e-4fd8-9d77-08de89845700
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230091-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BEF523054B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 14:38:40 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.130 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.130-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.6:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    133 tests:	133 pass, 0 fail

Linux version:	6.6.130-rc1-g90f5df72e0fc
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra234-p3737-0000+p3701-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

