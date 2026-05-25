Return-Path: <stable+bounces-254064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEbWD767E2pTFQcAu9opvQ
	(envelope-from <stable+bounces-254064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:02:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9250F5C5800
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9F243007F74
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 03:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F992853EE;
	Mon, 25 May 2026 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kAaaUhqT"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFE1A6822;
	Mon, 25 May 2026 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779678136; cv=fail; b=nY7Ti2fp9dX6G90Mrm/9j+LZFXF9RBb8eMERKW65KFfnHjWn2GnSN17D2TrNa3xB8s8f7JSAVmOfqPt1r0y8fFBVxoB6SRZTOMj/epG+MZWExadFBHNP6UJyJ0NEG9s808q/RM8sPmdoZjrqv+nNR46Ko5Fz+Mquxf+ZArhFU94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779678136; c=relaxed/simple;
	bh=g9FjeI6Yl4N0o0a1m/5DauKnlH5bEb6jK5lsy+Ou570=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fkrHBWwE6muWdhd5xaNi/GMW7RQ694WZUneumNr2CH51QOZIq4OYgmMZiC7YBW6rm9s05O4fpBMrfi0YlzdH0jB41MteyBaQcWtBptGiDI+lrKRBIDDsMFPvLJ5ibBk/RScjm4WHNBZJ+rURPgvRmL11lj/xpY5dBZBEcalmwLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kAaaUhqT; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpX/6hcOr2O1yfunYNQpR5HLMDOtPjLFBkUr4qqgI8CWMZQeJMklQ4hqSaviAB14os13fW2BsfC02uQO/hQ534mLDtt9bLFv8rS6hkfn6ORJF9pSRLQkwP1J6Y2rKDDhZpU2VEUcFS4TSy96vB0+aRrD1HYGgz5rryyXfkRkda+mz2j2LnpBRbYsoLUwLyQH08P3qfwkIe57EmC2iPcg87zx6mEnv8fJj37kmqlLg0VV9UwwRUNgFo/HFTJDm24LEErKqEX7OaRucR/tdgX0I4Aenfw27vho9fsYGY1N5WiYGfyzE+STYEL92XSz1xtV2cmd3raus/96SJgr/d8lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoPXviqR3T9LCL0W79XbV+zBJwe5FqqHzXWAV5UPg6s=;
 b=fbJMvX2pPeyp10bw50TjoPMdWpXXP1eEVb4bXKTmQq3j2dupWF8jr9RQXjwD8E9/MIDB3Ir8/uFtj6OLpYcV2Sm7EhdIUChnhqLBPPSrg5j/oXVG1Rgg1YI/VI20V52NUhg2kcWaP2nJUBGJJSITLQ2d1zRMF6fRNQUh8mvkzQwnUBwIN03Y4FjbM8ksMmrOmkdXUXKy9+kgbP06h/Yv5h6//ip86tQF830XO0S9BuJF8V0EKiqYFIUycWKWxyca0OiCw8tFZ1b246N9pAEBUbgf/OYWfYPxohRYlUN4w16sQSVHRiZxmIXq7sIgjDlwxokn7EBj561p7+EIYk4Tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoPXviqR3T9LCL0W79XbV+zBJwe5FqqHzXWAV5UPg6s=;
 b=kAaaUhqTOWRrz1aJzgRX9s8/MdLqQqHxKE3/Scy8pjYKLvCMtXfd37zjXRlBZiEgcFdZGfSCswyosvF/ISAVqU2/8Rguioh5kON0NPXWOf3bX6gak1NqPRkP/UmdCVmDNGkJxil1TH5iYnc+VHAjFSKDE/10XOydkL5XF18YLV/1sq48CpCd7GRDmZXAlvPd5x6xUTM0Bw1B4rKmjaUcCWtmp0ZOnwGmech5TparLyGWDoHmFscaJgds6j/EQ93o2k6gnO1ArLMKYaB+54Fy+/NiAncvcGJLHfcnJjVeMuhrW6558EZLz5LHaSg+e1eAHB34HkngSD7db9g2DOftaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AM0PR04MB11878.eurprd04.prod.outlook.com (2603:10a6:20b:6fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 03:02:09 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 03:02:09 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com,
	haibo.chen@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5] i2c: imx: mark I2C adapter when hardware is powered down
Date: Mon, 25 May 2026 11:04:00 +0800
Message-ID: <20260525030400.3182911-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AM0PR04MB11878:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d75270c-4c4d-4310-4c52-08deba0a026d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	o2G2pff74uGZMGzyG4FCQUBXj1jgGdFBJhh7yxYv7eCCDx66+LsN13H+Ld16kKuzQ/HGObLEBsUHvq2YM0HJDbMLCMp4hA74iGCO/nm3jCSsrOw9Mf8t+w0NFZqW5kXD7mLr7wf975FqH2DrmD6Qwyk/qmlFSs9sMCjWNYNawuEqZQttnIrWcHiVwJDmp6p8rCJlkR712amSACqyFhqFqF2W7ji4Vh+w6EnQsxOyHz1oJLAKpVQq+9PNPYynZqzCiq3mTTiPEM5ukXCXFTiG/J0at5lFoeTlzil7QCHgAL5MPwTtf0ZF2mVXiKWNbEeBIUnMKgFGXvU4L0aZ9C5Y2X1JPAxmDN4FsBokiQNWg18WbnZwfOxs02x2qsWVIkkN3lXx4mWda76g5Ll5K71ncq5hSsIVgrHqjkQVaNzb7llFwXhKgQIZPT8U+/bjFh7tikqsgRf9hcT0XgHQ0f3dnT9i21btpYZThonQoQfqxMKpyWwHNkhbaYdNaMUuLCnOsoZbWEZ9BxZG6TvWpMF4nfpGmDdfxwQthK1Q7ltCI5K4fJ5KJ6RQH0xgl5k+tYzqnJQSXegpsWEihJvLcQBUJGSVUGSiHrX0OTAt56RAJk0IsAnlH5kmhE0yZS1KtH809C1BWXds5gsoAY6BGL4a0knBc5kcUZiKQlC14utokuuuo2orXg0oHEz8RepLtuLfSXkPbZ12XQsZC3rURwLUNtbAlFFL4n5VETHX1mVm45Kh1vg2VPl+bJfhMpBxU/cU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f4OnT7zgYVrDi8JlYarmA3yp64iP9qn0SQ/MyJ4Vv5sH2AUDkchnVRw89FUe?=
 =?us-ascii?Q?IdryL4TQcgwbXYII1VSu+iu3KOeg9kxJcGUsSUwcWstDeNKqpMrJ7O6boND0?=
 =?us-ascii?Q?zlj0b0G+duQuT91C7mGnNxiWo+Gi46Nw43AQqg7mP0rCvakKBPC8cme5NyXe?=
 =?us-ascii?Q?v5VC8EMVK3JV1delaDhfx5k5YIFGTC6HwWhWGhTRHus/Bw+5mL6BGG0B324w?=
 =?us-ascii?Q?rIgInpfxfiwcYRqKYvDfsEAKdBobsa5tnhFMfDYAGoq4ST+7piEQTueNSOtR?=
 =?us-ascii?Q?OvqNQ6lsViB+FTj5QrW0DxpU2Tr9mwwu7Ml+otBVy4cTtAjULLgB1JI1VQQJ?=
 =?us-ascii?Q?B9v0e8lJbBMiJC2bL1k0Mg0C+weUP3pHkwARH6StnGiRX6Ru7yjKmJx6atb7?=
 =?us-ascii?Q?+t6m2Zz/UEv8EcKrpa7PHHCMGWxXqsMHdbGN6lbj5T7A1EanrV/7LB0r+Xou?=
 =?us-ascii?Q?IG4bIctXgOQd5ViH1s++wOS85bSUydRcLgQsWlHpNtw/AsDhJBJm6F7FoBxi?=
 =?us-ascii?Q?DtBAXZZQr/Q/O29WLwlakHLlx+pt6upQMyLsJzNtxDPOHjbTpJYbNJ1eU7hN?=
 =?us-ascii?Q?OrLVQKwd+wT2DAFiD/8DwJIed0AoDKTXm/OY+OgfDd/bgjRiGLru17oQcHBN?=
 =?us-ascii?Q?/LtXHzGZ9GmLK2G9mXyodax7rLi4IkAmNHm2jCPgN9kC6QLDzfIoGsBBvoHD?=
 =?us-ascii?Q?Q4kcT+CntlYixx10TA2BiWDuhMsGxhtnXKqTiNap/wmVSqnEb7MGAky/UfHO?=
 =?us-ascii?Q?PMrRqJQ6gp6RhC3wF+LQPsM+iCf2QtqWWcMAFiwEOUYshfiyzPpWC4jKydF8?=
 =?us-ascii?Q?AKvLyHRe2yOn7RZtH3pvs/iIQs0s4u5IXPIrWFV/4kvx2/UN3TPr84ooAie2?=
 =?us-ascii?Q?fYgu0Ukak4Baw869A8C6y8QqrfRkvZE3XWokwbGB92YHAExJ7MX7cfR1eV7p?=
 =?us-ascii?Q?l6x5BIcharpYL7kZaTqUZ+6ZF31vQyMf4BwyXaR+/FBP3kdlkO5hQ25hWHMQ?=
 =?us-ascii?Q?R7qOdeoK315GE3qIU2W6g2YLmoVz2jB7tBoAgCU0j60LJieG35rgNJ735WT5?=
 =?us-ascii?Q?RoRn9lHS5+YEUQeCcwB1XKI40veoOmdfkFjh+2mr5We99dmxV3eArOdVBgHd?=
 =?us-ascii?Q?yPLMBOEKtkitxvWK1XLlfVDo+piYJVAN6BCSDwDvjIMT+W3Mce2cJtXmNi89?=
 =?us-ascii?Q?LWsxSOZ90c/QFcf+eujHR54Dj0aVIu5DimaYHRmJ6JeOk9/2bQcv2H+MO1T+?=
 =?us-ascii?Q?7ykRndihBQS6xH8/h9CcAoH0kNHmgj/bUwYSS/y2wQVWqTwsuOah3lyugc7+?=
 =?us-ascii?Q?1vAFI2YcQYBau02sJz/+8YXnMkmFiPROml2ZVEMu28kvC+HF5dX98e03GRlA?=
 =?us-ascii?Q?79F7aOaErOb3iQLbs9Eerd0Cslae1fC/Wlv6gLhR0jt9WCzB6HHIWGBSGHA8?=
 =?us-ascii?Q?SyJDMnTQh1hSjwQyodSlDt0icsiBAyhGMCgjn1REtNfB9KXtG1Z/hKqMf0v0?=
 =?us-ascii?Q?6Jfle2EvJ31aIB25GiGsSiq9DRu0T0F66OCcRB7BbeCYHjWx4b+wgFuKsGal?=
 =?us-ascii?Q?4kMS9Zd6i8qKR2knj+OcLRuh3/0Gh2z1oVrEW4mekNrHIXcepqSTVwI7oxzT?=
 =?us-ascii?Q?6RzAMihZuV3fgPyOr+M66OEITMA++8VNDDixGYnZYFDE/gCSvbztFKBEDnpj?=
 =?us-ascii?Q?H2xRFBbesdFPf3LxZOWi2KHv7+neA1PezLr1edbtzCIivjU6T0NlScQWdQsS?=
 =?us-ascii?Q?xvGvkD4Feg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d75270c-4c4d-4310-4c52-08deba0a026d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 03:02:08.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qT8zYblLCS3CxZuai2fIsBQdV9pfflUd8EuW75JLJf/ByspjJvqTIuQ3QoKBRqRssJNYGckmM2UkKxStyS9sMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11878
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254064-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,gmail.com,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9250F5C5800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

On some i.MX platforms, certain I2C client drivers keep a periodic
workqueue which continues to trigger I2C transfers.

During system suspend/resume, there exists a time window between:
  - suspend_noirq and the system entering suspend
  - the system starting to resume and resume_noirq

In this window, the I2C controller resources such as clock and pinctrl
may already be disabled or not yet restored.

If a workqueue triggers an I2C transfer in this period, the driver
attempts to access I2C registers while the hardware resources are
unavailable, which may lead to system hang.

Mark the I2C adapter as suspended during noirq suspend and block new
transfers until resume, ensuring that I2C transfers are only issued
when hardware resources are available.

Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v5:
  - Remake commit log including the issue detail from Mukesh's
    suggestion.
Change for v4:
  - Restore hrtimer when pm_runtime_force_suspend failed when slave mode
    enabled.
Change for v3:
  - Add hrtimer_cancel in i2c_imx_suspend_noirq to cancel slave_timer for
    safe suspend in i2c slave mode.
Change for v2:
  - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
    to prevent potential deadlock if a transfer is active during suspend.
  - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
    fails.
---
 drivers/i2c/busses/i2c-imx.c | 45 ++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 28313d0fad37..73317ddd5f02 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1922,6 +1922,47 @@ static int i2c_imx_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused i2c_imx_suspend_noirq(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	i2c_mark_adapter_suspended(&i2c_imx->adapter);
+
+	/*
+	 * Cancel the slave timer before powering down to prevent
+	 * i2c_imx_slave_timeout() from accessing hardware registers
+	 * while the clock is disabled.
+	 */
+	hrtimer_cancel(&i2c_imx->slave_timer);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		i2c_mark_adapter_resumed(&i2c_imx->adapter);
+		if (i2c_imx->slave) {
+			hrtimer_forward_now(&i2c_imx->slave_timer, I2C_IMX_CHECK_DELAY);
+			hrtimer_restart(&i2c_imx->slave_timer);
+		}
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused i2c_imx_resume_noirq(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	i2c_mark_adapter_resumed(&i2c_imx->adapter);
+
+	return 0;
+}
+
 static int i2c_imx_suspend(struct device *dev)
 {
 	/*
@@ -1955,8 +1996,8 @@ static int i2c_imx_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops i2c_imx_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				  pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend_noirq,
+				  i2c_imx_resume_noirq)
 	SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend, i2c_imx_resume)
 	RUNTIME_PM_OPS(i2c_imx_runtime_suspend, i2c_imx_runtime_resume, NULL)
 };
-- 
2.43.0


