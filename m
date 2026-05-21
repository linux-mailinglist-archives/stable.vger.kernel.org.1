Return-Path: <stable+bounces-253461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GGLAkerDmr6AwYAu9opvQ
	(envelope-from <stable+bounces-253461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:50:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9F559FAC6
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 662C6309187A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 06:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01005395AC4;
	Thu, 21 May 2026 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oYAEjE3C"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A2395AD1;
	Thu, 21 May 2026 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346124; cv=fail; b=apQ2EPxtmgSd3XBB6Z3kuZQpZ4NrSpIXI84lMlfLV82qxRzsHZCPVVApH9b9IQGQYthuknYkLsh9lpG3d5zluP8kPtpkwO+1z39CI7WHHvXpKQ5oEtEhjaitxoWjVy5xjxmPym0vE/fKz/V+zxiNNTOlRG5EHkU5iub2k+8r8y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346124; c=relaxed/simple;
	bh=tuxERLoBmd1oj58GhWOGSDkfGWPQPMKbVAghmFtjCV4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XwuCBgIK25O4sbHPxalKX8MCDBntybrcU7mfzSFJhqbW5CRiUQghNguRqGfHW05P3/aVyX3b0zIOTb+FoGWEWbCdfsYaZbt1mI802VGuLS2lOlMkI7uk7i77Xd6ZN11qDQ2lNtmu+8J5qeI7ILW/vesZzESdoLkI8gcmxo0t1E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oYAEjE3C; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9S3sBXLjhKqqmdiQfvUjyiNCzOp5tTdFi1nrAV+oi0kzzpwms4QWTyWtqyj76EtofmLT6YrQ6HIcqLKRYyu0T4kzpw9JZxSceV4PjVn3Ec+iXN4IMyaqCSxUL0RydGrudoK7pVA3ddirg6IuC4H5REUZ9VMJ7XuJPc6a4k6djGPawgBpVzXbuab4azPekbK8GnCEnjdmJOeSY4NYwtiWQsvMHBToIYvIatlImvpU6FxtJxZDC6KwRkOpqF+bKLBllqFwfIphC47NkjRNNuEX37B99CL0FMrpK41hWiOygxnpzR9vgTRT05FK8RLI8OFkGD5bdt+UniLkgcYxa9WiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffkgPYo3RsV00oz9yH4dQclwKr0ZZMPev7A712WO24o=;
 b=CUnJiVqHEDr7FMxMBJYFSrV7ge18ynCYK91ReFif/9e7Q/kv+JY76tD6QuCh0z3xH15eNa9Mc3Yt1eJMHyoyOZhxqzulwymoxV3jI+igkNdZv/8T00h7OLpm8wgqbS6YtrTTcv8NK1iQB38Ndt4njQ3Il1fQ+YPjPMyeQxAUFtowlnzojQV/E747UPLARK8bcCYyBFLjqbgaTX6bnO80QHyVcjb7f2bwq7cofNIL22FVEgchzlwMZGEgcGtXlzfkvdtozMCqtjZcdH1NsSgQob8Q9JVCi6P+1ol8negdmA10ZkPZjAuRwWCMfCuOYE2UxsFsufLfwIgKQd0lRAvezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffkgPYo3RsV00oz9yH4dQclwKr0ZZMPev7A712WO24o=;
 b=oYAEjE3CCCRqoS7rLgRNcB72pPU/bgQLKpocnVmmauyAm81fJEGhY8klKOi16KzO9ROry+Hf4CYuYHrLOvfFZ8LYyQz6MtI6Sl6I13oKEgU5YnPoKUaCHDl94N6lrJzBdsjdqxc5+C0OZJT0zX24kCq4FaDvEzneGsPnnyodxPpe5jG7P8blYTXinqK4SXPuvo2a55MRBTLMYAN76JCqN+5upMLXijWcehtutp5Bb+Nl0VOVgze14kTXOQMEQbI8fzD8R6xFoOoxIheJkwZIEQpNTQhaMtIMINAZs23pOORUnDvXBiWiLoUx+LRSN9U56I/PlRe/BkSiadkNXtzsCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:48:38 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:48:38 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] i2c: imx: fix clock and pinctrl state inconsistency in runtime PM
Date: Thu, 21 May 2026 14:50:38 +0800
Message-ID: <20260521065038.2954998-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|DU2PR04MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: a320cd31-7f51-4867-b459-08deb704fc7a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|56012099003|18002099003|38350700014|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	pPxa+kIlDPHK2mrrJupkVFcrllooZ1EAsZuGpTTnxUZcRoiV57n48FOL2kLGptSquJpy9ggsEUeBa24qGR7o+irvBIpV+GUuAhN7sw7tVUUpfShMMKdXvQr5EPrqh23/poNgtVR5Pqjo3pehleWLFLUXK4zQOlQhzrsuT+AQRpfY9D8K/NhZve+6W/SvIGMuliFtbuOlw3yARhg2URqifK+OKfufLReTWmrPmajklGx3DYt/zKsWlEXHyIie4Xki/de7Cyry+ljegNfA/9fJcL+pWYnG1eSOAqd4LuIajYu+hJnsbbYtS8Q0f3BiceQwP2izWMZ+ekEXkAG3JufhCDSF4cN9jnezmhaM751beItqdB3LXi9C0zdILFuHwWzvNzLwPAL1TRjb+nEg2+MYaZEThGMVz0IP7hG/bH9XYdEuHWLidXwsiFemcv1rtqPhyVMrXne7vB+rytOvENxDGGXM3wK7MW8r9EJZ9aMkOLG1RjYOlQQCV+Oj+seDRlt06qdekRR9cz0JSex91mRYtW8hRxTE4ljVgbuCbEgb53QDIRbPOaCBIEIph8VFJQLZZ2nWFq3ewGTkRiyMBO8GtAlUN0SiqaTPuMsFwKekZx7EB3st1eIr1oXM/BWkW4qfOTp9/Lh5JYvhN4x9i8UlhO1F2MSFJHqxHStn9sixnwY2XhFzL7O17CIikczRzSLtyVPJVvWyXtyuy8ME+9vTBij9o0UIQx0fcOT18vhv073M/IfL+0rf+dR/v3m93NXu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(56012099003)(18002099003)(38350700014)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMqALD/nwjBxgisygEjfT4IFi3gefwtH8tnvPky4GBfpxSQvz0qWNGznxFqC?=
 =?us-ascii?Q?hKLcgXLbGjGZ90t0gVOSMVWsLtrx9B/ReEDcNEWWwNPe+qwgEMBlZOpjOc+K?=
 =?us-ascii?Q?e0ko6i0qzmvYpZDqCD5vlNCSkye8YLy8vszQ+EaDNSGrp00EFl290lS+1aBv?=
 =?us-ascii?Q?54PQ06dYqCl1VpppsegImCK7giMyiy3S85ifeD65Z5tU6TzCbOgq5Jfj7+I7?=
 =?us-ascii?Q?//yJmpIjTJUD3wwQOvtV1BoBJ2tzxoHP3JUsA653ldcfCzXlFWb6Fnybpogc?=
 =?us-ascii?Q?Um+BSLlrF9ivqQh3FBo0v1NXKQ5z6NcX1+FX4Cdp+sL6zQHKqasKcb2DQTXq?=
 =?us-ascii?Q?MLYVQRu66UL2/16zsfP6Q32eX8YpUrP+GyNu1662dXtpZ0O+Iavzl7peW4X9?=
 =?us-ascii?Q?tVYu5696CrJQk3FKocMsIL4De4FQp0V8hDH7UfZrR4a3usiQWsIUd4pL8RM/?=
 =?us-ascii?Q?gWWPGjyRrfA4ofQGLy6KtTtEnWyhtguquo1lxAXL6my8S/ViCt0diKsTVp/w?=
 =?us-ascii?Q?z8QUHuMOFEW6jbKBevuInvyMcP1+08v0MSeWv7K5ai8Z9xDZg52Xbv7V10sm?=
 =?us-ascii?Q?QLBKMO/RptgErF5Bmt2Wrpd78vseSPt1POJUy4u+8l5tS/anj4BfEzxWd1nk?=
 =?us-ascii?Q?a6qVyY7+JedsEbOZy1DHVANw/tnTTKMxmGbVj9FtleaKXPGO7AsCPjfxOzPs?=
 =?us-ascii?Q?UGKx8Uw29JKREcM/apd+jORDMROxlhTfzpaBypl5tjpzNP4ayRyN4ELsBoCO?=
 =?us-ascii?Q?Nr48X7yqF4rlMxW6GIWnTRnm2Jh1bS864wBPUT1h+1wqEx2loUCUZOyFe3l6?=
 =?us-ascii?Q?JunXKrlE6VNJ7/ZBfpXGrnsjQrFfHvH/GBsaxtdultLBobBKQBgtQOPW5bAD?=
 =?us-ascii?Q?mkeUvgHLhak9jX9oFnHjEUUWCpopiL+QUFojUOKOIJdQpFn0pfZdHfRVrAz+?=
 =?us-ascii?Q?sLgvph4OYNRUpm+ULwhjVyfHijjCWePKFBmr5Jt8r835X5VpYKmVjIpZdKz4?=
 =?us-ascii?Q?pI18fJ0K7nUZW6Vg2/spa3gOqLAq681XUQweBF9stZ0y8fkgtwhTMnogmy/T?=
 =?us-ascii?Q?YGk0IcOFsMoaRL9MsaK6t6iVqPOri29UV7YgpSbV7hdxYQXPBIIYHxhQTkqg?=
 =?us-ascii?Q?+8DR1jiqFGfD/4G1AzYx2rWrok64+4/E5+AprjFXQUEK1HcFqrtHPR3Ndykc?=
 =?us-ascii?Q?aqW9F0DhT3g7scBontrAbFjz4SYtW6mDWzQX1ftDLC5IMT2waKeyUZjT1Pwu?=
 =?us-ascii?Q?LtVw09E/2g47kZ1h8yoXIESs6v5fLz3VctaBiTpCXe7a31x61oO2GPCnrURD?=
 =?us-ascii?Q?56yGvGi3iCY4PGfJCkSo/7EE5sLlyfbK0+OGkIqyDe3Y6W056nXrEnBK/NUA?=
 =?us-ascii?Q?DO9qLceCDSDS6w8D4yFwI1L4ErKd+ze5xF1atCGqfDGx/+FPuyR7wuptsqoL?=
 =?us-ascii?Q?XnXwZpYvJz1NouUrR9+EYzCEwo7VC8iyw6Y6br9R5YqWmUNbVEJ72Hvr/Mxk?=
 =?us-ascii?Q?rl9iK8b86R0+jcrFnWa62nWW52Y8GP1tHiQ7uZtlj63zlKmB8kSnoom0ueTV?=
 =?us-ascii?Q?eUaV0NEnAW7TsCufO+TIFkaQcAqqIcs9CtBWoufXRp27U8f0EzdnRUkWjUsd?=
 =?us-ascii?Q?8ANKW+jZLLGddVQlZ8YQJL5WOpV4iBBaxatCS9CWWnbeib/36AHgXHLhUvKa?=
 =?us-ascii?Q?Lfz3sKkGKBe+8rtKHc0Zf+9fAbkZu8LbNN88RXjO1LipdsATQwSRbfz1k3Q9?=
 =?us-ascii?Q?DN06qskf3Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a320cd31-7f51-4867-b459-08deb704fc7a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:48:38.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koXeZK4SPCOcUx2I2O8V9d+bswRMlzyfUYxvxhKFhUlyrs0a0beYhXYhHILc9WPd8JgYF/KmiKifrWVVqXv4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-253461-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 7E9F559FAC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

In i2c_imx_runtime_suspend(), the clock is disabled before switching
the pinctrl state to sleep. If pinctrl_pm_select_sleep_state() fails,
the runtime suspend is aborted but the clock remains disabled, causing
a system crash when the hardware is subsequently accessed.

Fix this by switching the pinctrl state before disabling the clock so
that a pinctrl failure leaves the clock enabled and the hardware
accessible.

In i2c_imx_runtime_resume(), restore the pinctrl state back to sleep
if clk_enable() fails to keep the consistent.

Fixes: 576eba03c994 ("i2c: imx: switch different pinctrl state in different system power status")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Change for v2:
  - Fix commit log to "keep the consistent" according to Frank's
    suggestion.
---
 drivers/i2c/busses/i2c-imx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a208fefd3c3b..28313d0fad37 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1892,9 +1892,15 @@ static void i2c_imx_remove(struct platform_device *pdev)
 static int i2c_imx_runtime_suspend(struct device *dev)
 {
 	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret)
+		return ret;
 
 	clk_disable(i2c_imx->clk);
-	return pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
 }
 
 static int i2c_imx_runtime_resume(struct device *dev)
@@ -1907,10 +1913,13 @@ static int i2c_imx_runtime_resume(struct device *dev)
 		return ret;
 
 	ret = clk_enable(i2c_imx->clk);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "can't enable I2C clock, ret=%d\n", ret);
+		pinctrl_pm_select_sleep_state(dev);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int i2c_imx_suspend(struct device *dev)
-- 
2.43.0


