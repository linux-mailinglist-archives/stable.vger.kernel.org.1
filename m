Return-Path: <stable+bounces-116545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5180A37F1E
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B746188DC59
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544DD2165E8;
	Mon, 17 Feb 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WN/1dAer"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F1216E3E;
	Mon, 17 Feb 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786185; cv=fail; b=IWtExSqDpCQjsoLlF8RLtn2qLME99tuKTKclNn1R2eHyhtED3QFrKdIJN/7d0vHU0oYlXpi2+cbjlWejet0q16CibSZIPplBtJBrBEHKRfwXyRJ0oy741UOvxMdAk8/reSdHihx8924Ye64pDBnou8LGVn0fmmvgXekrraQzS7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786185; c=relaxed/simple;
	bh=NC4cD6fXHCZtwwyqBsSHtze5eBF5+SEz0zqFXdLlFoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SQmpIeKcFct9r8gT50gY42cGi1adcTAgt8IMkoxD66gHhO85VxSwyRzcqirEGwinhx2t2mIeAI4gRytRPJ/EL78+E7QhVv37y76S2RgmAtO5T5bN5mw+rjVRb64OpxiyqJmA4jjJUnPjL/zbKpFhWeLKZy1q2COJNUqsUouYbMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WN/1dAer; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmaUGMcDPX2qxtN0gcNujz/ZWHQmDtZoXNFCXyUWJR05k0Z1O4pHUGLZOpbD68oVxtL8ZwFPSOQ4KtWJL1hOfNoXyNFIh4Wt+ltowo6EjsSpi9tXmIMv6jBtcrMOBB6zZ4nTMhS6nFz7lmAmdfEAolxzzbQZiBQkqkYAVu/PSkeFTRB17w4Sd44ORqmXqjLSvK333jkhZilL7MqVyvmGIoazM6GwzZVvvwmmt6Zp0yxTaybXEjFVGaB5tW8gUhTFe4YvG3ujPMoHqp4Ux/TPIb5J6ICWcC4KZBydIertrjD8VJUIqFRy2dWpYrR5Je041/c+yR3j58y18niDjMe1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+W2qWrp7eBR3WvFbuONn/JjTZywSDRz7TYEXAbTcwU=;
 b=x4KOtnQkQjHhUYTLYJPnzYe1uGKNPm3B7igkkZByv2V/OABq1c5doNgdoiigZc9oPT/xSF5hKdSIYC/qRO3stP8U+SivBIDpK4URdopW6zEZtMg/k6LwWiAxukRAS70tXMJ47QFqg+0+PaDD+WDk6dF9yGfZHzggi88krg3r/3VYdJWu3sP1hLsKtg42+AhomlSJ9sajkMEGLpK2y+toKDQ8IqGSHKGxjGTTbPj3rI29zwJyyZ5uC/PLJPltJT2uSjCQh7+C/fY89YyUbrw4aScbwzdrRPFzYnTklXbmGaCXjxudbwR0FxYJZe53QFHa2p26pCmHqCLTE8smJuHx8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+W2qWrp7eBR3WvFbuONn/JjTZywSDRz7TYEXAbTcwU=;
 b=WN/1dAerw0pY1GxPBCJgnyVxHczxJn21syspbWLQPWEZjZVlPTfHYE5bcyoYE69y+gJBZqFwCx1AUyutaYLVHjztgkiZ7nIS+WdrHJyE9TvQKs883QN8mZK5nys7q60GEe4V8YauTITXovWXa9iOb77tQvCgLnN1zJodY5N/y1G6BaAtk/941AtOs2GSNF9wIo3EJ7a4m04OMYlq+WwzHk5bVVdlE+Nvbj0avO1V7uMPPZSVOoh84q4dZlCy/WwPgdMwP1FoYk5X0Fu1W0s8fQdrdD0wjvivrJS1gUENh0sN3KLr3zlTqn3BJ1wR9agOs9IC7IGiXNEZn1rEXaSOJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:56:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Mon, 17 Feb 2025
 09:56:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 1/8] net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
Date: Mon, 17 Feb 2025 17:38:59 +0800
Message-Id: <20250217093906.506214-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217093906.506214-1-wei.fang@nxp.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a89c326-333a-44f1-3487-08dd4f39537f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GqTs8OWR+AZyJE9vS4GEDeJ69rAeJ/foytRMHRBbz6Anx0+GtNSfaS16rg65?=
 =?us-ascii?Q?U0kUIkSoK3DvFWdPet1rQYjRR0RpYRYiCcQzZYCcPo/CvrpOANMQI5kqH2VV?=
 =?us-ascii?Q?YhR4XEbbfHlYHaPULa0PoeBC78oVFGaZN9GZZhfxW902Ir50RhxfC02CBYie?=
 =?us-ascii?Q?gycY7FicolC14cU4x/Z5Z3DdHtHSPBoOzgdnwps089OUxfbgI9dI91+mWS68?=
 =?us-ascii?Q?zImh/Z7vqeZXbujqQ+qV5zpAGDAn4fehV2VCIDIl6n3+sapMltMGiw4WiSqZ?=
 =?us-ascii?Q?H9fFfrkdj+XL3kkePdCX7Xlof0q5nsLnvOXtR/PhkjnMkWBdaBQCfj1cRNSm?=
 =?us-ascii?Q?5v3+j1+k28WA/GICVvM7Iz0KMB+1X0a2v8khuABhY1HioGm6Cn9vguaKG/WH?=
 =?us-ascii?Q?mW/CM9VYmI9DKWccze+XMjKXBeVYwXgd2xPbNyfEI+Q0Q69kVV3WkHT3NgEi?=
 =?us-ascii?Q?uDJ/jN49Q3MvVM+IvgEEBey7yYhThYF6FD5bnDLgrmY53l/3QUM6rYkDiuAg?=
 =?us-ascii?Q?LbPGY2lHZYiejWH69xPd5rmChui8NNha8GjDMjRmdusgO1/OVMDZPC7wuXQI?=
 =?us-ascii?Q?wzuMX28yCbQ2ga6OZJd6F4A3KKMMUEZztuT8byrydL3FFmcqNaxK8NqleN+s?=
 =?us-ascii?Q?VunZl1Xwmsdodj3BOfBohijA3HV0+QaRlHGrWq/AoyIPX21jebiGp/li91yB?=
 =?us-ascii?Q?9eqQkAnc+WB9WDGFdnT0IjOCzRux0UeunQOPt18Ris7zXA0PpA9UBwH92LPl?=
 =?us-ascii?Q?PCYeD5sJ22LubDOgLSO/nAryo5tHVS00ngr/QDNOnCCvREPLVYW5D3XMoUXI?=
 =?us-ascii?Q?19rQYkCBuVgM/C6EpoZLVxQLlaOlJL5Fw2zEwV0YhfVBD4GHdcRb3KTELC6d?=
 =?us-ascii?Q?PVA6mnlaGwhyoFMeTCtBsBkMmYzAjqQebRgfa5U/Pk71WBDZdLXUwwR4HPZl?=
 =?us-ascii?Q?NfSQxV8pFLuvhUdiablbbdA/UYVUg07+xFAXs0dcOWbx1USCIQCClOzJ5+R9?=
 =?us-ascii?Q?W8/oT5dHrFpbbIHu0I8xnlZ8hj76SSCZP3z3TCdXUkKtCxfMgf64lWB2ugn1?=
 =?us-ascii?Q?H2foXG2WA9j5OcfotlmtvFkZq66Hm58xBh1zLzd9SNuX/PIKjyaK1hTToStU?=
 =?us-ascii?Q?/1Hmaq9vnkHcv5kefXJnZBew3un1G3GwqFQpsyH97m5PyR+GcFavRY4x8rXd?=
 =?us-ascii?Q?hXpGxIcG24xhvIlmftk096QHJ6lPw8cIy7qXiR0ZZdkYM23NCgvf3USjc+NY?=
 =?us-ascii?Q?bFeCcrwMQj/is7DV0ogPOMpSq4JR2mvhvSl1D6soiVaEvm6GN6tfFxsGDs1b?=
 =?us-ascii?Q?YF4jnFb5XWptcG1iYtBBJryXJhjfgoMU93QbqhxPHqa0Wm1baNh2Qy2KSzFJ?=
 =?us-ascii?Q?q++6yqeBBqXxa8TnClih2GD1a1g7Cc36QImW1UcxWzt4k3E1l6yh1btY02m0?=
 =?us-ascii?Q?PqYnqsu8mD4dd1KMoaJV3QNF5FAnodNl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g/byT601fNuKZGxe3m7nOMOuizpaGGeUSJeUoIjSqKvxpJEr+nzp4vyRUDqv?=
 =?us-ascii?Q?tfKZCJmlCEDIRC6u+cm47b3tNqfvJNMoSHG/Xt0Nx9VmNw8Q4cPwhOdxANKp?=
 =?us-ascii?Q?WhjcD/qZw5BdYPsbtUNbQJePeQ+vNc1z9lEvdnVhJunOqrnpLG6OSy6cKe+Z?=
 =?us-ascii?Q?Q3/w4xxTWBkOglULaGKF40Gz3s4LrrNDE825YjwQ7/bZk4DDhIvz3zYRp3gj?=
 =?us-ascii?Q?blBZd4GWkpy8pcQZH6yHBtdDlfbG+aTeGm2n77DY051tUyuGCGzLuT3JlKfS?=
 =?us-ascii?Q?Q0pufXViNceDcRc0v1nthBtuSKOR7RROfvnjevizTurd27gmtRUSVLfUg/jP?=
 =?us-ascii?Q?A4VwiGcY2sekHi4prMfIrHUDhH6n33vZqGpMSpALvq4CTDtyAe8VhhHaLQu/?=
 =?us-ascii?Q?9BhVwN7TIWJABIggaBsUK8jlGnE5r037eQjhz7o8pPdRY1jU3v7sAdbnxrHM?=
 =?us-ascii?Q?y5L+0+7h1gjDDC/u2hH71xI/bWDQRWf5mXEh4H8Q2IhQupjhvPHjPOm0gO2n?=
 =?us-ascii?Q?O6q6FDc+c3WSgUC4DgKO4z+q0e83OWLhv38fD96dnIwZCV/pF1J0hyC+3qeH?=
 =?us-ascii?Q?74g1kPZSojfqezboBMsnwQXg/DVXLoXfOA9S0Si6XyMAsaHvNDCZl1m4QAy8?=
 =?us-ascii?Q?tZ2qmLcA3VLIrcoJtBk4z9hU//WaUngXO5aaUERAvHNXEuPjZKbyNrMblcHP?=
 =?us-ascii?Q?mVPJwoiHniulPCg19b7X3xbUSCCqAFvluhKVl6tBCYux7X5lCCvmDudIIrbO?=
 =?us-ascii?Q?eRz0sHDbO0cOMKDNO+QCJr3bq/8jyeH96VjqDoBgpIvD15coL9WIaCiexGVf?=
 =?us-ascii?Q?vm8cp5PZ2KHPm8IyfBVAjmiPqhwzQ3Rf91qjC7A+pbcJF4y2+63ttKY7k/X3?=
 =?us-ascii?Q?wjBU5iViMYdqRG7fXjDUD/QdGF81w2S3cb8u5v+qnlbNV8LFDZW1KOKUnq9J?=
 =?us-ascii?Q?ckz/GWK00vda4BqXxKq8L70OA2Ete+CUHVFCXOnPWggD1JBuInhKZsOZU43I?=
 =?us-ascii?Q?3bV2M2PX8cwQqa/K+Ui8nSv1/DEYk0xnRybYVjI/tgurpP/vTRbR22ScqUwM?=
 =?us-ascii?Q?+9DE1295/mIM5HNeryI1Uoj+MViEPCDxuDVknQkCMnUIIQYf1LsaiBVBjYOH?=
 =?us-ascii?Q?mHRVpo10F8FdF0L/IWP5IkpVvJmAqyLtntsPXoSzk+7nIu3aXx144c2cdfFY?=
 =?us-ascii?Q?Pp3soxmFWHSQFTVutJSepnpUzXyPsUBTYTne5Pg7P8Yq0GPfeU+mW2YEjhLv?=
 =?us-ascii?Q?H8iZIfxIN1a5DOE2Wc7bkGwsjRP+iM4l4DT4nazkDxhdmVASYN1iIwORsGUd?=
 =?us-ascii?Q?gmbpeRD96n4l3RUBH43279I4HgHNKCkW064kEyqO0iUyj5JxoRpe4uWvjCTz?=
 =?us-ascii?Q?d/mB4KB21EgIt+cvX+zM5IY4V/DiJikCgDCNi3F52HRI/nFakv9EHbpcRal2?=
 =?us-ascii?Q?kh/tOYtc3/wZ4jTkzrwZvuNxUuRojvT1wXNDyve3wszU8z1yhwf0bqFYsw7p?=
 =?us-ascii?Q?+bq/n/GX6fyJCgQ6G3ysNwDAIwrje+kaQkZu4NltKg1CqqCGNzSlcv8SgHN2?=
 =?us-ascii?Q?L+X/alyoUgrVM8PZzfZWpeAnd4q2IogKZYrlj/Wu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a89c326-333a-44f1-3487-08dd4f39537f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:19.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfcu5r8D6cH8itBVjMMlsnbe5ZuufVFHqL36mTYKT09T7hkYuRpl3AYqbmRUAhwIDFdXkLyT6zgnLcml4ZPU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

When the DMA mapping error occurs, it will attempt to free 'count + 1'
tx_swbd instead of 'count', so fix this off-by-one issue.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6a6fc819dfde..f7bc2fc33a76 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -372,13 +372,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 dma_err:
 	dev_err(tx_ring->dev, "DMA map error");
 
-	do {
+	while (count--) {
 		tx_swbd = &tx_ring->tx_swbd[i];
 		enetc_free_tx_frame(tx_ring, tx_swbd);
 		if (i == 0)
 			i = tx_ring->bd_count;
 		i--;
-	} while (count--);
+	};
 
 	return 0;
 }
-- 
2.34.1


