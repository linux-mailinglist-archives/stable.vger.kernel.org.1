Return-Path: <stable+bounces-249549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJJXDfE/DGqPbgUAu9opvQ
	(envelope-from <stable+bounces-249549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:48:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BBB57CC99
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9710F31212A3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982D35200B;
	Tue, 19 May 2026 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xS/ryIf2"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A6352033;
	Tue, 19 May 2026 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186979; cv=fail; b=UvU9Eri3yLRugOakXEvtNPhOjGd10/i1GbC2RcYYPdvl7LtjDwSI6gci00k8rnfS6AR+JQKS3e29egERNTqNc5YxA4gpIqfNieGLPsRMZWH9kAdbNB4AbUf1YZhdCk3WrEC+5qHDqU97sCVrAlQyw23jsXTdGAF7Vo/kgRnxdxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186979; c=relaxed/simple;
	bh=Mw6ct51/FBjFeRJsOv+cNNBU9PYrzmG+GVW/GKYtmQY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LOc+5ydIGCyObPhTdBgXdQvINm2oLqmHJk/bxR8xH5uS0X5Y5k556ReZHRmYPBrhOCXy77jsPW/zupG/FKOD5W1c/0lp9xYUJKC0UO4Pgaai2hp6AbN2+MuZfZIVmbHQQmI6TuCj0bh2cl8qXbNZ10ANnaGKw4XfMO5Nnp53gtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xS/ryIf2; arc=fail smtp.client-ip=52.101.83.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2mG5ecBwlb0pmDNtf7hFrUwmn/pPmAfIt0pA/lVBNi5e1aoBJ2EoRwK2k1qLiuJh6+gNixsu88lDQ4BWSDe/sgDHR3zvVjRqiInRPCA4rK5ByS18EWMuuzF7C+1mASK2wPLHCC/7VqyDx5yn3ufmN5tHufWn0Q0T+XG78PmwG7mCMi8pXmZETZ80fcHtuP/zQIPJl4vpy36UN7g6+2+muIA6SkinyR0mi3wrYqeaJ049WBb1twpF8xaEtZOcDmaVY+/2Vx5T5ZCqqbV0HtmnswsN2C99H0/srWlhOLD8Nc2MIKtzv+y7K1+mB5AHFqs1fhM429KOlCaxPQIfpiZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF9Q1PEQPHzIP5zIlZRB1mj7+T4VfHMs95W00a6V1ZM=;
 b=QVQOSOJaKL6KbxcGUP0hnl10U5fy/VseGxs8kEyyEUmG7/kbsIf/mwDz1fpsTlioCNz6uhRrS4AfVev7kOQljSYwLKGQg7E2miysg0dCr9OCASH8yUq+6SYlaDkhMnJ4AR/uYVoqhiQ246o+CASrVKUhsbEUOreL3+3T1lemNejrE0ENmO3oqJQrxpGiyvpEHltR0/StigwBEqA0Dd1bYXsNg3wZPhijkWE08wpCkOiT4byC48KqbC/c8hvembxLE9yeLlEoxOKMDdjL4TqAMI3Z+sUJcMyqQ2l1LzRbLUrntFqcONCXRQIUIbY5KLZAQpEoyDsTkDONUj0QoBozeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF9Q1PEQPHzIP5zIlZRB1mj7+T4VfHMs95W00a6V1ZM=;
 b=xS/ryIf28m92SI6+fZy0CNtaNdfv4MYAYdM//UIM7zwfIHYwLYIDs19jrmgBjHux8APzRslLRB/6tWJQc3MJbaVWEBqILY+Y5fSoH8vQKszXeb3ML33XDatO2JOD40n9deQLWpNfaH4cDqPkzrut4wiH4mc8dzoTGOZDbT9orXlKwgSRulpkfRF84iv0bThqz9CDJnpLcjUhtxTIeavorQWXFRBaNnFtvxS9XJJliOT+VVGswrnQ+Oje/ds+y8rAqOGcQzUMQuiaMqv/A3PWJtz8AVVX3bT1VZfief6IWHGDhNkcpdlQj8sY3d6yTC+9dpkQ88JuR3aMcPdfXksp8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:36:11 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 10:36:10 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com,
	haibo.chen@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] i2c: imx: mark I2C adapter when hardware is powered down
Date: Tue, 19 May 2026 18:38:15 +0800
Message-ID: <20260519103815.2793953-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::26) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9b5fec-de92-4f5a-037d-08deb592715b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|56012099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	xmXLCUdwtvZPOPfja9JFgxuItFepnAs+2IDXoKnG9kFdAaIez/h4TKXro6Ei/F7PL/ES5WnWFcyJTByg9CPhVytn0IF4YyVgUWwhsWe4aam532THxTfKm54BBF2lrto+5ZdNRiUiTFnRSHJoLIqlSB+wfgokoj4bCS1O48fJi7MFwpfpD7af3z8fz5G2GCO4xQS2xsk8NVHxZ5JJhYoSBmk3Iv4flgfweyyAymQG57iUkf05YKq03rPdxDSR83shdHSdeqa8nXxKV+pRd+bSBrSihdfSppwjus6/XYVP0aSQNJ6hrhV8cDF4uLJJSjkCcTuTUc7UJPdhnso8X8JTQsLikzGordcRBNuh2uLBXtEb7aobNjdX89nVN0Kv7wBHzNQOw8e4w0z9LpBjtd8ue+xyMHs+8Hi8GNhM+qH0EBkqNh9fmr76djP/EMQTDx6UMUnrxkoUWR2OA31LDa8golSz6YrpdjQrgz+UM+RNbcsQmaurFjJz486zWtLvPNlkUklpBvXZPOtrjrqXVZdboCc/FVJbHX6KHwOXzc+8Xlbr5lk4gcSqGfl91DU8q7Tu3zVhNxQjUk/ygwe4VlrQSjsRxeza0KhHxMzg0OE6scwX8yl2sk20amlaaWeQh9GjWPen2kCi5IIuypx9urUxjjQ/ZHqeSV8ufGElkDW/ujZy9I74Dc3wYAT+abci63HONBf6GPBp9t1DsZ18fWRDDtY5LKJoejlqAFBr+QPWkrWWwSlEfGff4gS0/u59ph5M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dGcSqyU953l4OFlcj0CWXWxD9Jv035450PalfgnC6/e4qiMdwsjOI0aAn92l?=
 =?us-ascii?Q?/7N79hcBhFMqGgIkjxTdclylNH5zk0ElBvksG8P1NfUTgiJ4uNmSffkF/CPy?=
 =?us-ascii?Q?YUh8khPwrL6CWHt7CSS8XbRbD3BlLtit+FxLiIDSVDlV28axHjLuZ9K29IoY?=
 =?us-ascii?Q?rjN1ELd3ho3FAxvRVUF6/iYeYtmhshLGg+KHwYwu0rUkM2g5068+1niKhXcE?=
 =?us-ascii?Q?yHRLqKjOi6SEMP4aI0kPVmfrwJ2sQ2UboVzWJ6pmsvPbxpnB2NPehkGzS19C?=
 =?us-ascii?Q?Om21EhGX7McrrD6eH6g2YmjcfSEqRAEXDMLDaE++5zc1MqzdZ11LPvQkAneN?=
 =?us-ascii?Q?8KGn3hrDwUpqO8tzbgnOaD0YzuqTfyqwWkChXshkmifdUeE+CiMhhyRoUpnd?=
 =?us-ascii?Q?ZSRXXDcCYmOs+r5pSQUrnSil/l6Fy8SHSJfBvVg8ezlYRjp+nYnng8rdgqix?=
 =?us-ascii?Q?RNpi31Rh449l2unRkW16lZMaB90XGxyN1uEIit7mq/IILsoely2KiDdO7F+J?=
 =?us-ascii?Q?d8bdhyDGEV33EVkDH8d4pqXGspN6fItJEMcb+7SR16lFY1KUfKa0AIrTpP9S?=
 =?us-ascii?Q?bdaJ80HbgRuU/JajuCVDQWoMnvn0OKxxFczTlBWbCvlWu6bOyivUn4U6xUDh?=
 =?us-ascii?Q?ufS0yaUz+drK+EG4gFrNK75TsU3yWANbS7IkJ4sR43OoLkuKdbOFrqnICVfF?=
 =?us-ascii?Q?9HQJzmLrK6aZVOFsh0aUSa3V62Drz0goRwMl6beIYjukWPcm+oTq1g1OM60E?=
 =?us-ascii?Q?RbOX4Lop5Lhb2Eo6Mdvfog7XGsn2VWvvWMztZnlcMMk75+mbjVJxqDlnDX/7?=
 =?us-ascii?Q?JWQf1t4Hg0n0/ww4K4VZQ7X0gI+L8o7NXky/rc+SXis9uyM/2rJxUk7ISEMC?=
 =?us-ascii?Q?8++QuFiFcVmVC0e9C4eFR2fLbAR12Wp75HVTPnwbO0yZn0gCAD7uT2kCfrRh?=
 =?us-ascii?Q?eGLuk59FVJyh9Qk69uPrsHuJL4V6DaB7XnZOs8OlSKAaWocV/RJ2rBySTEwt?=
 =?us-ascii?Q?83+grMC7q13a4/SjmEYv7O6zZjurrEjkGxqsDygm2ZCAB0PW+1R8GtPtSXyd?=
 =?us-ascii?Q?XZkF82Akl4EEWPXcCc+tYyZfWgBp8sAhlf2K6vd9j0iGfo4EAMlKnj6Xq04C?=
 =?us-ascii?Q?HSPl9GogPB+qnNfa/fE6G2zCjmq2DfgcL/HjS6UbtdLkRWsfUAac0c0WU4Pl?=
 =?us-ascii?Q?4mzihJcCwsTAxqyuv9x1SjldWwKGqS71f5IBJfKKcn3yyEdqdrsebFKqehKu?=
 =?us-ascii?Q?py5ix7vSrFLpHbquriNINEgThzmKWe76N4gWHyeJihrfKoexPbMsEb26+QM7?=
 =?us-ascii?Q?o1AoJEDb6YIl/NHTuuJufRzFBjk84UjN8ah29IOllO9cA3rH5H1RYDSXBlE1?=
 =?us-ascii?Q?QjCRsGn2Omz4wpVYKfY6EIN8GCjSeej1Qw9svxwmnIctrl6+M3crGdgIiwLp?=
 =?us-ascii?Q?0N4efOlBdNFZ0aTxx0i8WNCxB4eT1pH9T2ePpPdeoNicRtPrZSfUTBah3ikA?=
 =?us-ascii?Q?fwFtRCg20z48GF8lS626jo2DzOFYUsJjKVYoKNwSom4BijUPt9pyHbarYksS?=
 =?us-ascii?Q?LE6upN4yVwuGt9Hh9ueHJHuns2DA8huEOIMeHDEstqGJWcV1/YEIMXDfhOVW?=
 =?us-ascii?Q?UPC6HG1TGomHv4ZATsGFYHFj8g+1q5VoW0dJpuJrF5QlfwQ5x3xxIh6Su84Y?=
 =?us-ascii?Q?7vg/2HvXyiK4qe8haef/RkBfralmCT+o8bUK7r7GiV8NJESo7jVMoVgdgCk7?=
 =?us-ascii?Q?f3AUUEm/Tw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9b5fec-de92-4f5a-037d-08deb592715b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:36:10.9154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gmp8p5tBjpGi8LMQYB0oGQskf87Xb8Ip/EWfhS9EMtmGAuBY0jxHsD7muQ/QP8zvrBMsGTN/lCEnSF1qSySb+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249549-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: D4BBB57CC99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

Mark the I2C adapter as suspended during system suspend to block further
transfers, and resume it on system resume. This prevents potential hangs
when the hardware is powered down but clients still attempt I2C transfers.

Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a208fefd3c3b..3b19d4a424ca 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1913,6 +1913,34 @@ static int i2c_imx_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int __maybe_unused i2c_imx_suspend_noirq(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	i2c_mark_adapter_suspended(&i2c_imx->adapter);
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
@@ -1946,8 +1974,8 @@ static int i2c_imx_resume(struct device *dev)
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


