Return-Path: <stable+bounces-249792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCnDEq2EDWonygUAu9opvQ
	(envelope-from <stable+bounces-249792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:53:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA958B256
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF8F1306A891
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA52B3B3890;
	Wed, 20 May 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AUrMyMOx"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50893CFF7E;
	Wed, 20 May 2026 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270087; cv=fail; b=ROZ7tBr5srpgfznmTK4l3ZHb7dNKR+ED48cIyWO63AO5dCWJZa3pTaK1sr7Otpmfv3xdMhOvC5Au+1A088HjO9Ldp7UnSjfEht+6xin1Ge8LSCMqla/Kzli236Y8KOkFxGdJjiMwcycx76lv0MYePi2p2RSGI9HL1cOMQ89OEDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270087; c=relaxed/simple;
	bh=eUszgNfvg+TV0q1yMHsg+qXwob9SUFi5ua1XlMQzqn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ndChGFHzyohQbc9/KovG04IfS8t5t8jHknuBALDRc3UO8Mm9DwtLgUysu/1Hjs4C7lfc3U0ootAbJjL+fd3sNv8I7oq9dEvzihdTjCKwwcyzEAarVECTtA6+b/HcqMUaInScxmqMi00/9r5Yfme5WjuRbdN5b0ISrtNcaP+8iwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AUrMyMOx; arc=fail smtp.client-ip=52.101.70.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymg7Z9y1WZklL+VTMlga4gnHsUTu4/W6mzV3kotd2Tg14Qb00tSpEUZ79fCytXm12r4nITgoiyuVAQJBClkfsP4mPTYN+gZAv0gDQFPGeYa/HN7a/utYXu5QAeHyNUjRimTZY/eJIWEmVGuWSN5JYowpjEoMU15M0yaC9V1a2fhDfI985lOnSZOA1rrV9taKCn735Rpy9XtpRxOpaB+adKaBumDdd7GPYVuydGjcIngOceKkVPpHnk31psawcCw/RjMQUR1sIq+nQy53TSa6bt5bbs1gseySIWOtYNzhPtkqebrj4ZRzaPHUS0iEIm4kfmao08wrItUlW5oVqmMPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08pRR6fBUm3OEqKTRX3ApiG/BBLOhDiex9gg/EHM7l4=;
 b=UuxCTlvNfEOGRKBNAXDawoWA6Z98Rguzj1610SNULVAA61Ze8UbbbQO0afP9LNugiHjihEnBeCRIIGA0XB5mIrH42ZuGdNgNVDupk27eEQgQVC/z6KWWIz33F/l6AToywZo/IBdu/bTUZodliWDgQeLQQ4tEJzMRxEVDD1fUP9xC05Tt1PJF1m+OdZPUX4ziHjMpN8qSDm4aps14UYyOBtBEZskLlCfugWHDrqc3uTLKVZ2FfCjcoOxU2+P84dxDUeyTwDQFbBSOn56mDGrgG4m8VFUMQVUF3mYCEqb63cYXebZl5I/qfYNjx7WnXp1V2in97bHeJaDcoTpx56q9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08pRR6fBUm3OEqKTRX3ApiG/BBLOhDiex9gg/EHM7l4=;
 b=AUrMyMOx1ypsp7FdqLsG5ubH8KK6mZoDQjATobLdhjQGUPnoxtLXl/VKr2QJujgA8I7hRTLPc81LGuR1GMV24vz0CV+0KBbj+bLr/SmPhZT2lynmBjZAWfgvx8KvtPh9zn+UxcC54ig4V6/Aw6cZE7UfltL7o4NZwBwXfbgAHbx3OmGqbh7UEK4CvjFVE21vBHWZOO/KTrg6DMC0HTTzE4sGfqEHvObL6YAP7pPqiKX3mvNVhuNmkFpr0ZmbIUTCIZ3Lz6wIBbkukZ5kNo/VNsCFgQSVgTj8rdTdPC9uEul63+7vfgEeWma/zSPa6nFPkGaRZeRD0XJVdhk6bp0Lfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS8PR04MB8531.eurprd04.prod.outlook.com (2603:10a6:20b:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:41:18 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:41:18 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	xiaoning.wang@nxp.com,
	Fugang.duan@nxp.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] spi: fsl-lpspi: fix missing RX DMA termination on TX prepare failure
Date: Wed, 20 May 2026 17:43:08 +0800
Message-ID: <20260520094308.2882892-3-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520094308.2882892-1-carlos.song@oss.nxp.com>
References: <20260520094308.2882892-1-carlos.song@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AS8PR04MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f1b505-19a3-4620-37a8-08deb653f109
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wodxcNN5SA2Q/DFBgrPOssGaRDU4+JCJowhdyTwgN0XFzOLO0+BP/CrngyUxCQdlKBgVojYqVrdPflDMJqzgiI9R9JKjzCk1syretHicl85rFqxuynsVy3ESFIHM+LnQCYEsOeQlpMrrz7nucOyeos37uJR9rIcQdicz3fG5Wy0hudXTpMlE+UGPi+XlpkU5BwaEovwZeRbgguE47G1cCUMmiSOc1qaOnAPBXDMNX83qFcnspaGQ53J0QQUE+dGIP2itpVW1dRmi+kHBjgvMZgfF9PSgaZRVdBBL4EL6U6AnophI4WODuZFszmUSf7ZVd9EcyCCtHj1kVxEx3l3Ww9WH20J1ho/DGlhXzbcAhBG+wbVmXo21mScuwTc/Q29OeLF2msya70NvzozhrFWdXSTeKJKEneFpeWJo5lPGynC7YVsRxhE+JmLgY1v/ygAKxuZKpjKY463t4Ft1fiecGFG+vBBTbupEykzgNPWUH3WXIibkkWkIGJo1Jq4XZn2df28O7K07z2PIoNDSI+0dRA6cVgdvYJwT2+OuA8KcyrxkuoG0x5Efm7O1t/fDl5Xh6zfBt5+KnqVudVblw0iSHTFck54QWyUCUcx2LgFcf1Dx1MXAfuRMojdnA8UTBayfGTgflhmHAQxeZH45gT39fNuxzYTaayFTsgzoB7j588q2ogrCkqQ60EOl6+fuRUpPmppFg0sXXFD0dy10rKnpBEq3oS1nxMs8j4G9oSs1r8iQbZV+Z4fjERHBdGXept8W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bakefi+/sV6oY1fA5EQvxPoQgD9LnBxgNJ2xGT8yMLHUEB7hg6sDRZ5pQ286?=
 =?us-ascii?Q?hz4ML+qIts0YeFnY0ZJReE5nYs6iHeaFx+MbQ6+9oIsRASqnNaJRQb+JnWGo?=
 =?us-ascii?Q?/jLAGY+H+dgMMkKbRSo/5Ojsl4cy3Q1xxc+lxH858jVUoSzmbz8/MQxJPFJj?=
 =?us-ascii?Q?8ECgKaI8XALZ/ifNJEC111xD03BVfsuieHBldaN+YRMnWKTYvnrbC6z8ynKk?=
 =?us-ascii?Q?U8qkGn4HYImYc9hvRFdOzhPcK0RdTa0RE73mGqEbbrpAg8ej2KxK3HN+Cfa0?=
 =?us-ascii?Q?fqHQBEJ6K59sjTDvYXH93c1qqN0C2uD6EJ60E/a40VFVyb25JxtXpGjmfik5?=
 =?us-ascii?Q?L6xBKVegKjXRjIuvassUdHGl1naug9uvO12UxbGsDJ+7Xb9orECssJCHFAns?=
 =?us-ascii?Q?+maGZacH0remlkPsmB5xwbPTuNE+8AUDp9haiAaeXfpcyPU7qExGaR4uSGxe?=
 =?us-ascii?Q?W0N8gVKjcHlqAP8hoqJltKVAhT2zo2wLg5CppG9r0+R9fdnHmFgjOFCCTkVr?=
 =?us-ascii?Q?o3FusUN/JeBkGhwKjZ7eySIO+qIEI/di6UyjIbSstZ1mclCaqKC+zxtQZiCc?=
 =?us-ascii?Q?3GIva91k8/QQnn7k7DrrizAdMTXr0Ofak+Y7SM1ruLYtcZl7Iit4oAelSpUA?=
 =?us-ascii?Q?TeAqwcNrpz0I9l5ZJStHDefWsSw4E/Yfy/phJH4CuwVtrjejppVoGfnuMz42?=
 =?us-ascii?Q?+B2pYo3v1l9M1oCgPfmrGYbiW5m6HmKe75hSLAdjElxhMZ6WwV441ZVYJGVu?=
 =?us-ascii?Q?InO0WqSGlOm4HCf4E/nmzFBA2miS96GW72nOgTWSA4WUdHe7Adthh5XxiTBo?=
 =?us-ascii?Q?CuGNmDg9LwGRDTx+H31mDVcKp3tWBBrlR+CiyiejVUv4d0hA2x6Sf/JY6t2+?=
 =?us-ascii?Q?mYA7dL6YKbPuQR1WYExx3ytVDuYux/YbXnsuIPSJRd5eQcgxu+ceDc2sbhxD?=
 =?us-ascii?Q?U0294R/q43IB2X92AXB1jvDpZWLcE1qRdmmJtQl0/hwt89IqzXXpCjDK8ysZ?=
 =?us-ascii?Q?AKUIt+V5PslGD7X/0IQoW3U3AdTiYG0rHTycckenkXLUwW4v8qcpPvcYbFoi?=
 =?us-ascii?Q?UPdN2TLgEu0HB1ZZBqLUFXHTxrlI/tVO1gm8epHGHtYy0DomnRjL+Coq5lBF?=
 =?us-ascii?Q?iBfy72OOF3esRmMlmOujD1bt7sHgVvon4T7BaU+kg2Kzas5wWaA6Zy6U4Cgl?=
 =?us-ascii?Q?i7I01H5JDYEyxkTylDvRvDf7Ai8qJ3qaCBFAp63bDmc7SKepAJT/0XNVAYwN?=
 =?us-ascii?Q?ornOnyoihH/sWjIT9dQQIH8YBIjzAHK3FnMBE+CWSzp8R7he/CRVm8M0daww?=
 =?us-ascii?Q?T6Q6sIbc4Z/XEjSMqzBhCyJxibenxdKKgPG1jNpZYwXOrW2QqEwGGE7z16x/?=
 =?us-ascii?Q?BZl6FMN0t2KNn47PWVlPquVTf/ucVrDEqZ6v22/4Q/NQSuSrAuN8IdMUFQEH?=
 =?us-ascii?Q?8NAEU4nGpWKOc3iKqjDqkrA9S0iS47QE4KflQu/sSin47aLSlxEMekxnebid?=
 =?us-ascii?Q?/A5CIZG9PNZk0h3NKiy/hXPcHWSE262BoOIogJZUzxh9GWaMRfCFYZlAWvOq?=
 =?us-ascii?Q?8y66VNpu3i2DIU+zt4MofKJfMw07F3oQCSt/GfFW8qYA7vT2PDgHe12s8Y41?=
 =?us-ascii?Q?w1z5APBMq5n06VJtgfjxTtVm1l7Pp9Lp//ymsARRplW/LJcoJMi4lgX6/oXH?=
 =?us-ascii?Q?chh+LiBLmzviMNFufTMYI2IKrq7POg7G9c/nkZqyyB3A76tPzMRRg9ErL7+1?=
 =?us-ascii?Q?x6RD7COFaw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f1b505-19a3-4620-37a8-08deb653f109
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:41:17.9744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUIX0kylZjlnZYmViKR3/EmxIh10DSdrD2WsqQuOzFJzd8CaCTjHF9MpJO/sD8HFGCCtpKoJ6ydYzVV7MA5uxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8531
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249792-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: A5BA958B256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

When dmaengine_prep_slave_sg() fails for the TX channel, the error path
only terminates the TX DMA channel but leaves the RX channel running.
Since the RX channel was already submitted and issued prior to preparing
the TX descriptor, returning -EINVAL causes the SPI core to unmap the
DMA buffers while the RX DMA engine continues writing to them, leading
to potential memory corruption or use-after-free.

Fix this by also terminating the RX channel before returning on the TX
prepare failure path.

Fixes: 09c04466ce7e ("spi: lpspi: add dma mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
change for v2:
  - Add fix missing RX DMA termination on TX prepare failure.
---
 drivers/spi/spi-fsl-lpspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1a94a42fac31..906892453a84 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -647,6 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
+		dmaengine_terminate_sync(controller->dma_rx);
 		dmaengine_terminate_sync(controller->dma_tx);
 		return -EINVAL;
 	}
-- 
2.43.0


