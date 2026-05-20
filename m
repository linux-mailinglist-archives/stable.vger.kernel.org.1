Return-Path: <stable+bounces-249791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJF1M4WDDWoTygUAu9opvQ
	(envelope-from <stable+bounces-249791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:48:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F66358B108
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A2830FF826
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE0C3CF678;
	Wed, 20 May 2026 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rkDPKrXW"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C03CBE96;
	Wed, 20 May 2026 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270078; cv=fail; b=d5WkMS+7k0TkTw0uFRIHqKeAz90smoCXdhdz2Ykkj/MNpM+QOY2RtZAZlkw35HZqc2C42U1TCFccndgvvDM4PEl0lARGL459eH62UaAxyKNw3+p3NvcfVlbY0NyOvvUcz7BZLZ6qvLRDhVJkfCqIAM0tetUvotbPxyTS2Q0RVJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270078; c=relaxed/simple;
	bh=Y2npVWSSuwOv1ZpPkrnGA5mMelpcOjR4v8HrprCNuH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXQnG26rF/nb0GpspYoRZBtVUMJzLZ+kZkNGSrIPERdmdx5bGIJUK2hV9ezGMB188NkrsCNpU8gHedPbRp/qExetB3a38o7m2nJdcqPv8O3Vtev3xWZVcZW33jgfYWvzUB6WpDipv5z0llzLivDNiVBfrMD9zRFRfozbUwuRkdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rkDPKrXW; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ0BgW+L23FxnSeJnZiz6oYZ5XDt/y1vxmmQNB2AsDeof1M1l/SbAH2kkpufmY6953KAEDKzVXzadiNRoz000Nd7QGT7WZGnEz1iqCnX9KZB5/TRC2xRBk1g8/tfwmnYJexl1ZNTV+ttQZ3APdbqW6pANrk+nn2jvkHtINoqZ/P1famvJlSt5/vrUJpIDstr0xPhtzDTSuKr6F2kkTMjExCFqKGIHnKLOB64B/OaP+ENuvQmti8w9tUBh5aF+yg+EulZgMZXnTo54cllrqZV5FUfywvTPXY5kf6lTv8Jhsdel53UmtkwSteG6HZWnbw22QWWKRRCRzquFBaXBsCjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kacCqFgP/1OL1QiJ+PYvmtLpqyNkt5EL4a5VELenXPI=;
 b=Y8Mpc7AemfP/wQnM3Wr9f42jMeL/cEMKZQcwB3bRpcXU2CCRnN9ZsyyGBdNOuxYefXMdf6gx48j3f+0WlhEKx4OqMrNtN0+e3mgJxyUOtXTeHGuEKTJtyYF+vt2ufN4VA9jFgcj91GeHuGgutYz9/C/YWQjeUfj/nUlV6INWGj5vSwcnHUE6jeOYBQ8XZKMZMjRoecdNzyminvnPqXpsb9ppB0OcvbyjpYco/SPKwmOTGyBZz6TCh4onV2FU+RZKhBh9EqhtyhiVNCQX2tmfjZgXuvOUXfq63mMXNMKwQ+AGOhswTfZPi2cAEMNlUGTzEhB2+CqWjpzOJNEwNf9+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kacCqFgP/1OL1QiJ+PYvmtLpqyNkt5EL4a5VELenXPI=;
 b=rkDPKrXWglpzlbkroHrYsW8Qle70R7y2QJBX0uxxO40YoGGu+Re6FabSkWKmynZueJTWNy72YwvJR/lV+UqSUeALhyGHKE7FWGzzZro/Q2EkN/KAF2xWHMm8zW4iLznwo1HAY9ibLAVVC0fYLs4eSldnUNXXxVnKJpUjAzqraVvn4zU+GavZBnbjxe2fLShA7U2teoXGXfe24d2pHt319mUKtVo6acmIzdQlkTq9ktLWKSO1ZsvN2xaoFXaZM/gwr7gxEuYxllX5Wif2SeUwSmZPUSouWXpNN5s+Hr1VYnLdU1OOHCCX4wxkdwGmNCKjD5bfaCpc5mGoEuqGkTeDww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS8PR04MB8531.eurprd04.prod.outlook.com (2603:10a6:20b:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:41:11 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:41:11 +0000
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
Subject: [PATCH v2 1/2] spi: fsl-lpspi: replace dmaengine_terminate_all with dmaengine_terminate_sync
Date: Wed, 20 May 2026 17:43:07 +0800
Message-ID: <20260520094308.2882892-2-carlos.song@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c878817b-65ea-43a1-71eb-08deb653ed0f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ESid9puNMqdxV1qs0l2jBvZtviNLfzrqGtk7S2ZGXEB+PbSAFlqX5cbJjI11MI0TW5KEKgfV7fYuF6O8KWxoYR1cKjTvAuTMC7AOlMBxXXx+RZFrx4RfnhdtDYZ/ljyVArdcema/a7frDWGuLL935KSazwCqeCmGvajRlTS+GF8zuf7L8ESsy2nagPWjVwVy0blvfcpHgeKCFlzOUKg535xOC+WXFRdQh7SFi0EowymkjLpSATUgOXWfOfgXJjcyko9gYvBwC6MYBNsETPXkOD5lhU1Ojhy4kWG0z4QSvhLRaGxLTtPtH8OcyQqc0Ky5MId4Ovk1TizC25Wv+SKaWUqkGEjiyhhLjjdttE3qmPV6Vx7A0zRVa17a0BBoApCuvomBV5sQnkzce2kDdG8vewm0N0dFX0Hclk+4wh0qA4ZvgC9dIX6GelLGDyi4zZDZBJgCJNZ6t8aKs5527Y+fotvh/4JUdeJaXyJoJXPLTFruPcOJs00rELc6h9IRRqRAVvTXibbARsRCX3/Om3GQydn7PJGN3NgfVAdnbSUHVx/K9rHzZdMIXWkk4If4IYh/39Z8sne1Z0MLfZ9avrlqW5pnLYx3gMGa996Q5oLpK6pWq3zqsfAJ2qouuAWNCYYvKkPgr7bSCFdf9qGtO6i1q3Bhdn0eEe7I6hEeSKkY4zhd+deNFO/Sa4Mo5Va5cXw0DdN55OLUp/gt7M1Bp06YyJRW1l/kv//P71OcQXMDJ1HZiRT8ERuS6ix9s3nxwGrA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6uv22T+nKSbdgV8I+FMH8wGoAVpsFTdziwEmvXKQ8hHX5zkIsIBbnLrRo6l?=
 =?us-ascii?Q?+eY72TRlRo9IAg4anMKUx3GfAriYEezxLKQYjZgEGSzJFpEL1vSS//P7nIV3?=
 =?us-ascii?Q?VQlh+njvM5xGo+LmxsyOCyfJjfPlkc6Jup7o6acV2R3Y7eSkL5mkPaI7Uvj2?=
 =?us-ascii?Q?LUGYFmssupgtHRRWjArCd7nLPzuDUgYwdWkZFD0A3UMyoeG/P1cuto8AvV56?=
 =?us-ascii?Q?v/SqStjj/q62yca4bPQXw+wfN/DQYch4VV8RozqLfwW6NTuZ+P+IpL4QTEz2?=
 =?us-ascii?Q?PxlJxLDoovWI4ppNUiWFsOG7yDjvdDuofAzXjoA2aaubYnlsQlCu/AFxcdca?=
 =?us-ascii?Q?tQvSXq0dJFK9BwMaZgd6dIa6XbkKFXL+tii8IXLR7suKKIL3Xzpht4peUSO/?=
 =?us-ascii?Q?g9gBC9c16eqmLsjTckS5j3WvGFMypfKHheyrsgFbVio3w46WRAS7HLQHSPU5?=
 =?us-ascii?Q?OBZdw/oI67f27mjdkHUaj2W8vAx+clQZHiHKynHDawVkH4Z4KlP+f1EsQe1s?=
 =?us-ascii?Q?rDx2CWQ3M+dt0WcQoR66IqBcSLWv/HjazaiKAqE6cjttAzYR8ba0uamOCh1f?=
 =?us-ascii?Q?xBQJJ7oeTRIdxgupkycIKWMQjTaGSisMKlUvDRXs9mEaK/WQmW2lGvxQA8NI?=
 =?us-ascii?Q?HJwXHpnFROd2b2lWs+96fDlcGAeLLs9Oy2MdKmJ1lQZdwjYfazq47l/4yNAM?=
 =?us-ascii?Q?FlxkeA06CnmVgT3VrB2su7NBlgl+Cu4RCRpqRtMGJqBLINBVpgjqyzN0rcba?=
 =?us-ascii?Q?x4jjAox+IQtGcGT7bxODHUaSdXyuZFw0+lcYKTbx1o8dvhARP2QqfsUrRfjL?=
 =?us-ascii?Q?+A3z3jPEjY8joDy/6q1RRzvSgjkKgVr1al5tyLciPTujN8acyGP17qsO/1J/?=
 =?us-ascii?Q?tjPmarxk7sAQ8powq+nH39ZltRIrGuWfkrT/Ic6WrbN96mwfvcw42P1stj3b?=
 =?us-ascii?Q?82EWETL9kZIywqaX1pRClioS0TlJ7MIRuoTCWoU00Xt3FxYTZZKjRdVAlVoH?=
 =?us-ascii?Q?pIeuVLUA+wz93vmOMuteMOLsdQNpF4cUFutRoQZDhu2xDiggFFIUJ8N73M7x?=
 =?us-ascii?Q?cIctoWlPFk83tTDRVqUS2kU/c73xR7MvjpH4DDGreC93iKN35ThA7B6ntIUZ?=
 =?us-ascii?Q?OJIp5yukRHSIzyub40M9nqHTOn2KBlYMQLW5F+aydnNbYxONg/sAbE0pbj/v?=
 =?us-ascii?Q?HfIkYWzN+auubTVCC1I92ZRdaSVvRTXfifTZssrtPRuTOizflZTvHLlFlxRC?=
 =?us-ascii?Q?wZygGZBVlQR7FyLIDr33AC2Jeo8P20ltiwo1G4t+CSCfNx1AfWKIhh2hcrI9?=
 =?us-ascii?Q?K+z3EB8NdhXGGv4GFbO+AxvEUgxo4fECTUjx8pXdjdg2lfQDauUhiqjmatz0?=
 =?us-ascii?Q?d+xoLr7H8ft8ex5DSwB2DoSboPmETSxnB204BEbmoe/PKsGDFJlaOnXuVjcc?=
 =?us-ascii?Q?nB/cIsjGYyCxZWAxw8rdL3HmtVlaGp4o/wisadnAJcq4Pv8hEGBBfvigAjUP?=
 =?us-ascii?Q?IY6jxhectt8cQ+kLXEzMUEbAXyE3nOUTw9fhqmChzw1O6JojCW+cw18tBnfq?=
 =?us-ascii?Q?ZOIO92imK7nsnB1nf5e+KjcBw9jBiE7zFCrNMTZi6Ev3BWjtoojNvvJY5zbf?=
 =?us-ascii?Q?RyWIHjI1edHiA5pMJhYjjP6Sqr4hS6/k1Wr6lGue4Q2jJGnVdDUsyFb1FfCL?=
 =?us-ascii?Q?aC1Mev9iT6GdouKhqkszArNjwTUAtFY/qg1PXD6gihwY49DurLtlqVQ+PP5J?=
 =?us-ascii?Q?lnixL9faAQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c878817b-65ea-43a1-71eb-08deb653ed0f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:41:11.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0zl1N0cmYu8S5kPeg9sWk0BS0H1S0viJcX3wQVbRvXD3keLcmGyACrF/nlXmA5eI06SXpNALzdzQUn827Asgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8531
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249791-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 4F66358B108
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

The terminate API dmaengine_terminate_all() has been deprecated, improve
driver with dmaengine_terminate_sync().

Fixes: 09c04466ce7e ("spi: lpspi: add dma mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for V2:
  - No change in v2.
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


