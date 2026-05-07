Return-Path: <stable+bounces-244596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM1AOM60/GmOSwAAu9opvQ
	(envelope-from <stable+bounces-244596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 17:50:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F74EB62D
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4259F30157D2
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32DB44BC9F;
	Thu,  7 May 2026 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4foOIos"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A13B583E;
	Thu,  7 May 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168844; cv=fail; b=XMAbRYY1ANt9BNq7eVuM2m0hxnxNibfSWZuyM3iWlC/Sn0nHAoTkbfN93OBaQP/LELOlPK6WjU+Ewdhvy05lJdm35hE/0+aZfXtz1I7yzUyutrkQJYtBeKgGw5UGjumf1MX8ZB90zSA3MYTlr9dVsNrTqrhmylxFZycM68f4MOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168844; c=relaxed/simple;
	bh=9Dm/sHoOFUgpeGgXe4XsCiNfcLtPzB50LBbQEKp1mZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsvF5aoN0MnVv46DUtUZpGsmJ3ncrfOQlztZdtsnWZI9mWdaYVE4q9TVeHsAer89myQqpQpCv7kB6Gr4/NPyLCFH5aMRCs/b+ldeD182o06byusK3zdBstr9YcrFRfbdop76n99I+nHzAt4qFx+DJkL9PhniA8+FKA/gpPXWsqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f4foOIos; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSseR2PUe0HJ9eVCICaAOmA1K66ZP1E2j3vLvxGfmB7Lnb29TlyRXzL9DUyX/GKCKkGtX6jHP9ctY6q/wlrDQwpD+ex3ULLGTvzXYn9KHY4eKaXSxvRMbrFK9jgLcNFDsUDypXmghCBQLbDFNbkFO2oitayaVCzLPt52tVSJ8JK1fR1+nl/dD+zQNRFbp0RppR+Y/n+3kQQXw1gvq8/B+t7TcWrEAWUxMt/ssjKrvd7LZejBrv+jCTVx6PqEZHzb3AjlFpfNuxu4c5BE7Qlu/JoXkSmyK5KyUk/d4YY/zMQOaZXLhh1lbx1Px5FjEf0sqY6cJIFYXo0MDAfdr6zXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbj6hZQkxCTP0Yi0RKyrymjwiPmk8ciw2v1t5767OMU=;
 b=gejT3WeZ7JV8t810jTBARB2nHD9evgAqnHZaqggk4KvWUpyT8HmaiMYSuBDqMUeOsoax2X8yPrxqqfNQp27Wo+/6kkeyz6RNnHIEigL/Z2zZdqJC5pF5+r6yysL/dtAArcXP2QigF7CfvCGHBm9Orj48XuPr/wit7cCaLRm6EHPA39JEEW1652eIPtRZo5Aoss5S741+cHnjn8UH4mps4RX5t+a99soeNdMW4SGc7aYeRs24/P8QB8dxren2/rKa1lV+GNFbwwwnwg+PwB4AIXVjpPlrFjjSinuBeoIftEcZ7tJFRe5RndTtdVXYAdjFjdK671OTLqiiRVItakr3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbj6hZQkxCTP0Yi0RKyrymjwiPmk8ciw2v1t5767OMU=;
 b=f4foOIos/ScFv0ywQCtE9oMgGYNQ3T3nLgvcFeTfFsoAsrzORDjdkcGdIvJ2KUOBKzPS5ye2+AUrwbQiEBkcX0JsYc0k0g2HpBUCCVPPmLdgpCa9w3PqXczP8VvfC4OWwNb8W0wuPfYZ81PAaBNS4dr1W/KX/IaWtBMJSAA1Iz+M8CU7FOlxB1hlu+08gVJPNmRpnw/+YvHuPS0shZtwZ/MNbP2PRai2nW7MQpKft2KX6i03u2s08fn4t7MIq6v/vYeucMDIt25s59cUFGfNWXDlNn9X19xM1W7IPyAUlyrNmKgCkaIBlajHa2Z3JJG7zubF2d/Ob18ri2LEf9TOzw==
Received: from MN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:52d::22)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 15:47:16 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::91) by MN0PR04CA0008.outlook.office365.com
 (2603:10b6:208:52d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 15:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:46:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 08:46:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 08:46:21 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 7 May 2026 08:46:18 -0700
From: Kartik Rajput <kkartik@nvidia.com>
To: <daniel.lezcano@kernel.org>, <tglx@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kkartik@nvidia.com>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 1/4] clocksource/drivers/timer-tegra186: Fix support for multiple watchdog instances
Date: Thu, 7 May 2026 21:15:54 +0530
Message-ID: <20260507154557.2082697-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507154557.2082697-1-kkartik@nvidia.com>
References: <20260507154557.2082697-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 090e7576-f8a9-47ed-1e6e-08deac4fdafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lXodxVUngW+BS2+z+6eKflEb1Xagi0jqQCxU4/jOQDbkOGeZGUbXeCEPO/0U6CbfzACTyf1xdEQdiWnDLfhUV2s2dRoPBzcvmXfpAmOhwEVdXQABDkAhs1A9SS5I+xzJna0R64S6/+VynoNP5VceJ+Ic5oR3vLPhVQT07NveEECJK71b9LiCFq6DuG0/X81RIYmXi1xVKiKS6IEbGEJJVpIwRFgur67KWiGW17YGwqqd432GiqIUr2pBcBJQS0KfhzRFUYzBn8pxxoieQHPbgG/69miCkSd0PJ6uPoR91LL+u/rFsY4oSDka+bNiiHF52woPfrHb2zS6e59cjRVn62I2ZOBp4e+UmZyweTPBwoF2tsZ+m6jzehSH72NQ1VU/VS2DFi2dBw0hXVT4GXawM09EFJZfkXtM1zBI3fL7NzgU3RCHOW4u+Owlz0MdrReTpD0YLL+DfUMvIu3lDKJpcU9ldybCoOILS6i4HC9xFUxTOeGpQPWltRPJFMuiVovJ7MnzunKRTjjgL+2tSFyTb99/7jW71rSXZIddDWqbLG0DOacOSSAQvBLHQWE2U6HdGZATr4hv9lF1XVey6pjhqTJOp6kaMQePUdMAfa6ACKyqqMr8bI2D+YnHjyWsn/DQ5mF1d04wi3L55fz+fh7SX+vw1/oTLmBcn9i/Ofk3KpqVKns1n1Oe6t7h5iG2bJ1vDwky61nxuyYJn8nksZN1roVpfERznMHwwb4r/wTZW7CE4ibWYX0U9m0NSytMZgo2q9nNc1t2kU8CAYcopRPXEw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NrxJZxwTX0oHysKpoZnhdRPW9s33CXHk/kuO5IAHoOneuB4cv/mXgbFV1wft8q45IfC2nznrSWREf9m43QTkDbeJFQGFTVrjCGnRYbFkyo46VddbffoRUgaq5aW2jeVYSTKnayMrFpmlLJeiGJxasKdqK2eFkRcaDEIjt0vSR3uBVZh8/xZesE8fry0kkulNC7uYdO5KnmsguJpVyFqgg17oqzqYYkvqed60No6pefLQZ3Pn+DcuHRsWvU5P9pqG5v9lR4ridoKTkJieznTWwcp3xuFlBt6i7JWK57b+A3qEVT3faTCnPKoy+Y6Krp3/SyWXWuHOKydFOlV4JXxZaJkvSdnLz/Vd7Tl8tLR0vuwmtUGK/fvQJdneOmeuLiSx9o+rg+EQfO7xJ1nIQ4qNJb28Lkj6b7QCwOjN5WqTuSgwU1Saw56mTLOYEUlYyt6C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:46:50.7910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090e7576-f8a9-47ed-1e6e-08deac4fdafe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Rspamd-Queue-Id: 725F74EB62D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-244596-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kkartik@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Tegra SoCs support multiple watchdogs; currently only one (WDT0) is
used. When multiple watchdogs are registered, tegra186_wdt_enable()
overwrites the TKEIE(x) register, discarding any existing watchdog
interrupt enable bits. As a result, enabling one watchdog inadvertently
disables interrupts for the others.

Fix this by preserving the existing TKEIE(x) value and updating it
using a read-modify-write sequence.

Fixes: 42cee19a9f83 ("clocksource: Add Tegra186 timers support")
Cc: stable@vger.kernel.org
Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 355558893e5f..bfe16d2d5104 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -149,7 +149,8 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 	u32 value;
 
 	/* unmask hardware IRQ, this may have been lost across powergate */
-	value = TKEIE_WDT_MASK(wdt->index, 1);
+	value = readl(tegra->regs + TKEIE(wdt->tmr->hwirq));
+	value |= TKEIE_WDT_MASK(wdt->index, 1);
 	writel(value, tegra->regs + TKEIE(wdt->tmr->hwirq));
 
 	/* clear interrupt */
-- 
2.43.0


