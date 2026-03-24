Return-Path: <stable+bounces-230094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Cx+F4lVwmnNbgQAu9opvQ
	(envelope-from <stable+bounces-230094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:12:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FFC3055CB
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC2C3136F5A
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50883DDDC0;
	Tue, 24 Mar 2026 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgIzL+qT"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF363DD515;
	Tue, 24 Mar 2026 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343106; cv=fail; b=kZy1wAkjzYMgQHmpjrKpnm8MZnaexHlIfUxul0DeHIhi9GfFCkDt9zpEycIoep6OxNUChfi73YJPjH17BWoiwX2X7xzWiO03S0dmWStcDzBgyNbO/BiiGJq94P/DwPgXakSRDjXkKtkEYxRg4V1a3G+JVAIVeDMJHEbv4ZK2c14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343106; c=relaxed/simple;
	bh=CM5tipMKIqasVSn6TqT5YG2zTjmI2/gOq0CipI8nwT4=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=dCPUUvrxs8mnBe6D/SYX021vWpNlkhAAvO/OXXDvflrFxw8v04ggX4Q2Ewl8b0lDqJJsMqIOq9HiunTJxO2oiIBpH+dI7UT/UHIyHRSWglhNuuSGNTir/tGGDYMj5FbNGklcpO1Bnx2jVoRrNi/oW50p635uUTGBGbRdSN3QDHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgIzL+qT; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP1VDYxOnL78EF+xhoWfeXEEkTP95Xb6HJgtAqrkmTEU/iJ1QE1ru1anczPezWBjfkvzSMW+ULUhFfvHznXGH6ZLBW6vsdd0cpnPptI3lvOyobmEsfvuEEdR0kOP2YYa+V7EqN3mtLtp2vEXBbbvpBKn52vfao1NErUhvB+rHh0g76w/ZtRpRQFzePJJRCSdllQV5M45R6UDG++74OucZzAeFuQCSaHC5plge1ES6AQd5sbs+7I2Zpj47LBdxoIT7B+n8eM8+FmjNdJ2gghhqFonTt/wScGZpb/a5rRRd7ORu1V02IkK3t1qPwd1ewBN345sEXkWhJs2MT2OsqpRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3qyn9yq5hukN+JubTA3Uimry9ro+j6GXTgcTL/PL80=;
 b=qKFf25+vnJLGHQ9we4ifRUYj4WCaz0Omsc8+ujgCXXpZ960p65iq8P1wGykC+qH9CrOg/EaBMTabo2wztIET3ptijuyLmEF+ks7cVQ3zVxuhOACea+DDqpApydwMLeVRJyYxXCaPcBCqalnN0bD6pf05uNOciSMi5kk6kUJ70MorlBzD/UxtrP4BtjvZ3C8SfLYSwbKAXbscVnNKwUClDVLP7EvwhDMySDVbla4lbm1wSh+PzzCzB+h0OvMxnd2S9EDOLjKtYy1MslHMWkz/X+pEqJMEuNBeYaHmhNyrs1KAs0Vgwpb/nmj5+oR+kOa3mmR+oTlHJ4rt8hoc3jEylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3qyn9yq5hukN+JubTA3Uimry9ro+j6GXTgcTL/PL80=;
 b=kgIzL+qTZ+zOsPsdH4F5PFN6gzFyKvAKovgju1aAGbVDnzwQf+QT9iSm9/hsqJ4mnEDpksXUUjMELSrdPkwa+XO0P0u6nfukKs1KxNh8ZnhdtcLaB9pqpaWiKZeUPyIGkkfnn3E3tELMcBywn2e+HPmN3fdAFpr9tj5qdktk/OYOTrybh+9IKalTW/Tf+Z9UjUPHlYIgjgcW+jWsAGqxbsPiZ4YhpI88c9RmhF2l17FAQLnKvcpq0itE7AZEZgdvmNybox7H3vzTHmLTLoT34GPSA32M88ChLPOuKrYK7U3T4B/2LpFjcUKEdB2R3nIxLsSmOwucZbktY1WcIoeAKg==
Received: from CH0P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::13)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:04:51 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:116:cafe::57) by CH0P223CA0017.outlook.office365.com
 (2603:10b6:610:116::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 09:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Tue, 24 Mar 2026 09:04:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 02:04:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 02:04:36 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 02:04:35 -0700
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
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4fefe330-0f27-4456-933e-5e3472729d61@rnnvmail201.nvidia.com>
Date: Tue, 24 Mar 2026 02:04:35 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4a375d-74ae-4741-4804-08de898468ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pwgJr8hXz7/wc1foJKWDJyrorxxZbTXj6OdZclwXwHYajW7LdsDAeUPipR/QGvrV+i3WWARbBKNKdj+lWfhrLxS0aIqzHSTqZzaZZ9rHGqfpzaNawAmnGPtOlV2u4BqO+O4gGVGMVNusFKghO24NEVF1CDDd1R3SUtKA/LqEaIwZdqQSfQmGxoPAZMH8XmalTs8vml0g+sioA5+FFSefj1ehQEKtT5ghP5WZ/pry01sw1Xs1QytkSPahpxsfTiOXAJVcWqV41xPSbZgi+alFLqcE0U/LTcXw4ti+mjr4gILOzRERSpyrKfa+vqWi1evr56Kp0Vqq7mR18DHDCmeMlDQ0DQ/atWmAurY5S0+xeMtFP6lPebEP+xqizSMcJQYJBlMxPSB0jGqIZM4olbq2XIjKX6y8Q3AVyZ7N98ph62brcbghhMvSI6Kw4eZwebc3UPU4XClO2WsbntUvxfGt+Dbhf0S5omwrmzEzSZ48zB8KSCfFRCs5cMRJKmAlbCPZYuvmXC9NN9r+GBtFiHILEYmkrHdU5rdAClUv1sPfkV8+nGOT49ZwwoNxHWL6T2D01F+qXi7+OOO7y1Gt0DSqqPwf7WeDG2RQE6SIZ/5tOW1o0MIDFGM4/f9Q2zHuLmTDGW5+F5oZwy4+9CEgoegKxK99aNpfFAD8dV+YH/SmrMRkiJbF+ayra0gnCzKxAQlZA4seVg5hqmoiuXtnkd6EIHt2Pm5POdFhdpIAdew/AEI7TF6hKRxEMRW+dNV2b4dtrHS0cyp4is1MFIvYk6aQuQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gHfWbISCeZMUP2JbKac18gSONypvgiy7FBl5crMksQjDNgieiK1bdXXCbvky4s04awycWFBXquAhbIptaSHgCaa4xYgsMHX2VqviiL1CBrpmsAD8KknnnBjOwMHaaMn4hN/y9LYblC726B7aVjsUisZMOk38yXDCkG0G2vUo0+ujIhqywdjT7ssU/Khl13eXrq1HRsed8jg1o1eQ4NuMm9pBK8oavlLRYIvbSdx3vJD5D2sH+Q7M/0JTyqNcS+VT7yyLH3ExbV96T8kaDDDszz3JwoZ4L7DsuqhKvzxaAQ4Ejl+4imsZriW1l3OJc/KAeU+daaoB0/It55E6sl8vGRwwUUBUbbWBD4pbAlOKOcGR+8fj3NMcc06xrv9S4Q4QelbnkulKnXFuMYTWTV/FjryGexcaY3RZI9fgF2i2pGN5Nej/gmPHnXP20So8dIKB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:04:51.6540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4a375d-74ae-4741-4804-08de898468ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230094-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B0FFC3055CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 14:43:41 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.20 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.20-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.18:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    133 tests:	133 pass, 0 fail

Linux version:	6.18.20-rc1-g81b464548274
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra234-p3737-0000+p3701-0000,
                tegra234-p3768-0000+p3767-0005, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

