Return-Path: <stable+bounces-201448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDFACC2430
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE6873020CD0
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC233B966;
	Tue, 16 Dec 2025 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eSfAUodZ"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE126A08F;
	Tue, 16 Dec 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884672; cv=fail; b=YVf336iHxJ8/klRkvW489vraajRb+/1lKMGv5YhdICtLTs/4DVQAcYUFCyCE8mweOV/UWxHi5/49z2nmIfpfvvImRsH4N97m4hPLRwdn2jqZlDcTTsjyFd50JCbNS0JbgaGlBq+CVPcgvNgeGeUyWFc9Jwzy+IKH6x2s5pdGNQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884672; c=relaxed/simple;
	bh=91/5pgUYetPfFZ9++QUSX6AwS4rafmnzJqn83RBOnCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwVP35EIEE32j6r3grMMqrP5ATXOmwPijufEvcPM/QPe86DNsI3wmIuuiLdgxfz/J5VHp/OyzolQ+AzKCRTPla8LDKEAyI2SCJoITnxB/LkTQNrfvR2hIXWLKS/RBiQAafi0UOgt6rf1eOAjvvLzPD+sdTsJDNfHkFkroSagZIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eSfAUodZ; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eawQ7LctHnGTAhaDntQLf2B2CpamtMrGCZ9RwU7vNPCRxdF3mELonODhwXA3b9bDLFghUECjw5obSc7ruSsnVbfn1el94y/uMSy8VbwZTz/8pwsQEugfBAMGMmrzRx32qWxE4E2HDMCheMygjuao+D1Lw9J3weC5EorJndd93ZBUHjB1xr118fShhr1j1C8vng1PEnfn/LC78cjAlXUdiLuQwaT/onppMKDueOKI9kJV5qboENyCIObf4Wv5uXFfc4J8QiXkpEdw6q09Pb7LuR5cZTZ7UV156+kCWF9tVqwcvs983fhfaXeWtnLTSo67sg+4BtmKaOGQen+/MaRxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZkHI4e86e2FS+JBrM/mvkDq4YcgQisf6x9G9hVzCvM=;
 b=FJnCTCTiw2SjSROp0eIdd14BAyZ8H+IMDLk5VPZNN5ZZGKhki+tVQYQAdM6H4qiJl4IPxH/8PMxaI6EbgpVw2dc0LkPmq3ifILAD6JCK6MYGKLKfr9eQsrRZCtSPi7rncQfe/AmD1UNcSVTquSh0NBqy4s3njF2HeP2gSGS6pDq3TaFSlwxJr/DXYwvCyUKgYegh3Q5/j2h0t1G+ufHL+niXI6xbA00VfSx8sdd+ELQMvQttPh70rSOXm8krZhWKj7RgVZHVRWPfaRFdqnpZIDKCs9ZG117tQafpjrnOQrRuCrmuJq0uUXsdmAMj6cWIFrj5XE+vRsgaOvlJpSR9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZkHI4e86e2FS+JBrM/mvkDq4YcgQisf6x9G9hVzCvM=;
 b=eSfAUodZPr2rStVVmUCoLzAgMrNnFkiepPpQ6gxjRCI4BXMAT/5VbcJcezh0r9qGcuBYLyGNuQcOGbDXOwCQreUERfsEZXqWtNq3plsBntaU0z6JzUEXdjudczpHTJz+UmRLwuMdCTO+UdZRb9j0R09BNCYV8hHhtSDw0+Ujxnw=
Received: from SJ0PR13CA0050.namprd13.prod.outlook.com (2603:10b6:a03:2c2::25)
 by MW5PR10MB5714.namprd10.prod.outlook.com (2603:10b6:303:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Tue, 16 Dec
 2025 11:31:07 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::80) by SJ0PR13CA0050.outlook.office365.com
 (2603:10b6:a03:2c2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 11:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 11:31:06 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 05:31:03 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 05:31:03 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Dec 2025 05:31:03 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BGBV3cc3971499;
	Tue, 16 Dec 2025 05:31:03 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: am62p-verdin: Fix SD regulator startup delay
Date: Tue, 16 Dec 2025 05:31:01 -0600
Message-ID: <176588464864.57937.8124279856116763834.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251209084126.33282-1-francesco@dolcini.it>
References: <20251209084126.33282-1-francesco@dolcini.it>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|MW5PR10MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 73dd0120-d7a2-43c6-dee1-08de3c969a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGVka2tHbENyRjUvVEpranpzTmZXemJ3b0gyR0ZxOXgwZEVock90Tk02UGp4?=
 =?utf-8?B?a1lWN0Zkb1FRaUh3NDRyVGlTSyt2RThOcDh4a0JudzRIL0dZaTgrOFVnOVNt?=
 =?utf-8?B?bVBZd2ErOUtlakdBQlpCQXlMYmx4UVNtdDdjYTZzWUlSK3FkMDZ3S0FzOEla?=
 =?utf-8?B?OTc3dGM0RDg3Mk91ZXRmOHk3b1lQYnpjWjJPNndrZ0JPNjlVcGNVVHBIL3ZJ?=
 =?utf-8?B?akV6bFFiMlFrT3N5UDFkVmg1cTJKaStFNkRYMlBjZVpYZXpxOVFFSkQ3MUMx?=
 =?utf-8?B?UlREc0NpYmJGMEU1Q04xNFk0akdhRHZaazNTbU9HazErTnZZVzFzaGtQTWpL?=
 =?utf-8?B?VGlRWHJ2dUFjWlU4UWFsVjVFK2tpb0Y4UVEyZ3FBWlk2czFiSUIxTjl1eldS?=
 =?utf-8?B?UWgyS29xckhFN2w5amVVVmNya1FDV1hxK0lDQ3JQR0cxVFB6UHVTUjlZdUND?=
 =?utf-8?B?MGVlRkYvKzQ3aHB4MEFVcEEyb0c1VmZnSUFIdWc4d29ObFB1TFZJK255SUVm?=
 =?utf-8?B?QnZ6Y3dla3grQXBMbC9HWWhnbW1uZ2FJQ2JIa2phdnRsTHJNSUlEYkM2eHgy?=
 =?utf-8?B?MVV1eUJqRHphdWdwM2NOc1JwQ1FQSTZaV2R3bFdGR3EvTWd6a1RybDBhZ1o2?=
 =?utf-8?B?Z1BtelExUmVqNVBpVlVvUVVSWVpUdEtvUmRBSFo1T3ZKWnlRMnVwMXNRUWZz?=
 =?utf-8?B?L0UzaGU3Y3BzOHhPZXVDb1VXNWJtYjlkYjBCemJkRG4vM01IRjdrSWNHMlFV?=
 =?utf-8?B?Wkg2Qkh2bVZORXZma0M4VGRpSEpaTnZPeDlCdWlWNmVnVE5MVW1LaWZHQllV?=
 =?utf-8?B?blpuYW9FSzJKTlBSalI2SlF1ZW1KNHo0dFBzMlJobUJpU0UwQlQ5TW03ZkUv?=
 =?utf-8?B?MEpieEhzT2RtZkNqZUt3MFl1NWJPRDJzdlFkcjY1cjd6b1hvVmtHTHZXQlY3?=
 =?utf-8?B?SXFSN01ZUHoydUNpeCszSytDUk0wNVlWZmtmVG10UUQySUFmNUJGMVVRK1F3?=
 =?utf-8?B?bFhtTzZmN3d4WWFFbjhWR3dlOGh5STUvWUE5aDhZdTljYWFJYWxiWjlSL3g3?=
 =?utf-8?B?c1N2TWp2SjFnNmJCeEJ2alkxakQyK3lNS04xMVZoMWo2b2FXRzQ2VlI2Vnh0?=
 =?utf-8?B?dnorNFZLK3BoWE1hdUV3c1hOOEIwR245ekZRNVlQQXFQSTVwbkoveG96Q25s?=
 =?utf-8?B?eWJnc0FnQUpsaEdGc1BDcDkyRUZEdUt6MVVQdGxPc0J0VFhmbmNGTkpHQU5r?=
 =?utf-8?B?UDVoZmgzSHkrVWdOVW5qS09qcVhPT2VzbHBxeENGS2NoWVJQMkpwOE1sdUh1?=
 =?utf-8?B?cHFCN1BIanZMd3ZhV3VBVGRoeERCcXo3ZzFuYTdCQWpJTEVLMmduMW40bTJ2?=
 =?utf-8?B?VCtkRVY2TWJabjBQZDdETjU3WVpIekZmRjFja3E1VjgrMzNBcDhDcXRTVm0y?=
 =?utf-8?B?VFNQNUJpK05KODIxb2c4Rm1KdG9IbTB6R1V2dTBwK1p6Tjdxd2RQTGNlRzVB?=
 =?utf-8?B?SWs0YzB0NmYxNnFrMzVmbWdZUER1Tkc2d3hoWit0dlFyOXV5R0NxSE56ZTk1?=
 =?utf-8?B?NmF2RiszZWEzRFJVMW9FN1QreEVQeWN3TjZoWTN0djQ3SGRMdUxCa0lmMXE4?=
 =?utf-8?B?K1J6OGxWVmhKaW0yb3RyckpEZTF4cGc5Qkw5amxnazRQRVo1S0ZhR2xrRmhs?=
 =?utf-8?B?ZnRPSk9SdW1GcDY4WGhVcStrRzJWQVdiT3BvQmx6TTVNS1Z0cGlCSUR3YWwz?=
 =?utf-8?B?c05KbzdiVGRtY0VsSHNPNHRJL0poNTIyRTdhYmIyLzRQaWhPaXhwYksxTXZT?=
 =?utf-8?B?Qlpidy8zdG02eDkxRHc0UUJjQVQwd1dkOURQOThuQ1B4UWRlT2xGVW5aVE4v?=
 =?utf-8?B?TEhab1FxVVFrdEh2d1cwMXp3ZnlReGpRelpNM3hKM1JqTnNtN1FVbUNBa2Nn?=
 =?utf-8?B?ZFlOb0JTZjIwSXBNZjBuZlR5dXNTN3Z4REVEL2h5TFhZeUZEMDMweURUNml0?=
 =?utf-8?B?MVBpVWhoSzBaclBjSFlYRHVVQk9uWG8vNkpHQ09JbGliSkNlSnQ1d3N2aGhz?=
 =?utf-8?B?REZKV21WNk1mUVV5V0tXOTV6RHdHOXpFeFl0R0JWT01TNjg1OXE2YWp3R3lY?=
 =?utf-8?Q?JXMY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 11:31:06.6957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dd0120-d7a2-43c6-dee1-08de3c969a7c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5714

Hi Francesco Dolcini,

On Tue, 09 Dec 2025 09:41:25 +0100, Francesco Dolcini wrote:
> The power switch used to power the SD card interface might have
> more than 2ms turn-on time, increase the startup delay to 20ms to
> prevent failures.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: am62p-verdin: Fix SD regulator startup delay
      commit: de86dbc0fb00bd3773db4b05d9f5926f0faa2244

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


