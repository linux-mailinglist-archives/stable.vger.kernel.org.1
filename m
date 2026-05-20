Return-Path: <stable+bounces-249790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FWVCn5/DWosyAUAu9opvQ
	(envelope-from <stable+bounces-249790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:31:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1058ACFF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A7533016D3C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0CB3C6A5C;
	Wed, 20 May 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xZj9CjsK"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420E3C7DF5;
	Wed, 20 May 2026 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269496; cv=fail; b=JkFhpQEalQzs/vA4ywIZA1JyXq66eDZmBebVscBzHtrTvOyat4Mqozflzj1aEcN9pXRY1MfHkYAfepgsfR3pbfifGGwUn+AFf6HEjXcG9ZNh9QkyYF+nYKNV6ljsMVS41P+ygWMMWpCMLNxK4ZH9KP+yEnxt6WjXyg5VYk9IMJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269496; c=relaxed/simple;
	bh=yTZVzsM8zTYmNaDSxQUgzJGxNstjeJv6i+RWM0R6q1w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RmobwSHl0CbXI5fdYc68npHOV+LMvPjUwawoKr3LHtocM8G3zYfQ6Kx82XFEywd10awx3997OGcdOJeTCefLMyTkaLuuNOpt1pOz1QPZwQfztzeYNDD2hz1CMJgW+wloLdmhN4IREe5pwJ2oNpzl3Bj6me4XQxry+Ep2B3Mkom8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xZj9CjsK; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quiRwEV4TgEyMFcdYG+yi5frR4kWRRdu+titKPTrj26iOE/CFzmJQM75CrUSQYE+EhI7uvOPzNk408yFkWp6EKcgCA5MHNEuIan26whNmmYlrEhV6s2Buc7l66lPmmuZbFb2Nx+9BaGqJYyMUTEyE+LT2Fr0GPxTV5l8JSF2o34pSKsJr7eYkuakIjZEgc2WuaMPKIFJ8uRCLvJDXvXD9rFzqKBqcEqOPUmoinnzdgsVJ8rTgs9zYhE7Uu5WARVzKEh65udnBbZzqc4emOqdFSug8bbTwlgjzuNoi+rhTXVtUZ+nvWG7Y2fgAbXdiq+xS3zwNkzWg/r0hETHQWcgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgW8k7IBzEovn1bwn07ZQdj6JfXSEsccKXiYS9qA+mI=;
 b=l4SapFN2hQdqFtsFSHsDDxkm2SGNKyid6bGFRQKstBZQiVDHRPVouOXsKXX+UMHgadg15N6k3xiyuwnt6mhRV1MXCvFu6V5Z7Bd9swVYcsX5UA/h+DSHMdVceU2zA4Nw7CsjuJBuqUnEaRnDAPF3UO3lyNq0rlISxJSXe2p0Tcju6Vd79NrW+22F+8VpVECJ2/1D2lff2Bfavc5JFXI3Oqo5h4pSYaxQcb+K6ER5RoSTLRx12Uu4SgL7tpSWu69BVBN6NAqKv7q+TG8XWOBikG6nEBs3N+hFfXRdR9OxRIgJoSOAOcCUornPZjzmr+E7/3N1jnJkpcsCBD9quL5kgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgW8k7IBzEovn1bwn07ZQdj6JfXSEsccKXiYS9qA+mI=;
 b=xZj9CjsKBuSs8iE49GkgYb8Xy5MuuG4GW4c0LUOAPVrvOiWUmZVC99iEMhwBk4ES+j9r4pNW93gmOVqmYFciZeu0UUvD2Dm/OD5WQtIE7XmyR69J07Z4dr3BEUuEYnbr7ZKq1DQFRaY/KrzzXX/bNeMetXlR8GvvHouvGG44FQp2Bk/rt35PZWaH+WeCap2X77HTegBn/amJTlTa0RQ6hXvasJN+9+j/yHDyIQoba58Mi3rUAtwcOFaSOvEjIMLLZwmjU8CIajNFvslX0NwPiHgFZO5ljrEF5CJZUkHjmvOYsnIbcComsDfGkZtyjYkDAh+fZqYClDDyeNE2xinC/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DU4PR04MB11077.eurprd04.prod.outlook.com (2603:10a6:10:58a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 09:31:20 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:31:20 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] i2c: imx-lpi2c: fix resource leaks switching to devm_dma_request_chan()
Date: Wed, 20 May 2026 17:33:23 +0800
Message-ID: <20260520093323.2882070-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::12) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|DU4PR04MB11077:EE_
X-MS-Office365-Filtering-Correlation-Id: 054dde03-7140-4b1e-8951-08deb6528c78
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ls0P6ytwYG8YsHWHNg01RzFRa5T3Jn6g7z7ZXBGTscjoHIOJQZkCXavazsn1L1n5XusBwHb7XsTLOAhFXMjYUXHWmD/Vc61HKeaQeBZpqo4QBpwnFjQUIcku7t3yzFS+FIfhq81kBAY0rNvf86zX7cmHSX7b2zKej8zliIj+hqL/Knt8GKydEyyhmsuoE5uu0Ep+M0G5nVQqOULw2/rXJCPSCqhTI20iXsBf3TcCeMw7tDbbA2CstXbHfGPgA7kCQnrH3tC3WUVlVjxnLk6Bkbkn5yd5Qqk7z7r5AowHK973p33E0EVLXitcyutAKmK1LjEHjbR5bTP9x+0cT1AOkUM73AWIjUpp+TQELhSPLMfhUHekW/c7rvdM1uVT/+/7uq9H9MsucLcClegczuP8Q5EDmvvHQHHALCsWndcSi8QEpJleXDHMvG7uKzA37icTbdC2Suu2bfMjbiGVWymOkpQyL7dnEqY/eDv5Gz9aMs0+RT7NAfuD+DZvW0IZatOSDBbJfgRDgALLqoKOezB/leV8JEhNVL0Z1AEGljTrt/3YogMs+55Y1NrWo3kSA6W7G8oPwd0UkPVUEDnHSG43TjHIdR4IeDGos6/ghhm4vm+pw/BhzF9R4kg8T5vSszP7Ioshos3lt/LKT28bUg0MEjy3FtbyiodSQDKjC60OK4A+lmD4y1iyGVYOkpO0Odi1v6hFMYnEdzK55DrhrJPmbK1NKBqZ0z0TmQEJSRCw1/EmfCFuprHglk9t14G8eYRq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(56012099003)(18002099003)(38350700014)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GzpIKwMqXLMMGjsgHYCRmecWDpI8qvOAVBX+5jmawsPC3lHZhvNS9cKuD0gl?=
 =?us-ascii?Q?xNdDdWNpCtIdUhiUJY/mZnf4vU7sEc3aarlu8CuUhr8KZNE8LpdF4ZyLomxT?=
 =?us-ascii?Q?JnlWL7mcaQIjHeaFE5qqg+2bHPzYK9Npwv77DStAhEBqeaseYpZBbSL4aVe0?=
 =?us-ascii?Q?FZc2JNeiiQiigbWCo11y5psYJIjaQMWCd/dFZUWZCFJBnE1YY62wpIVANCO0?=
 =?us-ascii?Q?qo0pkI4Qx6BnUsZnfOc8379u482L+V/7ClfnPztFYB/7m1oKR+Ifzu7/VuRD?=
 =?us-ascii?Q?btamH54Hc7cPMdEKir3Z6Wd7M2SpxTqmgI1NFwYRAMCWXgKr3iAbsAn0X2tD?=
 =?us-ascii?Q?emSzU3xEbeflNiDjHnpfy7fDSDbsZ4jkefX1fUACAL7/T4DiPUqr61nPmNNx?=
 =?us-ascii?Q?NGbu0W+ebopnxZHzQFseIQEUFgYFr8YS72qtNN1SnSdU8YYfdIHi+KTDHpZv?=
 =?us-ascii?Q?VEzivyQPZ4MM6hCSj7rW8xPZHlzRtnEoUZxvdy436PT8fZeubbtZeRXZ+U9W?=
 =?us-ascii?Q?m4xyDH44YuufPlfwfZO6eDcIIl3YZ8sFbAD3Buoa51xdC64yu+Ky0XM6S0vw?=
 =?us-ascii?Q?wYQLNwoZdJeyJAD5/6M48+rQNlH67/V56vrwflkRDrWhcfj2Oxl9+T7cYBF4?=
 =?us-ascii?Q?s/HCh/QTsThVvF1sbBsEPj4ZgoQWBa8a2TgIIXFfDBj41zGyz6dTRBXAtRf+?=
 =?us-ascii?Q?dD1aKIGe6AjNZSp5HYZ5ur9ojodm7/NIo4nqecridtW+jCBkTcVPrR/nA7ru?=
 =?us-ascii?Q?JbuWZpH545ngL1+5Jwp6rJfTn8vhCUu7JFczy6UUKhdM9c81LIreVt8rzAp4?=
 =?us-ascii?Q?5tx5NBGcmwnWH85+kSj5++TbOoFNqancbfuTHyfk43S1h9YA8mOMYOWFdQrj?=
 =?us-ascii?Q?H2AU6UhVJzbHRJkdcwU28M5kl/o3+hONGJV3LTR/L07h9dievCZdvexJtXr+?=
 =?us-ascii?Q?B5zc1LAB31U5CtJU4D2P3BOHwVac5E417Zd4ZdyvXCVl6VhJdbyt03BLYw//?=
 =?us-ascii?Q?F2xX0B1Z0TgeSnl/PX9HYnHdv30vsHI+RdJeoMx2VhUJ0fXuk3kLgRyX3XDo?=
 =?us-ascii?Q?gzfpiiusF+Mwvd7m6BsfOJlNiRC4NwzUkiVpjkjK7OcKUmRHfkbIlGx6r3Jg?=
 =?us-ascii?Q?UDcQq1fPizUuBUxAN+u7J/ss++LKDauwD/yfExEhAdR/VYri8YprcjTF7cEs?=
 =?us-ascii?Q?pZL+mf5qkW9J90KqGc/RwLkx2q/1E/Wmukvi/quGSCwV1gIdLY9feRZ2168j?=
 =?us-ascii?Q?/cmDRfo2+VFEwfe4y37uJnkvfDFhVMs5uXpLZMFj61OckHJUOEzRKwXq3RGE?=
 =?us-ascii?Q?reRM/LpasokmxOakFa7H3rPnj84hFFHwDcVY4lNG4XEmAq6Kxn9tJHBzqpWb?=
 =?us-ascii?Q?JIimDN0nl+kt8I053VtwyjZV24eXL7AcfnMjr0EQh0eL40N7FSZVamB+J2tk?=
 =?us-ascii?Q?GcRlVDz1YtPI0uETnr89qS78yzVi3PTql3Wg3UDfBdbRyTXVJ3x+YHZOZ9Xi?=
 =?us-ascii?Q?Tjp03SywK4Z7pXPpwTf56yQPPC5wK1RsQKkeguFImfgAqS7ym/h5Iss+fS7U?=
 =?us-ascii?Q?h5/06eL4xiac5hp1hxrk9F5mJSl67hc96iMxQULAfbJEhBQUYGqtS5E9w4On?=
 =?us-ascii?Q?jHlBXyZvvLtP1HJB5w76ftN195lo28WP3oS+pd9SV0w/4rDv1A7JwBeUd8so?=
 =?us-ascii?Q?Ex4U7MHhZhUMO8lmGFdHo709+RGOZhmx2BnuCQFOuBwUd8nmAUlXvNDg04HT?=
 =?us-ascii?Q?k7Bj2Zp6dQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054dde03-7140-4b1e-8951-08deb6528c78
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:31:20.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sDS/3EXOBQRHr32Qz22pzFmObdz2kcFJUvYhWmMzg6+iI/x87abA7M7cItj5j9xkwh5cedIZOhsTYIHGxXwEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11077
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249790-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 8FF1058ACFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

The LPI2C driver requests DMA channels using dma_request_chan(), but
never releases them in lpi2c_imx_remove(), resulting in DMA channel
leaks every time the driver is unloaded.

Additionally, when lpi2c_dma_init() successfully requests the TX DMA
channel but fails to request the RX DMA channel, the probe falls back
to PIO mode and completes successfully. Since probe succeeds, the devres
framework will not trigger any cleanup, leaving the TX DMA channel and
the memory allocated for the dma structure held for the lifetime of the
device even though DMA is never used.

Switch to devm_dma_request_chan() to let the device core manage DMA
channel lifetime automatically. Wrap all allocations within a devres
group so that devres_release_group() can release all partially acquired
resources when DMA init fails and probe continues in PIO mode.

Fixes: a09c8b3f9047 ("i2c: imx-lpi2c: add eDMA mode support for LPI2C")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v2:
  - Wrap all allocations in lpi2c_dma_init() within a devres group so
    that devres_release_group() releases all partially acquired resources
    (dma structure memory, TX DMA channel) when DMA init fails and probe
    continues in PIO mode. Without this, a successful TX channel request
    followed by a failed RX channel request would leave the TX channel
    and dma structure held for the lifetime of the device.
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 53 ++++++++++++++++++------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 6e298424de5e..dedcc24e63ec 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1383,55 +1383,66 @@ static int lpi2c_imx_init_recovery_info(struct lpi2c_imx_struct *lpi2c_imx,
 	return 0;
 }
 
-static void dma_exit(struct device *dev, struct lpi2c_imx_dma *dma)
-{
-	if (dma->chan_rx)
-		dma_release_channel(dma->chan_rx);
-
-	if (dma->chan_tx)
-		dma_release_channel(dma->chan_tx);
-
-	devm_kfree(dev, dma);
-}
-
 static int lpi2c_dma_init(struct device *dev, dma_addr_t phy_addr)
 {
 	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
 	struct lpi2c_imx_dma *dma;
+	void *group;
 	int ret;
 
-	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
-	if (!dma)
+	/*
+	 * Open a devres group so that all resources allocated within
+	 * this function can be released together if DMA init fails but
+	 * probe continues in PIO mode.
+	 */
+	group = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!group)
 		return -ENOMEM;
 
+	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
+	if (!dma) {
+		ret = -ENOMEM;
+		goto release_group;
+	}
+
 	dma->phy_addr = phy_addr;
 
 	/* Prepare for TX DMA: */
-	dma->chan_tx = dma_request_chan(dev, "tx");
+	dma->chan_tx = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
 		ret = PTR_ERR(dma->chan_tx);
 		if (ret != -ENODEV && ret != -EPROBE_DEFER)
 			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
-		dma->chan_tx = NULL;
-		goto dma_exit;
+		goto release_group;
 	}
 
 	/* Prepare for RX DMA: */
-	dma->chan_rx = dma_request_chan(dev, "rx");
+	dma->chan_rx = devm_dma_request_chan(dev, "rx");
 	if (IS_ERR(dma->chan_rx)) {
 		ret = PTR_ERR(dma->chan_rx);
 		if (ret != -ENODEV && ret != -EPROBE_DEFER)
 			dev_err(dev, "can't request DMA rx channel (%d)\n", ret);
-		dma->chan_rx = NULL;
-		goto dma_exit;
+		goto release_group;
 	}
 
+	/*
+	 * DMA init succeeded. Remove the group marker but keep all resources
+	 * bound to the device, they will be freed at device removal.
+	 */
+	devres_remove_group(dev, group);
+
 	lpi2c_imx->can_use_dma = true;
 	lpi2c_imx->dma = dma;
 	return 0;
 
-dma_exit:
-	dma_exit(dev, dma);
+release_group:
+	/*
+	 * DMA init failed. Release ALL resources allocated inside this
+	 * group (dma memory, TX channel if already acquired, etc.) so
+	 * that a successful PIO-mode probe does not hold unused resources
+	 * for the entire device lifetime.
+	 */
+	devres_release_group(dev, group);
 	return ret;
 }
 
-- 
2.43.0


