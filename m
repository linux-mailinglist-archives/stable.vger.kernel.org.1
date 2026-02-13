Return-Path: <stable+bounces-216309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE3fH+Kjj2nASAEAu9opvQ
	(envelope-from <stable+bounces-216309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 23:21:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D3139C42
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 23:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C77C9301A413
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565C03043DB;
	Fri, 13 Feb 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZiTiObCO"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982A2701DA;
	Fri, 13 Feb 2026 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771021277; cv=fail; b=tZuGMZMN9zx38T9ffZ0QvsxeClyAAjSZnJ7xeXe6v232Zm2141lCVjvCBJhHdk+EZYU8Bxye0G+1vPeHoervQdf4kYj0YyuMnkjCbz30PCDxt5z8uAzskqa5KTQXoOeZwRsHsiHjeqdhFdcW9bmksZvzs/s1dwJNv2AUHTOkJuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771021277; c=relaxed/simple;
	bh=FDK+qJzXyumwmhI2xNWVmlterPmG6lDg9D4YkV6Y+ns=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=iHyhTTULMDDCmMiBmhCiLfHb77ZS8KQAsL+jQWD+7oqfiOewj4uuAgFCSdq+0Gq/WPKeqbmmPcR86KknyOKejapIpl8G7w1o7KZfRpjQlZO8CusPAsEKxaNCIhF8ZjKwX4ScOBfhD63SFxmmDL3VNlMJqblB1sFPmHF/8CUe1uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZiTiObCO; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOlPbheafg9wPlG2r50bHJkdnXJgbcgcAOQ8HbizLKRcGu6V/8zhENJ3ajre5pXzaFvEhHnxshfSZ7XzZzIllqfGVMCxNxiOMjXghOxMIS8AB3PqDmVogdGRJ525tcBDRikbDk2y9LBAjVY6ErnRmmcwrhRtOmG6Vm/q3wq//V6TFVNAuKQvMcv1A1KwlQfjJvzdum0lgpyiNesy5G6/r73uAyLS69k/UOCgqW+L/3g+GHr990XeoHqU/QFBkdodYf8p10N+kJVRQ/vSc4nMRURdj3QUq9RFt2kWRccpmjE+aBU9bqDApT1qLLz/kfax0lb+/6r8Fo3pU5HcQTn7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2s4RHrO6yNfu009lgEYOB55qwt4dStm9TC1tM4nN1Y=;
 b=D4syZE7C69CT4B11MId0rM+OpLhHObQ90ThiQjGN/HECVs9php4AziwFfbmFL3NnzNxZBTNKduklSj1ACBJYoXfrtfy8kdlp88fhECLJqiVdnKr4c34Bkqe8/hWS79XsmYQcoO3BPAGGqgSbPzcAo3+wTm5JihmaAt5z5Y5S3epVI3b1bPUELnQlER8egD/uw/NQUDk7U6B3WOU72BicePQhiHAcHFyX6bSbpWSik1NIsOwkEsD310qABra0/W5vr1txfSbvz1eVO70jsc/z4UdSTOtvtGDRP0AIMROngcHeaBDjlPwsdwgPcQUPEFhEy0tT0VGxM0sgucgv7vwJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2s4RHrO6yNfu009lgEYOB55qwt4dStm9TC1tM4nN1Y=;
 b=ZiTiObCOQXw3fdNAxoqJLMPoXOVOfLxOrRfG6ZTNRvdyRsgki2n1jm4yBS0CbpUWUbgjMme0m0DRAPYZh94Uj+PmBstqeO/Y4OPnEwubeKwOepQuaUlSikANS9JhHfx0p3bVpu6WY9NcjkBVDtAFc0Y84kWWyG0Af5YQxBKBg05YvFw/Yf8cTrX/wYFFvzqHFmfRabZCf7EIs/eA8OMmdNSHYO+7UbC7WWG/vaES/zz46NyifSS5iW63ABN6D+V5XhtFWjVE6M10ruk2F2VU5JuWvNxgfQWq2DW9TpXQo8b/jX+Uva2zSMVW15wR6JvlOrtKKkYjaqUszb3+9xOWOQ==
Received: from BYAPR02CA0016.namprd02.prod.outlook.com (2603:10b6:a02:ee::29)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 22:21:05 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::4f) by BYAPR02CA0016.outlook.office365.com
 (2603:10b6:a02:ee::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.13 via Frontend Transport; Fri,
 13 Feb 2026 22:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 22:21:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 14:20:48 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Feb 2026 14:20:48 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 14:20:48 -0800
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
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
References: <20260213134708.713126210@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <0b96e6c7-d6e9-4e18-8d6d-41040c9d4103@drhqmail201.nvidia.com>
Date: Fri, 13 Feb 2026 14:20:48 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 83973ab4-4b8e-4c4d-b1db-08de6b4e2d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnYxa0dzZ0VSdTJXTWUzT2FzNVVzTlFKQ3hiTVl4UFBWWkdCd1l6ZHgvY08z?=
 =?utf-8?B?aU1iZlJEd25FN1pObWl3QVhadjlqU2JRNjVqS1FKaGd1WFJrWkpNWHF3N3ZT?=
 =?utf-8?B?TUdGOFdYNjREdXYvZ3BrcFlzWjY0STE1dGpWbGs5UWVvaEpxTUI5RFFTSDJz?=
 =?utf-8?B?QzRsbjhReGhJK3R6QzhIT3Uwb25jMTM3V3czT2M2WkdoeWV2YWtMRFV1S1RQ?=
 =?utf-8?B?QUF4L0FQeW9HUks1NExTcUtzaUVuZGQzMkZ3NmN0cTRXbnVJalVMa0lDYy9X?=
 =?utf-8?B?dmg5RFJvbjR1TGdHajlGN2JQeE1CS0JhWG9XQys3VFdwYitCMEdkMm9SODFI?=
 =?utf-8?B?eXFLN3BYN2J1VW42TTd6UXM5aVUzMmNPeHA2MWoxY1AvcmFJZXNhdUxneFBH?=
 =?utf-8?B?ZjJkcDVJY3ZpSGFEdmtnZFJWT25wdnVkcUN0VkR3RFJGNjQybG1oM2lNL1JZ?=
 =?utf-8?B?K2JZQURpV1I2bVBPMnlIcEx0RzdkS0RCaWVwN2ZwTTdqWThzN2VUMDQ1cVpm?=
 =?utf-8?B?M0toN0txM2F6ZU9QNE1sUXNsY0hHdFU4cHRsWlhwM0RRa2pOMWxoWUdrUVpK?=
 =?utf-8?B?elk3UlRYVDM2dUExaStEWjZSRUMvUTByR3FLd1lTeUpKb2NIM01Ycm5SMWdN?=
 =?utf-8?B?OFUzWlp1ajU1MExKVjR5KzV1TTA4RHp3VlVCczZaOFNkSHl6WTYvYURpSS96?=
 =?utf-8?B?b1NDMFhINHJndjBuMk96Tks5VEtENGpPZ3BGU2pTMTEyZituN3FTYndXL0JG?=
 =?utf-8?B?b0owd1dvU0RWK1hhVklsM0FqaU54VFJHS1RlcFdodXRrcWh0OStLdngwazZl?=
 =?utf-8?B?SUFXdzFhN1RtL1RqdFJOTU5pZzBkQkIxSE0wVjNVWWM5Y3c5bXkvcmpUOGlU?=
 =?utf-8?B?WXNvRkJPa1JPKytsUm1wVDR1UFZWUXhTdGVZNUZHY01OMEg0WjVyN3poUUNy?=
 =?utf-8?B?c09HUU80aVNDdEZZeFl5bjJPQmIvblZvRE9Qa1EwRkZOaTcvQUhkcG11VUwy?=
 =?utf-8?B?c1Q3LzNPeDVueUZrUkpGZTZlanFPcTZGSlVqdzlEZWMyd2pQRUppcnZNQWlt?=
 =?utf-8?B?MU94bG1JeHh6MVpxZmJhMWdSYzh4NTlqY2dlWmVsdGV5V2FnN2xseFBvanVR?=
 =?utf-8?B?VkN5TlVpZHFDZjBLemZwT2g5NEsxby94WUF3dEtzQXpZVGd0SzluakRwbWlk?=
 =?utf-8?B?VUtlYitpWlcvT3c5UyttRHNXcmkvT1N0Y2xFOTE0ZWIzMHJST2gxSXZYcm1s?=
 =?utf-8?B?RWQ3cTJWMllGWDlkakpwMlM2N0NhN29lU01FaUpjbVlMbTlEVFkrVUExQXVN?=
 =?utf-8?B?QzVUenJTM3dmRUJWTHZ1bkNES3FCTStsVVN1Q2V2VHJzM3hSNTF6ZG13Y0Zo?=
 =?utf-8?B?OWVIR29HSGV0L2xrVWVrdkZWOUJYM1ZjaUVCTjFmdWU3Y2J3ZUxkdzhWN0cz?=
 =?utf-8?B?MlVYckZ3aFNMZ2ZUbk1tWmVoWmNwbmxBVjR2MU02M0ZxSFZVMjczTi9QMWxu?=
 =?utf-8?B?ZCtpR2R4NHBLVWZZOTl6aTJWTWNqbVU0SjdFKzZWd1AzbVZnMmVxdFdhdGZR?=
 =?utf-8?B?VkVIejM5dHFJcDlQcnd3MTlsYU5VbFBNbkRlS2Z1SkZKT2grVzhZbGRweDRr?=
 =?utf-8?B?VUF1blF1eXpCUVFWYjEvT1hEdnNmMGhsWDBleEEyY2pVNkFXekFTc3BBWXhj?=
 =?utf-8?B?S1Q3bklwandJRm0wMmRpY3BBa3FHZXc0OW1XSmNsNE5MMWVtaDRNekF1Tzkv?=
 =?utf-8?B?RWxYN08zRW0rRkphZ01HSEVheWcydUtRWWwrajlHZWlZaTNIOU80NkhWZWtu?=
 =?utf-8?B?eE1iaWpOaXZQSGNKTHprNnhNTlpjZUFLSFNMU081SnRtUjQ2ei83c1pBbFA4?=
 =?utf-8?B?S0QvdXFJbVpIa05qeFR1OU50RkF0cCtzMk9rYkowVVd4L1hCYWtKa0pUM05t?=
 =?utf-8?B?OTZMV3VTQnZiajlDSG8raXk5REw0TWh2VlVyb0lIM01NY0hCUE9wd3pxUVpL?=
 =?utf-8?B?NHZXL2Q3QjQwSlB4WXIyNTIvaXVLTHM1V2FVWkxTNXBxWTFGRlFtR1dqcFhw?=
 =?utf-8?B?UjQyQlc5cjBObjlQNnZLeGdYZy82aEFtblJ4MktXN2Z1L1NNNlZYc0t4MmM2?=
 =?utf-8?B?dFFWNnJMOGU1UG1uTVpWa2huYm16QXpBR0txQzlRZTVkckQ4NU5naDlNcFdV?=
 =?utf-8?B?NTRid1cwVWJvbEw2R1FNc2dRNlVuR2xTZldYeDFvZGl4WkZCZ0RHOHFFeW5P?=
 =?utf-8?B?MGhpWitIdUNRNkpTL1M2Y1NpLzNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PdnFt1aD9353mPUZYuKN27DAXQCRQa6DnSAU67FJUuhYFjVE/j2eZyqkymj1JgHDvccNYB1cKmLaQ2LjB5q4yAW38KhsNewsSb02UMYuxBZNPC3yU8X0/ppbf2GdwOJPS8D0dMvR0xJNcF24Asv9Mb5qtST1vnhJgeVSTd4ZkNh/05g1G06qLxnZwGjcYQKCJ8lkdS8Jh04Aid0g33MDY05SAouimBVn6XCCOgVA1DXoW1W5fseFk5rejipKwe71PTI1BFnTYaKGT9ERMVa4gzOHf+GR6frayB9oJ1Bm4cYS7VedHqf7/itFpcsWLgfTv6mPj6dGAX8IDVQ9ZSbslQu0ad7qpYP1djMpRSQ8O7AJ8SDT7fpLs71Qn96PTmOk9mdoFlPAD4hbTguVGj3BCw74jeGYedQ923Xkn/+uqfUBFeik8mVEl8A6GyKbOH9B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 22:21:04.8739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83973ab4-4b8e-4c4d-b1db-08de6b4e2d96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-216309-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F17D3139C42
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 14:47:19 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.19:
    9 builds:	9 pass, 0 fail
    28 boots:	28 pass, 0 fail
    133 tests:	133 pass, 0 fail

Linux version:	6.19.1-rc1-gfdd37e7f30ac
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

