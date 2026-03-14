Return-Path: <stable+bounces-225423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBq2JD5ZtWl5zgAAu9opvQ
	(envelope-from <stable+bounces-225423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:49:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D7F28D35E
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C7CD30125D0
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC8E1A2392;
	Sat, 14 Mar 2026 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JeqeaAwa"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271C5C613;
	Sat, 14 Mar 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773492516; cv=fail; b=acJBSlBamBE6rRBbIxUKRXJxF39HB1L9+ZI/vTlPQhOV+PJKNpJsJdfw8Yb+PmSMKUB9R2+W2DzS4yeG7OslgDOMojMXBA0FRWjtMxVC5kc1O3BPobI47ahqBBgrLoXkXJ3FvjD5jSxxEjlCWuyACymwwqK8gufp0Rj6Z837ymY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773492516; c=relaxed/simple;
	bh=6w96V+RGjxNjFlgtuomax1KCTHcsNjcEDVzEYlsw0bU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XH9g7aIFK5GTgZyUipICY0HR+IErtvhvPJoGUWByRy+366lEvwue9tl6FEi2vTVY9hFJPZLZrxFME7v+k4DD1Tu1fCUPuEYdJaLk/jqHEIF0A+RmE9dSqTvQtfqKQHQr4cjPWHxAG+uVBx3fsFzngJX2tv1pwybJzgtfCMgYOH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JeqeaAwa; arc=fail smtp.client-ip=52.101.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr6BLHjIj8eEgwcWE8w8NUcCfiHdJHYCWCfIQkkAM8GFuM2PCyc6Fi71Zl8ogSWWEhbhZzIxj5RsQ/qu6lhJKyGo+DcEQlLu3XJYb8NEYqi+bKUTaVuVuW24B0rfgVhvFVrCgD+PsJCegWyNKs1F6R6WO5QSA/PghvObGxRzBwwgES6pHVS1ozK+pbut2NV4QapwIS3b6sLtDVPqlYIKxOdqnmA5ieRSbwLC1hF/DhBI/0GamQjT+kzZTyRqQ8IR9eaR0B8t1BatUO6JaILV0DB775seeZYdsgZ9I1sPQcDjN4q9A8uTjYc0ouTJm3pREi9lA1IoucD55U84jmzhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPtVSl/knnE/VhzPtb+pdr0mJ4YVtDQskPkxtP7df1g=;
 b=S5bc7evnX27OkW225/TWwF4m3BowqBdO7MuyXFro4J3vWK3FKFfe2oqN0aXNEF6y9i0aBP4ilIbuzLhbjoGKsUDoxL/xOG9nArlSZJxp7pxTazP1HsPhFmcJhCs3acAbWWY0CCoboKYvGiR/q0jqUbCqR5Gt5k/teHIMV9RnAsg6T7rlRPFmSPY1Rq8dmSKU5uK1+W9nEY+URyFh1RanV8eAG6irlaWcv/vLRHKkQ7vre0LBdVtJkrPa+3ZRcbJYDqGRuNBR2QDcUbU9yKykyJfG3hR/xA4+fsuHSr5VZ1UkIdt2zpbqlTqEezGMh2T5uX4ZEAYsxxGQwrGw7peFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPtVSl/knnE/VhzPtb+pdr0mJ4YVtDQskPkxtP7df1g=;
 b=JeqeaAwa7GNEW9sBAN2Eq1WSLiTlS4KfU1nrYeK9QO4rGcnHOpzmV9eYGNwCKDMvN1f3BG6iFGEcYEU17Zbise7QDaim/ziK++Y1MMOQIWI5EAWL0bQzbtWD8U8IHHoN4RaIfnyL12PHFAzReXe75tYY1oMJzyMQzHvbGddzxUM=
Received: from SJ0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:33a::14)
 by DS4PR10MB997770.namprd10.prod.outlook.com (2603:10b6:8:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Sat, 14 Mar
 2026 12:48:33 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::8c) by SJ0PR03CA0009.outlook.office365.com
 (2603:10b6:a03:33a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Sat,
 14 Mar 2026 12:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sat, 14 Mar 2026 12:48:32 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 14 Mar
 2026 07:48:32 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 14 Mar
 2026 07:48:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 14 Mar 2026 07:48:31 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62ECmRY12257177;
	Sat, 14 Mar 2026 07:48:27 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <jm@ti.com>, <afd@ti.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <stable@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Fix pin name in comment from M19 to N22
Date: Sat, 14 Mar 2026 18:18:22 +0530
Message-ID: <177349248630.927221.11137917567321094680.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260309045539.2070793-1-s-vadapalli@ti.com>
References: <20260309045539.2070793-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS4PR10MB997770:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b8a428-237c-4415-3923-08de81c80005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9bTDtlNPO1UkuZr84N3fn4r4noeLzd/LUePdcmxT9X37RRp3kbYcteP7DXCFj1/CYhn3H/DsKxi1oeryDw2rGSlxw+Q0A6diCEMyxqK/Rw3JiNY6CounFeU+J4vQtdPPeTIRsjGALjgMzkXl3+RPKBICFp1tDXib9Hog36zjG7CUJ4VGtUZhJ1/dCYud8OrMNmtk2gqeJ5+yrqi8fuN2w16pOZ8gyKDMacXz2vA0XNMLHF1EgX9PpQoaXvHT05EGFYf7wUAmxbkSGm7O7cl2d47S6PFqE3kxn2fIv1YqvLsbY1vnEAp+j/A3rNkkcTPbXR6CSEsb1cJzKVIVaJYAo0evl/HvJ73VwtM3cfpqLbHmkVGM2cKawVS9J/3l8JkmPFhzw/BfWLbmaZEQA4Yh0O94i37LwEpjwfnY5W4b4ZF54Eu3vT255VDkw1EQVi27EbXjZkMz3HWcAk1dRvCOG2wHlpnM0HVoufe1dATt/eKElePHxVPO0rEuGqMFrzfzwjWIPK0SxNuFUjPiWPb2J/mWk7M3nQLtgf0cg7OaxsvIN4YncwlI+fqOXzjFTl0qD5S3je1K6hICO/6NPRxyvl5TbkmpFv22FCUJGDWkDKWqTu5YP3AjPKRLk3RxaPso5tyRvtn0oTd7HTkdOA3k2pQ/NAIJDzuaEiQZ2xklhrFl23ybk2zyxUoZ5D7eyUNjygpYrORODm9eCG3S4AXT+fZmgBh/7czrhCFcGwwMMhU=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oaKZ40wKglCVYYAnTuEMFM6FParPsBrWlRDS1e9Zfgo3CvrQJgVxsvc1KASPX1w/KI2F+n7k1HlU8eoEjo0YTY8qjyHVrEpG4TaVIzMvrgYq1Xw5bGL+AxJOy4AW0vEm+B0/559t5tmbIypqaT2IcagLiGVQ7m4Uuq3IcfMHa+/b+/tohtghmM2ucDBAfSxOPEdrQlz7Tdz49sgtRhD8KGdot6o/uqZ1ncoR1uaHTmgEsbeUmiIo22WGPpXXzEDTLn+PU8yDPrqhmpBNulCT62LtIAzPI3IjOPTeFNAPs8YOrz+16QX9htsh9PFlsbjr8O20iC0MFjwP4kxXNeqEqg8iySyWK63IpTwR+8fuhWfvEk786qTpMiihMgdYHZ0n1hp0Dv1+cXf0Jjs22GYJTdVdUZqhF5567eTGzryy27BRMn23KvQLlU/Owkp6tmBh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 12:48:32.5717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b8a428-237c-4415-3923-08de81c80005
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997770
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225423-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:dkim,ti.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F3D7F28D35E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Siddharth Vadapalli,

On Mon, 09 Mar 2026 10:25:32 +0530, Siddharth Vadapalli wrote:
> The pin for GPMC0_CLK.GPIO0_31 at address 0x000F407C is N22 and not M19.
> Hence, fix the pin name in the comment to avoid confusion.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a7-sk: Fix pin name in comment from M19 to N22
      commit: 6ee0792d83d5c690205c350825a4c30746c0e0a2

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


