Return-Path: <stable+bounces-254090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDKSMs7qE2rnHQcAu9opvQ
	(envelope-from <stable+bounces-254090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:23:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 837BC5C658F
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 963043029A45
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89E39EF39;
	Mon, 25 May 2026 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vkA150yd"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23E39A800;
	Mon, 25 May 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690123; cv=fail; b=icW5uqLk7jEVRgJ+jq+LteR0rbj4PYgNf3pDOww8iUrIQ+0tBytiWbinWKJ4CHmmzZOdfE43wvLvWD/5UhXqMHl2lj7vWTvLTzkySOcPYTCNkrkN/kn4DUxW22LbrhrQw4dnfFm7O7JGI0SurceZ8lPlbdsPtFykYUDEX1wz8SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690123; c=relaxed/simple;
	bh=dCImE7umPGc9ytdss5zXZDhBXhB3KCXF3P5ZyZgQbn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PObvWRx09uPlfzcymUKQslNI4FckVagk1Cnw/xr8mJOmGQNOt0EjiyQT3AzeuHpW65hY5JwcRYyLy0DU8TvpaRKUzt501Oz3FPG3v+xbJbD4D8sndX8Ru5idSod0vzy2XFWBEY9Mwllsv4+jLO07bHpLn/GnCmLstrtox89K544=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vkA150yd; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fkp7dCGAlLpmogMtlet9h9shJmjGGarzjaNIXHqQy4rgfPKkkt7rurvdmU/QCZabNyfQKL/eOBCvoZkjs0ayzoF4gX3C/QkpdcIjD7TQCAeps9nNj033s2c5Ew0f4O9+dYQD2QTOIFRGG9r6nWxJAH26KTD9JYqkVtKb7ghVHSZ6s+/H3Wlukn8Unhx8/bL0fc5yCwrY/rOyZ0HhGQeIHNwxn+d04qG96LQ2tsJ5mZidTZObrWZVGRF76hmYUrC0WCCdXCOOpmCm/WTsIxHaAEjATIkY2WPpor56Z6gCm5v0aGu9U/AMsNP0cnCcaAtmCCooAjoH0Wotw+gZwWt9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHnJ1r0/PoJ58keZPDJFr81eiiM81qKUiV4VcLoPNXE=;
 b=DCcC0yXmeK0lN4bdNYokyquj7WLAdZGXHTh3cG2hSVp471WqESLEHEZb3G6fgq1Kwj0cQYNz6FjBqATy4GsqyWC8cE60PJ/V/X73b99WfmcuZerBkg31wXpE2ZTTJ91KJlktdrwon3mFMaAp+dkOKGwE0rZwe1wiGG5DrkI8iIRoe49As07INWlR0e/EsodZwmA8x8tUc9zf969o9yp+J5ZJO7gQ420Ml8dyN3ieEO8+Xp/Hb40RXBguG2yDhChOR8JxToxcSwFw8yiNwhYPnpdU68W4Q4e4l3hZo6yEQHzZWLLK9r4Bvsyf6ZfCvI4g3TRHX3VRFGJkz3klJ3TaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHnJ1r0/PoJ58keZPDJFr81eiiM81qKUiV4VcLoPNXE=;
 b=vkA150ydSmd4eh6EBP11ajT7mvN99qPkoesIbbLxNYtX3YgVluQ1rWMxzFZrfMmMUt7ghuIzdzPQvtt78B7+EXJ1fkQnpsmL+oZZnx6jSMK8/nP5c7YtFNmGTwYmYFUaE9T9KvbqVHedL4Rji8Wpr0KjAGKn6lutnhm6jZZt9aChenQCbHUCjjyN7lsv78XLA1hkhfoPGdB8Vfo1iv1gSnO9EwNRz7fLjCytAVvxcSm/FjOhhlgaA89XFIpbT6y2yaOIlg6JCEEyw9ZdMgk/iOIveOrvdrBXrvA3P9/xBkK7A+JHKTzW9LfrDSo8eRATvFrJ1p4RO83BwRJpLAzg9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AM0PR04MB11930.eurprd04.prod.outlook.com (2603:10a6:20b:700::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:21:58 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:21:58 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	xiaoning.wang@nxp.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] spi: fsl-lpspi: replace dmaengine_terminate_all() with dmaengine_terminate_sync()
Date: Mon, 25 May 2026 14:23:56 +0800
Message-ID: <20260525062357.3191349-2-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525062357.3191349-1-carlos.song@oss.nxp.com>
References: <20260525062357.3191349-1-carlos.song@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P309CA0019.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::29) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AM0PR04MB11930:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b900f60-2256-4bf0-9b77-08deba25ecd6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|22082099003|18002099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info:
	e32X4t2bxOBkl0u/iXkqnVJN9Lp2LcrtUc1ElOrgf8VVQp77ZBpynDo4+lim8t3gGAjddYBjwY4moAygRLpP5Ayq50KVwBAgXoe1ytbBuKzkn+xKcfhLuzMxrdOcU6csKHgz0BP90xXGuUoQnxYrX/5Q6hXaCeYknWiHJaIreSDwGVFYeA0dIeWFDJlAtS6C404FgwCyvTjRYxgCxISg30RjhN9Tvgs9fF8M+nzvGsnbRq2/CiFPGeNfg0HHpCvpT9k/cb9uj3dQbfqW+HsCGpr2PUoxnaNXwq8pZdTJsuZjNB3t/hOLiHdanvIywPgjnfJP4VU/VAc2DWh8mZKPmGUAVIyt0F6l8PHFg2Hpd01y19yFpy64fABLxYAqRnuIcIEKQ5C0Ti4HYuYvUj0DIUXEi6tIJOSpeZXBe3zqESik05s0BMFLi2VWzbT5FIQC+dpNaN+1y1oBMQ3QGakhA++VsR6F65l3R5GPgYhEHM1hwuvw2JLRlfB6GKhRl4+J5PaVA23cptU+GhIx4B1uofZnJYXuqgQN/KuSlcCRJsgKH+Dd4y2bb/0zARotZ6LnHluyrWyjzYJB2o1KSWt10sJousY+Txcb6t6Ua7/0omYnWd95kZBu95yD8bFdoKKCxSKbyv++6JRBdFnN+Sd+tREiNz7GNrp+tLk/9C/cXsoyKQojdbyl0DjGjnWYDKlI7o7g2szDdNt3yhP6pWtDW5+g+baA8u/jLlfGeLekxrA6It80QFvbQiO/U2R8GSO1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(22082099003)(18002099003)(56012099003)(38350700014)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p42v3dClikpi8+qCUEiqSB5FPOBmENKiocowG9+M9ckYTV1D5CKKYH5YTKQS?=
 =?us-ascii?Q?jOpqgtZRyUf6q3V/ekxZz8/bWx31uTo9ni9r9ccF/nKia/nPL288lnBo6n5F?=
 =?us-ascii?Q?/G9ay7SsBYH413UO5pyLKrgiIXZELtleLGEpP92fptQIUbC+ppXo3kWPltix?=
 =?us-ascii?Q?2qO/xYyvWtMeLa84k88p5p3dlxvn0wSgupr/hGy0ZXji/nPpUDKpKZlJ+ZjV?=
 =?us-ascii?Q?N4oNambK4B+aQ6ULIAKxFqbn/HPcdUQGmU21pjGDrf9Hb/ivKeeoXmB7eLGO?=
 =?us-ascii?Q?TnYci2lWM49vnIaMZzKLzlWbs6Pr/q8xFo3Q1s1pRoK5Y444YEiL42w6uE6I?=
 =?us-ascii?Q?v1E7OHuEvoOHn3Rswo+JFzcP+9JFmcUSFPsiWCMPi6E/5nAG/+X5XJplAQe7?=
 =?us-ascii?Q?5K+QPLHQJzNtKd4ephf4jPGiiye3lYdd4xtQpBKkK9TUkhAQr43r0Oq2xj82?=
 =?us-ascii?Q?9mgDoKI1iv8F2Q+jU3DNQdAYbF4xgrdi6mbbSPcVORGRxCvV68Ggv8uJ03JP?=
 =?us-ascii?Q?vLq0uyUguW5R/u/5WhuTZ/oS+tDpZxESgX7l+HKckjs1VchLy3IDhSeYGXXJ?=
 =?us-ascii?Q?FHDrXhvyDA95xv5tvaI9MXDaCXnoAJkZHAwQJpd69iD00R1TEsj7MbrFItzu?=
 =?us-ascii?Q?dRqcwfT8DaZhBOuCdFbhfuESFaCB2ZLncpHIT7qsI/9NZKlKgJIUnbFoVVSV?=
 =?us-ascii?Q?70vgFxKvLWUJPbvq6YWv2zKhKsZCfLdh0vz2wI3350gJeRDKRkXpXliSYPH3?=
 =?us-ascii?Q?7TNmypLzklrUt4IZHSKUSjmnSbfmrGFqwfc/vMLpaYS5NlYOrXYstZf423mc?=
 =?us-ascii?Q?snE7OJfX6X19pWHZJZ3GtiuRnTYXOqj5ygkv5jCBm7B5twHJJ/hgoB3mBohK?=
 =?us-ascii?Q?SUi9QPbFBYhwuRdj9YiSdAx8oepPKQlOq/rJHWG8l5dIv4q6XgSDMpLy5Tuk?=
 =?us-ascii?Q?6a74IIb0xysBwUgBNiLLuiUMkb8YPrBVd+HQ6V+hWlOLitA+zg4QoKNX71Cj?=
 =?us-ascii?Q?GLzbL7IquOsKseaUIGZRN33txyer+qanBRhjbCPSmDOnxGYyzTov2p1DnPxZ?=
 =?us-ascii?Q?D4U/IEd0aHokP0gy0DUn6c8kqxuSqUr3ZD7ujv1RnmwvzVWrX/RSPW71SfRn?=
 =?us-ascii?Q?XV3iRlEiebNE1L6vVlRLhPv6khqZ46KJTViDJOzfkBvm22r27THE3vguNL72?=
 =?us-ascii?Q?BOrpRDdn8M3QqMAoZGYcP2lFn73pspitwsePzCE4lWB9rRaa+f4gkcoqQg+V?=
 =?us-ascii?Q?W6p68ONBqjbXbY9Y8kZ5XaXkzi53++cChWgWDyTG8amz3wksxpHEzLPxqJCx?=
 =?us-ascii?Q?/YEQ+FVlIiHsZa/5MCH9sQ00g1BTUp6JGAay7Q5oxHzi61yLJKlsIEavmQ/7?=
 =?us-ascii?Q?dPPC4K6MQV4LmVitI+0v9//fHwZ5UO0wda3IJDS99IYUR7Gjd+EIRCSeHvEj?=
 =?us-ascii?Q?HJNjqPlLW2QMoBN3Za5QPxylZCKT1zapcqaeLGJ4KqBb6hN7js0iLEfi9Vnu?=
 =?us-ascii?Q?5L0aKa09j5FQW5xJWTCp904ic+z5VYzJ+09Cuco81sqIS3gOHY6CIirw77qh?=
 =?us-ascii?Q?L05DD3C4gFOEV4+CXlv7Dp+MAmI4E5T0QHfo2h89YpfIToVLMOTUq8vjrOq6?=
 =?us-ascii?Q?Uab0tqUw5kU/JL4Am6isEzanOcsVpNIP3B/GBnGAs4CrpmPWFSgZo9rUqNm1?=
 =?us-ascii?Q?tacPc105pFthYyWi/8QnldRQoa8wAvlCYcVKM5Z13la0MYB6oJhnZtfAhxY9?=
 =?us-ascii?Q?qJGDDnQHYg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b900f60-2256-4bf0-9b77-08deba25ecd6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:21:58.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGQlTKrq2kGqMBDTK6HVB5lfPGdGuMv1F45FhXAuWzd7CFwfOHLhGrn/CdGf7O26Bzp6ljg2FXCxVCBKmQfFAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11930
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254090-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 837BC5C658F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

dmaengine_terminate_all() has been deprecated, so replace it with
dmaengine_terminate_sync().

Fixes: 09c04466ce7e ("spi: lpspi: add dma mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v3:
  - Fix a nit on title from Frank's suggestion and simplify the commit log.
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


