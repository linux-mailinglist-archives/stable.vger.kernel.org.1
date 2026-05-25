Return-Path: <stable+bounces-254091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGgoN97qE2rnHQcAu9opvQ
	(envelope-from <stable+bounces-254091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:23:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8C5C65A4
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBA37302D1B1
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811339B497;
	Mon, 25 May 2026 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WFKOY4BI"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E139DBD4;
	Mon, 25 May 2026 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690126; cv=fail; b=oibw8Tlc2o0wusxo0/+aZlQg3BPQeFhDqlPOMFYeLpCQXG4WRr8utA3mcLkQjhPyhM4JUrXyN4MnrKS5W+DOD90E6HEzkLKChudHydmwfuW3E/zpdzQOgqs2fgkkndS2sv6Sv7iVgkuokZqK1I8LoTEb1ZYoGehFM9OyOsv6Xhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690126; c=relaxed/simple;
	bh=D8lrZFTgUjOokNBKoHKFNFXHCJBG8HuU03uPPRwbkdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhhEWFbkmNljsd5/OqWKdVKObo67Bw3VzV/caJIT+Xk6Jo5FJ3hVpPLWBntYHFRYNDak3TezDXXR/Hx3vGOvx/n8uvNWLJ6FCdVKB0VuOLaTvOTrJXSnmMz/DHUjz2QvnvoRy3zI71supwEO5LgL9Cuku0cbEuWhKH/ywqAlsI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WFKOY4BI; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz5+IBEn8cgNrUWwILJZjT9Mdaw+/j9/cxIsN8mwTWu6Ln+SNoOGKFUzOFwbPoBBreSPeClx0EMVg+Wvsm53PML8G/8dt6RiAoXBZxMpONCm4xOs8PSjNwj9XPQZ5jRQvXldPv0oPHxOjxkPqLr1WnRDUFcM3+Bm2cCsLp/Am0LcEtwPNccUGImuqZ+pUa488phzj5NeG5pZkV9uTOcgwwuka4GnMhp1DYv8zRng86NEfQIMpGBFITqW8hjunkwBaHcBox/7v82Tjz4tLx/sFgVGOCDWVi/tyCaHrt6nEV5Bzm1AYQSmh1eFCTggQC0SUSjq42bixOTtjB4/DGdfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXcp5Sff+4hOK7zGUVJ8tnR3+KZH2MhMAPGIW7hWTiU=;
 b=J79+YZfFY5GnAH2vphjKz6e0PYy4T2IOVwV686qxFuyhZNANB0EoMbex4ohjP5BFchogyqhEbDoU4vM1axY0D7V9vEFcRfboToEmeUwAcO7WindYldicHO51q+htvic5qvZT8zRQA9YPKMG+VP+eQyz/lD0IU6vfCX7cRg2hzopymsV4clTuf+hN1dNT50Svt/zhDQrzXuRraaon1tp/DB6mgIzRdE/GtuqNipod3Cdqgqm+y3tc4EFJprXHCRbYPbkMgrVbB0ngXmckv8CCHj16S3L1GkCrT9398xqcR7tFv1+Fmjzc2d8ZZb47oBftudHCA3afRvk/amWEIyF9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXcp5Sff+4hOK7zGUVJ8tnR3+KZH2MhMAPGIW7hWTiU=;
 b=WFKOY4BI9DqcpQBZq0cwZ/oO0yC0ntakKwyy95ipyqC4Ut0jDFkouLgzCp87DZgDoTt5oo5+2b+uk1CKMMutjvMSBUzM24G3ZCsITtsdnzV8YwkO4oW8XXKeo5ysQNr78SeseNfaQznNgk2DBvKKM4VKMsIY9uB3lZYAzIJqL5qWziYOITa9XhSvk8nuBWQKZSpIHXBMl3IOx1XwwKZnWCCePAb1pcj2Fvf3yOd+6AmmRnnBIfRpJwhgfy+ytkhniBsKdwz5n/jd6Ie79guGdpcXM1VoGUr4CcFH95Cw+D32O97IvWuxJbSizSch1/vi9B4d6lZa79xbm6QjW8DW1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AM0PR04MB11930.eurprd04.prod.outlook.com (2603:10a6:20b:700::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:22:02 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:22:02 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	xiaoning.wang@nxp.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] spi: fsl-lpspi: terminate the RX channel on TX prepare failure path
Date: Mon, 25 May 2026 14:23:57 +0800
Message-ID: <20260525062357.3191349-3-carlos.song@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4416484f-a8e6-4a8f-8a31-08deba25ef4d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|22082099003|18002099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info:
	EJCtYzLESKEMWNDL6NMecLKKY5tBE+WHjgSSLWgBMZcLi+XcizfKLYHEtSoTX9oUSS+YWGdWdxnA7mCdN79ruBnu6ow/7h1x5T9aLFixTszAxgGmDFvoA6kP785z67sPEz8Tzcxzxz3Qc8j26Az5kM9LQKq7vQB/1p5CdTuuF+NtC3koa4InZTWbhlFijyV8BbfRzgPJzDsDeZS+hnwlUt9UL3cZhn1GDclhhmOg4taOab6u+O9sEbYmTDtPgxd1qCw8AM4jcaa5qhRYxl5pvN214Nm8d+foZKysXBopiB0uvxCRk0+dWWfxI1eKImLKWhSeXgTMZwTpRUjJn4ZPcdFv4xGrjjqC/6GY2c0CECKfi3+YHseGjf78BRnpk6ItDgqvnWIXISUx7sXEC0Nr6/HDPTzvkgDvWDORTukv3miml0z4u8eNj4SGTEYQ8PnPq6k1fCn1GTVymH9BXdzBbV8egZVFYNBwquwYbKnVTHUNkP3ifjYvHej6xhoJePFBSTDfQ7s9CboSR9MfZLFnzk91AvyozKp3dfl/li2nvbAbSnpDiWGGV7+4P0L46rBfpFhrv/4FLhgWnYIpKadnqitku0S07DIx9vecrcF42u7EKlx8T5SKBGKHRbKGKd9ESGow3B/Gl5asNCJnbZK5JYeFEmmU1aR4CeaAM5ENb8LfJS/z+a9FExYiSfHzc6GzwaxcaO1M3NBJRGRA0wae2AmjywVVwHAyFlt6ytCjcGUOtJmCoyXcS0d4FnxMLJgX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(22082099003)(18002099003)(56012099003)(38350700014)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eYxwkmdIESF4b2UCyXCVJn162OhU0KbrIXaAzz2/40gIPN+4vfyw+9WQc0mh?=
 =?us-ascii?Q?sQe5UytaGMjCxgAj7X86Hd4Q5cHLMg9GWbjV3kkUVlfCHeE8SJgYaPtG+sPl?=
 =?us-ascii?Q?28kF2ztqzR2fu4k+4f5IQsorIqTZcfptfpFirhgnl1euosp+Ai37qxb+Qb9T?=
 =?us-ascii?Q?loxnAyrg3yErW3fuE5febxk327qotw4xYWOzptlIkUzEj5LmCbnBA4SUK2P0?=
 =?us-ascii?Q?56+qJO+01TeA5uUsTo7M6H/8R7SmIu67PXpP4xdGGho7TfFv15Owu8xeHRb4?=
 =?us-ascii?Q?+/vdY00PNKaX1DZWOoHMuBQmddif6wmb0hFalcFXeZqKKATClx3J7PEGDTFV?=
 =?us-ascii?Q?6Oi0lS6i+2BZWi1bX8Q40FxnZ+KuzCW9CSCZtq/Tg1y4Ykgw3sSolMrbPb4j?=
 =?us-ascii?Q?5Uj4CLjOnMp0MZ0VYt34JMsoOnBN0zyDeLbppsYBaPsUc77WsyqBl/LoeQTQ?=
 =?us-ascii?Q?G+gRW2txpotp2am17KkZg9ONrEhv4wjlswO7Vb3YqNArxF9mHn34N5KOqPv5?=
 =?us-ascii?Q?y1qG0ba4WhcOOH+RotAIpfLyPm4K2UcOmph5UbAEe36bFqrl+odz+3qA+U2s?=
 =?us-ascii?Q?dxU/DvPv51rZcURdXUZjJXeAz/FdUfvuNxz+U3i7fcrr7Fe7K1o8MqXkMeNg?=
 =?us-ascii?Q?e75Lw8QJm6d5aATmGL9QUVMp5+opb/xixcPof+Mbs8fESNK491l7d5i1ydWV?=
 =?us-ascii?Q?wNp87PTu/pdL6E4OKI4N2QjbjNH3OAprBm5DkT5/7nKE0xjRnU/IY3sjtfc4?=
 =?us-ascii?Q?lEolZkrse8mmj5YATeTUDCR4ltjT4bixKpLli1M1UXi0p682RBOk/N52jw8J?=
 =?us-ascii?Q?A2ZV+ba/SqfYhAeMVAYOY9asOQJJIv3oxGwa6cRx/EDS2Ulgiwq+mw3bnGhY?=
 =?us-ascii?Q?MRbJSsXbu6MT/lztFd9Rx3svgW0I31HPDIGAMnYK24IkvJZtD+MR4vOZlstO?=
 =?us-ascii?Q?gk/DTs2WnUb60DLDqMebEFUEv/BwuVD/ASjnot/TujJWoPbjBiMht9pqAB4q?=
 =?us-ascii?Q?Z231PT7d2OoMb+pz0+XOIAU4QloGXMG/jD3tBHB9z+STxgyws93g1AHZ3TYv?=
 =?us-ascii?Q?Rvepz2mRWgBQ3Ehn/x4pHpaigw1CdJjor1OEKI2xrLZ/XoTFHyoSDCZA2Sfj?=
 =?us-ascii?Q?GFK7/mfXnPxVsTzajD6dO9EkPhIaz7RP2/TDStpJvlnJshtmaaNDoXlHdTWX?=
 =?us-ascii?Q?WvCUyhJ3EdFsapPdRk8qR3jblofI41qPNWAqY5qjbKYd6DijEDCffMKaePqa?=
 =?us-ascii?Q?wLybRuPWapPRfV51+iO8dz9TM6iu9aOPw4yO/ggkbcyy10Pk4Tg0CRSOk918?=
 =?us-ascii?Q?h8AevKHSUszyfdHm6+DpfkWOAxGPXe6xw2krvl89UjyfVyYZ+UL8jWpU1zSZ?=
 =?us-ascii?Q?Xc1qsNHLIPPgwC24Bi9N+H0eM5FQFP4vSm6C31I0A05kmKEWljC77vK4SSCc?=
 =?us-ascii?Q?6V/6q67TlhsLi/KWw5iojjKZIHQ0M3CUGIpTMHLEGmYfW2p/QG1mSqKqccik?=
 =?us-ascii?Q?DZAEsSsaGwI1CYZip0XBvmccHdm7kXddY+SkVq7q66WHt//EUj9RdZOHOy3L?=
 =?us-ascii?Q?7o7fp4eZ2UmEZBaBwueiCytx/FS5P7bnihVoc1OBNi7PWGpur59F3Ok/6gCA?=
 =?us-ascii?Q?8mirYrngGP9HfqtpLLFYreH2VCDyVtsnW5DI3V7LgyUWK3rL8RIAN1Yhmoar?=
 =?us-ascii?Q?yadTd1WkM8perExk1Uk31QaeyZu5qdwPymWx7lTyY9ymnCpQCSYiD4CBxP95?=
 =?us-ascii?Q?WwySAiNDrA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4416484f-a8e6-4a8f-8a31-08deba25ef4d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:22:02.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWIdJUTReoXG52AhDF7Ac1pm4F4DArHmCDemhBwdbTPL7FwtTlKBQM1fuWYzKixOcS66EpJ8zoAs9x/fPEBYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11930
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
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254091-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 92F8C5C65A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

When dmaengine_prep_slave_sg() fails for the TX channel, the error path
terminates the TX DMA channel but leaves the RX channel running. Since
the RX channel was already submitted and issued prior to preparing
the TX descriptor, returning -EINVAL causes the SPI core to unmap the
DMA buffers while the RX DMA engine continues writing to them, leading
to potential memory corruption or use-after-free.

Terminate the RX channel before returning on the TX prepare failure path.

Fixes: 09c04466ce7e ("spi: lpspi: add dma mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v3:
  - Keep dmaengine_terminate_sync for rx and remove
    dmaengine_terminate_sync for tx on tx prepare fail path.
  - Fix title and commit log.
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1a94a42fac31..e14753144e19 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -647,7 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
-		dmaengine_terminate_sync(controller->dma_tx);
+		dmaengine_terminate_sync(controller->dma_rx);
 		return -EINVAL;
 	}
 
-- 
2.43.0


