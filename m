Return-Path: <stable+bounces-208372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C345BD20717
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 18:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3215E300EE5C
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19832E9EAC;
	Wed, 14 Jan 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="urBUUaKj"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A292DEA87;
	Wed, 14 Jan 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410629; cv=fail; b=IQyv1waqt2lIgr3kTShnXEnomHLlH0VJdSeTdqR3RnQhXpbQW9bs9fCr2TlyKsYHj17ChqoK1Aq0/5WmUWn2nHgcRLolW8cmQq3/lajv9l/3gbC8fdRGj5WlTuVyGBHVr4+jebeXlsQkHpz+5+uID2mgVfoi5nS+y95jn1mvkhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410629; c=relaxed/simple;
	bh=RyBlxoubLUpDfCpbTdma+z5RNavGmY1FORPR0ACJxuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPJtAYM9MbL2tCxdIk/nCSt/oj+4I6JBZwDKVWVoWfMqmguZ2uCxZgMVWZsVZRU6AogiWjRreQUzBYwXhN9MB3oeGJgQ5Ul5yg11f4okFWZoDX/yjgDJiQriznXvlEDjTL/JUcghHGVxNJBaTt/jjeyotFtocyAH6IwlbwlrDv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=urBUUaKj; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrpJswL0pVQmjCNUmbQLQFFpViLtAVQF4qjk4vCC9FqBaaoRMePCodDGWqIjQwb49t9E/6ff45bg4JgP1XY+qxyozzSWWCRMy2zw8/9il7LWXmIYWTZWN8pFysXg7EW3egbr7nBxdKDLyOdBc+SLJEaQbodd/decLALEVQ6ZzyGbwrICl3FKuHvgY1Pz8m6lrJKEPKYL1o4d9hWwsV4zMlcjQCGCG2sfm7BKEsReDw9ds61lKRhTWqRbjo2tsgeqs865m6+wm2BAOr+nYjGZCQT0c8dBUoDjGXKzeCyEcY09tpmTpbU9eTfdZrQzhmUuxwsYFmOFV51Ak1I+h5Uc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMQHnCKhackAPqdSZKgIRWVGyrEcyHwPf8wBaTv4lBA=;
 b=I9wVU6LVZrsAwZmQZssYjgA7bn7u+iYcZi3tfm4xkyLn5C0s1Yz5UtG7Zkjp85Pd37IympVjspDyQ5L+nqQjNpL6PNyRQ3Jsudy8ZKmzqJMqsOUEhBLc7hBd/dQEakrvJErfcjW8kArBYbMRUO1TaIkgLWAKVZ9H6+Rom+gx97WHHJnOYW3oqGzqYzDnXalIjfvDo+B/CqVhslLpwJWNRsebQQ42gP7gWKFPP7MEX+UG5n1LwgKZ0H2hvtF0g0KFdpo7dpnRkJSi+2cPrQ4qckDA51TtOEn7X/ionEGprYYZ79srvQ3j9SGFYfukb4Oj7P6OcmXSjJE7vjfJSy6Swg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMQHnCKhackAPqdSZKgIRWVGyrEcyHwPf8wBaTv4lBA=;
 b=urBUUaKjUWcMrRp/804RGBiTZFZhbDAeD+mhATYPqlFQjiBZTqJtxqKaebJBHqXwCFzDBdhmUICKLN7Osmcemyv+i8jm+Qff2R5UKful1ww7ZNa3wFuK03qNA1CvMy7YpXEE9xkG7Rl7oHvXL9Xat1jtrp+xZhFk77Eoh0Oxldg=
Received: from SA1P222CA0196.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::23)
 by SN7PR10MB6545.namprd10.prod.outlook.com (2603:10b6:806:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:10:25 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::1d) by SA1P222CA0196.outlook.office365.com
 (2603:10b6:806:3c4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 17:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 17:10:23 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 11:10:23 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 11:10:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 14 Jan 2026 11:10:22 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60EHAMUU011086;
	Wed, 14 Jan 2026 11:10:22 -0600
From: Nishanth Menon <nm@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>, Johan Hovold <johan@kernel.org>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] soc: ti: k3-socinfo: fix regmap leak on probe failure
Date: Wed, 14 Jan 2026 11:10:20 -0600
Message-ID: <176841061071.1986120.3022761945213867100.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251127134942.2121-1-johan@kernel.org>
References: <20251127134942.2121-1-johan@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SN7PR10MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 525a7842-5656-47d0-940e-08de538fce01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|34020700016|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3FoWndFc1FhbnVLaDErS2h6UklTd1FxY202YmdKUzh6QnQ5WnRSKzVIZmsx?=
 =?utf-8?B?VSt4K0FnMVE3Y2ZCcWpQQTJ3UDAxS0dMQXdQdnlXRXBzRXcveTY2emt5OVFR?=
 =?utf-8?B?MU15dTR0REU0MmthTDJ2V3ptbjVudHhLUWNzVFRmV0pKREpoU3Q2dmNTWlk1?=
 =?utf-8?B?dlVLaENIR2FMMC9iYmlLVUZ5UFZNMEJ6bGcxRk9vWGhJeEJ6eGR1Zzk1WWR4?=
 =?utf-8?B?d3hHcS8xMWRmcjU2MGdvSnl6QXZqWjhIVWVaWkI3UFpvYlUydmIvbWh0dzhE?=
 =?utf-8?B?eHpnNnRYOW56VjRQaW1xbDVPc3FjQ3RwZW4yWmFaa1pna0xGdDdQdjRuZFhP?=
 =?utf-8?B?YkV2MDQ5NytzOXF4N21WZmZJUXhuQXRsMzgxa1Q1bW5TY2NGWE9VRkdheHBo?=
 =?utf-8?B?TC95dVdQdlNTQXY1MUZuU0tCbjdRV3RDNVY3MTJnVnNBUE1Fa0dPYytRK0Rq?=
 =?utf-8?B?TXRPWHUyRWZlRjE4azhJMHdISGxqOEdRS0xRbG1DYnBISEhUdk94VFEydWV5?=
 =?utf-8?B?c0hRZ1BxZnBKeWQ3NmxYZFNmc3JyQWpvdHZYdjRlL3pqc1c5WE16OXFicUFF?=
 =?utf-8?B?bHFGU005ajdSdW9KVVROMFgxcEROZnNzdm5NN2NFMDR0aWFSRFBpVldnTCtG?=
 =?utf-8?B?aStLZVhlVTdsYXo4Skl1Wk9sOFQyc3ZtNS84SUo0dHRPSmJseXhVbjBwRWpu?=
 =?utf-8?B?NWt5YWlMbjA0NVZRdlVBY2FrSTFsNk9GMmpYbllFQkc0OFR5UmhjaWxmamVP?=
 =?utf-8?B?ZEgvWC9YWm10YXBNOWpkTUIvc1Rycnl6VUh0WmNOTWluZVlPQnRPYVZGN21G?=
 =?utf-8?B?b3lOdTBzbTJNOGlHTEN2K1FxL1JXQ21KZFFKc1hvcVZ1VitmbEZzbjNDTjJ6?=
 =?utf-8?B?VzBMVDVLOTQvNE9MNHM1QzZNTWNQOUpaZXBJRjZ1UVdzTjBpb2pvaE01SEV1?=
 =?utf-8?B?cjJ2SzJIeHdDOVRYTm1Jby9GeGNFM1dlSWFJd1A0dmF2Z3gwNzhWUkJGeGdj?=
 =?utf-8?B?UU9ERmxMOVJndzZCbjlMejZxbFc1Tnd1M2NZelNFb3cwMDdiYzhRMW5FZjlk?=
 =?utf-8?B?cHdxVHFMZnBIUkFwbmFJaFAxQmFwdXZWbm9Tc2pYdVlETEZiNVVPMUw0OUZI?=
 =?utf-8?B?VG1OaUllYUhHRDlabGo5WHhGd1BncjFjUm13KytCelBBR2g5S3lvRVNZZDBh?=
 =?utf-8?B?ZDJkK0RCQmZ3cVBWaXA0WDZGTTJkMjFUZzFidytZVFlGemtreVdmeU40dGdo?=
 =?utf-8?B?UzlmTDcyVmgraXZWV0hVUThUZFdJTDFBVytWUU1xNkdNMWhPUi9HZWhUcUVn?=
 =?utf-8?B?QnM3YVM3WUs5Y0doVExuMmdwdVhMaHhxUEprNnRNcndYcDZhSmlSR3c5SDhu?=
 =?utf-8?B?eUJ6WmY1SFMwK05aK2JHZVJzK3VLZnNRd0R2VHVGcFNNdEdoaDBaZ2ZsV2xP?=
 =?utf-8?B?QzdTeXd6RzNUcEE5L1B6R1FHa3FDSkRjS3F2QU9uamI5TTU0L3YrSXdQU1l3?=
 =?utf-8?B?M0ZqcFB5blJHYUhDNFBPbkh4cytvSS9uWXNjcWI3VCsyU05MaHFTZTdGNS9Z?=
 =?utf-8?B?L0F4TDBPZEtYbHJuckFMQ3gvalgxUlA0aFlwaW1lVGQ5YTJyRThCaTNlYTN3?=
 =?utf-8?B?R2dXT0pVd1NYOEZCMzkrWFExcFpnaEY2S2ZOR0E1VFA5YWU2WGtUK0xQU1lU?=
 =?utf-8?B?dmJiN0VvS2JXU3lHWURyZmZMRDlTdmhRMkFCMmRuM09RV2hReUNKZjdpNXBL?=
 =?utf-8?B?Y2RyNUEvdWx5MzE0WS9YMUpaNGUyNzR4ZW1WbUI3eVoxZ1ZDK0d6aklydXRF?=
 =?utf-8?B?U1IrOE5JcHVzaGRXWkdyeERsZlpUdysvTnBwM29Dc3kyS1F3YXFvWnl0ZFBG?=
 =?utf-8?B?ODRLWTlQaFV0cWtGMDloZWlIRzBOTWt2MXJ0N1RaaGdTMkp1K1FveDQrVjRq?=
 =?utf-8?B?eDZPbU4ydjVuSkZYbDlKL3VjYlRIV2FQS0NLU3VhNGNxaTV5NHUzbWpWRUo2?=
 =?utf-8?B?NytrVW1IOGo4S0g3UHEzZFdPWmZrT1dYVHUzcEozQ2JEMGw1ZmJjY0Fpei9r?=
 =?utf-8?B?MFIxakI1TnpSWjlLd005M1ROMkxGaGtsZ3VuZkdaUUk3K1dhUEt1SCtjQkR2?=
 =?utf-8?B?NzZmaHZ6MXZTK1FZbHZLb1JBSzloZG1CUlo0d0NQVGw3bVVNYmJUMHFUNGtu?=
 =?utf-8?B?SVB2cFJiZzNnbE00eUJRS1ljTTFLZ0tQNnBnOEp2MWZ6Yy9STkVTOEZQemtQ?=
 =?utf-8?Q?5QZSrCXLeK80lKvJYRTR1ZNXM6rrM58MRO1Ggst5/4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(34020700016)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:10:23.4004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525a7842-5656-47d0-940e-08de538fce01
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6545

Hi Johan Hovold,

On Thu, 27 Nov 2025 14:49:42 +0100, Johan Hovold wrote:
> The mmio regmap allocated during probe is never freed.
> 
> Switch to using the device managed allocator so that the regmap is
> released on probe failures (e.g. probe deferral) and on driver unbind.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Apologies on missing this in my filter and thanks for following up.
Thank you!

[1/1] soc: ti: k3-socinfo: fix regmap leak on probe failure
      commit: c933138d45176780fabbbe7da263e04d5b3e525d

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


