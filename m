Return-Path: <stable+bounces-20280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5500856705
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597F1281BE7
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB3132C01;
	Thu, 15 Feb 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="Em2vo3zC"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2131.outbound.protection.outlook.com [40.107.8.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC681754B;
	Thu, 15 Feb 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010179; cv=fail; b=PdxAvFXNdTQAdkxpDIQd9XiGjCfMzyl0gf0y7qq8mMQNbNY9DFGZSCFdkK35rSjGe+6SlaRxzs8PPdS3RfslMOJtTTrQ8Tu3KiA7VkVEghIAv8Vh5QV+hEvT4Bypj0/cAEMWGRv68q+xXqaFUkvfxTnxMdDO+PkFu/KIJylYKsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010179; c=relaxed/simple;
	bh=UA/Jo8eqIOq5bpro3HGU6QcOrik6PJX/bPnMPP/k80E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJgcS4cj9Qe6hq4ez6c5QuGY2j/7s5e9fsvPUh36t9sj3Eu0PWcRQF7MCMFSbCvhIrbq/0sMXI3lQNXlHTflEJuOG/E8l3xhNM7SKTUaingBG5ng73Be0PlGBXPYipO1NUfY6vvHQx6qkUDnjXr+fNwjrDw0AGN8jUwRWHL52rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=Em2vo3zC; arc=fail smtp.client-ip=40.107.8.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCVFAbAWutgVN99t7AL+xyaVAzUdJD0ciEX51k4VbCgmgVpJpRia+rF4FkmXAc/IFRGPi91DyobPBwXUgNeba7FLRmn30bwl2Z7RY2fbyLfK4v+BUfeVIOmbylXAG7KmBLl+O7wOYnD755B/l8w8jQfqoZZjKfkkEaWOA03oG9qTTPSSvqhv8mnbM4XiykUL/Ac4Si0k4r635qPPFvtJsjD5zAxjhWspX4RYfL1bX3X8AC0PRtkJTKQnU1rCYIYZw4KoO/lXSnyM0pw5jE1By+fSgbzO0l+C7pP0fQolkBxuG3J4dk++h9Jc3ch/qEYW7lOqxyey2hfbkJPZ3VC9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jLZq8jz0DWJEcyr3ovhepEpw9+xJcdDaG6fRrA1Zjc=;
 b=WIsNkLfWsMEwGvJ4QmrXN0fRXlxNfkSEIVLHrou53+ceFgX0gDRpCZn5ZxU+tS//rczG6+zWOAmuhdwDgGcSmrdWO+PJqjKrjdpXoCBAG1lRqL4rRUpw0KOAccFjtgIz3Fm6hWN0pTH+X097Db9fq3IvThy6OO8aB4+XXSE7E15yDYDd8JmojST32lXYyEoAzkHSh9Zm39IUbKIOz8KfXMk1UZ57Rd1U1Fo402xgrTdtVTnX23EPbrs++98VQ0K9cy6mGTeNTUVA89UsHEhM6BISpoCRbCWJmoRn+GIIscvC2LDr2Rs5a75e0YfGj3KxBA75tATzdc2o/g9Do8oRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jLZq8jz0DWJEcyr3ovhepEpw9+xJcdDaG6fRrA1Zjc=;
 b=Em2vo3zC+BPgbpfEpYr4RhDb/mqaDW1YvaqLK6IddMrn769bqDR33SPx2NxVrAk9dQlrovTzp3705hPg4mY2zzygyOAlD9HOkVGB9gpCL79TiJBUOUyyA/mUbbNGYQLS93MaDKyZnHanKUnxMK3NK+koiBtXZp+BoY391vYGLsL831gE05HlKi0b6OIx8fII23koRD5+BCFp7z22henomNbUPxLRzPtRQ0FcqL7Yxbg/FzIAN2qo4k7vKet3AUlP6OjD7KqBTOCgNGYdJB3qZh3+ecgAiSiDoVNmQFHy2ga3zzJmlOZupNBr6EAsHG9RhW1QPS731vxkCEBw15N1xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB9P192MB1539.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:33b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 15:16:10 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::9a43:c1dc:91c3:186c]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::9a43:c1dc:91c3:186c%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 15:16:10 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH stmmac 4.19 1/2] stmmac: no need to check return value of debugfs_create functions
Date: Thu, 15 Feb 2024 16:15:26 +0100
Message-Id: <20240215151527.6098-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215151527.6098-1-hsimeliere.opensource@witekio.com>
References: <20240215151527.6098-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0059.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::19) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB9P192MB1539:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8fb6d9-5cfc-4798-a7dc-08dc2e390a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Aa+PWXIEy3o4Sos16Jr5s9dvb9WfxWzsxafQr6onr5kbpzv34ej8VsedV/q/mRYnzpDrsQjVTRdGoBeESB92PHyrwNmHuIgLbZBBQ4vHQX7NEkD5so8Mf1Ut0sxFPjGrjp+vJKNXAn5XOgxH4Z9qLPZPio9npNCVblfWusDz6PywWFxBgR6erC5jkbM0jsEeRj56x9/HU/CDCNCghNl6bmexDtP9lHs3PGH2CXqipI+SXIwAwlNPWXFyVeXvb8tZZIcbhjgMNpEVq/olDK7dp8kf55ig+NMblLofeEhQP1fM0qsLmGVCvTX4SCyM0blFnZCPZbu+zr6ioYqnH1SlvLBUM1kfiIFHSRz34N+6pRMoAlHPKAu0ZsB0rtHbi1it0R8BB4R+1vJ5RpisJtQzakACQDKF5IApC6Y9YyBJKrtC1TguOisSD5iIrB4sgYxSCbpPvosDBKguFDSeY38GsICCvu+lvE9cWEuQRWc8M7erRyTNeDmQ9st5zP6tyBemXPhZwRAFSUAx1tdIETcYPOH0hJYAXY4IL7RYEVMlU/3NGsxVUVDlBtX1kS1eFpCcf34gnHjmBD7Oe/bel8YlkaqPXw7YFTDMSTAFgR27zouyeWhv5cSC4Ai4+sAtWzo8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39840400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6666004)(316002)(54906003)(2906002)(66946007)(66476007)(6512007)(6916009)(5660300002)(36756003)(66556008)(8676002)(4326008)(41300700001)(478600001)(26005)(52116002)(9686003)(2616005)(107886003)(6506007)(38350700005)(6486002)(1076003)(38100700002)(83380400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dulLoHs+IOW4dK2uuvoGLV01J2MIX/pnRgGjCtBMA8y0D0hQnTXvw2ybeY1U?=
 =?us-ascii?Q?V0uJs/SPTzM146nQE494ZwP/cgLlHIMxyF9YqtBSfFFHSqqSTMiW0KF4vbp+?=
 =?us-ascii?Q?a00nYF6f9FgVpTJWBAWpgIm5MNPe1ZG6+cVn4PeuwBfQ2ART3Z20zuSObcZn?=
 =?us-ascii?Q?fLT6aBh0QjC9J2C/RRwg7iO1ddE2aBjKIszf7wskUa+2ImNcKZhhmnEItOz5?=
 =?us-ascii?Q?IjVRCSiLa8rDlzYXGz041h/sTcfYzx05iM4vadGMiv4GgAU63V90/aI3gU89?=
 =?us-ascii?Q?5HhlqyATihkoA3LggjZK6PLzWgWxYC/N4ujsLOsDU95JjgVbbN8WQKs4xvNp?=
 =?us-ascii?Q?v20Xxblno1kN5m97hFEo98TqSkxLTfHJ15V2o0VUibO0sfNsCtseoosGjQH/?=
 =?us-ascii?Q?MYGLWlpqVH6MUCUyZ27lyRLDvMTDTuiOUe7rWVD5SQRyzCOPWpxCGSc3WjT8?=
 =?us-ascii?Q?TP65WihOpaVlTgTf2xoenFQK2VpFyzVlUr7TQsZcQFNFIbbDOuJilDRBVjFu?=
 =?us-ascii?Q?bpI/6+Q4+QFbd6U0IepMP13MB7UuxxRchcMX3iyNEe0anhJSF14c8LXbVRYV?=
 =?us-ascii?Q?YQlaFJJK5hkCXkfijSZeF/5yOlJDsXZuhVF45yWlfRlH7FTYw5jA4ph5pjyo?=
 =?us-ascii?Q?cqtocYHy0RxhOgTHsvbiF+XsFf+rbv+WuXIieLk5Z5sTXRa7jx8NSjPOW51x?=
 =?us-ascii?Q?V5Bb7S57QxCc78lu/lXalDCs+mq6m9h3sygavp7fpcHOSua/+Kxv01tMcq1+?=
 =?us-ascii?Q?CeVyaa0krGHxfaaZiD3AVl9Up6/iFighHlmqbCu70lyHmEKeR2dPKiqieuiz?=
 =?us-ascii?Q?+YbtNirowHZkzmd0V4niMWhSOT55EGhKJqDRc8aHDiH7Rj/yDpw3BJRb30o3?=
 =?us-ascii?Q?FnLSNDFgLbdXRhtXHpsajZmI0QSjM4Owe/wU5y4/Pm6lV+vQ1QRaiArRhvAb?=
 =?us-ascii?Q?dmkAT5G9nu0IRkNzRdo8eyTXDhO9ogx9ErjtYwcckuzf52/FgHiKgRDr9sRs?=
 =?us-ascii?Q?RMzk7fqQM1+s00x6YW9fQjveHTwtAcaFT1wODlHjVZMy5tOpVeMadzt0Fp89?=
 =?us-ascii?Q?rH5PwOcbJq/KyUxpmUNEclLpfEBJ/1QpPyKZ1yCxymDdPsdQcDZCWPGt+7CC?=
 =?us-ascii?Q?f+pgvsPLSM+p0ccHe9VNrUEIB55ViL4wIQXvqP34u2l0kWcBtRekY28pk6H6?=
 =?us-ascii?Q?raGQYdd/5HGG807IIgjFJo/c4lLuk68W7SRoP2qSWvU90FNvHlMiycRSnbBc?=
 =?us-ascii?Q?PNa0ONKvvwmP7pNuElfgpy3fwDMix/XCFCq8envQeMJTxoR9iQhmc6IYfFYh?=
 =?us-ascii?Q?UQkM2f2nxzmLU8Q4KTRlRyO7dqvWD/5FcOc0Tl1h/8tY7c2TcAor5yMAaQHy?=
 =?us-ascii?Q?SIDmVMXTLOxA8JlwJoJNKprAUZllC7HR+gyPV9dku7jZeQEyXFVttmoKewoH?=
 =?us-ascii?Q?V95ThtxHdDD8NDr4/+EB3qHYu6Ribi7bdumPn7Rtrl9Iivv5Q8JVbhVMtbB5?=
 =?us-ascii?Q?Eys3ixsNDfMaymk4RpI++IJqsB6Zbw0TIzcnkbTI0uGISVb8O+33TkWJuPqh?=
 =?us-ascii?Q?o80CCLPn0z27Ltf18lnqYnaFpWSPMthYFbP6+PH6ApF5X7sMa1efuJJ9bZWe?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8fb6d9-5cfc-4798-a7dc-08dc2e390a88
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:16:10.5318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVYbX5DkOKoVwGaSg9p7cbwVR+hbB9VcGokNVSY1b2HNN7j+Okg31YYZXHc7Avn88FI+/rZZLcvVofap8X5pFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1539

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 8d72ab119f42f25abb393093472ae0ca275088b6 ]

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Because we don't care about the individual files, we can remove the
stored dentry for the files, as they are not needed to be kept track of
at all.

Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 52 +++----------------
 2 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 63e1064b27a2..5ec268817ee4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -188,8 +188,6 @@ struct stmmac_priv {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbgfs_dir;
-	struct dentry *dbgfs_rings_status;
-	struct dentry *dbgfs_dma_cap;
 #endif
 
 	unsigned long state;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3e35cdf0d2b7..6ee9c447ac43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -115,7 +115,7 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
 
 #ifdef CONFIG_DEBUG_FS
 static const struct net_device_ops stmmac_netdev_ops;
-static int stmmac_init_fs(struct net_device *dev);
+static void stmmac_init_fs(struct net_device *dev);
 static void stmmac_exit_fs(struct net_device *dev);
 #endif
 
@@ -4063,47 +4063,22 @@ static struct notifier_block stmmac_notifier = {
 	.notifier_call = stmmac_device_event,
 };
 
-static int stmmac_init_fs(struct net_device *dev)
+static void stmmac_init_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
 	/* Create per netdev entries */
 	priv->dbgfs_dir = debugfs_create_dir(dev->name, stmmac_fs_dir);
 
-	if (!priv->dbgfs_dir || IS_ERR(priv->dbgfs_dir)) {
-		netdev_err(priv->dev, "ERROR failed to create debugfs directory\n");
-
-		return -ENOMEM;
-	}
-
 	/* Entry to report DMA RX/TX rings */
-	priv->dbgfs_rings_status =
-		debugfs_create_file("descriptors_status", 0444,
-				    priv->dbgfs_dir, dev,
-				    &stmmac_rings_status_fops);
-
-	if (!priv->dbgfs_rings_status || IS_ERR(priv->dbgfs_rings_status)) {
-		netdev_err(priv->dev, "ERROR creating stmmac ring debugfs file\n");
-		debugfs_remove_recursive(priv->dbgfs_dir);
-
-		return -ENOMEM;
-	}
+	debugfs_create_file("descriptors_status", 0444, priv->dbgfs_dir, dev,
+			    &stmmac_rings_status_fops);
 
 	/* Entry to report the DMA HW features */
-	priv->dbgfs_dma_cap = debugfs_create_file("dma_cap", 0444,
-						  priv->dbgfs_dir,
-						  dev, &stmmac_dma_cap_fops);
-
-	if (!priv->dbgfs_dma_cap || IS_ERR(priv->dbgfs_dma_cap)) {
-		netdev_err(priv->dev, "ERROR creating stmmac MMC debugfs file\n");
-		debugfs_remove_recursive(priv->dbgfs_dir);
-
-		return -ENOMEM;
-	}
+	debugfs_create_file("dma_cap", 0444, priv->dbgfs_dir, dev,
+			    &stmmac_dma_cap_fops);
 
 	register_netdevice_notifier(&stmmac_notifier);
-
-	return 0;
 }
 
 static void stmmac_exit_fs(struct net_device *dev)
@@ -4442,10 +4417,7 @@ int stmmac_dvr_probe(struct device *device,
 	}
 
 #ifdef CONFIG_DEBUG_FS
-	ret = stmmac_init_fs(ndev);
-	if (ret < 0)
-		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
-			    __func__);
+	stmmac_init_fs(ndev);
 #endif
 
 	return ret;
@@ -4705,16 +4677,8 @@ static int __init stmmac_init(void)
 {
 #ifdef CONFIG_DEBUG_FS
 	/* Create debugfs main directory if it doesn't exist yet */
-	if (!stmmac_fs_dir) {
+	if (!stmmac_fs_dir)
 		stmmac_fs_dir = debugfs_create_dir(STMMAC_RESOURCE_NAME, NULL);
-
-		if (!stmmac_fs_dir || IS_ERR(stmmac_fs_dir)) {
-			pr_err("ERROR %s, debugfs create directory failed\n",
-			       STMMAC_RESOURCE_NAME);
-
-			return -ENOMEM;
-		}
-	}
 #endif
 
 	return 0;
-- 
2.25.1


