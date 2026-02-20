Return-Path: <stable+bounces-217538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOlmMejfl2n99gIAu9opvQ
	(envelope-from <stable+bounces-217538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:15:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7379C164A17
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2359A302D5E4
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1462F39B9;
	Fri, 20 Feb 2026 04:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CQWPxhn3"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402932F2910;
	Fri, 20 Feb 2026 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560813; cv=fail; b=ZAfK3/fRCO/WeWo7ehIDX+dnWfQ1kd07P1xX9nfqxDm/tdmNkR944HOAS56H4Qn+VhXRwzdEHFQ8oRwovKGBZzfYjSZkgzha7uVZ6KVvcz6fBD0U9sTV39zDLHqqk5RWHCUoxGViqO8b7SbHVzeX7n238WZcKVp2pG0DwusHM0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560813; c=relaxed/simple;
	bh=gOqRZx6jW6BTfGSA1RYoBDXsqCfdLjpSnAqUgG7pAQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNjG+y55iJId/A1VM5Orwb4frr6OxZ1bSItfAJaipbp3NrdRqOg8qKMXekShIiIoTgsw8bWRbrYKE+D7ZTpgBZaieFPZ+caCo5FRTRWk/78wek/m1sdJIimBd33qSw7f7dMVh8q8I3Az+HYsP+lPmxNvpf0m9tAnO9LMtJO19zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CQWPxhn3; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTiKRORtDdEXG+80rFVkotCi7TXn1VfYWEgj7zTH5IjKlNtU+3tLypQSmwYHQN9qH1YdUCSXng9c06OoKkBz10Q3ws9rvPEPwIzhk0SSHnfRNGCTJiwGwcW3IJ+UQ5RQbazhlHC0MNwk82M4GMjZQU7oA1ELLOXeR4BfNTMHU6Pn5LqVV5KrPN24T/qgcW3KUmQyeHOP2IPJugIuyoaRz8bSuPn+Jm7NjnoepEFyY53EohdsN7YEpsWrE0sT7PvHjC2ynraQ6ZQ/XHxzBdNE9ZXln8PTIjepN+CfpMtul98a9zJezKhqbPs9+3/u4u3wHxlAixecItAr+eexOVkTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWp207TLxEevPO+Ex1vLWU+SBLWfUgf262IfLv0GqoE=;
 b=EFfRKkNxgvQqXLmv/fU5TJ0Qe/tUnoJRbmt63FYhPDskMdKXk+RQTcijh32UAr0585O4PiQ0YWgMardjejXqRQWefd+vyVoXQ2VsroJxpK4DJsr//XyK+bOXQtRNVpBiVa9vYjJwfnjjl7pS98tLizS1Fo1PuyIMIMdYovUKJcbRY1cadoR8YPWj47OsEwhacW/nTaV0rEYiHBL29IZRfMYHeXvlU3XhmqqiXSfpHxWhNthIDd5Uzyg0ulRgSqfequcy4VggqFKiJLVct8WXBq7lDC4cifC985hgJOkqLtn9qD6k5TUQqisJqN9vIJkjWPUCPqUrTDS5O7R8Lh06IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWp207TLxEevPO+Ex1vLWU+SBLWfUgf262IfLv0GqoE=;
 b=CQWPxhn3gIwwywDQBIDTMsSFdpJ17QWPSKbNyzPdaPFoxwA6UZAAaoE6xlmNmz9Aw2qjxBXXpXqmA9T2R5TdOW2H2SdzQ4ju9A730u+6nUpnv1aBK6Xoj6ZwDyQE7dj1FYmic0UEZoRUhl5ht5g22jN6jCdnbNcnD/LKltwDqbM=
Received: from BYAPR02CA0035.namprd02.prod.outlook.com (2603:10b6:a02:ee::48)
 by SN4PR10MB5638.namprd10.prod.outlook.com (2603:10b6:806:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 04:13:29 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::39) by BYAPR02CA0035.outlook.office365.com
 (2603:10b6:a02:ee::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 04:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 04:13:27 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 22:13:25 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 22:13:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 22:13:25 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61K4D1St3237911;
	Thu, 19 Feb 2026 22:13:20 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <danishanwar@ti.com>,
	<rogerq@kernel.org>, <horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>,
	<v-singh1@ti.com>, <vadim.fedorenko@linux.dev>,
	<matthias.schiffer@ew.tq-group.com>, <vigneshr@ti.com>, <m-malladi@ti.com>,
	<jacob.e.keller@intel.com>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net 3/3] net: ethernet: ti: icssg_common: set irq_disabled after disabling RX IRQ
Date: Fri, 20 Feb 2026 09:41:59 +0530
Message-ID: <20260220041431.372610-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260220041431.372610-1-s-vadapalli@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SN4PR10MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f7dd4e-2303-4613-88ef-08de703665c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tboVwL5xeqggiGp/yFfmsxm5LwMD9w7YYLwbG2BWtFe75ntGu7F1bD2YKBcz?=
 =?us-ascii?Q?B01/Rb47KFVlpOxb2ZrJqLJBjl9vjncGAG6Pn36uFtqBTSCP4EA0Xu8bac1d?=
 =?us-ascii?Q?74T6WS2aI/lqMHxCWw590Fx0U27UxZTFWYxIoLJDaf0InvFKevI8G+0dgPnr?=
 =?us-ascii?Q?EOonKceqFj7mUNwmzSd1xcqGllH0YHhYrZ3D4RXAqJgRifAbKm4sZvEjuQdZ?=
 =?us-ascii?Q?gw5sumggG2YfdYVipYV4eD/CAvd6Jf0DoWHrHlzJuCGPU2q5SreQkCqKJLEX?=
 =?us-ascii?Q?wwNeadgjW3qqSZf/qRkd2LeJUq+pAjWmw6uTgT15AEQ95ZmgPz7CfTtcW+EE?=
 =?us-ascii?Q?3WuDLWlkADfl50sV2dfF74KkpBDjOV6zb7//ICZ4zxi13fmHDjNUp4SMJ+mo?=
 =?us-ascii?Q?v8DU8uYfQfs9jsS943eYVovfoYf8SWW2TtMky6UUqakaqkE6m/YzWv+4T/kG?=
 =?us-ascii?Q?Y12YbwJZNEJIUtA53uPpfQdXuVWpYxrkH30jBq/cfLBv1bbeJwYtef8xNpe3?=
 =?us-ascii?Q?pQ3F8nNUCkeIwwfCEn2qvuTcDIZd3RQUg7JvaIUfiMnUmuqfeqyVOMcImfnT?=
 =?us-ascii?Q?i29YfbtIgEA1v8kqfRkNeGPiMUnfVnezXBaRiBNbi1z756m1qFf2SUxNTU2L?=
 =?us-ascii?Q?hJ5VM0VM2Itki5q5XTNXsE5sDJfsSBSoS+nWoaMoLzaX0W4d7QdQY/4WTP42?=
 =?us-ascii?Q?g4EVOBfCNpCE8zrueJRd6zNaEL48yEcfFjPm9XJb+vEZaYq0JaQK4VKjYsRs?=
 =?us-ascii?Q?Dy8zcCOLHKRn/lbdbw76bL8u5LuvH3K1qUxy9qx6oPRaWatWozsxbzI3/4kS?=
 =?us-ascii?Q?qfPS48b4oMpo6wqlzlC9OHCR020aEnlGoU8WQdIXtIAEvaAyxzE6eW5cCEGs?=
 =?us-ascii?Q?1kMFmXgBXAM22out9fiir9SDTmFnbJWIyIMon9buirgA8Jn6/HFHEuPe/yhS?=
 =?us-ascii?Q?9dIE76XIifvkfhJOymhdsQsEWWNjriTB8+1uoNXHqqPMKw6ON5FGh24XNbHp?=
 =?us-ascii?Q?ejoKbbQ7mJBBh8Q3V3vca6tZd4CtQrapaMh6aBGwV/qkgCoaX2AaAh6XUKs2?=
 =?us-ascii?Q?Aa4sPX37j5Goc6eaw5MJKVhQwjA/zlQ2XeXGH3fNHotCbq9A3RpVvNRe4Dp9?=
 =?us-ascii?Q?mBarhBT8h6LHOeBBFXd4Uqv0P+Zh7GJ+HBBiB1PFJcTUjJWedwM8E6AOlmb9?=
 =?us-ascii?Q?ncEoQLPg2u3Qh+72clJWSEzQJ+NVG2Qmz/BeBWlMvddSToSlf39KKU7djEIr?=
 =?us-ascii?Q?oU1Us8EcZ4wqrL1txbUpyB4BdFCH2ScrjyyyaMhpw+JvAXQQnfJwC5W1vT8Q?=
 =?us-ascii?Q?Ac3zYPnSfDv5YW1ktyKE/dioExz3jlH/eREvy9ct1+vt+xWvDEFILubzup7M?=
 =?us-ascii?Q?UTEwoX6zrjOciKgZWJ5wLlJTqjCB36cgiT6X/GNKbuf16yWDWL0IlZ3++TxS?=
 =?us-ascii?Q?6zttxWC5mCQCdqfk4gYE2dVtggR9PePnaLzXX0LX6cRVjGUKUZvDREW/p0m5?=
 =?us-ascii?Q?E4OmKEoVYBP74cnQbsUrTeLKSQfMublkm+xBHnjnKP13d1XLGzyqkyvl2zyS?=
 =?us-ascii?Q?1GF2CRFeKhUoRnpnTTdamYwBqW4XVFe+kjmW0JUvkBzvqoql6aLPc/k6niXE?=
 =?us-ascii?Q?VZZIMx+CJHgvJM9ORIxmK1K78H+ReJrJu1TZqTOItwwFXV5mVJ6SAsXSF5X2?=
 =?us-ascii?Q?5KEPajiO4G9fhdiHWDpV+waIClY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wpWN8lUmMi/66bR/F3IR8ndKSNaHfmUIls+n0lIhyr1HMQ/nJampdxDvyXsTIt5bFSKyhFpqm94J/rq0LybYu1W4mgfAD6Z21MExCRZC0AhfLsQEUf1zsAuGf0zf0C11nLK6If0h45oJ9Tfvx31IQIvNdRtSaw3RLggSrDEc5p0t9xULsD7m9NxpysgSCcufVrgAi/UX8dKAfjjWOKAluAOOWb2ltt3UaqXFzCBA+YcgSqmSx1USs8nYFAqM7NTxv6/RR5i1vPaS6RULKjRL5uo1owwFqX/9ZdxKAHLHcYA/wfWHJktUr9buAYRQYn0Mfq5F12E6w2GBTSrGQUiKF4eNq2JiO/RqM/0d3PBHjGnxtu/5PgURINAe+xecUxuqoH6u4bERLkFxnI8PmnBa5cb4gGYxIt9nBRi9qd7yrNQnJsMu7TRQWy4GsqWk44m3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 04:13:27.0107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f7dd4e-2303-4613-88ef-08de703665c8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5638
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217538-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7379C164A17
X-Rspamd-Action: no action

The 'irq_disabled' variable indicates the current state of the RX IRQ and
is used by the RX NAPI handler to determine whether the IRQ should be
enabled.

Currently, 'irq_disabled' is set before actually disabling the IRQ by
invoking disable_irq_nosync(). In an SMP environment, this leads to a race
condition wherein the processor taking the interrupt sets 'irq_disabled'
while another processor executing a previous instance of the RX NAPI
handler sees 'irq_disabled' set and invokes enable_irq() before the RX IRQ
is actually disabled by disable_irq_nosync(). This results in the following
warning:
	Unbalanced enable for IRQ ...

Fix this by disabling the RX IRQ using disable_irq_nosync() before setting
'irq_disabled'.

Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 24716c8d7f75..a512a1317c59 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1385,8 +1385,8 @@ irqreturn_t prueth_rx_irq(int irq, void *dev_id)
 {
 	struct prueth_emac *emac = dev_id;
 
-	emac->rx_chns.irq_disabled = true;
 	disable_irq_nosync(irq);
+	emac->rx_chns.irq_disabled = true;
 	napi_schedule(&emac->napi_rx);
 
 	return IRQ_HANDLED;
-- 
2.51.1


