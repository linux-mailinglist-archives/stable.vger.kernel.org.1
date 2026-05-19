Return-Path: <stable+bounces-249551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ACaD/NBDGq4bwUAu9opvQ
	(envelope-from <stable+bounces-249551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:56:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994257CFBF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE1E931AF9F0
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F08E38F938;
	Tue, 19 May 2026 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Arv3LRw8"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3C369D53;
	Tue, 19 May 2026 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187270; cv=fail; b=P6rTvU4V2sXwo+eVZDTY0alsLFfftfaUXOy3zFffTTHwZbbNcBwYVvfKS6mBoqw9qxGiZw5aRPs73gUouhLZir8YwdVBgBQR42exofseiKUYEO3LS0IQHVqjBIh42WLA4rpR1q/KtAn3YIX51g/NqJpPCNTA5wzB3UPD7qQS+6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187270; c=relaxed/simple;
	bh=1GK7CaqZ/G4x3NbV69rP9Hs2U8UpOPjRU1B9DcdEuqA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KcUqgljLTs7EbkNJBXBeib9JSPfl9lIPRCYJ3VKeNcnC00oywlHjvX4WMI7Nqh+XnoaprblMe88q2wKbUmuUGV/sop29eVxtA5czivE1HoXdQuugiTsszKOHJ2Jvz0K6BVgTbtHVcW0Q+9rNsgHSKROiVKs2nO+okqbtWh5IsGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Arv3LRw8; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTzuipOUHLP/K71M577DZEg2OWeiub/KkkLANFGYKCFeNEPHXe1iWKLAbJKYH5SdfFfAXXXneobzEO0oGliODWVk0RZhtEFfssFD9vE7TjVkqCnYIKxyzgtqIWBhg1V2q/cHeDomIDTr/4G3lmZ60YvF61c2JCCE5vymI0GhQs4RPvVBBNCqdcGgk9U/7k10SWItY0fRqo4X62wAAZ3nE32QbhST6DY1H2zsvZUM2DZQowcv0LWsDYh/7msRqaI7ia/25c+qR4YLoS1NXoyqc38vJ4gbkKWzGdcJTqKWkQalTcqexssXt2nsPnqmQugVQNcf6HLR/70xfoSVf58O1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6Ib/O+bWACbb8CFEpzazxl7LVQEA0H+LLoRkNtdx9A=;
 b=HeoA/2AvPQRCl3MMJJ+sNbC4ExzXhVGEhQULbwh8RYhtTSwx0VD0YWx1ZsVDnt9dUU9hYJenPu97ZTw5q43SjuTK7OVVauSM9T0MeNN8fx/pfG0GTGL46lB0Mm0yY4ytm3lwvR03VIpYwKBn3wvYTsilQv+8YP1CLzkfEeAR++PO3rFlpFbnd/EtdY9xba9ueT6sWIu+IGJS0rxbuDBYV6RcOqBgFliDXFyZ2unAi90VCd/Fmw3Cf5DNqWa/x/t1Leh4zLl4W7r/sYynsE2O/eBX9ogeD+WxW1TEgexU1AKuLB7Bb4Xshg6bkrx+X89lu5KjwS4dNxMhWZJLGNgqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6Ib/O+bWACbb8CFEpzazxl7LVQEA0H+LLoRkNtdx9A=;
 b=Arv3LRw8ccC6m5qNkwP7gjw6UcJMrhDQoptqvqVOFZH0xiUUiVgY6wzOPKSTTSczXs+TG8wOhzopib2C8yGCs1Fx0cZdDZXSLOubt1uDQ9SLdLWiWkShgemdcRIRzVjFK4uAnPeHWVDfElXWTvF3cNszDEFCZsuXQQASzuxC3pUOBHpecSK0vZOkab7CtOoH5CLCEsuMlZHh+CGm58Ckpan7QDj2jlnBjAEJwMoCMqD0fRVAdXjh6juJ3o7tNNGvFvgQCwg9PoPDO6g12c+GZOJ4seBHWv74dnFdjMcjHzYAGwEsyUi3Qz27TA/n+J6LjqrWsHezLPs06IK8zpW4vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS4PR04MB9337.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:41:05 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 10:41:05 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: carlos.song@nxp.com,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] i2c: imx-lpi2c: fix resource leaks switching to devm_dma_request_chan()
Date: Tue, 19 May 2026 18:43:09 +0800
Message-ID: <20260519104309.2794248-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::10) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AS4PR04MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f46a4f0-9858-4bde-aae4-08deb59320dd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|56012099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	H8Co3MOzr5UyHLnHzDew0xqv/FupKP2qxWQgC2R9aY/6ZShEaLeJ46kY0TEq/iiTl/7hBw7yLeKMlDsugon1hscC8wA6m4+WyXPZvNcXx/jwKDoCSTe0EG7tS86macT9gZkxvI7ZWSGMSoQ0VSjVYDawdj1l0odFLttlawWYz08UnOAkuBJksMn86u+4PIf6Kqi9Bhu+XrXv8e7Wu5uBfhq1XzX8bt526iuXKGB2szNoDM0YuGFIs6IBMg6UlcR93JOHCGovGIGrgE4smlwi8xdB8uoyN8SMjQS+3Z+nzngtHn2XMseUa5WPx8IGbS6yZGJt4kJk68IA+Yy+RyyMQqTpzLv3re/zD09K96riOeFM+zZXA5KVX339GoC+s/ZgsvfKpBoaZvzX5sGM0CBOmdgk7thbuErZSVK46einjxCVrFaPvXpNttm31O4RL/H/2EtfuRYBEmSWABem41a4+ALFo+FqZ6Lcjcr6d94yAUo7VoxOJA7jRmQZYiDOaXS8BXjS8Kw5VeWn0FPKsyKg+RrPYMNBo2LokDC84hxhkwUpRamXKTTizkHdfHBDoiLCQ0ow3Gm/cVg+OaIMS4Om0xedsnG4xwQiPmln9ktjaro2YzBGArcfdMmwqyYEu6QhotGrOKL29cNNFcao0X764FL+eslirzDehy/lc8Dn3vnsP/UJw8By0CEFt+kEZeQ3C+2JlceqQvZUenR33Yi6LBGhgpUPExfVWrr1ROSQKnrW3jpgepz8IAI35+yCsc6y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8VTwE+vUKpO8iml4CwFjaFjKgzXbHT7XGiOGVa1Yuat9jCOvsdvZIc+NKzGL?=
 =?us-ascii?Q?Cq1Dl4qAfGValiZrbOo2PH6VvNd9hzDN/zH8ZgMDo502QBqd6C2mm2RIfiZV?=
 =?us-ascii?Q?U5g4McJb/fZzy8BQsWga8HgQZ+6nYxWiHHrlmTQFIPdgXLHZjyhr85+UQE33?=
 =?us-ascii?Q?qVqz5TudhnXUxl/EzqFeuYuXsVivuSgtPExNbHM4K634hFNgQHMsZM0v20Bp?=
 =?us-ascii?Q?9ZlwUHmefLPgYuEFmm9GTt0VqGo5mCNjQDZcw3cCz5RutEsKReFpGasl6pDd?=
 =?us-ascii?Q?KcdI2XIt5ynuP7R+nHzX52FOjnJih1ErzSu5NOpU2NYEBUA8q4dmioJ56lMX?=
 =?us-ascii?Q?Q6gQ0fFZImoCuOFwv1A6pUFT2u+ytkce1mc5AID82dStFPVV6IAfb0228xm4?=
 =?us-ascii?Q?/bOtVc4UDgkyGmOyCJALldqm5zA9zQaV7C8HI6hHjkdO3VudubH4R/JhljH+?=
 =?us-ascii?Q?f1qdzlwkG0Hn3v5ZEX5OH6M5eNSXb8qcTGxY5+XjJwWsKKkWZeQG22ljPNba?=
 =?us-ascii?Q?kbj+xkhMVIIteZwmevIE+23Ow/iwmzrfPC8fub80RjygBv8qiazO/56ygbUn?=
 =?us-ascii?Q?ZhMiGh6E2Z7nUssnhvzV4VIisF0cNv00nuPx638FBVtc6HUHlfEcSqbR+YMi?=
 =?us-ascii?Q?R+edGQBe/lHxAN1VRktvkxEsVscBgT/UwPNoh3zFWDDxAX1DuvotoqsTIhZZ?=
 =?us-ascii?Q?R/m3wtG2aJ3KJb4tt4A4Th/RgrQiuxtYj/KScKIrYh/33Ze1d9wb3lzvQ93Q?=
 =?us-ascii?Q?550gyck7wKLR+tzMqHMTrOmHvm0VIPQSuy1A72tLjM8NbJJYFeTIUEyFCvfE?=
 =?us-ascii?Q?aabpjmrX2aKQ3mcjJTT+bvrpizaPPuo+RQe6uEHK/Gde3t2SZmEtU5bBHJpj?=
 =?us-ascii?Q?lux75i1b+p9yLx2UCuKHfcpyrCQBa5QgRtfX5CvhCjMN/GHobNAIuIXAQBxA?=
 =?us-ascii?Q?jGVJ8nbbhNpv06ZuGAsIxYyXQYo8HdXQywYybJ+/oBK8JcsO5ZHPZLA00yH7?=
 =?us-ascii?Q?y1OWRErXvQsK/umBtSUNOd/01MVJSTT0AMkAAuWBxx+6UVIq1zIyj0CAVzt6?=
 =?us-ascii?Q?DsnPVJJXXe1dkpmFaa4YEKBpW1qqQLQNQr57ULHK/1Pn8hexFaMWpUb6bAzH?=
 =?us-ascii?Q?Huuy78ddxlqAXhx9lQAhs1JOSGiMHcVXPT3siocBnh2X4twQWV/CbiEKi/hw?=
 =?us-ascii?Q?zUI2uHZwbjZHG5YUAaGOW5Vj3T4FoaKuO0XHU2m7xhqst52+qgktHNdQ/CWd?=
 =?us-ascii?Q?7PC1v+rM0g9jQ6LpvlhDzF+c1Bpx3lzSWnTMJoQabO/nRfojkq7DfrnyOfro?=
 =?us-ascii?Q?C7d8oKG9iCpR0uv7XO5kVyApMdKXRcNd5fMTg8iXtSJBscY6tGuekHd+bYZN?=
 =?us-ascii?Q?f35emiNJdFbp1FzbA8U6XON9Ue4mZ43J90DkQUNDSn+QlY9j/l15xtAnk31Y?=
 =?us-ascii?Q?XfAHYgvucWsq4yZU647apPdFHa9HGd4W28oNf7uFc9GVQAKpz/7R662flbnC?=
 =?us-ascii?Q?QmNFqyPe6Ve8E5PLYRV4VxS4sUZ+u1nGxsBMPc76sUoawrtJTStpIB5402Z3?=
 =?us-ascii?Q?kzj5dxGcMZW494dD+LNx7RMSO16mmIopkHOoitzslm/Hx5Qgmv2fAqVrD31W?=
 =?us-ascii?Q?ltopx3fQSb/mbYgrcMfF3deiEp6mdti+BUGChocOZEWoGG73sJhaLXpwuytf?=
 =?us-ascii?Q?0wYOCmYIWOIFgxwPs76jiIdp0e/nrfhSbLOGQbyNlO+04GTGgMXTo7xfEZEw?=
 =?us-ascii?Q?cJDph3UljA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f46a4f0-9858-4bde-aae4-08deb59320dd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:41:05.3402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0nYPLXn2eQQD1NKKI+dRG2dHG2XB0JgebxLWIntaePdbetv+JO/Rg0qSBIY2bjGibeYvCBNHHE2FXQF7z5QOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9337
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249551-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 8994257CFBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

The LPI2C driver currently requests DMA channels using dma_request_chan(),
but only releases them when the request fails. DMA channels are not
released during driver remove or shutdown, resulting in resource leaks.

Switch to devm_dma_request_chan() to let the device core manage DMA
channel lifetime automatically, ensuring proper cleanup on all exit
paths.

Fixes: a09c8b3f9047 ("i2c: imx-lpi2c: add eDMA mode support for LPI2C")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 96f6dc23232e..fb52db5b4062 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1383,17 +1383,6 @@ static int lpi2c_imx_init_recovery_info(struct lpi2c_imx_struct *lpi2c_imx,
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
@@ -1407,32 +1396,26 @@ static int lpi2c_dma_init(struct device *dev, dma_addr_t phy_addr)
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
+		return ret;
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
+		return ret;
 	}
 
 	lpi2c_imx->can_use_dma = true;
 	lpi2c_imx->dma = dma;
 	return 0;
-
-dma_exit:
-	dma_exit(dev, dma);
-	return ret;
 }
 
 static u32 lpi2c_imx_func(struct i2c_adapter *adapter)
-- 
2.43.0


