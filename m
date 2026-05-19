Return-Path: <stable+bounces-249552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HhcO1lBDGqqawUAu9opvQ
	(envelope-from <stable+bounces-249552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:54:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9721057CEF6
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 238593072DBD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA2352015;
	Tue, 19 May 2026 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LrTDr43h"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA43A7F7E;
	Tue, 19 May 2026 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187408; cv=fail; b=YboF76POEZOGwzoibUCx1ww1Ep0gSVAerm7j8zdCmq0kpWVRF6kCRIAPzwjpJgbrZ/hDV1yZ5KhZt083LCe7DCfvdjYOo52JW3QFAo8aGBKrZm+gDTbjOrlq85sWKmB3R/Ndy40c7RmHCNcMfIEzbpTpArMOm2DecbMgphRGL/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187408; c=relaxed/simple;
	bh=NFCvNvF8jBguwXy6I+41awqDIbT1sLzelbKQcTZXyWk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LQBcv+Q3Qr51cTsijoXXniHRD1Vj/fgt/nI0XMpk55IIpRsw3CPnxAhHoLqLOyd1lwG3+RNd3fsufIoTCkCMRCCPp1tvh2f7i/D73zICfTgN0IrEKMQJCgBNfbOy5XAb+/EB21JMdK6bL+HaFxFoLN9phOZIKNDqJKGVmcOUZ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LrTDr43h; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMtxalyJMuJgOU50wgWi+5SXlaVsKLMCllylwhV0MpewEbhMWgd61sHCOVqT/GYAdCRuoSzvzweLrOZ7zb2XcdqwgbEPHq2qcgVtaZCbyIAPiCef9ZKoPUBEj5KpqtTg0bqzQhA+lsIEOj+VhGGLy4FKsuS2forn7alwndhC52gLKizcsBaZtF3b+ihVwfV8XUgVGQLD6OJ2FTqzWGW5LY0z8nD6YjUwD77b9LAWvJc1rRG5Lj+5LX72uU5lX6xVeHx5yJTi718W5NcxZ8iUW4UbrST7Z6pcPhuCvChsRUp7avKYhVQGNtlaP4tSzORk4YqG/+b2eJg4K2yZr1rDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q5N5CaPaZiO1scxBwzXHUNh3yJhodaFx+g/thgKjvE=;
 b=T1O178j3I7l8H0Vgb4m4Txw16j2Bj16pQWoa4Iyh4Bkl2T7BKPssPNDs02NTW0wSpkp2aJOuXl4BO9Hd2gcttCDjTXZy6e+jVKly6hNRLl3oQSxk8IiijVALQivkLN2vFKrK19FL/VFp13AikE5KwBWctVy1vzgJFfrO2HN2Un23nB4F9fzPIMEJaOrub6ueHKBBlDivzUKJQJjo1XsGLtGiRbak3OrLTYh4zQ8k7QWzd1E6GpASpUj/m91C8D7jm3rgrIq7SnjiHWpqaUN/omqiVIEMmmRx+Oqq0iPQ7sFOjsoZxpBxrA76bhCVfKNKdq7nA13v69vfth/t9B7x2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q5N5CaPaZiO1scxBwzXHUNh3yJhodaFx+g/thgKjvE=;
 b=LrTDr43hnCuyEDoQC87k7rpfXBvGemU4czrtUwmxJ2wyNlbK4jBwh2Ej2zmp44IbtQ0KSdeiOznHg4Jtxn22sZPxfw+SECzNMRt5dWA1q5VicwHSHnp7mf9mwrGZLGemlXmvKeQvqB8W+w4abJsyUOfCi6oSfqVHID/2/wJJSrpA9l9v4Vp3jgBx+85iiWshk4I+h5/ApD6Dkte+OYjum8/WS5WPlXoNi46V2SEs+YpPMbcqDqHO+P6wX1PS8RTkvVzomWR7o5NHtzcIk3xHSo/raU+LgzWrXBIKfUDakr7QTIN1yZNoYo1HqjeIPnfOPG34AMiyV5XR7E1umFqRTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DB9PR04MB8217.eurprd04.prod.outlook.com (2603:10a6:10:244::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:43:13 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 10:43:13 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	xiaoning.wang@nxp.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: fsl-lpspi: replace dmaengine_terminate_all with dmaengine_terminate_sync
Date: Tue, 19 May 2026 18:45:17 +0800
Message-ID: <20260519104517.2794390-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|DB9PR04MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 602ade4a-6e49-4ff4-4945-08deb5936cf0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u1sNhQOWdBx1eW7gojUzPtYjFatLYj4T3FBdBjckuXGKqERzlFjnCufQnr4LoNk4PwOGBUDDPWzFeImcr50sZ64lOaUhVGg31FedZ6aHPqiuFFnHP+4jY+t4/UqR8J0VCIsQ+r8cbZv5pAoJ7r77nKB2JZB99iPXrq92fCoPnHzWc2pIjrACeU3n2qyAUQgTPnIPCv25v0Z6YLKs2Q05h0x1utzpzL/4ojBw5YkXLW7ATKBCty4Clr5lpLoUr/aD180mDf4o9GrRCaLgFc53ov8ih07cWadoppRWxoW0JXn5YsOsI5QiX5qPzQhZXXFSgeNqLLNlNFG/DevL49eIJgUvFBhEH/9YQvDPRfUNbDwyInzloRvDPOswteZeHtbA+ryquE/nLb+RKPAAwIJmh/dkQSQ0ua1DnkrPK5O2ykrBd8Y/p6F5I9KjCIJ3+1EoXOUe3PinJ/6B9wHdj9jKCTmi+8fNBT1B2LGPB2M4NBSIKBGT1CLffz6AtWhgYHtOaygxWEuWElq9bawbBZweIoYsidzWXzC3iqxsKGOg90pNY1RquRfYz1MIEczeqYXLoL/s3CoxmbcOyR1yuTiCWwDQiOZlPWfrzs3S5GdFe7eV6BLegQcLI8kAkC/QXqYrJSqn4Y5OgCqOpChSMeR1OiByhBOJhrTCOwnrSowrMGhop27eWcFOZgf5fzIcaHKeAwiGz5WO4/9mvAsFCPGQ0zIFcKK4uYAvjaoYTmLhD9BYdYoDWMKnJkltWRc+f6eE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014)(11063799006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sf1JMKzvS75VTEfsapiYusrZYlWbf3Zt7lS/wRr4W/GogTQF6KlxJTWA3B2u?=
 =?us-ascii?Q?3hdU20IOS1vkrVxGUOhexfsTAIJhtKb3hJIkvdhFOCQCTTxUXrEQUEPxTikK?=
 =?us-ascii?Q?KDg4xXtFG7Lzh0tspJhiiZd0qxpcz4fzaf8brJmwM8HjOuNNppJSNzNtaWKM?=
 =?us-ascii?Q?XtHDDGmGNBV30moyu2GHqCzzfl/013eePV8IrbrbzWFj4oButeaFkCWQiunj?=
 =?us-ascii?Q?ovv10pb8EtUgCFOuLVLdTQP1+at9p4RbzekNXkH4o+gejE0LzaoTqDMMsPVl?=
 =?us-ascii?Q?8UxTLcrwbmlPELIQoagXyE9KbO3wPq/4bAF80MzelCs3+15K4nLmzTBigsIK?=
 =?us-ascii?Q?x0uYF93HUyqDpUhXgrP7HY6nGN+6pvXejRdSL06Kp8p7ixaQKwv9rTlqGAPt?=
 =?us-ascii?Q?BoSWlq2l4ukvXJyUsIBtE6rl4q5cKpks7dEW9o3bK44SfhHva+HldI5A5uHa?=
 =?us-ascii?Q?sZf+7NndSvsQd8AK7pkfRgALBgVPo5NdXoFilecqgffPdEypdjCoBzpAxGV2?=
 =?us-ascii?Q?pQUzGINlX7WS7bpaWPA8DgKXZs2MpsbQ5zO8npKkweSQBoeJH3qZTH+H57go?=
 =?us-ascii?Q?Z3PZkeLHRUGO6myn22QNMPpQsFaxJm2ssHff9L4R8ZbTKVDq0KG4F67OxVc9?=
 =?us-ascii?Q?Pw80R/DTEi8Dh5cnFc1uII4hCU/SnCWaJHpcoenQu3NbkcU3499N71RxAU8w?=
 =?us-ascii?Q?yyrlj4axRfSvpML9IQBbCFL7O1wjRioNTxTAZfURotOdpS12EqyUJIbwXA7u?=
 =?us-ascii?Q?SML1nWuyzRK+TE2WMQ0Uso+VK6ORZL4RrmDnLARPYx1id5pVEF8mf04lZVX/?=
 =?us-ascii?Q?PF1bAvY/Xs9NRRJ7+qBSYN8jYki8L1eclZ/ZFWqAUtC50JGG0zKwKYqWRU43?=
 =?us-ascii?Q?dZbXlDLqJ90RtW8jeP3/Ks7xb6cXdbgbwHHZpLzeBgoGsLETwbPQ0suteqtr?=
 =?us-ascii?Q?KSUU4ywUq7hGoGOxGtwwNjQ/eYuRY5+gUNUTPPV1X+OzIJOAVXMVnSkBJeJd?=
 =?us-ascii?Q?32MZK3RY988BDOci3FczbZeDfx8d2XKyTm+E8s2U1k+bqDlEskoDHv/qvthk?=
 =?us-ascii?Q?NvQjBCFrTktouCHmz/re9IdFmDQNJxdfbaAPrS7NRHsTYkWJZcjl24uSf4ip?=
 =?us-ascii?Q?UyH3wVpP8gV3EfK3xMQyvs2sE6sc5i1mAemKcVd6P2Y9QeX2Teb0HeA/NdcV?=
 =?us-ascii?Q?e2NS4/qNEuI7rJGM+hNYy106rd4cGTeZjvzd68LVm9bwHZxIAutWduHra6rH?=
 =?us-ascii?Q?Yh80zCQgJxiu4JD/0iBUKKCI+K7ThTI8uXhzn0PGV5HAD3MrweIVYW74euFy?=
 =?us-ascii?Q?fxG+lhia4CTfMaUGrvDjY/QsnAG9u1RP99LI2tI15zuy3SKQLtZtivMhuArj?=
 =?us-ascii?Q?IeL+LkjvQ1CZeDh92d67e9ptFTFD3LnnBB/+MuB6VLQBR5Px6XzJjtUrzS+d?=
 =?us-ascii?Q?MOItkkBhe3Ra9sBpmPn2mwLS63UzEzeur25Z6GemSwiVVVrxfqBHov1Hjumt?=
 =?us-ascii?Q?gMWrlj1sIrHZfRT5STRV9rrq+xHGLyddI7KFh1kgEPxzNBEZ1cXM+OvZ6e7s?=
 =?us-ascii?Q?3X0GAo60raMuPLnbvLvvC9/SHmaZbmCwAcs16DIFAz7InQIFw7iclwxoeORe?=
 =?us-ascii?Q?CwFSA6prudAElVfsyPtmBsAg/jQV5eHPCojuqZVNm8UfWoHsISqEP8MJMdZU?=
 =?us-ascii?Q?Yu/CAurPQ80nGaxkH1bn+ofxgxrbKRGhMILAclNeoTi4aQzdiqejtRWWHXKR?=
 =?us-ascii?Q?24GWHgQsEA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602ade4a-6e49-4ff4-4945-08deb5936cf0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:43:12.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJmqw/eFGX2akn1MPxZNKDErdqrCXsX2wqBFAeU1SXRc5LuNe7v6vGIpzYkAWU2t4BiAq9T7YXQ6U7hVHs5vMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8217
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249552-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 9721057CEF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

The terminate API dmaengine_terminate_all() has been deprecated, improve
driver with dmaengine_terminate_sync().

Fixes: 09c04466ce7e ("spi: lpspi: add dma mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e201309f8aae..1a94a42fac31 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -647,7 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
-		dmaengine_terminate_all(controller->dma_tx);
+		dmaengine_terminate_sync(controller->dma_tx);
 		return -EINVAL;
 	}
 
@@ -668,8 +668,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 							transfer_timeout);
 		if (!time_left) {
 			dev_err(fsl_lpspi->dev, "I/O Error in DMA TX\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			fsl_lpspi_reset(fsl_lpspi);
 			return -ETIMEDOUT;
 		}
@@ -678,8 +678,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 							transfer_timeout);
 		if (!time_left) {
 			dev_err(fsl_lpspi->dev, "I/O Error in DMA RX\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			fsl_lpspi_reset(fsl_lpspi);
 			return -ETIMEDOUT;
 		}
@@ -688,8 +688,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 			fsl_lpspi->target_aborted) {
 			dev_dbg(fsl_lpspi->dev,
 				"I/O Error in DMA TX interrupted\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			fsl_lpspi_reset(fsl_lpspi);
 			return -EINTR;
 		}
@@ -698,8 +698,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 			fsl_lpspi->target_aborted) {
 			dev_dbg(fsl_lpspi->dev,
 				"I/O Error in DMA RX interrupted\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			fsl_lpspi_reset(fsl_lpspi);
 			return -EINTR;
 		}
-- 
2.43.0


