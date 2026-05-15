Return-Path: <stable+bounces-247778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA6wEoIlB2oEsQIAu9opvQ
	(envelope-from <stable+bounces-247778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:54:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB9F550D0B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E20300615C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8784044104A;
	Fri, 15 May 2026 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OY+P4zWJ"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C52D3A69;
	Fri, 15 May 2026 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852900; cv=fail; b=H5YAlGltUTHMZG8Ecy9dFOZQv9+zmGEBZg4gdaaRlsVMxgvSRDcMgpvVyNbua5P5RsFQmSUiQvto9uDFvycJA76gZluhnfM/hi7kbiWkZVg2eQA2zrmyLRPm+PnRb94PVJ7eRfgcHeJnQJ6h2gZWfGceQg3RI36b7K552FR7RSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852900; c=relaxed/simple;
	bh=YcQPRBsnodOw/kdGMQemYW1d3XKLylVUoCruKqvuhN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOZgmQLoNr4YnUjjUtiH4e6V5IVHecq+meCwDDfX5Z7nOGYSgUE4eoP1Fntxy/MRPH25JBw/7f0OgPM8wCZdSnjvCxtHJJ1GR7Y3jBH88qYWh6umTQS/6H33WYlQ+eU8nJk/oBpFjBjgGN2XgmPG8Eaunx73ARK/BYHriI48rq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OY+P4zWJ; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zuanh5bwopTcN0eB6eh5AKje0jOlR9CcwkS0/inUOnqjbjsJKpxTkqQEgPIUgyqnyKPASWSePNJd4IIuqh03dFDRBC+XM5BAwD6ytomzzEnhsx9aDAlK4LjK7IZUf3SZ0gUiHNmjTtZ+rfO+L4fEjCI0lfuMwvoWZyLoA1wUZzcR6M5uu4zVypmK9o/ImKgz5J87wsqsBoL6MHRLX9mJXvzJUYrdXiCAUJqHwZyCnPdHGLuRaTKMsd3NH2v2z/x7mY2YaaRx8ceaU2Hk5cBJwmtam6G1qqP8DK44kyfTJdg1LhVC9LasWnAR1bGId4ACTZup2jwOV9RHIz3UE5REEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boouljTFgfnq1oLM8iKohy2+cB/PolWDy0lkbdhAh7A=;
 b=ZwGibVM0eyb3l4IaAlwwIzuG5CLorsTmAV0KSP/99Oqp4JpFCQUo3Dx/ldvWSxDdCiuMglwy529DMayCo1bms0I2gRgQkgRiIwIVb55YO12owqf3jmL4E1+8KqzaYBsrXru3fYBCrcreef50myJ3nus/+bbW5Ok58ESLVQd4VjTop56GVXgXJtq9p6fGKh3HULIVgshlfvbGiC1RNY6n6NE+PR3mE4kixULdi9q5+HWQo4l8JGORy20nceOXsL5Us9Ug9UI91NudWkgkDyWNw5EFznqaPWU9x1ImTA5YYAMXvEsbbkuXPolvWCTEJMYBJOPi6wSd/6tuRiCxatqOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boouljTFgfnq1oLM8iKohy2+cB/PolWDy0lkbdhAh7A=;
 b=OY+P4zWJtf8iwNx7YUaiaZQMQpDyCQoSy8Qc5NMeN5aCktnFxeNgddXUqH3bP/vzdMX9KQOjJnoniLFN+WJwcNMP3FZ7BLoB0wGHks2tuyuT1cb644XEX47/UgGbSBA4eiEhdXr7cXqB/BzkO3aaTR7a7Hg8wj+S6vy1hjweLKM=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 SJ5PPFD9B14F409.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 13:48:12 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::ac) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.9 via Frontend Transport; Fri, 15
 May 2026 13:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 13:48:09 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 08:48:09 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 08:48:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 15 May 2026 08:48:09 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64FDm9Bk350374;
	Fri, 15 May 2026 08:48:09 -0500
From: Nishanth Menon <nm@ti.com>
To: <ssantosh@kernel.org>, <gehariprasath@ti.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Nishanth Menon <nm@ti.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
Subject: Re: [PATCH v2] soc: ti: k3-ringacc: Fix access mode for k3_ringacc_ring_pop_tail_io/proxy
Date: Fri, 15 May 2026 08:48:05 -0500
Message-ID: <177885279926.149261.9133136693378554303.b4-ty@b4>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260501124129.362192-1-s-vadapalli@ti.com>
References: <20260501124129.362192-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SJ5PPFD9B14F409:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5b0fec-dd88-4fd8-b59b-08deb28899db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M4vIKN77Cja64SMVT1JsSUs5pCZuOpt9twhBIRaznPh9oKB42EAkoNVitkV7mAaQIi74AsJDHcenH11eEZyQf6ixTanSqVzg/5yO7w4iPFzXn9k9PdPOoa/WstpZS/UAcVBvzcGzGt3hh4Bsrfd0QLhjPkqZSYnFxjrOoY5JgJHuXra5H3ySKSz42tJ+ucBH6FWM0HW0N5dPEeJyQ+HWSH/8J+79YAwoYWRHILMEQBtOVDNHJpJvJTh337ahOES0qMhA2UCXLEaU0Dz4LeSddng2ALkD4wTGodXchIIdcFDd7kwV6ekGpGm2RBCSW1+QcO7sMhed2da04tvWpt+TK6zodjnMTX8iiWy+4xflwwY/+JmUjR10AYweH7rHgEWEWHEzOEv7lgE5cBmUapOiT53CDoUxuXPh131K2vmwNyFFJ6av+4iy6Oai7x/WBSXKiQHfTjO/1qGaubK0Ko7fyepC6ZvFoSAa6+zKmmbPCFsrzuhl1q3/QWuK/SZ4lmocUgu2Ro9ioApcua+6lVkngwvXHerNuA0QQoER2Hn4rDj3YWVBTuMDyI0vUyamWmRbeo51PMc20d0z7HydyVfFErIskdPK3QQCU5zNGoeJlPEJeh7CDpgI2fetppyPOq0PwmZSc7d95PV8txzrrQVpmh94UXI8ZA32vcXUD4aNwSgHV0Beu/f9YxCy3l+9nu/3nkkyOem+sfSzaPag/ljcERKphZb4g94YnHvBmBxXuro=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ztTNNVX7ZXASGu7MFboztD1YxgchIphMhX4xsdbDxdxI9p6Bu3AuRQJSpxQiQIXGSBuFTJ0lVX3nUsA4CXP0NGxShayIiHRlMxAqCFibTG8tX6qPV1sC79SgDQfooI8DJZShGEoU+cPH9IMLnHR73kUapTSw+ZW3/xGxWoaNXpbfoFMu5jXejqQk0gKpa0r6oBDp56BhMwcYodPDzBMQZtWepcIbQsddML3shTvPUt36qlX4Uo0URss30qwdE6V7vM4Jf4W2uXojZqdy1YkvSOGDilN7TTZGXmGnT4+EKcxD5vk9+yMmdN4BckpPgiSyba04oJ7jmolGA29xo+zqhECZGmWwdY8zsOC25pSPH7FgLFJSq1Cab/NQVsLTR2+Mltpk+hKFpNQdk2TTp+ZuFi2hN4CJtgq9AevU+Y0pg0oOdQt98otCbpl8GThb/tW6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 13:48:09.8998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5b0fec-dd88-4fd8-b59b-08deb28899db
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD9B14F409
X-Rspamd-Queue-Id: DCB9F550D0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247778-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nm@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Hi Siddharth Vadapalli,

On Fri, 01 May 2026 18:10:54 +0530, Siddharth Vadapalli wrote:
> k3_ringacc_ring_pop_tail_io() and k3_ringacc_ring_pop_tail_proxy()
> incorrectly use K3_RINGACC_ACCESS_MODE_POP_HEAD instead of
> K3_RINGACC_ACCESS_MODE_POP_TAIL. This will result in ring elements being
> popped in the reverse order of that which the caller expects. Fix this.

I have applied the following to branch ti-drivers-soc-next on [1].

I am queuing this up for the next window as things seem functional at
this point as well and was a bug that was present for a long time, so
I dont see this introduced in the current window.

Thank you!

[1/1] soc: ti: k3-ringacc: Fix access mode for k3_ringacc_ring_pop_tail_io/proxy
      commit: b920352cfd2b0fcd1249ff006618c939b64fc8f7

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


