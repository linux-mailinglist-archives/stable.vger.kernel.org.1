Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAFE6F69B5
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjEDLTt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEDLTs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 07:19:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E126846B3;
        Thu,  4 May 2023 04:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxIJtLw0aN9bunpKUiuuqwyUIskJ9Qla9oiJrwADU3rxN0MPoZV69owMXRBbjvpsPlW9vqOwmbAxPOwqTpokBt5enpShXGoL64p0ArzlfUfm5Y+8BY4frMNCdxDAoR3j+tfM3gmCCx2FgDSEaMAGHCYa/Np7Gjb5/gbiTWcZge/yGhYrwDHOZS9AeqAE01/rYe4b3Gb5ozdhp6noiEskfn+pTAL2FPZJP6lJU2xHpiqqSUKwhtpjSY8uN4AfO4I5hH/yPjvGNykMWJZD1I9RZQYTNumIwimpSHbKKUPcJDex++HwhM2qfGRIwYJGWUKjp7Lunu7YXd1fV9Ww158XNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6v3wlsDaSWG+hBUbMuD+wwUdKNbWvJb5VGB4YLFOJI=;
 b=P/iOU6OoJgKvotYGrPeEDJXIGz0MUGErAnrMGvm+M+4Zu78hmPe6TPwJAQdCESDykxuPVbg/qmkA5q+BvhNnebqtU3iZfVQOO5yP0IAil3LUvxYOfzu+dd3IR9/8/HRjcBwuVa5THHQ3mfJroHJLrKgdN2iDaHfn7LaL6DQBx11nWe1L1NN8gMxs3wNHTBWarkk6ejfoGY8Mv7dDFsKju1QIymXrzWXiv5jSqa9HXsoOGqRsJ0KkAqvV2pRRbyIt7fu0p5GlxlpUtJFOwlLnvz9yrckPwub0vSwuWYTYK6zofA19LU4qGkfv7typDOP1OuTPWST5NQQY5/M2/mdNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6v3wlsDaSWG+hBUbMuD+wwUdKNbWvJb5VGB4YLFOJI=;
 b=oyrVgQg7rNua6VtbORwtZK1zC3KeBamCymMO8YOzXPwG/6firV3Z6lmRW5Rz+EvAyz/I3mLgOGlCh4tlH7VTf7nb9gTZTzoVVsAY3gFeLARdikPnOSowAMFbuvdJaxe8eIfoHaePFlNpTCoIexT65f0JbCShXm7J6HkNH39brzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 11:19:43 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 11:19:43 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        s.hauer@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works
Date:   Thu,  4 May 2023 19:22:22 +0800
Message-Id: <20230504112222.3599602-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AS8PR04MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c6237a-da4b-40d0-a072-08db4c9175ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tlDiUZd64T/VNlLrreqw12sH1r9enomeD6uItLf2KSIJJvLsniavCxjHZ1THxrD6gAK2+u1KeSLhziWCuh1/QOa+dsjS2vpJoq8limGn+XRIC831dpjh7RfvCqDr3LvBYFkNmIv3mmF6bAjD4Z7uPUaNctKOMoxg9oJ8/XGEpUZlO/WQJw35ycq4Jp+X/goa3SXQIVw9c5MG3qZWnMEbzO30LrYvHo/7KTYZBcuBjPj71C7umTxNmrBCBRBRCJh8HMSp0xGNVLz8B1DVgicHR52MNZfCUUWJgvs5/fSTurZYpKm+PkuoKsUC5QTW9JesUMR0zSnfhS5A8Hvf8zZeSEyB/npqo7B4Hqz+20Ol+XV9hMzBAytd5n+mJSq1hOGY539uwl3gmQMSZXmiVztvGE3/W79tK5iWDjudz7PSMB742AUPRQUseDjFMsLZOufCQ58/HsRR/sqirZwyeln7nPsZ051kFAXNNGOpC58CMl2FXqk8Gvxug6OsJGp6HCSjFEvLqIYYF5thbor9TgBI3Op4G4EjsyChgqmuZwLjNf3G/ZjPDCQn1ApgvgRZiOHM+Xiq2/F/UfEt92YOrx0OubgtWPME6QRrE1zihy+XJcMrbeJW3n25RcodMq8c8pu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(41300700001)(8936002)(8676002)(5660300002)(4326008)(316002)(66556008)(66946007)(66476007)(2906002)(478600001)(86362001)(38100700002)(38350700002)(6666004)(52116002)(83380400001)(36756003)(2616005)(6486002)(26005)(9686003)(6506007)(6512007)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/trDaaBgQlMBciS2UGkwZGrJcd/6a+aJUsGaOK4VBkvqJKb09BT5gt9pFDdO?=
 =?us-ascii?Q?c+AFfSB3Ul5PB5dzuqvynBVbE1BlcdWut/TJZnQSa2n3Yin6rOENoPLcbe7z?=
 =?us-ascii?Q?M7M+rlWwpstiVF8+po64XIG8Cj0rKyLRWxjDQ/rfXs9iOmN7K+vHK3WgJMDt?=
 =?us-ascii?Q?Jp4U8XKo1GbPbS9pr0CEF1cL7NL450ZNEtK5PoLhIX884oNiXsnMR+kHnFuB?=
 =?us-ascii?Q?Pzaux2vXd60jcpMDrR7PomsDmoCEWC0Gl2WtmvLMQ5ZQ5v+5K3YH7mIfyUd1?=
 =?us-ascii?Q?t5hN4QB+px+EE6naq+m8AWD0XS1dHUt60mmqNFOLgu4up52+61lpjuoW3rme?=
 =?us-ascii?Q?siMHM4HEh/VeGO9xS15ADFUc0f+2Ool1vM2GrayuJ27tVwZ6885vZy7g+l37?=
 =?us-ascii?Q?A+Fu5dmqNt71DKRCbbHh1NgduOOzTARvM6mdgA1tGB4SVAK3p+ePW5hpXGoy?=
 =?us-ascii?Q?rqLmTkdxG7OQNqnxOp92mLx3qsqH4CuK25VaKS0oB5vsaAU8RREErmTKJqUR?=
 =?us-ascii?Q?bKdryxdo4pIWlVsLRfoTQ/vgXbn+cYGGEgxSLRiLyI/aBnWos2pgQeSaQf9B?=
 =?us-ascii?Q?M6Nl+8mNf5/9Kvbw3DLNmSSzWtYjjM97Pvv4rvTNSW7nltGaqRDPvRWIfBuz?=
 =?us-ascii?Q?i+YgITHJZJXVS+PWd7heIgzGLVJGRT9hNcbqX8gzb2boyEvgcygmWgyDW8yQ?=
 =?us-ascii?Q?6CCWD7MMNzBVhCq8XIGQVaq5U8IUwrhAab9hLsD5dXRjzcgEArrUIoEnrJfX?=
 =?us-ascii?Q?Vbmmlu1ONbBYwTQkqHaCyvhtxG/VXbnChcKcvl0q6QNoFx7MX7I5tLPKf03I?=
 =?us-ascii?Q?S71ZFfxlNtMlz/Ekzn1bWKpn+Ewh44Pd8ossxyjcEH2k5O1uV70BzzMnfhVO?=
 =?us-ascii?Q?+AFSQ+yLjCBQWztu+3hfA4mAksFzUYVd4dTgJ3Y3v0qAXvlzPMP5LQn1XCEq?=
 =?us-ascii?Q?0Ee1tNWMpwloTl4rTSyMsD7LH/J10jOpMbvUcw08y9rRDnyUfW5CY8skzyVY?=
 =?us-ascii?Q?NNuVl75g1fn/DIkEFqen52CAsmSKsDXoBrnayMh6uxcylbaBTq5VyFk+Y7dl?=
 =?us-ascii?Q?xAfEiYgH8MsVE8LaXjyfTSEGROmpZ9BSyb1mxfIBNfEzTqIo3I3lBvPJ7B2t?=
 =?us-ascii?Q?kfkcy7QAuT/DiZhyAEHwjIA6Ts7nWk2m27OzIA3/cy3KsPcNl7xAbJPZHeHS?=
 =?us-ascii?Q?cZ3ZP5aQfASswxw5AQgT5pYX8+XIy2/BRHfWzEKZkPLiLIafDsCUrZl72mZ+?=
 =?us-ascii?Q?GieraA1s8kY0Z2b6JJ4Gt3Ku+dgcocx7lplaU21dAhk75AEwbKGuief+3AD4?=
 =?us-ascii?Q?E4AMX6l34oGnWCAUf/Uhl4Vd4IGDmM3DUqUiWtrX7PCeA7ar/BMRB4FdIxrE?=
 =?us-ascii?Q?n/vtWPsY8xMenQcCuQq0ISbGFoi3g7dlhnMqHc69g8/ip1UBVo27c7xpgwbO?=
 =?us-ascii?Q?XeiJJTPzrg1O7Jqz5l2aiImMlgaVnmoJMYdN016uPIyemDxRdufJ+x1o51BH?=
 =?us-ascii?Q?bYYaCwZ3B6hSC3swc6KUkfsq75SmmxUR0xecOAi19zrDpSch9qeH9hZJzk1p?=
 =?us-ascii?Q?DndnKVqkomyBeiOxF1tZ0fBjcUlv9OmKqsHTEOcj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c6237a-da4b-40d0-a072-08db4c9175ed
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:19:43.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnjuucAJg/kq3OawAJhWdCCKw7VHFsCGSx9+K8Y5MxLaxxSKepCoWiBl8p9ayADy+C4/qJD1WkT174cvIQINGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8897
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

After commit 1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate
ESDHC_FLAG_HS400* only on 8bit bus"), the property "no-mmc-hs400"
from device tree file do not work any more.
This patch reorder the code, which can avoid the warning message
"drop HS400 support since no 8-bit bus" and also make the property
"no-mmc-hs400" from dts file works.

Fixes: 1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on 8bit bus")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d7c0c0b9e26c..eebf94604a7f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1634,6 +1634,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	/* HS400/HS400ES require 8 bit bus */
+	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+
 	if (mmc_gpio_get_cd(host->mmc) >= 0)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
@@ -1724,10 +1728,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc_host_ops.init_card = usdhc_init_card;
 	}
 
-	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
-	if (err)
-		goto disable_ahb_clk;
-
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
@@ -1735,15 +1735,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
 		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400)
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 		host->mmc->caps2 |= MMC_CAP2_HS400;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
 		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
 		host->mmc->caps2 |= MMC_CAP2_HS400_ES;
 		host->mmc_host_ops.hs400_enhanced_strobe =
 					esdhc_hs400_enhanced_strobe;
@@ -1765,6 +1763,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			goto disable_ahb_clk;
 	}
 
+	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
+	if (err)
+		goto disable_ahb_clk;
+
 	sdhci_esdhc_imx_hwinit(host);
 
 	err = sdhci_add_host(host);
-- 
2.34.1

