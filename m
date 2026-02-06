Return-Path: <stable+bounces-214642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AgzC8zJhWnAGAQAu9opvQ
	(envelope-from <stable+bounces-214642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 12:00:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FEDFCF0C
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 12:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45573300BEBF
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A32EC09F;
	Fri,  6 Feb 2026 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="izN1ZI5E"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B12224B0E;
	Fri,  6 Feb 2026 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375583; cv=fail; b=t43JVR7MQg+/0wvxzfuQKA4A+ghW+QO7oTsE5YenWwCV6jsMsGaPQIXqgqeTeSFd3Hm8pE906MYk5fNXwe5gMhqJsYQCq35MjSiFeD9fMQ23nERVSCSvTmqz9zdzFzJCbC/Ni0qOaMOgXsN8DfC4wyt1cdGSUl1oDw1PGrl5h5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375583; c=relaxed/simple;
	bh=n5zKwqQxVOmNBCrXNlTJC6JrpcgTeTQPjDN6fRQvqLo=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=pbEBExOPybQ18t57IG6xa/fgRqt91GyWFEzIuUnpjA5yeNX5JeWXcTOp1+6qYjOGiS2fF37BfOOmKv2/3Tmk0ttPtoQVdC1lwhNv0Vvhs9aJkpKcS5dQLaK9qWzH0/jHWTd3qXYucZSp6dxup1zanevpRg6ZEGcjRtcHCk4Ajso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=izN1ZI5E; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTQQMG5SRyIXtBRT7Quv+Muyrz9SciausVHhDVnyLYDtg9go1RT9k8CfuzJr5FGyMh8mB4VoOgfo1OhHjxFk9z7ffZucbIR+UPnGPYRAtY18g+U3MBiqif997/SoWOWFFuSxlBFE4Pzwloz1P9bajq3gPTbaZkq+tv0vKjXxO/0QJsUBncGoFPdKlcP/nLKFKl/D2p8XO0Lv0CcizDBDBSnf7Tkhz9pFlqDPd0F/fg1RFrmDDwXTZHiniPcsqGlSxnhOldkGQ+mUqhrv34PgAyqEtcdt7/GO+VSA6jT6YJ1pdQnioQRsQ04Et+f4pkTZAprKuCN/Tbx/8WVx/DM8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvo+ZW5YiqAcrAroJQWTN9kBnyCrjWlZBioNlNx8op4=;
 b=wOqO98KSq6KY4KwKCygNRRkMPlJsfncZlMb9IRU6Vk8kxEUvYRa9Tf6QJ5g9n2y9rxVKPewX4h4e5gnIRR4U/v2muMzdZghebB+9qezn2TCS2hLQzqAU+qKImpibd5bBDyp9MsD5+NGUoMVH67DjNIWg9W7oAIT7vlE+VmxdBxGiFhweHpfNWGRxN9XlG01VhW9JPPqc2vBHBgTbZIR5ejPktr7Ppw4pkGtWfgSJeIx7XedjKhYk8XHW2ZEUIfc5kAotQo5YSytoSoyZzO6LWco287A3r84FDVnDj6/PuCtMB8fYIddQgIoUeGSbhUb79ZbF855QgHgPEJxL84Iqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvo+ZW5YiqAcrAroJQWTN9kBnyCrjWlZBioNlNx8op4=;
 b=izN1ZI5EnFxzIJoZ06UPKr6Iqsg3RlK7D9IYjh7eCx6IpoTJWSX7f7iyQHByVcSGa/kEflLsrgb8/20X7QNabM/JcY5wZFpxplv6O1z43wJLGB1I2VzKgyf7rgdd6x1zN6Fl5TZ+ooxkmpGXKZ7ODyCrtN5pA0jqFX6cFRIij9TtB4gx3PAzUF6nUXpCB3z/+dTA91YKsUo5IwUpOXVoziZSvvm4JeYMFiaemtsIlHwhtHfNG0QFeC4CYj767hqnGPoFnSTn8aruOljg3Rf1nG6XXtGGi7An9TBu/hPdn09LyJnYRCeC4GbkcC6GKWoJUGB0f05aPH0OlabIMtCapw==
Received: from DM6PR14CA0062.namprd14.prod.outlook.com (2603:10b6:5:18f::39)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 10:59:34 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::ae) by DM6PR14CA0062.outlook.office365.com
 (2603:10b6:5:18f::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 10:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 10:59:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 02:59:26 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Feb 2026 02:59:25 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 02:59:25 -0800
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
Subject: Re: [PATCH 6.1 000/276] 6.1.162-rc2 review
In-Reply-To: <20260205143450.492803005@linuxfoundation.org>
References: <20260205143450.492803005@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <8aa26e00-1be0-4ef1-866e-0e1d5c0a0372@drhqmail201.nvidia.com>
Date: Fri, 6 Feb 2026 02:59:25 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: ded492ff-ec10-419f-2480-08de656ed014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEw1bGx3UnZ6TUJ6RHN6bHViSDhUaVhUY2RGR29Wbmc0d0UwRytHTHAzSVVL?=
 =?utf-8?B?U1FsTldRMzJ0bDltSXNaUHBQRXhlQkhpS0UwMUpzbFpOYm9MUzF1OUJtVnU1?=
 =?utf-8?B?L1BpTmxFVDlITXdJMHg1N2FDQS9ibE5hMGVZeUlwakpBRXBVekY0VjhHTFJz?=
 =?utf-8?B?RVZKUGVwcDR5UGhiU0xwQi96U3kyMnkvZEtJdE43VzNubU9YR1lIZHV3czkw?=
 =?utf-8?B?b1F6SnUwT2xyc0twWUZWSlF5b3d1Nkg3bXlGRFhleDBGRzZGQzNGZk5IOWFY?=
 =?utf-8?B?UUlKanZVa05pOWZEclZNamJwZ05WTFhXRmp4cnJMbHNNenE4TndRaW1GNVlK?=
 =?utf-8?B?aVlqdS9EY0c3UjAxMFNYU2dCRmxCeVduN252THZwSmcrSGZ5Tzh0MkNlQjE4?=
 =?utf-8?B?di85S0lPTUZOUTlMU0tJdnNKZVJYcFIwZlZubkJ2R2tLUlcwZEhBQWlHaVdD?=
 =?utf-8?B?NXF1b3U0ZGlVN1pzaERqZFhBa1NmOVpBUkpkemRZR2ZwR0E5eWh2MVA4Qnpl?=
 =?utf-8?B?SyswSWdDVmtxVTFLclBPUURVcVpNZ1d4a0pSR2lzSEVFNFF6ZmtSTnIyYUZh?=
 =?utf-8?B?ZW9FaEFWK1dveklGbFE3OUtFOXBwaWpYY1B5RHhndWlXRnRwNHRzNlM1SURJ?=
 =?utf-8?B?elNEek90cnBFQkgzN2dReGs5cUcybDl1QXlkNVVicHJNMDdCOFdzZ3dVdnJP?=
 =?utf-8?B?OEpHQ2xJcVFFVG4yT0lXUDlIM1BaTVJzdGM4cVZQRi96U29LcG9mR1cwaG5i?=
 =?utf-8?B?azM0QVUranJGd3h2dlNFOUxaWkx5bERGQ2Rzekl3MnpUQndZY0ZHb3FUN3Fr?=
 =?utf-8?B?Nml0NjQxNjdwMmZ1QjNEc2xqK3hnZjczVFpWLzBEWTZ3NXFST1VvWWtTZWRD?=
 =?utf-8?B?UWIxbHRmRzN4VlQ4N2lsdkk0KzZaNFBPeDJkckk3VE1yaEpla0ZGR2xiT2lF?=
 =?utf-8?B?R214aFVGTzRDOC9NWWxLd3ZEcldvSkxXNVhBaWN2NVhjRGVCOXBLdTdjS1lq?=
 =?utf-8?B?OG5GYzhiTDhjSlpqSXFGNU9GSFlIWUk1bytYMkpsbmpYR2xCTjBveTNKQ3pE?=
 =?utf-8?B?T0pXSnkwSnhnUGd4cFc1M2oyU1dIc0lZV2NPTHRYdUdkd0Z1QkVya3IxSm1n?=
 =?utf-8?B?bUx3SkZicEFlQVVHenUzRjdaN29sZlFZOXZLaGVrSC9IMUtxYVlrZ0MvS2tr?=
 =?utf-8?B?blVsZHVyZ0RTSGF5MzdaVXRsT2JvbjhCSDBHNVRvTVJqU09Cb1RKZE0zSmhI?=
 =?utf-8?B?NU1ERW1YSFJyMXEyY2g0T3BtRzhjUHhSRWFCdzFWL0E3Y0JKTUkzZElQekRa?=
 =?utf-8?B?ZnV5TzM5V1BpTDNJRUJvWHBWQnQrNldzYnlScVBiZEVvUkNLN2kvT0xiR2ZI?=
 =?utf-8?B?bnBNSmtHSDhNMnpyakRRQWY3anZYWVRFbk5GYTVraWdPbVNaTTVtY2dtN0dy?=
 =?utf-8?B?WUJ3VFpVelhHTXRZTTd1YStWekluUUdRaEZISHIvdEtDVVUxeHlBcFhxbWQ4?=
 =?utf-8?B?WlNFakJOK3FnTmpMdHpSZUVWNnBSU2x2YjdUL0lYYk9taWFWTUROdHJjUjVv?=
 =?utf-8?B?dFJCeC9ZVmJUc2dFTTdIdy9INUM1cVp6dDQzT3FXSkExbm1XMGREa3lwNHQr?=
 =?utf-8?B?aEw5Um9vNG9HVkZSK1R5OEtNdWVxVVRiQnJ5a05pWU5uOFFRTUtkdW9jTG1G?=
 =?utf-8?B?bGh1ejJ5WHAzNE5jZG9BUittQ29rcGYxL2tKRG1kSks3TUNvSUdxZk9PWVB0?=
 =?utf-8?B?clc2c0pOdnppa2VtWEpGS2doY084Y1RJVzFkNExyOEord3psa1loRDcyUWtY?=
 =?utf-8?B?cGNyMFo0U3BEbkRqTGxzOFJ5dlNxa09NT0todlkrSG5YN29LSHFyNDc5Nloz?=
 =?utf-8?B?eDhMSHpvOWxQak1SK3N5UytLM1V0RDdDc3dJOFJxbk5IUXJlWk5kdGJ1UWE0?=
 =?utf-8?B?dDdNN3FpcGZ0SktSeWJVNmNSMkNldlRNQjZXbHZhV1l4bFQ0VHNUaVlIY2F3?=
 =?utf-8?B?WGYxY3FxOWsydllZVi9GaXFCeXRVWUVPYy9PVU9ZOFR3bTBBeHJXSktCYjcr?=
 =?utf-8?B?TjAvQWh6dFhoQ3dVMEkxR2V6SjQ3YlRtQU5VbEQvazViUlNoeGdrQXhjWnpj?=
 =?utf-8?B?ZTJpS3ZSQWJZWUFvNGlNd1F1TTJReFpJeWtmTGZOOC9vaG81a1lVaDBJTHp4?=
 =?utf-8?B?dzE5L3E2dGNPaSswME90Z3RhaEozQTVLSDVQcmd5ZmhRdkNpZzl2OWYxbFRC?=
 =?utf-8?B?QVUrNUw4RFQ1MkU0bW5Mb3kxWEFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lm1bOK27xAvPLlHEZYHKpuQ2Mh/xsvpRt38FVCDHjixxNBEyHEPsGOak7dbDtyrd3HxOsyofLjkTKQ+fVSK5gdHX9WFxp2/PRO35G2oypRpHDIyXw2u9vVHq+mA02lujR5381HN3KdW+effgEdLBJSVgDv3+MW7lvkxl7KewujvC49Sa0dPd99akwZTSHSXEZ0AUxd+7Lwx0495LVZICrbRdynL3kojMA5xzol4a4SooFcsex+wpt9yroVanjHUFi5/BojxLXls7xZHqWSBH3GwVwHrHeZTG35les3mRpmRWrD8X6c1v9zGrl3RdOaxGXt/4HVcRksRn6OsDN6A1xj85BJfEKVlFtNeLlEUPxwePsS4+UAJUkMiFArMpFJZcSNiXSNQP11b1PrhviW3ODUq0N2tTQRX6bn7Nfyx2PrymrsZNK3Awxezx7KtGXCEL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 10:59:34.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ded492ff-ec10-419f-2480-08de656ed014
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214642-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,drhqmail201.nvidia.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 82FEDFCF0C
X-Rspamd-Action: no action

On Thu, 05 Feb 2026 15:44:40 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.162 release.
> There are 276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 07 Feb 2026 14:34:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.162-rc2.gz
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
    28 boots:	28 pass, 0 fail
    132 tests:	132 pass, 0 fail

Linux version:	6.1.162-rc2-gdad6f0d7f8e3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

