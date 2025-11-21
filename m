Return-Path: <stable+bounces-196247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9EC79C3C
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5EDE22E9DB
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D96F34DCE7;
	Fri, 21 Nov 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pcZxzE0J"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1970834B402;
	Fri, 21 Nov 2025 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732975; cv=fail; b=b8TJekZSK8q1spB/GZLE3g8E79xetDD6jclTsMz1oa+stILxGBLLsSgLWrZO1aIhM4zkqyrYf1NTA1ncZ3VjJxWMM6fXdplOj+xOWJVMA4cjd0oSb6OPcmVNJderTiySoUlY720DSkv8J0Lzef/W5VhHCg3GF5YWaKrclyuwnPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732975; c=relaxed/simple;
	bh=j+1O5JJP9Xo29h96xyW+sYPBUSoh9tiV0/8hGoppsmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2/MfnsFOL8hiP1ZSJC6htExzXk+l9gArx1E5Eq+VBEkrI8ntsEE7EVO8k/eRjt3IvqGAURfnn08cJVQlAMkYd17q/V02aUZ8KeqptIZS5zXujqghFAlihZTwBeZ1BXhvfMLoiRpVTEDgQ54C5b6YyevvH1j7hQ06xq1CbfWOyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pcZxzE0J; arc=fail smtp.client-ip=52.101.46.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4mT5MxHv2jqUiBV8dLnTXJywphkOn3npi09Keo+bQYS4r1V+dRpalouIvt5COXHEdrPJE/DRJfFzxaaZLkkRez0X6tuUSs9J8nEoLCqz2m8MgBQRMLuytFbpMFpQbJWpcwAZTjo4PPjPQSWbmQlaF9loB/rDqht34lNrJI/WBlpl0Q6BQu8AdRRGgqG8WP5ILFkTlqbAEIVgs6N7izq9/fcS4SvzR8r1OQMXO49hAUhLuh/Ml4f0Wqf8eiaqGmvn9atEpdhTtbaDwx+FfcPTj9sDgAVDxNX4/BiSTCspZMfQmZU1L31cJ7jh6hpr65KSjHSQanJ2vJxm81A/y2M2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mJ+Jg1f8cRgt+oDez5dZ80zpBBg2DNnsDtmRxQ/NN0=;
 b=kYUgOTyNPK6Kcvjj8u1TfRwx4URr29r+6ako/KGwegu9VMc3vM7s/pdg656JipkMFzNf3kk0uCQ19SAb3TwTnM1Y8e3ByW3T8FnEpPXTGs5rxgVVniX5ZiakBO9XMeY+Sr0R6uMPsOGoyKsZZnkdh/2YPEGwyM44bUWA4aVleJEvJ+yq5HjCNv2VjSgEQposuvMj38ABM0iXJagy3BqrQP4+rvqCybUdzgDCF98pk3VN1qUYE26SJ6lETeuE9Vlq662TqgqZxw/qwt3/x5/XahcWA0kKRfTeASefvD9+iMlITX/LncaPdGsH09qo+Epj1HDEQBovcJRrBQldXfyN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mJ+Jg1f8cRgt+oDez5dZ80zpBBg2DNnsDtmRxQ/NN0=;
 b=pcZxzE0JGwC6NV05YwEAGPsJcZglVT5DAT2SoaQ/H04rGQ3LWwM/F1YXDy3GEz31qupYKdhp2fNrEIN9LD4sIkrCItkw+HY09Ftu6jOKRMGybJIVAdXIyN+LzeKvyBHHrxKCc56I+wHJOe5o25Aq5y/W3IhsVUaYtb8eqSBv8C8=
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by SJ0PR10MB5552.namprd10.prod.outlook.com (2603:10b6:a03:3da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 13:49:28 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::a2) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Fri,
 21 Nov 2025 13:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 13:49:27 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 07:49:24 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 07:49:23 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 21 Nov 2025 07:49:23 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ALDnJrK1313880;
	Fri, 21 Nov 2025 07:49:20 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <y-abhilashchandra@ti.com>, <u-kumar1@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <stable@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e-sk: Fix pinmux for pin Y1 used by power regulator
Date: Fri, 21 Nov 2025 19:19:17 +0530
Message-ID: <176373265680.739386.4552474353060268697.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251119160148.2752616-1-s-vadapalli@ti.com>
References: <20251119160148.2752616-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SJ0PR10MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: 94072576-017b-4539-f58f-08de2904c9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzZ3S1hRYjByelZhWnJ6UWMvekJaTUd5dWxYeEZiUjZsSk9RVWNUOFFQU1lw?=
 =?utf-8?B?Z3BZRElWSnBUL0NqMS85M0JwQmRrbEp4Q0M5Z05WZ05ocm94MnJOL3dPSW5F?=
 =?utf-8?B?a1kzU2pVT2VxSEx1K1RrQStNbGtMWlVXTUJsU0VGdzZ4NTJjd2pUVEM5NXdR?=
 =?utf-8?B?SzUxMUlMMnQ4ZDVPQnoyWnlLSTlhZSs4SllIYzBaSUpHOGI1NTBQbndOOFZU?=
 =?utf-8?B?NmV2RDZDbzRRV09pRjdDRE5UZGZEdzg3RkFraE1ZaDRsS3F5VkEraGRERGVj?=
 =?utf-8?B?Ull0S2g5NCtkditYc1I2dlZxUmEzUkF3SkhuQmYzTTlPN0VLTVBNYk56dDNB?=
 =?utf-8?B?dlZPQ0RFUytiTnQ4R0lDVlhPYUpQNzFiUHN5RWRBalBBalRDdkhndE1sU1Vw?=
 =?utf-8?B?L1J3by9ZRWZsM1VZZjBiQWsvTEE3U1JrVDRMcUhLbkZ0ZGFIcGJZanV3cDJB?=
 =?utf-8?B?eVVxTERYbWZPU3RzbWtuZ1NQMVlNSXR2VWYwdEFyK3MwcUlKTk1YOHdXejZ4?=
 =?utf-8?B?U3RTdzZ6d3FqNTNEeEVMN3QwQytjRVNOLzRDY2tiUzFmYkFZNFJFRHd1b0ho?=
 =?utf-8?B?RGFQZlU4ZXJZK1plTWZkdHQxOGtxK2VYbEFhSEoxcFNEaHhrcmR6clBDcEVR?=
 =?utf-8?B?QU5Qd3RaNzg1YnhUL0k5dGNtZzJLaEZCK0ZEUlk5bW04UEk1WUZvY0VidWsr?=
 =?utf-8?B?Y2x2SFN5U1ZhbHpESnFURE1kR1MxMWZSY0dVcm1GRTlPUnVmenpEbGVEbmpQ?=
 =?utf-8?B?eG1tNGhMQ0VUTGNqdnhreThDWVQwRXVjVEJGcWRjR21rbFRpYUE2ZUdNQ0Q0?=
 =?utf-8?B?alF0d3ZhSDAwSUlUcVc5bE9WeGwwaFVoTWlIcnZLUVhJc1FDWXoxblpqRHBz?=
 =?utf-8?B?TExUNXIya2JwVG55Rzd4VUJPN3B1RWZNODBiUVZKaE9FTllza0phdFJLdVlD?=
 =?utf-8?B?T0NTS2hQazZUNnc4d0JrVUVyWXRkTVFKWHRnR2xId01vUmdUNTlaQWdYRTVy?=
 =?utf-8?B?WjdYUm5VYWRvb21rL2JZUGtsQ1RzbWVGbXpNOVlNRXJiVTVRamsrejE2OUFC?=
 =?utf-8?B?S0dweWFOcE5MdCsvekEzVEVpeE9rdXJJdVJiNFNTdktHa1FYcENNWUZhVVBV?=
 =?utf-8?B?U1dhTjh0VEhLaUJTVytRYzFOSmo4TXZIQWdjRFd5TGdpanVzT1RSL1MrcUlT?=
 =?utf-8?B?SHRacUFyemd1bnlTckU3dm1ESXp5MHJacGpSUzN3dFovYlp4dVAxOVRxdlMz?=
 =?utf-8?B?YTZwNTNremxNdVpqMU9jZzhHTVZaQWt5UmtESjVZbzJZVUFLSzNpMklLc25y?=
 =?utf-8?B?enNWTC92VjZ3Ky9RSjRkMWR5dUZ0S3REMW9uaGtWaTJpUkxBS3RCei9vbkhJ?=
 =?utf-8?B?TVBmTkFkYW9NR0ZqdEFMZGU3eXNIbUpuSnJ6czBFbWp0U3RrTFV3TzA0UDFY?=
 =?utf-8?B?YlNNVVJFOU4wQVk2Z3JMUzdzY2RscFoxNVp5SG5HQldSWURhZ0NNb29SUGgr?=
 =?utf-8?B?ek5sa2Y1VENOUVVkWEdCdElKWHZQYWMwM0dDcHNEOGhhYzRNYWY3U0oxN1pN?=
 =?utf-8?B?YU90cWhQTlhqVVBwMUlCMjY4eXoySkFFelBRV3BQK3pMOFNyblFEQlROS0ly?=
 =?utf-8?B?TnBFQVJNVHFTLzVBRVl5VVpCK0dIMWRKVms2cnNFVExvTkFheDhWaFErOU1q?=
 =?utf-8?B?MXBMYk9FWUZ1T3VFQ2ZVSHJrUGU4dHVUU0IwMjFmc05mZGdzUTJiZVNGODNB?=
 =?utf-8?B?V1dUVDBoTmNkZ0xzek5CeEZhSWIvN1hueWFzWkFGdS9PMnBIOW9WbUoreDg4?=
 =?utf-8?B?QXFIL2pTd1BaRzh3bDkyRTdiR3FIcFJtdC9oOXNPT2E3S2p1bGJaK3pFWGJF?=
 =?utf-8?B?VitFSE55c0xDZ0FEN0xIQm83VWsvQkQrYWpqSUxPbHJBck56eGUzMjN3SDUv?=
 =?utf-8?B?N21NTklPWDk4YnNFakc3ZVlMaGxUbENJRjFPSTUzaGlIM1NDWGoyRHl1aS9s?=
 =?utf-8?B?SkQ5ck9hbms4RDlXTkw3ZERyd0VpY0JkVVhQSHVPY2ZveDJvS1lTQ01hU1E5?=
 =?utf-8?B?Z0t5OHdJK2JpUE4wTmdZUytCd1FXLzNraW1hb0l5M3IzMmdpR2V6VTR4dHJx?=
 =?utf-8?Q?pmV4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:49:27.2958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94072576-017b-4539-f58f-08de2904c9bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5552

Hi Siddharth Vadapalli,

On Wed, 19 Nov 2025 21:31:05 +0530, Siddharth Vadapalli wrote:
> The SoC pin Y1 is incorrectly defined in the WKUP Pinmux device-tree node
> (pinctrl@4301c000) leading to the following silent failure:
> 
>     pinctrl-single 4301c000.pinctrl: mux offset out of range: 0x1dc (0x178)
> 
> According to the datasheet for the J721E SoC [0], the pin Y1 belongs to the
> MAIN Pinmux device-tree node (pinctrl@11c000). This is confirmed by the
> address of the pinmux register for it on page 142 of the datasheet which is
> 0x00011C1DC.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e-sk: Fix pinmux for pin Y1 used by power regulator
      commit: 51f89c488f2ecc020f82bfedd77482584ce8027a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


