Return-Path: <stable+bounces-238244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF4IIxth4Gn9fgAAu9opvQ
	(envelope-from <stable+bounces-238244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:10:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E10240A22F
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B12793070AF0
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 04:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3153101B9;
	Thu, 16 Apr 2026 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kCx0n8A5"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568642288D5;
	Thu, 16 Apr 2026 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776312597; cv=fail; b=KDkCl4HvAtpWIQFjM14w0S72G5/TgHHlgMaHIcvui4yLy+tq2oZljkh7OdvSJTdfWByTCjeKVISgOgQlxsmMQDsJj3qFVE/A9t/e6DduawwWgEiUXaNbE2sI7m79YFvQHMkHXDYC4oYxaGnWTNKTJjgi7SeBX0re7Tf1cm/xzNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776312597; c=relaxed/simple;
	bh=65XxLf18Qmgii5f9tUAEoIWktMfbtebtSxFH+/aTVMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OWzO2NNMpOgmFbhAZl8bCTy7AioalTCYCU5r4pHUPNR1/jqAiXUOY6eN8BLA+qqKk3u8Xe776NQyFxkO9DesxlzwPCpwnWg9qDDtWgYPkrIwYJmUVCDhVT1y/TFqr4Num/+mBMyKByaQ7HEt4polFdAEi1UhEBAxMTiHeD8SW9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kCx0n8A5; arc=fail smtp.client-ip=52.101.85.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR84dOT814+i21E1ruKPKWlqbNfzi9tMj7S0aBmwIXzF+Kn7vwQ85fXfGx7z+YBzy+Dl/leUNWNR/ChIlwviIDRV/TW8ARhTo4mqoB3as1694sV5K06PqNPIdXaTwGz96DRQILx9MqOC/usz4pumZlBWY8Krtns+IuklY0WMSjPNgIVMNAJAeKjAcEyIlpUVlUHCRv/phC1n2AzEVd9KK5YtyxYTaTRLkwwrZ+ekno4oK4HpRpXPpK0GxZQSLwvwAyjOy4yHvvCpzafIx0wWtKtM4rakOdVWkrIFxvA5MZgutxil2RxnY/VldP4NEQdQmgfQFfEICQZZibE0XSoh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe9i+7s/83O+IgPet/Um9U4En9JwppwD1GXBDM1f9MY=;
 b=EjKr0K3ixuMKJA5HB4v+yHRIz6UTS6Nkkp6Clmao4TBeQWFQGBCfR3uPONZthHfKqJcbub8Yv4FoGJni7DUGMG1v3M4FGM4R+k/ugU4JxcS8Q4BSZfBp4w1tyvFy6oH7b0LQ2nCylycp04PQF3L8FGCRLPsvvTxx1LwsCKSWdVpG+fu3E9wG1NHnGY8ItizXPhMXEUoKLvKfGSvjCxn0Wg7KbpwLj1GVrQVJE2sZy1+oireQXwZjwT7rG5n+kGEL3gCMTenc5PUbhYs/f01KpQvlljQp+cI0hJv9rPN+m2sp1KkL9IaGHtVVkAE8umDzGCnRsIfoowaR8QYwIzVscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe9i+7s/83O+IgPet/Um9U4En9JwppwD1GXBDM1f9MY=;
 b=kCx0n8A56mkpsKIwUdv2oIeWddYc/k7JJSQufUu0opadNCzzXxhIjPbi1fL//ENf2x+kICZ0lOTQzW6UPVy+65uWVG80W6rfrkYFvEVGoIsQAyMGAptMoAhK5bkB/E9zSsVRiOUWZKzFdX8kFq5KKGm5nS5Rn/o4pAClQLKOGeU=
Received: from BYAPR08CA0009.namprd08.prod.outlook.com (2603:10b6:a03:100::22)
 by CH0PR10MB7535.namprd10.prod.outlook.com (2603:10b6:610:187::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 04:09:49 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::e7) by BYAPR08CA0009.outlook.office365.com
 (2603:10b6:a03:100::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Thu,
 16 Apr 2026 04:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 04:09:48 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 23:09:47 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 23:09:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 23:09:47 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63G49fxN3241105;
	Wed, 15 Apr 2026 23:09:42 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <andrzej.hajda@intel.com>, <vigneshr@ti.com>, <b-padhi@ti.com>,
	<devarsht@ti.com>, <y-d@ti.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <yamonkar@cadence.com>, <sjakhade@cadence.com>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] drm/bridge/cdns-mhdp8546: Fix incorrect register clear in j721e disable
Date: Thu, 16 Apr 2026 09:39:33 +0530
Message-ID: <20260416040933.3052831-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|CH0PR10MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: c1179502-2025-479e-a3c1-08de9b6e005d
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|18096099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KILqRrsR8oL2M3UaEjK5TjMf5KtzE5RMFYEQH3fTdiobIaQrzZ5cy5ZUUG6cP3N8j7hdC7KsNGfdRmyMPmyxzvromXW4Xa7SFNf3R9nrWhQW05dcfpEUrQ5Pe/jYP703s/kQj6HkZpxDXwKqnxbs3JNCnnC+SckMktfROasO1WHjp7u+5FuzsbA3jAFNn6yj6qtlU9DH0IBJ2gQACqgIKW8dw0BHFc+pWKe0Ms5uMyu76GHlGlvU2Ef84gguAzJ6wfmlSeN2eULb8mLMlQiwt92cXAg1RQL5LW2rnffwDMAhJ2Q5+fJYkWRvx2+WMemGXiRAL9hWv4nrN+5uKvQn3LexEgnpm5pywFGF72kaTiBhT/NMx6gb14KRhHUehrl/Ol3knx86HnRi8OWVgUQ0WzEx1NZdBgajs0GCANsa3q2VcwTaFwrDQw4r7Pq/a6yV+j1WW7xhvVWRZNMU2looWg9d8LjoFrrnIRLepA190xzWhqTyqYG4CTKmUqZAjKaCc83UzxnB5bKs/2oKN5uLVndXvZZo85k9bV7MNiQ5kfni4msTJYFsuEnA7M8TSWuT+5nBL0RduYhpekfw56X9f95RVnYntdtMFTyAyUzmS79tRzBmvNQynE4pkNbUEeoZ5iBqo7VNHxax54xUew/IuOkyNWSysSgky0L6zCycFAeRd4fJzEmio6q2uoLVAz5R9mPCD+RiWCT4QRC8IXkDuA5Ag5MYM6ZZr267f3W85zO+NDMeWeKjRT2wszPB0y2vywOyx+SXp+5F2tW0X0HuxA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(18096099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w1AAQwhzkSXqjLaKnKuGlCzzqkPVMJ0RD7tfSOVN51txEwdwVJjgIHSdvXsvsCl8A8F5B3welbiwwhg5zDw5icbEeCBdYK69ut7+nRreYyOc+9ODCf8Y1EAnXbK/Otxj0mDP9qEL2ymWYp+JWqdtbrt0+3B10oJwR2Px1ANnc2bZzZHsXjFZ/E3SLKVexG78J3vp9NEKYlQ4EWuXjztRH/I0uJdgTgi8niOHDmwJaBl/ahpW8RFlx1fkEkeVUPxKXp2c+JZJnrxRsBF9yGhodaRyKwDcU4F7RDqsvWDLHKYo+26N1+bMgikOoVlBUiZI+NPbBdWWcWuzLsbOlankwrRgfmirl0p6HkpFv2NU9vhb1Oqn4/xXTw5B28PS5BJ3CWAwlhTP3KXq00/r+oo9jwYk9SnZGaPbXpI09fg/4XjLJXuJBqXZ0Di6Ko8IOoBa
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 04:09:48.6675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1179502-2025-479e-a3c1-08de9b6e005d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7535
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-238244-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u-kumar1@ti.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org,ti.com];
	NEURAL_HAM(-0.00)[-0.968];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid]
X-Rspamd-Queue-Id: 3E10240A22F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix the cdns_mhdp_j721e_disable() function to clear the correct register.
The function should clear DPTX_SRC_CFG (video source configuration) instead
of DPTX_DSC_CFG (DSC configuration) when disabling the display interface.

Clearing DPTX_SRC_CFG properly resets all video source settings (VIF enable
bits and DPI selections) to their default state.

Cc: stable@vger.kernel.org
Fixes: afba7e6c5fc19 ("drm: bridge: cdns-mhdp8546: Add TI J721E wrapper")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
index 12d04be4e242..5f92436ffa0a 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
@@ -62,7 +62,7 @@ static void cdns_mhdp_j721e_enable(struct cdns_mhdp_device *mhdp)
 static void cdns_mhdp_j721e_disable(struct cdns_mhdp_device *mhdp)
 {
 	/* Put everything to defaults  */
-	writel(0, mhdp->j721e_regs + DPTX_DSC_CFG);
+	writel(0, mhdp->j721e_regs + DPTX_SRC_CFG);
 }
 
 const struct mhdp_platform_ops mhdp_ti_j721e_ops = {
-- 
2.34.1


