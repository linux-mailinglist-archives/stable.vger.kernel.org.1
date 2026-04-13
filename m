Return-Path: <stable+bounces-235937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL26FvmR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:49:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E353E7EC0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06B3030058E3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F62366057;
	Mon, 13 Apr 2026 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aK6RbiWl"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AC2D063E;
	Mon, 13 Apr 2026 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062964; cv=fail; b=Hbi1NXZTZhQ8uO2q3jeQlDbuwkaF0aCVt9Ap2LZqWX5+Jq5NGMCg68/Wl9V61Q3TT+xeHyLwPNuqdsykBAxjRHC68fQUYl1znfDoL4IwBwAhXue3KqRzJbGPImB7BvzdFsWgJVtl3QLc2kPV+KCC6wqONhDuq2Hf7PP+5WfR+HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062964; c=relaxed/simple;
	bh=xcldgEKE7bVwhwQ5omotLXA/yCQQGHsxtjGs7HCZ5K4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dS2pJ2DI76vIObqrMCWtsHCWdLWJB5c2Yv8ykcyClZruEPeAYu1JrGzYS5qlVCdkDyjhncCrK7u5f7xG1i/LR3Fk8UmU78DzPoywdgJJm5lAH2oZseKSk2SX0VsT2kDiOwpad12OUhCUVokWFN2VMlMqlFfNMIcHjhVds/c/0do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aK6RbiWl; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgAgCzAs46xgL//oylh5s8nf1fymP5Cr+FY7xrdMrQNeg5L71dLxU5OXshpuPcnuHIdZKpO7Q8hUg+V/c65WJtPRze+TsHNgRg+r9ryYRmuxqmTF16oPcmBStw8sYqcQIZoMJeo3tD8rMuP1qtiwLStYDZP/WZVcucKX/2eXM+bYokCbd35n0TI8b6DMYuesMCG9qGSbD11/BV1pEqeYKkhWUgbdhXBvUnVbDwhX2FeQ4e0Jkd1kxKr2uIuw/PVFm6bIokZipJDiaixk4h1xwn3xdPI9VKKNlBmOtzvZjHOoHvk0GkpwJP2+DyOjiGDaQAsHVqGODQpDFbrIIoOyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8vi2XvuWsUXS14e2c2BRo4eE23R7SK/MQ3LDkwDdCI=;
 b=L27LeY/G2w4KSuTBDi3K/Dymvq6HbijMERReUC/NoeP+QGthlJyUggMKP4pZ82HObPclyFhGzJsBSGZ+1s0z7DC75LClcj1ab75ukNjVww+2DMQOQaMZYOCS79xPWJ5gWiSTElTpuQ/jmPXu9ZSaLsAEHlRAZqBoP4Ki0aF2AvewN3sOa8LesEJJl9cPiBQs5E/t+9kOgzvDRcjbt3OwLQ9nTJJfYAuVmGK+c+dqFkzOdBwuxKgDACGZ74nnRfBxmPNYkMcYo5+41l1rvB+Ux/ElvhQFsWdLuiISNfCZ+EvWEbJiXODh3IMEnjGynGS1SMqXH3Y2UlCexArhl/eOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8vi2XvuWsUXS14e2c2BRo4eE23R7SK/MQ3LDkwDdCI=;
 b=aK6RbiWl08D2cWcF8WtXvQBMYem5YgYxKC3OMSP4/MXEHMgzwl4D+2ifOucO1tSpE3d0e6OYC4dQYlyLYNW+x9X0h0A0T9EbgKe43KtcRdVv0/XA6j8F0u9x3OCZ4Z6FQfJTjoDKpz4dO1uQq3rOiZT5Cgc/h5L3WhZ7fzMN5/I=
Received: from PH8PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:2d0::22)
 by CO1PR10MB4403.namprd10.prod.outlook.com (2603:10b6:303:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 06:49:17 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:2d0:cafe::67) by PH8PR02CA0009.outlook.office365.com
 (2603:10b6:510:2d0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 06:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Mon, 13 Apr 2026 06:49:16 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 01:49:13 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 01:49:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 01:49:12 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63D6nALO1598785;
	Mon, 13 Apr 2026 01:49:11 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <ssantosh@kernel.org>
CC: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] soc: ti: k3-ringacc: Fix access mode for k3_ringacc_ring_pop_tail_io()
Date: Mon, 13 Apr 2026 12:21:14 +0530
Message-ID: <20260413065125.627180-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|CO1PR10MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e7ddf2-3c37-453f-9286-08de9928c803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ijL/G6eOfrJOCKV6A/Lc0wOcEHrHrLEIryXR3+fwDEOBp5zJdMcNoufUp+DWus/GJloXNeIgpVivgrO/4ppnUxwZjlR992DURjedk5qoboAY60A7d2ciHJQclEgd9k4YYRrlxM8x4NM2LNjQkL/7UYiE7uzlSuKepMtBrakZ+z9WQf3ZmqyOCQbzCZr8vfKCUylrfPPkGfowYeVoMJhgifOvs/3n4hMQDcQ9mUVmYjQbMrmCnIUhcU5t8hyzTHW/KP+RiU1yk8yANCgAufhahxC0Rwt+Ae2Y7yGnhNv+fsdAv80E/UvH4H5hJjTQiQs5bVUViR0bP3adXtTHJcQqVZn4v6WhAt0Yb+S5JZ/7ZguUi4zhXapFrOnav+ds6RjQje36bG7UAeHDXclV44M08mmZ2Sw1yVSgh2fuqZWSPxUj25wr8ypXbyIlQ5/Wjo5pdOe+TsLzE50iwHeUtefco5BAGssINmYPq8Yjx5ka/C1g9a+yUXtEy2Kz99f8tMTbKGw0zO6Mwp4O0ksC+7Z47YGnJKNrsPRItv0Tblwz5ymatUyZ3MDEKEG59PNBmf3LwVt77E857CeMvNIc4dhby6bDiajmpCIW+Rqm38tWl3x9tGG0WgXY9MB68Vka7cZtazt2tdDwWyah1qP4JlMeF6j/DjMZzk/LhHfo+E5/mtu9lSDv7YWbvlC8PluQCigWz8Muzs35/NM+iclXLD89l+HN9iO2zydk5/vOXiHBALa47nkFl1jc19aKG8eMlSlO03JJqTo6iYyv8mr9KbzW7Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ECAE6eN75HzoZwo9g5tx69qalM/9rRhegknDxga3LcUxkihaLCKXcSzcAgQGV9HFR0CvEwIBg8v77xaHfr3mPo9iedJ4c/FEkTvcZxBOFbtP1sHY8qtUiE1YXwh1S7zMJKN7+btHIlCIAZZCFvExthNkf95wdNc0gXvqeS/izAdaRL75YFejQenOL9gbDjlmR/UaQcDe5fviZy7/OiIcrjrRlhBYKSQZd7kxQSuVsrcYVjMUE2lnDGmsZqJgLSjQqL96gNLntExSZEpxGg8sQSGGCfn/iq1A26+RiX3LYqP3wkUIdWBxlzl1pRgJ9KS7DzWkvZ+8n1aVgQ0CvpeUD3jl2RrSjVBeHp8HEzVROcz6QXLjyVcfBkbWuJppXx8LJjV6Re/LOMSJWomPBTBzMi3nyA4MH4cO5t1VvFZOnKqgJNNSSF+c+dkYDDAPxDeZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 06:49:16.5324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e7ddf2-3c37-453f-9286-08de9928c803
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4403
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-235937-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99E353E7EC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

k3_ringacc_ring_pop_tail_io() invokes k3_ringacc_ring_access_io() with the
access mode incorrectly set to K3_RINGACC_ACCESS_MODE_POP_HEAD instead of
K3_RINGACC_ACCESS_MODE_POP_TAIL. Fix this.

Fixes: 3277e8aa2504 ("soc: ti: k3: add navss ringacc driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
028ef9c96e96 Linux 7.0
of Mainline Linux.

I noticed (visually) the incorrect access mode while working on:
https://lore.kernel.org/r/20260325123850.638748-1-s-vadapalli@ti.com/

Regards,
Siddharth.

 drivers/soc/ti/k3-ringacc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 7602b8a909b0..24f658e8c1dc 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1083,7 +1083,7 @@ static int k3_ringacc_ring_pop_io(struct k3_ring *ring, void *elem)
 static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void *elem)
 {
 	return k3_ringacc_ring_access_io(ring, elem,
-					 K3_RINGACC_ACCESS_MODE_POP_HEAD);
+					 K3_RINGACC_ACCESS_MODE_POP_TAIL);
 }
 
 /*
-- 
2.51.1


